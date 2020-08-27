Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACA4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 18:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA10D2087E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 18:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNz8+bhT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgH0SzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 14:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgH0SzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 14:55:00 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4F1C061264;
        Thu, 27 Aug 2020 11:55:00 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id d11so9024928ejt.13;
        Thu, 27 Aug 2020 11:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LHHKRlpGcLJvCKpegwxUOUmIDZhAqnwwqQX2kkQlM7s=;
        b=QNz8+bhTuuSkmXiGILO4+og6Sl1O4SV5ipW6T/vNZSvL9MXrAJy7C07y5OxL0U3W9f
         X8UpK761iwRZR/2m/xhmNila1tS7nUqofK1sHe1vm1aJC1wbIPL8/Q7/ZKwXB3zQOfNV
         HYuz5T0vULxgCZKFHsQ9DdJ2NV1N4bjw656Z+TMM7bJ5Rf9Y5nNuOGtEKh5UmhP1G9vx
         kP1YpVSFFvLoCgMDJVhU38/5hNmoA99DXrdSMFN1jYXJ1YFQcfDpOe8Vqh54/DzbPTfs
         +dNgdhkFt23twviXTBwdovKxmBKjYj1LWkvhMkp1CxVx84UKdnRybvsaU2/XsM9R84Js
         YO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LHHKRlpGcLJvCKpegwxUOUmIDZhAqnwwqQX2kkQlM7s=;
        b=SQ2Dw0LBKAyJP0xlKIPy+n9N4PFMVf8eq2+MRqWuXkSLoY9f+61L74nA0KSOvb+2hl
         y2KhuTHvjlGnUDsdgV/LxyH4ripSctTW1mtlC176s5T9ZyYozO8SXa4u/BrqyvOpb8cA
         Qoakv4L+KlYKgqTnASXSEpNNn9rIusmRyJfahBET/d3fvDukYsq/vlT/gu86yn/1Wqwp
         7nZg/lSO3mFw6wK6c978Sqq3iZOcZIQa4HeABjRT5KCapmMaWOyU55ziOx1IyQ30EyAs
         HhpDDy2Isgodei/AaOjaB6jak5TUYP2RrI9EfGh9kw+gbld1/JZX0D/pGZg/GXsn7ebF
         XP9g==
X-Gm-Message-State: AOAM531eDEXms3SlM/PuMdd1TXivB/oEmQ1YbRZUXhqTQO7v0QMYPQ1x
        efAIw2C+9UFtLuOkjjzWlZc=
X-Google-Smtp-Source: ABdhPJzAisnvpJNwmg6E75pm+Dss0ilEJO1mrAtf34l/Azy1U3zXvkxujPh0hP3H2R4xka8Ms08ijg==
X-Received: by 2002:a17:906:22d6:: with SMTP id q22mr14495824eja.242.1598554499144;
        Thu, 27 Aug 2020 11:54:59 -0700 (PDT)
Received: from BV030612LT ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id g11sm2100748edt.88.2020.08.27.11.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 11:54:58 -0700 (PDT)
Date:   Thu, 27 Aug 2020 21:54:56 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-actions@lists.infradead.org
Subject: Re: [PATCH v5 1/3] dt-bindings: interrupt-controller: Add Actions
 SIRQ controller binding
Message-ID: <20200827185456.GA2475396@BV030612LT>
References: <cover.1597852360.git.cristian.ciocaltea@gmail.com>
 <6bd99d4a7e50904b57bb3ad050725fbb418874b7.1597852360.git.cristian.ciocaltea@gmail.com>
 <20200825220913.GA1423455@bogus>
 <20200826214220.GA2444747@BV030612LT>
 <CAL_JsqLvXDFL6vFooPYLJ1QnZ7L756fNesXo-LW_scs9rV-zPA@mail.gmail.com>
 <20200827100629.GA2451538@BV030612LT>
 <64580e3b9acada6ff4ae9fdef02ac304@kernel.org>
 <20200827152428.GA2467154@BV030612LT>
 <7de137f820d5a3b7921bda0751509f85@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7de137f820d5a3b7921bda0751509f85@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 04:42:04PM +0100, Marc Zyngier wrote:
> Cristian,
> 
> On 2020-08-27 16:24, Cristian Ciocaltea wrote:
> > Hi Marc,
> > 
> > On Thu, Aug 27, 2020 at 11:35:06AM +0100, Marc Zyngier wrote:
> > > On 2020-08-27 11:06, Cristian Ciocaltea wrote:
> > > > On Wed, Aug 26, 2020 at 04:48:38PM -0600, Rob Herring wrote:
> > > > > On Wed, Aug 26, 2020 at 3:42 PM Cristian Ciocaltea
> > > > > <cristian.ciocaltea@gmail.com> wrote:
> > > 
> > > [...]
> > > 
> > > > > Ultimately the GIC trigger type has to be
> > > > > something. Is it fixed or passed thru? If the latter, just use 0
> > > > > (IRQ_TYPE_NONE) if the GIC trigger mode is not fixed. Having some sort
> > > > > of translation of the trigger is pretty common.
> > > >
> > > > Yes, as explained above, the SIRQ controller performs indeed the
> > > > translation of the incoming signal. So if I understand correctly, your
> > > > suggestion would be to use the following inside the sirq node:
> > > >
> > > > interrupts = <GIC_SPI 13 IRQ_TYPE_NONE>, /* SIRQ0 */
> > > >              [...]
> > > 
> > > Please don't. If you are describing a GIC interrupt, use a
> > > trigger that actually exists. Given that you have a 1:1
> > > mapping between input and output, just encode the output
> > > trigger that matches the input.
> > 
> > Understood, the only remark here is that internally, the driver will
> > not use this information and instead will continue to rely on the input
> > to properly set the trigger type for the output.
> 
> It's fine. The binding has to be consistent on its own, but
> doesn't dictate the way the driver does thing.
> 
> > The question is if the driver should also emit a warning (or error?)
> > when the trigger type supplied via DT doesn't match the expected value.
> 
> Rob will tell you that the kernel isn't a validation tool for broken
> DTs. Shout if you want, but you are allowed to simply ignore the
> output trigger for example
> 
> > If yes, we should also clarify what the user is supposed to provide in
> > the controller node: the trigger type before the conversion (the input)
> > or the one after the conversion (the output).
> 
> The output of a SIRQ should be compatible with the GIC input it is
> attached to. You can have:
> 
>         device (LEVEL_LOW) -> SIRQ (LEVEL_HIGH) -> GIC
> 
> but you can't have:
> 
>         device (LEVEL_LOW) -> SIRQ (EDGE_RISING) -> GIC
> 
> because that's not an acceptable transformation for the SIRQ,
> nor can you have:
> 
>         device (EDGE_FALLING) -> SIRQ (EDGE_FALLING) -> GIC
> 
> because EDGE_FALLING isn't a valid input for the GIC.
> 
> In both of the invalid cases, you would be free to apply
> which ever transformation actually makes sense, and shout
> at the user if you want to help them debugging their turf.
> The later part is definitely optional.
> 
> Hope this helps,

This certainly helps a lot, now I have a clear understanding of what is
to be done next.

>         M.
> -- 
> Jazz is not dead. It just smells funny...

Many thanks for the detailed explanations,
Cristi
