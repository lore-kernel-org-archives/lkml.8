Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472EDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A35E20897
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589825209;
	bh=VbO+1Gp4ofR2slg/DwcBWnfYz0lhF7lK5Xs9pZ5dAEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uqUrvoSWxRE4bLdDkz6E42+c7xsOlLqB7Um5EDhK4AtIcHWWgD1nZfI5j8JpnEJvl
	 bSHpJAxGR5avlCMy41Unl+U6g0yXl82Ox/fHEolGQqNsnDYx50A/022RLndeaxkaOp
	 kaHoO8m3ITonBxVmxE6rygarynUed1Fx67Xc5xk8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732637AbgERSGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:06:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:55006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730517AbgERSGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:06:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8956220897;
        Mon, 18 May 2020 18:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589825202;
        bh=VbO+1Gp4ofR2slg/DwcBWnfYz0lhF7lK5Xs9pZ5dAEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d/oBptPrs0Hjvb6JilNW8aLbk9iqRdm1b+WrtROsfpB9Zma7q6IlJdF4aEYnCRcLK
         3BrtAkfQuLElVRx4aTpI0eyXKRKPXy5Ogywy14jVr0ur+Yc7zURvNNY8EB2QEo9s4R
         bCgX1mt14C8qK8d1nfLI1IyBa+7UFOFJQJOLIvvA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Naresh Kamboju <naresh.kamboju@linaro.org>,
        Tero Kristo <t-kristo@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 5.6 171/194] clk: ti: clkctrl: Fix Bad of_node_put within clkctrl_get_name
Date:   Mon, 18 May 2020 19:37:41 +0200
Message-Id: <20200518173545.962289841@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173531.455604187@linuxfoundation.org>
References: <20200518173531.455604187@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tero Kristo <t-kristo@ti.com>

commit e1f9e0d28ff025564dfdb1001a7839b4af5db2e2 upstream.

clkctrl_get_name incorrectly calls of_node_put when it is not really
doing of_node_get. This causes a boot time warning later on:

[    0.000000] OF: ERROR: Bad of_node_put() on /ocp/interconnect@4a000000/segmen
t@0/target-module@5000/cm_core_aon@0/ipu-cm@500/ipu1-clkctrl@20

Fix by dropping the of_node_put from the function.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Fixes: 6c3090520554 ("clk: ti: clkctrl: Fix hidden dependency to node name")
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Link: https://lkml.kernel.org/r/20200424124725.9895-1-t-kristo@ti.com
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/ti/clkctrl.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/clk/ti/clkctrl.c
+++ b/drivers/clk/ti/clkctrl.c
@@ -461,7 +461,6 @@ static char * __init clkctrl_get_name(st
 			return name;
 		}
 	}
-	of_node_put(np);
 
 	return NULL;
 }


