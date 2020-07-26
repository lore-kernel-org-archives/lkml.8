Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B458C433E4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 04:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE1C72053B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 04:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="B9ohVNms"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgGZEkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 00:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgGZEkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 00:40:06 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17BEC0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 21:40:06 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t6so6465841plo.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 21:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cxwX2AIPHGdhCk9KqDzZeCU4mfFsakd7X68zNyxQ72o=;
        b=B9ohVNms6utQE84bDZvt/X1xrWcl1qH6zHCyzGnssOwqronSOaTwM3pmmtfnhWm/A6
         BhN9jdBJHXXVz5u5W3MKYQSNvNfMNK0p0r9kVdpMzZE8sQPSXrs5WQx21f3oL8gvJ+cQ
         n6k1w+OsdiwxCXmb9uAFVStF8E+7gpmlowdmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cxwX2AIPHGdhCk9KqDzZeCU4mfFsakd7X68zNyxQ72o=;
        b=dQL+P6LYeDCmprlRH/z/vE/3VIOgoP79DQr3yvs13lbVVlys7v68qEcSQT0DGAAT+0
         oRPIaE4s5mIH/iTfnOolSGdKW6q/0pfbxGwKFaYGOn+If6j21ZJNnzJ2U6T2ryKipvri
         jNrwE68RVQc7T4I5P7+8IyxcdoEdXB5JbpIx5uum6FuE0phQ6zmFBP5JD1+Osa5aaXMV
         XG68d3ehJcl3HWZpwXmeDKPn1P1bHjVF3a87aZU1jHKg/jm6vJWPnM/a3PBLdGgnz/y5
         DC2tAs/YuxbQo0st1x9/d9fHENKymosiXs/xJ1QEvPsYULOVHx9t9qP2VEgaar0q7ZgL
         vV3A==
X-Gm-Message-State: AOAM531e/4kgJlcPlJoy25ZeTzvoOxHFv6QYZVgnfwQswKfmUr4nSYw4
        9LScx7Wb+UddKQei95xW/G5xBw==
X-Google-Smtp-Source: ABdhPJwGEE7daGYP6xyWGoLWPlv+cxg/gdpeYpB7PSPQMfohdPw4fyifn2IIsAQQTjDIuTRBOkgpvw==
X-Received: by 2002:a17:90a:b00e:: with SMTP id x14mr13067166pjq.57.1595738406168;
        Sat, 25 Jul 2020 21:40:06 -0700 (PDT)
Received: from shiro.work (p532183-ipngn200506sizuokaden.shizuoka.ocn.ne.jp. [153.199.2.183])
        by smtp.googlemail.com with ESMTPSA id t1sm10507372pje.55.2020.07.25.21.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 21:40:05 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 4/7] ARM:mstar: Adjust IMI size for infinity3
Date:   Sun, 26 Jul 2020 13:39:45 +0900
Message-Id: <20200726043948.1357573-5-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200726043948.1357573-1-daniel@0x0f.com>
References: <20200726043948.1357573-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

infinity3 has 128KB of SRAM at the IMI region.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/infinity3.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/infinity3.dtsi b/arch/arm/boot/dts/infinity3.dtsi
index 2830d064c07d..9b918c802654 100644
--- a/arch/arm/boot/dts/infinity3.dtsi
+++ b/arch/arm/boot/dts/infinity3.dtsi
@@ -5,3 +5,7 @@
  */
 
 #include "infinity.dtsi"
+
+&imi {
+	reg = <0xa0000000 0x20000>;
+};
-- 
2.27.0

