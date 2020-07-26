Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F291C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 03:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73EF120674
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 03:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u0X8UPZe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbgGZDMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 23:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbgGZDMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 23:12:02 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD79C0619D2;
        Sat, 25 Jul 2020 20:12:01 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t15so7443951pjq.5;
        Sat, 25 Jul 2020 20:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+hw7WzZZbgQaEWyIpk2cj/jfp3lARlsWpyiskPiV7GE=;
        b=u0X8UPZeNz7uJRw6pJL/3/zx86HWRB37wA23Fb7wVu5U9lyBWYbbnC7dnIJV3XA2pM
         b7wjNCpuinY+7ylwfStg2GMcOfmJJYbYIUOBNvereM6HRVRlMucWdQgyXO7AOrMGsAXC
         qxBlu+qKdAkOciCjVOHeTCe7miRIO3DTMEJIEZ+E/VqN+jV6T91DTc8tdLWjZcbsLsk4
         TiB9Lxzy9G5AJyl6DCuo06pJBcdbwqk3J7zPgIMrw6n+h5+6sACF9g8IBrMmIlq8Ahk0
         sauW5PRerIS73epmLuca+ZciCotgGh+ygT2wM8zTz6Um78hEqef6dA8nuYb4836475nd
         1r1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+hw7WzZZbgQaEWyIpk2cj/jfp3lARlsWpyiskPiV7GE=;
        b=C02aGXZ0qVzkkbsDMYBL4NEWpB0GUq9miGnUcSylHpwJzfhTfINVg99HwZyMp4NR3K
         qSHrX2Z0CcyahOrrIef2rzBOIeAdjK2H/soR94cwdQhvM5T51tMRwLn/BV20Q99QvCbj
         w5xTsDMTIwhCzZKPE9IfeSVOjEoLI75h8uuC97txghJyvAfP9gAYbtW7GkoEzL9IrSVX
         rVjUpAACgZJ1h8nVsyzPEHwUoKsRR+kxoNXc6kJ6k41MUg80LpMTbDp9jmV5MJht/YTq
         KaMgSL+w/f74d7cckRTzRDamNlU9nOADFVrRl0vJmCxyhn1EHctqN0KzUXgAuPHWz/Tn
         JUHA==
X-Gm-Message-State: AOAM532xURiQNTC3AslEl/BGM+YjAmZlNQ6Y5E/9gBX/NfGZxSQsrGQo
        iOO0ZtaRNxH3HWeeuC+yHFoy6TuRiRA=
X-Google-Smtp-Source: ABdhPJy4D9B/SFUcL1mSJGDv3GXYnHNAT2NiFCZAlzAQZPgDRrBHP5E5CCOTospyTMmVlBbmudD0zw==
X-Received: by 2002:a17:90a:e48:: with SMTP id p8mr12372350pja.210.1595733120996;
        Sat, 25 Jul 2020 20:12:00 -0700 (PDT)
Received: from localhost (g155.222-224-148.ppp.wakwak.ne.jp. [222.224.148.155])
        by smtp.gmail.com with ESMTPSA id m9sm9714776pjs.18.2020.07.25.20.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 20:12:00 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Wei Xu <xuwei5@hisilicon.com>,
        John Garry <john.garry@huawei.com>, linux-arch@vger.kernel.org
Subject: [PATCH] io: Fix return type of _inb and _inl
Date:   Sun, 26 Jul 2020 12:11:54 +0900
Message-Id: <20200726031154.1012044-1-shorne@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return type of functions _inb, _inw and _inl are all u16 which looks
wrong.  This patch makes them u8, u16 and u32 respectively.

The original commit text for these does not indicate that these should
be all forced to u16.

Fixes: f009c89df79a ("io: Provide _inX() and _outX()")
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 include/asm-generic/io.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 8b1e020e9a03..30a3aab312e6 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -456,7 +456,7 @@ static inline void writesq(volatile void __iomem *addr, const void *buffer,
 
 #if !defined(inb) && !defined(_inb)
 #define _inb _inb
-static inline u16 _inb(unsigned long addr)
+static inline u8 _inb(unsigned long addr)
 {
 	u8 val;
 
@@ -482,7 +482,7 @@ static inline u16 _inw(unsigned long addr)
 
 #if !defined(inl) && !defined(_inl)
 #define _inl _inl
-static inline u16 _inl(unsigned long addr)
+static inline u32 _inl(unsigned long addr)
 {
 	u32 val;
 
-- 
2.26.2

