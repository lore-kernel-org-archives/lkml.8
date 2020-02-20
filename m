Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36177C11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 09:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E531224656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 09:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="T2mze/9r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgBTJoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 04:44:15 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:45914 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgBTJoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 04:44:15 -0500
Received: by mail-io1-f65.google.com with SMTP id i11so3906314ioi.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 01:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QT/bClfWBC0w+NUxOHZIftb3rGcPtYQdlmIKe6O0uis=;
        b=T2mze/9rr0qw8y10sXtQt5GIwP0JUitC+0q73XiYA0459VrkFjIrveX7AmBOsXZqwD
         pt5298wgoJgIcE0mbA9M0IJRFC1mPCXYHWHNirGepJZsoEl+rgIlCtYB1wMjMABj7guI
         6dzxO5kigNVc0rzJ4SGajLHf2Ef5y8u14FMNuPSnmaVAsMHcGuNoE9dCrcoJFfIpCetQ
         2vzLouv7+7mDnme9illrjqtCUeFHVCLfcYq0jybqM2fuNmllXZ2VvBysIvJSaLr1ySF+
         sc4bi3gurxpSBhALGTuwVMu7vR8jkhUy6IzmW015moUQfMTbnO8NZ9aLnms9Au2uNTI7
         fQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QT/bClfWBC0w+NUxOHZIftb3rGcPtYQdlmIKe6O0uis=;
        b=KpyyQPnxlV8GS96O6P44h6WV1fRzjgWiAKUNmpvZxY5Ig8Rv074V9aSmtu+bdDslFA
         i8De+kTnCi/fdKgkFpu4Sfjx6hlnIz8atPmMaVZB08XlZIfb8HLv/rbwI4lXqbP7cIto
         eL+3XFS1zTA/LuYIXWT2O4hX9iwDB9QrSYFx+/CHryYgXDzIG0xSDTiuvP5uAYtGpr8h
         vUtG1RuvMKSY9peu9Lwm1MDqjlKSW8cWbQy+RjxflWEjXmXwpPiNq+yri04EXiEw6b4E
         glhOPydoZwZdBVmOGo52QDBW9UBZsRPYSUsZ79jf3bsNKrCFQ54hZAluWKCnf77wI47Z
         1G+A==
X-Gm-Message-State: APjAAAWQ2ruv2tvr5A6iUoZYERxMqX0fLgx/R2BupOgMq3jiXh+hMIdI
        oKIIcqlhCdCXI2/koRZbSPpmi9IVMWXOuRwtc2Q4TRDJ
X-Google-Smtp-Source: APXvYqyeZ+JcrsXVpk+krPugyvcFamgoxUfJp7kz2mYgdin5zSv7hnhMtyQ8RfsgupCcLMHS5HNLbrCzFQwf9Pisjbs=
X-Received: by 2002:a05:6602:1483:: with SMTP id a3mr23929934iow.229.1582191854151;
 Thu, 20 Feb 2020 01:44:14 -0800 (PST)
MIME-Version: 1.0
References: <20200217153145.13780-1-james.hughes@raspberrypi.com> <CADaigPXfS4o-QQVPsp1axNz+hAATJqA-vzupC0VRWceJNEZNEg@mail.gmail.com>
In-Reply-To: <CADaigPXfS4o-QQVPsp1axNz+hAATJqA-vzupC0VRWceJNEZNEg@mail.gmail.com>
From:   James Hughes <james.hughes@raspberrypi.com>
Date:   Thu, 20 Feb 2020 09:44:03 +0000
Message-ID: <CAJ+9seGY3owufzm4WZwTQXQA9BonyamCCWCrazA3bukEkGixug@mail.gmail.com>
Subject: Re: [PATCH] GPU: DRM: VC4/V3D Replace wait_for macros in to remove
 use of msleep
To:     Eric Anholt <eric@anholt.net>
Cc:     David Airlie <airlied@linux.ie>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2020 at 22:51, Eric Anholt <eric@anholt.net> wrote:
>
> On Mon, Feb 17, 2020 at 7:41 AM James Hughes
> <james.hughes@raspberrypi.com> wrote:
> >
> > The wait_for macro's for Broadcom VC4 and V3D drivers used msleep
> > which is inappropriate due to its inaccuracy at low values (minimum
> > wait time is about 30ms on the Raspberry Pi).
> >
> > This patch replaces the macro with the one from the Intel i915 version
> > which uses usleep_range to provide more accurate waits.
> >
> > Signed-off-by: James Hughes <james.hughes@raspberrypi.com>
>
> To apply this, we're going to want to split the patch up between v3d
> (with a fixes tag to the introduction of the driver, since it's a
> pretty critical fix) and vc4 (where it's used in KMS, and we're pretty
> sure we want it but changing timing like this in KMS paths is risky so
> we don't want to backport to stable).  And adjust the commit messages
> to have consistent prefixes to the rest of the commits to those
> drivers.
>
> I've been fighting with the drm maintainer tools today to try to apply
> the patch, with no luck.   I'll keep trying, and if I succeed, I'll
> push it.

Hi Eric,

unclear whether you want me to do the split or whether you are going
to (your last paragraph). Also I'm a bit unclear on the exact
requirements for the prefixes etc.

James
