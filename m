Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B508C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 16:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 116122065C
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 16:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YgBqetjJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgEPQRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 12:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgEPQRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 12:17:38 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88179C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 09:17:38 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id e20so2503190vsb.5
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 09:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WhzEA2rdzJ/qx3T7SpNtVuwJgDYbiJVdLBcQA3bNs8A=;
        b=YgBqetjJuGu+U2CSr3IXT7S0VcLJZklSs5FOWo9s5CkvscHIUC64gcW7V485YOzOC1
         NNuphD5MyAq798pOdV2gcfVByhcfriBSf/54YWMa9faV1YKswN8X3eFgyNz3+hAG8l5L
         NtDorD3CsQFCeDSaWHDs6bojlLvtos36aOUvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WhzEA2rdzJ/qx3T7SpNtVuwJgDYbiJVdLBcQA3bNs8A=;
        b=d599n/swLYmLzuKAN2DmU2blywACd25qI5rLRuHVLRLtAxCeyfABBLH771RluHHG5K
         sd3Hsak3Y6lPFHRo5f/GeZhCSctG5Cs1S8m5nUZKuhrxFGl9NusGoSP2x1g6WR0pjtZR
         3eMic1YwTuVLpHm0FeLPJFTnX4Mv3FWJ2+lLN7MWyt5rJcpCHLAFrzzWvi9rrTkWty2d
         tbtzV4XuNvRpthbfCdGeyCm2PHHgxz58DbgDMxd0hIuZ/YxYsOxf6FP8R9yi4ZX7x+e9
         eMGZ297LcqgsPSqXNlDJC+Gf96tUARfrSp5q+ytVNTLejVRV++PvImPWA10sZ9/1km22
         SWaw==
X-Gm-Message-State: AOAM530yLJv8xrb8Krzj2V0cUd/r5q/DI+GlDPb3V2a3pVYwwVw1q+63
        2sDDSf0BFU1MCwASEsrgpgxO9REYyvE=
X-Google-Smtp-Source: ABdhPJxFogMhTIgPH+XVKUkTQHKrJ4hmNDVQkP/PZwDYPb4TZNTD9n04tLyYzaQjtquiyvdBITNd4w==
X-Received: by 2002:a67:b706:: with SMTP id h6mr6577398vsf.238.1589645857403;
        Sat, 16 May 2020 09:17:37 -0700 (PDT)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id 66sm1330015vss.16.2020.05.16.09.17.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2020 09:17:36 -0700 (PDT)
Received: by mail-vk1-f177.google.com with SMTP id 134so1374571vky.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 09:17:36 -0700 (PDT)
X-Received: by 2002:a1f:4e46:: with SMTP id c67mr5887506vkb.92.1589645855867;
 Sat, 16 May 2020 09:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200509214159.19680-1-liwei391@huawei.com> <20200509214159.19680-3-liwei391@huawei.com>
 <CAD=FV=VVz4QnQ6AWAsCMxw6Zne6es0omvJ--Gnag=PXkMPt42g@mail.gmail.com> <d5bb9ccf-6047-13d9-45b3-18421629e83f@huawei.com>
In-Reply-To: <d5bb9ccf-6047-13d9-45b3-18421629e83f@huawei.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Sat, 16 May 2020 09:17:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XMSsMFpPzBckkWhP6iDR4WM+qdV7J=aQCBbbBit_rDwg@mail.gmail.com>
Message-ID: <CAD=FV=XMSsMFpPzBckkWhP6iDR4WM+qdV7J=aQCBbbBit_rDwg@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm64: Extract kprobes_save_local_irqflag() and kprobes_restore_local_irqflag()
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

Hi,

On Sat, May 16, 2020 at 1:47 AM liwei (GF) <liwei391@huawei.com> wrote:
>
> >> -               kprobes_save_local_irqflag(kcb, regs);
> >> +               kernel_prepare_single_step(&kcb->saved_irqflag, regs);
> >
> > Is there some reason to have two functions?  It seems like every time
> > you call kernel_enable_single_step() you'd want to call
> > kernel_prepare_single_step().  ...and every time you call
> > kernel_disable_single_step() you'd want to call
> > kernel_cleanup_single_step().
> >
> > Maybe you can just add the flags parameter to
> > kernel_enable_single_step() / kernel_disable_single_step() and put the
> > code in there?
> >
>
> As kernel_enable_single_step() / kernel_disable_single_step() are also called in
> breakpoint_handler() and watchpoint_handler(), i am not sure it's a right thing
> to put the daif flag prepare/cleanup into them, especially we don't have a context
> to save the flags.

I think you misunderstood what I was suggesting.  Maybe better with
examples?  I was suggesting doing this:

kcb->saved_irqflag = kernel_enable_single_step(regs);
...
kernel_disable_single_step(kcb->saved_irqflag, regs);

To me that seems better than what you have now:

kcb->saved_irqflag = kernel_prepare_single_step(regs);
kernel_enable_single_step(regs);
...
kernel_cleanup_single_step(kcb->saved_irqflag, regs);
kernel_disable_single_step();

...or am I confused?

-Doug
