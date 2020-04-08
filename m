Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A79C2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 21:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2960520753
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 21:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaADSuI6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgDHV41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 17:56:27 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38207 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgDHV4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 17:56:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id p8so523152pgi.5;
        Wed, 08 Apr 2020 14:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PnIiwmTSVZMRtxsSOYRF7NKqNHugp52gwHRr9w8GaRc=;
        b=aaADSuI6TXoHE+iOPGDU4mEv7HZKcuE817g0U7W2c4POu04XkY+UF8Q62HT4X8V4Pc
         +u8ySTeSl4ldzMiS/XsLmRWdB3iiFi1gS/seN33nWT2MeAcR/D8Io0SviquIr9tQ6Lwr
         7nMNj0/J8h3LtQgveeZPzTUEG/Qn1Hc4xnsBesCr+QOHRuhjWEoH2GPFBRLP7Zcgeu7Z
         65QsiNotPKD2cTmF+V2xdr4RYXq5szsOxZaAfy5HJfGcENYm4kolCK4EEgptnaur5vrs
         MPoPulZyS/AcHaItFyiDWBEebwl04Ye77x5hUbwws9BKA2u+DETXifDIaeSu596WEDZU
         0Kwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PnIiwmTSVZMRtxsSOYRF7NKqNHugp52gwHRr9w8GaRc=;
        b=Le7WI88sHO1JfP6WTbsJQxssOic7qVAr62L5NnZPd08o/SdRvkJHRp8zPfnmDnHSrz
         0fIoAjzI3DzwGuPzTnbH6FcSv4gspIwEA5YCAeberfoRHbuk7Jr/17RxGjMuKI+hsSIK
         DV5SWe7iYP02ApPU83EHKYs83OTNQU45AHiEQMD1u2nam63UK25xzXuBEcHKMZeOb/5y
         4Fr53/VRgXycdK/hoQ+kIew+/atyBpz820SrlOp4wuUEE04i3AWD5pCxxyCFNDq+3426
         iOOICXkfEW9Oku9V9QggUJGYpbHByXO7T88RHK3fqt960ri0HDMvDgwtd+dfJSKrBnGw
         AHNQ==
X-Gm-Message-State: AGi0PuZZl/YFC/jQ/pk3UO+Bi4ZWi9g2HPS3oFZA11xDBgFdJzCwS6L9
        XqXAjBW+g6Sk/HtIOWOF0vI=
X-Google-Smtp-Source: APiQypLnT/F6Iqwegdn2VK0Dk2tonnaHWUkfXWT47civ/UTMena7uQDibcwFTXt2033nbINQgU2QwA==
X-Received: by 2002:a62:64d5:: with SMTP id y204mr9587296pfb.227.1586382983398;
        Wed, 08 Apr 2020 14:56:23 -0700 (PDT)
Received: from nickserv.localdomain (c-73-222-55-223.hsd1.ca.comcast.net. [73.222.55.223])
        by smtp.gmail.com with ESMTPSA id ci13sm459604pjb.16.2020.04.08.14.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 14:56:22 -0700 (PDT)
From:   Nick Terrell <nickrterrell@gmail.com>
To:     Nick Terrell <terrelln@fb.com>
Cc:     linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>,
        linux-kbuild@vger.kernel.org, x86@kernel.org,
        gregkh@linuxfoundation.org, Petr Malat <oss@malat.biz>,
        Kees Cook <keescook@chromium.org>,
        Kernel Team <Kernel-team@fb.com>,
        Nick Terrell <nickrterrell@gmail.com>,
        Adam Borowski <kilobyte@angband.pl>,
        Patrick Williams <patrickw3@fb.com>, rmikey@fb.com,
        mingo@kernel.org, Patrick Williams <patrick@stwcx.xyz>,
        Sedat Dilek <sedat.dilek@gmail.com>
Subject: [PATCH v5 8/8] .gitignore: add ZSTD-compressed files
Date:   Wed,  8 Apr 2020 14:57:11 -0700
Message-Id: <20200408215711.137639-9-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200408215711.137639-1-nickrterrell@gmail.com>
References: <20200408215711.137639-1-nickrterrell@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adam Borowski <kilobyte@angband.pl>

For now, that's arch/x86/boot/compressed/vmlinux.bin.zst but probably more
will come, thus let's be consistent with all other compressors.

Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Nick Terrell <terrelln@fb.com>
Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 2258e906f01c..23871de69072 100644
--- a/.gitignore
+++ b/.gitignore
@@ -44,6 +44,7 @@
 *.tab.[ch]
 *.tar
 *.xz
+*.zst
 Module.symvers
 modules.builtin
 modules.order
-- 
2.26.0

