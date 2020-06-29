Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDACC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89710204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PDfV+Se+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390910AbgF2VUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390903AbgF2VU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:20:26 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768ACC061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:20:26 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id f24so10057538vsg.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PvQsP2K1IWOWSErQkN4kOg/ZkRvv96UfS68Sc9P6pYw=;
        b=PDfV+Se+yMQ06TSOXI9VBLeM9L1MJl1ZGEEhtbRJvxiOKVAraxRnu6LXXdEaMEruK8
         Le6n8m2csF3UzAPIVfVkNJv8gcn4XGM/iQKosYIESa/2V7rRG+0PyMov4gYgKuzQE2DT
         kIPVCkP74x/rEcwqpqhX3pupL8W4PJNNkdMWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PvQsP2K1IWOWSErQkN4kOg/ZkRvv96UfS68Sc9P6pYw=;
        b=V10ZZr9eqQfxKpA8H4lVERhwBSHMUw5OnXA3B6zWCFNXVRlbsyiOrmuGDDAS8QM1VS
         7FR9qikmb5pL0wtXZ5CAP1Ko+cHp4bnQxbzCyR2XFo3Xm+wHYn9a/rPnxFvMCGWqq1Ca
         kPF/TF4qLn6Tx16q9LW0SmbUnUFe9baeuX395qtJ9x9k3l96Y3Be9RyeY2geb6sn5UrA
         lAxRbbnRBgIEL54WVeVqlXXARlcrx+x0vHpL9l+d2kZcKkTwCeKVmzFuHLiLXLAG6ENG
         XLGrn1To42eaEpmRkDQfAHIf1MPc7LKYc9ZL5cJAek4LSetoGbhE5nLb+o1G/FXyDTw8
         CLBg==
X-Gm-Message-State: AOAM530xJQ24vRPYRAA+kjdK0q7bvhDZnU4NL5BHCJCDt+fOPpM30A5b
        4nozfMPfziem+A+PeBNcseib6zHwmAs=
X-Google-Smtp-Source: ABdhPJxxfEhkXHrP7morNwB983hPYKxBv/f5pH+TlQOh199w1sqQl+aqXSZLmIuuL4SEhXV23R0yWA==
X-Received: by 2002:a67:7743:: with SMTP id s64mr13228041vsc.131.1593465625305;
        Mon, 29 Jun 2020 14:20:25 -0700 (PDT)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id f133sm146713vke.23.2020.06.29.14.20.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 14:20:24 -0700 (PDT)
Received: by mail-vk1-f173.google.com with SMTP id s192so4067647vkh.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:20:23 -0700 (PDT)
X-Received: by 2002:a1f:974d:: with SMTP id z74mr11382079vkd.40.1593465623410;
 Mon, 29 Jun 2020 14:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200509214159.19680-1-liwei391@huawei.com> <CAD=FV=Xv6xgj_M9tYjHzmW4UZD2RdH2c5=dagNybSkdfBabYZw@mail.gmail.com>
 <a20ee677-495b-9336-a329-eabd50dd1cad@huawei.com>
In-Reply-To: <a20ee677-495b-9336-a329-eabd50dd1cad@huawei.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 29 Jun 2020 14:20:11 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WYBAJB_nWxUAAVgV26e4CTzJeizZtxpwus6REi3j2meA@mail.gmail.com>
Message-ID: <CAD=FV=WYBAJB_nWxUAAVgV26e4CTzJeizZtxpwus6REi3j2meA@mail.gmail.com>
Subject: Re: [PATCH 0/4] arm64: kgdb/kdb: Fix single-step debugging issues
To:     "liwei (GF)" <liwei391@huawei.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        David Miller <davem@davemloft.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, liwei1412@163.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei,

On Sat, May 16, 2020 at 1:20 AM liwei (GF) <liwei391@huawei.com> wrote:
>
> Hi Douglas,
>
> On 2020/5/14 8:34, Doug Anderson wrote:
> > Hi,
> >
> > On Sat, May 9, 2020 at 6:49 AM Wei Li <liwei391@huawei.com> wrote:
> >>
> >> This patch set is to fix several issues of single-step debugging
> >> in kgdb/kdb on arm64.
> >>
> >> It seems that these issues have been shelved a very long time,
> >> but i still hope to solve them, as the single-step debugging
> >> is an useful feature.
> >>
> >> Note:
> >> Based on patch "arm64: cacheflush: Fix KGDB trap detection",
> >> https://www.spinics.net/lists/arm-kernel/msg803741.html
> >>
> >> Wei Li (4):
> >>   arm64: kgdb: Fix single-step exception handling oops
> >>   arm64: Extract kprobes_save_local_irqflag() and
> >>     kprobes_restore_local_irqflag()
> >>   arm64: kgdb: Fix single-stepping into the irq handler wrongly
> >>   arm64: kgdb: Set PSTATE.SS to 1 to reenable single-step
> >>
> >>  arch/arm64/include/asm/debug-monitors.h |  6 ++++++
> >>  arch/arm64/kernel/debug-monitors.c      | 28 ++++++++++++++++++++++++-
> >>  arch/arm64/kernel/kgdb.c                | 16 +++++++++++---
> >>  arch/arm64/kernel/probes/kprobes.c      | 28 ++-----------------------
> >>  4 files changed, 48 insertions(+), 30 deletions(-)
> >
> > Just an overall note that I'm very happy that you posted this patch
> > series!  It's always been a thorn in my side that stepping and
> > breakpoints were so broken on arm64 and I'm really excited that you're
> > fixing them.  Now I'll have to get in the habit of using kgdb for more
> > than just debugging crashes and maybe I can use it more for exploring
> > how functions work more.  :-)
> > > I'll also note that with your patch series I'm even seeing the "call"
> > feature of gdb working now.  That has always been terribly broken for
> > me.
> >
> Thanks for reviewing and testing this series.
> Enjoy exploring the kernel with kgdb/kdb! :-)

I'm curious to know if you plan another spin.  The feedback you
received was fairly minor so it hopefully shouldn't be too hard.  I'd
very much like to get your patches landed and I'd be happy to try to
address the feedback and spin them myself if you're no longer
available for it.

Thanks!

-Doug
