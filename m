Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B37DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38572204EA
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9NLMWn2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbgG3IWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgG3IWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 04:22:32 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347EAC061794
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 01:22:32 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id c15so9641061edj.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 01:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P5tO026HCWhunpPtUraf4hK8sVUtc5cHl/ZsmE/rYmg=;
        b=U9NLMWn24gZt8WtxgpL5aoU3QKrTkHkD6/dcKdC4LphBD4cX3BQGCLeuyfX+75BWAp
         oqmNE3yIYkcCRPpODyKk+EaQ2hBT+t0Qe4YmIMMEwbJn9lTonhzBwA/xe9xYTydOfYSK
         HA1PpxohUeLcNPINlNAKk4SvZ6hLfDaa9E0dhHIP4akiH8tF2bh3FZoRYtpRhp+Nx6UC
         1PYaVfzDygnlZ1Uc9IkJRDKBXmM43Cfw8BMqnCjjpyeKIfSWZRV17ug4/S/amlstz+td
         2VWsuOyw5uPhwFiREY/DqcBiUTXuo/N+Cyo5k7e2zuOQ+N/GH5dvcSOu28Foo4wY8B2w
         L0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P5tO026HCWhunpPtUraf4hK8sVUtc5cHl/ZsmE/rYmg=;
        b=FM4w8zgvLJZe+6/LaMVrad9kcyEcKALQODoXQS5GZBN9YV/NDZaCRmoQGFaYqBY+XT
         kMj7yuXH/S5qBhJ2OdAhSpB53mTM/DdjUgSrjOCByis+bnmyq+c8zTosCdXNzmvCvzlk
         lEQB8G4fIm6zEMYsWxKNXwWKtBEUyZU7yKkxGbrTDmmTNuXwxzhntnSdB7CzIaoIKiYc
         TyElXT7eFOF+5J5xaZONM6n3AY/8i3JQNMHotUNrgo/FpfnhY3cE9QSL81kt9+XmLcZZ
         GgbCtZ9rzghfksityLP+8l0HkaFGbZ0YGuyczLFxFfrgzr/cX/CFHsCUXAPlfodPu23x
         96Og==
X-Gm-Message-State: AOAM5315AVhtNfsmG8ikhOWa7KGJXPYfhn7bKSa/utL4535sfeeo/pSG
        D60E8wHr2IDPxdeokQeyt8U=
X-Google-Smtp-Source: ABdhPJz6I16zjQSU3JvaPfMdjbrDhwnziZ8PJqlqVpoGsGVBZPF4lHPfeb/btve/9CoadU16h9iMfg==
X-Received: by 2002:a05:6402:13d0:: with SMTP id a16mr1491655edx.269.1596097350964;
        Thu, 30 Jul 2020 01:22:30 -0700 (PDT)
Received: from skbuf ([188.26.57.97])
        by smtp.gmail.com with ESMTPSA id b18sm4847551ejc.41.2020.07.30.01.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 01:22:30 -0700 (PDT)
Date:   Thu, 30 Jul 2020 11:22:28 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
Cc:     Alison Wang <alison.wang@nxp.com>, catalin.marinas@arm.com,
        will@kernel.org, paulmck@kernel.org, mw@semihalf.com,
        leoyang.li@nxp.com, vladimir.oltean@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: Re: [RFC PATCH] arm64: defconfig: Disable fine-grained task level
 IRQ time accounting
Message-ID: <20200730082228.r24zgdeiofvwxijm@skbuf>
References: <20200729033934.22349-1-alison.wang@nxp.com>
 <877dumbtoi.fsf@kurt>
 <20200729094943.lsmhsqlnl7rlnl6f@skbuf>
 <87mu3ho48v.fsf@kurt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mu3ho48v.fsf@kurt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 09:23:44AM +0200, Kurt Kanzenbach wrote:
> Hi Vladimir,
> 
> On Wed Jul 29 2020, Vladimir Oltean wrote:
> > For more context, here is my original report of the issue:
> > https://lkml.org/lkml/2020/6/4/1062
> >
> > Just like you, I could not reproduce the RCU stalls and system hang on a
> > 5.6-rt kernel, just on mainline and derivatives, using the plain
> > defconfig.
> >
> > The issue is not specific to Layerscape or i.MX8, but rather I was able
> > to see the same behavior on Marvell Armada 37xx as well as Qualcomm
> > MSM8976.
> >
> > So, while of course I agree that disabling IRQ time accounting for arm64
> > isn't a real solution, it isn't by far an exaggerated proposal either.
> > Nonetheless, the patch is just a RFC and should be treated as such. We
> > are at a loss when it comes to debugging this any further and we would
> > appreciate some pointers.
> 
> Yeah, sure. I'll try to reproduce this issue first. So it triggers with:
> 
>  * arm64
>  * mainline, not -rt kernel
>  * opened serial console
>  * irq accounting enabled
> 
> Anything else?
> 
> Thanks,
> Kurt

Thanks for giving a helping hand, Kurt. The defconfig should be enough.
In the interest of full disclosure, the only arm64 device on which we
didn't reproduce this was the 16-core LX2160A. But we did reproduce on
that with maxcpus=1 though. And also on msm8976 with all 8 cores booted.
Just mentioning this in case you're testing on a 16-core system, you
might want to reduce the number a bit.

Thanks,
-Vladimir
