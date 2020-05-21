Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B94DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 06:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E210E20748
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 06:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590042180;
	bh=1cDoFhrO3JlVD3tvhSXZOVSF58OQKaORYpnpmjOhqAs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=GOndUOrgT8LorUlUpgoxj3qNNEMzppk/ofQ1GcCu6MonCOn4jzyxFb1nf8DSGJlFm
	 cioVhcJW7VrA1mMD+/5usBMx36gWiLwi3FLl+VTl/bQW2pm02HiRQSvI56Mcjz7LUG
	 QY1j+DwR1gOSw+H5jmAEpxfYlwO/7I1xaQBgK2oM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgEUGXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 02:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgEUGW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 02:22:59 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE7DC061A0E;
        Wed, 20 May 2020 23:22:58 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z18so6815699lji.12;
        Wed, 20 May 2020 23:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=1cDoFhrO3JlVD3tvhSXZOVSF58OQKaORYpnpmjOhqAs=;
        b=PDnu1Q7JRIO6G+SaTh5J1ef0cPUleRFWGKq+NULLVLnVdB2HfpfRQbRkB4AcBfA9W8
         jR0P0vfxJIFfYRIim8R0aFhSZtlSwn4wOpwc9xwRYXWa/MRje1MXg3wU0gyxasnnwT47
         ldrlQnckvUoAuPZyDM1s39GWahGyt99Uoq9h7R4LD4hzrHFkZzEiVaAXqd/OhmkIIfZU
         mEyd1xTzJrYj/tA+JK5UPcKm1+bh7NucrSuu7A3qwj69Xdv2eVWdVFzRyetw985RNcHr
         Uc387dqPmgyAvLtsGGseVef/jOTJcAnaxahq/tYfZTX/FlfKJUOoLsLRKiuCGpjLb0v5
         /zkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=1cDoFhrO3JlVD3tvhSXZOVSF58OQKaORYpnpmjOhqAs=;
        b=eCj1Pj7LUaaDGvYIZ49TmV7HmMWeKrO2HdMCtk9CoxwP71WSRNIbXhMzmcZu+RrRDn
         At68ssnNDItNd8NZMDOInEt2vphjKs9lVXYrkRaXAK5b0RiMatgac5PHGmlQLp2jLo6Q
         PInem0h0JMfF9HXMx5O3mcqAupGkzhib/iu7WgbCoDMTuodzRw5OpG9LbSlp/IyM2dKy
         TVzm9Rjf6amZk7gc2xaGOD8Z6AUWJZNDjVUXmA7Q3wIsSAGZHzELECgWSHlyMh4mXSSa
         XW8ZAHIPHg44HfruF0jmXvl+7ylV35hPAVc4O/L97T2tVil4Xxmz2Nj3vWURKybmK4aS
         PmZQ==
X-Gm-Message-State: AOAM532rQ2smeCqsPbr/IsYIw6LF1nFV1kZTiJhbkdsn9M4RAjyixD27
        rFK9Hl/MyfQm0G8Y+qtLF60=
X-Google-Smtp-Source: ABdhPJyMuPbOwO0ZBJt4B4trT6XYOxwNynenEnFe+gwIXnCnca6GrxDBZcsmtwNt+kFBVKcudUiaFw==
X-Received: by 2002:a2e:9850:: with SMTP id e16mr4096070ljj.163.1590042176833;
        Wed, 20 May 2020 23:22:56 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id e21sm376688ljj.86.2020.05.20.23.22.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 May 2020 23:22:56 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Jun Li <jun.li@nxp.com>,
        Jun Li <lijun.kernel@gmail.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Yu Chen <chenyu56@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jack Pham <jackp@codeaurora.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "open list\:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Peter Chen <peter.chen@nxp.com>
Subject: Re: [PATCH v4 3/9] usb: dwc3: Increase timeout for CmdAct cleared by device controller
In-Reply-To: <87v9kpx0zh.fsf@kernel.org>
References: <20191028215919.83697-1-john.stultz@linaro.org>
 <20191028215919.83697-4-john.stultz@linaro.org> <87mudjj4rc.fsf@gmail.com>
 <CALAqxLU+9uEcdRVaLfh+eQrDtZbDGod9pRXhBX=prAhg9MXagw@mail.gmail.com>
 <CAKgpwJVaKpsgMjKcnYyJsfNj0ibkPt=mdn-NxfOkeX1jfL=9iQ@mail.gmail.com>
 <87h7wqmwrv.fsf@kernel.org>
 <CAKgpwJXfWv5=MDqBCADhe2iXf6eiP0GQ13Bwo9fkuU5kGO7dsw@mail.gmail.com>
 <87imgx35pg.fsf@kernel.org>
 <VE1PR04MB65283F16826D2254128073C589BD0@VE1PR04MB6528.eurprd04.prod.outlook.com>
 <3d757998-56f2-6fff-a724-f713867ae785@synopsys.com>
 <87ftc0xsig.fsf@kernel.org>
 <VE1PR04MB6528AB046FD441A5DDD83CD289BA0@VE1PR04MB6528.eurprd04.prod.outlook.com>
 <87d074xfbq.fsf@kernel.org>
 <VE1PR04MB6528A50EA40BF40E4B09793789B90@VE1PR04MB6528.eurprd04.prod.outlook.com>
 <db7447c2-a39d-361f-8b35-a1d5c2705c89@synopsys.com>
 <e3b0ff51-70ab-7d16-2c7e-cacac7d97043@synopsys.com>
 <VE1PR04MB65286728B9546B5FAA818A0A89B90@VE1PR04MB6528.eurprd04.prod.outlook.com>
 <bbfbd3f7-4908-5529-1a4e-29469e794b27@synopsys.com>
 <1c16bdb6-8d8d-1e1b-f08b-b3963f905eb0@synopsys.com>
 <87v9kpx0zh.fsf@kernel.org>
Date:   Thu, 21 May 2020 09:22:51 +0300
Message-ID: <87r1vdx0w4.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi Jun,

Felipe Balbi <balbi@kernel.org> writes:
>> In any case, increasing the timeout should be fine with me. It maybe=20
>> difficult to determine the max timeout base on the slowest clock rate=20
>> and number of cycles. Different controller and controller versions=20
>> behave differently and may have different number of clock cycles to=20
>> complete a command.
>>
>> The RTL engineer recommended timeout to be at least 1ms (which maybe=20
>> more than the polling rate of this patch). I'm fine with either the rate=
=20
>> provided by this tested patch or higher.
>
> A whole ms waiting for a command to complete? Wow, that's a lot of time
> blocking the CPU. It looks like, perhaps, we should move to command
> completion interrupts. The difficulty here is that we issue commands
> from within the interrupt handler and, as such, can't
> wait_for_completion().
>
> Meanwhile, we will take the timeout increase I guess, otherwise NXP
> won't have a working setup.

patch 1 in this series doesn't apply to testing/next. Care to rebase and
resend?

Thank you

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl7GHjsACgkQzL64meEa
mQZinhAAudYIuvazPxapE687anJuiz/UEVAaqcfJK8dDh/BGT20JtTbI5J+1zwE7
OVwDBVXEdUNLOsd0Tc84OVeLNKhzbKGXdyter8tVautvcaSGQZm0nqO/ctFfs1N4
4kZf1LQd7HrA9Xju0Fzy3BIZcOJx39AD5cXFAkcHylfblO8On6OOm8q3zdMN3rPH
5Rgf3bPQSvt07Ex4uS8zPPEXC5H2EHyPDLMzMXmbDlKRzJcLtZcIMbeKGUuzBdNo
jobVMFblYbHf6f9gBjQtFfY1V64mnBT0ULDNmhWIKuXvRN7hfmCKmAZiDdDmzEqG
tVZ9qEwIWIgTF5mWuWvrZ2mqtzBRwSCScjxZwK6GmnktrDxGgi3TPom6e8TNZ0Ee
mV+UedcuqcFvpQeL58Ru478tl7Hmtw7Io7xMR0nNssXNLyIKKwSOKtbCHmHMC3NM
kHlK8dLAEnAPJ5AYOqIHvXACEI3vKestgQeWvci2slwWuBcNZFuweS4ASC/fkRzD
+QDE0t0L4AFY9bq1ML4QulL+3/0ogJkORLy1wnHb/QD++DfYDHhayFZ2Q6K9BF9X
axL5Gqw3tIjW5muwErsMTsLruNaA91/L6hPugtypeBqFigozZGtRJYTyuCGFlazM
zKtIsU7/wFUCfxhCQ9IcgXlfHk/240h22Gg5X2X+1/nX64WQzTI=
=y08r
-----END PGP SIGNATURE-----
--=-=-=--
