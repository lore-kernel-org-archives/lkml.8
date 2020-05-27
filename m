Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9501FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6770920899
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M+wxS5HR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbgE0RR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 13:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729534AbgE0RR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 13:17:58 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBB0C03E97D
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 10:17:58 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id r67so1422207oih.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 10:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IDLjVr5h7wxOvNCqeSpGg/VjHN6mMplZ0hDzgjqf8UM=;
        b=M+wxS5HRgoA/RJ6vqtHJLDqgrYDoOCrTEqtmWY1GZOqu72llBRdAJvY3+T6KMdROaE
         a6Stb4D4JxEcQHDmY5o+FT0VJNFwllZToT6gBQ9jNLXQfWzr1Vfpve9zgu495Ma8x2xS
         AauNeYV1pAe3og+nLRpkFf6uyJAN4tq09jvLH/mpDYoweo72RQ7FeFBjP6JWo4zRIgha
         cmBdILGwDJnooPmol0vF3dWWYjNspDQGveixWvKDAf6JizM61Ou1aDmEqafC+tuBiyyl
         ahDCdkIwGY5rZqVac7H11vDYCRq8HYJ5YviogC3g4rXa4bodebIzgVNrZkKhn/s1p0gc
         aDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IDLjVr5h7wxOvNCqeSpGg/VjHN6mMplZ0hDzgjqf8UM=;
        b=qixnnqgrNbpLmCv2S7GQ8TTMR7wL+emXzTAxqkzTmKu+kzRhRDRarRRDFIIrEZVl7c
         1gdHGoH11nvB9xF8zH+oHxQ/Cn+Ao1FY3Od0f/dF2H8SyzVODm5Q8k/VpUPc2ydTxiFz
         oSVGnbSnLPGm6cOoa7CRc+zzHrA2uUO9vHuOgqG2s92ySA/DpHXzQIMi4U9fZZKZIpWA
         S22rBHLUIr4y7m6j2NHw7TOmu5mM0Qt4ffUll6Wo6YA071hxTQrHf4RS4lguE6WpazKk
         8uE/k5OlziZ/iKGSMYLcLLCQ5qyt45KPcZiJCji+pwGF6C2PSEmVTq+MvB9FV+sQrLT8
         M6Nw==
X-Gm-Message-State: AOAM531Xhz2Dfu5tpJkw4ZAHAQT7jpm2ixYt7D5pyiEA2VqhToWLFtuO
        vI/zeT5Ugorq6n2+eXBfdsAEZb8uJ0GJXH/Z/Q2N7A==
X-Google-Smtp-Source: ABdhPJwYDtDi8WDqKNYvp5HXrIgZwtIZlRlj+xIecITA6Jlo060V1TLlP01dUYxvmzMKuIn3Us6jRZCV47b2kzHK0Qg=
X-Received: by 2002:a05:6808:5d5:: with SMTP id d21mr3466536oij.30.1590599877334;
 Wed, 27 May 2020 10:17:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200527074057.246606-1-saravanak@google.com> <20200527111750.GB5308@sirena.org.uk>
In-Reply-To: <20200527111750.GB5308@sirena.org.uk>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 27 May 2020 10:17:21 -0700
Message-ID: <CAGETcx_Hr75W7VJT-2CnS=VVCW+B4ktv=4vdVQoxkhP4TAPF6Q@mail.gmail.com>
Subject: Re: [PATCH v1] regulator: Add support for sync_state() callbacks
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 4:17 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, May 27, 2020 at 12:40:56AM -0700, Saravana Kannan wrote:
>
> > When a regulator is left on by the bootloader or anything else before
> > the kernel starts (let's call this a "boot on" regulator), we need to
> > keep it on till all the consumers of the regulator have probed. This is
>
> No, we don't.  As ever we have no idea if there ever will be consumers -
> we don't know what drivers the system is going to load, we don't know
> what the intentions of the OS and system integration are and we have
> zero idea why the system is in the state it's in.

Ok, so not knowing if there'll ever be consumers, drivers, etc is the
issue. But that doesn't mean we don't have to keep the regulators on
till all the consumers in the system that need it have probed. So,
let's solve that problem instead? Because the hardware clearly fails
to boot properly without keeping the regulators on.

Let me try to walk through your concerns and some potential solutions.
If fw_devlink is off or not supported by the firmware (Eg: ACPI), the
behavior doesn't change. We act as if there are no consumers and turn
stuff off 30s after late_initcall_sync(). If fw_devlink is on, then it
makes sure all the consumers (in DT) are linked to the regulator
device as soon as it is added. So that solves your "we don't know if
there'll ever be consumers".

The next concern is, "will the drivers ever be loaded for these
consumers". To handle these cases, I can update the "30s timeout code"
to just release all the "hold state". And I can make the time out a
kernel command line param that if set to 0, then it will actually wait
for all the consumers.

Does that seem like something that'd work for you? That way, if no one
sets this command line param, it won't affect them. And if they set
it, then things work as intended when the system is configured so that
everything does eventually come up.

> > This commit adds a regulator_sync_state() helper function that takes
> > care of all the "boot on" regulator clean up for any regulator driver.
> > All one needs to do is add the following line to the driver struct.
>
> None of the issues around this have *anything* to do with individual
> drivers,

Fair enough. I was just trying to give a way for systems that don't
have the "consumers might never come up" issue (Eg: Android phones) a
way to start using this while we try to figure out what to do for the
systems where it might be a problem.

> all this is doing is forcing us to go through and add this to
> every single driver which doesn't accomplish anything.

I don't see what's wrong with that. The kernel has made plenty of
changes where all the drivers using an API had to be updated in one
shot. This patch doesn't even require a one shot change. Anyway, if
you want to "blanket" do this for every regulator driver, then we can
just set the device's driver.sync_state() when it registers a
regulator and if it isn't already set.

> Regulator
> drivers have no role in this, they don't set policy, so there is no
> reason why they should be aware of any of this.

Agree.

> Please go and look at the previous discussions of this topic, this needs
> to work for other users as well.

I'd be happy to, if you can point me to some of them. Sorry, I didn't
know what to even search for to get a meaningful list of search
results.

Thanks,
Saravana
