Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1E6C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 20:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 971192070B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 20:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i9sjjh5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgG1Urz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728745AbgG1Ury (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 16:47:54 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5415FC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 13:47:54 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id f24so1529802ejx.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 13:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ExajQAZpNTd+joqebqoVtMbLAI74qmTPLZGYxWwu4D0=;
        b=i9sjjh5UAFRZq+C3SoLUFHBEFZe6/rz5SKiFPjmp8dcIsULItKWNbWHaJLPdjgA3Mj
         TmKlkfab84dkU55DoSBegy1MTK+TCHgJKsRJtDKe0ppHkw9hqFaosw/z/OPlicU5HoFK
         om2qlX+kETm4XnxUxtAKkwLggUd0PsUuko2zc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ExajQAZpNTd+joqebqoVtMbLAI74qmTPLZGYxWwu4D0=;
        b=WTfSnGZqatlBspQPi8MPo4uWDUSAtkWrhp/QPk9p8nGYbU2fqbTuycc0SqTWVfHwwa
         6erBzhhUzHtFHYIkkruM6DGlkiBpw3m+HXmup6u9RxNfirR8qCaJgW07L4PXWuxPtef6
         Z1HwHYxF+xc9SQmMJyqsEFnVvFgIIMiol3L6QAAtVeD43+KFJau5UK1+4cD7TO0WFWNB
         Df3Of3svddfzGFRlzRps7lBw6XJYRi88hhW6pEi4ZATbOsl+dzBts2RwDn43Lp+SeO8x
         DLoJKNg4qc2YH560yGJ4jbarxsi1we2GqPzvjI1vqG7zLKGgtxW//EUxFn84S+5+bTJF
         LhRA==
X-Gm-Message-State: AOAM532JocZ3sxpGrpRjSeEUZulb26Z00XKDcu8BG5VRkRTKdnbHy7/j
        Ed5kHKyU4PB7FQMNUxux3HVq/8HadzM=
X-Google-Smtp-Source: ABdhPJymc2qZAYfguqRv+YnqBAL2gPEAx9eaVlppvZxfc868eB0NYpzN8wyKwX1NKj1C6vNsBqxxsg==
X-Received: by 2002:a17:906:ca4f:: with SMTP id jx15mr19633866ejb.449.1595969272694;
        Tue, 28 Jul 2020 13:47:52 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id j7sm6809766ejb.64.2020.07.28.13.47.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 13:47:51 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id 3so850424wmi.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 13:47:51 -0700 (PDT)
X-Received: by 2002:a7b:cc0b:: with SMTP id f11mr3518054wmh.79.1595969271235;
 Tue, 28 Jul 2020 13:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid>
 <20200728151258.1222876-1-campello@chromium.org> <20200728091057.4.I33c50453845a8167969130d514af86e573b6ef31@changeid>
 <CAHp75VcRBCmRdGh5WVGDY28AzNhBufkoNkrEZ7uEFCW2MsJ=qg@mail.gmail.com>
In-Reply-To: <CAHp75VcRBCmRdGh5WVGDY28AzNhBufkoNkrEZ7uEFCW2MsJ=qg@mail.gmail.com>
From:   Daniel Campello <campello@chromium.org>
Date:   Tue, 28 Jul 2020 14:47:15 -0600
X-Gmail-Original-Message-ID: <CAHcu+Va0DVm1Pw__jYF_EhZHSQnSqb_zex2NN1M67zc=FTAitA@mail.gmail.com>
Message-ID: <CAHcu+Va0DVm1Pw__jYF_EhZHSQnSqb_zex2NN1M67zc=FTAitA@mail.gmail.com>
Subject: Re: [PATCH 04/15] iio: sx9310: Remove acpi and of table macros
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        kbuild test robot <lkp@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 12:09 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Jul 28, 2020 at 6:16 PM Daniel Campello <campello@chromium.org> wrote:
> >
> > Avoids unused warnings due to acpi/of table macros.
> >
>
> At the same time I would check if mod_devicetable.h is included.
I did the following and no error showed up:
#ifndef LINUX_MOD_DEVICETABLE_H
#error Missing include
#endif

>
> > Signed-off-by: Daniel Campello <campello@chromium.org>
> > Reported-by: kbuild test robot <lkp@intel.com>
>
>
> --
> With Best Regards,
> Andy Shevchenko

Regards,
Daniel Campello
