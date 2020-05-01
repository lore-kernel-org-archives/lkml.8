Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C123C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEC5C2137B
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ep/JYE+p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbgEAND6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728712AbgEAND5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:03:57 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10B2C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 06:03:56 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id y3so3817963lfy.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 06:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Jgeb9V3DPGc3QB1JR0CXzxKdYexNkGLUlFPYO765RE=;
        b=Ep/JYE+pXNaF2jDBd53wSJFYCpQyr+GZQGkKjYehGJpzYOwsHtjJZlCiDluROVGhw8
         mh0y6uE8ZL4CUWJgWsHM3ewNLXSOO++i0MpuBI1S1W3fOtozD29ktM3tYhfje1aoZFE8
         2NgwDDlnFIvZiBFRm/X5nnJlJqs1KzQjp3kTmtQgbI0JQpd0c2+jkoGJddsoJf0a/YwV
         RnfuLo16PjkI1r7eNAQS1o/p+9bkYrGw34GmcyjdbGFCZwfupVWHSTlHPLyKnZJ5SZda
         pXN6SwLDfEGQRp5wkl5g/Wbmr2BEq4rarHDo9SorHhCRB/TuRv9YAdyi/Ko1NKwYNvWb
         n+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Jgeb9V3DPGc3QB1JR0CXzxKdYexNkGLUlFPYO765RE=;
        b=sa0uYLlTbxjZfoE2zYQyynvG+GnjMoHf2dSvzGVk4wTIcI0M0KHV/C0wH3X8bquo/y
         kWAsSulIn+0J+y6k+MdR1i9v9lWPkTGcBl76rKjBprV/d3QygPjWhY3XathkmZaGg0Xq
         Sji4ZhuIfQ8rv1wseMeCnsRjRWelnaP57CDLk6qbvMKH44uCaX82DR0yoSoGeSl0gJzf
         PH0cpq5+udbPLy9WpjbpsBnRw9TPILiHdKpLDYFocBlBAlOewCTg5XiD/hsBVRPbXCIb
         LxRDwxQIjSACJLlB580cerlcWBP0S5gaMnjenO6VuJ0r37tAHu9BuESkyCiyzr+9o0pE
         YvsA==
X-Gm-Message-State: AGi0PubU/g90ushpF6IUvt3sbRYwcIZWTplenkifm6UxKWBQkBQRzMte
        qRnXac+IheSQR0YscAlmTJyaMf2SP/qkXnaOYV7Dsg==
X-Google-Smtp-Source: APiQypKEAjCb6B0XNCBmwsr3+hJz9uTjk/hiENuc+OVSOPzBEyb2sgOOC+CWTjNXaD8mUmyTD8sRDKY9Oj+2+JkX+3g=
X-Received: by 2002:ac2:4113:: with SMTP id b19mr2558877lfi.40.1588338235381;
 Fri, 01 May 2020 06:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <1587726554-32018-1-git-send-email-sumit.garg@linaro.org>
 <1587726554-32018-3-git-send-email-sumit.garg@linaro.org> <20200425112950.3a4815b6@why>
 <6fd3d96181ec53f735ef1b6a79d28da1@kernel.org> <CAFA6WYPNNNZeX5zpadayfiZ7P_mHmiREpUd5LZ3Jp+TjGVqoEw@mail.gmail.com>
 <ac57cb4bbb6507ee98f199d68a514503@kernel.org> <CAFA6WYMheJxeKVC_YWN9owNJhcWTBsaOCvZXxq=GVj5ROJ0cvg@mail.gmail.com>
 <20200430101322.420e4052@why> <CAFA6WYO+NGLfNkOah4YzXx5XuaDh=QtWHgnMBwwMFY1zRt15GQ@mail.gmail.com>
In-Reply-To: <CAFA6WYO+NGLfNkOah4YzXx5XuaDh=QtWHgnMBwwMFY1zRt15GQ@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 1 May 2020 18:33:41 +0530
Message-ID: <CAFA6WYPxiwxpJitX7fCSESUvQSa9Dq89GwL4e3w33ooetV=ysw@mail.gmail.com>
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

Hi Marc,

On Thu, 30 Apr 2020 at 17:43, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Thu, 30 Apr 2020 at 14:43, Marc Zyngier <maz@kernel.org> wrote:
> >
> > On Thu, 30 Apr 2020 12:50:28 +0530
> > Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > > Hi Marc,
> > >
> > > On Wed, 29 Apr 2020 at 13:53, Marc Zyngier <maz@kernel.org> wrote:
> >
> > [...]
> >
> > > > What I would like is for the arch code to request these interrupts as
> > > > normal interrupts, for which there is one problem to solve: how do you
> > > > find out about the Linux IRQ number for a given IPI. Or rather, how
> > > > do you get rid of the requirement to have IPI numbers at all and just
> > > > say "give me a per-cpu interrupt that I can use as an IPI, and by the
> > > > way here's the handler you can call".
> > >
> > > I think what you are looking for here is something that could be
> > > sufficed via enabling "CONFIG_GENERIC_IRQ_IPI" framework for arm64/arm
> > > architectures. It's currently used for mips architecture. Looking at
> > > its implementation, I think it should be possible to hook up SGIs
> > > under new IPI irq_domain for GICv2/v3.
> > >
> > > So with this framework we should be able to dynamically allocate IPIs
> > > and use common APIs such as request_irq()/request_nmi() to tell IPI
> > > specific handlers.
> > >
> > > If this approach looks sane to you then I can start working on a PoC
> > > implementation for arm64.
> >
> > I can't say I'm keen. This IPI framework doesn't really work for the
> > GIC:
> >
> > - it requires a separate irqdomain to be able to guarantee that you
> >   allocate the hwirq in the SGI range. What is the point?
> > - it creates yet another level of indirection on IPI injection
> >
> > This framework was created to deal with two cases:
> > - systems that can't represent their IPI with a single hwirq spanning
> >   all the CPUs
> > - "accelerator cores" that don't run Linux
> >
> > The GIC architecture avoids the first point, and I don't even want to
> > think of the second one.
> >
> > Also, it doesn't solve the initial problem, which is to bootstrap the
> > whole thing. The IPI framework relies on an irqdomain to be created the
> > first place. This would mean teaching the arch code about the
> > intricacies of irqdomains, FW nodes and other terrible things. All
> > things which are better hidden in the GIC drivers (not to mention the
> > other horror stories that are the RPi-2/3 irqchip and the Huawei GIC
> > knock-off).
> >
> > What I have in mind is to replace the set_smp_cross_call() with
> > something that passes the required set of information (interrupt range,
> > at the very least). The only thing that I plan to reuse from the IPI
> > framework is the chip->ipi_send_mask() callback.
> >
>
> Fair enough, I will just pass the allocated interrupt range base
> instead of set_smp_cross_call() and use __ipi_send_mask() to invoke a
> particular IPI.

Thinking more about this, there seems to be multiple irqchip drivers
registering softirq API via set_smp_cross_call(). So we need to
introduce a new API instead of replacing set_smp_cross_call() under
"CONFIG_GENERIC_IRQ_IPI" macro until all drivers switch to IPIs as
full interrupts.

BTW, could we take up this generalization as follow-up work as it
seems to be independent of current IPI NMI work?

>
> And to request an arch specific IPI as NMI, will use
> arch_get_ipinr_nmi() and in turn use request_percpu_nmi() to turn that
> particular IPI as NMI.

I have updated the second patch [1] in my tree to incorporate these
changes. The updated commit log is as follows:

commit 25c96663126264ec758c49a4a01a9c285f4ccc61
Author: Sumit Garg <sumit.garg@linaro.org>
Date:   Wed Apr 22 16:29:59 2020 +0530

    irqchip/gic-v3: Setup arch specific IPI as pseudo NMI

    Add support to mark arch specific IPI as pseudo NMI. Currently its used
    to allow arm64 specific IPI_CALL_NMI_FUNC to be marked as pseudo NMI.

    Brief description of changes:
    - Update NMI setup/teardown routines for SGIs.
    - Enable NMI support prior to gic_smp_init().
    - Setup custom flow handler for SGI setup as NMI.
    - Request, prepare and enable arch specific IPI as per CPU NMI using
      common APIs.

    Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

Please have a look and let me know if this is something you were looking for.

[1] https://git.linaro.org/people/sumit.garg/linux.git/commit/?h=kgdb-nmi&id=25c96663126264ec758c49a4a01a9c285f4ccc61

-Sumit

> > Thanks,
> >
> >         M.
> > --
> > Jazz is not dead. It just smells funny...
