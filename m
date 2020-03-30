Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93E4C2D0ED
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 12:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F410206E6
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 12:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585571504;
	bh=Oolrve6KUjp8JtWjcuS+gE/QlRSl5sSSz5E1f+buIIM=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=GSQR/lzlhQHww0A5Y2bUUPUEvgvmZwgT9GHLWgkqus2G4FKJL3fCwiVK+9NHfSGdc
	 I/Qk0WGmjN0R7CP3ViSvoI8hZlfSxAAykepHDej9A6WZRgopI0oS2PrMd1oSpM/fHX
	 74UdR7VwyneGob+/trwKF2S4fdPVkqtHMB7Y0lyo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbgC3Mbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 08:31:43 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39904 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729785AbgC3Mbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 08:31:43 -0400
Received: by mail-wm1-f67.google.com with SMTP id e9so9758881wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 05:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=6D1CONpxSBKbzO1QemsXadQ3h0HbBv4V05qXdKPSA2c=;
        b=VRaZ+PwyFH11ZL2vUQmMIrV6ZhVoH1LzhV9kF2+OpaSqUO/r8b4JW8maN96Jof3Rk6
         tZyWFWUKhBPyBSPcE9FfSKvn8LRAMLKMxzqXGyeIoWkWVwcP6OkvykJluR25BJgWchEs
         v9L5XxljzDMvpaDU2YBsjPH9z+7r9m6yqsxxeUlIf1wbgba5qkXaUEAoaFIg98gbdOts
         SouC95NP6mnlHfm2aa1Yr3elplv5VhkeSY8z+hLpSsVJ5mRXjfWZ+Wqos5QAU/ewx4L6
         MZXqCKiGi6zrTQIfA35PWq70PS5B4dsOOau4XKg7TLTzsteu0gXUzurLUk8eLukvXL0G
         Nivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=6D1CONpxSBKbzO1QemsXadQ3h0HbBv4V05qXdKPSA2c=;
        b=eGXKIZdiCgW5gRsO9Io4Be7AeyFT7nB+9t0j9xWWhpBFN9gvTfVuXfAH0vbi2LHT/t
         5kc8+h1rbstUDecBFLL9OLZCxIp3n5uArJuN0E7svwE8VfRodwosbeO7au/TeYYypyQ2
         CqNIQyPiUuhdJEIb0gmfrYqQASqZuuW/7BIZnakG/Ll5NHy+vUqY5CFQOSn/qcfiEAzC
         6riZVdDOQ4hqcqBPWSnXE+jpDMGcaMlVS0at+2rA9G75dhXIXOm720dUMP4HLtKA33Rs
         x/e5PmASC5GLA5hObDPzDefjM7+nS03oIFscd8rOSj+03EkHvPi7RdBUqdA0+xc8ALAp
         FJAw==
X-Gm-Message-State: ANhLgQ1l9mW275fDElHQGdsuY6U3Ys2MvC/6RjTjF5WAK2lG7JoswXgF
        BQC0Y5toPoOiQPzGFsifJb8=
X-Google-Smtp-Source: ADFU+vu3f3t8TT9K+EF52uMxeI94XrICKD14M+w5lZjw9wB57iTGIKJccAeEggT1NDIdhpNN81t6Lw==
X-Received: by 2002:a1c:8108:: with SMTP id c8mr12761629wmd.50.1585571499575;
        Mon, 30 Mar 2020 05:31:39 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id b203sm20940964wmc.45.2020.03.30.05.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 05:31:38 -0700 (PDT)
Date:   Mon, 30 Mar 2020 14:31:36 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] core/objtool changes for v5.7
Message-ID: <20200330123136.GA3021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest core-objtool-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-objtool-for-linus

   # HEAD: 350994bf95414d6da67a72f27d7ac3832ce3725d objtool: Re-arrange validate_functions()

The biggest changes in this cycle were the vmlinux.o optimizations by 
Peter Zijlstra, which are preparatory and optimization work to run 
objtool against the much richer vmlinux.o object file, to perform new, 
whole-program section based logic. That work exposed a handful of 
problems with the existing code, which fixes and optimizations are merged 
here. The complete 'vmlinux.o and noinstr' work is still work in 
progress, targeted for v5.8.

There's also assorted fixes and enhancements from Josh Poimboeuf.

In particular I'd like to draw attention to commit 644592d328370, which 
turns fatal objtool errors into failed kernel builds. This behavior is 
IMO now justified on multiple grounds (it's easy currently to not notice 
an essentially corrupted kernel build), and the commit has been in -next 
testing for several weeks, but there could still be build failures with 
old or weird toolchains. Should that be widespread or high profile enough 
then I'd suggest a quick revert, to not hold up the merge window.

 Thanks,

	Ingo

------------------>
Josh Poimboeuf (5):
      objtool: Fail the kernel build on fatal errors
      objtool: Add is_static_jump() helper
      objtool: Add relocation check for alternative sections
      objtool: Fix clang switch table edge case
      objtool: Improve call destination function detection

Peter Zijlstra (17):
      objtool: Introduce validate_return()
      objtool: Rename func_for_each_insn()
      objtool: Rename func_for_each_insn_all()
      x86/kexec: Use RIP relative addressing
      x86/kexec: Make relocate_kernel_64.S objtool clean
      objtool: Optimize find_symbol_by_index()
      objtool: Add a statistics mode
      objtool: Optimize find_section_by_index()
      objtool: Optimize find_section_by_name()
      objtool: Optimize find_symbol_*() and read_symbols()
      objtool: Rename find_containing_func()
      objtool: Resize insn_hash
      objtool: Optimize find_symbol_by_name()
      objtool: Optimize read_sections()
      objtool: Delete cleanup()
      objtool: Optimize find_rela_by_dest_range()
      objtool: Re-arrange validate_functions()


 arch/x86/kernel/Makefile             |   1 -
 arch/x86/kernel/relocate_kernel_64.S |  12 +-
 tools/objtool/Build                  |   5 +
 tools/objtool/builtin-check.c        |   3 +-
 tools/objtool/builtin.h              |   2 +-
 tools/objtool/check.c                | 268 +++++++++++++++++++--------------
 tools/objtool/check.h                |   2 +-
 tools/objtool/elf.c                  | 281 +++++++++++++++++++++++++----------
 tools/objtool/elf.h                  |  51 ++++++-
 tools/objtool/orc_gen.c              |   9 +-
 tools/objtool/special.c              |   4 +-
 tools/objtool/warn.h                 |   2 +-
 12 files changed, 429 insertions(+), 211 deletions(-)

