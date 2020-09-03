Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F48C43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F14920684
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZaU4FVQI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbgICUjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729686AbgICUjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:39:15 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CBEC061246
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 13:39:14 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id h11so4331960ilj.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 13:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tydz84oeqirnpuLu3bbRByfKWhDqGhIFntBJvkUrXd8=;
        b=ZaU4FVQIZtMoJYgeUnVah1sxMUXe4vfXTOApozs8v6qNaLeEML6U2zwXK4RI8j3L8R
         gdk49UHCtCkTT7Qj7uWEEVLmTeC7BKMTFS0FisXaRhAcDqj37QcTT3AG2uDlFQsretSm
         jx3/IQsY08B6aRhkWnaPGh2zA1VHmrLvhm6eM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tydz84oeqirnpuLu3bbRByfKWhDqGhIFntBJvkUrXd8=;
        b=dNfmxbhGFe/Vl7B0pvtFKy8sEfNq3vAbPI/LeLl4gdR6w7uVk2N7Ez2XAKK79lywGd
         rHliTUiBy23cJoYtYlQS/8zwNmAgefZSHriA0eH8ARSIGk/zTi1pX51eQ9sMlUdKPr2O
         BCRWrn55TenFoElUMSEBrr7AjzCbZzp9YuAilV/iBeqsJ0Bg5n0PjMvsgsyIT+M7IXVs
         BJcOIlNLk7y0B6B0dqcPg1D8ygBLMYv1IPUYnKQjia2Ac63S7+qg8drYL/DNFod3ymdy
         w+NPRNTgBmxECT9GO6PPzcL4e3GeMl0vmAn//VVEUZf+fJcjIqgdoxJTZkS5wwMnwvZj
         193g==
X-Gm-Message-State: AOAM533gWp6N21N688wEzURNM0D+K3EIS6XN4nibsHRLr/fj+NjuuFLg
        xJR9T5+we1rv/p1DZbFitn53JJalinXjuCU4NTVqSw==
X-Google-Smtp-Source: ABdhPJwBvaiqqfUAkNG6JlVarMP8g2QAyipuCkVid/rgJbNcm8n/aSIMAlmfjCs1sxttE5hXJYAbbpIvA3jaGYNftIo=
X-Received: by 2002:a92:b74c:: with SMTP id c12mr5047627ilm.237.1599165554066;
 Thu, 03 Sep 2020 13:39:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200903141746.996974-1-enric.balletbo@collabora.com> <CABXOdTeHZ52HzghkS85rRs92gG-mPe6JEfUx9uz3vMrxXYjpaQ@mail.gmail.com>
In-Reply-To: <CABXOdTeHZ52HzghkS85rRs92gG-mPe6JEfUx9uz3vMrxXYjpaQ@mail.gmail.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Thu, 3 Sep 2020 13:39:00 -0700
Message-ID: <CAPUE2utgmDH6PL4ubW9G0-3V+uwovfFiKSvHf_=GacpuS2KJRg@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: Kconfig: Remove the transitional
 MFD_CROS_EC config
To:     Guenter Roeck <groeck@google.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 3, 2020 at 8:02 AM Guenter Roeck <groeck@google.com> wrote:
>
> On Thu, Sep 3, 2020 at 7:17 AM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
> >
> > The MFD_CROS_EC config was a transitional Kconfig option to not break
> > current defconfigs in the kernel. Now, this is not required anymore
> > because all the defconfigs have been removed this option and migrated to
> > enable the CrOS EC parts individually.
> >
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>
> Reviewed-by: Guenter Roeck <groeck@chromium.org>
Tested-by: Gwendal Grignou <gwendal@chromium.org>
>
> > ---
> >
> >  drivers/platform/chrome/Kconfig | 10 ----------
> >  1 file changed, 10 deletions(-)
> >
> > diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> > index a056031dee81..ccc23d8686e8 100644
> > --- a/drivers/platform/chrome/Kconfig
> > +++ b/drivers/platform/chrome/Kconfig
> > @@ -3,16 +3,6 @@
> >  # Platform support for Chrome OS hardware (Chromebooks and Chromeboxes)
> >  #
> >
> > -config MFD_CROS_EC
> > -       tristate "Platform support for Chrome hardware (transitional)"
> > -       select CHROME_PLATFORMS
> > -       select CROS_EC
> > -       select MFD_CROS_EC_DEV
> > -       depends on X86 || ARM || ARM64 || COMPILE_TEST
> > -       help
> > -         This is a transitional Kconfig option and will be removed after
> > -         everyone enables the parts individually.
> > -
> >  menuconfig CHROME_PLATFORMS
> >         bool "Platform support for Chrome hardware"
> >         depends on X86 || ARM || ARM64 || COMPILE_TEST
> > --
> > 2.28.0
> >
