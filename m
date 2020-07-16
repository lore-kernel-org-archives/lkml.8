Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53424C433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 18:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29B2E2074B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 18:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ckUVbs1S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbgGPS0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 14:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbgGPS0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 14:26:44 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9E3C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 11:26:44 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id o1so4238517plk.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 11:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u7RPi0dZoxrinhSex63VGQU/jKFhdDJaMRbmZIfUlH4=;
        b=ckUVbs1SYKKOQol/tE9tRtc5oeTZih4Ff7NQoYGxW6jbLLmwjnSe47n+jGbAGH33+4
         mLqUdJ5ThOXmrJD+8wOd8bzXrL7Ws0PPETbndzpliyoDhBC/g/QxB6PtAVy21rUR6HJP
         bsqEE74MRfeGMbMd8xduK2QqKHILoswzoxGtQy/TN6q8mzqPrr/Ei1kza0bAlAeuajm9
         nPz+jgnAYVIBol7r7YAFKi86TwacSkjbN+fhwVDNSg2r2Gq6WgnxpNyLx1JoeAhMwEdd
         PR+K/ce/b4OY1w8P3z3h4IS8DN82o/18LJbH11Z2h87JJ31AJZlzCID2c/N6A0VUsVy9
         1LFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u7RPi0dZoxrinhSex63VGQU/jKFhdDJaMRbmZIfUlH4=;
        b=jQ7ns0UIxVK0ABB096hwIzs3S93MgioS3IxxSA6Nx3Ctlg2G2pofHxcW0lT139/1md
         EHHsH+pboFn8qqOl8n1hojBtjE6hKAsMpmPz8vWkYRFQi1fyqT2E3xxJXIlHFELYbSdC
         qYv5LuA++RdLWHDszZLC9WhjXZYkp0WlWO1udJwj99p1IwRERgT9bAhAHfSI00+47qo1
         7GQNyrvAkpWIdU8K9kCDTOX2BLFuvP1ZEz2UCtzdXVSuoS4W20E2zv1XN+KD5mQSAaWR
         Z/h7PU+OTF/2pB/jZuc2enquCuA3qeeVbsDs6FPms5cFKYrdCpjSGyk/diOpp39BL2sz
         3y+A==
X-Gm-Message-State: AOAM5312MYqAWuPYmmPdLTg1h852MaQNkrbZ7cPayb2hxUzu27vaViyz
        +HZpqMsHQf0ksOlRHaBv094EFRn/8otaCcHdPvo3zw==
X-Google-Smtp-Source: ABdhPJzphgbYsjBbvOEjKOBoX4CycazX4k0q+zhWxgzOW4hYyQqYRt/zeen1wGSQbjTtoL2K8TJtDSD4hUyptEaPCfs=
X-Received: by 2002:a17:90b:3683:: with SMTP id mj3mr6164614pjb.91.1594924003399;
 Thu, 16 Jul 2020 11:26:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200716050846.2047110-1-saravanak@google.com>
 <CGME20200716053024eucas1p1fc9f469ce40472554cf377e4cd12e1d2@eucas1p1.samsung.com>
 <e3f4469e-8467-1736-8a39-6539b9f542af@roeck-us.net> <99bf8e73-1daa-34b8-ca7e-093a44fdba9b@samsung.com>
In-Reply-To: <99bf8e73-1daa-34b8-ca7e-093a44fdba9b@samsung.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 16 Jul 2020 11:26:07 -0700
Message-ID: <CAGETcx9cLdhSWb9zVRrOrqAA2kN+9i3YcuNGmSHVjW3CNZdJhA@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Fix scheduling while atomic warnings
 during device link deletion
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 10:48 PM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Hi
>
> On 16.07.2020 07:30, Guenter Roeck wrote:
> > On 7/15/20 10:08 PM, Saravana Kannan wrote:
> >> Marek and Guenter reported that commit 287905e68dd2 ("driver core:
> >> Expose device link details in sysfs") caused sleeping/scheduling while
> >> atomic warnings.
> >>
> >> BUG: sleeping function called from invalid context at kernel/locking/mutex.c:935
> >> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 12, name: kworker/0:1
> >> 2 locks held by kworker/0:1/12:
> >>    #0: ee8074a8 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: process_one_work+0x174/0x7dc
> >>    #1: ee921f20 ((work_completion)(&sdp->work)){+.+.}-{0:0}, at: process_one_work+0x174/0x7dc
> >> Preemption disabled at:
> >> [<c01b10f0>] srcu_invoke_callbacks+0xc0/0x154
> >> ----- 8< ----- SNIP
> >> [<c064590c>] (device_del) from [<c0645c9c>] (device_unregister+0x24/0x64)
> >> [<c0645c9c>] (device_unregister) from [<c01b10fc>] (srcu_invoke_callbacks+0xcc/0x154)
> >> [<c01b10fc>] (srcu_invoke_callbacks) from [<c01493c4>] (process_one_work+0x234/0x7dc)
> >> [<c01493c4>] (process_one_work) from [<c01499b0>] (worker_thread+0x44/0x51c)
> >> [<c01499b0>] (worker_thread) from [<c0150bf4>] (kthread+0x158/0x1a0)
> >> [<c0150bf4>] (kthread) from [<c0100114>] (ret_from_fork+0x14/0x20)
> >> Exception stack(0xee921fb0 to 0xee921ff8)
> >>
> >> This was caused by the device link device being released in the context
> >> of srcu_invoke_callbacks().  There is no need to wait till the RCU
> >> callback to release the device link device.  So release the device
> >> earlier and revert the RCU callback code to what it was before
> >> commit 287905e68dd2 ("driver core: Expose device link details in sysfs")
> >>
> >> Fixes: 287905e68dd2 ("driver core: Expose device link details in sysfs")
> >> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >> Reported-by: Guenter Roeck <linux@roeck-us.net>
> >> Signed-off-by: Saravana Kannan <saravanak@google.com>
> >> ---
> >> Marek and Guenter,
> >>
> >> It haven't had a chance to test this yet. Can one of you please test it
> >> and confirm it fixes the issue?
> >>
> > With this patch applied, the original warning is gone, but I get lots
> > of other warnings.
> >
> > WARNING: CPU: 0 PID: 1 at drivers/base/core.c:1790 device_release+0x94/0xa4^M
> > Device 'regulators:regulator@0:50038000.ethernet' does not have a release() function, it is broken and must be fixed.
> >
> > WARNING: CPU: 0 PID: 1 at drivers/base/core.c:1790 device_release+0x94/0xa4
> > Device '53f9c000.gpio:50038000.ethernet' does not have a release() function, it is broken and must be fixed.
> >
> > WARNING: CPU: 0 PID: 1 at drivers/base/core.c:1790 device_release+0x94/0xa4^M
> > Device '50030000.tscadc:50030400.tcq' does not have a release() function, it is broken and must be fixed.
>
> I confirm that I also get such warnings for every platform device in the
> system with this patch applied to linux next-20200715:

Sigh... I should refrain from late night coding. I'll send a fix in a few hours.

-Saravana
