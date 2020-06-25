Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14B8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 18:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1074207FC
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 18:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HpNWW9Mw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406167AbgFYS0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 14:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404019AbgFYS0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 14:26:30 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CC9C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 11:26:30 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id b92so3657628pjc.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 11:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ETOuWEoyx3l3QXnbkpa1FViwhlbDdj5RYMJCyJ/ebAM=;
        b=HpNWW9MwE6vq1Anc++U5txnTPeoSIrQ5ogp/CEHf3tIl/tnClkkszSCuLVxsOR4GPr
         qcQFsZrY1WgOj2xyyC4B017aZ0SuioqBQfuR9KnIkgAV64f3VaENBCHAG8DhybTBfLWK
         nEFxBn9j+386lOrjYHH726Abn7OdM3h2OFxvJqy5JV3xyI9J3wmHkmuLKsxidkQM0CMc
         EPug7d2CnudNRbjNrBVRx4MWrw8Oq4VXLovuCt05RFqTRT8U6a+Cl07V05KuUk8znw0t
         kgonB3v/6h4/vMMeve6EqnJsVah4jQabfhkmvBLZi0X9dlQkDwQnDrKzuz714RG2j/Hc
         aRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ETOuWEoyx3l3QXnbkpa1FViwhlbDdj5RYMJCyJ/ebAM=;
        b=VI0Evt2l30emAKIrqMQ/7wj2GTa9alTNbgD3YuJZgqB0grSXpTBZiv1vVeROUlCMQe
         +Q2rxWJQEkoUXPPRdIdc9c9FH8vAPYUiIUdRCMKHu1VKDB6Rjo/sdf1PcFjyUnMXTMeb
         mwDz/c1CrMA1eYjMP0SzLrCPkUFwLsOSjBfX018ZqDxIPgCoIa/sEkEVSg+tu4RPMBhm
         u5eF6tBdd1jKweggR5emJXjVuPmZJu8PTdaVruWOi2RYTAmkpfHGPoB8IfSLqVqFnxS1
         7Rlo/zSwWs5oNDTaZhs6fk3LvBU59LBvgzbManicEBH8TKA4iIz0CTy/W0Hqj4FTE3gA
         847w==
X-Gm-Message-State: AOAM532/cdyPm3DAvMv9nI+hyog+ndFJyHDdcB2n3H0InrqLjsrOdtwx
        77GQjjl3yLotoGigSgDABJHTXSzIPzaazoW04EjkVA==
X-Google-Smtp-Source: ABdhPJx842ihVSXEC+dRBn4T1wBfiF1wZmkEpTThe17QN8NnIH9b7pknjYgr+o16BK9UFkYWqyd4uw/Uf/cSkjGAC0Q=
X-Received: by 2002:a17:902:b698:: with SMTP id c24mr33333972pls.223.1593109590004;
 Thu, 25 Jun 2020 11:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200618122537.9625-9-dbrazdil@google.com> <202006251244.YDWclRrq%lkp@intel.com>
 <d807e83db1f1052378b6998f683e4617@kernel.org> <20200625083441.GB7584@willie-the-truck>
In-Reply-To: <20200625083441.GB7584@willie-the-truck>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 25 Jun 2020 11:26:18 -0700
Message-ID: <CAKwvOd=TswBPY7J-VH6hm80O0eq6GPA_7YUsuddwq3RHaDMQfA@mail.gmail.com>
Subject: Re: [PATCH v3 08/15] arm64: kvm: Split hyp/switch.c to VHE/nVHE
To:     Will Deacon <will@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, kernel test robot <lkp@intel.com>,
        David Brazdil <dbrazdil@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kvmarm@lists.cs.columbia.edu,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, android-kvm@google.com,
        Philip Li <philip.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 1:34 AM Will Deacon <will@kernel.org> wrote:
>
> On Thu, Jun 25, 2020 at 09:16:03AM +0100, Marc Zyngier wrote:
> > On 2020-06-25 06:03, kernel test robot wrote:
> > > Hi David,
> > >
> > > Thank you for the patch! Perhaps something to improve:
> > >
> > > [auto build test WARNING on linus/master]
> > > [also build test WARNING on v5.8-rc2 next-20200624]
> > > [cannot apply to kvmarm/next arm64/for-next/core arm-perf/for-next/perf]
> > > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > > And when submitting patch, we suggest to use  as documented in
> > > https://git-scm.com/docs/git-format-patch]
> > >
> > > url:
> > > https://github.com/0day-ci/linux/commits/David-Brazdil/Split-off-nVHE-hyp-code/20200618-203230
> > > base:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > > 1b5044021070efa3259f3e9548dc35d1eb6aa844
> > > config: arm64-randconfig-r021-20200624 (attached as .config)
> > > compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project
> > > 8911a35180c6777188fefe0954a2451a2b91deaf)
> > > reproduce (this is a W=1 build):
> > >         wget
> > > https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> > > -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # install arm64 cross compiling tool for clang build
> > >         # apt-get install binutils-aarch64-linux-gnu
> > >         # save the attached .config to linux build tree
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross
> > > ARCH=arm64
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > > All warnings (new ones prefixed by >>):
> > >
> > > > > arch/arm64/kvm/hyp/nvhe/switch.c:244:28: warning: no previous
> > > > > prototype for function 'hyp_panic' [-Wmissing-prototypes]
> > >    void __hyp_text __noreturn hyp_panic(struct kvm_cpu_context
> > > *host_ctxt)
> >
> > I really wish we could turn these warnings off. They don't add much.
> > Or is there an annotation we could stick on the function (something
> > like __called_from_asm_please_leave_me_alone springs to mind...)?
>
> Agreed, I've caught myself skim-reading the kbuild robot reports now
> because they're often just noise, and then having to force myself to look at
> them properly when I remember. Even just something in the subject to
> say "the only problems are W=1 warnings" would help. Is that possible?

When the W=1 reports started showing up, it took me a while to figure
out these warnings were only enabled at W=1.  I asked Philip to help
denote these in the reports, and Philip was kind enough to add a note
in the report about W=1.  I agree that the note could still be more
prominent.  Another part of me wants to move -Wmissing-prototypes to
W=2, but that's just biding time until 0day starts reporting on those.

-- 
Thanks,
~Nick Desaulniers
