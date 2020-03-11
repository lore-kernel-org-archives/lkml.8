Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF13C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3AE720737
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Id8s4oOS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387441AbgCKTyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 15:54:39 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45147 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387414AbgCKTyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 15:54:39 -0400
Received: by mail-ot1-f65.google.com with SMTP id f21so3411999otp.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 12:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9G8BKi87dM8ac+1i8fsYu7iUa+IfFufMeRSjgfr6A2E=;
        b=Id8s4oOSWs5Xu5M/KFQRUlf7eQY409+ZLkiK/Jdgljhl8fu/YQkLXw/5EBFEyPHMGa
         pqwkBkWddzxS7iDwDGW5rPcYnvi7d+33rZc5hGSKDYNUHMIR8dSdwMi3a6oh+rlYEeJc
         Fo4W6E6CZeivx037vSOmQVyWguZzfiX9cSix3q4xutmoBDRyf4AH7j1Zq75o1KhYFNbX
         hZW3G3CaVznikgDMo1k6me6w7bK91Hy4zU016PvxRURtTDiCg9HpslVFjZb2Rv7BQYhl
         SOuEUjZaOwxCRnLlfcb4Of13gquA7HwqNJdGgIGsVYscr/Pv6j3k6Xv3JrP3AQ2G3vlp
         c8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9G8BKi87dM8ac+1i8fsYu7iUa+IfFufMeRSjgfr6A2E=;
        b=kqy7SNyWdCTDSInMHafS9pJjvchA6whlKGKsaH/SvjbIHVhwhFy3lBf4AYItSGfrED
         Y+GtB/vjE4Qgz06LH4yK7IuKWY5PqQkyNJsVbZW6dtVtQWBWUzXDk9AhFUst3Z9dSd1+
         9zRC8sg6j2CzTa2QhLhRJpEyYUxApx3aPw41fGG6n9ajyGoe1RuwZGbvtMcxUYRFh6kh
         IQ7PsqfRWHU8I4QT2lCXdqHkYgYHjxpW3/zOz4GlQ9UhkZ5q0Iqh4rVs65UXmTxwQWO8
         GSJGWqMEt/tjaS7i81UmxNM+DLXhhTQxpxMOH7rFIo98hClMsoNCWCILn/Mjp6cu3T/k
         6Lrg==
X-Gm-Message-State: ANhLgQ1atpj2bNc9I6Th+u/kNpkRDhbnFKstAETFLY59zuA2qj1vWzQw
        oWiZzxWcbuuchR5ZgxK5Lr378DzTECGmOyyzCuz22A==
X-Google-Smtp-Source: ADFU+vujO1GuU0FxzgptyGmNumunhFLdj+J5zktXsJFnyVaoSjBzIH+jerB5Vt1h+nF6X7xTtUh1JTzBtNN8NNpemso=
X-Received: by 2002:a9d:344:: with SMTP id 62mr3839951otv.102.1583956477185;
 Wed, 11 Mar 2020 12:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200311172109.45134-1-john.stultz@linaro.org>
 <20200311172109.45134-2-john.stultz@linaro.org> <7337bea7-1449-e6e3-4c65-1bb802a2c316@linaro.org>
 <CALAqxLXEZQnH3a8z9CGf52VUbb-ZHX-R78DPM1psJhV9_bs35g@mail.gmail.com>
In-Reply-To: <CALAqxLXEZQnH3a8z9CGf52VUbb-ZHX-R78DPM1psJhV9_bs35g@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 11 Mar 2020 12:54:26 -0700
Message-ID: <CALAqxLU0HWYsZcOjBj3XRy6+D33aPuQ=+hF=gv0prUquyb1+pg@mail.gmail.com>
Subject: Re: [RESEND][PATCH v8 1/6] usb: dwc3: Registering a role switch in
 the DRD code.
To:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Yu Chen <chenyu56@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Guillaume Gardet <Guillaume.Gardet@arm.com>,
        Jack Pham <jackp@codeaurora.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 12:44 PM John Stultz <john.stultz@linaro.org> wrote:
>
> On Wed, Mar 11, 2020 at 12:17 PM Bryan O'Donoghue
> <bryan.odonoghue@linaro.org> wrote:
> >
> > > +static int dwc3_usb_role_switch_set(struct device *dev, enum usb_role role)
> >
> > @bjorn found an API change that explodes this one.
> >
> > Fixed here: https://lkml.org/lkml/2020/3/11/1034
>
> Huh. I wonder why I don't see that causing trouble in my testing.  :/
>
> Oddly, trying to use your patch results in build failures for me... Is
> the api change something in -next?

Ah. Ok, I found it: "usb: roles: Provide the switch drivers handle to
the switch in the API"

I'll add that to my patch series, retest and resubmit. Thanks for the heads up!
-john
