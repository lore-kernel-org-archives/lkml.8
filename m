Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1024DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB9B92173E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YvH/uR8J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbgHETpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729075AbgHETpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 15:45:06 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48146C061756
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 12:37:27 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id k18so34565825qtm.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 12:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JXg1rw7TER/dCS/fPia5Ipaa/xp5S6D1puoEf6L0It8=;
        b=YvH/uR8JUCjfa4yM05TlsoHznQuDvY432VhGlVI/pHdGA1BNxkCdTFQLKNPQk7DB9o
         W4exEUyJxqcw7cA1t+hPZwLSyc3Za2zW1De+bmu7LZaqLd+wZaAHQ/k3x94ZJc74RpV4
         mjaAWtz6Mv47ROUZZfcRldBd6j8emltAm+zoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JXg1rw7TER/dCS/fPia5Ipaa/xp5S6D1puoEf6L0It8=;
        b=CQJb+Wz4Jg+iCr9N8k3Lijs2lq8ij5G9NAIbDvOAmRBsX6/IB1PzToFvMKzrHmWjnC
         dKP51Yb7DmSLVyxxA0Z2+x1TmlmwchlVe1U3uPJ2vcc9zNGJRWW1T9AuHIk4XEjloatc
         nNtL0X7jGToBkOIkId//i6wa5k5QVJ1aZzX7+pYunp4H0aXfzx0LStYssS3zb+8+bzcW
         5rz6lbo9srLKt/La4alU3VXxnNiRpK/tgEF6LgUmUtHzCZutSr1/9BvARDJiUU/9pweo
         xnT/9wC6cy6EKdCkdnBVXHnINDF2n8uCKSXAJ5CjEBw1A8usJAbhXjPS84KP/065sK98
         iZIA==
X-Gm-Message-State: AOAM532cI99jZUFPEmgn4vnFcTJltYXp3tz9gUWiD4uv4dSuKRw6S6zW
        hoJF+eiaWpVwEto0X/EMOulTp7HDB2hGGXgHcLSOmw==
X-Google-Smtp-Source: ABdhPJyxeAblojwA1B4vmv63kp9dzBHhpG6HUxAusjiQvQWtvPGblPWZubEL4RHuGFZ+ts1mbQra85M7Anit8/9MEMQ=
X-Received: by 2002:ac8:777a:: with SMTP id h26mr4947670qtu.141.1596656246037;
 Wed, 05 Aug 2020 12:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200730225609.7395-1-azhar.shaikh@intel.com> <20200730225609.7395-3-azhar.shaikh@intel.com>
 <20200730230238.GD3145664@google.com> <MWHPR11MB1518178C5B2335FC02CD36AE91710@MWHPR11MB1518.namprd11.prod.outlook.com>
 <20200730232504.GG3145664@google.com> <MWHPR11MB151867DF25664C80E99A326D914B0@MWHPR11MB1518.namprd11.prod.outlook.com>
In-Reply-To: <MWHPR11MB151867DF25664C80E99A326D914B0@MWHPR11MB1518.namprd11.prod.outlook.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Wed, 5 Aug 2020 12:37:14 -0700
Message-ID: <CACeCKaf6WuW6XbFBQoVEW55w=OHfaVmmDn1xepiYYeRyMzZFrA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] platform/chrome: cros_ec_typec: Avoid setting usb
 role during disconnect
To:     "Shaikh, Azhar" <azhar.shaikh@intel.com>
Cc:     "bleung@chromium.org" <bleung@chromium.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "groeck@chromium.org" <groeck@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>,
        "Bowman, Casey G" <casey.g.bowman@intel.com>,
        "Mani, Rajmohan" <rajmohan.mani@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Azhar,


On Wed, Aug 5, 2020 at 12:22 PM Shaikh, Azhar <azhar.shaikh@intel.com> wrote:
>
> Hi Prashant,
>
> > Is this documented anywhere? Kindly provide the links to that if so. I wasn't
> > aware of any ordering requirements (but I may be missing something).
>
> The configuration of the connector should always happen in the order defined in the
> USB Type-C specification. Check ch. 2.3 (USB Type-C Spec R2.0). So that will basically give you:
>
> 1. orientation
> 2. role(s)
> 3. the rest.

Thanks for the link. Are you referring to Section 2.3 (Configuration
Process) ? I couldn't find anything there which
implied any required ordering (I'm reading Release 2.0, Aug 2019, so I
don't know if something has been added since).
Could you kindly point me to the appropriate subsection?

Additionally, I think any ordering requirements there are already
handled by the TCPM in the Chrome OS EC.

>
> Also I see in USB Type-C Port Manager driver the above mentioned sequence being followed
> https://elixir.bootlin.com/linux/latest/source/drivers/usb/typec/tcpm/tcpm.c#L664

In addition to the above, note that this is a TCPM implementation (on
Chrome OS the TCPM implementation is in the EC), so what is
done there doesn't necessarily apply to cros-ec-typec.

Best regards,

-Prashant

>
>
> > > > -Prashant
>
> Regards,
> Azhar
