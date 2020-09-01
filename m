Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF78C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EEA52064B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598975338;
	bh=3lZBsXsVdxMW4GHyatjZAH/Pc9qyQnjphXDHDzPWI8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IsNbpoaqpsBYSc1HQiytXwSDcg+KnxLvK7cX+JBfocwUzUqS13wi17PKPYsOmkWdx
	 K/FU98wVeiKxsr800ZUtg2rfUGvuDidoObCngzWOLSJvu6LUAjioAQ51iLB4al5K1o
	 0ALebSWc2WTMX4XhMESrOz5UNtCJOkRMVpQPEatc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731582AbgIAPsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:48:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:33150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731554AbgIAPpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:45:08 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44B42206EB;
        Tue,  1 Sep 2020 15:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598975107;
        bh=3lZBsXsVdxMW4GHyatjZAH/Pc9qyQnjphXDHDzPWI8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EEp85slIt92kHbFAJZQTDGkSIie14e8ULaXzPv2yjJ5fRGjZRlw/JCqOnkR+MEiyA
         9BkOEv4mUc85PWcm1tRFf8CDImHkZV+UfPE6p+0MBuHBWVcb+0feBltZ6h3j+7VGuV
         /wEwFkF5fUr6PZnaoQQmmLh9DTKmdeJz1/blSaKE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH 5.8 211/255] drm/etnaviv: fix external abort seen on GC600 rev 0x19
Date:   Tue,  1 Sep 2020 17:11:07 +0200
Message-Id: <20200901151010.810734768@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901151000.800754757@linuxfoundation.org>
References: <20200901151000.800754757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Gmeiner <christian.gmeiner@gmail.com>

commit 2c5bf028ef34745e7b3fe768f9c9355ecc7df101 upstream.

It looks like that this GPU core triggers an abort when
reading VIVS_HI_CHIP_PRODUCT_ID and/or VIVS_HI_CHIP_ECO_ID.

I looked at different versions of Vivante's kernel driver and did
not found anything about this issue or what feature flag can be
used. So go the simplest route and do not read these two registers
on the affected GPU core.

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
Reported-by: Josua Mayer <josua.mayer@jm0.eu>
Fixes: 815e45bbd4d3 ("drm/etnaviv: determine product, customer and eco id")
Cc: stable@vger.kernel.org
Tested-by: Josua Mayer <josua.mayer@jm0.eu>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -337,9 +337,16 @@ static void etnaviv_hw_identify(struct e
 
 		gpu->identity.model = gpu_read(gpu, VIVS_HI_CHIP_MODEL);
 		gpu->identity.revision = gpu_read(gpu, VIVS_HI_CHIP_REV);
-		gpu->identity.product_id = gpu_read(gpu, VIVS_HI_CHIP_PRODUCT_ID);
 		gpu->identity.customer_id = gpu_read(gpu, VIVS_HI_CHIP_CUSTOMER_ID);
-		gpu->identity.eco_id = gpu_read(gpu, VIVS_HI_CHIP_ECO_ID);
+
+		/*
+		 * Reading these two registers on GC600 rev 0x19 result in a
+		 * unhandled fault: external abort on non-linefetch
+		 */
+		if (!etnaviv_is_model_rev(gpu, GC600, 0x19)) {
+			gpu->identity.product_id = gpu_read(gpu, VIVS_HI_CHIP_PRODUCT_ID);
+			gpu->identity.eco_id = gpu_read(gpu, VIVS_HI_CHIP_ECO_ID);
+		}
 
 		/*
 		 * !!!! HACK ALERT !!!!


