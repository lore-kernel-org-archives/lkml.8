Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72208C2D0F7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 21:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FEBF20769
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 21:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="RFrsodxT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731236AbgELVAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 17:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725938AbgELVAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 17:00:31 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8090DC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 14:00:31 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a21so15275843ljj.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 14:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TDdEsiy1lD5BaG8worU3pfEwiy8TVHZ/OK/6hiOMkBQ=;
        b=RFrsodxTsCdMDcQ0B7Lm3EsixY3LdaI1+OVIps49ZoFWYCOGlDFAB5lJO7dN6wAQOV
         scwBlc1HXjxzj4mfj9JHfkqfA+0XS6g3aaghfXVv80FYYVFhuABYTTGrXdoL6ncQf4dT
         pWsdlUJcelgB/v7AjD/q4992ZpzmFZEhY3OZjXIPO0JVggQepdu9n60DxKT3dEm3xErg
         KFTkRFuOhVZqSbtzQjEkDmUGl4XWywDr0kwTM7ZdOOktys4+RqaKmUhXtvMaRldPBBBu
         zrS/bzo8arfMKgwFRWigGHY8QYGOEdQJA6J4aK36/kwgVulFFtUyS/7dSCEOl1PmBohB
         m5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TDdEsiy1lD5BaG8worU3pfEwiy8TVHZ/OK/6hiOMkBQ=;
        b=KyLgM42MorTGlGg90UNMHHb5YQJYZ8g3rbv+Fq9g0lMVsru0W8C321lUBDV84BAUV+
         KHW/jZKkeUjIe11mFscSqd1AE1/nGhh0HS7RMe7dMInWXDVV3qR0/KAtG1yx+POzioiM
         +BL9EXPDY6uf2ScT84+PDfyGx8V8eHSVicTuv3iUBeccu0YIMH3P0c8dhzWJYNN0WD16
         aC7Q3c4KMk3L3mt067nbGDM8xcyoPkdtUk23k7eIGgudfe45hdqKzuPUFHuVg8WefjaZ
         v0TK5WEJMCcLocKw5zDzzsurp348YUKq1ysa2sMMPlOuiSACFWUl129X9j2Gb07z5Zqo
         EzFA==
X-Gm-Message-State: AOAM532te+5MZ9p+z4l/zhW8Lfi953WDJW2KqmLf+Hk569vSpVoSb8l2
        Nt+1sIlJE+eG1Tu935A55sWbxf6L22pY8CTUTjYmMw==
X-Google-Smtp-Source: ABdhPJwf2XbHn64f/pzEGlh7y/CxqM3rg7OqY0mu+g2r0Irzp74CC5oIv2nH/0mHE3u+OoFIutEpx9VWuzzH0188Js4=
X-Received: by 2002:a2e:96cd:: with SMTP id d13mr14284184ljj.219.1589317229927;
 Tue, 12 May 2020 14:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200306002112.255361-1-dbasehore@chromium.org>
 <ecbfb5f8-615a-4a88-5dac-de17158125bf@gmail.com> <CAGAzgsqpjZxh7PEL_Dy7HrFeFGm7+=F6cL3QG9KmK9CHvDWZ9g@mail.gmail.com>
 <6dc9ef16-9671-6ce8-27e6-aa1f4c009ee2@gmail.com> <CAGAzgsrNrq+S+-5KEFVnJn6S5DRn1fKkToD5=KR911T9AOAF-w@mail.gmail.com>
 <736ad1d2-4a28-87e8-62f7-28a5582c9fcf@gmail.com>
In-Reply-To: <736ad1d2-4a28-87e8-62f7-28a5582c9fcf@gmail.com>
From:   Sean Paul <sean@poorly.run>
Date:   Tue, 12 May 2020 16:59:53 -0400
Message-ID: <CAMavQKJtbha_o==X+MX6GmjfAMYvdLyubvCFg48Tbn1mdgo40w@mail.gmail.com>
Subject: Re: [PATCH v10 0/2] Panel rotation patches
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     "dbasehore ." <dbasehore@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 7:03 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 15.04.2020 00:32, dbasehore . =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Tue, Apr 14, 2020 at 2:18 PM Dmitry Osipenko <digetx@gmail.com> wrot=
e:
> >>
> >> 14.04.2020 22:32, dbasehore . =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>> Hi Dmitry, sorry for the late reply.
> >>>
> >>> On Sun, Mar 8, 2020 at 12:25 PM Dmitry Osipenko <digetx@gmail.com> wr=
ote:
> >>>>
> >>>> 06.03.2020 03:21, Derek Basehore =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>>>> This adds the plumbing for reading panel rotation from the devicetr=
ee
> >>>>> and sets up adding a panel property for the panel orientation on
> >>>>> Mediatek SoCs when a rotation is present.
> >>>>
> >>>> Hello Derek and everyone,
> >>>>
> >>>> I'm looking at adding display rotation support to NVIDIA Tegra DRM
> >>>> driver because some devices have display panel physically mounted
> >>>> upside-down, and thus, display controller's scan-out needs to be rot=
ated
> >>>> by 180=C2=B0 in this case.
> >>>>
> >>>> Derek, yours panel-rotation patches add support for assigning panel'=
s
> >>>> orientation to the connector, but then only primary display plane
> >>>> receives rotation value in [1], while rotation needs to be applied t=
o
> >>>> all available overlay/cursor planes and this should happen in other
> >>>> places than [1] as well.
> >>>
> >>> This is intended. We don't correct the output in the kernel. We
> >>> instead rely on notifying userspace that the panel is rotated, then w=
e
> >>> handle it there.
> >>>
> >>>>
> >>>> [1] drm_client_modeset_commit_atomic()
> >>>>
> >>>> Please also note that in a case of the scan-out rotation, plane's
> >>>> coordinates need to be changed in accordance to the display's rotati=
on.
> >>>>
> >>>> I looked briefly through the DRM code and my understanding that the =
DRM
> >>>> core currently doesn't support use-case where scan-out needs to rota=
ted
> >>>> based on a panel's orientation, correct? Is it the use-case you're
> >>>> working on for the Mediatek driver?
> >>>
> >>> Yes, we rely on userspace to rotate the output. The major reason for
> >>> this is because there may not be a "free" hardware rotation that can
> >>> be applied to the overlay. Sean Paul and others also preferred that
> >>> userspace control what is output to the screen instead of the kernel
> >>> taking care of it. This code just adds the drm property to the panel.
> >>>
> >>
> >> Could you please explain what that userspace is?
> >
> > This was added for Chrome OS, which uses its own graphics stack,
> > Ozone, instead of Xorg.
> >
>
> Thank you very much for the clarification.
>
> It's probably not a big problem for something monolithic and customized
> like ChromeOS to issue a software update in order to take into account
> all specifics of a particular device, but this doesn't work nicely for a
> generic software, like a usual Linux distro.
>
> >> AFAIK, things like Xorg modesetting don't support that orientation pro=
perty.
>
> In my case it's not only the display panel which is upside-down, but
> also the touchscreen. Hence both display output and touchscreen input
> need to be rotated at once, otherwise you'll end up with either display
> or input being upside-down.
>
> The 180=C2=B0 rotation should be free on NVIDIA Tegra. There are no known
> limitations for the planes and BSP kernel video driver handles the
> plane's coordinates/framebuffer rotation within the driver.
>
> The kernel's input subsystem allows us to transparently (for userspace)
> remap the touchscreen input (by specifying generic touchscreen
> device-tree properties), while this is not the case for the DRM subsystem=
.
>
> @Thierry, @Sean, @Daniel, could you please help me to understand how a
> coordinated display / input rotation could be implemented, making the
> rotation transparent to the user (i.e. avoiding xorg.conf hacking and
> etc)? It should be nice if display's output could be flipped within the
> DRM driver, hiding this fact from userspace.

I think the right thing to do is to fix userspace to respect this
property, since that has the most communal benefit.

However(!!) if you don't want to do that, how about inspecting the
info->panel_orientation value after drm_panel_attach in tegra driver
and then adjusting rotation values in the driver. Of course, you
wouldn't want to expose the panel orientation property since you don't
want userspaces to be double-rotating on you, but it's optional so
you'd be fine.

>
> Will it be okay if we'll add a transparent-rotation support specifically
> to the Tegra DRM driver? For example if device-tree contains
> nvidia,display-flip-y property, then the Tegra DRM driver will take care
> of rotating coordinates/framebuffer of the display planes.

I don't think this is necessary, but it also wouldn't really be
appropriate to put software attributes into devicetree anyways.

Sean
