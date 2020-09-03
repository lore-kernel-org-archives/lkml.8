Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2CDC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6418D2098B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="LA/7fzSG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mlp+FK0V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbgICIMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:12:31 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:47753 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728338AbgICICO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:02:14 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 5C7A5C02;
        Thu,  3 Sep 2020 04:02:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 04:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=tbdfL9NcjyVQC
        Pzt3lMBWUV5KAA8n13YgBSTiiVmjF8=; b=LA/7fzSGs8xD6O2w1ZfRC3AvE3HcV
        TUdOO+VYs3bo4lBFlh2TLgEuFVijj1RQSd9CCqaBy+Hw7EQaf9zIHAXXDs6TyhRT
        V6pNBSiTtRuZyho8phWrsAMB3CWq+UN+0CnW3sgzs5hq4gIKrpPvhc7SsVuXLH26
        nLJs/72nDaIIb/KgAqDchzFgfrRuJ2iBlouPdQohPwsvgWanvWrzhD0PO0KBn8lk
        rry5a67JHLsqOIPMvavma2Sld1TA+WjC60cuYV280oH2bADlM8SrlsufYVg4btco
        HjcFtuAlqFMFKfbj0Oow6qPxXG2oQshuYDcn/n73MxaJkA6ln9pQm0nxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=tbdfL9NcjyVQCPzt3lMBWUV5KAA8n13YgBSTiiVmjF8=; b=Mlp+FK0V
        IMcn74sINPQrsKkb0miDQ7e5bku51H5Zifq/t7QB6yKwYS2enfqXDQGEQlhoWAsy
        l+Zlnfxv5lxYH4QumuZapUd1LDx5+TDOHzH9xM7FCVIxPwZsq6re6SAhmTMrWZU4
        vVUcp8ldPobeW0CilhS2Fx+AH/8/4zJ5bxL55KJjR6dky1j7/QNrmGcO/VFTi+QO
        dHELPdaShm1PAGBKLwkj/ny2GHXBwLZM+VQeaNJqNY1r7BptkHxQMD+qholxK35/
        CpxZ0xxD3vXkUFpUvKhNfV8ktnIRxFPR60OAyaouQBCWh+DKdIdP0RPgtICIeoXo
        9NepO3+hh7YnhQ==
X-ME-Sender: <xms:_aJQX1vDJ27HEQNfClToHShZiPDzXE8gXLgW2_RtGYBlT9vL2K06cA>
    <xme:_aJQX-cLTOplxYKjzhS4RR1bE54Wg7gPVWC5DYXDJV3UY_BPVXgMSNOvRUAdTckai
    uPra_edjBDtMq7Ji-M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegtddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpeeine
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:_aJQX4zzZlfRLjfK-qjjhLlBqzmy7cHcuyyxKfpQ946hzkIXvoChfg>
    <xmx:_aJQX8PmmOcQ0jd3xHUXdiS7YWgpgx-fOb9JliLnFGn8LlCTrnPSyQ>
    <xmx:_aJQX183dQ147yUdp8e62Kv2IBNLAoYMu97pbcO_lbskt628iVb6uA>
    <xmx:_qJQX8WXshJbCTIxGwrxRH8r26XG5D_Ete9h4l-j2igb8n1O_vfOJUECgs0>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 93F26328005A;
        Thu,  3 Sep 2020 04:02:05 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH v5 08/80] drm/vc4: crtc: Use a shared interrupt
Date:   Thu,  3 Sep 2020 10:00:40 +0200
Message-Id: <5a915d374357f41083ac71779fa9b2c35a339c2f.1599120059.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some pixelvalves in vc5 use the same interrupt line so let's register our
interrupt handler as a shared one.

Reviewed-by: Eric Anholt <eric@anholt.net>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index e55b2208b4b7..9faae22cb0f8 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -919,7 +919,9 @@ static int vc4_crtc_bind(struct device *dev, struct device *master, void *data)
 	CRTC_WRITE(PV_INTEN, 0);
 	CRTC_WRITE(PV_INTSTAT, PV_INT_VFP_START);
 	ret = devm_request_irq(dev, platform_get_irq(pdev, 0),
-			       vc4_crtc_irq_handler, 0, "vc4 crtc", vc4_crtc);
+			       vc4_crtc_irq_handler,
+			       IRQF_SHARED,
+			       "vc4 crtc", vc4_crtc);
 	if (ret)
 		goto err_destroy_planes;
 
-- 
git-series 0.9.1
