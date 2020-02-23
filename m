Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866F9C35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 19:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63211214DB
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 19:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbgBWThZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 14:37:25 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:41031 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbgBWThV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 14:37:21 -0500
Received: by mail-qv1-f65.google.com with SMTP id s7so3289567qvn.8
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 11:37:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d+QmnLrRwcCe4goxaquBsikLpsyp4quOOJ9FJHZsvts=;
        b=lEQ/i9RH6HZoo5eEtxcVe7xB0/+Sxa4eGyKNM9GGFGMEA59hXrAgzrJezPKzBH4Z7K
         TTChfazh41liXEtQRi/Vd6h+keq5hUpQ3d73PIKK044d+U55OFjglO231bEDxiDteca7
         aDB0YjCCguxE1M4EWi02mqmRO51MD/V/IX8S2hpRMqxSq9UoZsJrlOzT8a2TD4nK/NKR
         hm2NcH1lacO053fTeIZmrXgQRCn2RcBrzotDsZ/osGuh3wyE6NsbrlGCZ+WBif1mO4O4
         +tBdi1oAVk5dv9MxMsbYn1ivciax3vW1RNBYtmL1+9NMdlVNpLup6LVEVd3hG3RiFquN
         vBaQ==
X-Gm-Message-State: APjAAAXBkv8+8jFiYzd0VWcNnSf/Cj1S88+pXuZFTsMwn7q0/WtKkJlV
        4/YNg2IRYTwbm6D1G6wdozw=
X-Google-Smtp-Source: APXvYqwFpd0luhut71MjstqAhf6gfHUPmPGCIJnzYy26ESypiXtNBQmH063vWJnVulhHgFn0OlQesg==
X-Received: by 2002:ad4:5144:: with SMTP id g4mr41169931qvq.179.1582486639306;
        Sun, 23 Feb 2020 11:37:19 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 204sm4780976qkg.74.2020.02.23.11.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 11:37:18 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Michael Matz <matz@suse.de>, Fangrui Song <maskray@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 2/2] arch/x86: Drop unneeded linker script discard of .eh_frame
Date:   Sun, 23 Feb 2020 14:37:15 -0500
Message-Id: <20200223193715.83729-3-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200222235709.GA3786197@rani.riverdale.lan>
References: <20200222235709.GA3786197@rani.riverdale.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we don't generate .eh_frame sections for the files in setup.elf
and realmode.elf, the linker scripts don't need the /DISCARD/ any more.

Also remove the one in the main kernel linker script, since there are no
.eh_frame sections already.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/setup.ld              | 1 -
 arch/x86/kernel/vmlinux.lds.S       | 3 ---
 arch/x86/realmode/rm/realmode.lds.S | 1 -
 3 files changed, 5 deletions(-)

diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
index 3da1c37c6dd5..24c95522f231 100644
--- a/arch/x86/boot/setup.ld
+++ b/arch/x86/boot/setup.ld
@@ -52,7 +52,6 @@ SECTIONS
 	_end = .;
 
 	/DISCARD/	: {
-		*(.eh_frame)
 		*(.note*)
 	}
 
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index e3296aa028fe..54f7b9f46446 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -412,9 +412,6 @@ SECTIONS
 	DWARF_DEBUG
 
 	DISCARDS
-	/DISCARD/ : {
-		*(.eh_frame)
-	}
 }
 
 
diff --git a/arch/x86/realmode/rm/realmode.lds.S b/arch/x86/realmode/rm/realmode.lds.S
index 64d135d1ee63..63aa51875ba0 100644
--- a/arch/x86/realmode/rm/realmode.lds.S
+++ b/arch/x86/realmode/rm/realmode.lds.S
@@ -71,7 +71,6 @@ SECTIONS
 	/DISCARD/ : {
 		*(.note*)
 		*(.debug*)
-		*(.eh_frame*)
 	}
 
 #include "pasyms.h"
-- 
2.24.1

