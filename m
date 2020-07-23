Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B551C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36B132065F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="bhbwlb65"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgGWTlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 15:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgGWTls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 15:41:48 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A99C0619E2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 12:41:47 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id q4so2147407edv.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 12:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yDa3ZkgaE+WuzZtaVFiJyzytWneTWKSFcpZNER2Xyo8=;
        b=bhbwlb65XluKM2V2sElc/28MQmfFvinSxRA6UNKn8PF0p8CCmL4AyNxxuTsA73ybg4
         mzaDpPE17MWH+ODDOmK4ufuktYwq4H0wVyIiNDueQ9TTmWxkJJHvPNhIM2DsJvYFpNLQ
         E8OqCRcsFhQL8VxPqFGF4UlaIGaijRkiVmp6kwDmrn3qKeO3cf6Yqso++Ivi5tj6bUW/
         XX7oU7Ye6kMirSQ4D0eIDTV3u0dw+4/1ELAq73l63Wy2QGVV1Jf5LGFhBtpETNktedO0
         q0eNDR15gPxmN2N3JhLL4JL4rEJHZvPUcsrzCD1/S3zDLViMqnNSKouBWVNcp7a4g4Fs
         pGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yDa3ZkgaE+WuzZtaVFiJyzytWneTWKSFcpZNER2Xyo8=;
        b=SoINqdYn3bWNl6dnLGfGSiuBRWjyDZzp8PC0nKur5e2xsQasNHEguTPLQ2mMOED75B
         swC+FCGRqQSavsE2UDnDqK7SxVLFMVKUXvZGAdfXy+Yc9IAT0J9WQtzkPoxR5oWVjlkX
         jlXHhCsDPcDNjKOp20a+JYO9UYVHzZcup8dOQ10d1s1baMYealML/9GU+BlcF6lZd5X7
         lkAGjdJtIpA0X5xJ4Yn4TwYHBAlwqJnKcDM7mZArtOnXpryMwfZjYjarfOSBqqNQJdRU
         nHHZ/Bp/UQ7JAZNRpYRVS/LU9KXAJy9cRiLEn5TjZ3SNoU7lIGik8kHWiJC1V20/PFzC
         ncJA==
X-Gm-Message-State: AOAM530wQ5orI+9GCXcHmLojS9aGNttgse1mD/d+zbzlCBMmzwCXuhOc
        +oJgSWFOYYE4On4K+2fYAXx6/wv05R3nhmkvLdphhg==
X-Google-Smtp-Source: ABdhPJxt1dYk2ga8AQ6Qj6Tx7iv2mjgE0rTywGGNUcNbzAOtVdZbIbywzA3j6HqGw14AgYMhW5u1fri73Rsq6EWFtB4=
X-Received: by 2002:a05:6402:14c1:: with SMTP id f1mr5907076edx.342.1595533306590;
 Thu, 23 Jul 2020 12:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200717205322.127694-1-pasha.tatashin@soleen.com>
 <20200717205322.127694-2-pasha.tatashin@soleen.com> <20200723180902.GV3673@sequoia>
 <CA+CK2bDC2ARTT2Q=c-p7586Xb8uedx-f6Rr7H9bYn-3U8x=d2Q@mail.gmail.com> <20200723183909.GW3673@sequoia>
In-Reply-To: <20200723183909.GW3673@sequoia>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 23 Jul 2020 15:41:10 -0400
Message-ID: <CA+CK2bBv7UuCXQ-BDtrH=JiQRAJD9V885C-4tg+3eKG9viF=yA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] loop: scale loop device by introducing per device lock
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > -     atomic_inc(&lo->lo_refcnt);
> > > > -out:
> > > > +     err = mutex_lock_killable(&lo->lo_mutex);
> > > >       mutex_unlock(&loop_ctl_mutex);
> > >
> > > I don't see a possibility for deadlock but it bothers me a little that
> > > we're not unlocking in the reverse locking order here, as we do in
> > > loop_control_ioctl(). There should be no perf impact if we move the
> > > mutex_unlock(&loop_ctl_mutex) after mutex_unlock(&lo->lo_mutex).
> >
> > The lo_open() was one of the top functions that showed up in
> > contention profiling, and the only shared data that it updates is
> > lo_recnt which can be protected by lo_mutex. We must have
> > loop_ctl_mutex in order to get a valid lo pointer, otherwise we could
> > race with loop_control_ioctl(LOOP_CTL_REMOVE). Unlocking in a
> > different order is not an issue, as long as we always preserve the
> > locking order.
>
> It is probably a good idea to leave a comment about this in the
> lo_open() so that nobody comes along and tries to "correct" the
> unlocking order in the future and, as a result, introduces a perf
> regression.
>
Makes sense, I will add a comment about it.

Thank you,
Pasha
