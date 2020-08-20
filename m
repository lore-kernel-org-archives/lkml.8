Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8421EC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 18:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5014E207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 18:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMZz2dIN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgHTSUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 14:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgHTSUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 14:20:33 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAEDC061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 11:20:32 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id y3so3011658wrl.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 11:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zx2aiS5u/hckouAkg5PnRRNt9/H2zFBAnmQ4nJmER3I=;
        b=gMZz2dINC8zpXVORxgXuG419lwuL2jppPFpi9E8y9ViJ5rFQVNH5ukaLokAx1UNnAk
         LnFjj1ja6vrOsfCmyvCtvycL5UbeTjrswVf/fz474oCsgo7KR4DwDs8+9yME2QzSyP1t
         btNlhjDwesjZHpPkIwvSAFxi/3ehi3qZZhRwoz1aMyqAsF+kD90DdJmoGoBYMl1yK/MX
         1wieGOerjuYByQQswCybYzTMyJ+NRHx4ec4IWNJs8+7licRAvCwVBOLRJwCWxHFjcfS/
         aJ+seiC59nGep1PKg4bc8wt71F4XQ/swv4ch3ygt87iK0ZLccKXrRsjnwDF9FQbmOMRP
         lSQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zx2aiS5u/hckouAkg5PnRRNt9/H2zFBAnmQ4nJmER3I=;
        b=NEezYlTZMNTFksimqJ/Xp3UOoaZa+68qdWwTJYmKEDn/E8EEP04Eky9uIVNuMUCOXJ
         oSGp7xqt520Z1THcmJjxXvtowm5MaK0niiD0RvjyGr4VdU3FX3DPH0QN80YwnI6JlWi6
         AfT2k+Zy8OG2kOWvEwr2AiKVTJLr6NmUTh1PKYipvcl+FHx4GWTwvvEgiCFhJ4T77UZ7
         2zSjsibLIaMac7irQdcTknAQWRuFr6XVxv5gnV87RPMZ6ArRewQyNobw5NPScDWGN8oX
         U7lZnrUQjp8oj7LdCrEtpuKsi5SATlEHMOgc2CWx0Q9r+OMHSn4YKHRSX8mdAJgwBYzD
         Fdzw==
X-Gm-Message-State: AOAM531grfWKX6AO3Oe/c/43LGLOzITTuEChxoNv3KFFwNl1kHolFbhh
        Rz6YKIgJne1fjWdNyIKOrcGhzs34lqe+TxmKPvg=
X-Google-Smtp-Source: ABdhPJyCgPFZTTFbee2LsSre9fQTTAa/kvTeNAYYXu+7XbLwA7kVTe9RGC+WZR3sqKRc/e35BaY8uJLdg3H4gsxzS/w=
X-Received: by 2002:adf:a351:: with SMTP id d17mr4280713wrb.111.1597947629882;
 Thu, 20 Aug 2020 11:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200820052600.3069895-1-furquan@google.com> <20200820075241.3160534-1-furquan@google.com>
 <5c7dbcd6-b4c5-f7e5-40d5-b65d8ff58030@amd.com>
In-Reply-To: <5c7dbcd6-b4c5-f7e5-40d5-b65d8ff58030@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 20 Aug 2020 14:20:18 -0400
Message-ID: <CADnq5_NEoM1RGoLS=a0HDtN20rOvKndiYCFRnzrc3JQn5ePzpQ@mail.gmail.com>
Subject: Re: [PATCH v2] drivers: gpu: amd: Initialize amdgpu_dm_backlight_caps
 object to 0 in amdgpu_dm_update_backlight_caps
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Furquan Shaikh <furquan@google.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Stylon Wang <stylon.wang@amd.com>, deepak.sharma@amd.com,
        David Airlie <airlied@linux.ie>, adurbin@google.com,
        Roman Li <roman.li@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Aug 20, 2020 at 5:01 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 20.08.20 um 09:52 schrieb Furquan Shaikh:
> > In `amdgpu_dm_update_backlight_caps()`, there is a local
> > `amdgpu_dm_backlight_caps` object that is filled in by
> > `amdgpu_acpi_get_backlight_caps()`. However, this object is
> > uninitialized before the call and hence the subsequent check for
> > aux_support can fail since it is not initialized by
> > `amdgpu_acpi_get_backlight_caps()` as well. This change initializes
> > this local `amdgpu_dm_backlight_caps` object to 0.
> >
> > Signed-off-by: Furquan Shaikh <furquan@google.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> > v2: Switched to using memset for initialization of object.
> >
> > drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/driver=
s/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index e4b33c67b634..da072998ce48 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -2855,6 +2855,8 @@ static void amdgpu_dm_update_backlight_caps(struc=
t amdgpu_display_manager *dm)
> >   #if defined(CONFIG_ACPI)
> >       struct amdgpu_dm_backlight_caps caps;
> >
> > +     memset(&caps, 0, sizeof(caps));
> > +
> >       if (dm->backlight_caps.caps_valid)
> >               return;
> >
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
