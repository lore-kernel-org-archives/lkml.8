Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E12CC33CA3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 06:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D346D20673
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 06:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeiG/VoX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731476AbgAJGKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 01:10:09 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:38714 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbgAJGKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 01:10:08 -0500
Received: by mail-pj1-f67.google.com with SMTP id l35so531157pje.3;
        Thu, 09 Jan 2020 22:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Gs8xOV9REFN752Csx9CR2qaFoIT578nSg5oH4PWWVU=;
        b=CeiG/VoXb1xWihY/5qC/jQtxLE/cxBJ6pV/wc/Gtr/xdoAwsO5F7+zcEI9691HAXaV
         2Y6WUuhgdA+22IhN3VWLIYvNlLLNZp6ltsaCdJgN5IA38fMHTUDHv1+u5fg1dKOe9wqn
         7xeE4AKM4AhD0tuyEPeykZNuVJI+7KiECrEtoB9amFpeUZtwpfAZFUsZmiv9UzxYMeW8
         D8EVZvcUEtgE2tMfI3na8iwjOgK/tTZPfajZWBsEFLjZZEHvjmdFH4R9nSwIE6vyc123
         IWGQMp4KtdPRATDBiu6aD0cq322sFn64Bf2OaRArsnAOyylwipOTdI0h5G3vMYScdIIS
         bvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Gs8xOV9REFN752Csx9CR2qaFoIT578nSg5oH4PWWVU=;
        b=tELd7GKY/ogO6aOAwynY3vWqWRm0kE6wuaTuHGScCVekmZO9uzkWFIHIQOrSdRORjH
         JvO86M655/qr/S7k0V/pK36zHkZ6+RCibr0QTN+YGoNkqcB/0DnAD27wJ+c2cqWSiJI5
         4UIaddABRlp4gcNCsW4bP3uvZ0EmH7RBZlsBp1mJ5yTwwt/8XQh/AlDwH/wpLGJUNNNf
         gwmUPeflstROomusujATxOzeu3zvfSZgEGKRyG5nuUVtMN/oJfZkIW5z/MDAVf/nIwfM
         Zcg5QeVqiNapDnJ1go612+VKnm7ARuhOIsFsCBRlbkdz0mGecoIQUosSRg6eTok/t7/L
         aFAA==
X-Gm-Message-State: APjAAAWAqQnWnohG7lNCFpu0ffzA6kwQo/TnqHtq0vXA4KR5IHJJOX06
        6y6QKM3Fckdc6sZiYbf+38M=
X-Google-Smtp-Source: APXvYqyyWTkrtPgZojyimf0o1zZY57YIXWKkXv83ZHxaqsX1ll7mTEQvcqagmZRQ8JkmYI4uP6mPrA==
X-Received: by 2002:a17:902:6b83:: with SMTP id p3mr2316604plk.284.1578636607884;
        Thu, 09 Jan 2020 22:10:07 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id y76sm1195814pfc.87.2020.01.09.22.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 22:10:07 -0800 (PST)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 2/7] dt-bindings: clk: sprd: rename the common file name sprd.txt to SoC specific
Date:   Fri, 10 Jan 2020 14:09:13 +0800
Message-Id: <20200110060918.18416-3-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200110060918.18416-1-zhang.lyra@gmail.com>
References: <20200110060918.18416-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Only SC9860 clocks were described in sprd.txt, rename it with a SoC
specific name, so that we can add more SoC support.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/clock/{sprd.txt => sprd,sc9860-clk.txt} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/clock/{sprd.txt => sprd,sc9860-clk.txt} (98%)

diff --git a/Documentation/devicetree/bindings/clock/sprd.txt b/Documentation/devicetree/bindings/clock/sprd,sc9860-clk.txt
similarity index 98%
rename from Documentation/devicetree/bindings/clock/sprd.txt
rename to Documentation/devicetree/bindings/clock/sprd,sc9860-clk.txt
index e9d179e882d9..aaaf02ca2a6a 100644
--- a/Documentation/devicetree/bindings/clock/sprd.txt
+++ b/Documentation/devicetree/bindings/clock/sprd,sc9860-clk.txt
@@ -1,4 +1,4 @@
-Spreadtrum Clock Binding
+Spreadtrum SC9860 Clock Binding
 ------------------------
 
 Required properties:
-- 
2.20.1

