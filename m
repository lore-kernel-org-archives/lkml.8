Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF72C83000
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 00:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B421F20731
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 00:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FfcNmeqW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgD3Anh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 20:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726309AbgD3Ang (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 20:43:36 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E687C035494
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 17:43:36 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id p13so2162230qvt.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 17:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5o/Er+M3stuv2s1188l/Kps5H4ED2pxcg+ddDdjlJ8s=;
        b=FfcNmeqWBWruARuFzkjgHZp3rrglu4upXfmDX/X6a498J/M1Mk3viO7rgpCGJ7t+4Q
         vZGnmJY3pETS04ZqmDDAe7FUs9rLNh/pCKEiUWg9nLn+w4W6lG/ao5iziap0KeMoV62w
         v3k8wdfAU4IsuqT3rybNFITNCePP8UlBKxdIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5o/Er+M3stuv2s1188l/Kps5H4ED2pxcg+ddDdjlJ8s=;
        b=VOzLXcBQUR6el8JGN6xuVu9UMY9/hU5rQ1MaJb5jLSuSirnnw021m0AURaX4lEfHr1
         OikUdXZS5rdUwecSLNZdM6szPBn3sGsiE42OY8Q84U0mVI8nHBZDXWcUC3SNhmCwO2ZB
         dwnlregSKkKYnspmEQR26M4m/ioz6Bx+hV4iw9G6ZUB8zGcG9YoR0lRF9/sl0I1+z0Ni
         Mzc+zmE6hEt5eOzTd8pgvd2hV9qiLK7bYvTxdzsDnVaESQEqixYc+PN5cKxo4r9wxp4S
         jpRqMnFsEJM76JVwqrlt+Exm4exJldBj+OkNfkPdHy7D+qtWYap6efoH5EgnnK0/PsgU
         WIcg==
X-Gm-Message-State: AGi0PuaxDgYPlKSBfKyOKDuAELIk0LDV07yw8Gp9LApZ6MVyKjNuTPMX
        TmaLs+2Gj+j8oweu5WfHLWEM95tmOnZefuqrVH4RJUxU
X-Google-Smtp-Source: APiQypJ4s+Ms/TihTztIamAJiwTfWcsAsvUL1G3pM+kBNzlXtf6SCum+EyCWC+EmJWqs7SRwAKurn/ptG+pVSka5vX0=
X-Received: by 2002:a05:6214:150f:: with SMTP id e15mr593521qvy.18.1588207415260;
 Wed, 29 Apr 2020 17:43:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200428110253.1.I926f6741079cafb04ecb592130aef75b24ad31ae@changeid>
 <c57b0892-d68d-f0f2-3cc1-b8549983227e@collabora.com> <CAONX=-dLVBpz+p1si4cWGHEmQ_toO8kW=fCPcdUuX2KLc-o=2A@mail.gmail.com>
 <CAONX=-dDWjMQDGncSgXNf86Bt3C5OUtFqh=Pe2HToGPSv5qa4A@mail.gmail.com>
In-Reply-To: <CAONX=-dDWjMQDGncSgXNf86Bt3C5OUtFqh=Pe2HToGPSv5qa4A@mail.gmail.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Wed, 29 Apr 2020 17:43:24 -0700
Message-ID: <CACeCKacoEjQm0_VfZGYNEZVhKubPyqspNZupQk+7piJOsVzH+Q@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Handle NULL EC pointer
 during probe.
To:     Daniil Lunev <dlunev@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 5:38 PM Daniil Lunev <dlunev@chromium.org> wrote:
>
> [to make it appear on the mailing list as I didn't realize I was in
> hypertext sending mode]
>
> On Thu, Apr 30, 2020 at 10:11 AM Daniil Lunev <dlunev@chromium.org> wrote=
:
> >
> > Hi Enric.
> > I encountered the issue on a Hatch device when trying running 5.4 kerne=
l on that. After talking to Prashant it seems that any device with coreboot=
 built before a certain point (a particular fix for device hierarchy in ACP=
I tables of Chrome devices which happened in mid-April) will not be able to=
 correctly initialize the driver and will get a kernel panic trying to do s=
o.

A clarifying detail here: This should not be seen in any current
*production* device. No prod device firmware will carry the erroneous
ACPI device entry.

> > Thanks,
> > Daniil
> >
> > On Thu, Apr 30, 2020 at 7:58 AM Enric Balletbo i Serra <enric.balletbo@=
collabora.com> wrote:
> >>
> >> Hi Daniil,
> >>
> >> Thank you for the patch.
> >>
> >> On 28/4/20 3:02, Daniil Lunev wrote:
> >> > Missing EC in device hierarchy causes NULL pointer to be returned to=
 the
> >> > probe function which leads to NULL pointer dereference when trying t=
o
> >> > send a command to the EC. This can be the case if the device is miss=
ing
> >> > or incorrectly configured in the firmware blob. Even if the situatio=
n
> >>
> >> There is any production device with a buggy firmware outside? Or this =
is just
> >> for defensive programming while developing the firmware? Which device =
is
> >> affected for this issue?
> >>
> >> Thanks,
> >>  Enric
> >>
> >> > occures, the driver shall not cause a kernel panic as the condition =
is
> >> > not critical for the system functions.
> >> >
> >> > Signed-off-by: Daniil Lunev <dlunev@chromium.org>
> >> > ---
> >> >
> >> >  drivers/platform/chrome/cros_ec_typec.c | 5 +++++
> >> >  1 file changed, 5 insertions(+)
> >> >
> >> > diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platf=
orm/chrome/cros_ec_typec.c
> >> > index 874269c07073..30d99c930445 100644
> >> > --- a/drivers/platform/chrome/cros_ec_typec.c
> >> > +++ b/drivers/platform/chrome/cros_ec_typec.c
> >> > @@ -301,6 +301,11 @@ static int cros_typec_probe(struct platform_dev=
ice *pdev)
> >> >
> >> >       typec->dev =3D dev;
> >> >       typec->ec =3D dev_get_drvdata(pdev->dev.parent);
> >> > +     if (!typec->ec) {
> >> > +             dev_err(dev, "Failed to get Cros EC data\n");
> >> > +             return -EINVAL;
> >> > +     }
> >> > +
> >> >       platform_set_drvdata(pdev, typec);
> >> >
> >> >       ret =3D cros_typec_get_cmd_version(typec);
> >> >
