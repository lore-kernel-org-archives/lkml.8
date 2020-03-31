Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A4AC2D0F4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 21:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE38020838
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 21:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euctZYXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731492AbgCaVpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 17:45:45 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36514 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731407AbgCaVp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 17:45:26 -0400
Received: by mail-lf1-f66.google.com with SMTP id u15so9551133lfi.3;
        Tue, 31 Mar 2020 14:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aMH1Nn5N++bI82vIh9Zeuiq3h9nQ3Tmnp6S+rKl7EQQ=;
        b=euctZYXcBIwKrzAtyTVpNDRLYIDP4M1HjBDZw6ulvxKSkWj2Hw62rI8Q4Dlr1VIfJm
         40DJFaCp5TSAF5+LMhYEcWp7pyH0oY0RasH6Kzz2EqyJ49j6MP3VwBy+j5m55pHeVthM
         A16bm9x474VAadipO62GwgEAMa7YRUPolkLwCpld9bhiILNcrkUpj8Lzgl9r6jtI1wNL
         tCl/rsEHfJIuckkciS+A4tOdCd7x7bUEMX9eLkd6us0nYs8GV3fx9z8woIZFTldE9PPn
         HfKS6E6sKJzfXpoBU8Lz+/papJ/alF1J/1wW8tnKJH2RSaa+UFoXO7Cftd+qAkDo2D0T
         LH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aMH1Nn5N++bI82vIh9Zeuiq3h9nQ3Tmnp6S+rKl7EQQ=;
        b=Qeadi8lXaHsnjsNAh2peW1ThE2x0pJy07H0S9NEyZ19PpgeZa5EnHr8mkiyUDcq54e
         vMQM6Z+/teXMNuvqm/EAn6GpPyqipQDfxd0Tk79pAdiTQu2aURvR31kZTYyrIFuau3WI
         MbqMfzZt3yFClXJOCFbvvrFyuz+xNg9fnvYVEqeZDA3qLKZ3HL9VVjZ66Lu5EnB/aRhs
         6emHhoyvATC+XVsTuVkH0W4LroEy4FIh7WpjR+73jNVVHvfM5HPEx7IPcNAfC+btfa3g
         00upwmTguLQ2wDw3wrswgZrMD89Rc7QxZNBOYtiaZXyscKWBtOwVt4DaitlYV4zKjYf8
         zN1w==
X-Gm-Message-State: AGi0PubtsKb2EkfS49Bx/zrWELb8efpNQcX0PMEddkhUyp0yiXNRmVt4
        +7sdRtrdMhcA3RCJ2FvBkMUtrfph
X-Google-Smtp-Source: APiQypJ67zs8QM3oeFjkvXK9AuExf+HPGajMPJ0bzku44RnUrvPyIa/zZWlgtBX8yC5ke3Ae+ouVEg==
X-Received: by 2002:a05:6512:403:: with SMTP id u3mr724939lfk.4.1585691124001;
        Tue, 31 Mar 2020 14:45:24 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id a4sm3757826ljb.27.2020.03.31.14.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 14:45:23 -0700 (PDT)
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
Subject: [PATCH v1 4/6] dt-bindings: ARM: tegra: Add Acer Iconia Tab A500
Date:   Wed,  1 Apr 2020 00:43:25 +0300
Message-Id: <20200331214327.6496-5-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200331214327.6496-1-digetx@gmail.com>
References: <20200331214327.6496-1-digetx@gmail.com>
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

