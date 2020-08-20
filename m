Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F215C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D17A20738
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597925883;
	bh=G+G+Ym26cq/41gK660ylSESL4nMsWXnY8y2UDQq+AgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xxNSg/TPnlLSQfXynSJVlYkJPSuY1YxcERY2dDwSwYoqp9bQXD0SHgk2E9dM6ALF9
	 UIsCMYH5UbKZ+2jFkAvRzOUUCUdU6Sn1iiVGk4d0E4ibSJZfEI4TL1tvjssKfYPMpp
	 Wze4eGJWFLD+CNufiz3pAt2iY6BSGmn2GjgrcW6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbgHTMR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:17:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730230AbgHTJ4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:56:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BBC820885;
        Thu, 20 Aug 2020 09:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917395;
        bh=G+G+Ym26cq/41gK660ylSESL4nMsWXnY8y2UDQq+AgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l1kJ5z9vR51mVmXkSPPyhI8cAk0QMZTjov4SF4dp/eYl6rVVr9hqT4P36PYP3TYfu
         eRiFJvmneoU5sGpOoNU28nQmtbNOlMSwFvhcjZRGHphTQ9UqL3US5Ifm8OfZc1ru5n
         Ibm+LgdQro8Xiu49B0nJg7vRXOP1vLbvFIIM82DA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 017/212] x86/build/lto: Fix truncated .bss with -fdata-sections
Date:   Thu, 20 Aug 2020 11:19:50 +0200
Message-Id: <20200820091603.210193271@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091602.251285210@linuxfoundation.org>
References: <20200820091602.251285210@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sami Tolvanen <samitolvanen@google.com>

[ Upstream commit 6a03469a1edc94da52b65478f1e00837add869a3 ]

With CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y, we compile the kernel with
-fdata-sections, which also splits the .bss section.

The new section, with a new .bss.* name, which pattern gets missed by the
main x86 linker script which only expects the '.bss' name. This results
in the discarding of the second part and a too small, truncated .bss
section and an unhappy, non-working kernel.

Use the common BSS_MAIN macro in the linker script to properly capture
and merge all the generated BSS sections.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20190415164956.124067-1-samitolvanen@google.com
[ Extended the changelog. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/vmlinux.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 097268f85e4ee..0df44e4fe7cb1 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -329,7 +329,7 @@ SECTIONS
 	.bss : AT(ADDR(.bss) - LOAD_OFFSET) {
 		__bss_start = .;
 		*(.bss..page_aligned)
-		*(.bss)
+		*(BSS_MAIN)
 		. = ALIGN(PAGE_SIZE);
 		__bss_stop = .;
 	}
-- 
2.25.1



