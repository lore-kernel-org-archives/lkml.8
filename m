Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1752C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1308206EF
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAYv9bIK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbgIAQam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbgIAQai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 12:30:38 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCE5C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 09:30:37 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id o5so2220914wrn.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 09:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dJWXvZJM7Rn58/XCux894oNDEA8N0mvrqTZBm36mRD8=;
        b=BAYv9bIKlv5XxzGIg6gQ4IP+lB247VfdzjbsG0AIE6Xa5tHfIgi7s5SNp1TAn6dQ+3
         yyJSGNQJNTU7b3U4q1Db1mzZZyYNVJqpb+3BNi2lCay9ZWcxYxAeXrUKXRCrUsEnb5IC
         vIvE5Bqzlr1pvwvcTVsVEX2JD59ZDJJqlVLqt/AaLcbqN3anmWKTdXzkhiX31VOG9dD2
         iZiuIcP9PYMGizayS5dQy+iWShXEOz2cBmYgHN0JC06ElVtmu/hAskEs6C7X8WTuvAFo
         82AwE458kdU70SwXYGW5tudnXh92/gBdlmAMaS8dGhlqOj3EtzHi+6j5csQF/WhltvFr
         eTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dJWXvZJM7Rn58/XCux894oNDEA8N0mvrqTZBm36mRD8=;
        b=tbidSSfMv/dnu5XqPxxyYv4R1g3WEwTFlry88e1foQJNz977HgcTKOdaCa3rOjbtiO
         dCKTvNrmVAPlsTLlwpc0HetEZwycKR/1VkECQSiUsGrgC42RPcSY8rifGja10pcrfU+P
         SzxV8HFrMLzfenpVJ5FwNrUV640Vmmkz05Q73sEY8fAAXR41OFem/yv0xS62az19SE8k
         p5uTqJhJz1UtFKdwiLMuegxfmSX/l+Pc1NGhv72wkqZ18uGOxB41xen4YPbrHp+qTMVr
         GvKzR4zWLbRDVRLMNOBvJojQCdhb/E+0r+yUd3E+FltBHyCCC7iF6IO4Z/f35CFDua/5
         pmMQ==
X-Gm-Message-State: AOAM533UaibshSRqn/Dv1oSj0z3cFwyBRfmc2GSfrV95By+rducCsvd7
        ZBwoHAfflZ0GknAxBwc8T+RlEzyKgkgdXxsQnQE=
X-Google-Smtp-Source: ABdhPJzzSrHT7+gBJQ7wWBvPgJGllAEIrLh9E3aUHR/FsKFXgMIVyTDBs4wzl5zRXelF2y/qR6xaj9Pen/T2mxCXszw=
X-Received: by 2002:adf:ef0a:: with SMTP id e10mr2733473wro.362.1598977836259;
 Tue, 01 Sep 2020 09:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200901063227.6057-1-kai.heng.feng@canonical.com>
 <CADnq5_MXs-=BpMrYVudhHPjTpgs1XUE=GEujpp5AeYy5vWS=YA@mail.gmail.com> <3269C99F-2349-4004-8B5F-31A2297A5043@canonical.com>
In-Reply-To: <3269C99F-2349-4004-8B5F-31A2297A5043@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 1 Sep 2020 12:30:25 -0400
Message-ID: <CADnq5_PMLoL0Zkw8uB+noPJ0buO5aUavDrFGBhBp_GEz8+xBDA@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Reset ASIC if suspend is not managed by
 platform firmware
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 1, 2020 at 12:21 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
>
>
> > On Sep 1, 2020, at 22:19, Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > On Tue, Sep 1, 2020 at 3:32 AM Kai-Heng Feng
> > <kai.heng.feng@canonical.com> wrote:
> >>
> >> Suspend with s2idle or by the following steps cause screen frozen:
> >> # echo devices > /sys/power/pm_test
> >> # echo freeze > /sys/power/mem
> >>
> >> [  289.625461] [drm:uvd_v1_0_ib_test [radeon]] *ERROR* radeon: fence wait timed out.
> >> [  289.625494] [drm:radeon_ib_ring_tests [radeon]] *ERROR* radeon: failed testing IB on ring 5 (-110).
> >>
> >> The issue doesn't happen on traditional S3, probably because firmware or
> >> hardware provides extra power management.
> >>
> >> Inspired by Daniel Drake's patch [1] on amdgpu, using a similar approach
> >> can fix the issue.
> >
> > It doesn't actually fix the issue.  The device is never powered down
> > so you are using more power than you would if you did not suspend in
> > the first place.  The reset just works around the fact that the device
> > is never powered down.
>
> So how do we properly suspend/resume the device without help from platform firmware?

I guess you don't?

Alex


>
> Kai-Heng
>
> >
> > Alex
> >
> >>
> >> [1] https://patchwork.freedesktop.org/patch/335839/
> >>
> >> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >> ---
> >> drivers/gpu/drm/radeon/radeon_device.c | 3 +++
> >> 1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
> >> index 266e3cbbd09b..df823b9ad79f 100644
> >> --- a/drivers/gpu/drm/radeon/radeon_device.c
> >> +++ b/drivers/gpu/drm/radeon/radeon_device.c
> >> @@ -33,6 +33,7 @@
> >> #include <linux/slab.h>
> >> #include <linux/vga_switcheroo.h>
> >> #include <linux/vgaarb.h>
> >> +#include <linux/suspend.h>
> >>
> >> #include <drm/drm_cache.h>
> >> #include <drm/drm_crtc_helper.h>
> >> @@ -1643,6 +1644,8 @@ int radeon_suspend_kms(struct drm_device *dev, bool suspend,
> >>                rdev->asic->asic_reset(rdev, true);
> >>                pci_restore_state(dev->pdev);
> >>        } else if (suspend) {
> >> +               if (pm_suspend_no_platform())
> >> +                       rdev->asic->asic_reset(rdev, true);
> >>                /* Shut down the device */
> >>                pci_disable_device(dev->pdev);
> >>                pci_set_power_state(dev->pdev, PCI_D3hot);
> >> --
> >> 2.17.1
> >>
> >> _______________________________________________
> >> dri-devel mailing list
> >> dri-devel@lists.freedesktop.org
> >> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
