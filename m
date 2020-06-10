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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09359C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D89532072F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHrcQOV7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgFJRRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729586AbgFJRQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 13:16:39 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561E4C03E96B;
        Wed, 10 Jun 2020 10:16:39 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t18so3168938wru.6;
        Wed, 10 Jun 2020 10:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8qnrUTlruyZBfNINeLZXr9jcAeZ0GwM8qwMZYyF64O8=;
        b=hHrcQOV7s9ClQx7WJ82o5VJSvvzJkKtumIstTIIQXpH710Clhl4FTJz2S4mNdf3MWp
         j9zCDGIulHTU5v2fq6u1EyY5oc8CSVeXaW/FUQgM2kGCZ+ggehjij2KJP9GOSXE1l+71
         jFtkDaudCxhpF8gqBi4s9CcuKI1LeCZTNrLTyT8sw6OcSmYlbRDyLqiGn4Ya9Fbb0M4f
         U2hBGt02wqXZt/+XVE7S6EvlXCmOyQx6tRi1YHCjVT+g1GJlOaJknFEeiuKYFmGOea9w
         N/SvikagMRBwV/5/uAWiQDeeEsx5OwNuOWycdaUXH4/7AorC9ZzAytcjM9W8WVTbDaDi
         eABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8qnrUTlruyZBfNINeLZXr9jcAeZ0GwM8qwMZYyF64O8=;
        b=R08AbAjlsI10EEX0FiIQJwKmc/tlf1Xq1ArgCB0yJyYoX+v2ljr8fHnHU/T//ip1bd
         cyd4Ocmn6oPX1+ybrqFFNj/rZkP9hANWWf54lzdh7rOoLxBJfqS6GFHWVNLqFWs6okWY
         Wa07oO9JovSF6jPJcg+O6AMgD0Do1UjbOd5cxOyuDDra3pl4yJV15g+rn+yihFSiGl4K
         iksQQCJ6W0b0hXSZgzLDLRqK8MRDJQS4XIxbIPhPwJvU6aHTnsPw56ofgS2nc3dOzWND
         /qF2NL5ZRSmpp48OiJl/5S5H+4OcM81QilH02ULrF8EvzeesX7hQfnHFruF3sy0IopGW
         +d+Q==
X-Gm-Message-State: AOAM531la9QRloOP48txHTiTRuyIVnbBOYnW6KHeWyq7KWWZ8p1K8Tzi
        DVtR7euQGkn6OEXdCQ4JDz8=
X-Google-Smtp-Source: ABdhPJy5yG42+jw2onyLnrDicb3xufPchQWsadng168yCu+nX18AQlQFTfWW1LAAWEeta6RWulAgkQ==
X-Received: by 2002:adf:ef50:: with SMTP id c16mr4773543wrp.161.1591809397956;
        Wed, 10 Jun 2020 10:16:37 -0700 (PDT)
Received: from skynet.lan (28.red-83-49-61.dynamicip.rima-tde.net. [83.49.61.28])
        by smtp.gmail.com with ESMTPSA id f11sm589048wrm.13.2020.06.10.10.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 10:16:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     hauke@hauke-m.de, zajec5@gmail.com, tsbogend@alpha.franken.de,
        robh+dt@kernel.org, f.fainelli@gmail.com, jonas.gorski@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v3 5/9] mips: bmips: add BCM6318 power domain definitions
Date:   Wed, 10 Jun 2020 19:16:26 +0200
Message-Id: <20200610171630.465579-6-noltari@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610171630.465579-1-noltari@gmail.com>
References: <20200610163301.461160-1-noltari@gmail.com>
 <20200610171630.465579-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BCM6318 SoCs have a power domain controller to enable/disable certain
components in order to save power.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 v3: no changes (patch reordered).
 v2: Add BCM6318 dt-bindings header file.

 include/dt-bindings/soc/bcm6318-pm.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 include/dt-bindings/soc/bcm6318-pm.h

diff --git a/include/dt-bindings/soc/bcm6318-pm.h b/include/dt-bindings/soc/bcm6318-pm.h
new file mode 100644
index 000000000000..05931dce8333
--- /dev/null
+++ b/include/dt-bindings/soc/bcm6318-pm.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __DT_BINDINGS_BMIPS_BCM6318_PM_H
+#define __DT_BINDINGS_BMIPS_BCM6318_PM_H
+
+#define BCM6318_POWER_DOMAIN_PCIE	0
+#define BCM6318_POWER_DOMAIN_USB	1
+#define BCM6318_POWER_DOMAIN_EPHY0	2
+#define BCM6318_POWER_DOMAIN_EPHY1	3
+#define BCM6318_POWER_DOMAIN_EPHY2	4
+#define BCM6318_POWER_DOMAIN_EPHY3	5
+#define BCM6318_POWER_DOMAIN_LDO2P5	6
+#define BCM6318_POWER_DOMAIN_LDO2P9	7
+#define BCM6318_POWER_DOMAIN_SW1P0	8
+#define BCM6318_POWER_DOMAIN_PAD	9
+
+#endif /* __DT_BINDINGS_BMIPS_BCM6318_PM_H */
-- 
2.26.2

