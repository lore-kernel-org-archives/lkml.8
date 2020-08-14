Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D483BC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 08:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2E19207DA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 08:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e89zevz8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgHNIXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 04:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgHNIXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 04:23:44 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C383FC061383
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 01:23:43 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id d2so4420038lfj.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 01:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=eFnKZN0nDkXEMnVHqpXKPvxHxeInqTtj3cAC5I26ma4=;
        b=e89zevz81wOF42kMV3hsGa+7BPXPtkxZT5SvAK328YLsMv8YiAmNkzT4L6YaGJLpY2
         ZJNAx20IoadLD3KkhRWnGUFUlHEMDH4M4JftMFaG7EviQ+IOiWIPntmmuUd2i+R+5AAg
         /RGL4aJHGHWbS+cr67dF2thOXGwuIP0/QzJDHspGD+onCcco3mYtfxCM8mw6GdaeOE2L
         gzf2wi+JsmV0GC5mtvK9tQAomhLiacBd8hRLQ0eYU9xpHoYKNojXrcFxygVHdFdpsaji
         WEDO79rx+9BNmFBANRqlatBAb3e9y6WV/05koeyaIVXRJtLwQX4SwwIAd5cx6rdDpDiD
         HxOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=eFnKZN0nDkXEMnVHqpXKPvxHxeInqTtj3cAC5I26ma4=;
        b=oxxJOuPETNCRKOtgC168oyQLWgVReflwZwhm/uzpwnFMmEOr4ezhLCEqHOzZvtQd44
         Xb05pCT/868ElcBowbYeOw9UL/6keUWogDHfHT0m16qJ1uTYe75D9bRFO7CxgBfdRMB6
         tArg44/cX8pYCM+qfmgcLaN0OGwog0MDAJ/0cEGHzdgjH4YZnEhZrVMJuMQrcfbNeEPR
         WUuWoDhU1Kc2XhffXkuYP8AbnzT5XPj+vUs2+U9v8Wah4Z1UASELt//8aepCiHqtZM5C
         VeaiRs/2vSWeiWJh6905ZAa6c+N/sR2r3CB1uYaHR2HIhKa16hKQBmHmiEbs16cu1/6Z
         6MDw==
X-Gm-Message-State: AOAM531+fBByKEvNaqiYSLp4rh4ASQo5dcXzmP2c/12DonazuOYDdkkq
        iCBWft8hpxw567M/hG/IH0U=
X-Google-Smtp-Source: ABdhPJx1Eta7oqUaKM47XYlHscA1lToyUV1G6AhWGpLRzYA7//kae7qnZT67N8cFYQPLtWHCmeXIrA==
X-Received: by 2002:a19:c852:: with SMTP id y79mr710040lff.37.1597393421186;
        Fri, 14 Aug 2020 01:23:41 -0700 (PDT)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id m27sm1731878lfq.19.2020.08.14.01.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 01:23:40 -0700 (PDT)
Date:   Fri, 14 Aug 2020 11:23:29 +0300
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     crj <algea.cao@rock-chips.com>, jernej.skrabec@siol.net,
        laurent.pinchart+renesas@ideasonboard.com, jonas@kwiboo.se,
        airlied@linux.ie, kuankuan.y@gmail.com, narmstrong@baylibre.com,
        hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, a.hajda@samsung.com,
        tzimmermann@suse.de, jbrunet@baylibre.com,
        linux-rockchip@lists.infradead.org, darekm@google.com,
        sam@ravnborg.org, linux-arm-kernel@lists.infradead.org,
        cychiang@chromium.org
Subject: Re: [PATCH 4/6] drm/rockchip: dw_hdmi: Add vendor hdmi properties
Message-ID: <20200814112329.4f83dc7a@eldfell>
In-Reply-To: <20200813104522.GA6057@pendragon.ideasonboard.com>
References: <20200812083120.743-1-algea.cao@rock-chips.com>
        <20200812083543.4231-1-algea.cao@rock-chips.com>
        <20200812093315.GE6057@pendragon.ideasonboard.com>
        <52cca26d-b2b3-22b2-f371-a8086f2e6336@rock-chips.com>
        <20200812133017.GJ6057@pendragon.ideasonboard.com>
        <20200813104228.096179e7@eldfell>
        <20200813104522.GA6057@pendragon.ideasonboard.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/OYJIbNYvQBUhhX5zztcLolA"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OYJIbNYvQBUhhX5zztcLolA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Aug 2020 13:45:22 +0300
Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:

> On Thu, Aug 13, 2020 at 10:42:28AM +0300, Pekka Paalanen wrote:
> > On Wed, 12 Aug 2020 16:30:17 +0300 Laurent Pinchart wrote: =20
> > > On Wed, Aug 12, 2020 at 07:08:10PM +0800, crj wrote: =20
> > > > =E5=9C=A8 2020/8/12 17:33, Laurent Pinchart =E5=86=99=E9=81=93:   =
=20
> > > > > On Wed, Aug 12, 2020 at 04:35:43PM +0800, Algea Cao wrote:   =20
> > > > >> Introduce struct dw_hdmi_property_ops in plat_data to support
> > > > >> vendor hdmi property.
> > > > >>
> > > > >> Implement hdmi vendor properties color_depth_property and
> > > > >> hdmi_output_property to config hdmi output color depth and
> > > > >> color format.
> > > > >>
> > > > >> The property "hdmi_output_format", the possible value
> > > > >> could be:
> > > > >>           - RGB
> > > > >>           - YCBCR 444
> > > > >>           - YCBCR 422
> > > > >>           - YCBCR 420
> > > > >>
> > > > >> Default value of the property is set to 0 =3D RGB, so no changes=
 if you
> > > > >> don't set the property.
> > > > >>
> > > > >> The property "hdmi_output_depth" possible value could be
> > > > >>           - Automatic
> > > > >>             This indicates prefer highest color depth, it is
> > > > >>             30bit on rockcip platform.
> > > > >>           - 24bit
> > > > >>           - 30bit
> > > > >> The default value of property is 24bit.
> > > > >>
> > > > >> Signed-off-by: Algea Cao <algea.cao@rock-chips.com>
> > > > >> ---
> > > > >>
> > > > >>   drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 174 ++++++++++++=
++++++++
> > > > >>   include/drm/bridge/dw_hdmi.h                |  22 +++
> > > > >>   2 files changed, 196 insertions(+)
> > > > >>
> > > > >> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drive=
rs/gpu/drm/rockchip/dw_hdmi-rockchip.c
> > > > >> index 23de359a1dec..8f22d9a566db 100644
> > > > >> --- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> > > > >> +++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> > > > >> @@ -52,6 +52,27 @@
> > > > >>  =20
> > > > >>   #define HIWORD_UPDATE(val, mask)	(val | (mask) << 16)
> > > > >>  =20
> > > > >> +/* HDMI output pixel format */
> > > > >> +enum drm_hdmi_output_type {
> > > > >> +	DRM_HDMI_OUTPUT_DEFAULT_RGB, /* default RGB */
> > > > >> +	DRM_HDMI_OUTPUT_YCBCR444, /* YCBCR 444 */
> > > > >> +	DRM_HDMI_OUTPUT_YCBCR422, /* YCBCR 422 */
> > > > >> +	DRM_HDMI_OUTPUT_YCBCR420, /* YCBCR 420 */
> > > > >> +	DRM_HDMI_OUTPUT_YCBCR_HQ, /* Highest subsampled YUV */
> > > > >> +	DRM_HDMI_OUTPUT_YCBCR_LQ, /* Lowest subsampled YUV */
> > > > >> +	DRM_HDMI_OUTPUT_INVALID, /* Guess what ? */
> > > > >> +};   =20
> > > > >
> > > > > Vendor-specific properties shouldn't use names starting with drm_=
 or
> > > > > DRM_, that's for the DRM core. But this doesn't seem specific to
> > > > > Rockchip at all, it should be a standard property. Additionally, =
new
> > > > > properties need to come with a userspace implementation showing t=
heir
> > > > > usage, in X.org, Weston, the Android DRM/KMS HW composer, or anot=
her
> > > > > relevant upstream project (a test tool is usually not enough).   =
=20
> > > >=20
> > > > We use these properties only in Android HW composer, But we can't u=
pstream
> > > >=20
> > > > our HW composer code right now.=C2=A0 Can we use this properties as=
 private=20
> > > > property
> > > >=20
> > > > and do not upstream HW composer for the time being?   =20
> > >=20
> > > It's not my decision, it's a policy of the DRM subsystem to require an
> > > open implementation in userspace to validate all API additions. =20
> >=20
> > Also read
> > https://www.kernel.org/doc/html/latest/gpu/drm-uapi.html#open-source-us=
erspace-requirements
> > very carefully: it calls for a FOSS userspace project's proper upstream
> > to have reviewed and accepted the patches to use the new UAPI, but
> > those patches must NOT be MERGED at that time yet. =20
>=20
> Correct. Many userspace projects wouldn't merge a patch before the
> kernel API is merged, so that would create a chicken and egg problem :-)

I wouldn't be so sure that absolutely everyone knows that rule. It only
takes just one userspace project to merge and release with it to
potentially require renaming everything if any change is needed after
the kernel review process.

Actually, if I remember right, I may have seen such merging happen.
After all, "accepted" is usually a synonym for "merged".


Thanks,
pq

--Sig_/OYJIbNYvQBUhhX5zztcLolA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAl82SgEACgkQI1/ltBGq
qqeoPg//QF/KmV+W3r7hJpYNR4Fh9oX2bbkn6C+oa1Op70IyVrpYTJJisVcGIuVx
YbQd+GAtYLMuS5ooTO6pWn09zXCZ1l1tNLSoKtheiCLKyQZ/QplxTe2Vrm2gLjE/
MRw6EnAcD3RwHCqLTNWDKlIMehm+MYYRphizLCuGkSJcwNyqn7xFlT3aAIpeSkoA
UHz3Wg+kfBfbse82XNVLDPJ64zB0LY38/8Ae5U8AoEqcQDdpG+F68jchhR4AseAv
hQ78LD2q2/hNvSZxmo7rMvdddZMMh8/7qFvjKkZYUL/+9K8U3wZ5KkdqsQbl1azP
bFFM88zz9MEQWhiAV6Up+aPFo+/fvVOdlo7mHWhNztetbKI5zwUlp/IHd3dEsk6R
xyOKBU/fgehGpHpFGGR7452nfrwN3w4xNCRbO2RiupbAC1l1ilvMFGw3Il/50L6Y
DyXdUN5x1zeA7Api94KXSBELWX42/AFijzHo5IGeWLG37Uhq+CmMjyvaGVnJQG2R
1E+fcOS7wkBTFgbMkkSIieB0sH6/EAD8q8eTvlrZQodRcijZylONSxn+8gOkBlKC
FR2OuE4Y9ygf4KrlF7FEcYxYoCu4SFblpuc8Ah76dnEHFCNIId9uLZI0uyQTRjVL
urvGr/Bl0nK7s/52x0WRZnu0uqt2OBM02L7dj5uTVkflkDjqDPU=
=uVVF
-----END PGP SIGNATURE-----

--Sig_/OYJIbNYvQBUhhX5zztcLolA--
