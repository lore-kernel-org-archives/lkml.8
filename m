Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4FEC2BA12
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 23:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C99E206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 23:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wSRw9XzR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390323AbgDBXyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 19:54:15 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37832 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390267AbgDBXyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 19:54:15 -0400
Received: by mail-oi1-f195.google.com with SMTP id u20so4555315oic.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 16:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MkVjVANpcM96YTP/artLgGpoBzA7LQYeml3uEpxUsEQ=;
        b=wSRw9XzRiBybQLd7br9k7afPC7Rj5x3o8UDf1DIiDxl26R2ISpzh28VA/aCw6AgQ3r
         xuvnlxkR+knRDPbx3sXs2gVcudJLcu2lc1Tz4ewwZrR65itu6LgqK1YV+JQyJpR3WUXg
         A/Mcg+H/AvqA+PHrZpQwWa1DkfSVVxvyQ/DN98Gv55vtWRBVia8xI7uYHHTD8QI2FpvG
         zkB/KLVn6ElyebU/hCoWiC0P6lHPaxF5iRs4uOAjVk/lpGD1uuj3RRRSejuE9zrwoHtc
         9DGavumf8OKF7RWI9+k656CDmhalsGx8Q64HSmbnNgL7fGfrFFrxaXm1FwUE8NiUz/DW
         QKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MkVjVANpcM96YTP/artLgGpoBzA7LQYeml3uEpxUsEQ=;
        b=UeuUYm20TWCmePnf2lvqtDPOR591QfC4gAeDESziQkKjOZQeRJDSxLZvfvqT8uHYJk
         HiM0dEcMCraZ5ui52uQPFCjw2I+O/YsfX1QdsaujqupwWcIokmzMMKNnZibXpeeO75uV
         4RY6CnD2AVH523CxuRRLBgRpKWr9txEuyLju6n/5FOPVY08BqbPSXpqCWRXMRzrtd0d1
         zzVUuMcRNWIAPYjnua8Rt+H85IobzlKxX3uIUWhIHnEvc43q7iGGKotBYaHdh8qlvoOk
         mCbBfDujQRWO6N1e4kE954vDVMLqnYc1plFVNgfQpO1tH5qsjbnojtPmt+xP42j1XHqH
         Z7Dg==
X-Gm-Message-State: AGi0PuZMtz7IWEnHsF1eJLW8b8BMXI0V6OcwGMQR2eKihhsM9/layIRt
        LdIX1xTI7+U9GZcfvk+hhvAH5KKWTmy8RCpm6CUakQ==
X-Google-Smtp-Source: APiQypJ1ZSdBUd3//b0o+rdxCAtF34zyk2+np7OTHfHudJN4riuwjNAt1eydJ7G7VnJwzPwsibZMWSQvVjikVhy04CY=
X-Received: by 2002:aca:5208:: with SMTP id g8mr1073389oib.169.1585871654146;
 Thu, 02 Apr 2020 16:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <CANcMJZCr646jav3h14K0xV=ANMxXg=U20wvSB546qrLX3TECBg@mail.gmail.com>
 <20200402223723.7150-1-john.stultz@linaro.org> <CAD=FV=VGT75c4_ErQAJgNtcCd2Jzv0A2KpfEkS637GqOhamj9Q@mail.gmail.com>
 <CALAqxLXfd+7Wc79_XWRv8cKLFu+MpM1w9e3byx9z5bXSdTemLg@mail.gmail.com> <CAD=FV=WLAgowK67U1GkF3h_CZU_nyFfDPpZ=bF8BXU1jd_uTZg@mail.gmail.com>
In-Reply-To: <CAD=FV=WLAgowK67U1GkF3h_CZU_nyFfDPpZ=bF8BXU1jd_uTZg@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 2 Apr 2020 16:54:02 -0700
Message-ID: <CALAqxLVt9nZDWVTi=yHRnbT26PGCKANsqfhr9=3qnkOCOCFDhQ@mail.gmail.com>
Subject: Re: [PATCH] phy: qcom-qusb2: Re add "qcom,sdm845-qusb2-phy" compat string
To:     Doug Anderson <dianders@chromium.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 2, 2020 at 4:19 PM Doug Anderson <dianders@chromium.org> wrote:
> On Thu, Apr 2, 2020 at 4:08 PM John Stultz <john.stultz@linaro.org> wrote:
> > My understanding with dts bindings is that they are effectively an
> > ABI. While maybe it makes sense to deprecate the
> > "qcom,sdm845-qusb2-phy" string in the Documentation to avoid new
> > users, I'd think we'd want to keep the support in the driver as we
> > aren't supposed to have tight coupling between the DTB and kernel (at
> > least for official bindings).
>
> If nothing else if we're going to land your patch, can you at least
> put a comment in there that says "only needed to support legacy device
> trees that didn't include "qcom,qusb2-v2-phy" in the compatible
> string.  Then the person who adds the next Qualcomm SoC will know not
> to add themselves to the table too.

Done.


> > Granted, I've not gotten much experience with boards that were fully
> > upstream and thus didn't have an eternally evolving dts file that had
> > to be kept in sync with the kernel, so in practice either solution
> > does work for me, but in theory it seems like we should at least
> > pretend these things are stable. :)
>
> Yeah, I don't want to get into the whole stable ABI argument, but what
> you say is the official word.  The bindings are supposed to be a
> stable ABI and it's a good goal to strive for.
>
> ...but in reality most people are OK with it not being quite so stable
> as long as it's not hurting anyone.  What should have happened here is
> that the bindings and dts should have landed in one Linux version and
> the driver change landed in the next Linux version.  Now we're stuck
> with the breakage, though.  :(  In general for "new" architectures
> it's considered more OK to break compatibility, though I guess you can
> argue whether sdm845 is really new enough.  I guess to get at the meat
> of the issue though: if you need a patch to fix your problem anyway,
> why not land the patch that doesn't end up chewing extra up extra code
> space and providing a bad example for someone to copy?
>
> Now certainly if changing your DTS was an undue burden (like you've
> already baked device trees into firmware) there's no question we
> should land your patch.  I'm just not sure the lofty goal of "it's
> supposed to be a stable ABI so let's add an entry to the table that
> nobody will ever care about after the dts change lands" is enough of a
> reason to land it now.

Personally, I'm fine with either solution (as there's still dts
changes for db845c pending that we're carrying), but I also want to
make sure we're setting a good standard for future changes (as these
sorts of things seem to bite me far too frequently on the db845c,
sometimes even resulting in forced userland changes that we've so far
been able to adapt to, but are not ideal).

So I've resubmitted my version to let the maintainers decide.  :)

thanks
-john
