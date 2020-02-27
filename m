Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A634C3F35E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D6920801
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811259;
	bh=Cha20+Xxu9phiLA7J1NZ6jfSosSBjKixo2UuHu/w2zM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PY518as9WKxTh5SC70g3z6E7jLn1VXGW8tUaI01DyNJEmJFZ2QFRsuB83YALZe40E
	 rZe9R4GA7qUQ5nlm6ZDx/4Dd9e+rNPp1r/Ib4aW8RiD4iWmE1kADMFMUn4/Lv82ZHN
	 g0E5QDKVT9z9AUmGxuMOzof/89LB4RnUkFmVBoL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbgB0Nrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:47:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:44072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730713AbgB0Nrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:47:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCD832468D;
        Thu, 27 Feb 2020 13:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811255;
        bh=Cha20+Xxu9phiLA7J1NZ6jfSosSBjKixo2UuHu/w2zM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PHP6RoQn8NSSZLakDzF1kWv8Z3JdlLrk/cZ8w3gVii8bgI7Pmzrg+WcB+bU3sc03l
         /e5EFGH+nklwdyXTM8PItKpV3b91WMTUdQuhT7BF6nAX99hejzVkaEtAPnoJxihnE2
         7qFRkJnI0M/h/d9YVOMtHJjwjBsSwCM5WgsZ7nUQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 062/165] x86/vdso: Provide missing include file
Date:   Thu, 27 Feb 2020 14:35:36 +0100
Message-Id: <20200227132240.547831980@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132230.840899170@linuxfoundation.org>
References: <20200227132230.840899170@linuxfoundation.org>
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



