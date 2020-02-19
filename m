Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D8EC3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 00:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF502465A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 00:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OtBOFvHp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbgBSATS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 19:19:18 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43561 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgBSATS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 19:19:18 -0500
Received: by mail-ot1-f65.google.com with SMTP id p8so21371661oth.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 16:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xenh2Sb7watxNJKL24pMYing6QNd1CcZcrQqPV0Tmqc=;
        b=OtBOFvHpDvOG/VrUXyWUqM7/v93QMT690BDatQIdj4wKhYvlnn/TszCLy4WZEd0uH1
         PvT2NIC6GflEREjR7GMOwzt79s3Mq5OdV+wwBC4BvW6tLoFAzeeIi499q2VuSoOR4al1
         fVnCluY89EcQHTVt4DA+Yobkp/sG1FzVMy55Z0hFR9EeVlZj3Y3TxNQMqD36p/jt+592
         Sbj0PRujciQo2114ylm54UcukkvTu6eVlTAzUjU154FQmKb3BrTAzhceOHtUGkM4whJH
         TS9dvtMRhULVi7xu5/E5dHfcj7qF/OR1XODIJSnVr/ZV8FVWi8Ahxbe8aAuSBXhDCkw/
         Nwsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xenh2Sb7watxNJKL24pMYing6QNd1CcZcrQqPV0Tmqc=;
        b=pCKplAfes342ibr7KzIAzLIP02TF1GAvvi3L66WPdyHA9hHXw8RhrQkdXI3dvdXhud
         wyVWoGf3yrsVkB3HS4aSca6u5hoEppZqVcQhMz7rdHOU+eDCWh7sz2GkKKXYN5x6rY6S
         aKnV6pQbC6OrzgezZrCj58RRrphn7IfSd4ogexbanHvdgBfKyNyd5xhdYf2VOlZ0yKyd
         YNSW9VAPr7hkNXZm6BIRdXYQUxRrKdc2rDmcdURZoRiX3tupV1BksLpst+HMM041bi5W
         7VlQxNMb7ZGBkgYzr4GT/JMSyn3cxjvSuNWSpuns1zUP+9eomKvkKyX0xtFjNrkhuyQy
         9rUA==
X-Gm-Message-State: APjAAAW3nVFsGyv5ivPin5gwCTCPNBQ6ZIvCTe5q66habcS8RJ2u3bUS
        4YCVDcLiJId1e058VlRSf65/7uDCs8KVdcJKhQjEMw==
X-Google-Smtp-Source: APXvYqyWeP93XV4oSanGCNVvzUTbLsEGnn0vejUafZA+l6yt+5W3qHMpIqtdSnnnzDUW6i7itjjql9xeMAeIzRuITjY=
X-Received: by 2002:a9d:634c:: with SMTP id y12mr4006764otk.12.1582071557097;
 Tue, 18 Feb 2020 16:19:17 -0800 (PST)
MIME-Version: 1.0
References: <20200218220748.54823-1-john.stultz@linaro.org> <CAHp75VcPL7DYp9hjgMu+d=CE=g+V7ZxT9ZyXX-OjEW_JQ4m_nA@mail.gmail.com>
In-Reply-To: <CAHp75VcPL7DYp9hjgMu+d=CE=g+V7ZxT9ZyXX-OjEW_JQ4m_nA@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 18 Feb 2020 16:19:05 -0800
Message-ID: <CALAqxLWtYfwCzDRVecWF8yRQSKQZh-N2g0SifageUaG0QhBGJg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] driver core: Rework logic in __driver_deferred_probe_check_state
 to allow EPROBE_DEFER to be returned for longer
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     lkml <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 4:06 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wednesday, February 19, 2020, John Stultz <john.stultz@linaro.org> wrote:
>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>> index b25bcab2a26b..9d916a7b56a6 100644
>> --- a/drivers/base/dd.c
>> +++ b/drivers/base/dd.c
>> @@ -237,13 +237,12 @@ __setup("deferred_probe_timeout=", deferred_probe_timeout_setup);
>>
>>  static int __driver_deferred_probe_check_state(struct device *dev)
>>  {
>> -       if (!initcalls_done)
>> -               return -EPROBE_DEFER;
>
>
> Why to touch this? Can't you simple add a new condition here 'if (deferred_probe_timeout > 0)'... ?

I think that might work. I'll give it a spin later tonight and double check it.

The main thing I wanted to do is fix the logic hole in the current
code where after initcalls_done=true but before deferred_probe_timeout
has expired we just fall through and return 0, which results in an
ENODEV being returned from the calling function.

thanks
-john
