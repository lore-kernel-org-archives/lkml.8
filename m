Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1465C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 22:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C49E520739
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 22:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HTBqdcQL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389490AbgDMWNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 18:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727871AbgDMWNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 18:13:42 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874F3C0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 15:13:40 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id v2so10818804oto.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 15:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GLCCOE0nOtb0ZaUeeY6RIoKusS2ZdXw/3d25jLxeyEE=;
        b=HTBqdcQL40YBSL0sugXtVRoo0wZPVSSoNy5a8NcjDpM3mZwtEQMRdPu1PDT295H4I/
         Mo8llaAUvtKw5BFYovYN1CZ0+EdASDHusjzAIc+mmLaU1UEF7oWi2FtkulyLVFPP4C1k
         CVzpPa1z/UVFpTJzAaHNQjg3gv8eagEULxuD8WxVhHuXwaJSvWcv8vkIVTp1ilvZb7Qs
         i4o1clqtOl7u5jDLjwwlhrz2xRhbJLrdgNfQWePMm8G+XVG8cg9S+A4mu9/Xi5Fmsghj
         mQIm3ntW8DS1xEI0wWrtIRL1omqpcDkeFBrph7cH3ipv3SBPduRq0UNk3bXzRhcECW6I
         v3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GLCCOE0nOtb0ZaUeeY6RIoKusS2ZdXw/3d25jLxeyEE=;
        b=GqbTS6O0Ria70+q3sLN0ozVv9jd5zcA8sxsmmrgHv3/hRXRiDZNDwq40LUrYMD3Tke
         tV5ktFTWKxS6ux5FG2coLQSyzrLd6wUp6G4vv3db6yiIUmWHvybXqHCqXILotExQqHUD
         k5pmOFVfYGVmHGE4gwQlJ4B1IP2iXLuHlgzFDOvKrWNdGgFJAJLGZHfdus/soE25PZ0C
         RdEEdXP+i5+hh40Rvqs2aWQ4Oh5AwWBftisdi4ZdAfP+pJ2Jp3mAZYiPvV30Dzf4mj2m
         jhuk0VommExiowgW3Rvmm0UhvfyV7QR9wI52Iya2LLQu3OVksKXB0hXb7oLkgjoxLppy
         1qAw==
X-Gm-Message-State: AGi0PuY2t8tzlNv0Gw3QuaXnSEyADXyRAqFblqjlSbXRKR5Bqe44XUnF
        +T3S6uoNxzD29JYHfF9n6nsxn9bFo4eLVCobHw4RxQ==
X-Google-Smtp-Source: APiQypLvOgzX5JA3z8Oxe7h1JlV5rrdqzv/xLLs4kYksoQfwBcqH6vwqXiL83VnjfgaI1LfWLrzyw7EiKz+hqQP9rOI=
X-Received: by 2002:a05:6830:20c3:: with SMTP id z3mr9665932otq.102.1586816019576;
 Mon, 13 Apr 2020 15:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200411045918.179455-1-saravanak@google.com> <86sghas7so.wl-maz@kernel.org>
In-Reply-To: <86sghas7so.wl-maz@kernel.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 13 Apr 2020 15:13:27 -0700
Message-ID: <CALAqxLXkbNh4GVC82SqXNoib+4FQS2Y3XbePyhreJcwWoVEQaw@mail.gmail.com>
Subject: Re: [RFC PATCH v1] irqchip: Add IRQCHIP_MODULE_BEGIN/END helper macros
To:     Marc Zyngier <maz@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Android Kernel Team <kernel-team@android.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 11, 2020 at 2:14 AM Marc Zyngier <maz@kernel.org> wrote:
> On Sat, 11 Apr 2020 05:59:18 +0100,
> Saravana Kannan <saravanak@google.com> wrote:
> >
> > Add helper macros IRQCHIP_MODULE_BEGIN and IRQCHIP_MODULE_END that add
> > the boilerplate code to be able to compile an irqchip driver as a
> > module.
> >
> > The driver developer just needs to do add IRQCHIP_MODULE_BEGIN and
> > IRQCHIP_MODULE_END(driver_name) around the IRQCHIP_DECLARE macros, like
> > so:
> >
> > IRQCHIP_MODULE_BEGIN
> > IRQCHIP_DECLARE(foo, "acme,foo", acme_foo_init)
> > IRQCHIP_DECLARE(bar, "acme,bar", acme_bar_init)
> > IRQCHIP_MODULE_END(acme_irq)
> >
> > Cc: John Stultz <john.stultz@linaro.org>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> > I don't expect this patch to be perfect or the final version. But I'd
> > like to introduce macros like this that don't need the driver developer
> > to copy/paste or repeat the same thing (compat string, function name,
> > etc) in multiple places for the driver to work as a module. If the exact
> > style of my macros aren't appealing, I'm open to other suggestions.
> >
> > There are some checkpatch warning about the > 80 columns that my patch
> > doesn't add. There are also checkpatch warnings about the trailing ; in
> > a macro, but I need those for IRQCHIP_DECLARE to work when the driver is
> > builtin.
>
> I think you are looking at the problem from the wrong end, and adding
> syntactic sugar should be the least of your worries. The reason for
> not allowing irqchip drivers to be modular is that there is no
> refcounting in place to prevent drivers from being removed whilst the
> IRQ stack still has irq_desc, irq_data and various other objects
> indirectly referencing the driver.
>
> I'm all for addressing these issues, though it begs the question of
> *why* you want to do this. We have been perfectly happy with built-in
> irqchips so far (they are pretty small, and there aren't millions of
> them), so what changed?
>

I can't speak for Saravana, but my sense is that moving functionality
to loadable modules is becoming more important for Android devices due
to their efforts to utilize a single kernel image across various
vendor devices[1].  Obviously with mobile device constraints
minimizing the unused vendor code in the kernel image is important,
and modules help there. While the unloading issues you raised are
important, one can still benefit from having a permanent module
(modules that don't have a .remove handler), as they can be only
loaded on the devices that use them. You're also right that irqchip
drivers are fairly small, but one issue is that any code they depend
on also has to be built in if they are not able to be configured as a
module, so by allowing the irqchip driver to be a module, you can also
modularize whatever platform calls are made from that driver.

thanks
-john

[1]: See:
  https://arstechnica.com/gadgets/2019/11/google-outlines-plans-for-mainline-linux-kernel-support-in-android/
  https://www.linuxplumbersconf.org/event/2/contributions/61/attachments/69/80/Android_and_Linux_Kernel__Herding_billions_of_penguins_one_version_at_a_time.pdf
  https://linuxplumbersconf.org/event/4/contributions/401/attachments/318/542/GKI_Progress.pdf
