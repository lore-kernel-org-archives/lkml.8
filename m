Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78646C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 10:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C61C206ED
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 10:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LUObm/4l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387476AbgBNKlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 05:41:19 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53990 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387397AbgBNKlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 05:41:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581676877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JIODMyxS3Cw9NVg2Y0JpjutrQnRroxT6oU0d5Fa65Qk=;
        b=LUObm/4lEVO5KAnX63WGy3bsGzwNNG9fHcuBTMLWZEGf1oAjzJ5hW7HVx0116g0FIoMpK4
        HpZy5b5Jcq+BHFZtUaIiJi0UScGA3Cl9BI5Bs8LpSbkPRsNRCC4BPUEsr6eG6OtV76Zcix
        D0BUHWGyAu/PdQQpdR9cPX7skwCQOOs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-6m0DcErZMG2mxi4j1FioBg-1; Fri, 14 Feb 2020 05:41:11 -0500
X-MC-Unique: 6m0DcErZMG2mxi4j1FioBg-1
Received: by mail-qv1-f71.google.com with SMTP id v3so5432170qvm.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 02:41:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JIODMyxS3Cw9NVg2Y0JpjutrQnRroxT6oU0d5Fa65Qk=;
        b=DNGGb0YHTimbu0XMPSWZ3GJH9Av4kU34mY3KjiQqYcfxizp8Bpp2RynAHAlprP/++u
         yboTd3SXpvlIBFcF9X3jGYaAU6tc3+kJdFJc5UKMGf75w9McvFBhyeM5dwTqd0WFtaCi
         kF5oQGISmaCTPpt5DspUtuhdaULcssnOqFrTFp5Hu3sfcPmDc8XI2Ow8AWpCLVMsoZAW
         hYTBf44xedpZgmrhe+pCb2XgiYv4I4Vjk8T95gTqzjh8QW3lN+3IncRMiu5FjCxQIJ3K
         9PiIdKRZQrPZuT1oNVEa9+USfT2SXHE7V6eyOo2OGSldLNKfvVtXi+GERweCwdB2YYw3
         TPnw==
X-Gm-Message-State: APjAAAWEvEJir+oLhrYKBioQHlowdFkt82s1khql4Lh0HUJWn91I3UY5
        wVMtiE9CKaodPCwKMRDdDHJOwqppfh4PwKU2z12HTKQGJXyOknGPkQx006RuD03lcY4lEmBKpz7
        YcdpbdhgHU0bUT5Ggk9v90oqnKiZnzy4ndsLAm9x9
X-Received: by 2002:a37:a717:: with SMTP id q23mr1847722qke.169.1581676870590;
        Fri, 14 Feb 2020 02:41:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqw8d+hGyj3olMhg+4toi9NBjWt6lr9Wsapa23D7XeqEdU1Ydn5be+Ql2yJAA553mDKf9WAuFnMbeiu3rclujH0=
X-Received: by 2002:a37:a717:: with SMTP id q23mr1847704qke.169.1581676870363;
 Fri, 14 Feb 2020 02:41:10 -0800 (PST)
MIME-Version: 1.0
References: <20200214065309.27564-1-kai.heng.feng@canonical.com> <189a7784-3754-99b8-3f3d-560b7657c134@redhat.com>
In-Reply-To: <189a7784-3754-99b8-3f3d-560b7657c134@redhat.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 14 Feb 2020 11:40:59 +0100
Message-ID: <CAO-hwJL5d4RGxOZ7NqDBdQ=0GYCDThCUR8b+-kRpwPEuhsFXyA@mail.gmail.com>
Subject: Re: [PATCH] HID: i2c-hid: add Trekstor Surfbook E11B to descriptor override
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Feb 14, 2020 at 9:32 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 2/14/20 7:53 AM, Kai-Heng Feng wrote:
> > The Surfbook E11B uses the SIPODEV SP1064 touchpad, which does not supply
> > descriptors, so it has to be added to the override list.
> >
> > BugLink: https://bugs.launchpad.net/bugs/1858299
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>
> Patch looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Thanks everybody for the patch submission and the quick review.

Patch is now queued in for-5.6/upstream-fixes

Cheers,
Benjamin

>
> Regards,
>
> Hans
>
>
>
> > ---
> >   drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c b/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
> > index d31ea82b84c1..a66f08041a1a 100644
> > --- a/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
> > +++ b/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
> > @@ -341,6 +341,14 @@ static const struct dmi_system_id i2c_hid_dmi_desc_override_table[] = {
> >               },
> >               .driver_data = (void *)&sipodev_desc
> >       },
> > +     {
> > +             .ident = "Trekstor SURFBOOK E11B",
> > +             .matches = {
> > +                     DMI_EXACT_MATCH(DMI_SYS_VENDOR, "TREKSTOR"),
> > +                     DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "SURFBOOK E11B"),
> > +             },
> > +             .driver_data = (void *)&sipodev_desc
> > +     },
> >       {
> >               .ident = "Direkt-Tek DTLAPY116-2",
> >               .matches = {
> >
>

