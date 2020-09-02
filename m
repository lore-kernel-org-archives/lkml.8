Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CFEC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B542E208B3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWrjEeNY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbgIBPrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbgIBPrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:47:07 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79540C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 08:47:06 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t10so4923077wrv.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 08:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9H7/mF6ZryP92cYZg0TAhb3a8scGXiZh0eOQGOZfLVY=;
        b=EWrjEeNYJHzpFyynRv1Tm36aYF5UDXud2Bzh/c1N/PCCgF3DRzgeHshxPGu+2ui6Zp
         pzZzccyDBYjqSzS+kjbbHDm2/osM2b9qg9vxfCAGk4WGU4NuBoI65yajrriCk5naVRSt
         l24inn9h11hreISFMmkgPUtrldM7v8NyZPsdWKYHGCvJuMIasLwos6u5TvDHgu1rKROx
         j6GUj7uyMoBdVcvJFn4QS55FAtFBC+qOVc/QG9MMhouCPIabQ+9hbCHCEKwtFqmmceWl
         +BgebIXIcsRoMRzq89VauVrHFo2u+wsS9vpU5Nkn/8jrsoePM4r/OZAojtwGNZhWbLrl
         mT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9H7/mF6ZryP92cYZg0TAhb3a8scGXiZh0eOQGOZfLVY=;
        b=fihAtTObqd9mPGwfBrZcftPMdrMHREwfAvWuABrXMpteORe99dEAu40BqS5OFKO75W
         1GWHFc4C75HR+qt0gcQB8qRcnE9U/EIFcZKw4feqF6vFaJhCmkfBc50sQDINL+ftaMa6
         MNHYiy6TXRJTDOH93MyFi1+94K5rEeRAJuk70p+htwk6G5l/LutsD6KZkROXdQFhhmBP
         CqLUJR9jZWB9FxpD/FCknU+lpWgRWASulB77eQFArLXu76Ev0Fdg62FcIKgAflUkUbgV
         Z4uoYZVKIuMZ30I4b2Fvbda75sd9ZnEg4mrqk4pohFSCasW+kpzmgHvh4gi/EG5Cl/+c
         YxTQ==
X-Gm-Message-State: AOAM5314+7GuoXkyncANix3fH9uChoGKBLt2cMg2mQPHdmwc0qLBZLnx
        G9ZTYuhJRifNVkJ4vPQuuMA=
X-Google-Smtp-Source: ABdhPJyzJK7Qdfa4BBx3/Wpjhp0NtuTOCeKSPzQYT4+st3PI6LlQymsTvuTjEnv5IAqB/Qa9VKY+SQ==
X-Received: by 2002:a5d:444b:: with SMTP id x11mr7733827wrr.402.1599061625113;
        Wed, 02 Sep 2020 08:47:05 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id b76sm44507wme.45.2020.09.02.08.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 08:47:04 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
Cc:     lkp@intel.com, Alex Dewar <alex.dewar90@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Javier F. Arias" <jarias.linux@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>,
        Saiyam Doshi <saiyamdoshi.in@gmail.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Magnus Damm <damm+renesas@opensource.se>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging/emxx_udc: Remove pointless variable assignments
Date:   Wed,  2 Sep 2020 16:46:24 +0100
Message-Id: <20200902154628.283453-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <202009021127.uodVMaSJ%lkp@intel.com>
References: <202009021127.uodVMaSJ%lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a number of places in emxx_udc.c, there are variables which are
assigned to without that value ever being used. Remove these pointless
assignments.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 33aa8d45a4fe ("staging: emxx_udc: Add Emma Mobile USB Gadget driver")
Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 drivers/staging/emxx_udc/emxx_udc.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
index d0725bc8b48a..4ceaf1ead123 100644
--- a/drivers/staging/emxx_udc/emxx_udc.c
+++ b/drivers/staging/emxx_udc/emxx_udc.c
@@ -793,7 +793,7 @@ static int _nbu2ss_out_dma(struct nbu2ss_udc *udc, struct nbu2ss_req *req,
 	u32		dmacnt;
 	u32		burst = 1;
 	u32		data;
-	int		result = -EINVAL;
+	int		result;
 	struct fc_regs __iomem *preg = udc->p_regs;
 
 	if (req->dma_flag)
@@ -1288,8 +1288,6 @@ static void _nbu2ss_set_endpoint_stall(struct nbu2ss_udc *udc,
 
 			_nbu2ss_bitset(&preg->EP_REGS[num].EP_CONTROL, data);
 		} else {
-			/* Clear STALL */
-			ep->stalled = false;
 			if (ep_adrs & USB_DIR_IN) {
 				_nbu2ss_bitclr(&preg->EP_REGS[num].EP_CONTROL
 						, EPN_ISTL);
@@ -1304,6 +1302,7 @@ static void _nbu2ss_set_endpoint_stall(struct nbu2ss_udc *udc,
 						, data);
 			}
 
+			/* Clear STALL */
 			ep->stalled = false;
 			if (ep->halted) {
 				ep->halted = false;
@@ -3073,8 +3072,8 @@ static int nbu2ss_drv_contest_init(struct platform_device *pdev,
  */
 static int nbu2ss_drv_probe(struct platform_device *pdev)
 {
-	int	status = -ENODEV;
-	struct nbu2ss_udc	*udc;
+	int status;
+	struct nbu2ss_udc *udc;
 	int irq;
 	void __iomem *mmio_base;
 
-- 
2.28.0

