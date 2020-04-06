Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD892C2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D0F72072F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rDKIPBDC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgDFTn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 15:43:57 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42066 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbgDFTnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 15:43:51 -0400
Received: by mail-lf1-f66.google.com with SMTP id s13so448628lfb.9;
        Mon, 06 Apr 2020 12:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aMH1Nn5N++bI82vIh9Zeuiq3h9nQ3Tmnp6S+rKl7EQQ=;
        b=rDKIPBDCLHw62B4B62vZtPEj8/RgTX/2PBk4DPzAR2LVxEJnM4P8uYqE2ug2BzkVur
         0JAm3X+kiiiDVf392d+LptmOs5OPuq1V4QOT03tVJdX2CkNGyHCml9dEBNwGQ48E1KhO
         VAum9VB+3kGjAJdJY1bKdIasM9RaXftVmhYFhwvrvj2ECcJVzNMESdrtyonJCAJ1w0J+
         GcSVLxmmAxn351V686kgIdgdpLN/0Dp2nRWINRG9aRTTJU1/a9WQi8t/K+l36ckO1fkN
         3UwI6Hb9XiZDZ1W9ydNom8T/fwJJbhiRn1rDDGCYUURd6tKW5BH3Z7vYxXmCQrgMN9ya
         Obrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aMH1Nn5N++bI82vIh9Zeuiq3h9nQ3Tmnp6S+rKl7EQQ=;
        b=NxJs7rXSLtG2ydcuajjnAaarDvfySAoHrWzQKpwRr8l5gxBkQ3UWr15sRTjp38rG11
         J5r3EAaq94M1LlMMFbS174WW30zuxvBcp37iNhl2SO2xKxOKijgwAKcPmX4LTV2yEsfn
         AGBTxLOEs71BX7t0+g4XmM/pf7lSnQnOW0e9wY1cRunufBPQU5Lzf7m7bm7DtPWcRx5Z
         hHSgI+znssJppLvovTa93MnGBvdo5m5s9AbMPv42p8m5g8d5+RWBN7TXXpCOAUpN8uzP
         HR//ziNU8SkPgsZo8CtSp00tKKuHpOu1dRlVS7fbNkNAGjMpbbP50A5G/BLxwDjyCXi2
         184A==
X-Gm-Message-State: AGi0PuYxDuH3jR9g4Z9EtDWulYISGZRP+BxcwVNO8Pc+Arr9mYq1DLFM
        Tdj3siDyDya2IjkMdqwDlVo=
X-Google-Smtp-Source: APiQypIFkAtpfM05vPJXyGK6D4nBuDiu8PN3Ch+eamwuvFKgcMmkpNzc2TYkkPVFbrkBHYmIMlWBzA==
X-Received: by 2002:ac2:4853:: with SMTP id 19mr6664580lfy.171.1586202229423;
        Mon, 06 Apr 2020 12:43:49 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id r206sm4996233lff.65.2020.04.06.12.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 12:43:48 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        =?UTF-8?q?Pedro=20=C3=82ngelo?= <pangelo@void.io>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] dt-bindings: ARM: tegra: Add Acer Iconia Tab A500
Date:   Mon,  6 Apr 2020 22:41:08 +0300
Message-Id: <20200406194110.21283-5-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200406194110.21283-1-digetx@gmail.com>
References: <20200406194110.21283-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding for the Tegra20-based Acer Iconia Tab A500 tablet device.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 Documentation/devicetree/bindings/arm/tegra.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/tegra.yaml b/Documentation/devicetree/bindings/arm/tegra.yaml
index 60b38eb5c61a..7fd0b66c69b2 100644
--- a/Documentation/devicetree/bindings/arm/tegra.yaml
+++ b/Documentation/devicetree/bindings/arm/tegra.yaml
@@ -34,6 +34,9 @@ properties:
               - toradex,colibri_t20-iris
           - const: toradex,colibri_t20
           - const: nvidia,tegra20
+      - items:
+          - const: acer,picasso
+          - const: nvidia,tegra20
       - items:
           - enum:
               - nvidia,beaver
-- 
2.25.1

