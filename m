Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E316AC83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 09:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5AFE2053B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 09:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o0eS6a4Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgD1JS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 05:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726896AbgD1JS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 05:18:28 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682A4C03C1A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 02:18:28 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id e6so861197pjt.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 02:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0Em04UA/LNcN7O3epZlicZOW4v1ayywcrAiq1IjpMWU=;
        b=o0eS6a4YlVDqCMQbAdFr0rhFPJcOI8la8r53buSeaYmNpOKs8r8Tvo3vz9HHoFR+JN
         Nrn4KVLGdSOp85P0eyBHBNSh/4Eu4Po/8mk+tX1DJ4ZiPW8nUm0e9DXzxwTU0PqmvDxQ
         qLXrl2kADSlWYMA64s9Tez4ysJj9k8pZpR6n05U5iC8J/n759jdexaygbjD37rHsfQMQ
         eHsVeF9rBcNDNO2LUPrHB+c4MnbiG8hB7fl//IfUPuP0rXUdWhk8NuWjvvgozdv7ScCR
         /olLOXqpPKBDAA5118tMMJ2xbVk/WHuBi7wQgLUjE0u3S4v7CeQTZ2TqPJjGsWYuXij9
         x/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0Em04UA/LNcN7O3epZlicZOW4v1ayywcrAiq1IjpMWU=;
        b=qJibWxn+A5waTb8PqqWM5TGTUJ3OwrAyTW36WAu1sdJgrqB1ug/MX+Xa+hkHZ3Ey3U
         TRXLMk1mnzFBjn9x1wFmLjh8Ta5njx+383RvS9s5IjsdeMzcES9jPObWYzBeCNCJUlos
         EHMzVakKkqu5j7usQhsp+hp2+gVzGhNZ2/774N2FqbI4e5KHCbNwE5bMXCEE4kw1htFW
         zsmhmmDkx3rwKi6bz04fQTP5dAbyAUKsbVVCAC6kH5ZXmq2hxkTXOgmUUF0hAh+ArcVk
         t+qkK/y7Bmd3ZmQvy0YQsQbQszf//bRT22Za+QnW4BpgpskMa7cqgfGrJmrF4U9Gw8uI
         fypA==
X-Gm-Message-State: AGi0Pub+0hw2pBYkdzrDXYZ/pX2wP6ZPePWl/uebcJK3O7fdtUNZI0Yy
        36XaifeH3nPmBY6L7buBCyA=
X-Google-Smtp-Source: APiQypJOdw+4aGwEWl/mmpSmW0vaZMwfXEkiOnl4FJ8NhqKoLoOePed07PmfAtklxOt3OY2h7RUL7w==
X-Received: by 2002:a17:902:6b4a:: with SMTP id g10mr6134305plt.141.1588065508022;
        Tue, 28 Apr 2020 02:18:28 -0700 (PDT)
Received: from software.domain.org (28.144.92.34.bc.googleusercontent.com. [34.92.144.28])
        by smtp.gmail.com with ESMTPSA id m7sm14853596pfb.48.2020.04.28.02.18.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 02:18:27 -0700 (PDT)
From:   Liangliang Huang <huanglllzu@gmail.com>
X-Google-Original-From: Liangliang Huang <huangll@lemote.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Huacai Chen <chenhuacai@gmail.com>,
        Liangliang Huang <huanglllzu@gmail.com>,
        linux-kernel@vger.kernel.org, Liangliang Huang <huangll@lemote.com>
Subject: [PATCH] include/bitmap.h: add the type of the nbits parameter in bitmap_empty()
Date:   Tue, 28 Apr 2020 17:18:11 +0800
Message-Id: <1588065491-27292-1-git-send-email-huangll@lemote.com>
X-Mailer: git-send-email 2.7.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The type of parameter in bitmap_empty() is lack. In order to
keep context consistent, so add the type of the parameter in
bitmap_empty().

Signed-off-by: Liangliang Huang <huangll@lemote.com>
---
 include/linux/bitmap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 99058eb..768f7b7 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -379,7 +379,7 @@ static inline int bitmap_subset(const unsigned long *src1,
 		return __bitmap_subset(src1, src2, nbits);
 }
 
-static inline int bitmap_empty(const unsigned long *src, unsigned nbits)
+static inline int bitmap_empty(const unsigned long *src, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		return ! (*src & BITMAP_LAST_WORD_MASK(nbits));
-- 
2.7.0

