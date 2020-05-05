Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DE7C47256
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 04:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9664A20721
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 04:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="slCE0T5G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgEEEKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 00:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgEEEKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 00:10:05 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA763C061A0F
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 21:10:04 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id w14so201879lfk.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 21:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jz2cSoqOGbsKqpbrYNnHYMttjY/bXQpYhBr6USfoRbY=;
        b=slCE0T5Gb03QdASe6JmzYMEexr63wsm23L+sdIHGtpinXdhAZFyVxcQHTeYtBQp4yD
         y71qhKRv4heGuf2Wqxq+0+VlHrEBSaFB4Ye93hueiw+f7ytT0SkRwhxoE9XAV+jRpvZm
         faQkCdyyjm3agluH/OCbAwqdc/gQ9IKPzCHrcyoX5K08xveCw2VZtYKLKyzhqUggdJNP
         PPw9y1OcCESn9/cOfa/VlntjB98n9YahFhvKIxSA4Ye2AOVEKdByRcA6KsYKXcb54819
         j1NEIrMrm6iOgGR6QN/l5yOjWNtfkYbN4Tdiwc0fvFelvgA/CSnblcMrW4hOnXz9V5qr
         qskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jz2cSoqOGbsKqpbrYNnHYMttjY/bXQpYhBr6USfoRbY=;
        b=BwGm/Lxle6mMezudBera5lwPt435R0JrsjMdGF2YfeXyPGkhaj9zhFX4NHgLpFpspM
         CImMrzCLE8LWDjfpvPCgUkNYhmBfYkjrjqfqS6fuholCQZEpVgZ3PM7BmYxJWqc94KJQ
         YjsYLTN22gy88L10K/X8tUq1Goln58BZTm1CFwSrQ0PNwjXiGS4g9mh56M9WzNbkdEf6
         OkWQZ2lCrT6+mLfR9+3xOyLmC5KKOqFteMBventIhUeuGgcbe288xWGeoZeuih3Y2tVm
         s1wzvOzOZbNW8laNsQ5ftxp3bLfspnEAMRO5oWj58qLQd/XEIVavw+2P5KUHFwqMrqDb
         s0Lw==
X-Gm-Message-State: AGi0PuaZOavvi2vfb0T59Lk5AdvCTKTuaIatBm+ZMkefwb6p8IsIFjzo
        2VtNusK8WJ14mXDdPJgxPZ6I8EdMY0XlmEZoVl0BQQ==
X-Google-Smtp-Source: APiQypKwcPjJPBwPDyzfifsJ9SA8+fSBAfu1r/Lymm9Q4ODuue79UHwVFwqFxAtVSoJpSw4ipsyt3LIML681Ciwsf/c=
X-Received: by 2002:a19:7418:: with SMTP id v24mr263376lfe.15.1588651803162;
 Mon, 04 May 2020 21:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <1587726554-32018-1-git-send-email-sumit.garg@linaro.org>
 <1587726554-32018-3-git-send-email-sumit.garg@linaro.org> <20200425112950.3a4815b6@why>
 <6fd3d96181ec53f735ef1b6a79d28da1@kernel.org> <CAFA6WYPNNNZeX5zpadayfiZ7P_mHmiREpUd5LZ3Jp+TjGVqoEw@mail.gmail.com>
 <ac57cb4bbb6507ee98f199d68a514503@kernel.org> <CAFA6WYMheJxeKVC_YWN9owNJhcWTBsaOCvZXxq=GVj5ROJ0cvg@mail.gmail.com>
 <20200430101322.420e4052@why> <CAFA6WYO+NGLfNkOah4YzXx5XuaDh=QtWHgnMBwwMFY1zRt15GQ@mail.gmail.com>
 <CAFA6WYPxiwxpJitX7fCSESUvQSa9Dq89GwL4e3w33ooetV=ysw@mail.gmail.com>
In-Reply-To: <CAFA6WYPxiwxpJitX7fCSESUvQSa9Dq89GwL4e3w33ooetV=ysw@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 5 May 2020 09:39:50 +0530
Message-ID: <CAFA6WYOn+DLf77C1+e5bq-NdT+o4=o32oPu2b3bxD_U+mLQ3WQ@mail.gmail.com>
Subject: Re: [RFC Patch v1 2/4] irqchip/gic-v3: Add support to handle SGI as
 pseudo NMI
To:     Marc Zyngier <maz@kernel.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Douglas Anderson <dianders@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, julien.thierry.kdev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 May 2020 at 18:33, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Hi Marc,
>
> On Thu, 30 Apr 2020 at 17:43, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > On Thu, 30 Apr 2020 at 14:43, Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On Thu, 30 Apr 2020 12:50:28 +0530
> > > Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > > Hi Marc,
> > > >
> > > > On Wed, 29 Apr 2020 at 13:53, Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > [...]
> > >
> > > > > What I would like is for the arch code to request these interrupts as
> > > > > normal interrupts, for which there is one problem to solve: how do you
> > > > > find out about the Linux IRQ number for a given IPI. Or rather, how
> > > > > do you get rid of the requirement to have IPI numbers at all and just
> > > > > say "give me a per-cpu interrupt that I can use as an IPI, and by the
> > > > > way here's the handler you can call".
> > > >
> > > > I think what you are looking for here is something that could be
> > > > sufficed via enabling "CONFIG_GENERIC_IRQ_IPI" framework for arm64/arm
> > > > architectures. It's currently used for mips architecture. Looking at
> > > > its implementation, I think it should be possible to hook up SGIs
> > > > under new IPI irq_domain for GICv2/v3.
> > > >
> > > > So with this framework we should be able to dynamically allocate IPIs
> > > > and use common APIs such as request_irq()/request_nmi() to tell IPI
> > > > specific handlers.
> > > >
> > > > If this approach looks sane to you then I can start working on a PoC
> > > > implementation for arm64.
> > >
> > > I can't say I'm keen. This IPI framework doesn't really work for the
> > > GIC:
> > >
> > > - it requires a separate irqdomain to be able to guarantee that you
> > >   allocate the hwirq in the SGI range. What is the point?
> > > - it creates yet another level of indirection on IPI injection
> > >
> > > This framework was created to deal with two cases:
> > > - systems that can't represent their IPI with a single hwirq spanning
> > >   all the CPUs
> > > - "accelerator cores" that don't run Linux
> > >
> > > The GIC architecture avoids the first point, and I don't even want to
> > > think of the second one.
> > >
> > > Also, it doesn't solve the initial problem, which is to bootstrap the
> > > whole thing. The IPI framework relies on an irqdomain to be created the
> > > first place. This would mean teaching the arch code about the
> > > intricacies of irqdomains, FW nodes and other terrible things. All
> > > things which are better hidden in the GIC drivers (not to mention the
> > > other horror stories that are the RPi-2/3 irqchip and the Huawei GIC
> > > knock-off).
> > >
> > > What I have in mind is to replace the set_smp_cross_call() with
> > > something that passes the required set of information (interrupt range,
> > > at the very least). The only thing that I plan to reuse from the IPI
> > > framework is the chip->ipi_send_mask() callback.
> > >
> >
> > Fair enough, I will just pass the allocated interrupt range base
> > instead of set_smp_cross_call() and use __ipi_send_mask() to invoke a
> > particular IPI.
>
> Thinking more about this, there seems to be multiple irqchip drivers
> registering softirq API via set_smp_cross_call(). So we need to
> introduce a new API instead of replacing set_smp_cross_call() under
> "CONFIG_GENERIC_IRQ_IPI" macro until all drivers switch to IPIs as
> full interrupts.
>
> BTW, could we take up this generalization as follow-up work as it
> seems to be independent of current IPI NMI work?
>
> >
> > And to request an arch specific IPI as NMI, will use
> > arch_get_ipinr_nmi() and in turn use request_percpu_nmi() to turn that
> > particular IPI as NMI.
>
> I have updated the second patch [1] in my tree to incorporate these
> changes. The updated commit log is as follows:
>
> commit 25c96663126264ec758c49a4a01a9c285f4ccc61
> Author: Sumit Garg <sumit.garg@linaro.org>
> Date:   Wed Apr 22 16:29:59 2020 +0530
>
>     irqchip/gic-v3: Setup arch specific IPI as pseudo NMI
>
>     Add support to mark arch specific IPI as pseudo NMI. Currently its used
>     to allow arm64 specific IPI_CALL_NMI_FUNC to be marked as pseudo NMI.
>
>     Brief description of changes:
>     - Update NMI setup/teardown routines for SGIs.
>     - Enable NMI support prior to gic_smp_init().
>     - Setup custom flow handler for SGI setup as NMI.
>     - Request, prepare and enable arch specific IPI as per CPU NMI using
>       common APIs.
>
>     Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>
> Please have a look and let me know if this is something you were looking for.
>

In case there are no major objections to this approach, I will post
complete v2 patch-set (alongwith Marc's patches) for detailed review.

-Sumit

> [1] https://git.linaro.org/people/sumit.garg/linux.git/commit/?h=kgdb-nmi&id=25c96663126264ec758c49a4a01a9c285f4ccc61
>
> -Sumit
>
> > > Thanks,
> > >
> > >         M.
> > > --
> > > Jazz is not dead. It just smells funny...
