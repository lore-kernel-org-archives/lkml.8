Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF955C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6C72080C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584624441;
	bh=OrkMEH63HQ57aeJwplbioe6HOa1klsRlnvHjGTqwtE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P0zWBrTg7Weg6hzCEbUyA4JBXfyAW5JQQsud4Oug15941jcUy0Vt+FHfKBFzM1MOo
	 cwiHtQ+lz/YylnYgHKTwHMbfUUTh2QOVGboaWPVfGfaq4iNxLhdJM1Sf2XfIHQQ51Q
	 4D2OfvfsK7OcJqsuVAkZ0wGkSMvcLxokY8Cuvz0M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730636AbgCSN1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:27:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730746AbgCSN1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:27:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 006B32080C;
        Thu, 19 Mar 2020 13:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584624437;
        bh=OrkMEH63HQ57aeJwplbioe6HOa1klsRlnvHjGTqwtE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JzVdEE0TzxaYAdmreCPfVmPmqJLccbGtmJ8d4Fzw7nRAzvEkJEs5mSOMurdeb1+Br
         Kk9UapQstvsAJwvzxZ1mBWf62l5Fy77qtluh0O1Zkx3GCAKYhE+D8Pgf7npJLFnL+S
         32ruzddvnl2uRHT1oD6jIy/0nt8QhYFBEXt1ZXVM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 5.5 60/65] ARM: 8958/1: rename missed uaccess .fixup section
Date:   Thu, 19 Mar 2020 14:04:42 +0100
Message-Id: <20200319123945.150112169@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123926.466988514@linuxfoundation.org>
References: <20200319123926.466988514@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

commit f87b1c49bc675da30d8e1e8f4b60b800312c7b90 upstream.

When the uaccess .fixup section was renamed to .text.fixup, one case was
missed. Under ld.bfd, the orphaned section was moved close to .text
(since they share the "ax" bits), so things would work normally on
uaccess faults. Under ld.lld, the orphaned section was placed outside
the .text section, making it unreachable.

Link: https://github.com/ClangBuiltLinux/linux/issues/282
Link: https://bugs.chromium.org/p/chromium/issues/detail?id=1020633#c44
Link: https://lore.kernel.org/r/nycvar.YSQ.7.76.1912032147340.17114@knanqh.ubzr
Link: https://lore.kernel.org/lkml/202002071754.F5F073F1D@keescook/

Fixes: c4a84ae39b4a5 ("ARM: 8322/1: keep .text and .fixup regions closer together")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/lib/copy_from_user.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/lib/copy_from_user.S
+++ b/arch/arm/lib/copy_from_user.S
@@ -118,7 +118,7 @@ ENTRY(arm_copy_from_user)
 
 ENDPROC(arm_copy_from_user)
 
-	.pushsection .fixup,"ax"
+	.pushsection .text.fixup,"ax"
 	.align 0
 	copy_abort_preamble
 	ldmfd	sp!, {r1, r2, r3}


