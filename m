Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD639C35677
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 968AA21D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811772;
	bh=5V8SWZ6KE+h38jugiRV8yIUeJZVT+9gKHm+N4Sh0huE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vv7X5YBJRM8Hwt4yzO7OW1vfQzfWx3mDqdm2UPXDjCIZKTWrIH9TPUyIZc9y/4irw
	 4DgKsa9CBs5G3+VmhscjTXedYyPaQK+xNR8pA08LXRfaazOxumM20ZAGIekGMZaB5T
	 1mHRO7IcTk1+IAdBr8PfBR3zxFtnxuk1b94bWZbc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731950AbgB0N4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:56:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:56540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732075AbgB0N4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:56:07 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7EF52073D;
        Thu, 27 Feb 2020 13:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811767;
        bh=5V8SWZ6KE+h38jugiRV8yIUeJZVT+9gKHm+N4Sh0huE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TrCOVGfRy1RWlpywu0gzhJX7MDvUUDWXPRWypr4itV20ggdgQlR/b/NvVaC3dHMXJ
         8kxv4IF27pck89xp7i8gOATHmW3UfJnBt22JIBX4Zrlj2Tw75xHE8bYR35Kcnbg0ud
         vEbGguzEpnQD94xVzNj+jaXbPeZjmRa2C6aKl4b0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 093/237] x86/vdso: Provide missing include file
Date:   Thu, 27 Feb 2020 14:35:07 +0100
Message-Id: <20200227132303.854943248@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132255.285644406@linuxfoundation.org>
References: <20200227132255.285644406@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Valdis Klētnieks <valdis.kletnieks@vt.edu>

[ Upstream commit bff47c2302cc249bcd550b17067f8dddbd4b6f77 ]

When building with C=1, sparse issues a warning:

  CHECK   arch/x86/entry/vdso/vdso32-setup.c
  arch/x86/entry/vdso/vdso32-setup.c:28:28: warning: symbol 'vdso32_enabled' was not declared. Should it be static?

Provide the missing header file.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/36224.1575599767@turing-police
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/entry/vdso/vdso32-setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/entry/vdso/vdso32-setup.c b/arch/x86/entry/vdso/vdso32-setup.c
index 42d4c89f990ed..ddff0ca6f5098 100644
--- a/arch/x86/entry/vdso/vdso32-setup.c
+++ b/arch/x86/entry/vdso/vdso32-setup.c
@@ -11,6 +11,7 @@
 #include <linux/smp.h>
 #include <linux/kernel.h>
 #include <linux/mm_types.h>
+#include <linux/elf.h>
 
 #include <asm/processor.h>
 #include <asm/vdso.h>
-- 
2.20.1



