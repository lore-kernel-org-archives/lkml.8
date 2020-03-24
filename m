Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8ACC2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A0E206F6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585056463;
	bh=Dx6k0GLLmgPCqWvaZNBL/L4NZ2kAZQoCDGH+zulMf1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=irRYmfbbn5jn8CyIT52zx0m0VT03Fxx+MkCV4+QDT07nthCn7QhffR161xiMl6mVV
	 /ETbLlckVB0YgXQo1LNHjfKHwT7JQOS2Ct9cgyc/S+hdTC44lrJiaz37IU0acsW8Ra
	 vqdxVWY6rQhQkI/XrR6ex6W+PrfD6VaBRoTouU1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbgCXN1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:27:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:53248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729952AbgCXN1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:27:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23D9C206F6;
        Tue, 24 Mar 2020 13:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585056453;
        bh=Dx6k0GLLmgPCqWvaZNBL/L4NZ2kAZQoCDGH+zulMf1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NDtkkNdd5GQ2RJiw7Lzz1iK7GOEc8GPkMXgqJWqVYnS+XCdwTAge16Jp9EFPg6bbZ
         2idWWMg95GI7fVHDH0dmfz90rn0oD++wE3py0GibUDOAw6V3Zlv1tsT3Ib0cI1P6H1
         e5LEkybkJ7mU2o7RkjMfWKK9Im6tC9JlI7t29o4A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 5.5 086/119] arm64: compat: Fix syscall number of compat_clock_getres
Date:   Tue, 24 Mar 2020 14:11:11 +0100
Message-Id: <20200324130816.836640833@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324130808.041360967@linuxfoundation.org>
References: <20200324130808.041360967@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

commit 3568b88944fef28db3ee989b957da49ffc627ede upstream.

The syscall number of compat_clock_getres was erroneously set to 247
(__NR_io_cancel!) instead of 264. This causes the vDSO fallback of
clock_getres() to land on the wrong syscall for compat tasks.

Fix the numbering.

Cc: <stable@vger.kernel.org>
Fixes: 53c489e1dfeb6 ("arm64: compat: Add missing syscall numbers")
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/include/asm/unistd.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -25,8 +25,8 @@
 #define __NR_compat_gettimeofday	78
 #define __NR_compat_sigreturn		119
 #define __NR_compat_rt_sigreturn	173
-#define __NR_compat_clock_getres	247
 #define __NR_compat_clock_gettime	263
+#define __NR_compat_clock_getres	264
 #define __NR_compat_clock_gettime64	403
 #define __NR_compat_clock_getres_time64	406
 


