Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364D0C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 11:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06CCE20732
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 11:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580297715;
	bh=NIsZX4pgljyK2CM9OoHSCXA887GDNOni8VTWXPA7VTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pgkW2UPvMRiSTEfr0opXO4uAlV3xYf9h/pSZnkex1pSOCRQRf5MvwlfJkEVcWcahE
	 D4Zzsr99YDNLeEdB+aADmVJeJw20peOrJPE9f9IQLPMh4YXoffOCVpQo4+W5i8LC2i
	 KJA76ilz3jIAmfJ6GxfE1URm1Ia42XlrYa4quu/Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgA2LfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 06:35:14 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37067 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgA2LfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 06:35:13 -0500
Received: by mail-wr1-f68.google.com with SMTP id w15so19816521wru.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 03:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EvhTSqKe0KTZSxbOIZ3ttCfoqhIVfAMnz2yZe7ho1Gg=;
        b=FFSuItjdKrntW2osVDwsEpGbFPCjQIlrfCBXderoGApcvG9bX/dr5jdLEwSAIR/j1W
         p2zYMlE9r4cpS2cSTpYBDP2OpusV9LcAUaoHGHEJn2aeZlHCNcsvV0nH67PRufpFrmbf
         z7a1W/l/YecEJWkKJfMFdyOeS3HGskV/nXsmMoqndcFduee60Y8jrBJm5V+cTx+ZVOxg
         AjRKGmFd3cgYk64BLHV4Da7Tewj605eY7UZxbSJvZTr6JprcwuZCXbe8JVsExWjr6dFh
         kA97BTRkKadpa5g4quvzUvxtk8f6ThC2ctgNJkWLDuAUi2+npcyeE9Bbkc7wu5oD/pAd
         FxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=EvhTSqKe0KTZSxbOIZ3ttCfoqhIVfAMnz2yZe7ho1Gg=;
        b=DsypbE2OA+nKNBgTIVKIbIm3oIcV0BimBpSw+hrVnRZogTiPDnzgBOp9XX/VYHcefq
         6v5dBGd7SzuaGvqAR3W6683wWfbkxHacEY7xqGm7307Z2HcMr2GXTa5+u5+RWfpEVbbQ
         kv1h0oRcbwbLwcmXoUYHlKzqChZUCUu+iUqveEKC0PO8BN642aZM78DglZqsY3Z6tIjz
         FwmrVygdiY7k9sc+EyDfdHNmwW5j/jhOUgWcKeY2+ArCsPKc1UDkbOLI7lxxwfq7EJhS
         JqP3WDH+1kU2FxgNbuj1yCFxOjWGbKUzEerq8nNUXNLtDxd4yFd1r28Y03U6m/MS5HMK
         uP8Q==
X-Gm-Message-State: APjAAAWzZ70te1X21h8O6/2CZpBo+iuJROpb31HoZzcH7Da8FgKJFNYI
        VedLEQBhsJzoYe8/RyZPElTYp19n
X-Google-Smtp-Source: APXvYqzeKHKlvJowSv5C3aWR0q0arCg96YOaG598FXB2raKvWKP4WEjHJetfsraj4Pau+rwIa47lqA==
X-Received: by 2002:a05:6000:1183:: with SMTP id g3mr6698716wrx.374.1580297712119;
        Wed, 29 Jan 2020 03:35:12 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id q124sm9978903wme.2.2020.01.29.03.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 03:35:11 -0800 (PST)
Date:   Wed, 29 Jan 2020 12:35:09 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] x86/cpu changes for v5.6
Message-ID: <20200129113509.GB89586@gmail.com>
References: <20200128175751.GA35649@gmail.com>
 <CAHk-=wjoZfKFHL0wSsfnm32zv=zWNxtJcPob+1z2+P-tMcdoCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjoZfKFHL0wSsfnm32zv=zWNxtJcPob+1z2+P-tMcdoCg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, Jan 28, 2020 at 9:57 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> >    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cpu-for-linus
> 
> No diffstat in the pull request?
> 
> The shortlog does match, and the diffstat I get looks sane, so I'm
> pulling it, but please fix whatever thing that caused the diffstat to
> not show in the email..
> 
>                  Linus

My bad: I erased the patch part manually and went too far accidentally. :-/

Just for the record, this looks good:

   commit c0275ae758f8ce72306da200b195d1e1d66d0a8d
   Merge: f6170f0afbe2 283bab980978
   Author: Linus Torvalds <torvalds@linux-foundation.org>
   Date:   Tue Jan 28 12:46:42 2020 -0800

And the missing diffstat is attached below.

Thanks,

	Ingo

=============>

 MAINTAINERS                                            |   2 +-
 arch/x86/Kconfig.cpu                                   |   8 ++
 arch/x86/boot/mkcpustr.c                               |   1 +
 arch/x86/include/asm/cpufeatures.h                     |   1 +
 arch/x86/include/asm/msr-index.h                       |  14 +--
 arch/x86/include/asm/perf_event.h                      |  22 +++--
 arch/x86/include/asm/processor.h                       |  11 +--
 arch/x86/include/asm/vmx.h                             | 105 ++++++++++----------
 arch/x86/include/asm/vmxfeatures.h                     |  86 ++++++++++++++++
 arch/x86/kernel/cpu/Makefile                           |   6 +-
 arch/x86/kernel/cpu/bugs.c                             |   7 ++
 arch/x86/kernel/cpu/centaur.c                          |  37 +------
 arch/x86/kernel/cpu/common.c                           |   3 +
 arch/x86/kernel/cpu/cpu.h                              |   4 +
 arch/x86/kernel/cpu/feat_ctl.c                         | 145 +++++++++++++++++++++++++++
 arch/x86/kernel/cpu/intel.c                            |  49 +--------
 arch/x86/kernel/cpu/mce/intel.c                        |  15 +--
 arch/x86/kernel/cpu/mkcapflags.sh                      |  15 ++-
 arch/x86/kernel/cpu/proc.c                             |  15 +++
 arch/x86/kernel/cpu/tsx.c                              |   5 +-
 arch/x86/kernel/cpu/zhaoxin.c                          |  37 +------
 arch/x86/kvm/Kconfig                                   |  10 +-
 arch/x86/kvm/vmx/nested.c                              |   4 +-
 arch/x86/kvm/vmx/vmx.c                                 |  67 ++++---------
 arch/x86/kvm/vmx/vmx.h                                 |   2 +-
 arch/x86/kvm/x86.c                                     |   2 +-
 drivers/idle/intel_idle.c                              |   2 +-
 tools/arch/x86/include/asm/msr-index.h                 |  14 +--
 tools/power/x86/turbostat/turbostat.c                  |   4 +-
 tools/testing/selftests/kvm/Makefile                   |   4 +-
 tools/testing/selftests/kvm/include/x86_64/processor.h | 726 +------------------------------------------------------------------------------------------------------------------------------------
 tools/testing/selftests/kvm/lib/x86_64/vmx.c           |   8 +-
 32 files changed, 432 insertions(+), 999 deletions(-)
 create mode 100644 arch/x86/include/asm/vmxfeatures.h
 create mode 100644 arch/x86/kernel/cpu/feat_ctl.c
