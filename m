Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53C2C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 17:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD453208C7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 17:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NTAIkpXZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgGQRbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 13:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgGQRbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 13:31:50 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC855C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 10:31:49 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a23so4142858pfk.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 10:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XFgYMGoKiX49l1DrRRroifUSZDfK1GLfBiXM5ZME7LU=;
        b=NTAIkpXZs3R0/tyj+kfF1UAEFf7YQPnRv/fOJXVKn9Wipmia8S6aiULGLOTUYLcpVK
         Ka8rISkOqc5D2/28OFWffArLGdT5OolGAa50rYnPjTfeLh6DY6TQrfXq9aABDoFZiZoM
         PcgMu24PPM4TsuQwT5TS1mTBugFnF9i8A+JDFumQnDKni0sSBR6EFgc5FMoFpvIPdh0f
         JlsZuxDwOZDbGFyBHAQNKybPhUVmiijqXmuZ/XhjCKbW/YbuFPhEApvUZbFOX2FIb3hp
         BIMs6J4XRuB6uFsgZ4+k7YpvCLCLkRbNwbJSpQD/IFsEqqnUYdFe6TkUD4zLeXPpAsnj
         SAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XFgYMGoKiX49l1DrRRroifUSZDfK1GLfBiXM5ZME7LU=;
        b=J/3Ie6C/U1ljHq7moGx9M0Zk14PCEfkCLh07L+nX3OSF93sGKRRdLXPz5+eiR5fMtW
         YwcOmcyA4KI+1Bw+YnGGHSynyImv1OmLPve6HQs1V1EA3j1d3y5gd+4S6bWmLwuMtu0E
         68bTPl5dhd1P/BVFbaW681Ch58VtlV1sBhqOwULVah5EoF4dHfNrkdCfPZXct0hhTU5z
         5+LbO/gNlaUY55UQfhc8vL1XmTNA2Kia+m9RsrmjyZQRcjs5CismC6VAh8nSFulEPsd6
         TY+UikNrMFh7UF28I8Ysq82p8x+hKuiO434J6aAgpEn/qJJtGaE8gQ/WVuHk0rRLcGKs
         eSjQ==
X-Gm-Message-State: AOAM530vc8v3MIEO4U9dVR1ebDZvyCqV+pIOvpAbyoguEZwV5WNxxGJY
        UGx4n288UBsiPEWglwk42wGWtv8guDxbW286k0YxWw==
X-Google-Smtp-Source: ABdhPJwd7yuLIvXv9X95ZgUtHIgV5x0iHoSuVr+9QTRBIYv128h5R30OylV6OksETLfQ+2xSMCsFl6cVAFth72q8wLI=
X-Received: by 2002:a05:6a00:15c7:: with SMTP id o7mr8670450pfu.51.1595007109035;
 Fri, 17 Jul 2020 10:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200716214531eucas1p2c173df09a6e00ef15dfae43ce8f1f9cd@eucas1p2.samsung.com>
 <20200716214523.2924704-1-saravanak@google.com> <6b37125c-96f5-c59c-f170-934d68c9bed1@samsung.com>
 <20200717163434.GA119309@roeck-us.net>
In-Reply-To: <20200717163434.GA119309@roeck-us.net>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 17 Jul 2020 10:31:13 -0700
Message-ID: <CAGETcx9quqtV9TeD8WEcLLijGeV+7hXqnyiMv7F8xo+vyF_7iw@mail.gmail.com>
Subject: Re: [PATCH v2] driver core: Fix sleeping in invalid context during
 device link deletion
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 9:34 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Fri, Jul 17, 2020 at 12:13:04AM +0200, Marek Szyprowski wrote:
> > Hi Saravana,
> >
> > On 16.07.2020 23:45, Saravana Kannan wrote:
> > > Marek and Guenter reported that commit 287905e68dd2 ("driver core:
> > > Expose device link details in sysfs") caused sleeping/scheduling while
> > > atomic warnings.
> > >
> > > BUG: sleeping function called from invalid context at kernel/locking/mutex.c:935
> > > in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 12, name: kworker/0:1
> > > 2 locks held by kworker/0:1/12:
> > >    #0: ee8074a8 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: process_one_work+0x174/0x7dc
> > >    #1: ee921f20 ((work_completion)(&sdp->work)){+.+.}-{0:0}, at: process_one_work+0x174/0x7dc
> > > Preemption disabled at:
> > > [<c01b10f0>] srcu_invoke_callbacks+0xc0/0x154
> > > ----- 8< ----- SNIP
> > > [<c064590c>] (device_del) from [<c0645c9c>] (device_unregister+0x24/0x64)
> > > [<c0645c9c>] (device_unregister) from [<c01b10fc>] (srcu_invoke_callbacks+0xcc/0x154)
> > > [<c01b10fc>] (srcu_invoke_callbacks) from [<c01493c4>] (process_one_work+0x234/0x7dc)
> > > [<c01493c4>] (process_one_work) from [<c01499b0>] (worker_thread+0x44/0x51c)
> > > [<c01499b0>] (worker_thread) from [<c0150bf4>] (kthread+0x158/0x1a0)
> > > [<c0150bf4>] (kthread) from [<c0100114>] (ret_from_fork+0x14/0x20)
> > > Exception stack(0xee921fb0 to 0xee921ff8)
> > >
> > > This was caused by the device link device being released in the context
> > > of srcu_invoke_callbacks().  There is no need to wait till the RCU
> > > callback to release the device link device.  So release the device
> > > earlier and move the call_srcu() into the device release code. That way,
> > > the memory will get freed only after the device is released AND the RCU
> > > callback is called.
> > >
> > > Fixes: 287905e68dd2 ("driver core: Expose device link details in sysfs")
> > > Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > ---
> > >
> > > v1->v2:
> > > - Better fix
> > > - Changed subject
> > > - v1 is this patch https://lore.kernel.org/lkml/20200716050846.2047110-1-saravanak@google.com/
> > >
> > > Marek and Guenter,
> > >
> > > I reproduced the original issue and tested this fix. Seems to work for
> > > me. Can you confirm?
> >
> > Confirmed, this one fixes the issue! :)
> >
> Same here.
>
> Tested-by: Guenter Roeck <linux@roeck-us.net>
>
> Guenter
>
> > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >

Thanks both.

Greg, can you review this and pull this into driver-core-next too?

-Saravana
