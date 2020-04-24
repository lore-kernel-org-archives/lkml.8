Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3C8C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E2C02087E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="r//bO9qI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T6hbr9/f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgDXPgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:36:11 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:60849 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728450AbgDXPgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:36:09 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id C400D3E9;
        Fri, 24 Apr 2020 11:36:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 24 Apr 2020 11:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=ZDDHs6S1gq2LI
        nfVgmp0pHkW/VF7Q7iLnmFsdw8/KiU=; b=r//bO9qIgxdaJSKujrpIRc2odnZ23
        m0spgdGn3TSSH1yiyLwkbAUk5NAcAC3I5empK8aw4TU/uk33ajmezUoX4skp7rhJ
        ilvZp2wQnZtwfPaY0tr3KOE9JV9g3n2zjxjcAS7p1oq1wnEYtljBjjXfjMpwf3PR
        tYvS7oI3KBnU6P6VWewWDaty0Rq+xZkQSOA2osw2pbsDRlsJZKBQ3h1aZnAf6Oc0
        X1ww/Lykmt2wF+Ye51tNlzHhBtztH2KHfr3sU4gfaBqFrkm5DXANgX35i3QlDlsf
        ezSskS46bFAsLz84NKLJnJEznN8FEDoKseWqhSfQWktgFuGAExvkflgrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=ZDDHs6S1gq2LInfVgmp0pHkW/VF7Q7iLnmFsdw8/KiU=; b=T6hbr9/f
        JvMhh2zBE3RVRuztK5bIGCwlEzqHvGUgsBJnzFfpr1mLYxU1vkK8VkJpLXdZpMhb
        Vs7zQtYTez8xTm6S9YCscm27PAeYXXomLyXyGUeEwP5I39KAnYtdohsoHoaSOq6l
        HKa1O82lNpYjns5STZ1hPQGj0fA9C5MMvjM05/ctdAsUVxb4T1dsS+Au4VdbrOl0
        LhxD4FmqrUp+MrzfYlzM5gI/faNxj8MbizvcDg7791fixXGN9CH0IZdXwehhViiL
        E/EU8Ey8WyulVogAAE3tazAY6wgPDOWw3b34eC/XsPTNuo3urBIulaQCmX6XvGD3
        cdAijCp/ACbbzQ==
X-ME-Sender: <xms:ZwejXoa5z1yHEhpuBIMOcLDQonnMn1XslMfpDIeqnGHH17CUwFGBnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrhedugdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedvheenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:ZwejXmChnfT6QMbyJZaO6Bqpj_w-zYtFFw3NP7-2fmxSKueeIm_Fkg>
    <xmx:ZwejXieksySxOwa-RPe1eSlg4Jq3dIh-R-1rDnVyteUJMxuS1FbCZQ>
    <xmx:ZwejXj_icdsdgEwZIDpf5d8qCcxnmjoBWEE8rLyxEtLM0N0qsuOzkg>
    <xmx:ZwejXrIHsmCIfSK9IHIAHNpsPJi7vGkDvaNWD_5nEK-soQ_qU-odYrP_V-c>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 09E68328005E;
        Fri, 24 Apr 2020 11:36:06 -0400 (EDT)
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
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v2 32/91] drm/vc4: drv: Add include guards
Date:   Fri, 24 Apr 2020 17:34:13 +0200
Message-Id: <e460188876bf0d4b3b3a6428a237794907bbb4d4.1587742492.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vc4_drv.h doesn't have any include guards which prevents it from being
included twice. Let's add them.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_drv.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 139d25a8328e..e7748f8e2967 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -2,6 +2,8 @@
 /*
  * Copyright (C) 2015 Broadcom
  */
+#ifndef _VC4_DRV_H_
+#define _VC4_DRV_H_
 
 #include <linux/delay.h>
 #include <linux/refcount.h>
@@ -897,3 +899,5 @@ int vc4_perfmon_destroy_ioctl(struct drm_device *dev, void *data,
 			      struct drm_file *file_priv);
 int vc4_perfmon_get_values_ioctl(struct drm_device *dev, void *data,
 				 struct drm_file *file_priv);
+
+#endif /* _VC4_DRV_H_ */
-- 
git-series 0.9.1
