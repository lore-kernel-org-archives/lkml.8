Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D46C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54E5220786
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587045779;
	bh=mDp69Lb0S9CHcaaZ0egFJJ01Dml5CiR2KtDUpVg1cCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cSrURFMtqy3WXGcPoz6Ylr04TCOZBo3Qgv+Zjk04s4OmnAEsK7DttBtCiGtr1tydI
	 hnkGUQ1yk29vBA6AZsugC/zccoKDonl56KPN2k78whjslJr5GZdRGJNW3S0QyqawXz
	 j7e0lg+R68Aj7vwY93geWxS1xlNbaa1HIOP4nd3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409659AbgDPOC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:02:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:54776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389073AbgDPNlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:41:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 032422223E;
        Thu, 16 Apr 2020 13:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044510;
        bh=mDp69Lb0S9CHcaaZ0egFJJ01Dml5CiR2KtDUpVg1cCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jbn2uPwD8XHh/5Xa8HhIsEHsmSJktJqKzMQ9nXFRhS2LlnZrLN/FGSRhp1H6gKDOk
         F5+7Mc15xpMSthE4zPC+IdGVAkabihh6bBeUn8CIglXhfduHrXR+wXawJAOA/YoSoK
         mcaEfbWLtkzH9ApY/q18eHMMgwQOYvtnSfiEZbbA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 5.5 245/257] arm64: Always force a branch protection mode when the compiler has one
Date:   Thu, 16 Apr 2020 15:24:56 +0200
Message-Id: <20200416131356.363859412@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.891903893@linuxfoundation.org>
References: <20200416131325.891903893@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Brown <broonie@kernel.org>

commit b8fdef311a0bd9223f10754f94fdcf1a594a3457 upstream.

Compilers with branch protection support can be configured to enable it by
default, it is likely that distributions will do this as part of deploying
branch protection system wide. As well as the slight overhead from having
some extra NOPs for unused branch protection features this can cause more
serious problems when the kernel is providing pointer authentication to
userspace but not built for pointer authentication itself. In that case our
switching of keys for userspace can affect the kernel unexpectedly, causing
pointer authentication instructions in the kernel to corrupt addresses.

To ensure that we get consistent and reliable behaviour always explicitly
initialise the branch protection mode, ensuring that the kernel is built
the same way regardless of the compiler defaults.

[This is a reworked version of b8fdef311a0bd9223f1075 ("arm64: Always
force a branch protection mode when the compiler has one") for backport.
Kernels prior to 74afda4016a7 ("arm64: compile the kernel with ptrauth
return address signing") don't have any Makefile machinery for forcing
on pointer auth but still have issues if the compiler defaults it on so
need this reworked version. -- broonie]

Fixes: 7503197562567 (arm64: add basic pointer authentication support)
Reported-by: Szabolcs Nagy <szabolcs.nagy@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
[catalin.marinas@arm.com: remove Kconfig option in favour of Makefile check]
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/Makefile |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -72,6 +72,10 @@ stack_protector_prepare: prepare0
 					include/generated/asm-offsets.h))
 endif
 
+# Ensure that if the compiler supports branch protection we default it
+# off.
+KBUILD_CFLAGS += $(call cc-option,-mbranch-protection=none)
+
 ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
 KBUILD_CPPFLAGS	+= -mbig-endian
 CHECKFLAGS	+= -D__AARCH64EB__


