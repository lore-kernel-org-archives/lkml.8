Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2B9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB90B20724
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UDwsCRqV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391258AbgFXOp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 10:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389253AbgFXOp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 10:45:56 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B72C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 07:45:56 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id b15so1688707edy.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 07:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V6zGdXUAqtZ8TMJ1p/Ja4LOic56oWXGysX+nGE4qGOk=;
        b=UDwsCRqVx8pfOz08W/2ltgAZty0p1HIWOlxDs9wZvrc42865oOIHY6SxuI2wLxKSK4
         oX1qfEtOdm91IM9CbQ5mvylgn9KaJlFQafwX3iRPPyO10cQ/e0DDKvcdVFFjFnPCw6v+
         m0aztYbQKOtK/DNy4DXRqaeAzOAMX7wkrVtXSFUUSIXPNuFi3g2Xluz02EDJTGM1PVdo
         L3mlYBDLQHsEixw6Hwg0iGqWlyeVIwA6L0psHpwzAQuipMKp/9BStuN5A4XoXmbTmg+Y
         5p8/tYN4bjKWIt2LuHADfiTGe980AsUeFyyhbeuJ/eM+Y0rb7YzET0ARqw4MzChKo9st
         gRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V6zGdXUAqtZ8TMJ1p/Ja4LOic56oWXGysX+nGE4qGOk=;
        b=ZXXRENlhHzEbPVqf35QG/HJ7ObjE5ua7qxJHEKNBE2DmXdRR4n2ya9ktwQKyvWuEDw
         zyJMTd6oIDprZWawQqRCS6bP2dLnzWyV8wf6QgvhfLfMwXKUaduw5lqCCpKkgpNX6ec7
         G6v8pv5R8aG80Ui1FCg8XkJ+blNSLvD3xZDb4rP2U6FuNNbGgTMm5JeLU3GBKcKpgc9o
         5eSeYJ36NnOGDGqQLpc2DraSROPlSRzXqHM8Q45IYg7Mgv6xJeIt49sjsyR1kWzJBG4U
         UzITBG4qyvae1PNELPftG5gEwcBOH8OipI6Ih7rlPA/FWfv/ilRRlfY7TJHmI+NKA54D
         wYdA==
X-Gm-Message-State: AOAM533SrDITS4WuerBEKTL8/L+a5jszyO6+TP9iC8gq0HMPRgqwFTE4
        gcBlhUq3v/ZtKbk31MvqDroyTM4u+/XbKJoeY88H1g==
X-Google-Smtp-Source: ABdhPJwnXbWDY/gO5ncGRvDs4eTqLBVgcBQOPmSnBTcgFXDGWRsIjoHMLm/gVmNqWNiWnV8W/5Ahy7gdx/MLPcryIlg=
X-Received: by 2002:a05:6402:22f0:: with SMTP id dn16mr21977111edb.83.1593009954891;
 Wed, 24 Jun 2020 07:45:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200622100520.143622-1-darekm@google.com> <ca796f62-7d1f-3391-0373-ec9b98b1c47a@xs4all.nl>
 <CALFZZQHuqx+H=7pd9t=XYWqKppMzze0XsXwRVA5kLZfwWYLmKQ@mail.gmail.com>
In-Reply-To: <CALFZZQHuqx+H=7pd9t=XYWqKppMzze0XsXwRVA5kLZfwWYLmKQ@mail.gmail.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 24 Jun 2020 07:45:43 -0700
Message-ID: <CABXOdTfyzKtT4jWLhBwV5ecG1Bc2g88vUfKB6OspmF0mTafxpA@mail.gmail.com>
Subject: Re: [PATCH RESEND] media: cros-ec-cec: do not bail on
 device_init_wakeup failure
To:     Dariusz Marcinkiewicz <darekm@google.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Dariusz Marcinkiewicz <darekm@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 5:40 AM Dariusz Marcinkiewicz <darekm@google.com> wrote:
>
> Hello.
>
> I realized that I sent the previous answer using HTML, and as a
> consequence it was blocked from mailing lists. Sending it again
> (apologies for double posting).
>
> On Mon, Jun 22, 2020 at 12:23 PM Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:
> >
> > On 22/06/2020 12:05, Dariusz Marcinkiewicz wrote:
> > > Do not fail probing when device_init_wakeup fails.
> > >
> > > device_init_wakeup fails when the device is already enabled as wakeup
> > > device. Hence, the driver fails to probe the device if:
> > > - The device has already been enabled for wakeup (via e.g. sysfs)
> > > - The driver has been unloaded and is being loaded again.
> > >
> > > This goal of the patch is to fix the above cases.
> > >
> > > Overwhelming majority of the drivers do not check device_init_wakeup
> > > return value.
> > >
> > > Signed-off-by: Dariusz Marcinkiewicz <darekm@google.com>
> >
> > This can be CCed to stable, I guess?
> >
>
> That issue is not a recent regression but has been in there since the
> very beginning.  So it might be argued that is it not severe enough to
> warrant cc'ing stable. Happy to do that anyways if you think
> otherwise.
>

Confused. Internally you would like to have this patch applied to
chromeos-4.4. Here you suggest that it may not be important enough to
apply to stable releases. Which one is it ?

Thanks,
Guenter

> > Can you provide a Fixes: tag as well?
> >
>
> Done, submitted v2 with that a couple of days ago.
>
> Thank you and best regards.
