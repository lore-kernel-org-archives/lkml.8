Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3F0C4BA2D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D6C21556
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9Z/1Qb4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbgB0N2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:28:36 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45250 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729056AbgB0N2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:28:36 -0500
Received: by mail-yw1-f68.google.com with SMTP id a125so2926678ywe.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 05:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=naAstPuQL5iUK964foSh5Uac6wX9+5/VEhQHKY9iq2E=;
        b=Y9Z/1Qb4BjI1V+c4JxO5HAl2rcILVPiBiysFRw7NZ0DeyLClP2mGebcAP+oIuIQJV1
         au01WUCTRJ395q4s1HWIG481NqSMISkrNQb+nChhMak/6Tf0KtScKjdqib9OCImTiXQI
         LQlVjDY7i6VenDi3ntBAvtIjb/8yms/IXGo1/7xJ7G7aTleIBKkHGBx0xYHPlWNhqN/e
         NSOYsoXzyxa1OPDtJZpuP9Qh+u1nA9PDdABJJbsML9rWR/rc3hOPAKLg44xFyrjjT9es
         d1yqnwVIXOplH2fgPgu9o5kUe7vyDRSMgZ/bSOQkESETlRD1U+eVVQmieVaSBGrxdEuK
         Pe6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=naAstPuQL5iUK964foSh5Uac6wX9+5/VEhQHKY9iq2E=;
        b=cUS/6uFU4TLlQHrO29DJqmMMxTbb4Lmj1Hi0UWdf70znJI0W4RqpaDOimWO3oXPr9Y
         1/S+CNYWneKd0P7HVgS6Cx2pWP4ApWBCiUvcc7gXE8xsnvOgpF5qUvlSebJrJIErRV8u
         OOnizoWUvSrzh44e21jod6srT5zem+NpTuNYYAvJ4nE9TCI6b1BAoxCfoCT/+qxUuI7l
         +BS3iebwkyaZzblQD7hKKa+tC0AU7DLIbQnMrMq26k9+oTIrdlEQCHKnYF6W3f8sEcKW
         jtBmFP0b98NdXEo6XRJRvHYE5XNhGRredywnAEtxBuwAnUP9NXO5dwkrEM2EnBWv3wqh
         NhAg==
X-Gm-Message-State: APjAAAUCBOgVDw5cr1kn+IorOP/OqICK+vm7faDrg5DzMZDXCPXtPire
        onaVkOxDmL4rvEL5imGQSDkl8v4=
X-Google-Smtp-Source: APXvYqxW5Ie9p1gMwDtNi3ZBIm+pVlzhhhExrcSSOcipEZKhKhi9xFzN+tPAUsRulB7/ZMLAgCkFxw==
X-Received: by 2002:a25:7355:: with SMTP id o82mr3768881ybc.140.1582810114548;
        Thu, 27 Feb 2020 05:28:34 -0800 (PST)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id j23sm2442759ywb.93.2020.02.27.05.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 05:28:33 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v3 0/8] Enable pt_regs based syscalls for x86-32 native
Date:   Thu, 27 Feb 2020 08:28:18 -0500
Message-Id: <20200227132826.195669-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series cleans up the x86 syscall wrapper code and converts
the 32-bit native kernel over to pt_regs based syscalls.  This makes
the 32-bit syscall interface consistent with 64-bit, and a bit more
effecient by not blindly pushing all 6 potential arguments onto the
stack.

Changes since v2:
- Moved adding the [compat_]sys_ prefix to the ABI-level macros

Changes since v1:
- Split patch 1 into multiple patches
- Updated comments and patch notes to clarify changes

Brian Gerst (8):
  x86, syscalls: Refactor SYSCALL_DEFINEx macros
  x86, syscalls: Refactor SYSCALL_DEFINE0 macros
  x86, syscalls: Refactor COND_SYSCALL macros
  x86, syscalls: Refactor SYS_NI macros
  x86: Move 32-bit compat syscalls to common location
  x86-32: Enable syscall wrappers
  x86-64: Use syscall wrappers for x32_rt_sigreturn
  x86: Drop asmlinkage from syscalls

 arch/x86/Kconfig                       |   2 +-
 arch/x86/entry/common.c                |  20 +-
 arch/x86/entry/syscall_32.c            |  13 +-
 arch/x86/entry/syscall_64.c            |   9 +-
 arch/x86/entry/syscalls/syscall_32.tbl | 818 ++++++++++++-------------
 arch/x86/entry/syscalls/syscall_64.tbl |   2 +-
 arch/x86/entry/syscalls/syscalltbl.sh  |  33 +-
 arch/x86/ia32/Makefile                 |   2 +-
 arch/x86/include/asm/sighandling.h     |   5 -
 arch/x86/include/asm/syscall.h         |   8 +-
 arch/x86/include/asm/syscall_wrapper.h | 310 +++++-----
 arch/x86/include/asm/syscalls.h        |  29 -
 arch/x86/kernel/Makefile               |   2 +
 arch/x86/kernel/signal.c               |   2 +-
 arch/x86/{ia32 => kernel}/sys_ia32.c   | 130 ++--
 arch/x86/um/sys_call_table_32.c        |  10 +
 16 files changed, 691 insertions(+), 704 deletions(-)
 rename arch/x86/{ia32 => kernel}/sys_ia32.c (83%)

-- 
2.24.1

