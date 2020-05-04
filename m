Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B043C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6013A2073B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588615630;
	bh=fLIVL3sjse+37SzZ0JN8pjVguV51V/e7QehVdNR5FHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bvc9lKo6zvGswJ+TVimSlVOxY1Bf2oebGAYLYTLEhBNcbozK6OpAfgEZCTPadKxfV
	 DKX+aOgq4oTKEtCC6BUo597TEsB2D9cMcy0sOsQZj7Tnm17dlrjd+Eim2Y3EJRgP6T
	 Tz/d/9ofR1SfeB1WgBXJj9zkdxKdc8Uka+hkopIo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732087AbgEDSHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:07:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732069AbgEDSHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:07:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02EB520721;
        Mon,  4 May 2020 18:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588615625;
        bh=fLIVL3sjse+37SzZ0JN8pjVguV51V/e7QehVdNR5FHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NqAZCIXSpqrlfa2VKwh346yokR0Do1KovWfB+RdlzqdusMqd4IR9AuH9XcASqBOZi
         AlgK3MOKzgb/vZqLey478JZ5+PzC2fmL3YeTEuknQKj6X7JD7i/5/u1J0zyF33eyX/
         MsiJN6TOmGoNcTIVOS7yXwhS+HPgPG1pFPi0c5BY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 5.6 57/73] dmaengine: ti: k3-psil: fix deadlock on error path
Date:   Mon,  4 May 2020 19:58:00 +0200
Message-Id: <20200504165509.601260333@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504165501.781878940@linuxfoundation.org>
References: <20200504165501.781878940@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

commit 172d59ecd61b89f535ad99a7e531c0f111453b9a upstream.

The mutex_unlock() is missed on error path of psil_get_ep_config()
which causes deadlock, so add missed mutex_unlock().

Fixes: 8c6bb62f6b4a ("dmaengine: ti: k3 PSI-L remote endpoint configuration")
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Link: https://lore.kernel.org/r/20200408185501.30776-1-grygorii.strashko@ti.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma/ti/k3-psil.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/dma/ti/k3-psil.c
+++ b/drivers/dma/ti/k3-psil.c
@@ -27,6 +27,7 @@ struct psil_endpoint_config *psil_get_ep
 			soc_ep_map = &j721e_ep_map;
 		} else {
 			pr_err("PSIL: No compatible machine found for map\n");
+			mutex_unlock(&ep_map_mutex);
 			return ERR_PTR(-ENOTSUPP);
 		}
 		pr_debug("%s: Using map for %s\n", __func__, soc_ep_map->name);


