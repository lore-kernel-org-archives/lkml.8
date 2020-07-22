Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098A9C43446
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 21:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D548D22B42
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 21:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z7n28Qr2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733018AbgGVVNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 17:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732896AbgGVVNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 17:13:16 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABC3C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 14:13:15 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id d18so2776213edv.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 14:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4x7MXfjAHP2OqVahR16pifID3jW+ZfJYn4I2NJML5F0=;
        b=Z7n28Qr2Afeyip2TTRIaKRZ1P8PLGsK6JPk5T6J+GRX0uwMZxrAzYMqduYV0jv5ZvE
         Dt1tVg8CpJYw/DA8YzaqC73uF0fQ8elUDN8m0P1R+O7tg0IubBdDqPByTymhDal1DyQ4
         9WxjFytxVtWK5xVS7giYWlioJi3IK9FjbR0PAK6j2uV0/ckSGFCFOO8u9I9H7veV6BYV
         s6PHJO4yCotlxvXj/GoEgs37U6CMOeOFfKYdi89ZQs9k7Q+rR3rDa+hsUEMvI9bYAya2
         Izop23/2wAbff08VYg6UBgi2VdWzm3QiNVnzJF+5ZMqhJtM3OyXQ2pqwJOdAcOk2QhaN
         oIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4x7MXfjAHP2OqVahR16pifID3jW+ZfJYn4I2NJML5F0=;
        b=Iipq1IGLHleyVC7y0JUb1sP7tkJJK9iPxgtcT5/WVpq13q8hwb1/TDP2Ejc9+a+3q2
         MHoUuK5rLVo1M5aeZcl9rk7Bq52hmVXsGFW9kEENk7toslH+bK1mSye+5B10KwKhY0Op
         7I3oRvUOGzP0iPy8ySz/FRUDajHInw0zM5FWoXisWyUszYHe/zLxNlaeCQvozm66btBP
         9Bg22bFLDVgmrjkn/HFpJdhsqFGTEvu4p9NwDY1M6uSvcLMSHpfsHEr/1vu38gq2BpnI
         3m3R0bpFApRLQdurxapXlV68pJQv+ixvQtLEcBfQH3l/Ek6kamz2O8Pb/9q1jwRUIBb0
         qg6Q==
X-Gm-Message-State: AOAM5339DPLpSmMV6zs3RNNfu9kEorsVbXYJkiQsAUx5w/M7FoQZpYaO
        NHBoQ6PSyiY63v7TjqNskfsMjesoaphhH/Vm8NAY8Kdw39U=
X-Google-Smtp-Source: ABdhPJwyScPYxzvRKewC/U9XRkoM92lky4JqJepfTA7C5u8Jco5VQu5qwdd9bzZxnP2cbMpwMrZRsEs3Vww9v9ic5U0=
X-Received: by 2002:a05:6402:22f0:: with SMTP id dn16mr1295083edb.83.1595452393987;
 Wed, 22 Jul 2020 14:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200722015732.1720840-1-briannorris@chromium.org>
 <20200722015732.1720840-2-briannorris@chromium.org> <5ebf1534-8045-9894-9c1c-b92b9c6d8479@collabora.com>
 <CA+ASDXMk7Tg7Lwqt8Pv5BQT0J40dpJtqrL9TAn8y5Nj3TCkj6Q@mail.gmail.com>
In-Reply-To: <CA+ASDXMk7Tg7Lwqt8Pv5BQT0J40dpJtqrL9TAn8y5Nj3TCkj6Q@mail.gmail.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 22 Jul 2020 14:13:03 -0700
Message-ID: <CABXOdTfvNBuaEx-vTU2MqNF_EmULJu=506oUtd29kN=FAPswBQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] platform/chrome: cros_ec_proto: check for missing EC_CMD_HOST_EVENT_GET_WAKE_MASK
To:     Brian Norris <briannorris@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 1:50 PM Brian Norris <briannorris@chromium.org> wrote:
>
> On Wed, Jul 22, 2020 at 3:19 AM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
> >
> > Hi Brian,
> >
> > Thank you for your patch, I'll take a look soon but I'd like to ask if you can
> > join the discussion with this patchset [1], specially this one [2]. We're trying
> > to match EC errors with standard linux kernel errors because we think can be
> > helpful.
> >
> > [1] https://lore.kernel.org/patchwork/cover/1276734/
> > [2] https://lore.kernel.org/patchwork/patch/1276738/
>
> Hi Enric,
>
> Thanks, I'll do that. I do wonder sometimes how non-maintainers should
> best support "community" around these things, for subsystems that
> don't have a dedicated mailing list and are therefore sent only to
> maintainers + LKML-fire-hose. I could probably subscribe to LKML and
> filter it, but something tells me my mailbox will still manage to
> explode somehow... Anyway, I digress.
>
> Other than perhaps taking a lesson not to propagate -ENOTSUPP, I don't
> think this series should block on that, as this is a bugfix IMO.
>

My patch will return -EOPNOTSUPP for EC_RES_INVALID_COMMAND, so maybe
you could do the same. In my latest version (not yet submitted) I
extracted the conversion into a separate function, so if your patch is
accepted now I can just add another patch on top of it to start using
that function.

Thanks,
Guenter
