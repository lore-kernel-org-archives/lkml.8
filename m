Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F74C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01EB5206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zke3BM2V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgENMwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 08:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725955AbgENMwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 08:52:34 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F38C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 05:52:33 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id a4so2482508lfh.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 05:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uCoIlQA1207VBvJOUJdZ2UqHgsI7A1R5G3zb7vQc0Lw=;
        b=Zke3BM2V++gC9yF7VuYXsh1sPJJjvKEdtcXN6VMzhbH+Pcnpbq0qF52Mmkjd9CdQ2V
         92lFlJOHkoUsxbItqH6bfVqf898nkx7Ws4uBGIyjufpOrddR71mw8Cyq9Ih6tn1tTkRj
         LDtmRqzeeW9GN7NCB7rnU1eGLklr9R81jdMTy0zGs7KiTg7WqGIT6QniCOVViTf/Hf2P
         qX3HBBAI0bkilJFGK0er7tTkMcJdCD6EWv5CXhJsSbCUxygFsOqQ+nNxLLeKurzD2uhb
         HtTDtsYs5Fx03nc3tlMcw6PNjJ4SphltEjZbwwaUORNGJGa0hsXRfrClEGs8mt2poWJk
         IboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uCoIlQA1207VBvJOUJdZ2UqHgsI7A1R5G3zb7vQc0Lw=;
        b=LAilj7JS2JL/Pu8VQngtJwinKxOgu2Y+3/tw6Qzfe8WRZ6arLe/CCnDxA/gNdkEmeK
         MY9cc+X3HKOm/7OkfbUNeuCsFVy/lxO8Cn2WltyVHrm5wuImBHX4SfszzS7zKwZ5LUCt
         97D0UHiKD3s7MCQ88XsZzGadZdf/dnvpkLupOg5c6gwy4DC/qZpU9IFwywZKDjpqphnS
         tmgjgD/H67urY5usuGFnw17JUzLDSM2MtHZMBVMXjMP8+hk6jyvIEitJ5UzHeKE8Vdx8
         4ZbEzfpbqzs3hShcV6k54hKBxWd/b94U/PkH0sWeu5U7CiWI5CXbBD96tXyZZXrypOOS
         wU8Q==
X-Gm-Message-State: AOAM531YhskhtiZ4YurLFoliteq9K/EVtsXplOk7JuVWy7yIgdBieuYm
        rapkgtJTA+Ga+lY+nsAq8puWzqDUz1vx/vCbCqK2GQ==
X-Google-Smtp-Source: ABdhPJzy+C6tPu4BL7LNgfmr8TNC0GWk/3OFcD4pNyUqP/+T/nxt8ulA71JsymOcnp6KvxyuGR+efebqw+GbtFjIs5c=
X-Received: by 2002:ac2:4da1:: with SMTP id h1mr3214154lfe.152.1589460752472;
 Thu, 14 May 2020 05:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200514082109.27573-1-etienne.carriere@linaro.org> <b8661499-6ecc-2adc-9ed6-b7c428a8aa35@arm.com>
In-Reply-To: <b8661499-6ecc-2adc-9ed6-b7c428a8aa35@arm.com>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Thu, 14 May 2020 14:52:21 +0200
Message-ID: <CAN5uoS-t-xzk3nGKyd9jJA6h0GM35qT+1tb2wpBA=BVV4yPVbg@mail.gmail.com>
Subject: Re: [PATCH 1/2] firmware: arm-smccc: define identifier for Arm SMCCC v1.2
To:     Steven Price <steven.price@arm.com>
Cc:     linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, alexios.zavras@intel.com,
        will@kernel.org, maz@kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 May 2020 at 14:38, Steven Price <steven.price@arm.com> wrote:
>
> On 14/05/2020 09:21, Etienne Carriere wrote:
> > Define identifier value reported by secure firmware when its
> > supports Arm SMCCC specification v1.2.
> >
> > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
>
> FYI Sudeep has already posted a patch to do this[1].
>
> Steve

Thanks. I'll follow the thread.

Regards
Etienne

>
> [1]
> https://lore.kernel.org/linux-arm-kernel/20200430114814.14116-3-sudeep.holla@arm.com/
>
> > ---
> >   include/linux/arm-smccc.h | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
> > index 59494df0f55b..1cf221f3f07a 100644
> > --- a/include/linux/arm-smccc.h
> > +++ b/include/linux/arm-smccc.h
> > @@ -56,6 +56,7 @@
> >
> >   #define ARM_SMCCC_VERSION_1_0               0x10000
> >   #define ARM_SMCCC_VERSION_1_1               0x10001
> > +#define ARM_SMCCC_VERSION_1_2                0x10002
> >
> >   #define ARM_SMCCC_VERSION_FUNC_ID                                   \
> >       ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,                         \
> >
>
