Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93110C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DFB92075E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ge/W542H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730541AbgDMOSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 10:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730508AbgDMOSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 10:18:44 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E25EC0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 07:18:44 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id m4so9439668ioq.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 07:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=emXwBGPTpqKl3AFe8JZf7oCpzmXnd/oPYYjIiyQ9ScE=;
        b=ge/W542HUDE/dwGDqrvAcxeliK3zSr1ABSsyEXlVoo4KksnXVToo/7YT7h5ZFiyStF
         dPenRCRtm3MKWUh/Wuz5t4wx/cv9vAhOZEhNL/28aiiCC1GssXp9ugmSGjtJq7LAG4vQ
         OLWpxxF9ufT7j8b46jVt3mxztxWAtSU7zNCfdbeZWwMCCBUl8jL7n3637l1nejmPuWh+
         Al9mF3QoTLRe1u4H++gK30DaXPw+ZcF6wNuuPdTcwszxFFQ1G6L0IuTC4n1Lk3y9RHqY
         dZm5TAUVpAV+0jTlOuSZ+osbpax93PzSQ6X+L0Zr6FW2rxTxKr5YDSyul+8z4gc6vJZA
         N0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=emXwBGPTpqKl3AFe8JZf7oCpzmXnd/oPYYjIiyQ9ScE=;
        b=R3G6rbNvROTp94A5QQ0ZIn84wpnvtOjtGTLE7/8JP3LB+vXSg+OEAzLiERWFzLM5BC
         kJV6g9Y35lKWbpy8HLBsWbCzn10kLV/8J8/xoG5kUIeecAscZl9le+khD1BCmyYhvrjD
         Q7Xv1dtwi2llUTDjEWEsYfXg3IaJhH0WNIGnWD+0NhJmBSDm3fDxZBO0lJpqvF92MmA9
         VOi/wybpLBtNG55U5r+3KvcsT39z7uQADpZHZCcYuLho6wPJoz/EsqRLI0s8ktW5MBgY
         rJHnD4+ccQ8lNv4HjNYHIBDJKq9L4ELSXCx18yE0+oRmVTdkinyMt6+7K8GXTfkfS/9j
         nsUQ==
X-Gm-Message-State: AGi0Pub7zGt4VsmWSx05bF+tiqjOJLSFDHTcNlRhsOuvh7q3Wd0Owx0g
        vufuWgEOYOoFfxwzDZhf8FwyTKMyPc5A3qiVlD4=
X-Google-Smtp-Source: APiQypJAOM9uoOA/GO2yY4HMJCCYyVeeJu4iFn9U5G7EWc83Q4TV2uRbET/xEhDMuLWjFv0cZqB0l+Rma3AH0sqKCY0=
X-Received: by 2002:a02:3b4b:: with SMTP id i11mr8280280jaf.16.1586787523808;
 Mon, 13 Apr 2020 07:18:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200411200632.4045-1-peron.clem@gmail.com> <20200411200632.4045-2-peron.clem@gmail.com>
 <c96f31a2-6ff4-31aa-aaac-2ce9eafb3bfe@arm.com>
In-Reply-To: <c96f31a2-6ff4-31aa-aaac-2ce9eafb3bfe@arm.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 13 Apr 2020 16:18:32 +0200
Message-ID: <CAJiuCcegkNGQ7j4jcT1rBpSLqG1c-nb8g0wq+Nbvt-dGj7am2Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/panfrost: add devfreq regulator support
To:     Steven Price <steven.price@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On Mon, 13 Apr 2020 at 15:18, Steven Price <steven.price@arm.com> wrote:
>
> On 11/04/2020 21:06, Cl=C3=A9ment P=C3=A9ron wrote:
> > OPP table can defined both frequency and voltage.
> >
> > Register the mali regulator if it exist.
> >
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >   drivers/gpu/drm/panfrost/panfrost_devfreq.c | 34 ++++++++++++++++++--=
-
> >   drivers/gpu/drm/panfrost/panfrost_device.h  |  1 +
> >   2 files changed, 31 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/=
drm/panfrost/panfrost_devfreq.c
> > index 62541f4edd81..2dc8e2355358 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> > @@ -78,12 +78,26 @@ int panfrost_devfreq_init(struct panfrost_device *p=
fdev)
> >       struct device *dev =3D &pfdev->pdev->dev;
> >       struct devfreq *devfreq;
> >       struct thermal_cooling_device *cooling;
> > +     const char *mali =3D "mali";
> > +     struct opp_table *opp_table =3D NULL;
> > +
> > +     /* Regulator is optional */
> > +     opp_table =3D dev_pm_opp_set_regulators(dev, &mali, 1);
>
> This looks like it applies before 3e1399bccf51 ("drm/panfrost: Add
> support for multiple regulators") which is currently in drm-misc-next
> (and linux-next). You want something more like:

Thanks for you review, indeed I didn't see that multiple regulators
support has been added.
Will update in v2.

>
>      opp_table =3D dev_pm_opp_set_regulators(dev,
>                                            pfdev->comp->supply_names,
>                                            pfdev->comp->num_supplies);
>
> Otherwise a platform with multiple regulators won't work correctly.
>
> Also running on my firefly (RK3288) board I get the following warning:
>
>     debugfs: Directory 'ffa30000.gpu-mali' with parent 'vdd_gpu' already
> present!
>
> This is due to the regulator debugfs entries getting created twice (once
> in panfrost_regulator_init() and once here).

Is it a warning that should be consider as an error? Look's more an info no=
?
What should be the correct behavior if a device want to register two
times the same regulator?

Link to original discussion:
https://lore.kernel.org/patchwork/patch/1176717/

Thanks,
Clement

>
> I have been taking a look at doing the same thing (I picked up Martin
> Blumenstingl's patch series[1]), but haven't had much time to focus on
> this recently.
>
> Thanks,
>
> Steve
>
> [1]
> https://lore.kernel.org/dri-devel/20200112001623.2121227-1-martin.blumens=
tingl@googlemail.com/
>
>
> > +     if (IS_ERR(opp_table)) {
> > +             ret =3D PTR_ERR(opp_table);
> > +             if (ret !=3D -ENODEV) {
> > +                     DRM_DEV_ERROR(dev, "Failed to set regulator: %d\n=
", ret);
> > +                     return ret;
> > +             }
> > +     }
> > +     pfdev->devfreq.opp_table =3D opp_table;
> >
> >       ret =3D dev_pm_opp_of_add_table(dev);
> > -     if (ret =3D=3D -ENODEV) /* Optional, continue without devfreq */
> > -             return 0;
> > -     else if (ret)
> > -             return ret;
> > +     if (ret) {
> > +             if (ret =3D=3D -ENODEV) /* Optional, continue without dev=
freq */
> > +                     ret =3D 0;
> > +             goto err_opp_reg;
> > +     }
> >
> >       panfrost_devfreq_reset(pfdev);
> >
> > @@ -119,6 +133,12 @@ int panfrost_devfreq_init(struct panfrost_device *=
pfdev)
> >   err_opp:
> >       dev_pm_opp_of_remove_table(dev);
> >
> > +err_opp_reg:
> > +     if (pfdev->devfreq.opp_table) {
> > +             dev_pm_opp_put_regulators(pfdev->devfreq.opp_table);
> > +             pfdev->devfreq.opp_table =3D NULL;
> > +     }
> > +
> >       return ret;
> >   }
> >
> > @@ -126,7 +146,13 @@ void panfrost_devfreq_fini(struct panfrost_device =
*pfdev)
> >   {
> >       if (pfdev->devfreq.cooling)
> >               devfreq_cooling_unregister(pfdev->devfreq.cooling);
> > +
> >       dev_pm_opp_of_remove_table(&pfdev->pdev->dev);
> > +
> > +     if (pfdev->devfreq.opp_table) {
> > +             dev_pm_opp_put_regulators(pfdev->devfreq.opp_table);
> > +             pfdev->devfreq.opp_table =3D NULL;
> > +     }
> >   }
> >
> >   void panfrost_devfreq_resume(struct panfrost_device *pfdev)
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/d=
rm/panfrost/panfrost_device.h
> > index 06713811b92c..f6b0c779dfe5 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> > +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> > @@ -86,6 +86,7 @@ struct panfrost_device {
> >       struct {
> >               struct devfreq *devfreq;
> >               struct thermal_cooling_device *cooling;
> > +             struct opp_table *opp_table;
> >               ktime_t busy_time;
> >               ktime_t idle_time;
> >               ktime_t time_last_update;
> >
>
