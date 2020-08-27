Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4C9C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B1522080C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZ1UT1Jv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgH0PYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgH0PYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 11:24:33 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC13C061264;
        Thu, 27 Aug 2020 08:24:33 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a21so8230205ejp.0;
        Thu, 27 Aug 2020 08:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RdoDtBKGcqZmEr6XwRvBVpJT6+jSdmIYiVMHvZ2UEtM=;
        b=dZ1UT1JvUfj8uxpfO5tKZObD9vupZ6VKPHEPWHiIX6/azQ3Xx0wiMpuwNWJrbqQuRF
         MtFchebdnoYgSKqDE0PxgEUQ2ono+2kbI99Ov7xzOQqnPKNzI68N8AQ9wVOUPW+Rn0e7
         sYR5JWw22qj/yPUWFU7yH3afY4qi1ThAZFMX4QPAmju0zzCW9ZQnqMzGiptFdTfuuV3O
         l7VwkbseTYupt71wVEWopi3mA00+fcQB0ENTmVwqdxeP4dQe5BPNA7jk9FprgWcTqtyR
         ezQCSepa0hmpM8sRO9RiKBLtNV/WHEM+gxLrIEPK467vYT1vQ6PHqju5+BgSG7sd4VPd
         /lSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RdoDtBKGcqZmEr6XwRvBVpJT6+jSdmIYiVMHvZ2UEtM=;
        b=DMbWc8H7mqAKg6u6Ny3/tm149wZ4UwKFUH0TP6MwqeJpFGXOdTvUplgqyGeo8m7I7L
         i7fSW22BRhJTaA03nJ/22zFv8hl0NhFV2jINR06rhIvnPGSl7FLe/hAs5j4JFI930djZ
         ogZrxOZqAeVsAqFFOnprFvKie+86pBEVZPEddWSjXfflQjYZfq4u5GOKzfRxF21kNBmJ
         +MYFSGNCHDsItkYKdRT3/Qx0YOwjUxBMPllNAKGT3WozpyLT7F6vlblxunf6YVERMr0F
         tGCnkVkUDtYNkfZedjrIE45IxXZty+JM43sKSV4GxF83fU25niIYWrXuaoDjMMFx94i3
         lUog==
X-Gm-Message-State: AOAM530YSB682hoy1JaY0K8vukfqCfbMENykRakxEbBcPY+8BLQ9vT/g
        pVTaRkS3K6xmYQ4DbHSZFx3Zg3Ee7E4=
X-Google-Smtp-Source: ABdhPJwE8DVg2X/JWXzdbYoyz5GYUFxkza0BR0PvLwoLKnPpFlRU1KQlEOc3ePw+NgAdF36O9erBYw==
X-Received: by 2002:a17:906:1719:: with SMTP id c25mr22373847eje.487.1598541871646;
        Thu, 27 Aug 2020 08:24:31 -0700 (PDT)
Received: from BV030612LT ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id g9sm1742781edk.97.2020.08.27.08.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 08:24:30 -0700 (PDT)
Date:   Thu, 27 Aug 2020 18:24:28 +0300
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
Message-ID: <20200827152428.GA2467154@BV030612LT>
References: <cover.1597852360.git.cristian.ciocaltea@gmail.com>
 <6bd99d4a7e50904b57bb3ad050725fbb418874b7.1597852360.git.cristian.ciocaltea@gmail.com>
 <20200825220913.GA1423455@bogus>
 <20200826214220.GA2444747@BV030612LT>
 <CAL_JsqLvXDFL6vFooPYLJ1QnZ7L756fNesXo-LW_scs9rV-zPA@mail.gmail.com>
 <20200827100629.GA2451538@BV030612LT>
 <64580e3b9acada6ff4ae9fdef02ac304@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64580e3b9acada6ff4ae9fdef02ac304@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Thu, Aug 27, 2020 at 11:35:06AM +0100, Marc Zyngier wrote:
> On 2020-08-27 11:06, Cristian Ciocaltea wrote:
> > On Wed, Aug 26, 2020 at 04:48:38PM -0600, Rob Herring wrote:
> > > On Wed, Aug 26, 2020 at 3:42 PM Cristian Ciocaltea
> > > <cristian.ciocaltea@gmail.com> wrote:
> 
> [...]
> 
> > > Ultimately the GIC trigger type has to be
> > > something. Is it fixed or passed thru? If the latter, just use 0
> > > (IRQ_TYPE_NONE) if the GIC trigger mode is not fixed. Having some sort
> > > of translation of the trigger is pretty common.
> > 
> > Yes, as explained above, the SIRQ controller performs indeed the
> > translation of the incoming signal. So if I understand correctly, your
> > suggestion would be to use the following inside the sirq node:
> > 
> > interrupts = <GIC_SPI 13 IRQ_TYPE_NONE>, /* SIRQ0 */
> >              [...]
> 
> Please don't. If you are describing a GIC interrupt, use a
> trigger that actually exists. Given that you have a 1:1
> mapping between input and output, just encode the output
> trigger that matches the input.

Understood, the only remark here is that internally, the driver will
not use this information and instead will continue to rely on the input
to properly set the trigger type for the output.

The question is if the driver should also emit a warning (or error?)
when the trigger type supplied via DT doesn't match the expected value.

If yes, we should also clarify what the user is supposed to provide in
the controller node: the trigger type before the conversion (the input)
or the one after the conversion (the output). 

>         M.
> -- 
> Jazz is not dead. It just smells funny...

Thanks,
Cristi
