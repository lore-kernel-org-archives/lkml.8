Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F5FC5ED37
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E6C20801
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582813213;
	bh=/mCFG9XO4hu6TS2zQyZ1++jfPLwvNRIBluqoYAVDOUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zwESg3s1NZrvCN+pN6Qto64iOS0D17P1LsRvE72m70jokUVSqTzhE6Lt+yvKayjWZ
	 BvxHUWgsPd0afZ2QlYS5EcVh4RgG8Q1sUgVJ2rzNJ/oCK7AVdZeNlrMmwyEG1rcyj9
	 3W5gUK9fVSL+hJFFyabfeGoUDZNm6631jxaN8Cz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389769AbgB0OUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:20:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:58700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389828AbgB0OSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:18:10 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 621732469D;
        Thu, 27 Feb 2020 14:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582813089;
        bh=/mCFG9XO4hu6TS2zQyZ1++jfPLwvNRIBluqoYAVDOUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uJDn9Spvv6G4H5IZ2ILuJsm0cQkQKqxn18rCgEy1SK+OTrlxRpBS4fvMI9Nss3izY
         tsmj8uM17JfCWU+0EbAnCpWiiCqNjfWuat/SO2avK4a2BwQC2GBZx+KpXN9ls0glae
         kY9BdPbeMPE6VPa0LNxUPM8H6Jp8sW9AjgOldKQ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Amit Kachhap <Amit.Kachhap@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH 5.5 132/150] arm64: lse: Fix LSE atomics with LLVM
Date:   Thu, 27 Feb 2020 14:37:49 +0100
Message-Id: <20200227132251.962200508@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132232.815448360@linuxfoundation.org>
References: <20200227132232.815448360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

commit dd1f6308b28edf0452dd5dc7877992903ec61e69 upstream.

Commit e0d5896bd356 ("arm64: lse: fix LSE atomics with LLVM's integrated
assembler") broke the build when clang is used in connjunction with the
binutils assembler ("-no-integrated-as"). This happens because
__LSE_PREAMBLE is defined as ".arch armv8-a+lse", which overrides the
version of the CPU architecture passed via the "-march" paramter to gas:

$ aarch64-none-linux-gnu-as -EL -I ./arch/arm64/include
                                -I ./arch/arm64/include/generated
                                -I ./include -I ./include
                                -I ./arch/arm64/include/uapi
                                -I ./arch/arm64/include/generated/uapi
                                -I ./include/uapi -I ./include/generated/uapi
                                -I ./init -I ./init
                                -march=armv8.3-a -o init/do_mounts.o
                                /tmp/do_mounts-d7992a.s
/tmp/do_mounts-d7992a.s: Assembler messages:
/tmp/do_mounts-d7992a.s:1959: Error: selected processor does not support `autiasp'
/tmp/do_mounts-d7992a.s:2021: Error: selected processor does not support `paciasp'
/tmp/do_mounts-d7992a.s:2157: Error: selected processor does not support `autiasp'
/tmp/do_mounts-d7992a.s:2175: Error: selected processor does not support `paciasp'
/tmp/do_mounts-d7992a.s:2494: Error: selected processor does not support `autiasp'

Fix the issue by replacing ".arch armv8-a+lse" with ".arch_extension lse".
Sami confirms that the clang integrated assembler does now support the
'.arch_extension' directive, so this change will be fine even for LTO
builds in future.

Fixes: e0d5896bd356cd ("arm64: lse: fix LSE atomics with LLVM's integrated assembler")
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Reported-by: Amit Kachhap <Amit.Kachhap@arm.com>
Tested-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/include/asm/lse.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/include/asm/lse.h
+++ b/arch/arm64/include/asm/lse.h
@@ -6,7 +6,7 @@
 
 #if defined(CONFIG_AS_LSE) && defined(CONFIG_ARM64_LSE_ATOMICS)
 
-#define __LSE_PREAMBLE	".arch armv8-a+lse\n"
+#define __LSE_PREAMBLE	".arch_extension lse\n"
 
 #include <linux/compiler_types.h>
 #include <linux/export.h>


