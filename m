Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1ACDC11D3A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE2720732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgBXXVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 18:21:54 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:43701 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbgBXXVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 18:21:33 -0500
Received: by mail-qv1-f68.google.com with SMTP id p2so4910434qvo.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 15:21:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7eJOUKA9+YMnHErB2iphiqe6znDzVNUSfeCBuEYYLTo=;
        b=GPE3CUlzT3eyIhBmINTkYX8CdPykwb7Lmj44V0fBTtJy1w9lWv18/XIO9TLvii0hwJ
         5l0RAtQFCqgTTf/TaEjCDlvJqbaSprGm4QJNokODwI3P+3DdpZgJtj1NToOInEe6J0eO
         IoA2/XmVPwenRjy8sSZaQ6fv/ObwpvLdncch0sg9NfzZ1juvv8v/4QsACigG/YfgRggn
         k3uo3mxbvxNiVLczUeMZy+CyRvzR+Q3ETtzIkNCLvJOeM59N4Fj7rhtPg3h6GOrkOeA5
         kidBXIDPMCZVpNO68XkDdCH0tQePA8ui2TcUbOMLzlXfzDvBvX3bSeWP7z7pErpYTD36
         QUBA==
X-Gm-Message-State: APjAAAXME+vVI1deLLgpZ3mW1zPSY2YdR6qbogIveyZGwsXQ1XBtiimp
        yExSx+stjH/UBBQquC/LiEE=
X-Google-Smtp-Source: APXvYqweEcGUAPh3nLyKqwQtOcSUxZYzKkDEZDE1pbyx598pt0vVqfbz2Ci4kDXbHLybdeSWfOCj1A==
X-Received: by 2002:ad4:580b:: with SMTP id dd11mr45660696qvb.242.1582586491073;
        Mon, 24 Feb 2020 15:21:31 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 202sm3757849qkg.132.2020.02.24.15.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 15:21:30 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Michael Matz <matz@suse.de>, Fangrui Song <maskray@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 0/2] Stop generating .eh_frame sections
Date:   Mon, 24 Feb 2020 18:21:27 -0500
Message-Id: <20200224232129.597160-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <CAKwvOdn6cxm9EpB7A9kLasttPwLY2csnhqgNAdkJ6_s2DP1-HA@mail.gmail.com>
References: <CAKwvOdn6cxm9EpB7A9kLasttPwLY2csnhqgNAdkJ6_s2DP1-HA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In three places in the x86 kernel we are currently generating .eh_frame
sections only to discard them later via linker script. This is in the
boot code (setup.elf), the realmode trampoline (realmode.elf) and the
compressed kernel.

Implement Fangrui and Nick's suggestion [1] to fix KBUILD_CFLAGS by
adding -fno-asynchronous-unwind-tables to avoid generating .eh_frame
sections in the first place, rather than discarding it in the linker
script.

Changes from v1:

Rebase on top of tip:x86/boot and include reverting the addition of
	.eh_frame discard in compressed/vmlinux.lds.S.
Fix up a comment that refers to .eh_frame, pointed out by Nick.

Arvind Sankar (2):
  arch/x86: Use -fno-asynchronous-unwind-tables to suppress .eh_frame sections
  arch/x86: Drop unneeded linker script discard of .eh_frame

 arch/x86/boot/Makefile                 | 1 +
 arch/x86/boot/compressed/Makefile      | 1 +
 arch/x86/boot/compressed/vmlinux.lds.S | 5 -----
 arch/x86/boot/setup.ld                 | 1 -
 arch/x86/include/asm/dwarf2.h          | 4 ++--
 arch/x86/kernel/vmlinux.lds.S          | 7 ++-----
 arch/x86/realmode/rm/Makefile          | 1 +
 arch/x86/realmode/rm/realmode.lds.S    | 1 -
 drivers/firmware/efi/libstub/Makefile  | 3 ++-
 9 files changed, 9 insertions(+), 15 deletions(-)

-- 
2.24.1

