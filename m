Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DB5C83000
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 00:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B981D20731
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 00:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UG5LtxTD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgD3AiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 20:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726279AbgD3AiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 20:38:14 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5A1C035494
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 17:38:14 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id v192so1249459vkd.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 17:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ue/rz4Fn+04hr+n+K+kjQp326QaO0CAjZ9NJZaZx2cM=;
        b=UG5LtxTD2tA4eaZff5YUWopXsU5j3/4yLdHOhbh8CkdQ6Reesn4zDCGdJL5BwPc5vS
         omwCMU384Jgg7XnfXoBRLqeofDGUVwVJwdIMRrAQgJpoJ1jweKli79KF6f27onMgz+Yg
         eyIQmYI9+I/GFGLbiJnJI+HUaiCF8SP/aF3S8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ue/rz4Fn+04hr+n+K+kjQp326QaO0CAjZ9NJZaZx2cM=;
        b=mloAlCQdb/XAOooR3TdLASb4rd6oqKPSEPJ/1s3UbvQRaVjA3KgzdnU5bdl8KkWWlP
         vFyX0bnNBPqWR21PQSdoXaBhhLch/giPa7g/pvhZv+eHpe7SZq9LNqWNxXkUo31v6RvL
         Q1kJqWnM+FybBHn7FUcr9URf7sTYebF2ZTY5+WIjpDwB1r0dL5VbXq1DDoyrweOdLG6h
         U3bRtqwxtHbIDk3IM0aK4VQ21IcMBqn8X+K+cHY76L2JnTlbP+eGJKebUkDhwhwUyD5/
         A0EwkILkK8VWCP75Gfg+j5m041OttgJLBKNs1d7V8konojEfo00QtAawzEXVHa5GCQU7
         c6fg==
X-Gm-Message-State: AGi0PuY+0ghWfcZl9cexFEel6beJ9P4yjTxtDdkd+fO1U9IZDFcmmSOW
        1ijFXwEBSR56DcZG5BJpdyzQ5X3ATvcrg4kr59J3TQ==
X-Google-Smtp-Source: APiQypJXmOqw5s0QzOld2YZjGvp8sje8rIw7BJQKF+Wj89Od8Uxn2IC/RFlWm/0x9jPrveYxHiBIG1O1xKYdg7WZQDY=
X-Received: by 2002:a1f:5ec7:: with SMTP id s190mr695642vkb.58.1588207093257;
 Wed, 29 Apr 2020 17:38:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200428110253.1.I926f6741079cafb04ecb592130aef75b24ad31ae@changeid>
 <c57b0892-d68d-f0f2-3cc1-b8549983227e@collabora.com> <CAONX=-dLVBpz+p1si4cWGHEmQ_toO8kW=fCPcdUuX2KLc-o=2A@mail.gmail.com>
In-Reply-To: <CAONX=-dLVBpz+p1si4cWGHEmQ_toO8kW=fCPcdUuX2KLc-o=2A@mail.gmail.com>
From:   Daniil Lunev <dlunev@chromium.org>
Date:   Thu, 30 Apr 2020 10:38:02 +1000
Message-ID: <CAONX=-dDWjMQDGncSgXNf86Bt3C5OUtFqh=Pe2HToGPSv5qa4A@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Handle NULL EC pointer
 during probe.
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[to make it appear on the mailing list as I didn't realize I was in
hypertext sending mode]

On Thu, Apr 30, 2020 at 10:11 AM Daniil Lunev <dlunev@chromium.org> wrote:
>
> Hi Enric.
> I encountered the issue on a Hatch device when trying running 5.4 kernel =
on that. After talking to Prashant it seems that any device with coreboot b=
uilt before a certain point (a particular fix for device hierarchy in ACPI =
tables of Chrome devices which happened in mid-April) will not be able to c=
orrectly initialize the driver and will get a kernel panic trying to do so.
> Thanks,
> Daniil
>
> On Thu, Apr 30, 2020 at 7:58 AM Enric Balletbo i Serra <enric.balletbo@co=
llabora.com> wrote:
>>
>> Hi Daniil,
>>
>> Thank you for the patch.
>>
>> On 28/4/20 3:02, Daniil Lunev wrote:
>> > Missing EC in device hierarchy causes NULL pointer to be returned to t=
he
>> > probe function which leads to NULL pointer dereference when trying to
>> > send a command to the EC. This can be the case if the device is missin=
g
>> > or incorrectly configured in the firmware blob. Even if the situation
>>
>> There is any production device with a buggy firmware outside? Or this is=
 just
>> for defensive programming while developing the firmware? Which device is
>> affected for this issue?
>>
>> Thanks,
>>  Enric
>>
>> > occures, the driver shall not cause a kernel panic as the condition is
>> > not critical for the system functions.
>> >
>> > Signed-off-by: Daniil Lunev <dlunev@chromium.org>
>> > ---
>> >
>> >  drivers/platform/chrome/cros_ec_typec.c | 5 +++++
>> >  1 file changed, 5 insertions(+)
>> >
>> > diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platfor=
m/chrome/cros_ec_typec.c
>> > index 874269c07073..30d99c930445 100644
>> > --- a/drivers/platform/chrome/cros_ec_typec.c
>> > +++ b/drivers/platform/chrome/cros_ec_typec.c
>> > @@ -301,6 +301,11 @@ static int cros_typec_probe(struct platform_devic=
e *pdev)
>> >
>> >       typec->dev =3D dev;
>> >       typec->ec =3D dev_get_drvdata(pdev->dev.parent);
>> > +     if (!typec->ec) {
>> > +             dev_err(dev, "Failed to get Cros EC data\n");
>> > +             return -EINVAL;
>> > +     }
>> > +
>> >       platform_set_drvdata(pdev, typec);
>> >
>> >       ret =3D cros_typec_get_cmd_version(typec);
>> >
