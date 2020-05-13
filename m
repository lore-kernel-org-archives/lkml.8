Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018C1CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE2BB23126
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589363184;
	bh=HokuufDRAM7oWalWhPRiWqAim20UNg+s0sNa4Ozzl/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z7Z1vl8p9JpD3xtsGkUKTypffrvGFeCh3tos9dxb3qHFFVeAbS+IcA+ekjMdjCcf7
	 4o668+loH1chucl093ExkEdV+zsr0F4i30FG6oQBF3k4w5Ct4tImnPlrwjUoz81Hss
	 GmHO1HgzRBvgynZOm8KhuAr/mnYZEQlHrgKXr6+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732625AbgEMJqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:46:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732608AbgEMJqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:46:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69C7720769;
        Wed, 13 May 2020 09:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589363178;
        bh=HokuufDRAM7oWalWhPRiWqAim20UNg+s0sNa4Ozzl/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PvGnNgTT8XTcPaNcYGc03HXhaiWsPJi6AjWXxk1fWySbSUPCLbYgKjbPt+y23sixl
         NYncQCJRTzTkTBkMTOAqQylsqugO4bpX6vKrWMDCmdCNojtjAADNVxf6aauJeMWtiR
         GiKDi6UGpNhyhYArXoHIOHFKMoJlWK7wVMnaDG1c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 04/48] dp83640: reverse arguments to list_add_tail
Date:   Wed, 13 May 2020 11:44:30 +0200
Message-Id: <20200513094352.744242697@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513094351.100352960@linuxfoundation.org>
References: <20200513094351.100352960@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julia Lawall <Julia.Lawall@inria.fr>

[ Upstream commit 865308373ed49c9fb05720d14cbf1315349b32a9 ]

In this code, it appears that phyter_clocks is a list head, based on
the previous list_for_each, and that clock->list is intended to be a
list element, given that it has just been initialized in
dp83640_clock_init.  Accordingly, switch the arguments to
list_add_tail, which takes the list head as the second argument.

Fixes: cb646e2b02b27 ("ptp: Added a clock driver for the National Semiconductor PHYTER.")
Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/dp83640.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/phy/dp83640.c
+++ b/drivers/net/phy/dp83640.c
@@ -1114,7 +1114,7 @@ static struct dp83640_clock *dp83640_clo
 		goto out;
 	}
 	dp83640_clock_init(clock, bus);
-	list_add_tail(&phyter_clocks, &clock->list);
+	list_add_tail(&clock->list, &phyter_clocks);
 out:
 	mutex_unlock(&phyter_clocks_lock);
 


