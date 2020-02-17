Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3BFC35242
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 03:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B5321744
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 03:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/zBAfu0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgBQDXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 22:23:50 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36959 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgBQDXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 22:23:48 -0500
Received: by mail-pg1-f193.google.com with SMTP id z12so8319651pgl.4;
        Sun, 16 Feb 2020 19:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Gs8xOV9REFN752Csx9CR2qaFoIT578nSg5oH4PWWVU=;
        b=g/zBAfu04+SvgWF8Rk+ZuHK8b3yOSTTghkF6A3u23qwoG7fAOVdi7qdXgdxidcasSn
         o+raUZhrcEJyL9j6UIBS8R3HuelSn3cU4iGO1UOM0EvNWyVY7TjdWrkEpEcvUsYExt9q
         Kww6s1HYeqm76fdXf+AwjnCM2fXzvavQNXHXsJs7ZIW7a2ErkOrppGcIYtu6g7lOqbZp
         crGhFuGlKDOxxpY/EJXujlAVZ0D9CHRsJ26I0sXgH0M/h1d/9F1CF9iIG6dDvNTlpgN3
         LXM5AmWyIKdaZ6ZYn41mL32KhZ+km+RQw8szrfKzbpGAU25ERH5mfwAoNdjjxEE8/zn/
         OHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Gs8xOV9REFN752Csx9CR2qaFoIT578nSg5oH4PWWVU=;
        b=mKtYgRPJEVr5KIhy64o6ZWU+oXyiJAid5HqLZz6QP46VXc3uoUSSBzFklwbvToksSy
         n+wnUFjvWHISKdLsKJUe3FpLC3MMvmumj38SG4NG81kb//RdwpWntovVAMPtoFfZyLsh
         MC0cO/E+MK3f9VTW6cTfPiRB1wnio2n+TQpPW5q3f5LFBqcWxAt72UjmZvaZfo2263vr
         cNLFF6tT/pY9VdWxIPOKQKfiUSHNnkTOn+qz/u6600veQOuEt8Tr9QEPjO8q7BzQO0NQ
         XNdj2SO1kzBFRRqlcdgW3d/kYTKbw43c2nvBUC+7eqnfKu4PbphTA6l1CSkNTY8pH6Bx
         RGlw==
X-Gm-Message-State: APjAAAV9eJHwtn1kN90tOVS5CsHVCUB/iN8d8dvnMK1C9VcAXeppsqXi
        IiKPR6EBK7qVrx/9Adj1bMI=
X-Google-Smtp-Source: APXvYqxJVjO25azWgAgAJiLwywofO6K0+XKS9Gy1hDEZW2vRs/j5/wo3XEmU+CrywE/5+A/y3eW7qA==
X-Received: by 2002:a63:691:: with SMTP id 139mr16488412pgg.325.1581909828032;
        Sun, 16 Feb 2020 19:23:48 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 76sm14644383pfx.97.2020.02.16.19.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2020 19:23:47 -0800 (PST)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH v4 2/7] dt-bindings: clk: sprd: rename the common file name sprd.txt to SoC specific
Date:   Mon, 17 Feb 2020 11:23:16 +0800
Message-Id: <20200217032321.15164-3-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200217032321.15164-1-zhang.lyra@gmail.com>
References: <20200217032321.15164-1-zhang.lyra@gmail.com>
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

