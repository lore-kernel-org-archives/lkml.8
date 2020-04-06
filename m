Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2853CC2BB1D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB2F2072F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="No4ucvr+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgDFToK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 15:44:10 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38833 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgDFTnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 15:43:52 -0400
Received: by mail-lj1-f194.google.com with SMTP id v16so1051261ljg.5;
        Mon, 06 Apr 2020 12:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h9tkgMFNzJvbwS5Mj8KGdhRxtWizvU/2l3mcyErW424=;
        b=No4ucvr+ihtQGx7piq/XioUheCKpFmahFuTe8BVkyxriIJ3+PSB7RACUzg76eNsD6a
         s+6DQ3hWJSi2mCbVdNq3GzLC4AaIOBfHrgJjN2/Gcf8pxVqDzNzeMICtxYOtfcVpqs8J
         m506ZpFtHWKVViVYRHH25jy34iSpXkTiyxTSZ7Oo+0EPIe4e1UZm2qdeFdp1cR1ex/xB
         0By+z5yUmKnrGx7f70f/cqxxpqDUNOfTVUjLPVc4JhjkPoX2HDld+h4aLUAnQd7nh53d
         m1wKkq+XYc+w1borP9/qRNfAUJH836+JryBomyV+nIMW7bUdB9c6Qv2QOvuZUBB+jAyB
         o/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h9tkgMFNzJvbwS5Mj8KGdhRxtWizvU/2l3mcyErW424=;
        b=hno5aESXr3BBhRthtII65pNs8XiCiqD/1FFpH+VLvdYOui6/A4NhV8VAU/4LqAqXA1
         M0xD8lLu5b3Y8qvMLLVPCaSE06b2WZenvU8Eo2S096A4PP/oF2NmRerYBPM2pVNXHsqj
         Q1DfYJ7vovVG19zxYCc2yy8JbJV160nwSbKpQGIalv52FLdoVyBHjR4bGhoUg4pz5qgS
         wOydPcU0EylGqx2McR1u8PhKqmyr6K/3fVyMtuURiDHHdHwUPX14wBIgyR7+xgMHE/Mg
         CadGjF/nAoAJb1qqVqmDSZzsd8EAspsfLTLnFx+gf48ysLYJCbjasHOq10PSdeAV5Vwx
         nDaA==
X-Gm-Message-State: AGi0PuaofHA0wkXNUZ+DQWRIM5OMrK1Z220bwjLYNBzQ37VAzBRqdrxA
        kc50Xq6yu798gLlnAfXp6HA=
X-Google-Smtp-Source: APiQypKAK7UGTqgb/z+ukoC6VwgVw+YPVpEN9s3FFYFCKks5ZtwP1J2TWVMGJBSgBa/UfBnKq1l83w==
X-Received: by 2002:a2e:91cc:: with SMTP id u12mr576009ljg.244.1586202230524;
        Mon, 06 Apr 2020 12:43:50 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id r206sm4996233lff.65.2020.04.06.12.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 12:43:50 -0700 (PDT)
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
Subject: [PATCH v2 5/6] dt-bindings: ARM: tegra: Add ASUS Google Nexus 7
Date:   Mon,  6 Apr 2020 22:41:09 +0300
Message-Id: <20200406194110.21283-6-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200406194110.21283-1-digetx@gmail.com>
References: <20200406194110.21283-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding for the Tegra30-based ASUS Google Nexus 7 tablet device.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 Documentation/devicetree/bindings/arm/tegra.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/tegra.yaml b/Documentation/devicetree/bindings/arm/tegra.yaml
index 7fd0b66c69b2..fb3bbf7a5fb4 100644
--- a/Documentation/devicetree/bindings/arm/tegra.yaml
+++ b/Documentation/devicetree/bindings/arm/tegra.yaml
@@ -62,6 +62,13 @@ properties:
               - toradex,colibri_t30-eval-v3
           - const: toradex,colibri_t30
           - const: nvidia,tegra30
+      - items:
+          - const: asus,grouper
+          - const: nvidia,tegra30
+      - items:
+          - const: asus,tilapia
+          - const: asus,grouper
+          - const: nvidia,tegra30
       - items:
           - enum:
               - nvidia,dalmore
-- 
2.25.1

