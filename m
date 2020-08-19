Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C17DC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 10:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44461206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 10:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WfRsJeQ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgHSKy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 06:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgHSKyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 06:54:22 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E74CC061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 03:54:20 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 9so1612754wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 03:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LoR45TLt38yCU6AhQ8oX4RTGkUKE37UbDgPk3c4jGCY=;
        b=WfRsJeQ6i7bcQs7Hh6HfJ0mcOi/e+46/0sIZqEhM9Fro1CA8P+8fToIkBi7iccjbpq
         XIwYXrRAl8fucC/T0b4oMAVA/CxVIbnqXkeQFDejPkuyxxpOMha3oLfHNcBn6KsdBd2b
         +UxO/K/59OdhpBlKfc8sUV8X8bPfjLmScDR6ONM1m3jQpclskEKwo7oPhyEDlkD/Gjfi
         RQDYzc8EDphk/hyhlehKdNk72McXQrCG1WlxJC5/XGBvuoqx2RcMqwMgIoqlcozWCRG6
         9MMJ+d5tGH8AI3pX2YFB1cIxf59bI7C6odaFG35zS3zwdoCMQ88AgR7IZS/z9f4MyeWE
         jvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LoR45TLt38yCU6AhQ8oX4RTGkUKE37UbDgPk3c4jGCY=;
        b=R/yd1JucNFlAOyz9+FjAlm504l8Wr2SxWeSxVPHeO4BfbVULD2aKO835GTtxra63eF
         bSoL4P0fbkZIWaGTKwv/xm8uaKAtKJOV+sFMkyXYkRmHPc9PPnTZbwe5DJ+VcYOJBoe+
         bE0zg/z7bk3cb4NBN2CUeQ/keWe6GEcOBe4L/pG9NlsU756E1X1Loe3Pab+Cf4Swt+Kz
         tFgZUi/rlz3+LRK2/YyarASsd15qqMSmw0DCbQ9DljSN/IRbuhk+f1Gvo2+GsWDcxtmS
         6MW5i4jES2dm1zpBfjELNnZPHCN9Op1cJsrFyE2pJGpvodw+HNr5LETEaotUjnwFWnkC
         X+Xw==
X-Gm-Message-State: AOAM532sz2x7CzJax+G4uI/GijuSKLsDK8RX2fM7xGTvO3ojJRgU/NKR
        qV3B68jPw0bId8g13IoNmUy7XA==
X-Google-Smtp-Source: ABdhPJzTuBTrMvjfZt2nq0o/V4PT2CQ3KIo94Gao3LzYMwZ/7/L4nEPgV6onwZCV/wWynDthcOgCDA==
X-Received: by 2002:a7b:c38d:: with SMTP id s13mr4432107wmj.153.1597834458881;
        Wed, 19 Aug 2020 03:54:18 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id r11sm38389400wrw.78.2020.08.19.03.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 03:54:15 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        icenowy@aosc.io
Subject: [PATCH 1/1] mfd: mfd-core: Ensure disabled devices are ignored without error
Date:   Wed, 19 Aug 2020 11:54:06 +0100
Message-Id: <20200819105406.3249846-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e49aa9a9bd22 ("mfd: core: Make a best effort attempt to match
devices with the correct of_nodes") changed the semantics for disabled
devices in mfd_add_device().  Instead of silently ignoring a disabled
child device, an error was returned.  On receipt of the error
mfd_add_devices() the precedes to remove *all* child devices and
returns an all-failed error to the caller, which will inevitably fail
the parent device as well.

This patch reverts back to the old semantics and ignores child devices
which are disabled in Device Tree.

Fixes: e49aa9a9bd22 ("mfd: core: Make a best effort attempt to match devices with the correct of_nodes")
Reported-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/mfd-core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index c3651f06684fa..30f90a15ceaab 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -126,10 +126,6 @@ static int mfd_match_of_node_to_dev(struct platform_device *pdev,
 	const __be32 *reg;
 	u64 of_node_addr;
 
-	/* Skip devices 'disabled' by Device Tree */
-	if (!of_device_is_available(np))
-		return -ENODEV;
-
 	/* Skip if OF node has previously been allocated to a device */
 	list_for_each_entry(of_entry, &mfd_of_node_list, list)
 		if (of_entry->np == np)
@@ -212,6 +208,12 @@ static int mfd_add_device(struct device *parent, int id,
 	if (IS_ENABLED(CONFIG_OF) && parent->of_node && cell->of_compatible) {
 		for_each_child_of_node(parent->of_node, np) {
 			if (of_device_is_compatible(np, cell->of_compatible)) {
+				/* Ignore 'disabled' devices error free */
+				if (!of_device_is_available(np)) {
+					ret = 0;
+					goto fail_alias;
+				}
+
 				ret = mfd_match_of_node_to_dev(pdev, np, cell);
 				if (ret == -EAGAIN)
 					continue;
-- 
2.25.1

