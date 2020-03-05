Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CACFC3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 06:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011D220726
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 06:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=anholt-net.20150623.gappssmtp.com header.i=@anholt-net.20150623.gappssmtp.com header.b="gTA2qM38"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgCEGVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 01:21:12 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37947 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgCEGVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 01:21:12 -0500
Received: by mail-lj1-f194.google.com with SMTP id w1so4722847ljh.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 22:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anholt-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PEmhObW/jpADaANqPhkfSckuY3+qAcewjBs0fek5zKc=;
        b=gTA2qM38DxWUoV6HAHoHMGwWShAl0vDPQEcHnQS/KXrKpZo2uVuk5SB0r+UgtYi21j
         W0hTTcDDrl/c9DECGmtDjh0xFtI2NtkqpFpZtCGVCJ0TYuXKXojyk1KS/unGVCLQfjpM
         wUYCNuQS8Ylkz3QT9ip1AEe/N21TrOiUsrSwusufbkcUAoBG3K6m8HHxDer/P6C7hGUm
         6YkPQjybUF1CuEtBxtsXjdSc6u31f5YbQVDXls9bAV947fo9Eqpko43D5LN7FmVr22Or
         prdngeHQ8wVR1GAhx9CeTqDDtZRzwahlKD/cSGAa3fDlgxRNvb5sJqSqM+7pyBgfS+Dr
         MDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PEmhObW/jpADaANqPhkfSckuY3+qAcewjBs0fek5zKc=;
        b=LCng6npU5GU3RnaLmPr/yLiRT0JTqrbZr3zcGrGpKgZGbbL1mN3UgtP1DTLkUX3W1a
         eHraaG5crfr0FyXeaN6gBVxbgli8TZWObE1YDXQiJn2uMLIt4AXYZe/mYn+bii0bzAOv
         HZs6GFD2T3wGAmJLrrs7qlnUQDDUQ2vwN2fI1Hq3EhVGBoOdPtVZ57wzvwetDwkAPW25
         cusnXqovbw8TZsfvulTwQQg12/w+cSn+9W3hQ1Oehm6YBq4coNAXeuV/N7zM2bvvGS6E
         VZB1GsAIMgj0/C1/Qu3GBBzQ1A6bzHT/no+kB/JiLZuyFlZVPwUFp0DXHds/XuLeFCqL
         n84g==
X-Gm-Message-State: ANhLgQ3LofQBE/w8oXYvSXkl264lXKg3EF+OVLMJp7BXCQR+2LA/wBf8
        NkVyJU1SnprM5e1m6XLZ3lIFVG9QMot+7up0ftUUU7uGrH0=
X-Google-Smtp-Source: ADFU+vu96kevqcEYi2C+kn6iYIEElBuzdXVKXs5nkqdXBqnm2BMBsmPM2ZssqC/Rzj9FOOhuzflrqynM0Gtha43D4ZU=
X-Received: by 2002:a2e:9094:: with SMTP id l20mr3931274ljg.131.1583389270542;
 Wed, 04 Mar 2020 22:21:10 -0800 (PST)
MIME-Version: 1.0
References: <20200217153145.13780-1-james.hughes@raspberrypi.com>
 <CADaigPXfS4o-QQVPsp1axNz+hAATJqA-vzupC0VRWceJNEZNEg@mail.gmail.com> <CAJ+9seGY3owufzm4WZwTQXQA9BonyamCCWCrazA3bukEkGixug@mail.gmail.com>
In-Reply-To: <CAJ+9seGY3owufzm4WZwTQXQA9BonyamCCWCrazA3bukEkGixug@mail.gmail.com>
From:   Eric Anholt <eric@anholt.net>
Date:   Wed, 4 Mar 2020 22:20:59 -0800
Message-ID: <CADaigPWWMaX0fCMofoLFKHCWRyHunfp8y=YMwgxYKDOkCUQKFA@mail.gmail.com>
Subject: Re: [PATCH] GPU: DRM: VC4/V3D Replace wait_for macros in to remove
 use of msleep
To:     James Hughes <james.hughes@raspberrypi.com>
Cc:     David Airlie <airlied@linux.ie>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 1:44 AM James Hughes
<james.hughes@raspberrypi.com> wrote:
>
> On Wed, 19 Feb 2020 at 22:51, Eric Anholt <eric@anholt.net> wrote:
> >
> > On Mon, Feb 17, 2020 at 7:41 AM James Hughes
> > <james.hughes@raspberrypi.com> wrote:
> > >
> > > The wait_for macro's for Broadcom VC4 and V3D drivers used msleep
> > > which is inappropriate due to its inaccuracy at low values (minimum
> > > wait time is about 30ms on the Raspberry Pi).
> > >
> > > This patch replaces the macro with the one from the Intel i915 version
> > > which uses usleep_range to provide more accurate waits.
> > >
> > > Signed-off-by: James Hughes <james.hughes@raspberrypi.com>
> >
> > To apply this, we're going to want to split the patch up between v3d
> > (with a fixes tag to the introduction of the driver, since it's a
> > pretty critical fix) and vc4 (where it's used in KMS, and we're pretty
> > sure we want it but changing timing like this in KMS paths is risky so
> > we don't want to backport to stable).  And adjust the commit messages
> > to have consistent prefixes to the rest of the commits to those
> > drivers.
> >
> > I've been fighting with the drm maintainer tools today to try to apply
> > the patch, with no luck.   I'll keep trying, and if I succeed, I'll
> > push it.
>
> Hi Eric,
>
> unclear whether you want me to do the split or whether you are going
> to (your last paragraph). Also I'm a bit unclear on the exact
> requirements for the prefixes etc.

I debugged what was going on with my maintainer tools and got the
patches applied:

https://cgit.freedesktop.org/drm/drm-misc/commit/?id=9daee6141cc9c75b09659b02b1cb9eeb2f5e16cc
https://cgit.freedesktop.org/drm/drm-misc/commit/?id=7f2a09ecf2e8d86e22598dfb879db48e72c5a40e

Apologies for the wait!  I've fixed some mail filters I think so I
should notice pings like this in the future.  But also I hope Maxime
can feel enabled to merge patches to vc4/v3d in the future -- I
certainly don't want to be the limiting factor here, and it's under
drm-misc so any drm-misc maintainer can apply stuff.
