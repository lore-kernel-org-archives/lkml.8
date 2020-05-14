Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A36EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B983205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HkgUt4eW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgENO5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 10:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbgENO5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 10:57:06 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA0BC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 07:57:06 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id b26so2896960lfa.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 07:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4HTVnMXFqn25Or2z9tz1JpDCA867OnT6AzmCxAyNnTA=;
        b=HkgUt4eWkp2ApKf+Q8p05mUbDzAnPvl/NPEQp2HBG5nnd3tpFK+filWKg9ep0Dfic6
         LUAPu+HOZ/+1wy2K509QzOP5abxcwXkU7Z5ZeQtdDY+ogtGKmqt7sjHqKAaRDofww6u2
         4B0uBmngMwrctbwae+ZobEPCtD/jcEuch+BajoIi+2SAlh4xpXrSfNhJkeLTiKP/GIBf
         JItLNV2MwlHe77/BjSc0m3UW2Y7E8CJRpp3SH/Z5gwzH8qH39BrbCpg4TnOm3FsTPl0i
         uOdoiyGdWbbe3iKB6uhmJXdWeREj5h7hO4s2BQXAvfL4dUj45BIE/GGgEJ11Ac8oT6V8
         gHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4HTVnMXFqn25Or2z9tz1JpDCA867OnT6AzmCxAyNnTA=;
        b=QFIVFBBhAc7q+x2P61X5AGd7HOaL/XPa43bzsuq+z91HB7ETCjiB5H+ye4hCfMGCPN
         0YTMTmNt4wjMf14M6T7bm1ji66hQNJhtI48F+hlhjIT7J4TtvKmxkEeYgZ8yyfn7HgTn
         Cx4yN7D9CU+pCvh5KA3Ezjci8f1eLk/vD1yRey7mI1nphWZWmZe2RWuKdcO172TpSu80
         awa0f+ek6ITuBwtF6rm7Bpem6ZTxq2MZst3wPKmlOMuEzLOwsZJ/VZmKEO8EMXR2//Hq
         83qISxXUS+RgQzI4YQiqgd6zr/x80cfcZg2fila3N+WyhW9jD5tIsZlkclofjNmyI17t
         Yw2w==
X-Gm-Message-State: AOAM530695WvIUMdYDdJ0NddEZLhyFr2B3MEX2VDh3rw6KUGC7a0Yp19
        Frb+J3GkAdHsNMe1fiIvuV7inlKEKgcwycffafXJbw==
X-Google-Smtp-Source: ABdhPJwHqTgIhDJNt4wwVGJjnTipm7hc43f5LFNNT5JulCF6C5kN/TFfsARDd0Vl9CNRBA6h2m+cFhheln5UzkaJCrk=
X-Received: by 2002:a19:4f1b:: with SMTP id d27mr3626688lfb.81.1589468224785;
 Thu, 14 May 2020 07:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200514082109.27573-1-etienne.carriere@linaro.org>
 <20200514082109.27573-2-etienne.carriere@linaro.org> <20200514142442.GB23401@bogus>
In-Reply-To: <20200514142442.GB23401@bogus>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Thu, 14 May 2020 16:56:53 +0200
Message-ID: <CAN5uoS9gZ7820Fg-6dmm4BO5GW+Y6D3O5Xt3gUQtYVZGafm_XA@mail.gmail.com>
Subject: Re: [PATCH 2/2] firmware: psci: support SMCCC v1.2 for SMCCC conduit
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        lorenzo.pieralisi@arm.com, maz@kernel.org,
        Steven Price <steven.price@arm.com>, alexios.zavras@intel.com,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 May 2020 at 16:24, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, May 14, 2020 at 10:21:09AM +0200, Etienne Carriere wrote:
> > Update PSCI driver to support SMCCC v1.2 reported by secure firmware
> > and indirectly make SMCCC conduit properly set when so. TF-A release
> > v2.3 implements and reports SMCCC v1.2 since commit [1].
> >
> > Link: [1] https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/commit/?id=e34cc0cedca6e229847c232fe58d37fad2610ce9
> > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > ---
> >  drivers/firmware/psci/psci.c | 14 ++++++++++----
> >  include/linux/psci.h         |  1 +
> >  2 files changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> > index 2937d44b5df4..80cf73bea4b0 100644
> > --- a/drivers/firmware/psci/psci.c
> > +++ b/drivers/firmware/psci/psci.c
> > @@ -409,11 +409,17 @@ static void __init psci_init_smccc(void)
> >       feature = psci_features(ARM_SMCCC_VERSION_FUNC_ID);
> >
> >       if (feature != PSCI_RET_NOT_SUPPORTED) {
> > -             u32 ret;
> > -             ret = invoke_psci_fn(ARM_SMCCC_VERSION_FUNC_ID, 0, 0, 0);
> > -             if (ret == ARM_SMCCC_VERSION_1_1) {
> > +             ver = invoke_psci_fn(ARM_SMCCC_VERSION_FUNC_ID, 0, 0, 0);
> > +
> > +             switch (ver) {
> > +             case ARM_SMCCC_VERSION_1_1:
> >                       psci_ops.smccc_version = SMCCC_VERSION_1_1;
> > -                     ver = ret;
> > +                     break;
> > +             case ARM_SMCCC_VERSION_1_2:
> > +                     psci_ops.smccc_version = SMCCC_VERSION_1_2;
> > +                     break;
> > +             default:
> > +                     break;
> >               }
> >       }
> >
> > diff --git a/include/linux/psci.h b/include/linux/psci.h
> > index a67712b73b6c..c7d99b7f34ed 100644
> > --- a/include/linux/psci.h
> > +++ b/include/linux/psci.h
> > @@ -24,6 +24,7 @@ bool psci_has_osi_support(void);
> >  enum smccc_version {
> >       SMCCC_VERSION_1_0,
> >       SMCCC_VERSION_1_1,
> > +     SMCCC_VERSION_1_2,
>
> I took approach to kill this completely [1] instead of having to keep
> expanding it for ever.

Yes, I've been pointed to [1]. Discard this change. Sorry for the
(little) noise.

Etienne

> --
> Regards,
> Sudeep
>
> [1] https://lore.kernel.org/linux-arm-kernel/20200506164411.3284-5-sudeep.holla@arm.com/
