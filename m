Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF75C433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 04:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4B432053B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 04:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="a0Fs4meJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgGZEkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 00:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgGZEkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 00:40:04 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E217C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 21:40:04 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a9so7348644pjd.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 21:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TXJ1NcT71dEwTgLwEHbAIexF2sZraNkG0dfcffq3WTc=;
        b=a0Fs4meJoGMc6fOL1XFKjjk1/wXsBhoeWoL/A23QyJYUVN2fSgEf09ezWKGK4VBJIl
         pc8cZLin1e732paxMwyqPTyEOX6SCPtUgGIPzu30+Zn8GVRTJwVEVbyyDZD1at+LgWlG
         i6Ye3sLp1z00y0KoY8Ke2V1SqcTYkcKzoMPmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TXJ1NcT71dEwTgLwEHbAIexF2sZraNkG0dfcffq3WTc=;
        b=MsTNCFX6tNQAefLgXIJWafB7QNsVFERrOiFnNW2RclfXwbv01psAdGcjgzr78TSWuT
         pqnwDSu/XHsT2py9o5yjwzpUhxC5u/oTsUarR7FgAvDayFrxB+cnXDeho5CpdAQPPhm8
         dbnd2fdnJ5Pq284xUxBrIvk3mWRoOYFzVunqjnW28OqBUpDKsXtetDjZMewsTxLoblqS
         24o1DQjzst8zsOayK5m3cBtGDtC08EejPvvY/d0mN5V102QrLQ59BXZ7EI0fUjfqEf5q
         B+XFtVVIOGWGewjZ/hhjiBXbIs+PohOf6EgY+q6iwJOw0Qu2Ocy9ugX/E4CWVRCd3ZZU
         6k4g==
X-Gm-Message-State: AOAM530jsprDArc1w+B2ZO+9M0HcpgZfpX5XH2Oja9pX8iSxRoSqy7jf
        kZ8Bch5wAg22lU9JMVjMvVzWvA==
X-Google-Smtp-Source: ABdhPJzy0vBvUWWihwtxDTK8ly7CbhNg1RrC40BOaZpHt9iB2NgzrWJJvOlf6ioVecywtJ0ytSvu1Q==
X-Received: by 2002:a17:902:c181:: with SMTP id d1mr13989906pld.176.1595738403919;
        Sat, 25 Jul 2020 21:40:03 -0700 (PDT)
Received: from shiro.work (p532183-ipngn200506sizuokaden.shizuoka.ocn.ne.jp. [153.199.2.183])
        by smtp.googlemail.com with ESMTPSA id t1sm10507372pje.55.2020.07.25.21.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 21:40:03 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 3/7] ARM:mstar: Adjust IMI size for mercury5
Date:   Sun, 26 Jul 2020 13:39:44 +0900
Message-Id: <20200726043948.1357573-4-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200726043948.1357573-1-daniel@0x0f.com>
References: <20200726043948.1357573-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mercury5 family chips have 128KB of SRAM in the IMI region.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/mercury5.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/mercury5.dtsi b/arch/arm/boot/dts/mercury5.dtsi
index f68e6d59c328..a7d0dd9d6132 100644
--- a/arch/arm/boot/dts/mercury5.dtsi
+++ b/arch/arm/boot/dts/mercury5.dtsi
@@ -5,3 +5,7 @@
  */
 
 #include "mstar-v7.dtsi"
+
+&imi {
+	reg = <0xa0000000 0x20000>;
+};
-- 
2.27.0

