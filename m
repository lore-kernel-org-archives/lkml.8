Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F84C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 02:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A85F207D3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 02:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="euNrCaxH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgFECIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 22:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgFECIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 22:08:54 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A062FC08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 19:08:54 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id w90so7254856qtd.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 19:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vf1+KHa5uVuveCfYB76JgHx3nwRL/i8E8jzR5pXq5CM=;
        b=euNrCaxH1KD7AV8Ltzxg+pF2OicrHC9eosYbKlPS9yspzyxSLHdEDhK+gwP174CANT
         I726a5JHAECbl2yPLpfkoLZJks3n2YOWhSdOa3N/UZAoESjmvTFcyhPuiT502bf4cwfk
         kGgmZctsJzKwL+RfJOv0eGa2ZxtGNtBtpnsV7YyldrjTJV2dng6ZlVB+wAIn+aCsVL5+
         W1DRqtWE8gUFRMnjVRllJjW9SbjQXLWLLnW89vC2/NRnlVPlmqbnZ1kuXLnpHQEjg5w5
         7jUU4ot8icIRIRTXimqXnU7/smEBkAb4QQxctoSMlCq1pMCCtxqTgEANHMs9JVv7MrZU
         4r6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vf1+KHa5uVuveCfYB76JgHx3nwRL/i8E8jzR5pXq5CM=;
        b=BuAp9+dTjjddrl7mqvvZFuGi5X9cEAzIFLuyLSl/gbxoJDjWiDvdRVBhyugfxiIbTj
         FbuDCWOb/f9+hGzFfOS4ToImKwZeFHV34qiGzsD7uG4jlChttpIW3nHC4bNQnvmJCzaM
         8XO57pjrXl4LM6s8uKXQzS2/avKnxOS7cmNcohzOrxnj8OLCQnDNCQN3YCyI9/bCTe/1
         uZvIhW49lROk01nMwvVWBti2dO+n/nO5f3A69BFIOeiL4yiKFeaxTvdbfHo5jKVSVHDg
         hYhw5kkFSU3tX3ZgD6XQaGzkkFDvgrCMiAhw5hjMibat2yUl58PGTYtjbu9ktEWAaoR2
         QPcQ==
X-Gm-Message-State: AOAM530UVfOSjvhMQ+1qwe80Ci1On3tac0qfrIv21BN5SkWYyrvxuvtK
        cq8vtE/G6kfpTEnPFyePx48TDRZxHEaLnyEzuTCNTyia7+cKUw==
X-Google-Smtp-Source: ABdhPJxOJKnhu6jfZnkPiuUcCcpd1Ww4p4I+9IJ5b5szM6uLrmJpaYMzwcR+/qwxiGYdRlE8nD9F2V9RjT/WG6zQjP0=
X-Received: by 2002:ac8:7ca:: with SMTP id m10mr7590184qth.86.1591322932936;
 Thu, 04 Jun 2020 19:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAOnJCU+jkYSVa-vMjabdnRpubK0c52VgjjVreC=07L_Vr3C64g@mail.gmail.com>
 <mhng-6a5f967f-96fa-4476-ad99-50b2c3962a66@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-6a5f967f-96fa-4476-ad99-50b2c3962a66@palmerdabbelt-glaptop1>
From:   Vincent Chen <vincent.chen@sifive.com>
Date:   Fri, 5 Jun 2020 10:08:42 +0800
Message-ID: <CABvJ_xiJ9iMiqCo-xtCvsOTQcsUwAXQmunbz1a+Qkf__5NJw_w@mail.gmail.com>
Subject: Re: [GIT PULL] RISC-V Patches for the 5.8 Merge Window, Part 1
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 5, 2020 at 4:15 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Thu, 04 Jun 2020 12:50:13 PDT (-0700), atishp@atishpatra.org wrote:
> > On Thu, Jun 4, 2020 at 11:57 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> >>
> >> The following changes since commit b9bbe6ed63b2b9f2c9ee5cbd0f2c946a2723f4ce:
> >>
> >>   Linux 5.7-rc6 (2020-05-17 16:48:37 -0700)
> >>
> >> are available in the Git repository at:
> >>
> >>   git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.8-mw0
> >>
> >> for you to fetch changes up to 09c0533d129ce460e6214c14f744ddbac3733889:
> >>
> >>   soc: sifive: l2 cache: Mark l2_get_priv_group as static (2020-05-28 15:57:49 -0700)
> >>
> >> ----------------------------------------------------------------
> >> RISC-V Patches for the 5.8 Merge Window, Part 1
> >>
> >> * The remainder of the code necessary to support the Kendryte K210.
> >>     * Support for building device trees into the kernel, as the K210 doesn't
> >>       have a bootloader that provides one.
> >>     * A K210 device tree and the associated defconfig update.
> >>     * Support for skipping PMP initialization on systems that trap on PMP
> >>       accesses rather than treating them as WARL.
> >> * Support for KGDB.
> >> * Improvements to text patching.
> >> * Some cleanups to the SiFive L2 cache driver.
> >>
> >> I may have a second part, but I wanted to get this out earlier rather than
> >> later as they've been ready to go for a while now.
> >>
> > Hi Palmer,
> > Can you also add the run time cpu hotplug fix patch if it is not too late?
> >
> > https://patchwork.kernel.org/patch/11581221/
> >
> > Without the patch, cpu hotplug will broken for 5.8-rc1 too.
>
> It looks like there's enough to warrant a part 2 (that fix, the vDSO stuff,
> some Kconfig stuff, and the interrupt stuff).  Some of that was held back to
> avoid conflicts, so it'd be easier for me if this just goes in as-is and I can
> start putting together another PR based on the post-merge commit.
>
> >> ----------------------------------------------------------------
> >> Damien Le Moal (1):
> >>       riscv: K210: Update defconfig
> >>
> >> Palmer Dabbelt (5):
> >>       riscv: Allow device trees to be built into the kernel
> >>       riscv: K210: Add a built-in device tree
> >>       RISC-V: Skip setting up PMPs on traps
> >>       soc: sifive: l2 cache: Eliminate an unsigned zero compare warning
> >>       soc: sifive: l2 cache: Mark l2_get_priv_group as static
> >>
> >> Vincent Chen (4):
> >>       kgdb: Add kgdb_has_hit_break function
> >>       riscv: Add KGDB support
> >>       riscv: Use the XML target descriptions to report 3 system registers
> >>       riscv: Add SW single-step support for KDB
> >>
Hi Palmer:
The "kgdb: enable arch to support XML packet support." patch seems to
be missing in this pull request. By the way, I recently sent the v5
KGDB patch set to fix some compile warning reported by Kbuild system
and select CONFIG ARCH_OPTIONAL_KERNEL_RWX in Kconfig to enable KGDB
to insert software breakpoints. If the v5 KGDB patch set is OK for
you, could you replace it with the v5 KGDB patch set?
Thank you.

> >> Yash Shah (2):
> >>       riscv: cacheinfo: Implement cache_get_priv_group with a generic ops structure
> >>       riscv: Add support to determine no. of L2 cache way enabled
> >>
> >> Zong Li (3):
> >>       riscv: Remove the 'riscv_' prefix of function name
> >>       riscv: Use NOKPROBE_SYMBOL() instead of __krpobes annotation
> >>       riscv: Use text_mutex instead of patch_lock
> >>
> >>  arch/riscv/Kbuild                       |   1 +
> >>  arch/riscv/Kconfig                      |   7 +
> >>  arch/riscv/Kconfig.socs                 |  17 +-
> >>  arch/riscv/boot/dts/Makefile            |   2 +
> >>  arch/riscv/boot/dts/kendryte/Makefile   |   4 +-
> >>  arch/riscv/configs/nommu_k210_defconfig |   7 +-
> >>  arch/riscv/include/asm/cacheinfo.h      |  15 ++
> >>  arch/riscv/include/asm/gdb_xml.h        | 117 ++++++++++
> >>  arch/riscv/include/asm/kdebug.h         |  12 +
> >>  arch/riscv/include/asm/kgdb.h           | 112 +++++++++
> >>  arch/riscv/include/asm/parse_asm.h      | 219 ++++++++++++++++++
> >>  arch/riscv/include/asm/patch.h          |   4 +-
> >>  arch/riscv/include/asm/soc.h            |  39 ++++
> >>  arch/riscv/kernel/Makefile              |   1 +
> >>  arch/riscv/kernel/cacheinfo.c           |  17 ++
> >>  arch/riscv/kernel/ftrace.c              |  15 +-
> >>  arch/riscv/kernel/head.S                |  11 +-
> >>  arch/riscv/kernel/kgdb.c                | 390 ++++++++++++++++++++++++++++++++
> >>  arch/riscv/kernel/patch.c               |  46 ++--
> >>  arch/riscv/kernel/setup.c               |   4 +
> >>  arch/riscv/kernel/soc.c                 |  27 +++
> >>  arch/riscv/kernel/traps.c               |   5 +
> >>  arch/riscv/kernel/vmlinux.lds.S         |   5 +
> >>  arch/riscv/mm/init.c                    |   9 +
> >>  drivers/soc/kendryte/k210-sysctl.c      |  12 +
> >>  drivers/soc/sifive/sifive_l2_cache.c    |  40 +++-
> >>  kernel/debug/debug_core.c               |  12 +
> >>  27 files changed, 1119 insertions(+), 31 deletions(-)
> >>  create mode 100644 arch/riscv/include/asm/cacheinfo.h
> >>  create mode 100644 arch/riscv/include/asm/gdb_xml.h
> >>  create mode 100644 arch/riscv/include/asm/kdebug.h
> >>  create mode 100644 arch/riscv/include/asm/kgdb.h
> >>  create mode 100644 arch/riscv/include/asm/parse_asm.h
> >>  create mode 100644 arch/riscv/kernel/kgdb.c
> >>
>
