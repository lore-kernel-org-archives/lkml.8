Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7ADDC3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 11:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8913C2166E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 11:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NPzYl0+C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbgCBLWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 06:22:03 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35155 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgCBLWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 06:22:02 -0500
Received: by mail-wr1-f67.google.com with SMTP id r7so12094470wro.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 03:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eHZJoauDU3YCd4oo6H8UkUj4vcKpuKTOVNgGI3sKcA0=;
        b=NPzYl0+Cj9Bodz62CFuc/7zeYsqpkh13Et0PpWoBeAy0TS2FC5OplEhDkxAYsc7Uvp
         GkkjKKcMZX9GWQNuJ5iT4Dq6TigXqR+mvYZZJpZyWpiCVEjb9PJ9fvCRFFGTnOQ4LZkO
         YzxSjml2OP392/Scf5dO8G7l4Kmh5NyMy/neFvB5mwjAoWkrkHhTs/jdvRjF9gs4KE8M
         kyZFxBfe6c7nR6gxQNu1/BoVNv9QgAajUc8QZpwFJUc4A11WKRDG7YBLYwsOMd2im58i
         CO7l/S5+9YSI9y0Ts7mQtTlB+k0k2jRGaGJRBOLGJ/oGOpWl2+2d566XLfXw+zwRHKS3
         jmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eHZJoauDU3YCd4oo6H8UkUj4vcKpuKTOVNgGI3sKcA0=;
        b=lvwDObCnDYgkglFYtCYMB3SKZ/VzLYSqxFZ79Mwg89kJX3e6YyGJ7J+jZiSepZDnWl
         xFbgUfGI5OIWsyLqDG1laIfSlgk9ExaozIVkwKJyM5QmS2rhP5FeX+rW9OvDqOu7/4xs
         Evd1gqaDy6ms1ALHAF5n1s/fTu5vY+c9NLJsWtbtOkeepa59Yaxq/OVfVA4tbPjTuI0I
         0/Zmio89Gar8awENb9EESnrTqc5QPYCc78k1fwoFWGfO5Dv6onr8P+oF8AUW/47GqWZ7
         jgmaYp7Y3MmwKh02/suEDAWJfMTkog/eXXi/hwyDVuHiF0mjdeRa1q3sVxdx1qBNiWxr
         q/cA==
X-Gm-Message-State: APjAAAV/UAOZJXYQuCW8IWfmer24XrlWL+QvkZxVky1CBqe2vmCaF6/B
        UGo07kXwDn/T03BB1fw0N0xKOQ==
X-Google-Smtp-Source: APXvYqyZlRonNGPN6OZje8r6g98mgNwbkojbpYskc2y6mkeqC9MkKpFwp4Ipsn5QsmRq8gTVXPpHag==
X-Received: by 2002:adf:dfc2:: with SMTP id q2mr21397636wrn.209.1583148120855;
        Mon, 02 Mar 2020 03:22:00 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ecba:5540:6f5c:582a:cc84:32f5])
        by smtp.gmail.com with ESMTPSA id j14sm28398441wrn.32.2020.03.02.03.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 03:22:00 -0800 (PST)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     matthias.bgg@gmail.com, joro@8bytes.org, yong.wu@mediatek.com,
        ck.hu@mediatek.com, Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: iommu: Add binding for MediaTek MT8167 IOMMU
Date:   Mon,  2 Mar 2020 12:21:50 +0100
Message-Id: <20200302112152.2887131-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds IOMMU binding documentation for the MT8167 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Acked-by: Rob Herring <robh@kernel.org>
---

V2: no change

---
 Documentation/devicetree/bindings/iommu/mediatek,iommu.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
index ce59a505f5a4..eee9116cf9bb 100644
--- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
@@ -60,6 +60,7 @@ Required properties:
 	"mediatek,mt2712-m4u" for mt2712 which uses generation two m4u HW.
 	"mediatek,mt7623-m4u", "mediatek,mt2701-m4u" for mt7623 which uses
 						     generation one m4u HW.
+	"mediatek,mt8167-m4u" for mt8167 which uses generation two m4u HW.
 	"mediatek,mt8173-m4u" for mt8173 which uses generation two m4u HW.
 	"mediatek,mt8183-m4u" for mt8183 which uses generation two m4u HW.
 - reg : m4u register base and size.
-- 
2.25.0

