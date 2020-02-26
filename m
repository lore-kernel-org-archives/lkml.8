Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E276FC4BA21
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF85A24670
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbgBZVum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 16:50:42 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42717 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727503AbgBZVum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 16:50:42 -0500
Received: by mail-qk1-f196.google.com with SMTP id o28so1104740qkj.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 13:50:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bVvtoF3dBwjUAYtU4MtEeTRU2gPLqCEKNNfUILCYJ2w=;
        b=kGMXdz8RsI8BmUG5Z5gl5QRP+Bd48MZg+8N9So7ujcCno6UgK+3a8HqpIvbXl2SC6/
         bamzBRZWzCuGtRqYCEPdlUEbEQkdq1s/qVjOsPjiLTlRGhRHdkMzYTt9k5VdK0HSz1j6
         35mGRRjwu2JdhVCEresCRwoW/RDlf6l3af3/0DW4HQ6AmeFIHebZBGDDMONW5BSkB48v
         jNfJln14QANgjYgdurlWIshvnZ2bA5WreUfdGt67S88fWEfNMyrIeMsTlR1TiZYTfwm3
         cGlevCt9h4fAt5baN3zS1kPPqzd4rZTcZfR6k08XIsI6iSL4JEO0zd5OzG7XjlBXpy1d
         vw6Q==
X-Gm-Message-State: APjAAAXPq6I5hrBTPWaRLu3zuqpQXE7wQ24xAIROzjxm1GnCpaUzw8RD
        KPeFFSTEjEmceWFyDm9LqrE=
X-Google-Smtp-Source: APXvYqx8UV8YjcThLwuE4pseSIhWF+wgUfrcRuFfFy2RgtZSG7vFhqozsjyBFIY3a73ZGyacvn9lUA==
X-Received: by 2002:a37:4e97:: with SMTP id c145mr1416125qkb.253.1582753841181;
        Wed, 26 Feb 2020 13:50:41 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id y62sm1877659qka.19.2020.02.26.13.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 13:50:40 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     "Tobin C . Harding" <me@tobin.cc>, Tycho Andersen <tycho@tycho.ws>
Cc:     kernel-hardening@lists.openwall.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/mm/init_32: Don't print out kernel memory layout if KASLR
Date:   Wed, 26 Feb 2020 16:50:39 -0500
Message-Id: <20200226215039.2842351-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For security, only show the virtual kernel memory layout if KASLR is
disabled.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/mm/init_32.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index 23df4885bbed..53635be69102 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -788,6 +788,10 @@ void __init mem_init(void)
 	x86_init.hyper.init_after_bootmem();
 
 	mem_init_print_info(NULL);
+
+	if (kaslr_enabled())
+		goto skip_layout;
+
 	printk(KERN_INFO "virtual kernel memory layout:\n"
 		"    fixmap  : 0x%08lx - 0x%08lx   (%4ld kB)\n"
 		"  cpu_entry : 0x%08lx - 0x%08lx   (%4ld kB)\n"
@@ -827,6 +831,7 @@ void __init mem_init(void)
 		(unsigned long)&_text, (unsigned long)&_etext,
 		((unsigned long)&_etext - (unsigned long)&_text) >> 10);
 
+skip_layout:
 	/*
 	 * Check boundaries twice: Some fundamental inconsistencies can
 	 * be detected at build time already.
-- 
2.24.1

