Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC938C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3CFD2067B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="ALBLU+Fe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbgFDUPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 16:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgFDUPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 16:15:36 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EFFC08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 13:15:36 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bg4so2664444plb.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 13:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=WOZaG2u1de4YEHm+yW1ep+MxAdFc9U0Z2nxdOZXGt88=;
        b=ALBLU+FeqwQoATYy+P/2ToiUYbwkFRW+/Jy0BP6bHUmjobSR95mEC1dD80v2PySV6/
         rAHOT3Sc4hDcUpLaxma36F1oewKiEY0bunsCrUgT1goIgubbUo2cAnpjfGjtEcQYsybi
         /fJxPsulhJl4SvKjzIdj1Jz++udL1OK9aGiKtRhazzzA1TuA8nn97hwp7Z0a7ArYnzTA
         7dRO9sjR7xahcXuCAxTZfSC3jfh31a+yxDko46tX1z84J+T2E+Q9b7yyr7g0tb9feNvQ
         Aqa+yksWE+KbALJVua5NSJe5V/iVQVs4iOI4P41lOVNmwurDxDpAoDugusv2XFczMl7Z
         raIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=WOZaG2u1de4YEHm+yW1ep+MxAdFc9U0Z2nxdOZXGt88=;
        b=F5dWj5uzzlrbIWmRiE4HXLwg+VcgOgzJLTKdmxoZf5DhiLS64ZznMm9E1GwyAbfUPB
         wSBLQZbTzmd0B0hDjbHoos3OP8ogzaz+vbr1DH0O8BwEM+3zTDRvUdKCcaqGey/xuM/p
         G+LeJTGSpvWy14tG50s0p2WCOT+ms/a4MO4yC19niz9dRLHMcM1+fv/pdWZEqF6119DJ
         lDePsezOk+lLxlmYqwJSck61Dzz2RMK09Cw7sGXNzrBl+BdpK2n9CP71yFnbtojWWKD7
         onaLn+pB1HRUf1DAtYbvGwpb9Sd2PU8BxAnKZAbXQGoqlUgjBfyBjuuv/RLhW5jwSoa6
         ZulQ==
X-Gm-Message-State: AOAM530y5ORtE99ekGkQ5QRoYIBwPRvjDDK/wn3EtYYgM7t5KayTx85P
        HyjbZVSojIq3VPvgAT3V4Bn24C2dedNLWg==
X-Google-Smtp-Source: ABdhPJy7+MQO7TyqSkHCQ0356mGWsvAdakxuGJB4/Vexl1NwjXd8bhEaCq1cP4gxQg0Pq6iqMXirRg==
X-Received: by 2002:a17:90a:c905:: with SMTP id v5mr7905454pjt.39.1591301735348;
        Thu, 04 Jun 2020 13:15:35 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id y23sm4601875pgc.78.2020.06.04.13.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 13:15:34 -0700 (PDT)
Date:   Thu, 04 Jun 2020 13:15:34 -0700 (PDT)
X-Google-Original-Date: Thu, 04 Jun 2020 13:15:31 PDT (-0700)
Subject:     Re: [GIT PULL] RISC-V Patches for the 5.8 Merge Window, Part 1
In-Reply-To: <CAOnJCU+jkYSVa-vMjabdnRpubK0c52VgjjVreC=07L_Vr3C64g@mail.gmail.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     atishp@atishpatra.org
Message-ID: <mhng-6a5f967f-96fa-4476-ad99-50b2c3962a66@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Jun 2020 12:50:13 PDT (-0700), atishp@atishpatra.org wrote:
> On Thu, Jun 4, 2020 at 11:57 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>
>> The following changes since commit b9bbe6ed63b2b9f2c9ee5cbd0f2c946a2723f4ce:
>>
>>   Linux 5.7-rc6 (2020-05-17 16:48:37 -0700)
>>
>> are available in the Git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.8-mw0
>>
>> for you to fetch changes up to 09c0533d129ce460e6214c14f744ddbac3733889:
>>
>>   soc: sifive: l2 cache: Mark l2_get_priv_group as static (2020-05-28 15:57:49 -0700)
>>
>> ----------------------------------------------------------------
>> RISC-V Patches for the 5.8 Merge Window, Part 1
>>
>> * The remainder of the code necessary to support the Kendryte K210.
>>     * Support for building device trees into the kernel, as the K210 doesn't
>>       have a bootloader that provides one.
>>     * A K210 device tree and the associated defconfig update.
>>     * Support for skipping PMP initialization on systems that trap on PMP
>>       accesses rather than treating them as WARL.
>> * Support for KGDB.
>> * Improvements to text patching.
>> * Some cleanups to the SiFive L2 cache driver.
>>
>> I may have a second part, but I wanted to get this out earlier rather than
>> later as they've been ready to go for a while now.
>>
> Hi Palmer,
> Can you also add the run time cpu hotplug fix patch if it is not too late?
>
> https://patchwork.kernel.org/patch/11581221/
>
> Without the patch, cpu hotplug will broken for 5.8-rc1 too.

It looks like there's enough to warrant a part 2 (that fix, the vDSO stuff,
some Kconfig stuff, and the interrupt stuff).  Some of that was held back to
avoid conflicts, so it'd be easier for me if this just goes in as-is and I can
start putting together another PR based on the post-merge commit.

>> ----------------------------------------------------------------
>> Damien Le Moal (1):
>>       riscv: K210: Update defconfig
>>
>> Palmer Dabbelt (5):
>>       riscv: Allow device trees to be built into the kernel
>>       riscv: K210: Add a built-in device tree
>>       RISC-V: Skip setting up PMPs on traps
>>       soc: sifive: l2 cache: Eliminate an unsigned zero compare warning
>>       soc: sifive: l2 cache: Mark l2_get_priv_group as static
>>
>> Vincent Chen (4):
>>       kgdb: Add kgdb_has_hit_break function
>>       riscv: Add KGDB support
>>       riscv: Use the XML target descriptions to report 3 system registers
>>       riscv: Add SW single-step support for KDB
>>
>> Yash Shah (2):
>>       riscv: cacheinfo: Implement cache_get_priv_group with a generic ops structure
>>       riscv: Add support to determine no. of L2 cache way enabled
>>
>> Zong Li (3):
>>       riscv: Remove the 'riscv_' prefix of function name
>>       riscv: Use NOKPROBE_SYMBOL() instead of __krpobes annotation
>>       riscv: Use text_mutex instead of patch_lock
>>
>>  arch/riscv/Kbuild                       |   1 +
>>  arch/riscv/Kconfig                      |   7 +
>>  arch/riscv/Kconfig.socs                 |  17 +-
>>  arch/riscv/boot/dts/Makefile            |   2 +
>>  arch/riscv/boot/dts/kendryte/Makefile   |   4 +-
>>  arch/riscv/configs/nommu_k210_defconfig |   7 +-
>>  arch/riscv/include/asm/cacheinfo.h      |  15 ++
>>  arch/riscv/include/asm/gdb_xml.h        | 117 ++++++++++
>>  arch/riscv/include/asm/kdebug.h         |  12 +
>>  arch/riscv/include/asm/kgdb.h           | 112 +++++++++
>>  arch/riscv/include/asm/parse_asm.h      | 219 ++++++++++++++++++
>>  arch/riscv/include/asm/patch.h          |   4 +-
>>  arch/riscv/include/asm/soc.h            |  39 ++++
>>  arch/riscv/kernel/Makefile              |   1 +
>>  arch/riscv/kernel/cacheinfo.c           |  17 ++
>>  arch/riscv/kernel/ftrace.c              |  15 +-
>>  arch/riscv/kernel/head.S                |  11 +-
>>  arch/riscv/kernel/kgdb.c                | 390 ++++++++++++++++++++++++++++++++
>>  arch/riscv/kernel/patch.c               |  46 ++--
>>  arch/riscv/kernel/setup.c               |   4 +
>>  arch/riscv/kernel/soc.c                 |  27 +++
>>  arch/riscv/kernel/traps.c               |   5 +
>>  arch/riscv/kernel/vmlinux.lds.S         |   5 +
>>  arch/riscv/mm/init.c                    |   9 +
>>  drivers/soc/kendryte/k210-sysctl.c      |  12 +
>>  drivers/soc/sifive/sifive_l2_cache.c    |  40 +++-
>>  kernel/debug/debug_core.c               |  12 +
>>  27 files changed, 1119 insertions(+), 31 deletions(-)
>>  create mode 100644 arch/riscv/include/asm/cacheinfo.h
>>  create mode 100644 arch/riscv/include/asm/gdb_xml.h
>>  create mode 100644 arch/riscv/include/asm/kdebug.h
>>  create mode 100644 arch/riscv/include/asm/kgdb.h
>>  create mode 100644 arch/riscv/include/asm/parse_asm.h
>>  create mode 100644 arch/riscv/kernel/kgdb.c
>>
