Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419EBC433FB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F08E212CC
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mst7gel3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgGPXJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 19:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbgGPXJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 19:09:18 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC9FC08C5DC
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 15:17:32 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x72so4352607pfc.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 15:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fKhPiYD9NcrQRpGcdGZj40gj8kQ14shj2rOSqaCnLy8=;
        b=Mst7gel3VBVQzOLyDQc4MiMlTFuTEiShGv3qqgOuhaXUyMGeV4zTgdVmkOgMTj9gKQ
         z2iOtKgtrQZxHToj4Qz1Q0faDBqYksccsEsRKj8z8QIKGVF0mNdJd6qZSNIfI7xcqeA2
         v+DmOEuHmIEMAQVHk4i6Lb8RS5iL58W8azgnQssZ2Lz578yN7dZZRWayMfLPgqFzhe7m
         lPI3FC0itrcx/3rQgT/Qn1wwGjVH6H8Qq094WgUNOTwF/AP0DIO+pCtocpLliGfy2kr+
         Ipq7GN/NuNUe8At/AHKbHMBRGyzr2/wykc43zU8dDXEQ3n/giOipL/YtkEEg4U5tSzw8
         D87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fKhPiYD9NcrQRpGcdGZj40gj8kQ14shj2rOSqaCnLy8=;
        b=N3flK1R2E3fxYxMIpPhSbz3AnRoE35kmORrJKms65PEWDx8byLjNekyNmcNBHlWQA1
         TCTulhQaveHiGZkPHT+exHzLY6K9mPPUCk/3tgTSDWZjJFS3i+lLFNCfdXtTHCXbLuId
         uHeiuLnrcSOW/pZWZmYizxb2y/ZRI7zKbOHD/iJLoMFao3zNLYEWDF+3ZPBLbuBTk7TO
         JWs6KrS7w6WWs9dBH2IUB9p0IrH4NGFYhkB0SkfFhVjk2ItM/JBtvDwJ/jmY35y0o/qG
         t8oCHXkfD/c38F8X+zQP56argkUf4aQJXcfCNBFzWawWalSpaiM5rQoh319C2JTBP66c
         TGeg==
X-Gm-Message-State: AOAM533VIEfI7AqwPykRlU0XnvrnmspMXrC5oshBXe/zb5ulIC5fddQI
        5mSz6rWEO3qLXVE+JZIOP84+X+myjFPOF7fgI6d/Og==
X-Google-Smtp-Source: ABdhPJyB1S2SygSzhySIsQA8wZTB5mqkgjWM0X235I1SrN5gy+5Lds4v98EN7Jiyscyi/bmY8Sy6UyuNhQdcc0ETlHQ=
X-Received: by 2002:a62:8c54:: with SMTP id m81mr5296241pfd.215.1594937851949;
 Thu, 16 Jul 2020 15:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200716214531eucas1p2c173df09a6e00ef15dfae43ce8f1f9cd@eucas1p2.samsung.com>
 <20200716214523.2924704-1-saravanak@google.com> <6b37125c-96f5-c59c-f170-934d68c9bed1@samsung.com>
In-Reply-To: <6b37125c-96f5-c59c-f170-934d68c9bed1@samsung.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 16 Jul 2020 15:16:55 -0700
Message-ID: <CAGETcx_Zyj2sVrT3H9W5gnnBDRa9HMXde3vSXNKvnEDzN4_05A@mail.gmail.com>
Subject: Re: [PATCH v2] driver core: Fix sleeping in invalid context during
 device link deletion
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 3:13 PM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Hi Saravana,
>
> On 16.07.2020 23:45, Saravana Kannan wrote:
> > Marek and Guenter reported that commit 287905e68dd2 ("driver core:
> > Expose device link details in sysfs") caused sleeping/scheduling while
> > atomic warnings.
> >
> > BUG: sleeping function called from invalid context at kernel/locking/mutex.c:935
> > in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 12, name: kworker/0:1
> > 2 locks held by kworker/0:1/12:
> >    #0: ee8074a8 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: process_one_work+0x174/0x7dc
> >    #1: ee921f20 ((work_completion)(&sdp->work)){+.+.}-{0:0}, at: process_one_work+0x174/0x7dc
> > Preemption disabled at:
> > [<c01b10f0>] srcu_invoke_callbacks+0xc0/0x154
> > ----- 8< ----- SNIP
> > [<c064590c>] (device_del) from [<c0645c9c>] (device_unregister+0x24/0x64)
> > [<c0645c9c>] (device_unregister) from [<c01b10fc>] (srcu_invoke_callbacks+0xcc/0x154)
> > [<c01b10fc>] (srcu_invoke_callbacks) from [<c01493c4>] (process_one_work+0x234/0x7dc)
> > [<c01493c4>] (process_one_work) from [<c01499b0>] (worker_thread+0x44/0x51c)
> > [<c01499b0>] (worker_thread) from [<c0150bf4>] (kthread+0x158/0x1a0)
> > [<c0150bf4>] (kthread) from [<c0100114>] (ret_from_fork+0x14/0x20)
> > Exception stack(0xee921fb0 to 0xee921ff8)
> >
> > This was caused by the device link device being released in the context
> > of srcu_invoke_callbacks().  There is no need to wait till the RCU
> > callback to release the device link device.  So release the device
> > earlier and move the call_srcu() into the device release code. That way,
> > the memory will get freed only after the device is released AND the RCU
> > callback is called.
> >
> > Fixes: 287905e68dd2 ("driver core: Expose device link details in sysfs")
> > Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >
> > v1->v2:
> > - Better fix
> > - Changed subject
> > - v1 is this patch https://lore.kernel.org/lkml/20200716050846.2047110-1-saravanak@google.com/
> >
> > Marek and Guenter,
> >
> > I reproduced the original issue and tested this fix. Seems to work for
> > me. Can you confirm?
>
> Confirmed, this one fixes the issue! :)
>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thanks!

-Saravana
