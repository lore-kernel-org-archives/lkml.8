Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518BBC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD61247A8
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581697486;
	bh=Cha20+Xxu9phiLA7J1NZ6jfSosSBjKixo2UuHu/w2zM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CaqMLXX4YLv+ceqrf1uz+BEpSZr1YOciKzNQzH7CrrR7btD4Ud9yYvrg9GJUqEjny
	 h4LymlV05ooAIARPX0w/DEx0haTJqDA/x9vfw+PLf7jMnWdTFwDwc5wLeKowbG+kl+
	 d5Sikg1BlF+DkHSOjX+NXEqOK1WR799NJrbE+yYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405430AbgBNQYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:24:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:58846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388857AbgBNQW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:22:56 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 632DC24761;
        Fri, 14 Feb 2020 16:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697375;
        bh=Cha20+Xxu9phiLA7J1NZ6jfSosSBjKixo2UuHu/w2zM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=erqaafAFAR57He9NWgnrc+gCDapy+CbUNa6xoewwFQ3mltK7/gT1pYobAG+z+5hGR
         xaxF2sfEW45aTybanJXJ3mKszQ99JfKrX3Gnsm/uo/KHjMmGZjP7P5xvaB5EotkjYG
         1FJuH5Vs3zHZS0c4EMRI8Fi9Mhz4xy7D/b+5xfew=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Valdis=20Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 073/141] x86/vdso: Provide missing include file
Date:   Fri, 14 Feb 2020 11:20:13 -0500
Message-Id: <20200214162122.19794-73-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214162122.19794-1-sashal@kernel.org>
References: <20200214162122.19794-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 3f9d1a83891ad..50c1f77cab150 100644
--- a/arch/x86/entry/vdso/vdso32-setup.c
+++ b/arch/x86/entry/vdso/vdso32-setup.c
@@ -10,6 +10,7 @@
 #include <linux/smp.h>
 #include <linux/kernel.h>
 #include <linux/mm_types.h>
+#include <linux/elf.h>
 
 #include <asm/processor.h>
 #include <asm/vdso.h>
-- 
2.20.1

