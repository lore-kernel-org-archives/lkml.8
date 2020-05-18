Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F639C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FC162083E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="p+4e8OGb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgERJcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 05:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbgERJcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 05:32:18 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F80C05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 02:32:18 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id y85so3630537oie.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 02:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r4y8pOF1U2hIXUEaQHB5pp1+f6cCMjasAlccauvS3u8=;
        b=p+4e8OGbkl4jtB21Kp0Taies1F3UglkyxEVlBRQUQ1JCB7uuaBDtommPyyPp+nFWc3
         1Xguh2oulhrEM1GT03E7NzWVydFgKZNO9PxIrx2t4zUNhN2e2Yzekzb5Kd8ItHWtaWJ+
         DJRzZRP0Zod3TVkJ8lxGJbG7FIMvQZ7pP+Yi5IcziQk+yOTY+8Ijv+n/4M4sTFnh95o/
         YyGb1xwUv7sa8c9Jbj4KOSqiGGjhEjVMmHGmH4kDJ/f+dly1SZSizUV2p+nmhaft5URq
         EUcitTFvt2xe/bdolmFD5KvRRInAoLbZB0WCOCNiPysMYx9wph5eWaErFcbLXSzPw6Y3
         SQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r4y8pOF1U2hIXUEaQHB5pp1+f6cCMjasAlccauvS3u8=;
        b=kz8idGcVmLlflmkuXw1ylB406E46eYV5M1NjOsrHJip5LiWYjVrvxt9nPhvxMNxv/V
         KkI3nW2yvaVs9KqSTKWD20VU4gp02GOLjAWW7PiA/h3U8bXlmBjfXsNh9KfMC9SakqhQ
         us4MsJKn8SUbOb7JPFAuufR7kNtw3O69OQgWL2bKuaMhPqRpLPvGZ6K2F8ShNH4BaIg4
         /2H6rIo/uTnAmmdjNpWN4WBlmvk8tpvsilAWehphPB9u1LPl65zU++JrlznRizcNyces
         K3ZWigwmZdP+YgJ1X9Up+SUUrW7ASaaxF+HB8233QEH8qH3WzQV63eBNxahYiPx3umgX
         J/kA==
X-Gm-Message-State: AOAM532Y2sD+ztzAYWIrEwWmQt4RhscEDxdqUO4OVxWutYst3capFjA2
        a+sZFwoKT9LamksyYeVXxGXAPlVU2HN4MvN41ODUHQ==
X-Google-Smtp-Source: ABdhPJyrEJAISIZWsXEyVlyc4BlPLuXVfhVNfJE1HrEOPfH8Lbw8GOfGkNCHlNzM0DGX7IOc1TiEmiYBdJ1xs3xDRQ4=
X-Received: by 2002:aca:ea46:: with SMTP id i67mr9709314oih.152.1589794337493;
 Mon, 18 May 2020 02:32:17 -0700 (PDT)
MIME-Version: 1.0
References: <4502272.pByIgeXik9@kreacher> <CAJZ5v0j6S+we7tHeV9TM30LS+TO3zWigACe0ZUFfWphg2FBBZQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0j6S+we7tHeV9TM30LS+TO3zWigACe0ZUFfWphg2FBBZQ@mail.gmail.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Mon, 18 May 2020 17:32:06 +0800
Message-ID: <CAB4CAweV+U_pPv9877S+j6UVUPjcTzJq26rarxnJfwc6on1ESA@mail.gmail.com>
Subject: Re: [PATCH[RFT]] ACPI: EC: s2idle: Avoid flushing EC work when EC GPE
 is inactive
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 4:59 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, May 14, 2020 at 12:10 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Flushing the EC work while suspended to idle when the EC GPE status
> > is not set causes some EC wakeup events (notably power button and
> > lid ones) to be missed after a series of spurious wakeups on the Dell
> > XPS13 9360 in my office.
> >
> > If that happens, the machine cannot be woken up from suspend-to-idle
> > by a power button press or lid status change and it needs to be woken
> > up in some other way (eg. by a key press).
> >
> > Flushing the EC work only after successful dispatching the EC GPE,
> > which means that its status has been set, avoids the issue, so change
> > the code in question accordingly.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > Hi Chris,
> >
> > Please check if the key press wakeup still works on your system with this patch
> > applied (on top of https://patchwork.kernel.org/patch/11538065/).
>
> Hi Chris,
>
> Since I haven't heard back from you and the problem at hand is a
> regression on the machine where it happens, I'm going to push this
> patch for merging.
>
> If it causes the key press wakeup issue to reappear on your machine,
> I'm afraid that we'll need to quirk it in the EC driver.
>
> Thanks!
>

Sorry that I missed this email. I'll apply this patch and test again.
