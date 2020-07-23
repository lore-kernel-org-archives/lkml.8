Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679B6C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40F2720737
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLamQXWe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgGWTa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 15:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgGWTa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 15:30:56 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F48C0619DC;
        Thu, 23 Jul 2020 12:30:56 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p3so3666632pgh.3;
        Thu, 23 Jul 2020 12:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=033/koxi8tBQP0JLIdsncSOzrcGFA+WfwhEA16y7708=;
        b=PLamQXWeKF3HJi1PXDCtJy6A79iRX+Ip1qtHibkqeaZY123FqV5BTXB4PMMKTyE6b6
         WZTcJXOsJK3Dnt5mHWp4HSrbHvx/mnvYMMPSmCtV+Io1RKQhVjKsXr15icFI8Yjfgyrl
         C5b6PDZDB9Rjyx92IEPhtPga93oz933lGCWerAzy5fM05nqSDc9cGd5e7+i7wcIa44p9
         fpkCxUxYxrDtrSoZ+SIki43obfwFU4IEHSI5iuwqTEtaXJpzUcXHn7l4U5iND41EgxRM
         Tre2qNjhm+DIqUNeSp+C4vgLjttVGVJm0JZqxOC3LZpGmyWa08frjnkFa+BussN9YWHU
         cJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=033/koxi8tBQP0JLIdsncSOzrcGFA+WfwhEA16y7708=;
        b=MQLPkvhci3FrPs+TU8s60RWMVTMsC7CCUSs5EPd5Ga/Q802fZb8iyQhWxHhncfKink
         frzw666cL+9owMdk2achgh65e8dqDjWPYn+tEcswSlsqlzvOSKB+mvUcoYDzmXf//Zz1
         GPRhza38ml8Pp1qcO6IT4Iw6tbCa3trl8Gavm/h3LYtHSkVFmAMtC19pwb8Km/KGQQL/
         0FoSBey/2i37I/KLcmojpZNkkWeJyGHt1ikgsgB37Z0j1rLT8thYdAS9/f5U36c/j4dk
         3N5K1kwWQ3Ulmi0AVnPNM0a6s1MJJcQVEDDYBxyU5KlPOPvvwjz79rYVdMStON1yar5X
         /xLw==
X-Gm-Message-State: AOAM530mInlvbKkItvrZOBTwXgUdI/Vpm9L36V4mqe6g8k9S7gODFGNh
        rRHiOuxfUCRP1dkm47auJlM=
X-Google-Smtp-Source: ABdhPJzKJfA4dhK77dO73I/iuAhFXaSHyAPIdTCST0mBi74TsxmznFdf57kz/W4DG0JMb6LVZQ6g9g==
X-Received: by 2002:a63:e018:: with SMTP id e24mr5387011pgh.175.1595532656288;
        Thu, 23 Jul 2020 12:30:56 -0700 (PDT)
Received: from nickserv.localdomain (c-98-33-101-203.hsd1.ca.comcast.net. [98.33.101.203])
        by smtp.gmail.com with ESMTPSA id y18sm3794332pff.10.2020.07.23.12.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 12:30:55 -0700 (PDT)
From:   Nick Terrell <nickrterrell@gmail.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>,
        linux-kbuild@vger.kernel.org, x86@kernel.org,
        gregkh@linuxfoundation.org, Petr Malat <oss@malat.biz>,
        Kees Cook <keescook@chromium.org>,
        Kernel Team <Kernel-team@fb.com>,
        Nick Terrell <nickrterrell@gmail.com>,
        Adam Borowski <kilobyte@angband.pl>,
        Patrick Williams <patrickw3@fb.com>, rmikey@fb.com,
        mingo@kernel.org, Patrick Williams <patrick@stwcx.xyz>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Norbert Lange <nolange79@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Xu <alex_y_xu@yahoo.ca>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Terrell <terrelln@fb.com>
Subject: [PATCH v8 7/7] .gitignore: add ZSTD-compressed files
Date:   Thu, 23 Jul 2020 12:28:01 -0700
Message-Id: <20200723192801.351114-8-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200723192801.351114-1-nickrterrell@gmail.com>
References: <20200723192801.351114-1-nickrterrell@gmail.com>
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
index d5f4804ed07c..162bd2b67bdf 100644
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
2.27.0

