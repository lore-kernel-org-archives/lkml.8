Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8181FC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 12:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57C9E207FB
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 12:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbcF8bcl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387677AbgEXMgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 08:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgEXMf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 08:35:59 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F339C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 05:35:59 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id x20so17852284ejb.11
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 05:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XKDhsQ5sTY9fRZdUNyusZ0FDVI/AcG2vut+gn5kNrHM=;
        b=hbcF8bclIaz/TiOQjjoaTSqfCFG98h+14xlDBvAIVi69diKFdF98taSitLT+iakQLE
         MN2kKGjDdwqWvwByb9IsGy8fImecckucu0LD292qlbCxLLd47QaLZmZYZd4zOLLriraA
         xn9ixkfUaEpnrEeBxwMqYWvrR2SYsBEaqj/ZOF3sVTd64mlaImg+ABJakgNszPBXBZ8I
         mol3PPkVz5HvjCLW8yaiQRny3VtsTgPH9+7pquQUD9l/Bb5r694Awi0l8YAN8AOXLbiy
         Ykpc9v/VO8OP3SWhUrek8YiRjezFnt67V4gLocw8ROrh2miZeYZ/XEKNTaYm3UVGECnr
         2MjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XKDhsQ5sTY9fRZdUNyusZ0FDVI/AcG2vut+gn5kNrHM=;
        b=q/7wl+wssp1wHRBN9n91WCaYCUQYfG2JrSOhy7NzqMp7gUK9ZladZFa4y3kqEcthEX
         uD1ldNRlVljwzvSKeCckBn0vzSVvldkuxTKFIZp/4NskEYQxAH7knuWhHtpgEspkODiI
         ty3I+AbAZuSImbsecwn9J+9NimQUlGmffLZ3Fm3EApNFdAsz8fjw9cQWuOJvge33Fc+w
         dkP/VGEy48+rooVZXczyr1+V9WrJuqR/1kG3pkDy2zKF8s/XpTRPdgZbpMF1f1ZHtVPe
         v/ocIRbi4TMrNakJ0RH4+1PMGU32Bn2eN27DoUEg70bCv/z0iA90niaWM5zFPddIJBKO
         sWjA==
X-Gm-Message-State: AOAM533NbONKZdXoaw+QMo0l9SqahsrcpjZIyspSrLnlMKCbA4TPbFLz
        ioFoTVkmmg9BuivRwTIqK8w=
X-Google-Smtp-Source: ABdhPJx7RyNKByMHmnXjYHF5JyQKBOqZ1fiRHWxReCQvA+g8GxzabFTCSKBq0ZElGjH9sXgodkYlVw==
X-Received: by 2002:a17:907:11cb:: with SMTP id va11mr16010089ejb.515.1590323758211;
        Sun, 24 May 2020 05:35:58 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id r13sm1842806edq.53.2020.05.24.05.35.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 May 2020 05:35:57 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        christian.brauner@ubuntu.com
Cc:     linux-kernel@vger.kernel.org, Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH] bitops: simplify get_count_order_long()
Date:   Sun, 24 May 2020 12:35:51 +0000
Message-Id: <20200524123551.9469-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two cases could be unified into one.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 include/linux/bitops.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 9acf654f0b19..5b5609e81a84 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -206,10 +206,7 @@ static inline int get_count_order_long(unsigned long l)
 {
 	if (l == 0UL)
 		return -1;
-	else if (l & (l - 1UL))
-		return (int)fls_long(l);
-	else
-		return (int)fls_long(l) - 1;
+	return (int)fls_long(--l);
 }
 
 /**
-- 
2.23.0

