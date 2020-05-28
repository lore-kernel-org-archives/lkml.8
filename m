Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83EFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 21:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93ADD206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 21:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ROLiHp2N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436564AbgE1VTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 17:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436543AbgE1VTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 17:19:00 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DC1C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 14:18:59 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id j145so535848oib.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 14:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Izclf3iWwhuBdj+AyqDZNTKQPIM/hg7SPWZBXMGL2l4=;
        b=ROLiHp2NjSvrFpWBfBWNkFIDKRaTw9ZwEIv+rl38brz1x9SCCDtn5e1RlEBtjEbFZE
         8GbOXVqoaw/jfLpOyutnvB1Vtg1kI4KkiSxcEB0nJlQ1YzdNxY8wBeMzoptY69RnBF9R
         zRmov/xazXgAZIvXC3pR/25/mrcdA/LsxRSltp4WwzgqZDX9bc924CIqE8FVXfAVgzQv
         st2eP5qhP7X3OwNP3dWdsTVGgC0GWmj6uaseeOnJolw6IK0M4cTSbpi3FZ1uUU6oxA57
         BxnKzvFqPeZm6DPURVfEPrVCoQxTXLesY6dO85z8dEdse9zEAYtFQ5F/z1rxXHEuY+2r
         YZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Izclf3iWwhuBdj+AyqDZNTKQPIM/hg7SPWZBXMGL2l4=;
        b=s9Ep/iqXMOwRiichmUl3g6BrwDMoJSTKg2KzaaFOBd6FTjpoSf8REcVzUGkEzYVEEA
         QZ44OkqEWEFSL3q0Ejje70OHQBHIpo1EuaJNEuaLc2MmN6oK93f7zBJIZYYf1Q0A9EAs
         OeO5oYM8MZ8jjH5uuqdx43xa2noh929H5SzOGSXp7QulXhI/pCozHH2o6HvwKF+0kUqo
         1pXMu5Ka6AFgaB1d6fK++eoAEzu91oz7iqoSFF9/bwmV13KD1zjwgLlcHrOQNAoo3qdq
         EVxpxwO+NOLTlpuHSrEw88Ti1QAvsmPsSsTlaobc0Kyiy3oXr3C0CUb/C/OukFLHKFRm
         p0Xg==
X-Gm-Message-State: AOAM530sXCpmPcgoEqobWON7YIZNAVOiGpQIcr1J9hwt9bHEHCInU53Q
        zW0TiX7AEczEZEiRhSW9PF7Vri+rDLMZa0dTB9thlQ==
X-Google-Smtp-Source: ABdhPJyw7U2WT9n/sOygpPecLN3RFPOU9iX8N0Q+3xHWo4rHkDHqt8y0wR3uXmA498b8tKy12JJDyucNnaHpuYSyklI=
X-Received: by 2002:aca:d0d:: with SMTP id 13mr3586541oin.172.1590700739034;
 Thu, 28 May 2020 14:18:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200521191800.136035-1-saravanak@google.com>
In-Reply-To: <20200521191800.136035-1-saravanak@google.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 28 May 2020 14:18:23 -0700
Message-ID: <CAGETcx8UGps6bz1YhYcbjCAAXenBuR6XDT0qv5WED5zbyfzNFw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] driver core: Add device link related sysfs files
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 12:18 PM Saravana Kannan <saravanak@google.com> wrote:
>
> With fw_devlink and with sync_state() callback features, there's a lot
> of device/device link related information that's not available in sysfs.
>
> Exposing these details to user space can be very useful in understanding
> suspend/resume issues, runtime pm issues, probing issues, figuring out
> the modules that'd be needed for first stage init, etc. In fact, an
> earlier verion of this series was very helpful in debugging and
> validating the recent memory leak fix[1].
>
> This series is based on driver-core-next and [1] cherry-picked on top of
> it.
>
> [1] - https://lore.kernel.org/lkml/20200519063000.128819-1-saravanak@google.com/
>
> v1->v2:
> Patch 1/4
> - New patch
> Patch 2/4
> - Fixed the warnings I saw before that were related to incorrect
>   sysfs removal code when a device link is deleted.
> - Fixed error handling in device_link_add()
> - Split up flags into more meaningful files.
> - Added status file.
> Patch 3/4
> - Fixed error handling that Greg pointed out before.
> Patch 4/4
> - New patch
>
> v2->v3:
> - Dropped patch 1/4 from v2 since it was already picked up. So numbering
>   has shifted.
> Patch 1/3
> - Added documentation
>
> Saravana Kannan (3):
>   driver core: Expose device link details in sysfs
>   driver core: Add state_synced sysfs file for devices that support it
>   driver core: Add waiting_for_supplier sysfs file for devices
>
>  Documentation/ABI/testing/sysfs-class-devlink | 126 ++++++++++
>  .../ABI/testing/sysfs-devices-consumer        |   8 +
>  .../ABI/testing/sysfs-devices-state_synced    |  24 ++
>  .../ABI/testing/sysfs-devices-supplier        |   8 +
>  .../sysfs-devices-waiting_for_supplier        |  17 ++
>  drivers/base/core.c                           | 237 +++++++++++++++++-
>  drivers/base/dd.c                             |  22 ++
>  include/linux/device.h                        |  58 ++---
>  8 files changed, 464 insertions(+), 36 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-devlink
>  create mode 100644 Documentation/ABI/testing/sysfs-devices-consumer
>  create mode 100644 Documentation/ABI/testing/sysfs-devices-state_synced
>  create mode 100644 Documentation/ABI/testing/sysfs-devices-supplier
>  create mode 100644 Documentation/ABI/testing/sysfs-devices-waiting_for_supplier

Friendly reminder.

-Saravana
