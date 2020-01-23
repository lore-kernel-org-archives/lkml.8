Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4292CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 10:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1278C2253D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 10:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BAZVoNen"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgAWKPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 05:15:54 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46391 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgAWKPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 05:15:53 -0500
Received: by mail-lj1-f195.google.com with SMTP id m26so2595639ljc.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 02:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fGfmqlHJGvBUaKB7KIupk3AiKKfrbPuecg/oG3x9WSM=;
        b=BAZVoNenHKrAA/oEiLjf2M7tw2gmunAONl8JQT3tWRc9R6cAl5ePpa5lUP8niqxYRZ
         R+/Emi3bFFA/cluIHYoKSu18qVtAlhH0KXimTss+LRzh7okMojoOBtF0VFTzb21fysTL
         el/e/n8jkVpqZWaqaUPc7zs61F7+30g2/p68PjvrUU7WzME5DvzycFRPm3yLMyG48lGn
         Ymlxq1woXg8juaPXOef+7rTaFfN/KN1BqEIaG9/dN6angWdJjey0l+zlRMnr/AJNz0zj
         1Am68DoX/IaGhJxkLnDN+ICg7/3dpuzjVsrdNmEHvUgxOFhquLXIAXwWn7yYG0FRSBE8
         etcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fGfmqlHJGvBUaKB7KIupk3AiKKfrbPuecg/oG3x9WSM=;
        b=ZWhR4lr3RWwgKPfZyHzQryS5g8FQmsb6i1OPZvdZ/UG0S5RxgmeNOvSQd97vXBaSZk
         /ItlVWjlect6uPx9a7WlFqWA2FiINfUsuGFjOCyVLNoexYmVi0x3FLRHXcQNib/lPkeS
         3IgHYxQKHeToDWxMmzMGXxOs68HitMt6HFGV3oj0ZahRhhC94+GZeC3tgBqJ+kNu0V/u
         sdDs+TxWTzrAjY2g7zed8Iu0rPm8wc9jZXiquU3TTNbzjjyGRTG/WrfnCyFoaS8EUPKJ
         KY3CgN4uys2JjmzU8Dj0v7C48b+UKt9WxARbygsRc8/qRk0HCou87Dc6HvqfglEJprhe
         4Iuw==
X-Gm-Message-State: APjAAAWwm+iudwt+PXSbvJQSzEZk8/V4VrZxPAp5icH4QNmNqkKAvICm
        PDpivazZwcRSOzp2xwAQ1d13Sw==
X-Google-Smtp-Source: APXvYqxpzB6GeS7Gz4vyQJwoM7evEIeIVcNniS0/dew7FLxOk9hUA3/TT+Y6luaMQL53q9+gaD0eOw==
X-Received: by 2002:a2e:8758:: with SMTP id q24mr22874310ljj.157.1579774551702;
        Thu, 23 Jan 2020 02:15:51 -0800 (PST)
Received: from jax (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id a12sm905492ljk.48.2020.01.23.02.15.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Jan 2020 02:15:51 -0800 (PST)
Date:   Thu, 23 Jan 2020 11:15:49 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: optee: Fix compilation issue.
Message-ID: <20200123101548.GB10320@jax>
References: <20200110122807.49617-1-vincenzo.frascino@arm.com>
 <8fa0e5b3-6e88-3fa2-9e16-046350cc752b@arm.com>
 <20200121152031.GA572414@kroah.com>
 <f4134c26-231f-968a-7fc3-0427af9a886e@arm.com>
 <20200121171836.GA674326@kroah.com>
 <CAHUa44F1FU6iPqjkk_9ALS0YHc5AVtSzweEt-0RX919cUbU2eA@mail.gmail.com>
 <6862c452-4280-7999-a03f-1184e1a03015@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6862c452-4280-7999-a03f-1184e1a03015@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 09:37:28AM +0000, Vincenzo Frascino wrote:
> Hi Jens,
> 
> On 22/01/2020 08:03, Jens Wiklander wrote:
> > Hi Vincenzo,
> > 
> > On Tue, Jan 21, 2020 at 6:18 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> >>
> >> On Tue, Jan 21, 2020 at 03:27:47PM +0000, Vincenzo Frascino wrote:
> >>> Hi Greg,
> >>>
> >>> On 21/01/2020 15:20, Greg Kroah-Hartman wrote:
> >>>> On Tue, Jan 21, 2020 at 02:23:02PM +0000, Vincenzo Frascino wrote:
> >>>>> Hi Greg,
> >>>>>
> >>>>> I sent the fix below few days ago to the optee maintaners but I did not get any
> >>>>> answer. Could you please pick it up?
> >>>>
> >>>>      $ ./scripts/get_maintainer.pl --file drivers/tee/optee/Kconfig
> >>>>     Jens Wiklander <jens.wiklander@linaro.org> (maintainer:OP-TEE DRIVER)
> >>>>     tee-dev@lists.linaro.org (open list:OP-TEE DRIVER)
> >>>>     linux-kernel@vger.kernel.org (open list)
> >>>>
> >>>> This should go through Jens, why me?
> >>>>
> >>>
> >>> I added Jens and tee-dev list in copy already but as I was mentioning in my
> >>> previous email I did not get any answer. I thought that since it is a small fix
> >>> you could help. Sorry if I made a mistake.
> >>
> >> Give people time to catch up on email, especially for obscure issues
> >> like this.
> >>
> >> thanks,
> >>
> >> greg k-h
> > 
> > I'll pick up this patch.
> > 
> 
> Thanks for this, since it might break the build in some cases, do you think it
> there any chance it can end up in 5.5? I know it might be late.

I've just sent a pull request with this commit to arm-soc. It's their
decision if it's passed on for 5.5 or if it's too late.

Cheers,
Jens
