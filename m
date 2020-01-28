Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C87C33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 21:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 519C22173E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 21:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/IG7Ozi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgA1VbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 16:31:11 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:46659 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgA1VbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 16:31:11 -0500
Received: by mail-yb1-f195.google.com with SMTP id p129so7586908ybc.13;
        Tue, 28 Jan 2020 13:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZbfQbGyFzdG711MVxj7R2AJtJXuX0PPglzrUb6oV19I=;
        b=C/IG7OziNokQ9t+0JhxwzqhpHNTYR5Ezg+yW+UrRwAA+xIgNEGQ+9ulFveeUEH7NuS
         cJDKlgOrI5WZEwjBY4j24WLkXU+H9lxhMSnzVs5j1HlGifGAY1xp82/hu9aYaZoeh6Qv
         SMNMfxLSMZWTroNWkYYOOdPFoTo92+wQSkQY0NKWfbDem4lv2G7D21tE2h6vZ0moYfgv
         5yFOGmnUHCHet4S5F/gPmPmQv8cFQ9ACh++9GQlH9uOEb0Shq5RTj9YQhti4qIyFZ66S
         svG5wEPa0VVJvVs6iiXK0xuHJahrax0wx1vlun16Sc5M5Fp8qIMw5e8/X+uDlZdvA1JJ
         6LFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZbfQbGyFzdG711MVxj7R2AJtJXuX0PPglzrUb6oV19I=;
        b=b0NEjaklmcqVCwDb4UKkEzLs8Jq4pzRmiUGS6SZUeUT7q95uFgo/MD0z66ZnnXfeM/
         +mDSsWisO+gwOkuUVOCM2WQhaChL6o1orK27H8+yRMfnDihdaThZ0510plptC59CA96I
         1GmGvSi56N6tiM2/whWhGd0SxJCON+m+cSyagV6HoNTyjcNDarEiJIQ3pVLhuVLaRMPE
         IxU4ikNoRWJaU3ZFSMvmU5lc6obRCRLMr4i0d/wE+zi4wQctuiPsIitmn96WsXYgQMsK
         t2O04PpfyOc5NRCLApvamNkNbLK7Dh4nbjXVSfIaSyQq8yzrdAiIcSij6oKuF29NGpgj
         bgqw==
X-Gm-Message-State: APjAAAUijNFv9W0lliKDGYf1kVG4x6pH+YY51WoBHkPoW919hXRuLLyC
        FO4jbiUjpWGNZY7FxA2xcfE=
X-Google-Smtp-Source: APXvYqwD+YT7exIeTLN+trU1isViIR/quViPycAIGYkkvNoJXnZp5uGDsPDTyEj7KQ84c3qIXaFEJg==
X-Received: by 2002:a25:c514:: with SMTP id v20mr19060385ybe.293.1580247068939;
        Tue, 28 Jan 2020 13:31:08 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g195sm11557ywe.99.2020.01.28.13.31.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Jan 2020 13:31:07 -0800 (PST)
Date:   Tue, 28 Jan 2020 13:31:06 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Jones, Michael-A1" <Michael-A1.Jones@analog.com>
Cc:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: Re: [PATCH 2/3] hwmon: (pmbus/ltc2978): Fix PMBus polling of
 MFR_COMMON definitions.
Message-ID: <20200128213106.GA30571@roeck-us.net>
References: <1580234400-2829-1-git-send-email-michael-a1.jones@analog.com>
 <1580234400-2829-2-git-send-email-michael-a1.jones@analog.com>
 <20200128191306.GA32672@roeck-us.net>
 <SN6PR03MB40329A1D480256447C4565CDF60A0@SN6PR03MB4032.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR03MB40329A1D480256447C4565CDF60A0@SN6PR03MB4032.namprd03.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 09:16:39PM +0000, Jones, Michael-A1 wrote:
> Guenter,
> 
> The decision to not poll PEND was based on some other non-driver code based on /dev/i2c that looked like this:
> 
> // Set to 0 for LTC3883 which does not support PEND
> #define USE_PEND        1
> 
> #define NOT_BUSY        1 << 6
> #define NOT_TRANS       1 << 4
> #if (USE_PEND)
> #define NOT_PENDING     1 << 5
> #else
> #define NOT_PENDING     0
> #endif
> 
> My recollection is that came from the datasheet, many years ago.
> 
> I talked to the designer, and if the above is correct, it has not been correct since 2012. The designer was not interested in researching artifacts that far back in history. So we know it has been in the part for at least 8 years.
> 
> There seems to be two choices:
> 
> A) Leave it as is
> B) Poll the PEND bit and possibly break compatibility on ancient hardware
> 
> Generally, unused status bits in this kind are high when reserved or not used. That is good for polling.
> 
> The shipping volume of LTC3888 has always been very low compared to other parts, so exposure is very small, certainly Cisco/Juniper type companies would not be effected.
> 
I assume you mean LTC3883, not LTC3888.

> I would feel ok with polling PEND on this part. Let me know your opinion.
> 
> On a related matter, bit 4 is asserted low when the output is changing value. Hwmon cannot cause this because it only performs telemetry.
> 
> A user application could change VOUT and cause this to happen. Telemetry would reflect the last measured value from a 100ms internal polling loop, which may be a before, after, or during value. I have always judged that checking this bit has no value, and it can be problematic. If the part is set to have a very long transition rate, like 5 seconds, this would hang the call for a long time. That seemed bad to me, and is why I did not poll this bit.
> 

Your call, really. My major concern was that bit 5 is no longer polled
on LTC3883. From the above, it looks like it actually _is_ the pending
bit (5) that isn't supported on LTC3883. With that in mind, I'll apply
the series as-is and add the Fixes: tag myself; no need to resend.

Thanks,
Guenter

> Mike
> 
> -----Original Message-----
> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> Sent: Tuesday, January 28, 2020 12:13 PM
> To: Jones, Michael-A1 <Michael-A1.Jones@analog.com>
> Cc: linux-hwmon@vger.kernel.org; devicetree@vger.kernel.org; linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org; jdelvare@suse.com; robh+dt@kernel.org; corbet@lwn.net
> Subject: Re: [PATCH 2/3] hwmon: (pmbus/ltc2978): Fix PMBus polling of MFR_COMMON definitions.
> 
> [External]
> 
> On Tue, Jan 28, 2020 at 10:59:59AM -0700, Mike Jones wrote:
> > Change 21537dc driver PMBus polling of MFR_COMMON from bits 5/4 to 
> > bits 6/5. This fixs a LTC297X family bug where polling always returns 
> > not busy even when the part is busy. This fixes a LTC388X and LTM467X 
> > bug where polling used PEND and NOT_IN_TRANS, and BUSY was not polled, 
> > which can lead to NACKing of commands. LTC388X and LTM467X modules now 
> > poll BUSY and PEND, increasing reliability by eliminating NACKing of 
> > commands.
> > 
> > Signed-off-by: Mike Jones <michael-a1.jones@analog.com>
> 
> Fixes: e04d1ce9bbb49 ("hwmon: (ltc2978) Add polling for chips requiring it")
> 
> > ---
> >  drivers/hwmon/pmbus/ltc2978.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/hwmon/pmbus/ltc2978.c 
> > b/drivers/hwmon/pmbus/ltc2978.c index f01f488..a91ed01 100644
> > --- a/drivers/hwmon/pmbus/ltc2978.c
> > +++ b/drivers/hwmon/pmbus/ltc2978.c
> > @@ -82,8 +82,8 @@ enum chips { ltc2974, ltc2975, ltc2977, ltc2978, 
> > ltc2980, ltc3880, ltc3882,
> >  
> >  #define LTC_POLL_TIMEOUT		100	/* in milli-seconds */
> >  
> > -#define LTC_NOT_BUSY			BIT(5)
> > -#define LTC_NOT_PENDING			BIT(4)
> > +#define LTC_NOT_BUSY			BIT(6)
> > +#define LTC_NOT_PENDING			BIT(5)
> >  
> 
> In ltc_wait_ready(), we have:
> 
> 	/*
>          * LTC3883 does not support LTC_NOT_PENDING, even though
>          * the datasheet claims that it does.
>          */
>         mask = LTC_NOT_BUSY;
>         if (data->id != ltc3883)
>                 mask |= LTC_NOT_PENDING;
> 
> The semantics of this code is now different: It means that on
> LTC3883 only bit 6 is checked; previously, it was bit 5. I agree that the above change makes sense, but it doesn't seem correct to drop the check for bit 5 on LTC3883. Maybe remove the if() above and always check for bit 5 and 6 ? Or should bit 4 be checked on parts other than LTC3883 ?
> 
> #define LTC_NOT_TRANSITIONING		BIT(4)
> ...
>         mask = LTC_NOT_BUSY | LTC_NOT_PENDING;
>         if (data->id != ltc3883)
>                 mask |= LTC_NOT_TRANSITIONING;
> 
> Thanks,
> Guenter
