Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4809BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 275C4221F9
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592444146;
	bh=YPvB/UVTTNOlO5+VGInzT9x0BmqbR/P5AtA7zUkZ0g0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RVZYHYy0LdjT1BOXQlH3eeRKYXIrW4cMtmeq1rhR2tXDunK0CvHaXOyxPIkCwbDy4
	 m2UovzwpCFO6bQfDhngJdQwlzT7shGlWT32ce6JW/7NET1yZj7uwfCP1mMJGU8uKt7
	 PlSNgQquWfpC19pmhzWUrc6Qj2z6BlwVuUoA9tmU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731237AbgFRBfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:35:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:42032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732075AbgFRBbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:31:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E7842225B;
        Thu, 18 Jun 2020 01:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443880;
        bh=YPvB/UVTTNOlO5+VGInzT9x0BmqbR/P5AtA7zUkZ0g0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t1aLcRWtqCFxxhxGm2FeXCUIITExNcqhQhGDQo4PuDqj2q9BP113khD43LwmJgNKx
         kxCg11tSakROBCIj98ehG17i1Rrr+aiWP50dxdviqimP88XPHspjOw59YCB9sQzexx
         Owt8YxswtfrMHhD6sGq8AWgXsGjrfEjcNtjS0qdo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Fangrui Song <maskray@google.com>,
        Jeremy Fitzhardinge <jeremy@goop.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>,
        clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 4.4 58/60] elfnote: mark all .note sections SHF_ALLOC
Date:   Wed, 17 Jun 2020 21:30:02 -0400
Message-Id: <20200618013004.610532-58-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618013004.610532-1-sashal@kernel.org>
References: <20200618013004.610532-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Desaulniers <ndesaulniers@google.com>

[ Upstream commit 51da9dfb7f20911ae4e79e9b412a9c2d4c373d4b ]

ELFNOTE_START allows callers to specify flags for .pushsection assembler
directives.  All callsites but ELF_NOTE use "a" for SHF_ALLOC.  For vdso's
that explicitly use ELF_NOTE_START and BUILD_SALT, the same section is
specified twice after preprocessing, once with "a" flag, once without.
Example:

.pushsection .note.Linux, "a", @note ;
.pushsection .note.Linux, "", @note ;

While GNU as allows this ordering, it warns for the opposite ordering,
making these directives position dependent.  We'd prefer not to precisely
match this behavior in Clang's integrated assembler.  Instead, the non
__ASSEMBLY__ definition of ELF_NOTE uses
__attribute__((section(".note.Linux"))) which is created with SHF_ALLOC,
so let's make the __ASSEMBLY__ definition of ELF_NOTE consistent with C
and just always use "a" flag.

This allows Clang to assemble a working mainline (5.6) kernel via:
$ make CC=clang AS=clang

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Fangrui Song <maskray@google.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/913
Link: http://lkml.kernel.org/r/20200325231250.99205-1-ndesaulniers@google.com
Debugged-by: Ilie Halip <ilie.halip@gmail.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/elfnote.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/elfnote.h b/include/linux/elfnote.h
index 278e3ef05336..56c6d9031663 100644
--- a/include/linux/elfnote.h
+++ b/include/linux/elfnote.h
@@ -53,7 +53,7 @@
 .popsection				;
 
 #define ELFNOTE(name, type, desc)		\
-	ELFNOTE_START(name, type, "")		\
+	ELFNOTE_START(name, type, "a")		\
 		desc			;	\
 	ELFNOTE_END
 
-- 
2.25.1

