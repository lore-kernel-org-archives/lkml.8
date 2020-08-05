Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEEFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D69D22D2C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgHERbT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:31:19 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:34911 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728665AbgHER2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:28:42 -0400
Received: by mail-yb1-f194.google.com with SMTP id y134so18954095yby.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 10:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jIESkjbosNzI2i/4mKhOLQJDIy5XIt98gpDKy5En5c4=;
        b=Yi/UzzzM3z87dUT0oujl32lPhaPVgx2Sn1+vNdHuCqqEBJpFAuNC3KC8ty/ZhyDPl5
         9iDRQJZg7MTbPYrdSCFiB/i4HkH2Tv7DUUusG1FP2dUxkmZ1Ld2gsVzPmNNKMnNQ3CIO
         knLfysXQAQcR6XZI7aP/BJWVSGEDwA8xgIPET41D4z97mLroaQbAhHQcl9IsG3sbl8qO
         of3Ii58DQsw7DnzD9gE8WbL4TJhKpogdqE/uXrpJPhIGLP4eKqVAdNDQq8ttWUWARg58
         AW/66NlMN+t/gZrb4JUO2c/+cPqpfkvzejaRnAWMayfFKokBMp22f1fHdHZ9cK9sIFUk
         EGWg==
X-Gm-Message-State: AOAM530ZmDPU2lVWg4C6zpjT9GGvnSJz1tecJX/MAYYmDADQg1Ue+cEM
        akkvhJCjXFgzmquD4F7pYyMO7hEZEGVIw2nOUkM=
X-Google-Smtp-Source: ABdhPJzte+8NoKSJuGw9eYFA13DSpKHsDBmKqgn4k/Mm9Ytk75/dvy05IZxLYFMiua2sOAJDf1Wocp/j2vKgV+Qprrs=
X-Received: by 2002:a25:4609:: with SMTP id t9mr6233360yba.231.1596648521373;
 Wed, 05 Aug 2020 10:28:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200722152422.72532-1-kernel@esmil.dk> <20200722152422.72532-2-kernel@esmil.dk>
 <CADasFoDfRwcfFHM_Sa-HzwSDyXEr2PNu3Wfe5riwZJM9XsELBQ@mail.gmail.com>
In-Reply-To: <CADasFoDfRwcfFHM_Sa-HzwSDyXEr2PNu3Wfe5riwZJM9XsELBQ@mail.gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Wed, 5 Aug 2020 19:28:29 +0200
Message-ID: <CANBLGcym5LER30xEVCmVU=6BTNTTLJDUL72DnVSB0V2MsBOwuA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] riscv: Clean up module relocations
To:     Luke Nelson <lukenels@cs.washington.edu>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        Zong Li <zong@andestech.com>, Andreas Schwab <schwab@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, Xi Wang <xi.wang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jul 2020 at 20:53, Luke Nelson <lukenels@cs.washington.edu> wrote:
>
> Thanks for the patch!
>
> > Also RISC-V has a number of instruction pairs to
> > generate 32bit immediates or jump/call offsets. Eg.:
> >
> > lui   rd, hi20
> > addi  rd, rd, lo12
>
> On RV64, both hi20 from lui and lo12 from addi are sign-extended to 64 bits.
> This means that there are some 32-bit signed offsets (in the range
> [2^31-2^11, 2^31-1])
> that are not encodable using (lui+addi), (auipc+jalr), etc. (see
> discussion at [1]).
>
> The following note is from the ISA manual:
> >>> Note that the set of address offsets that can be formed by pairing LUI with LD,
> >>> AUIPC with JALR, etc. in RV64I is [−2^31−2^11, 2^31−2^11−1].

Good point!

> The existing code and the new code both seem buggy if the offset happens to
> be a 32-bit int but falls outside of the encodable range.
>
> > +       if (offset != (s32)offset) {
> > [...]
> > +       if (offset != (s32)offset) {
> > [...]
>
> These checks should probably be replaced with something similar to
> what's used in the RV64 BPF JIT here: [2],
> except that this code should check if using RV32 or RV64, since the
> encodable range differs for each.

Yeah, I decided to leave these checks as they are to not change
everything at once, but I'll see if I can improve on those in the next
version.

> > My hope is that we can eventually factor out the code to generate
> > immediates and instructions so it can be reused both here, in the
> > jump-label code and in the bpf-jit code, but let's take it
> > one step at a time.
>
> This sounds great! Having fewer copies of RISC-V encoding logic around will
> hopefully decrease the likelihood of bugs :) Some other archs already
> have shared
> infrastructure for doing instruction encoding (e.g., in
> arch/arm64/kernel/insn.c);
> we should consider doing something similar for RISC-V.

Exactly this. I've even tried to copy the naming from arm64 as well.
I'll send a 2nd version of this after -rc1.

>
> - Luke Nelson
>
> [1]: https://groups.google.com/a/groups.riscv.org/forum/#!topic/isa-dev/bwWFhBnnZFQ
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/?id=489553dd13a88d8a882db10622ba8b9b58582ce4
