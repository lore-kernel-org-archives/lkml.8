Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5236FC11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 216A024656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582814646;
	bh=q9B2fCZrysqb+v5XGLZAltzC00DdcE0gKtCJ9/GgzYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b7iX7TMtijdYR+PMiI0ZRNFNvGmgHowcXbrE4OU2mJ96t+hNUjvYlOHo84D2MWPBu
	 5svhURaEPGwOS58dZaTIx70fqLjcfk7LL8D4G20NH5V2/z/4h/N+W7La38HGLwkoQE
	 76A7ij4EHD5qx1NI8+kBH/aJsoOTMslxtffj2F4s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731321AbgB0OoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:44:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:45428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730893AbgB0Nsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:48:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4037E21D7E;
        Thu, 27 Feb 2020 13:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811315;
        bh=q9B2fCZrysqb+v5XGLZAltzC00DdcE0gKtCJ9/GgzYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DDGsOIpZVrvMn87++eo1wcF/yTl+gBZxlvrMOeJ4qTcyX9+hJSkdl+R7onykWm/kz
         ZsSqAO3ARb4g2cIsmfBONqtmv2/rrqqGrUQlKOkH1mk9mbkD7uGFQ2NJzHxPowyyuq
         Z5Y4eFXjRT+C4EC0k6NZWJI/mUulAsg8ncmvYcxA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Tony Lindgren <tony@atomide.com>, Bin Liu <b-liu@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 083/165] usb: musb: omap2430: Get rid of musb .set_vbus for omap2430 glue
Date:   Thu, 27 Feb 2020 14:35:57 +0100
Message-Id: <20200227132243.442948410@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132230.840899170@linuxfoundation.org>
References: <20200227132230.840899170@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 91b6dec32e5c25fbdbb564d1e5af23764ec17ef1 ]

We currently have musb_set_vbus() called from two different paths. Mostly
it gets called from the USB PHY via omap_musb_set_mailbox(), but in some
cases it can get also called from musb_stage0_irq() rather via .set_vbus:

(musb_set_host [musb_hdrc])
(omap2430_musb_set_vbus [omap2430])
(musb_stage0_irq [musb_hdrc])
(musb_interrupt [musb_hdrc])
(omap2430_musb_interrupt [omap2430])

This is racy and will not work with introducing generic helper functions
for musb_set_host() and musb_set_peripheral(). We want to get rid of the
busy loops in favor of usleep_range().

Let's just get rid of .set_vbus for omap2430 glue layer and let the PHY
code handle VBUS with musb_set_vbus(). Note that in the follow-up patch
we can completely remove omap2430_musb_set_vbus(), but let's do it in a
separate patch as this change may actually turn out to be needed as a
fix.

Reported-by: Pavel Machek <pavel@ucw.cz>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Bin Liu <b-liu@ti.com>
Link: https://lore.kernel.org/r/20200115132547.364-5-b-liu@ti.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/musb/omap2430.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index e8be8e39ab8fb..457ad33f4caa8 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -388,8 +388,6 @@ static const struct musb_platform_ops omap2430_ops = {
 	.init		= omap2430_musb_init,
 	.exit		= omap2430_musb_exit,
 
-	.set_vbus	= omap2430_musb_set_vbus,
-
 	.enable		= omap2430_musb_enable,
 	.disable	= omap2430_musb_disable,
 
-- 
2.20.1



