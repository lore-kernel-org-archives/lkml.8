Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D02C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 05:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D1420739
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 05:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B7LWHfMU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387790AbgCLFJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 01:09:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34438 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387657AbgCLFJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 01:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=+MMAgr+LaCv2k1zN/x1GpYWsAedizhAP04NXBfBxfUY=; b=B7LWHfMUHPAGMMsGfLqDIcUNuI
        3Z4ac/7WW9mh4+oqhrh3y8VU63GOCqQQREFLvrk2llb57hhtfy44NTZByM81DLCQQZ+Rwsc2irHJ+
        IMX3Qvi94MthI5LK9e+bFy1BKAtrmb+glJKcMGvS104O+/y3UuPnTiQjiHyNYt2aZrH8TzbG3Ej1p
        Q+btsJ1AMTXyo8/+aQw1hMpvSdWv52we4Z7eMAUxcuyKl/lWJUpM8n178LrPvuLWoLdlIj+X/noZh
        CfqpVerFUBvJ6qA09nyj2tJOnd2KPoR8L2OGq6gCnTxMO3ur0LrLhJbb/UCnxqqkBItCEzxbZI/yj
        hADu4shg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCG69-0007E9-MO; Thu, 12 Mar 2020 05:09:33 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Cc:     Marek Vasut <marex@denx.de>, Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Andrew Morton <akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] drm: mxsfb: fix Kconfig menu presentation
Message-ID: <a57392eb-da12-f760-7124-ba39fdd8775b@infradead.org>
Date:   Wed, 11 Mar 2020 22:09:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Make DRM_MXS depend on DRM. This causes the MXS FB menu to be
presented in the DRM menu where it should be instead of in the
Graphics support menu.

Fixes: 45d59d704080 ("drm: Add new driver for MXSFB controller")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Marek Vasut <marex@denx.de>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Stefan Agner <stefan@agner.ch>
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/mxsfb/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-a.orig/drivers/gpu/drm/mxsfb/Kconfig
+++ linux-next-b/drivers/gpu/drm/mxsfb/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config DRM_MXS
 	bool
+	depends on DRM
 	help
 	  Choose this option to select drivers for MXS FB devices
 

