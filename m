Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A180C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 13:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73CFD2082F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 13:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rqUeg7CR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730435AbgFRNwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 09:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730451AbgFRNwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 09:52:14 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40E8C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 06:52:14 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id i25so7160285iog.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 06:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eVS/S6zyAsSq/6kuxFunRg89oD8Dg+SRXmL6IJBqxCA=;
        b=rqUeg7CRBj/e3o5psD3Os41N/M9sCjUS5dfPl+E5LMVF1R8oOpB9IXJZM8PtZ+nc8j
         Qvm9HVCGBrXpnn5qynSeUmxb2IPFifqr0dBbWI9HqUZGWf0GSx8i5QUCCkjZ8elYQtBP
         b3hfvtxeTNicoL/D/JAzKaA9DKqcD1gHudHwJT/06PQOczjmTzr6cQCu9zK3K48w1PdR
         4/t8RoP0MoJRApcm0skwCKkbVwcnMDNj+FxTyZ0afH4Xjoa6+qoc9s9oyG9evC6wufvJ
         ny5hPe/zIPPnG3WZB2qQBL77PaOcfLd+xl716Dn8l3tbxc7t/S3cgLMDPp1b1MBmrCl5
         L2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eVS/S6zyAsSq/6kuxFunRg89oD8Dg+SRXmL6IJBqxCA=;
        b=DhNCNif0SUcvs0WFaFHvZkhRO2HzgpS7A8AHk7T66IoomPehq1Ks5rL1Uc4+D2Hcgy
         a4zqVT8Xie/V4CVoU+HUrqSkVL1vVjDmk6h/qEQjV8pvf+laElrV32ndOrGFcyL7xDOE
         EE0ht8tPU0wnbMoVnWh9qVucVijU/bBqxX3UfMyXIbH/LLiDSQeMfrOjXGv2WBS77WKY
         yGpCR8+VhJAnGOijiTgthn0FHK7dBR2mIfmD1mKCrFwq7B/vZIrKzRkAqyuLU4hy1+QN
         hOaSpvG9RzyxIOoUFxrryeQVmfjI+k0B8S4arlsbQWG1QneLOyBsR7hWA3+3wBKIWuOa
         +KuQ==
X-Gm-Message-State: AOAM530GjSGQlgLTiUkyVIyqOGupMvG6+SRGKVoyw7QiBjYKc2gz+EVb
        k8F0ff+fMt8ZAmjuNpM4WuG98eFGidkBJoIxvnDrhJPQuJI=
X-Google-Smtp-Source: ABdhPJzAevsDs5/CaxSbOZu2xtpXyUD7rhoaK3SdCfk6sEhUCveLuzp7FVrX982QQ4FRaXax0ahV2oohzWFZMwlZ7vU=
X-Received: by 2002:a5e:a61a:: with SMTP id q26mr4916808ioi.207.1592488334169;
 Thu, 18 Jun 2020 06:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <87mu5roov6.fsf@nanos.tec.linutronix.de> <20200529082618.1697-1-laijs@linux.alibaba.com>
 <CALCETrXKdh=nBWz96pow5roLmh0ez2YeQ9P+H5gxdor5TfrqUQ@mail.gmail.com> <CAJhGHyBSzhm7h5dROAKSzdSD3czmUNG+80rS9tpaau_U23p4Ug@mail.gmail.com>
In-Reply-To: <CAJhGHyBSzhm7h5dROAKSzdSD3czmUNG+80rS9tpaau_U23p4Ug@mail.gmail.com>
From:   Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Date:   Thu, 18 Jun 2020 21:52:02 +0800
Message-ID: <CAJhGHyC+LswHw+=Ymo92CX-ffFB=PJRP0bSLOWEN42KLPfvJ6w@mail.gmail.com>
Subject: Re: [PATCH V2 0/4] x86/entry: simply stack switching when exception
 on userspace
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello and Ping

On Tue, Jun 16, 2020 at 9:56 AM Lai Jiangshan
<jiangshanlai+lkml@gmail.com> wrote:
>
> On Sat, May 30, 2020 at 2:33 AM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Fri, May 29, 2020 at 1:26 AM Lai Jiangshan <laijs@linux.alibaba.com> wrote:
> > >
> > > 7f2590a110b8("x86/entry/64: Use a per-CPU trampoline stack for IDT entries")
> > > has resulted that when exception on userspace, the kernel (error_entry)
> > > always push the pt_regs to entry stack(sp0), and then copy them to the
> > > kernel stack.

Ping Andy Lutomirski for having added the overhead two years ago.

> > >
> > > And recent x86/entry work makes interrupt also use idtentry
> > > and makes all the interrupt code save the pt_regs on the sp0 stack
> > > and then copy it to the thread stack like exception.
> > >

Ping Thomas Gleixner for having added the overhead recently.

>
> Hello, All
>
> This patchset can be smoothly applicable to the newest tip/x86/entry
> which has 5.8-rc1 merged. Which means I don't have to respin/resend it
> until any update is needed.
>
> Could you have a review on it please.
>
> Thanks
> Lai
