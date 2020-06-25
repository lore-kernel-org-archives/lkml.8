Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5665C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 17:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD640207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 17:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593107773;
	bh=P85gb0RYxs8bdscv/UzJZV8GMZKO6FNZmtLISXWaRkI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eVqBxr8Mto2nkZgaCDdbIoDCXlOnIaV1OkYPvZphEA9RC5fWdv5ZU95X/e11+InDb
	 ystb2wfbnQ9PahfwVRBQEZzGpJdMfZmQg4oBd90LIbvyL0Hn6yl7vhbM6L/bcN21jW
	 yJ9abt0hLsgDC2MZnFxZoAsbXDVsbn0pFWLYR//o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406957AbgFYR4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 13:56:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:34678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405512AbgFYR4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 13:56:11 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A68D4208C7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 17:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593107770;
        bh=P85gb0RYxs8bdscv/UzJZV8GMZKO6FNZmtLISXWaRkI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oKVWfvoGv7fuIwzL2lqOsnY8d0mXHBPXz6dV//HQfdCW1l2sfTW2ApQkAZO+2jvXH
         N0NKmYVRu3N7wTkF8pT1cJRqAVMcYDkz5u5tt107w2JCYbcC4uTvmEWDOWR1AkdRHp
         L+E6hvq2jfQPexZDLIr8zDUu+RZSNmNoPvube2N8=
Received: by mail-wm1-f54.google.com with SMTP id f139so6857244wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 10:56:10 -0700 (PDT)
X-Gm-Message-State: AOAM532WNayHktw1s0NJMEJHE0v7MqAjsKXLFh1ZVtkjR+iLycEAunml
        3DARlL2ySd2U8ugrquOJS14JoOjeh2upRkNWiYPcPg==
X-Google-Smtp-Source: ABdhPJyD6H4S6WO9N1l9zzdg3mNnfR0NeQ/s4mEYulZWDN4TxbiqvfmMcS6fjAEL2b515bNpz9Ocp+EVy/cNkq/McJw=
X-Received: by 2002:a1c:b143:: with SMTP id a64mr4970455wmf.133.1593107769134;
 Thu, 25 Jun 2020 10:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200618122537.9625-9-dbrazdil@google.com> <202006251244.YDWclRrq%lkp@intel.com>
 <d807e83db1f1052378b6998f683e4617@kernel.org>
In-Reply-To: <d807e83db1f1052378b6998f683e4617@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 25 Jun 2020 19:55:58 +0200
X-Gmail-Original-Message-ID: <CAKv+Gu-82CKeKvYozmnqnoBDDdJUfc3xxfXv6w4LHPnN5uvyGA@mail.gmail.com>
Message-ID: <CAKv+Gu-82CKeKvYozmnqnoBDDdJUfc3xxfXv6w4LHPnN5uvyGA@mail.gmail.com>
Subject: Re: [PATCH v3 08/15] arm64: kvm: Split hyp/switch.c to VHE/nVHE
To:     Marc Zyngier <maz@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        android-kvm@google.com, Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        David Brazdil <dbrazdil@google.com>,
        Will Deacon <will@kernel.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Julien Thierry <julien.thierry.kdev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jun 2020 at 10:16, Marc Zyngier <maz@kernel.org> wrote:
>
> On 2020-06-25 06:03, kernel test robot wrote:
> > Hi David,
> >
> > Thank you for the patch! Perhaps something to improve:
> >
> > [auto build test WARNING on linus/master]
> > [also build test WARNING on v5.8-rc2 next-20200624]
> > [cannot apply to kvmarm/next arm64/for-next/core
> > arm-perf/for-next/perf]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use  as documented in
> > https://git-scm.com/docs/git-format-patch]
> >
> > url:
> > https://github.com/0day-ci/linux/commits/David-Brazdil/Split-off-nVHE-hyp-code/20200618-203230
> > base:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > 1b5044021070efa3259f3e9548dc35d1eb6aa844
> > config: arm64-randconfig-r021-20200624 (attached as .config)
> > compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project
> > 8911a35180c6777188fefe0954a2451a2b91deaf)
> > reproduce (this is a W=1 build):
> >         wget
> > https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> > -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install arm64 cross compiling tool for clang build
> >         # apt-get install binutils-aarch64-linux-gnu
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross
> > ARCH=arm64
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> >>> arch/arm64/kvm/hyp/nvhe/switch.c:244:28: warning: no previous
> >>> prototype for function 'hyp_panic' [-Wmissing-prototypes]
> >    void __hyp_text __noreturn hyp_panic(struct kvm_cpu_context
> > *host_ctxt)
>
> I really wish we could turn these warnings off. They don't add much.
> Or is there an annotation we could stick on the function (something
> like __called_from_asm_please_leave_me_alone springs to mind...)?
>

We should define 'asmlinkage' to whatever makes this warning go away.
