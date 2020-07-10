Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2123FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC8DF206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="kNqPxMM9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgGJJqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbgGJJqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:46:12 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B45C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:46:12 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id t6so2308915pgq.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XhWMx0j/cyCnhmrTzo0oYPY6DDccISB6NUmDX++Xyd0=;
        b=kNqPxMM9/JjdDB3Q8g7rsPcGAKFEnLP1z0PprD7TmTI4NCSOeNz9zaXD75vZMgQYe4
         5EJQBIydPw0HU2IWEKZL3UzfzchRwrI0PZ7jaSt1LBpAlXEDojN5V0qwn+S8kmrHHqJ8
         LiabKtGrUFGRoAeo8aUcjO0JHBUnnTgVUBrmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XhWMx0j/cyCnhmrTzo0oYPY6DDccISB6NUmDX++Xyd0=;
        b=HUY1Z1gdTmWeiFpJf5lW3xVeLQ9ue11mBFY/hRhMhabslm/SizS8H5IsURPmoLuJfZ
         GTAageH/8m4SmD+3WQco+2hI+8D8g2/mRYEI0JdaSBgzc1JLyz0m0y5rDD8Vz1N3KtN4
         UMuzOSscEqccIb1fGr2mqujI1tpOz7M3Z6JDlF/IDSsczjBS+udi2KsN3SM/1PID2V9m
         EfagDogGnKNtpPZ++ozK3NKukZr5VG+XQtGemcZoqfaKxBZNORKCqHEJTxrbX7UQuX0P
         S2rr22CysFuLtP/UafHZOMUmTlFb2bdGx3vUXNm3DrCrzAAn0amBC2zkqnl5aeS89xec
         G2xg==
X-Gm-Message-State: AOAM531IP7qJklggd+acLsREcHuiXJ5qql++D2/N28xIvzjOW/NPHwaZ
        6US5UsW9wv9/JyNAqcQ+d3HilQ==
X-Google-Smtp-Source: ABdhPJzll6JUJ6I6Pdb3JxQhA/6djgkZsDDTznXdKcVd5x9Yyt4wg9JHUXOgl16BDP/h+CJRG4JxVg==
X-Received: by 2002:a62:3583:: with SMTP id c125mr14791613pfa.158.1594374370506;
        Fri, 10 Jul 2020 02:46:10 -0700 (PDT)
Received: from shiro.work ([2400:4162:2428:2f01:7285:c2ff:fe8e:66d7])
        by smtp.googlemail.com with ESMTPSA id z9sm5133213pgh.94.2020.07.10.02.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 02:46:09 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux@armlinux.org.uk, arnd@arndb.de,
        afaerber@suse.de, maz@kernel.org, w@1wt.eu,
        Daniel Palmer <daniel@0x0f.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH v5 03/12] dt-bindings: vendor-prefixes: Add 70mai vendor prefix
Date:   Fri, 10 Jul 2020 18:45:35 +0900
Message-Id: <20200710094544.430258-4-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710094544.430258-1-daniel@0x0f.com>
References: <20200710094544.430258-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add prefix for 70mai Co., Ltd

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ba5bd3b0ed9a..53cd050668e6 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -23,6 +23,8 @@ patternProperties:
   "^(simple-audio-card|simple-graph-card|st-plgpio|st-spics|ts),.*": true
 
   # Keep list in alphabetical order.
+  "^70mai,.*":
+    description: 70mai Co., Ltd.
   "^abilis,.*":
     description: Abilis Systems
   "^abracon,.*":
-- 
2.27.0

