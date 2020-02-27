Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602A7C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 09:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 351E724672
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 09:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fLazak1c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgB0Jjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 04:39:35 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35496 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbgB0Jjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 04:39:35 -0500
Received: by mail-wr1-f65.google.com with SMTP id r7so147622wro.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 01:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=TEQSjnIQxM1VtgQo9ixFuHUcsHPXNxUSWJy38z7yyCk=;
        b=fLazak1ceSbh9cl2KSW8RUZXXlnNgA7sMBzwXBpDHLH0ku1kK6pT4Mk0hocAJAd2W7
         tbQpHVo30+YP4Nq6OnPFVu60l8U1iHOj7fvUL/fZm83UrHWE7j/ViVqzzM5rDD21/GOj
         ttOyYnJg5xDnE/OLXU5O+b0q9gpDa22/11FhY7qMzDW1Jv/DS06NPOLy0nnEGTuBzZnU
         BTZoL5jmChUs1fNL/nrCgbFDGCoOPKw+H4RrLXNdvDG8EHVzlYfyJpDBA7Vnbas05s+2
         j1i12eaEY4b5cf55efbBdcoFmluOMrkvCVPEITtrQ36jwCK0kU3cZSrqJ3KJjQ7bWZmU
         sWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TEQSjnIQxM1VtgQo9ixFuHUcsHPXNxUSWJy38z7yyCk=;
        b=bGiJL/0zLKh+6gbtFRUAlroLM8Dp2H9tqLUxrsZiIdOTCYpbCPoGbq+ZT2wm7QPHDR
         XW4Lo0JHGz15USirnaVzVX8JUpqHJIOeIzXiSNtaRrng4tyoGDxN8Chj2MdvMRcq4/kT
         3vMZKHE9HBp1qVKroMd+vSiOEgtKlZ/4nu7CZLLaEbmSyXuMNr60naSoYLydTH451+RD
         UdUX/rrB8vyc6AVo/b2yBkXd+ahl2J7dwTPtQIov2kMljqnMeye5Zz+VamLBwA2eb9m9
         0J1pHfcbaPIBP0u4QJsKt6/VUDKaGcLcE7dGTnY2fkIvtLhDbWIotl3IlcXeoQQuPVOX
         pbfg==
X-Gm-Message-State: APjAAAVBbVfyY4cLd1JNXf3dV1wPoNVdxqv8fzRDYy0RtjEVLv/KUNPr
        EY3VBvGKFvd3H6jHANM20+9CAnomLC0=
X-Google-Smtp-Source: APXvYqwyo9YBUm97LulROFQKlNIsaZHsT++CMBKTQZorQHur+Ruk+7la2C7a4CNxjFmCXhbUllE01A==
X-Received: by 2002:adf:f588:: with SMTP id f8mr3949793wro.188.1582796373705;
        Thu, 27 Feb 2020 01:39:33 -0800 (PST)
Received: from dell ([2.31.163.122])
        by smtp.gmail.com with ESMTPSA id t133sm7065652wmf.31.2020.02.27.01.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 01:39:32 -0800 (PST)
Date:   Thu, 27 Feb 2020 09:40:06 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        b.galvani@gmail.com, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        phh@phh.me, stefan@agner.ch, letux-kernel@openphoenux.org,
        jic23@kernel.org
Subject: Re: [PATCH v5 1/2] mfd: rn5t618: add ADC subdevice for RC5T619
Message-ID: <20200227094006.GV3494@dell>
References: <20200223131638.12130-1-andreas@kemnade.info>
 <20200223131638.12130-2-andreas@kemnade.info>
 <20200226154055.GQ3494@dell>
 <20200226174914.047667d5@kemnade.info>
 <20200226174640.GR3494@dell>
 <20200226190028.0de5c095@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200226190028.0de5c095@kemnade.info>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2020, Andreas Kemnade wrote:

> On Wed, 26 Feb 2020 17:46:40 +0000
> Lee Jones <lee.jones@linaro.org> wrote:
> 
> > On Wed, 26 Feb 2020, Andreas Kemnade wrote:
> > 
> > > On Wed, 26 Feb 2020 15:40:55 +0000
> > > Lee Jones <lee.jones@linaro.org> wrote:
> > >   
> > > > On Sun, 23 Feb 2020, Andreas Kemnade wrote:
> > > >   
> > > > > This adds a subdevice for the ADC in the RC5T619
> > > > > 
> > > > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > > > ---
> > > > > depends on:
> > > > > https://lore.kernel.org/lkml/20191220122416.31881-1-andreas@kemnade.info/
> > > > > 
> > > > > Changes in v3:
> > > > > re-added it to the series because of
> > > > > "Oh, it looks like there was a conflict.  Could you collect any Acks
> > > > > (including mine) rebase and resend please?"    
> > > > 
> > > > Looks like there is still a conflict.  Sure, it's not a complicated
> > > > fix, but that's beside the point.  What tree is this set based on?
> > > >   
> > > It must be applied on top of my rc5t619 rtc series here:
> > > https://lore.kernel.org/lkml/20191220122416.31881-1-andreas@kemnade.info/
> > > 
> > > I expected it to make it into 5.6 and when I first sent the RTC series
> > >  (in October) I had no idea when I will continue with other stuff.
> > > 
> > > That is why I sent this ADC series separately, also to give the IIO
> > > maintainer plenty of time to review.   
> > 
> > If a patch-set can or should be applied on its own, you should send it
> > based on an upstream commit, or else things like this happen.
> > 
> It cannot without breaking bisectability. The RTC series adds IRQ support in
> the PMIC which is used here.

Then Kconfig should reflect that.

Or, if that's not possible, then you should not break-up and submit
sets which cannot be applied by themselves.  Either submit the whole
set together, or submit them piece by piece, not submitting the next
part until it's predecessor has been applied.

> > My advice would be to maintain topic branches, each based on an
> > upstream release, which you can merge together into an integration
> > branch for full coverage testing.
> > 
> > > Do you want me to resend all that pending stuff together in one series?
> > > I have little experience with this multi-subdevice process.  
> > 
> > It makes more sense to rebase this set onto the latest full release
> > and resubmit this set on its own.
> > 
> So, I resend the RC5T619 RTC series mentioned above as you answered
> upont Nikolaus question and wait with this series until review is
> through.
> Ok, so wait and rebase it onto 5.7-rc1 or 5.8-rc1 or whatever release
> the RTC stuff will appear.
> So you are not going to create an ib-mfd-rtc-iio branch.

As above.

If you go the whole-patch-set route, yes, either myself or someone
else would have to create an immutable pull-request, but you don't
have to concern yourself with that.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
