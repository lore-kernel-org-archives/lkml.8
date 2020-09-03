Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AB9C43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 09:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB43C20709
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 09:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q6FaqYyv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgICJJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 05:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbgICJJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 05:09:52 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B829C061245
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 02:09:52 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id i22so2800763eja.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 02:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V5vCv00NRZR85r0QBP/ebzcR3D26FJaIP5JeqX6Z45w=;
        b=q6FaqYyvNpaYaPdvXdtEotUaS1VDpvmI9FUuDa++/JqgoNp1iqlm+uwazzN888e02K
         rIttpXGgK0+CmDSCjH6YHJKi1BADt3uKh0GyKX499XfoMl19nXtQW2hM/q/3e3oKxDWL
         enFHwEYcU//+5Q0AuHmqjtP6t+VolU6i5SqhgUT4UY4PlqgUqk8Pw9n+mK4Otkqv1k2x
         8IsCGytd5FzqHSLGW/0xNa+AQG/frU0Rh9k5Fur0E+NBv5lzdfhFUAkOT3lZ4Vf4sEWD
         3tVCORw9+4j89T204sQbBa4H/IpGtlTyYpWwIPNhYTMNWfpmrrUbXP4GWWLM8Txpd9gI
         QQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V5vCv00NRZR85r0QBP/ebzcR3D26FJaIP5JeqX6Z45w=;
        b=Sx0eqzGM8RDz0vUyzWNYUWBuE/1IToH4XFBODbnG4YEmFX79kYurJ/FeFEKkNFfv2U
         aB7bfHRNBBUbqYbuL8/D+PYFbLixco3oSRu8bFGbTT6jlu8e6tEIGnhf+ivGg4fOaNWM
         /9w4Pg42Le7TRttyqzCIes50gQx2b1OUooOlRvmTiiCHWgPAi31U028F7r2LBJGxL3fR
         Jq/98fg5wZjG7+HdFWInn/pf7p6wSpwYQKkQ7wnt4NuJqo4CJ0nXlHFzH85R9qUoEZ1s
         9VoE9mzWJnafOtl7mTk/MXIzbp8JYUk0MDxGtZjwF1WYcjHth37YQj/X1fMX/ZEFZ7vX
         saHw==
X-Gm-Message-State: AOAM5303CrD3Rji//UWjHTB+C8l3d2lI/vihjkDRU10THttvcdhDRGFz
        bTL7vuF4QDDhJdT3dAWWA8UmW0QWYsiTTMheNwfVLA==
X-Google-Smtp-Source: ABdhPJwmWVdelUfdmR7S1WkN3U4XFezpkaZdSbAZBDCpG8rThOwqIusj4KHSxfOpOJbnd1PZO7bPZC4uKxxZfjn3OGU=
X-Received: by 2002:a17:906:49c9:: with SMTP id w9mr1142036ejv.520.1599124190692;
 Thu, 03 Sep 2020 02:09:50 -0700 (PDT)
MIME-Version: 1.0
References: <0efc2605c8c06b4b1bf68cbad5536c4a900dc019.1599110284.git.jie.deng@intel.com>
 <f3ab5d7d-cce5-b34c-5931-dd5d74f065e7@redhat.com> <6517879c-15d4-6265-761c-626cba9c95d6@intel.com>
In-Reply-To: <6517879c-15d4-6265-761c-626cba9c95d6@intel.com>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Thu, 3 Sep 2020 11:14:38 +0200
Message-ID: <CAMZdPi-s_FZ6ycuM7uh6uE_aV41x0nVtKzqp1h49VdmT5me6jw@mail.gmail.com>
Subject: Re: [PATCH] i2c: virtio: add a virtio i2c frontend driver
To:     Jie Deng <jie.deng@intel.com>
Cc:     Jason Wang <jasowang@redhat.com>, linux-i2c@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        open list <linux-kernel@vger.kernel.org>, mst@redhat.com,
        wsa+renesas@sang-engineering.com, wsa@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        jarkko.nikula@linux.intel.com, jdelvare@suse.de,
        Sergey.Semin@baikalelectronics.ru, krzk@kernel.org,
        rppt@kernel.org, tali.perry1@gmail.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        shuo.a.liu@intel.com, conghui.chen@intel.com, yu1.wang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Sep 2020 at 09:19, Jie Deng <jie.deng@intel.com> wrote:
>
>
> On 2020/9/3 14:12, Jason Wang wrote:
> >
> > On 2020/9/3 =E4=B8=8B=E5=8D=881:34, Jie Deng wrote:
> >> Add an I2C bus driver for virtio para-virtualization.
> >>
> >> The controller can be emulated by the backend driver in
> >> any device model software by following the virtio protocol.
> >>
> >> This driver communicates with the backend driver through a
> >> virtio I2C message structure which includes following parts:
> >>
> >> - Header: i2c_msg addr, flags, len.
> >> - Data buffer: the pointer to the i2c msg data.
> >> - Status: the processing result from the backend.
> >>
> >> People may implement different backend drivers to emulate
> >> different controllers according to their needs. A backend
> >> example can be found in the device model of the open source
> >> project ACRN. For more information, please refer to
> >> https://projectacrn.org.
> >
> >
> > May I know the reason why don't you use i2c or virtio directly?
> >
> We don't want to add virtio drivers for every I2C devices in the guests.
> This bus driver is designed to provide a way to flexibly expose the
> physical
> I2C slave devices to the guest without adding or changing the drivers of
> the
> I2C slave devices in the guest OS.

So AFAIU, what you're trying to do here is "I2C slave passthrough over
para-virtualized I2C bus"? While not totally crazy, that looks a bit weird =
since
a straightforward way would be to directly assign the I2C bus controller as=
 a
passthrough device (vfio?), though I assume your goal is also having per sl=
ave
VM assignment control (and not exposing the whole bus)...

>
>
> >
> >>
> >> The virtio device ID 34 is used for this I2C adpter since IDs
> >> before 34 have been reserved by other virtio devices.
> >
> >
> > Is there a link to the spec patch?
> >
> > Thanks
> >
> I haven't submitted the patch to reserve the ID in spec yet.
> I write the ID here because I want to see your opinions first.
>
> Thanks
>
>

Regards,
Loic
