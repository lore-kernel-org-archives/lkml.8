Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B66C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 06:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98EEE205C9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 06:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="WUxjxADi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgEBGNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 02:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726468AbgEBGNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 02:13:32 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB378C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 23:13:31 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e16so9226404wra.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 23:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JhvioNVfM97l3WSCiP+ZrH6wOXH1bX9mQnh1D6DTF2o=;
        b=WUxjxADivgi7evwQJxeX8FTGyQPfSbIyMxWdi09e0Gl5jNUaAviU+m7qyQa1vOYuNX
         Ib8FegKZZBHhLQLUq/H4Fqhkrops2Aq7ZifwGWe6RLYxu4SNEYA0wF0SapU8R+1VNEEb
         B1rcWhlN+jLa6I6VRM1Qi97OwvwvTCTqs+B47jxFWAtYVWqjwltT8RxVXKR0EvXHPjTi
         hIHTYMMqCxhzlcd+Kkt5IZRB7rYsvkMM2sjKYtGhokPyvPS0SBsnh5k137vzSJa+NLvk
         wbqDyl332okUupQ4LPaV7PMQEDmTNqsgX5Q4ov3vRj+GBytFtPTByPCvWM8is13zpIlq
         QXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JhvioNVfM97l3WSCiP+ZrH6wOXH1bX9mQnh1D6DTF2o=;
        b=QVcS7X3ABBz85rysPt2Qk81gIoBJ1iJJrke/B6AbKIxdmJln61dv+LDLQfPziBCJfj
         hHFXEaf/4KRI0SNUPz1DxiHbmhV2RK5clhp1DlYw21KSEWDahqTmtcQsNOB1zq94YvKG
         YM7DzlaxiW+9npBgczYPFMF4i0NgBDmm8pkomKpzAOOXD0HXr1rmsL4Fv1ok9yh9sgLh
         mj/YvGJ7ebMjgzOFQcb2eZsleXPx6HCSJJqZdJYK2zybDIQKHsHAEsekQoY4aKdqRNk9
         KABl7kEoRKWovO/OFW8Qg/I44cTYd7DWXwOkF8JLm9scvv6zzWowhJxuAa3yLkBABwYd
         +YaA==
X-Gm-Message-State: AGi0PuYAQymBdfwjDfunW4thY2LpoPRDREbnLCyvwodcm5d2cfMmZVhq
        3mX2cJvEYQ4/7xO030BTLTapsh5o2qe50uowbsNK/jax
X-Google-Smtp-Source: APiQypJJ/DcxxJ+twQ2TVpRpb4je3K4adn5gd15IIE968xX2S249iENDB9dT++Q4fmWa5mZd8TTc58vooYzMz2oxbJk=
X-Received: by 2002:adf:b35c:: with SMTP id k28mr7648219wrd.61.1588400010329;
 Fri, 01 May 2020 23:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200430095325.111441-1-zong.li@sifive.com> <CAOnJCUJBJ3wrY-KY3YgD-qJfr7dsWzdA83fxFYmOTmjsrYgOfA@mail.gmail.com>
 <CANXhq0qk_GQubgWB9=2uMVDSLSCWaiLtPkBcHQCPLCHyVrtdnA@mail.gmail.com>
In-Reply-To: <CANXhq0qk_GQubgWB9=2uMVDSLSCWaiLtPkBcHQCPLCHyVrtdnA@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 2 May 2020 11:43:18 +0530
Message-ID: <CAAhSdy0QRMCm0jWe2azQ-6_D3KPRO60YEX+Wk-+HMrJfwYn_sA@mail.gmail.com>
Subject: Re: [PATCH] riscv: force __cpu_up_ variables to put in data section
To:     Zong Li <zong.li@sifive.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 2, 2020 at 11:30 AM Zong Li <zong.li@sifive.com> wrote:
>
> On Fri, May 1, 2020 at 2:23 AM Atish Patra <atishp@atishpatra.org> wrote:
> >
> > On Thu, Apr 30, 2020 at 2:53 AM Zong Li <zong.li@sifive.com> wrote:
> > >
> > > Put __cpu_up_stack_pointer and __cpu_up_task_pointer in data section.
> > > Currently, these two variables are put in bss section, there is a
> > > potential risk that secondary harts get the uninitialized value before
> > > main hart finishing the bss clearing. In this case, all secondary
> > > harts would go through the waiting loop and enable the MMU before
> > > main hart set up the page table.
> > >
> >
> > That would be only true if you are using random booting protocol with
> > SBI v0.1 implementation.
> > With HSM extension in place, all the secondary cores are waiting in
> > firmware. The booting core
> > will bring them up one by one from cpu_up method.
> >
> > The HSM extension is already available in OpenSBI v0.7 and Linux
> > kernel 5.7-rc1 onwards.
>
> If I understand correctly, the newest kernel still works with earlier
> OpenSBI than v0.7 or BBL. It seems to me that we need to consider the
> use cases if we don't limit it to up to OpenSBI v0.7.

I think the commit description should clearly state that the issue will
manifest only for random booting of multiple HARTs which means it
will manifest only for BBL and OpenSBI v0.6 (or older).

Regards,
Anup
