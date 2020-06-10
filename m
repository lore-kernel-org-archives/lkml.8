Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF64C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8E0A206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQGZvkWi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgFJR31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbgFJR3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 13:29:12 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A23C03E96F;
        Wed, 10 Jun 2020 10:29:11 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l26so2579516wme.3;
        Wed, 10 Jun 2020 10:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SHgzSJEEndBakOSkgCFurMoB+aQACrg9d1V1wZ4pvkc=;
        b=lQGZvkWiq1dx9K2Elaa+owKrv4kHARiPswI+rjdeLj5bpFu7xOMRJ48H2cy3qQPEow
         5CuWNhPnmCxKg8Lb6Ewo2Y22lUPEeQid0V9Atr3e/emFRpDQBnzSZAJcr+MIA53Wi3Lu
         mK9qs0w2RS2xcl3+xIUu5NTY+YFbNmh6ouh/jibV4iJWXAx772oNyYqYsEZ54D6+0+gD
         1/PbWAKK2HZBY+cuSRXeJP5rQ2y4deKmG3+2M6oODRWrT1z+ZFdYgFCOLN+NyUn1E1MJ
         1IDIGRYMpuJFuZg6sUbE9JM80LxQiE3cSdJJeiMVoVLi1DS4ksvW53TWHENquYQ8Xuht
         xIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SHgzSJEEndBakOSkgCFurMoB+aQACrg9d1V1wZ4pvkc=;
        b=kQfDldvG2qpjl9fdGFxBEwHbEY9J8XV3lj0vVmcl/R9mIkWlZ5OIFm5rR34Ft5uEFc
         3O3cC9X8/sjE+H6D/L/wMBgGKVPrljOBdzjRntcLh48s9SzbqDZIkbRfikTs9Ab1q95a
         v8QoFsfgEY9q6eOMLaGUtqIsVOJRF/WhMgMCO/KdN7cZJ6DYAsYhFvlPA2f5EKWEXW8B
         kr0ebzYNgNZNwG/z2nwPQgqmhgkVNP5pqHUhCcJ0Rl3/9R8LBlGbZmoq5/bVB5bCVXWG
         rRS7MeO0UQ0cOH5QLu+X9e/50ZPre64k2cqXZ8mD8oEuRO0cT23ustH6/vaZFlto/dBm
         JK+g==
X-Gm-Message-State: AOAM531qnvvgsqcvZ3mIevDDADQXfHoutG+7ho741Yb3OvCy/ghtFf+y
        J8nEFRCC+x4W9ZpYE8WZVoc=
X-Google-Smtp-Source: ABdhPJw6oCXEx7AVchIxUlfyiuGSmLlGyIWpQ62BXmrtdcs+8+wmO6kGl29bLWhIGjx1NCAIGNKnNw==
X-Received: by 2002:a1c:143:: with SMTP id 64mr4417764wmb.182.1591810150107;
        Wed, 10 Jun 2020 10:29:10 -0700 (PDT)
Received: from skynet.lan (28.red-83-49-61.dynamicip.rima-tde.net. [83.49.61.28])
        by smtp.gmail.com with ESMTPSA id h188sm568551wmh.2.2020.06.10.10.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 10:29:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org,
        tsbogend@alpha.franken.de, f.fainelli@gmail.com,
        jonas.gorski@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v3 7/9] mips: bmips: dts: add BCM6368 reset controller support
Date:   Wed, 10 Jun 2020 19:28:57 +0200
Message-Id: <20200610172859.466334-8-noltari@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610172859.466334-1-noltari@gmail.com>
References: <20200609160244.4139366-1-noltari@gmail.com>
 <20200610172859.466334-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BCM6368 SoCs have a reset controller for certain components.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 v3: add reset controller definitions header file.
 v2: no changes.

 arch/mips/boot/dts/brcm/bcm6368.dtsi      |  6 ++++++
 include/dt-bindings/reset/bcm6368-reset.h | 16 ++++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 include/dt-bindings/reset/bcm6368-reset.h

diff --git a/arch/mips/boot/dts/brcm/bcm6368.dtsi b/arch/mips/boot/dts/brcm/bcm6368.dtsi
index 449c167dd892..52c19f40b9cc 100644
--- a/arch/mips/boot/dts/brcm/bcm6368.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm6368.dtsi
@@ -70,6 +70,12 @@ reboot: syscon-reboot@10000008 {
 			mask = <0x1>;
 		};
 
+		periph_rst: reset-controller@10000010 {
+			compatible = "brcm,bcm6345-reset";
+			reg = <0x10000010 0x4>;
+			#reset-cells = <1>;
+		};
+
 		periph_intc: interrupt-controller@10000020 {
 			compatible = "brcm,bcm6345-l1-intc";
 			reg = <0x10000020 0x10>,
diff --git a/include/dt-bindings/reset/bcm6368-reset.h b/include/dt-bindings/reset/bcm6368-reset.h
new file mode 100644
index 000000000000..c81d8eb6d173
--- /dev/null
+++ b/include/dt-bindings/reset/bcm6368-reset.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __DT_BINDINGS_RESET_BCM6368_H
+#define __DT_BINDINGS_RESET_BCM6368_H
+
+#define BCM6368_RST_SPI		0
+#define BCM6368_RST_MPI		3
+#define BCM6368_RST_IPSEC	4
+#define BCM6368_RST_EPHY	6
+#define BCM6368_RST_SAR		7
+#define BCM6368_RST_SWITCH	10
+#define BCM6368_RST_USBD	11
+#define BCM6368_RST_USBH	12
+#define BCM6368_RST_PCM		13
+
+#endif /* __DT_BINDINGS_RESET_BCM6368_H */
-- 
2.26.2

