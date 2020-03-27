Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F87C2D0ED
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 16:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFE6A20675
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 16:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9zjbZDu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgC0QRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 12:17:08 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36140 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbgC0QRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 12:17:07 -0400
Received: by mail-ed1-f67.google.com with SMTP id i7so6930218edq.3;
        Fri, 27 Mar 2020 09:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bhwCLD99THloN8dCbGNfgSTq5wDx5PYUGJHnnh+sr0s=;
        b=W9zjbZDuHcCXzsT5Gpy0NgsGp0UPXuI9jopRCIueqai8LTcuZTMbscs1+ZYXCOUB9S
         unaTG6d5+l3w6zwUaepGSZM5//sy9Ml8qbaXMKCzw3Bvuy/wvdIxVr7VkLM2ny96mfew
         BX++H56uAmBxEwDft7uV6q/rqC6yDL8IAQ6xXWsmSrnzvNwn7lUzLTSTtH1iyRBCyD98
         WUMqiAFJ32jiI6omQok5qXuXsoUnoQwdY9OUFu0RVdlRga7r1A9o6duNRTBz4MVZWuds
         iHEgEd1n5a13NUE48zkaZtQo8ggUv691sYn2u53dJmNmrldzWKN47s7pD9oq3jvCr3Gz
         Jl2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bhwCLD99THloN8dCbGNfgSTq5wDx5PYUGJHnnh+sr0s=;
        b=IQYCYpjg1lGtuYlxZFdF71pJ3oC9dszKaa9C+DGSOpbS9IJwahOohhViSjMWODmpo4
         0W7xqbWfHqmbwLvSrqPi6AfFURRu+bLn+w6l1F+vg7ubmCKWFBshc7r+MJd5vRzy9fkN
         VVDofhNnpCY/sK0qBpCITCF+cbiMrj/BaM12Mh/KE1f6L6mndjF7idbv8bLXJXagLhtn
         uqVlyLn89W/CenmJgXOM1FCeIjWQaugbUdnEKCDeI8nUNckr1sOwuhlgeL+2pGHcTYA8
         VXdycmzqrZQWdda3x6HEUKIiJokW+RYYCohPMko76PO/7F7ANn52EEZLgAoaUw9jfZ/F
         XLTQ==
X-Gm-Message-State: ANhLgQ0dDvDEgVlHZ/VRw/qRxNVBx0V6LxjmhW0Si4kitX5jnnezC+rb
        l91hoIhETca8xCeH9xBomU1RgNC8d7u0UlXuMKCdOw==
X-Google-Smtp-Source: ADFU+vvZ+s+3+GJf+hwaZ3hW3JamirY1OAA+vKuZrKrhYuxc/pgFwbRhyyFNqRxoAKf7w6JsLpe+Tfrb428/As9gqC0=
X-Received: by 2002:a50:d712:: with SMTP id t18mr13743363edi.151.1585325825642;
 Fri, 27 Mar 2020 09:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200327132852.10352-1-saiprakash.ranjan@codeaurora.org>
 <0023bc68-45fb-4e80-00c8-01fd0369243f@arm.com> <37db9a4d524aa4d7529ae47a8065c9e0@codeaurora.org>
In-Reply-To: <37db9a4d524aa4d7529ae47a8065c9e0@codeaurora.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 27 Mar 2020 09:17:03 -0700
Message-ID: <CAF6AEGtWqaGf1m_ew=iSQG2cX0_tV=W_7DwKRkTJUWJaParsvw@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu: Demote error messages to debug in
 shutdown callback
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 8:10 AM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Hi Robin,
>
> Thanks for taking a look at this.
>
> On 2020-03-27 19:42, Robin Murphy wrote:
> > On 2020-03-27 1:28 pm, Sai Prakash Ranjan wrote:
> >> Currently on reboot/shutdown, the following messages are
> >> displayed on the console as error messages before the
> >> system reboots/shutdown.
> >>
> >> On SC7180:
> >>
> >>    arm-smmu 15000000.iommu: removing device with active domains!
> >>    arm-smmu 5040000.iommu: removing device with active domains!
> >>
> >> Demote the log level to debug since it does not offer much
> >> help in identifying/fixing any issue as the system is anyways
> >> going down and reduce spamming the kernel log.
> >
> > I've gone back and forth on this pretty much ever since we added the
> > shutdown hook - on the other hand, if any devices *are* still running
> > in those domains at this point, then once we turn off the SMMU and let
> > those IOVAs go out on the bus as physical addresses, all manner of
> > weirdness may ensue. Thus there is an argument for *some* indication
> > that this may happen, although IMO it could be downgraded to at least
> > dev_warn().
> >
>
> Any pointers to the weirdness here after SMMU is turned off?
> Because if we look at the call sites, device_shutdown is called
> from kernel_restart_prepare or kernel_shutdown_prepare which would
> mean system is going down anyways, so do we really care about these
> error messages or warnings from SMMU?
>
>   arm_smmu_device_shutdown
>    platform_drv_shutdown
>     device_shutdown
>      kernel_restart_prepare
>       kernel_restart
>

I'd guess that drm/msm is not detaching all of it's UNMANAGED domains
in shutdown.  Although *presumably* the device_link stuff would
prevent the SMMU from shutting down while gpu/display is still active?
 If not I think we have bigger problems.

I hadn't really noticed the error msgs before, not sure if that is
just because the screen is off by the time they happen or if they are
a new warning..

BR,
-R
