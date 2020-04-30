Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4B0C8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 12:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 430BB205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 12:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dBJrTKuq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgD3MNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 08:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725280AbgD3MNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 08:13:35 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E167C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 05:13:35 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id f8so996078lfe.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 05:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yoeiwlW47gmLywsOiQtPAE+BLkFaEXPfv/CcedEMo0A=;
        b=dBJrTKuq/SFqvsQRbkobYYD98E85yyKcrd9m+8aU8XQsZe9qZ4X3mboJ4YAStQGCSe
         P+gw90exxtyuQ+xUnKPv2uPJUukjiRRy9FsMM6ZESi54vVlyqNkiuueBXFXaEA+p2BOx
         kea0VHcA4BCDM5e0RydFHUESpaYzlZtUpyNXaH8uzi90pA9n9qbLgycjFafZayXSQoG6
         SQE9u4XUwAUyNzpljPgQk122jmjjie0LBRRy4kjw5WsQC8saX6p04NfwH1LiqEE9yp6X
         FWfhEMGJZZ9J/ODkOI51KV8YAvWFKqM078K9NHUzJzCTypO0tdZDb7NTW7NsRqKeiTgH
         yzQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yoeiwlW47gmLywsOiQtPAE+BLkFaEXPfv/CcedEMo0A=;
        b=IM3m3KwwJjp8mgcMRB0SClGXdLoLL2KQBj2iEXeV/Q1OEKRV/zyEpYgDyk3+o4V0Ys
         mUpXv/Drbomz939OhXrywg58sJxfrVheNDS3jlAMabaBvRToBlIDA4peCxFSsAQgrEm2
         W2B86cMoaLx3X1SslBV3QI5b0uJzRPDa57M2EoUWacfW5KKp3SOkYz9LIidW/58d8DC/
         KoM2F1Azve2pKWTfHrISBHY5tlCMYH+6IoBq9TSM1DtyiWOg0IXSBzTud1Vbk+V5U+kn
         hbYgpoU1rG6tuTQlIt+Dmmp+Gxtg9tRIN/E6Wl3DOWFc50fcPoy/nf0OZnbAk7Ckqk4N
         10Qw==
X-Gm-Message-State: AGi0PubGPBqK6uGd5SwBetg0qf0VYAzKF7hm9Mk/Lex5AAlOx25/vMSb
        0SOsrXPc4DOC8dtan2yrqbn01rDH94hyxuClQMBAuw==
X-Google-Smtp-Source: APiQypIIPUadX74iZ/bCIqJG4Vsa3NMnxmkI+UwH+e41amhBTK/XrBg+ktI/Ar3uSdlHbEz4HG6H/aHz5MJH+jCDZWI=
X-Received: by 2002:ac2:4113:: with SMTP id b19mr2009647lfi.40.1588248813839;
 Thu, 30 Apr 2020 05:13:33 -0700 (PDT)
MIME-Version: 1.0
References: <1587726554-32018-1-git-send-email-sumit.garg@linaro.org>
 <1587726554-32018-3-git-send-email-sumit.garg@linaro.org> <20200425112950.3a4815b6@why>
 <6fd3d96181ec53f735ef1b6a79d28da1@kernel.org> <CAFA6WYPNNNZeX5zpadayfiZ7P_mHmiREpUd5LZ3Jp+TjGVqoEw@mail.gmail.com>
 <ac57cb4bbb6507ee98f199d68a514503@kernel.org> <CAFA6WYMheJxeKVC_YWN9owNJhcWTBsaOCvZXxq=GVj5ROJ0cvg@mail.gmail.com>
 <20200430101322.420e4052@why>
In-Reply-To: <20200430101322.420e4052@why>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 30 Apr 2020 17:43:21 +0530
Message-ID: <CAFA6WYO+NGLfNkOah4YzXx5XuaDh=QtWHgnMBwwMFY1zRt15GQ@mail.gmail.com>
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

On Thu, 30 Apr 2020 at 14:43, Marc Zyngier <maz@kernel.org> wrote:
>
> On Thu, 30 Apr 2020 12:50:28 +0530
> Sumit Garg <sumit.garg@linaro.org> wrote:
>
> > Hi Marc,
> >
> > On Wed, 29 Apr 2020 at 13:53, Marc Zyngier <maz@kernel.org> wrote:
>
> [...]
>
> > > What I would like is for the arch code to request these interrupts as
> > > normal interrupts, for which there is one problem to solve: how do you
> > > find out about the Linux IRQ number for a given IPI. Or rather, how
> > > do you get rid of the requirement to have IPI numbers at all and just
> > > say "give me a per-cpu interrupt that I can use as an IPI, and by the
> > > way here's the handler you can call".
> >
> > I think what you are looking for here is something that could be
> > sufficed via enabling "CONFIG_GENERIC_IRQ_IPI" framework for arm64/arm
> > architectures. It's currently used for mips architecture. Looking at
> > its implementation, I think it should be possible to hook up SGIs
> > under new IPI irq_domain for GICv2/v3.
> >
> > So with this framework we should be able to dynamically allocate IPIs
> > and use common APIs such as request_irq()/request_nmi() to tell IPI
> > specific handlers.
> >
> > If this approach looks sane to you then I can start working on a PoC
> > implementation for arm64.
>
> I can't say I'm keen. This IPI framework doesn't really work for the
> GIC:
>
> - it requires a separate irqdomain to be able to guarantee that you
>   allocate the hwirq in the SGI range. What is the point?
> - it creates yet another level of indirection on IPI injection
>
> This framework was created to deal with two cases:
> - systems that can't represent their IPI with a single hwirq spanning
>   all the CPUs
> - "accelerator cores" that don't run Linux
>
> The GIC architecture avoids the first point, and I don't even want to
> think of the second one.
>
> Also, it doesn't solve the initial problem, which is to bootstrap the
> whole thing. The IPI framework relies on an irqdomain to be created the
> first place. This would mean teaching the arch code about the
> intricacies of irqdomains, FW nodes and other terrible things. All
> things which are better hidden in the GIC drivers (not to mention the
> other horror stories that are the RPi-2/3 irqchip and the Huawei GIC
> knock-off).
>
> What I have in mind is to replace the set_smp_cross_call() with
> something that passes the required set of information (interrupt range,
> at the very least). The only thing that I plan to reuse from the IPI
> framework is the chip->ipi_send_mask() callback.
>

Fair enough, I will just pass the allocated interrupt range base
instead of set_smp_cross_call() and use __ipi_send_mask() to invoke a
particular IPI.

And to request an arch specific IPI as NMI, will use
arch_get_ipinr_nmi() and in turn use request_percpu_nmi() to turn that
particular IPI as NMI.

Is there anything that I missed here?

-Sumit

> Thanks,
>
>         M.
> --
> Jazz is not dead. It just smells funny...
