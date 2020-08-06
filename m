Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23909C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 707372086A
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596732756;
	bh=6Ibsyaw2FefxKuClRyPVKKIN/nMVuRAur37qCTL3o1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1spqQSbFqzBCm+wzIqeBHQWncUt/ljSnQeYZVAW8njhku3c+PTLQzxh6/XXhT//E+
	 fLGBDquxJXuEAfFz888fO1h5qMQ2vbLEWAw56qCbCND1OU1z2nBJgzBEXJsZ2a+d14
	 opvDK7O1DptBaDi12E9rUGCV03KPKTe58QdYkdQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbgHFQwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729509AbgHFQvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:51:03 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEE4C0086AE
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 08:33:05 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id m22so7685225eje.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 08:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BJRVvbJ27WTMdqqsxMOJteTWJIZ1QhBp8oNNmFI81Ts=;
        b=J1kms1Jb+DBdy5tnRvsQhyY5wCNWWMDZ5UhkCcv51jnBWIEP44sPwLQU49f/DZ+UqN
         ATRIAgR5nrdJESlIXlZA9JZ6VKqbSeiFL/eDWjrZ17nG2Ziot8JbxvgwwSIkH01rc0cR
         nOhlq03lA6XNLqBreq14AIiCB/cp+NF6DbLjLsfX5U5bLr7cNzGSD//gmVIJ5O6Q/Lqy
         RoMZp0mSuIgDbjVFKx6NfBplUOIYCKTKQSn3FN7/iAu0Vztf8okVp2gwU+ed5xee6l8o
         qi87urfH+G2reTX5kcSC/y7C4xYkqmssnH6WMScQbUXpQbs8N1doCrUy1DBsHjTXOgZb
         7kag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=BJRVvbJ27WTMdqqsxMOJteTWJIZ1QhBp8oNNmFI81Ts=;
        b=bCL5x9XxO9Qud8gHrCwjYwLZtpLTNR5YhPE+zqOIIbjcoIGKxIr5TDrJKqE/aVx04o
         hC1/D7m98+9WLVgJWBU74Y1XjzP+2OoHshN4PoewRvAQv6oMg39HH7mqARZjRP0XgS5h
         4Q7/IRNByBeswuaMitHQmNU5B55W6wGA1U7+H0hGP8O+5UO8cCInQRIBETX7YRRyiyS4
         igFFtkyRJjQBuBuDwrZTv9Lgj8gRg894tf0fuFro6IYE1ksVkpYybu7roaJEFbZtKOLf
         9HNBuVsJFizuWucAVnYc/8+cGew55XgH/6dOtkS899uQxY5KFJeUfl96PRKtAON8JYjP
         zhig==
X-Gm-Message-State: AOAM531b/VYbi4haLk0Ldwn/DeM+tRuxMmh6ol1co9C2GbdZx0UfSAV9
        WqG5JC4qdcC61DXV+4AtI0A=
X-Google-Smtp-Source: ABdhPJzKadYqu9DuxT6yEhY+yLfMI17678fAKsD2zLmixlazR3kmBiWq46Lgd5M0wGB4iVXxcsq0vA==
X-Received: by 2002:a17:907:10d9:: with SMTP id rv25mr4656328ejb.264.1596727984179;
        Thu, 06 Aug 2020 08:33:04 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id u13sm3984781ejc.72.2020.08.06.08.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 08:33:02 -0700 (PDT)
Date:   Thu, 6 Aug 2020 17:32:58 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     keescook@chromium.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, arjan@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        rick.p.edgecombe@intel.com
Subject: Re: [PATCH v4 00/10] Function Granular KASLR
Message-ID: <20200806153258.GB2131635@gmail.com>
References: <20200717170008.5949-1-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717170008.5949-1-kristen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Kristen Carlson Accardi <kristen@linux.intel.com> wrote:

> Function Granular Kernel Address Space Layout Randomization (fgkaslr)
> ---------------------------------------------------------------------
> 
> This patch set is an implementation of finer grained kernel address space
> randomization. It rearranges your kernel code at load time 
> on a per-function level granularity, with only around a second added to
> boot time.

This is a very nice feature IMO, and it should be far more effective 
at randomizing the kernel, due to the sheer number of randomization 
bits that kernel function granular randomization presents.

If this is a good approximation of fg-kaslr randomization depth:

  thule:~/tip> grep ' [tT] ' /proc/kallsyms  | wc -l
  88488

... then that's 80K bits of randomization instead of the mere handful 
of kaslr bits we have today. Very nice!

> In order to hide our new layout, symbols reported through 
> /proc/kallsyms will be displayed in a random order.

Neat. :-)

> Performance Impact
> ------------------

> * Run time
> The performance impact at run-time of function reordering varies by workload.
> Using kcbench, a kernel compilation benchmark, the performance of a kernel
> build with finer grained KASLR was about 1% slower than a kernel with standard
> KASLR. Analysis with perf showed a slightly higher percentage of 
> L1-icache-load-misses. Other workloads were examined as well, with varied
> results. Some workloads performed significantly worse under FGKASLR, while
> others stayed the same or were mysteriously better. In general, it will
> depend on the code flow whether or not finer grained KASLR will impact
> your workload, and how the underlying code was designed. Because the layout
> changes per boot, each time a system is rebooted the performance of a workload
> may change.

I'd guess that the biggest performance impact comes from tearing apart 
'groups' of functions that particular workloads are using.

In that sense it might be worthwile to add a '__kaslr_group' function 
tag to key functions, which would keep certain performance critical 
functions next to each other.

This shouldn't really be a problem, as even with generous amount of 
grouping the number of randomization bits is incredibly large.

> Future work could identify hot areas that may not be randomized and either
> leave them in the .text section or group them together into a single section
> that may be randomized. If grouping things together helps, one other thing to
> consider is that if we could identify text blobs that should be grouped together
> to benefit a particular code flow, it could be interesting to explore
> whether this security feature could be also be used as a performance
> feature if you are interested in optimizing your kernel layout for a
> particular workload at boot time. Optimizing function layout for a particular
> workload has been researched and proven effective - for more information
> read the Facebook paper "Optimizing Function Placement for Large-Scale
> Data-Center Applications" (see references section below).

I'm pretty sure the 'grouping' solution would address any real 
slowdowns.

I'd also suggest allowing the passing in of a boot-time pseudo-random 
generator seed number, which would allow the creation of a 
pseudo-randomized but repeatable layout across reboots.

> Image Size
> ----------
> Adding additional section headers as a result of compiling with
> -ffunction-sections will increase the size of the vmlinux ELF file.
> With a standard distro config, the resulting vmlinux was increased by
> about 3%. The compressed image is also increased due to the header files,
> as well as the extra relocations that must be added. You can expect fgkaslr
> to increase the size of the compressed image by about 15%.

What is the increase of the resulting raw kernel image? Additional 
relocations might increase its size (unless I'm missing something) - 
it would be nice to measure this effect. I'd expect this to be really 
low.

vmlinux or compressed kernel size doesn't really matter on x86-64, 
it's a boot time only expense well within typical system resource 
limits.

> Disabling
> ---------
> Disabling normal KASLR using the nokaslr command line option also disables
> fgkaslr. It is also possible to disable fgkaslr separately by booting with
> fgkaslr=off on the commandline.

I'd suggest to also add a 'nofgkaslr' boot option if it doesn't yet 
exist, to keep usage symmetric with kaslr.

Likewise, there should probably be a 'kaslr=off' option as well.

The less random our user interfaces are, the better ...

>  arch/x86/boot/compressed/Makefile             |   9 +-
>  arch/x86/boot/compressed/fgkaslr.c            | 811 ++++++++++++++++++
>  arch/x86/boot/compressed/kaslr.c              |   4 -
>  arch/x86/boot/compressed/misc.c               | 157 +++-
>  arch/x86/boot/compressed/misc.h               |  30 +
>  arch/x86/boot/compressed/utils.c              |  11 +
>  arch/x86/boot/compressed/vmlinux.symbols      |  17 +
>  arch/x86/include/asm/boot.h                   |  15 +-
>  arch/x86/kernel/vmlinux.lds.S                 |  17 +-
>  arch/x86/lib/kaslr.c                          |  18 +-
>  arch/x86/tools/relocs.c                       | 143 ++-
>  arch/x86/tools/relocs.h                       |   4 +-
>  arch/x86/tools/relocs_common.c                |  15 +-
>  include/asm-generic/vmlinux.lds.h             |  18 +-
>  include/linux/decompress/mm.h                 |  12 +-
>  include/uapi/linux/elf.h                      |   1 +
>  init/Kconfig                                  |  26 +
>  kernel/kallsyms.c                             | 163 +++-
>  kernel/module.c                               |  81 ++
>  tools/objtool/elf.c                           |   8 +-
>  26 files changed, 1670 insertions(+), 85 deletions(-)
>  create mode 100644 Documentation/security/fgkaslr.rst
>  create mode 100644 arch/x86/boot/compressed/fgkaslr.c
>  create mode 100644 arch/x86/boot/compressed/utils.c
>  create mode 100644 arch/x86/boot/compressed/vmlinux.symbols

This looks surprisingly lean overall.

Thanks,

	Ingo
