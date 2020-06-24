Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20971C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ABDE21473
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403896AbgFXMek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 08:34:40 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38574 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390646AbgFXMe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 08:34:27 -0400
Received: by mail-qt1-f196.google.com with SMTP id z2so1485271qts.5;
        Wed, 24 Jun 2020 05:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dd/x9rNY52s67dtxhdU+GLjXuLmi+ISuyjz/CGrFIjM=;
        b=NGYb8BWF69d58aMZEBSJDTJ2WfoIzyaBQyGXCLpmS2l1d0l7s6tpwFmJVUSQPwFw4l
         ffuOCBHy8Tfl5stimfruliPRKtHTEJ8kHF2Xe81rpsnAqTxWoY+Tm/4a8iJ5SHpQNv4W
         4OAg+4NOcUxWf8pQaA79GK7lM5JljdiGSY76oYGqHZw2ysOvw15ErQpoUdyb+4pNmLXM
         Fy2GKbhWH7WwoIuLfT05RCx704qxFPLnvwHCsrpX6mTbl0cVldIQPPKHvcuImCsvcIru
         Kbdi4Gsjih3cpTJJnvn8WYaoJp+zA6On5fHIM9gRmdjt71LVoQ8NdK8hBRh3H04hekR5
         1+Nw==
X-Gm-Message-State: AOAM53285VFkuOZyUAz3jNxDeLZ9BGJ5/4XWMxFGyE3yF0rnWTl1YL5J
        Ecr+8htJVYTRCL0o/TPn3lA=
X-Google-Smtp-Source: ABdhPJyKNg/sgqLpXlRp5nWSXUg5BbFE6D7yhTpokmqzn6cNtEQ6n5ShWMctUFdRI9VD2lwP79MMMA==
X-Received: by 2002:ac8:5486:: with SMTP id h6mr6019451qtq.255.1593002066620;
        Wed, 24 Jun 2020 05:34:26 -0700 (PDT)
Received: from localhost.localdomain ([185.248.161.177])
        by smtp.gmail.com with ESMTPSA id x26sm3354512qtr.4.2020.06.24.05.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 05:34:26 -0700 (PDT)
From:   Alexander Popov <alex.popov@linux.com>
To:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Emese Revfy <re.emese@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Sven Schnelle <svens@stackframe.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Alexander Monakov <amonakov@ispras.ru>,
        Mathias Krause <minipli@googlemail.com>,
        PaX Team <pageexec@freemail.hu>,
        Brad Spengler <spender@grsecurity.net>,
        Laura Abbott <labbott@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Alexander Popov <alex.popov@linux.com>,
        kernel-hardening@lists.openwall.com, linux-kbuild@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, gcc@gcc.gnu.org
Cc:     notify@kernel.org
Subject: [PATCH v2 3/5] arm64: vdso: Don't use gcc plugins for building vgettimeofday.c
Date:   Wed, 24 Jun 2020 15:33:28 +0300
Message-Id: <20200624123330.83226-4-alex.popov@linux.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200624123330.83226-1-alex.popov@linux.com>
References: <20200624123330.83226-1-alex.popov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't use gcc plugins for building arch/arm64/kernel/vdso/vgettimeofday.c
to avoid unneeded instrumentation.

Signed-off-by: Alexander Popov <alex.popov@linux.com>
---
 arch/arm64/kernel/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index 556d424c6f52..0f1ad63b3326 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -29,7 +29,7 @@ ldflags-y := -shared -nostdlib -soname=linux-vdso.so.1 --hash-style=sysv \
 ccflags-y := -fno-common -fno-builtin -fno-stack-protector -ffixed-x18
 ccflags-y += -DDISABLE_BRANCH_PROFILING
 
-CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS)
+CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) $(GCC_PLUGINS_CFLAGS)
 KBUILD_CFLAGS			+= $(DISABLE_LTO)
 KASAN_SANITIZE			:= n
 UBSAN_SANITIZE			:= n
-- 
2.25.4

