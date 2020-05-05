Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4F9C47258
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 11:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFAEA20735
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 11:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VH3NB1RZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbgEELdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 07:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728855AbgEELdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 07:33:37 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43736C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 04:33:37 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id s9so1074344lfp.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 04:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hupIsa73mYi5wqryxe4Qi42JysQkQpBvcd0iG3bDTIg=;
        b=VH3NB1RZHEvs5K7gdOjwynz0XSk4hklChAwSnf9CBV0dqOMKufdJjyxgi+kZvX5uNZ
         +oynGrV0QHSRGalM8tgG/rbkxVYT8F0cBFML/4yh0b8obwpoV2EwRk7T1x5Czne4EXu5
         l5uw/K26uHeZS6VWJsGc7f5OjmRrmPWwevTr+TnDoyD2fSHoASkUOKfFhaclL3Oi3rfB
         RBoM5NzMZSJtkRMwsAYIPgcAf6di6MPGj3PtIXwHnOQ0X3xLs1KYjdDogTLFWE5X/KBm
         +m6A6Xe+SN8BnlU1uKncJpvfWoeRLE476mXu8gCUiXNZ4q+V+iA/qf7Mn3GUSl3H7h58
         FI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hupIsa73mYi5wqryxe4Qi42JysQkQpBvcd0iG3bDTIg=;
        b=ZZT0ITnmqcztVvKh7UC/wPCHQBAZJqol7tn0rU1LhLLGKVOywV8XTZds9e5nyABU8w
         /Ss6XQABV/2u7LBo+4/DlYxko1GGtPLqXomyixV/lpZaRZmcwqbnmY8j/hA9sSBfLuTR
         6SBZVKWKcQMpfOtKLz2wKXH8TOJuk7c8ym7LnMvnFzvQUGviDnK2RvwpvwT0vF3otIY8
         WKJyOAS03MPkPHuJzEpCSia6qyCiszEY9mnH6Knwow6Y1Jt2FHDJTCUnplwc7MEOpRzW
         TQEMGVZdJjiXcEOQm8Wwv5kEkdvCJuxzzUyrwLftLr00WwcOo8X/a4KQkJS697/MCE6z
         3WeQ==
X-Gm-Message-State: AGi0Pubb9F6NsMCP8HbEuLo2fJYoR8Qfx7WN1I8ckB/wlIKRvJQUuqcj
        fXrQEWqK85L04lyE2zFd5yz7L1Gv94q2k9DDeUdZpg==
X-Google-Smtp-Source: APiQypLU2m/D7oJWk9It8mtjKBIlV1BpWKwlq9Nc3PajJn78yBAiMiIjgK7Faej/USSOYk2Wxlaz7fdud7Qz/+U/Wfg=
X-Received: by 2002:a19:7418:: with SMTP id v24mr1403778lfe.15.1588678415695;
 Tue, 05 May 2020 04:33:35 -0700 (PDT)
MIME-Version: 1.0
References: <1587726554-32018-1-git-send-email-sumit.garg@linaro.org>
 <1587726554-32018-3-git-send-email-sumit.garg@linaro.org> <20200425112950.3a4815b6@why>
 <6fd3d96181ec53f735ef1b6a79d28da1@kernel.org> <CAFA6WYPNNNZeX5zpadayfiZ7P_mHmiREpUd5LZ3Jp+TjGVqoEw@mail.gmail.com>
 <ac57cb4bbb6507ee98f199d68a514503@kernel.org> <CAFA6WYMheJxeKVC_YWN9owNJhcWTBsaOCvZXxq=GVj5ROJ0cvg@mail.gmail.com>
 <20200430101322.420e4052@why> <CAFA6WYO+NGLfNkOah4YzXx5XuaDh=QtWHgnMBwwMFY1zRt15GQ@mail.gmail.com>
 <CAFA6WYPxiwxpJitX7fCSESUvQSa9Dq89GwL4e3w33ooetV=ysw@mail.gmail.com>
 <CAFA6WYOn+DLf77C1+e5bq-NdT+o4=o32oPu2b3bxD_U+mLQ3WQ@mail.gmail.com> <306aecc560a9503e500fbf1f512c6d30@kernel.org>
In-Reply-To: <306aecc560a9503e500fbf1f512c6d30@kernel.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 5 May 2020 17:03:24 +0530
Message-ID: <CAFA6WYPHWP46TY_XdxVVrTr6AChU_1ATXu+p32vXCjkaXWPWOQ@mail.gmail.com>
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

On Tue, 5 May 2020 at 15:38, Marc Zyngier <maz@kernel.org> wrote:
>
> On 2020-05-05 05:09, Sumit Garg wrote:
> > On Fri, 1 May 2020 at 18:33, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> [...]
>
> > In case there are no major objections to this approach, I will post
> > complete v2 patch-set (alongwith Marc's patches) for detailed review.
>
> As this is still a work in progress (I'm currently wrestling with
> the stupid RPi driver), whatever you have is unlikely to apply on
> top of the final series.
>
> I'm not going to stop you from posting the patches, it is just that
> they will be obsolete by the end of the week...

Thanks for the heads up. Will wait for your final series.

But while working on an NMI request, I noticed a hack in common gic
code [1] which basically enables all SGIs for every CPU by default.
This hack is quite similar to mine initial hack to set priority for a
particular SGI by default to act as pseudo NMI.

Due to this hack I got following error message while configuring SGI as NMI:

[    0.000000] GICv3: Cannot set NMI property of enabled IRQ 8
[    0.000000] genirq: Failed to setup NMI delivery: irq 8

I think chained IRQs worked for you due to this hack only as it
doesn't seem to enable SGIs per CPU.

IMO, as we shift to SGIs being standard interrupts, we should also
rely on standard interrupt framework to enable SGIs. So it seems the
correct way would be to use "request_percpu_irq()" and
"enable_percpu_irq()" for configuring SGIs as demonstrated in updated
commit here [2].

Also, we should get rid of this hack as demonstrated via commit [3].

Apart from above changes, there was a minor update needed for commit
"irqchip/gic-v3: Describe the SGI range" [4].

I hope these updates are useful for you while preparing the final series.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/irqchip/irq-gic-common.c#n155
[2] https://git.linaro.org/people/sumit.garg/linux.git/commit/?h=kgdb-nmi&id=e208979b5165d753d144db57e0cb8646fdedc495
[3] https://git.linaro.org/people/sumit.garg/linux.git/commit/?h=kgdb-nmi&id=cd6d0d7cea14ac16156f0dbd297940df382f8cea
[4] https://git.linaro.org/people/sumit.garg/linux.git/commit/?h=kgdb-nmi&id=1180e9c54547ec05d96cc6b36c26005059c90d9a

-Sumit

>
> Thanks,
>
>          M.
> --
> Jazz is not dead. It just smells funny...
