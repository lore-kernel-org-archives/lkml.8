Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2699C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B619920801
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cO7lKma5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgCEWSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:18:21 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:41851 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgCEWSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:18:21 -0500
Received: by mail-ua1-f66.google.com with SMTP id d19so2702277uak.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 14:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KaysUP+3Av+N3rptK3NvGlj/ejFA3gDwE+RY9/HC1SE=;
        b=cO7lKma5P41BEzS5Zq4IgnFZZnd95U39OACyYzmddDkWoykXKe+Dc1zrW6TCjWts4a
         /MNL7estdbZEtjBHceq0tR2XThzeTxj0qJNzHFevlJ4Clj2em5EaYjSfsuSdCk1X+h5r
         8bdYd942qRJya+3QBptQJQH7B8bFN5XRqf0x8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KaysUP+3Av+N3rptK3NvGlj/ejFA3gDwE+RY9/HC1SE=;
        b=UWxhC4MGCxtH2J2Uw6Z8YHesmESwZT3ne5IpObvRsNUfkJooTFqykm59EYzsnJidmU
         C4pKsbwvyL0lusi0osIhHiG7TqyK3pENA7Kv3Ema3eGx17U8za43DDhnqdMpvEj4Goh3
         piRFAt8CmaNhawmla9W4XzmsvjAxh+Rzw8eCYMd3DpzmbgYAK2YrtHWBzkwIfwgKndQC
         duank1KIF8nlxM7rOoSxLry/QQtt3wwRkgYWeWsEb1xMKVgWJnQLRZ0ntQBHeMRVg400
         yGP1G79Y016IbsPS+TPuni+yFC8e+GRtdwMkt05/gOdWPHYcO0bj+mRZXJoMk7S6OkG8
         uxxQ==
X-Gm-Message-State: ANhLgQ3Yg89BqUG86xl9nwBJLvOLGZxw9pF9S9UZKiB/AyVs7dpxv6Qw
        6h5TsXhEcuAqvztLBa4zqY7an2Wi2Fs=
X-Google-Smtp-Source: ADFU+vuKCTvOOcuFuedNh4DnZp6i8S+SKw0ytAR/VIh+yN8eRi6EibGyf6PhcAIB7cAJ/BBgATwNVw==
X-Received: by 2002:ab0:4144:: with SMTP id j62mr20094uad.13.1583446698278;
        Thu, 05 Mar 2020 14:18:18 -0800 (PST)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id q85sm6023365vke.42.2020.03.05.14.18.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2020 14:18:17 -0800 (PST)
Received: by mail-vk1-f176.google.com with SMTP id x62so59208vkg.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 14:18:17 -0800 (PST)
X-Received: by 2002:a1f:97c8:: with SMTP id z191mr983268vkd.0.1583446696985;
 Thu, 05 Mar 2020 14:18:16 -0800 (PST)
MIME-Version: 1.0
References: <1582889903-12890-1-git-send-email-mkshah@codeaurora.org>
 <1582889903-12890-4-git-send-email-mkshah@codeaurora.org> <CAD=FV=V92fFH8q+yvMk2sWdgi_xjFyvt3rMu14O+sO5zLp2kGg@mail.gmail.com>
 <7704638e-b473-d0cf-73ab-2bdb67b636ba@codeaurora.org> <CAD=FV=XL631dpEY8iB=gzjnh1cZVk6AKRafkQ7ke++AfXtuHNA@mail.gmail.com>
 <c65ec56b-6cd2-8593-7d25-23eb2f3672d0@codeaurora.org>
In-Reply-To: <c65ec56b-6cd2-8593-7d25-23eb2f3672d0@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 5 Mar 2020 14:18:05 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VNaqwiti+UB8fLgjF5r2CD2xeF_p7qHS-_yXqf+ZDrBg@mail.gmail.com>
Message-ID: <CAD=FV=VNaqwiti+UB8fLgjF5r2CD2xeF_p7qHS-_yXqf+ZDrBg@mail.gmail.com>
Subject: Re: [PATCH v9 3/3] soc: qcom: rpmh: Invoke rpmh_flush() for dirty caches
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, lsrao@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 5, 2020 at 1:41 AM Maulik Shah <mkshah@codeaurora.org> wrote:
 >> There are other cases like below which also gets impacted if driver
> >> don't cache anything...
> >>
> >> for example, when we don=E2=80=99t have dedicated ACTIVE TCS ( if we h=
ave below
> >> config with ACTIVE TCS count 0)
> >>      qcom,tcs-config =3D <ACTIVE_TCS  0>,
> >>                            <SLEEP_TCS   3>,
> >>                            <WAKE_TCS    3>,
> >>
> >> Now to send active data, driver may re-use/ re-purpose few of the slee=
p
> >> or wake TCS, to be used as ACTIVE TCS and once work is done,
> >> it will be re-allocated in SLEEP/ WAKE TCS pool accordingly. If driver
> >> don=E2=80=99t cache, all the SLEEP and WAKE data is lost when one
> >> of TCS is repurposed to use as ACTIVE TCS.
> > Ah, interesting.  I'll read the code more, but are you expecting this
> > type of situation to work today, or is it theoretical for the future?
> yes, we have targets which needs to work with this type of situation.

My brain is still slowly absorbing all the code, but something tells
me that targets with no ACTIVE TCS will not work properly with non-OSI
mode unless you change your patches more.  Specifically to make the
zero ACTIVE TCS case work I think you need a rpmh_flush() call after
_ALL_ calls to rpmh_write() and rpmh_write_batch() (even those
modifying ACTIVE state).  rpmh_write_async() will be yet more
interesting because you'd have to flush in rpmh_tx_done() I guess?
...and also somehow you need to inhibit entering sleep mode if an
async write was in progress?  Maybe easier to just detect the
"non-OSI-mode + 0 ACTIVE TCS" case at probe time and fail to probe?


-Doug
