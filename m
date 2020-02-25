Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717F8C35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 16:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54ED620CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 16:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730866AbgBYQ0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 11:26:55 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:40267 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730315AbgBYQ0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 11:26:54 -0500
Received: from mail-lf1-f69.google.com ([209.85.167.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1j6d2q-0005TE-VV
        for linux-kernel@vger.kernel.org; Tue, 25 Feb 2020 16:26:53 +0000
Received: by mail-lf1-f69.google.com with SMTP id u11so1097184lff.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 08:26:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6KgosfBk+kukcYhOBsRdACyiQcocWmwDB5HCCyo2ovs=;
        b=Y6uP4HLsNxZJffRAv6IuJdE+gHebqyIfnd26FWGajElY+VLsvqHm2zJBmOegWHQuO8
         uZ7ijYJP9A5nkGjvxx3lPXkfvCwsKWdAquEykbDC4J+rPPToUzWKCiNKPszxuhSCdAfK
         9lBCul845VqRxE54SE9PfmmTlM+nFlzYTFR12gZNW7i1LN5t1VeaB0gX3OGOULO5LuHc
         Y2+DL3KyPPV1hqvQY/k0dBgDt59R0y1JZws/0ryImcZPD/KpzpWOrvBX+riteMHDafx4
         PNm7mMlmctvAedRzzxplmSGUL7nnN+FUgNHXrP7L3hNoKp+UCWMOKzmpOrlCIMh1pfjg
         NONA==
X-Gm-Message-State: APjAAAXiUmAql6ZMKHqPY6Da0DFZbeQMMEjb7JCWNFf3JN1t68zddJcN
        Fa9mCie3QhwbbnshQPJDlwsJ8AV+1eOjU8siboMbO2WKs6es4PSqvNnEM2wwDiABjSC6SSeUaZA
        a/BECwO4H9G0JfJAcW380frudNf3fJFZAM9WgRcLBtGNIiJML7nFuMNop
X-Received: by 2002:a05:651c:86:: with SMTP id 6mr35455442ljq.193.1582648012400;
        Tue, 25 Feb 2020 08:26:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqwhAChCYW8Rnza3LJ6Bqlvbte3yT4V3IJgbdnBoydcCXoxBv65l338zoLUI7XDIPP1MBkmx7GDdU7hQOX/tW8Q=
X-Received: by 2002:a05:651c:86:: with SMTP id 6mr35455420ljq.193.1582648012111;
 Tue, 25 Feb 2020 08:26:52 -0800 (PST)
MIME-Version: 1.0
References: <20200225101809.9986-1-po-hsu.lin@canonical.com> <bbc88e24-835b-2b1e-2997-255896b14cc4@kernel.org>
In-Reply-To: <bbc88e24-835b-2b1e-2997-255896b14cc4@kernel.org>
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
Date:   Wed, 26 Feb 2020 00:26:40 +0800
Message-ID: <CAMy_GT_aUvyUGb8RhdWu5VQ7Y-a82-Jm4hY7fPGL+rEAityyhw@mail.gmail.com>
Subject: Re: [PATCH] selftests/timers: Turn off timeout setting
To:     shuah <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, tglx@linutronix.de,
        John Stultz <john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sure,
I will send V2 that include the change for makefile and more detail
about the change.
Thanks for the feedback,

On Tue, Feb 25, 2020 at 11:30 PM shuah <shuah@kernel.org> wrote:
>
> On 2/25/20 3:18 AM, Po-Hsu Lin wrote:
> > Tests in timers especially nsleep-lat, set-timer-lat,
> > inconsistency-check and raw_skew these 4 tests can take longer than
> > the default 45 seconds that introduced in commit 852c8cbf
> > (selftests/kselftest/runner.sh: Add 45 second timeout per test) to run.
> >
> > Disable the timeout setting for timers instead of looking for an proper
> > value to make it more general.
> >
> > Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
> > ---
> >   tools/testing/selftests/timers/settings | 1 +
> >   1 file changed, 1 insertion(+)
> >   create mode 100644 tools/testing/selftests/timers/settings
> >
> > diff --git a/tools/testing/selftests/timers/settings b/tools/testing/selftests/timers/settings
> > new file mode 100644
> > index 0000000..e7b9417
> > --- /dev/null
> > +++ b/tools/testing/selftests/timers/settings
> > @@ -0,0 +1 @@
> > +timeout=0
> >
>
> What happens when you disable this and set it to 0? How long does the
> rest run in this case? Can you add the details to the change log please.
>
> thanks,
> -- Shuah
