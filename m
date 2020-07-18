Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8126C433EB
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 16:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C927E21741
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 16:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4BCEL+3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgGRQvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 12:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbgGRQvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 12:51:40 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4FAC0619D2;
        Sat, 18 Jul 2020 09:51:40 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id o38so9999461qtf.6;
        Sat, 18 Jul 2020 09:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Cc9ZbLWZeNYRvq8MuuIw0ykj3kvA9KHOrY775lBuJk=;
        b=h4BCEL+3oMGF4n+Pj5lHCSopoV6zukiWNIGUdHwitKc+rsqkrLKjDz3cHYQ0Owh+g9
         +Eht/F98gPhF1sPVpG/L2r6szKRLcAcigKY6jOhahIX8JaxHvcQSZAAHk2uunz6QsCmw
         BlFe6lir1fwCiwkEr9qGJ2/4wO3GTbQaBA5Ovs3+68xKpyRh/8e0vz7rCFMFovzcaj4S
         /cFiu0Y8dHJaMRBHuqvhSMOF34T9IYEZdByra4S8+eGQSpp1cQRa52ftFzzvUHZmg/ys
         LU3tF/60uI2bx3qWDHmQChPeVk/R+yHYqHopMwvuO8SvqEoF/7x3pcQbs9e8J1KDrmYA
         /dLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Cc9ZbLWZeNYRvq8MuuIw0ykj3kvA9KHOrY775lBuJk=;
        b=krSh+XALAOop/GhqvzVYV72t+TzYvjlNT6+iR7R8mjLppc3rjhUBayrsHyb137uS0G
         MRFP0D1SfgYlURYTm5bYFdBIxELX13c6wRY4Aud+xklwMUlMpiztOljOnMHRcfDQuU5E
         UVroRvgTe83+0lIn6EiZo25KCBdgIBQJhM8NJCjYK2rGE8dRMG5sco9FtLfpGeUT3ndp
         7hwD402SXBJhWAHIEN13TrVeW5rv34It9NLEV3DHiCOtYA8Aa+crhRgz5cdwk5OnkY5N
         Dh9Wrv/ETOAs9FbKhHk9bkZ4JTqk4koz5JLL5scSurzXNVF4hmPLuwY9ZvkMPFKD0b5k
         /J3g==
X-Gm-Message-State: AOAM531iuH+77B7XISXH2l/uIhpxC0N11iruzV+u+1V6BHPmyYD6jc++
        9aOBZA73HgKDBkHT7huc3W4=
X-Google-Smtp-Source: ABdhPJzB4kunyqpTxMdrQI6W/O+Ta/CJPMSgWzpPN2+gMPb1IAwwmDewlFP7WVFajic3pqDXEq71Jg==
X-Received: by 2002:ac8:4806:: with SMTP id g6mr15052147qtq.213.1595091099469;
        Sat, 18 Jul 2020 09:51:39 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:602d:16d:d038:1a92:190d:65d2])
        by smtp.gmail.com with ESMTPSA id q5sm15361801qtf.12.2020.07.18.09.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 09:51:38 -0700 (PDT)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, gregkh@linuxfoundation.org,
        tyhicks@canonical.com, jpoimboe@redhat.com, jkosina@suse.cz,
        tglx@linutronix.de, keescook@chromium.org, steve@sk2.org
Cc:     "Daniel W . S . Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, clang-built-linux@googlegroups.com
Subject: [PATCH] docs: process/index.rst: Fix reference to nonexistent document
Date:   Sat, 18 Jul 2020 13:50:59 -0300
Message-Id: <20200718165107.625847-5-dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200718165107.625847-1-dwlsalmeida@gmail.com>
References: <20200718165107.625847-1-dwlsalmeida@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel W. S. Almeida <dwlsalmeida@gmail.com>

Fix the following warning:

WARNING: toctree contains reference to nonexistent document
'process/unaligned-memory-access'

The path to the document was wrong.

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 Documentation/process/index.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/index.rst b/Documentation/process/index.rst
index f07c9250c3acb..dd231ffc8422d 100644
--- a/Documentation/process/index.rst
+++ b/Documentation/process/index.rst
@@ -32,7 +32,7 @@ Below are the essential guides that every developer should read.
    kernel-enforcement-statement
    kernel-driver-statement
 
-Other guides to the community that are of interest to most developers are: 
+Other guides to the community that are of interest to most developers are:
 
 .. toctree::
    :maxdepth: 1
@@ -61,7 +61,7 @@ lack of a better place.
    botching-up-ioctls
    clang-format
    ../riscv/patch-acceptance
-   unaligned-memory-access
+   ../core-api/unaligned-memory-access
 
 .. only::  subproject and html
 
-- 
2.27.0

