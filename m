Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0843C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BFF720786
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="IDJHDqNL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgG1KD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728646AbgG1KDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 06:03:54 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49831C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:03:54 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t1so461036plq.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B89mjClqeI/vqWkN9tLpJuvAY3gONZ+D/nVVB1nJjqE=;
        b=IDJHDqNLXGnZEzFNlqEOTInutoPxbVgpW/zs4sxqngNtawOBMyGB0+/kv3OOo1sgl+
         vgk0LA9WseadMqv/xlCv/9hWIaz3tiKOa3lDzToavjt4NOHqqCoRZnHvMIfNlxW1HIJw
         93rc3DgLtjM7PoPKVvv0GLFR1HA0MSaG5CXAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B89mjClqeI/vqWkN9tLpJuvAY3gONZ+D/nVVB1nJjqE=;
        b=ZdkKExWS11FE8sd6TozixpQ4QdsxIy7XmDepyzT1FgOPs7FWu7xlLhJ9UMw93Cq5ll
         5hZEYOcKQ1F4cySokRma3KI+zMazL5VcXsr3TpB8iSCP6C8y49Z9Qy149q4T6TmbwxX1
         sqtO1vjZuRVABK9UUEdqQKUL18s2ZtcETF0w295GhGUgeI0/ZZ1ZOLPZRcQVP7EK7YRA
         n7izsmZXNQmaXMKkpg/TePbjpnM8w15s6wZBM3nYlfbtZfUPk/EHwvnmPzsrm7X0Sz3i
         LykjWsJU8ANxcpXlXe/s2WXkVhSvrdA+xzYeNk00nXAhDiVMd5DUSkr9F+bkOX2gmABQ
         wnAg==
X-Gm-Message-State: AOAM532Pii0dpTTlpPS06YTOywEbWsPmdy+WdjF5fJ2h4lqCP5Wwfc9c
        ASZX2/Gpy/kuL8+u7DbObv1bXA==
X-Google-Smtp-Source: ABdhPJwzavziDgWZ8/8aJJSmyTGpB3WR5DC+B2ky5X3WtG3n/UQyG/0pTtLr/GClhyOMrQxJuYWTqg==
X-Received: by 2002:a17:902:cb91:: with SMTP id d17mr4528874ply.223.1595930633809;
        Tue, 28 Jul 2020 03:03:53 -0700 (PDT)
Received: from shiro.work (p532183-ipngn200506sizuokaden.shizuoka.ocn.ne.jp. [153.199.2.183])
        by smtp.googlemail.com with ESMTPSA id u66sm17779018pfb.191.2020.07.28.03.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 03:03:53 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de, robh@kernel.org,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2 8/9] ARM: mstar: Add "pmsleep" node to base dtsi
Date:   Tue, 28 Jul 2020 19:03:20 +0900
Message-Id: <20200728100321.1691745-9-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200728100321.1691745-1-daniel@0x0f.com>
References: <20200728100321.1691745-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a node for the pmsleep area so that other
drivers can access registers contained within it.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/mstar-v7.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-v7.dtsi b/arch/arm/boot/dts/mstar-v7.dtsi
index f787b8e4b67f..bb7fb3e689a7 100644
--- a/arch/arm/boot/dts/mstar-v7.dtsi
+++ b/arch/arm/boot/dts/mstar-v7.dtsi
@@ -73,6 +73,11 @@ riu: bus@1f000000 {
 			#size-cells = <1>;
 			ranges = <0x0 0x1f000000 0x00400000>;
 
+			pmsleep: syscon@1c00 {
+				compatible = "mstar,pmsleep", "syscon";
+				reg = <0x1c00 0x100>;
+			};
+
 			l3bridge: l3bridge@204400 {
 				compatible = "mstar,l3bridge";
 				reg = <0x204400 0x200>;
-- 
2.27.0

