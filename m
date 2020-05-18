Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB365C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E18B20849
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589823811;
	bh=zyeyKeHzoQB4z3mEqUUGw7iDBKNzKrBvabHIzqeR+HI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mCqxJuTc8O4AKS4++c00lTTyo27Wh0CTGIJCdfAyqVFFrvO0G+M+TnhAqLUxQClNU
	 15xNqcfqheC63SRrGjlXnY0QApraNbfnS1JKgu/SdcTJSKI+e6H5gHcRSL2aHFuwTq
	 gTQK+V+KVo40J0HPf+dUSkLXQNdL3BLF1gyd2puI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbgERRna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:43:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729567AbgERRnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:43:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F246D20715;
        Mon, 18 May 2020 17:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589823803;
        bh=zyeyKeHzoQB4z3mEqUUGw7iDBKNzKrBvabHIzqeR+HI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rQV7iuwdUadOMyaJcGYp0TgUzKtSestv/llfF6vr9gIsGvyShKW9zHiO0ifkNCZBb
         /TCnnWMcQWWBFMlnWCw0+ZXSiPScmkKmj8+AJypJoDczLCi/6jiM9zISA07wIoJ6Om
         ak5FHKCkroJWuOr+ixWD3obQLGTTF0DIS1FwVq/E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Richard Kojedzinszky <richard@kojedz.in>
Subject: [PATCH 4.9 25/90] binfmt_elf: Do not move brk for INTERP-less ET_EXEC
Date:   Mon, 18 May 2020 19:36:03 +0200
Message-Id: <20200518173456.322832435@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173450.930655662@linuxfoundation.org>
References: <20200518173450.930655662@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

commit 7be3cb019db1cbd5fd5ffe6d64a23fefa4b6f229 upstream.

When brk was moved for binaries without an interpreter, it should have
been limited to ET_DYN only. In other words, the special case was an
ET_DYN that lacks an INTERP, not just an executable that lacks INTERP.
The bug manifested for giant static executables, where the brk would end
up in the middle of the text area on 32-bit architectures.

Reported-and-tested-by: Richard Kojedzinszky <richard@kojedz.in>
Fixes: bbdc6076d2e5 ("binfmt_elf: move brk out of mmap when doing direct loader exec")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/binfmt_elf.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1107,7 +1107,8 @@ static int load_elf_binary(struct linux_
 		 * (since it grows up, and may collide early with the stack
 		 * growing down), and into the unused ELF_ET_DYN_BASE region.
 		 */
-		if (IS_ENABLED(CONFIG_ARCH_HAS_ELF_RANDOMIZE) && !interpreter)
+		if (IS_ENABLED(CONFIG_ARCH_HAS_ELF_RANDOMIZE) &&
+		    loc->elf_ex.e_type == ET_DYN && !interpreter)
 			current->mm->brk = current->mm->start_brk =
 				ELF_ET_DYN_BASE;
 


