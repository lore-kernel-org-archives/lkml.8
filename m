Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BD5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 17:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 005592075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 17:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KDuBvM5m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbgESRXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 13:23:08 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23213 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729053AbgESRXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 13:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589908986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xr0IWkc5cd9RFwz8LsU7++TtyuSvnhVK7nv8eOr0z7U=;
        b=KDuBvM5maDQYd2yaYAoVB9cOJoQ+7PBrLYFocEyHxFiUatoUxx59wdYR+DIgnSdVS2naiO
        0XcEHDWZcRGehznei2dODhplFa1I2EApw+aqD2Z8nODGGcwWuWF6Ztxk6pYop2qZm/Kll9
        F0CiDrsnfuOWjUNI0SRvgJcUypEzbMg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-Hm2XYAErPx6yKr691wRR9w-1; Tue, 19 May 2020 13:23:02 -0400
X-MC-Unique: Hm2XYAErPx6yKr691wRR9w-1
Received: by mail-ed1-f69.google.com with SMTP id m7so30358edr.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 10:23:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xr0IWkc5cd9RFwz8LsU7++TtyuSvnhVK7nv8eOr0z7U=;
        b=SoUhFBDMByZaJtY6q7Q3TSLIjepzUEGg9pyd16AuUdeBWO/JuAYmOEOesUrYHCXMuA
         9B0O58C+nB63fVcuEjaqjHTJRn9G20PSc+O72aC008z0OgVfnt1GEwWod/pyxrwsVFXh
         l+5PFUoGgwr2EBQXVJAEgZX9BBLx5m4dtOXxOuf1KHIKCmhrYImCPdBt1q5iDp+qaLJl
         xE+2jjhRN9gzWpqqtGL0mbEZR2w+/dZgibtzK+NzGLFPLi3YjXMIfvdwnE1gMRrm8x6H
         zTLC3Qzu0lFHdBSCTzUEZQ+sWM9yv3Zmje4j+fW3SyzqhKLRNIGFLV6pEs41auO3yU85
         AD3A==
X-Gm-Message-State: AOAM533xK4LIcth5dlU3FYuNIhXC5AaQZY6+1dNGEq4CP3fV3LxvVHDG
        Kir3xNuUVCfIblrSd5kxpibjiIdrXzyw4t5tQyh6ggRSH7bNqh8PL8UP2qPE5EiOgX6EHNvdSwf
        Hum8grHSuJo1iabNUfHwyNxkZv1ZQsBZtCKq5v1DS
X-Received: by 2002:a05:6402:68f:: with SMTP id f15mr28541edy.89.1589908980860;
        Tue, 19 May 2020 10:23:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhliVX54qC9F8tVH/Uxlkhcajof6VHEtCuyT4Y7J/8+Qf6Szuk4QIj8ZglKda578e6zYVbHGherzcpsBKGMzY=
X-Received: by 2002:a05:6402:68f:: with SMTP id f15mr28523edy.89.1589908980585;
 Tue, 19 May 2020 10:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <158955700764.647498.18025770126733698386.stgit@buzz>
 <20200515162707.GI2978@hirez.programming.kicks-ass.net> <403cc691-4ec5-8b3f-382c-4820736da41d@redhat.com>
In-Reply-To: <403cc691-4ec5-8b3f-382c-4820736da41d@redhat.com>
From:   "Carlos O'Donell" <carlos@redhat.com>
Date:   Tue, 19 May 2020 13:22:48 -0400
Message-ID: <CAEMqeSqr9D6uj2OB0_5uT03c_au3906z_oyhX3zfg4OempTJVw@mail.gmail.com>
Subject: Re: [PATCH] futex: send SIGBUS if argument is not aligned on a
 four-byte boundary
To:     Peter Zijlstra <peterz@infradead.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Maxim Samoylov <max7255@yandex-team.ru>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 1:50 PM Carlos O'Donell <carlos@redhat.com> wrote:
> This isn't fixed because this is the older code in pthread_mutex_lock
> which we haven't ported to futex-internal.h yet, otherwise we would abort
> the process.

I filed this upstream as a QoI issue so I don't forget to port the existing code
to the newer internal interfaces for futex handling.

"Bug 25997 - pthread_mutex_lock QoI issue for unaligned futex."
https://sourceware.org/bugzilla/show_bug.cgi?id=25997

I checked that -Wcast-align=strict does warn about this case, but it's
rarely used
in production code that I've worked with. I'm following up with the
compiler people
to see if we can consistently warn in these cases and so avoid this kind of code
existing in the first place.

Cheers,
Carlos.

