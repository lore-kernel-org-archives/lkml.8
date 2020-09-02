Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61370C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 00:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41216206F0
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 00:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgIBAjU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 20:39:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36596 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgIBAjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 20:39:19 -0400
Received: from mail-pf1-f198.google.com ([209.85.210.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kDGnz-0002GZ-2m
        for linux-kernel@vger.kernel.org; Wed, 02 Sep 2020 00:39:15 +0000
Received: by mail-pf1-f198.google.com with SMTP id b189so1685710pfa.16
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 17:39:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HapSh6J4ipleysnVKYsirTF50PzRq3WDVc1GsW3eoRw=;
        b=X0P109TPAEu+8VqoBFcy5wm9CKAGVn65daNqGkJCehP4xJFEW0/3yjuM+Eq57bM+EX
         VsCIYGsVn+7XhNbgzmyN5Fal3bVrqLmkoYfqlW2zOh2/X/XGeTHaPZUIGVKCjvkivGoS
         woyXt1fbfS++xpTGJaHZrAvmrAIMj24uecVyuTFYkHmwBCZN5WE42xPdcxCjdRIW4yk/
         nZ21/Eoo13zlC08tsCkJroAoxYw2NouAfID9K80vktj8cte4sfJD6yT5lwmMvefruP1G
         AiwVr4oY+AOT1oYr+Sfc0zg+g2THX+4rWtVZBMkSUBGYX22xbZiX5Yv8D77qcR4v+NDY
         PgbA==
X-Gm-Message-State: AOAM5317z9ioOMXxoGy9+0xDyZJQxfQhsmNF4E/e3TeKbCfCTSjXX4gv
        uMessWWDum1a1CyoeqZFzaFJDv1Z9T3Z0eNF9I98Lz6/QxTmXBr6dW0kcGTY1qNy6GHYVLi5Rzt
        n+UUOOCKpx8Y+ewwItTBUJdEQbeZwLDRSj5EBR9jBNA==
X-Received: by 2002:a62:7c09:: with SMTP id x9mr760351pfc.229.1599007153388;
        Tue, 01 Sep 2020 17:39:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwm3QapIMxS3NYIcgVW1Am2hXnQMWOVnVHjfdLckz4kXMEDFeOvPUT3ZkAuRXJdaw8qsl4Zgg==
X-Received: by 2002:a62:7c09:: with SMTP id x9mr760316pfc.229.1599007153014;
        Tue, 01 Sep 2020 17:39:13 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id u5sm3152827pfm.149.2020.09.01.17.39.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Sep 2020 17:39:12 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] drm/radeon: Reset ASIC if suspend is not managed by
 platform firmware
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CADnq5_PMLoL0Zkw8uB+noPJ0buO5aUavDrFGBhBp_GEz8+xBDA@mail.gmail.com>
Date:   Wed, 2 Sep 2020 08:39:09 +0800
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <D7166B38-F8AE-4603-9C7E-11620E1E8B60@canonical.com>
References: <20200901063227.6057-1-kai.heng.feng@canonical.com>
 <CADnq5_MXs-=BpMrYVudhHPjTpgs1XUE=GEujpp5AeYy5vWS=YA@mail.gmail.com>
 <3269C99F-2349-4004-8B5F-31A2297A5043@canonical.com>
 <CADnq5_PMLoL0Zkw8uB+noPJ0buO5aUavDrFGBhBp_GEz8+xBDA@mail.gmail.com>
To:     Alex Deucher <alexdeucher@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 2, 2020, at 00:30, Alex Deucher <alexdeucher@gmail.com> wrote:
> 
> On Tue, Sep 1, 2020 at 12:21 PM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>> 
>> 
>> 
>>> On Sep 1, 2020, at 22:19, Alex Deucher <alexdeucher@gmail.com> wrote:
>>> 
>>> On Tue, Sep 1, 2020 at 3:32 AM Kai-Heng Feng
>>> <kai.heng.feng@canonical.com> wrote:
>>>> 
>>>> Suspend with s2idle or by the following steps cause screen frozen:
>>>> # echo devices > /sys/power/pm_test
>>>> # echo freeze > /sys/power/mem
>>>> 
>>>> [  289.625461] [drm:uvd_v1_0_ib_test [radeon]] *ERROR* radeon: fence wait timed out.
>>>> [  289.625494] [drm:radeon_ib_ring_tests [radeon]] *ERROR* radeon: failed testing IB on ring 5 (-110).
>>>> 
>>>> The issue doesn't happen on traditional S3, probably because firmware or
>>>> hardware provides extra power management.
>>>> 
>>>> Inspired by Daniel Drake's patch [1] on amdgpu, using a similar approach
>>>> can fix the issue.
>>> 
>>> It doesn't actually fix the issue.  The device is never powered down
>>> so you are using more power than you would if you did not suspend in
>>> the first place.  The reset just works around the fact that the device
>>> is never powered down.
>> 
>> So how do we properly suspend/resume the device without help from platform firmware?
> 
> I guess you don't?

Unfortunate but I guess we need to accept reality and use the default suspend method.

Kai-Heng

> 
> Alex
> 
> 
>> 
>> Kai-Heng
>> 
>>> 
>>> Alex
>>> 
>>>> 
>>>> [1] https://patchwork.freedesktop.org/patch/335839/
>>>> 
>>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>> ---
>>>> drivers/gpu/drm/radeon/radeon_device.c | 3 +++
>>>> 1 file changed, 3 insertions(+)
>>>> 
>>>> diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
>>>> index 266e3cbbd09b..df823b9ad79f 100644
>>>> --- a/drivers/gpu/drm/radeon/radeon_device.c
>>>> +++ b/drivers/gpu/drm/radeon/radeon_device.c
>>>> @@ -33,6 +33,7 @@
>>>> #include <linux/slab.h>
>>>> #include <linux/vga_switcheroo.h>
>>>> #include <linux/vgaarb.h>
>>>> +#include <linux/suspend.h>
>>>> 
>>>> #include <drm/drm_cache.h>
>>>> #include <drm/drm_crtc_helper.h>
>>>> @@ -1643,6 +1644,8 @@ int radeon_suspend_kms(struct drm_device *dev, bool suspend,
>>>>               rdev->asic->asic_reset(rdev, true);
>>>>               pci_restore_state(dev->pdev);
>>>>       } else if (suspend) {
>>>> +               if (pm_suspend_no_platform())
>>>> +                       rdev->asic->asic_reset(rdev, true);
>>>>               /* Shut down the device */
>>>>               pci_disable_device(dev->pdev);
>>>>               pci_set_power_state(dev->pdev, PCI_D3hot);
>>>> --
>>>> 2.17.1
>>>> 
>>>> _______________________________________________
>>>> dri-devel mailing list
>>>> dri-devel@lists.freedesktop.org
>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>> 

