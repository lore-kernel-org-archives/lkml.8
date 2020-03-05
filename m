Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8961C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 05:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E9B2072D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 05:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583385707;
	bh=2lUN7ILWaspQY0MJv1l9aakTEzclFQ4lRj4makZ7tLI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=0wuysFBRmTjXjiUC2e2hcGgcryl3Y0nzmc/7s5hkoamhyTnA80hwjdnGwt2/mYOeQ
	 EP32Bwou0i9RYlpZRqZ9L7po5iAavF7XzLzG0TJ5aEpJYuVFKzH05/I58gOeR9jqrW
	 7mVVsqKxVomII/SZ6eLUpJ48R9lwSZ3N+ruvWLOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgCEFVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 00:21:46 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:43948 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgCEFVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 00:21:46 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 0255Kw6j009985;
        Thu, 5 Mar 2020 14:20:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 0255Kw6j009985
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1583385659;
        bh=ZAwmm19S9mp5zDydwDwXfFI6adzi2LMYicgGIC+mmNg=;
        h=From:To:Cc:Subject:Date:From;
        b=SEjTa3Q7PJ9eXfMJ6N/c2+bn6ar/e+qtVUy/ALJyJmVeFIJaEnVRHHTjhH3106hWS
         6NdtdXVXUAM8KT/OcEwOfz/22PR+8f/QukN/FFLGLollrb1nS21rBBNTB5/KDD+Ghf
         VB4sDT7LmawKK7Ux5rAqWOTRZvLC4gS+zvqBuJ+IS8t926PfZ7ti0D4HpED8BxCisv
         WnT8V30HGgyfOfzJx62cuQc/Nagy1Tl6TyeL+MPste2HZY6NtT7lllSgT5/A1x66og
         sN6Dy6PTq1MbSFScDNOIiyKElkHLE+qtXlAD+K53q2gczeqzNSp1BqXkwQUjxuSJhd
         1jmX/3RkvjAQQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Torsten Duwe <duwe@lst.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH] arm64: efi: add efi-entry.o to targets instead of extra-$(CONFIG_EFI)
Date:   Thu,  5 Mar 2020 14:20:52 +0900
Message-Id: <20200305052052.30757-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

efi-entry.o is built on demand for efi-entry.stub.o, so you do not have
to repeat $(CONFIG_EFI) here. Adding it to 'targets' is enough.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/arm64/kernel/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index fc6488660f64..4e5b8ee31442 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -21,7 +21,7 @@ obj-y			:= debug-monitors.o entry.o irq.o fpsimd.o		\
 			   smp.o smp_spin_table.o topology.o smccc-call.o	\
 			   syscall.o
 
-extra-$(CONFIG_EFI)			:= efi-entry.o
+targets			+= efi-entry.o
 
 OBJCOPYFLAGS := --prefix-symbols=__efistub_
 $(obj)/%.stub.o: $(obj)/%.o FORCE
-- 
2.17.1

