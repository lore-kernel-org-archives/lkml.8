Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC11C35DF2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 05:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2B924682
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 05:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LFrOdVRm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgBYFNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 00:13:14 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43886 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgBYFNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 00:13:14 -0500
Received: by mail-pl1-f195.google.com with SMTP id p11so4987220plq.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 21:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CQB4rWAgQlshK2jar7JtwK95ipRQeMQdrfjF9c60b3Q=;
        b=LFrOdVRmnVadjqGd8oJrAQjMoolYjWN9vYwc3EwXw87IXTST26Jz+ZUqqf3Cwz9CoS
         8nvpcKutc2DDmK9larltPBH0crdkmid8hDBB1a3PpJF4ipvEpIkrP1nwnZd6QtbZKUqw
         THv95WvZqUUgZ2hYd5vk1iRfZrXdVhQeyUBzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CQB4rWAgQlshK2jar7JtwK95ipRQeMQdrfjF9c60b3Q=;
        b=jecIb7LFddsCed11T4Tp3HXW5sQT9C/QtswUBnkOwJHb65cWnIg8t5K2MlrjFBqx5f
         6K/Hkt4H1d6f7lFkAvaIDQdykJW2CqSUVT6V0XFraA0bHjJKU6h0ozmDQPI4bTunqqcg
         XrnHa7aPPCHOHqZTLd4k2qt/ZqLi+CcJnkOOAN8wdMm9hM7fxi+bUw5ujBKmelSIZypR
         XLZRou8oKa40vlSpxyTjOmBlDVUbpEAm/tzJCVVeLmwobAhmlIls1TOkYdGAVkuhqMin
         2rnAnTn8cTeX+kk3cnFnE3l7qOAAM+CLBmce65dlahIkAJ01ABfTWfSgVhNiqnEP2jF0
         dcpg==
X-Gm-Message-State: APjAAAXgHwkYTR60b4EsXFA/H9DilNDRWy5ubTBqBxECRd5fx4cyIo6O
        jULEO2hqZup9JmLivZSRHZ1iag==
X-Google-Smtp-Source: APXvYqyEp2DduArcsAfDzCxBtvCjTHJyL0Kka4MDfFR/IyZ8Q21kRRLDuvjt0qN6ORbpfkkeenKrsA==
X-Received: by 2002:a17:90a:da03:: with SMTP id e3mr3139897pjv.57.1582607592644;
        Mon, 24 Feb 2020 21:13:12 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h13sm1274471pjc.9.2020.02.24.21.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 21:13:11 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>, Jann Horn <jannh@google.com>,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/6] binfmt_elf: Update READ_IMPLIES_EXEC logic for modern CPUs
Date:   Mon, 24 Feb 2020 21:13:01 -0800
Message-Id: <20200225051307.6401-1-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a refresh of my earlier attempt to fix READ_IMPLIES_EXEC. I
think it incorporates the feedback from v2 (there are no code changes
between v3 and v4; I've just added Reviews/Acks and directed at Boris,
as it seems Ingo is busy). The selftest from v3 has been remove from v4,
as I will land it separately via Shuah's selftest tree.

This series is for x86, arm, and arm64; I'd like it to go via -tip,
though, just to keep this change together with the selftest. To
that end, I'd like to collect Acks from the respective architecture
maintainers. (Note that most other architectures don't suffer from this
problem. e.g. powerpc's behavior appears to already be correct. MIPS may
need adjusting but the history of CPU features and toolchain behavior
is very unclear to me.)

Repeating the commit log from later in the series:


The READ_IMPLIES_EXEC work-around was designed for old toolchains that
lacked the ELF PT_GNU_STACK marking under the assumption that toolchains
that couldn't specify executable permission flags for the stack may not
know how to do it correctly for any memory region.

This logic is sensible for having ancient binaries coexist in a system
with possibly NX memory, but was implemented in a way that equated having
a PT_GNU_STACK marked executable as being as "broken" as lacking the
PT_GNU_STACK marking entirely. Things like unmarked assembly and stack
trampolines may cause PT_GNU_STACK to need an executable bit, but they
do not imply all mappings must be executable.

This confusion has led to situations where modern programs with explicitly
marked executable stack are forced into the READ_IMPLIES_EXEC state when
no such thing is needed. (And leads to unexpected failures when mmap()ing
regions of device driver memory that wish to disallow VM_EXEC[1].)

In looking for other reasons for the READ_IMPLIES_EXEC behavior, Jann
Horn noted that glibc thread stacks have always been marked RWX (until
2003 when they started tracking the PT_GNU_STACK flag instead[2]). And
musl doesn't support executable stacks at all[3]. As such, no breakage
for multithreaded applications is expected from this change.

[1] https://lkml.kernel.org/r/20190418055759.GA3155@mellanox.com
[2] https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=54ee14b3882
[3] https://lkml.kernel.org/r/20190423192534.GN23599@brightrain.aerifal.cx


-Kees


v4:
 - split selftest into separate series to go via Shuah's tree
 - add Reviews/Acks
v3: https://lore.kernel.org/lkml/20200210193049.64362-1-keescook@chromium.org
v2: https://lore.kernel.org/lkml/20190424203408.GA11386@beast/
v1: https://lore.kernel.org/lkml/20190423181210.GA2443@beast/

Kees Cook (6):
  x86/elf: Add table to document READ_IMPLIES_EXEC
  x86/elf: Split READ_IMPLIES_EXEC from executable GNU_STACK
  x86/elf: Disable automatic READ_IMPLIES_EXEC for 64-bit address spaces
  arm32/64, elf: Add tables to document READ_IMPLIES_EXEC
  arm32/64, elf: Split READ_IMPLIES_EXEC from executable GNU_STACK
  arm64, elf: Disable automatic READ_IMPLIES_EXEC for 64-bit address
    spaces

 arch/arm/kernel/elf.c        | 27 +++++++++++++++++++++++----
 arch/arm64/include/asm/elf.h | 23 ++++++++++++++++++++++-
 arch/x86/include/asm/elf.h   | 22 +++++++++++++++++++++-
 fs/compat_binfmt_elf.c       |  5 +++++
 4 files changed, 71 insertions(+), 6 deletions(-)

-- 
2.20.1

