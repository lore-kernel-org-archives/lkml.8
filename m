Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7419C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 21:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2C0F2075A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 21:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NvbMBgkO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgE0Vny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 17:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgE0Vny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 17:43:54 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1B7C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 14:43:53 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id 5so2140893pjd.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 14:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8xrSbOhXNcO53Jugnfn3DM3MYFsd0aIhSW+Q702590o=;
        b=NvbMBgkOqpmFrJjInrBVR2+iybHAphGK16x1eGVEHUUQhd41vCIA0JVrQudLGWiTJ1
         UuGF2Iz1G0cReJeK7jJ7X/2ei83C4MIdO8KSDIqXbHLoV9orVRnxbvHAl6yY9awoa98s
         yYRTBTC2h2EK1VtE7Pu/f99uxmuB1JQ1914r0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8xrSbOhXNcO53Jugnfn3DM3MYFsd0aIhSW+Q702590o=;
        b=WHct9V/exI1BJWIsvdOK7vCU5PM7BcJ1h7hf3DTX092WutGemcEeLFkLp+LRPVEl03
         KMxjy7udhKIwnBk2Ufh8jcm6zU7X5MYza24+9YnLy55kyZHprMZou8CYIv2TKBfYcuA2
         8VGktD2LW7HPlgiKFSkSZ8qdEtrWOcs6u20eDwT16zyb0cjqqRWD88W+ULoeqOlkZz+t
         73NQOvCQ4dY9RhjJyxwBOEaBXaRX35I71tuJg8xuv1Q7aCOExMABD3ugFBCt3jNAbekW
         dBo4gTWCZ3nHcdpkZVplFWn2syvwm3GJuAZiCd1Mnty7eLQYK7FLgIXSr0Rqfh3a5z1L
         hhsA==
X-Gm-Message-State: AOAM532wPNvDMDw8uxZB8QMXaOIO7mzkkbQK6GInogUbS8q+L+ndLHsJ
        oZRG30rn3VNzt0xGFccQjr2FoA==
X-Google-Smtp-Source: ABdhPJxRUr0b3j6IjHfDpsbCKKpWAeNbp6kND1YduC9VB6pPkSW3FIGlBSz1/vgFhjY79NIkltnvdQ==
X-Received: by 2002:a17:902:9d94:: with SMTP id c20mr402368plq.224.1590615831883;
        Wed, 27 May 2020 14:43:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u4sm4643626pjf.3.2020.05.27.14.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 14:43:50 -0700 (PDT)
Date:   Wed, 27 May 2020 14:43:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Matt Denton <mpdenton@google.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Robert Sesek <rsesek@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: Re: [PATCH 1/2] seccomp: notify user trap about unused filter
Message-ID: <202005271408.58F806514@keescook>
References: <20200527111902.163213-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527111902.163213-1-christian.brauner@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 01:19:01PM +0200, Christian Brauner wrote:
> loop. But this is problematic since we don't get a notification when the
> seccomp filter has become unused and so we currently never remove the
> seccomp notifier fd from the event loop and just keep accumulating fds
> in the event loop. We've had this issue for a while but it has recently
> become more pressing as more and larger users make use of this.

I had been under the (seemingly very wrong) understanding that when
all the tasks associated with a filter cease to exist, the notif fd is
effectively closed. But I see now where I got confused: this is only
half implemented: if the userspace end of the fd is closed, it'll get
cleaned up in the kernel, but we have nothing going the other direction
except the general object lifetime management on the filter itself.

So, yes, I accept the basic problem statement, "we have fds hanging
around that will never be used again, we need to notice that". :)

Why is EPOLLHUP needed? Can't the fd just get closed on the kernel end?
I would expect that to be visible as EPOLLHUP internally (though I
haven't looked through the VFS yet). And I haven't found how to
close/detach a anon file from the listener task. It strikes me that this
would actually be much cleaner: then we actually don't need the
additional __get_seccomp_filter() in init_listener() -- we simply
invalidate the file during __put_seccomp_filter().

(While I'm here -- why can there be only one listener per task? The
notifications are filter-specific, not task-specific?)

> To fix this, we introduce a new "live" reference counter that tracks the
> live tasks making use of a given filter and when a notifier is
> registered waiting tasks will be notified that the filter is now empty
> by receiving a (E)POLLHUP event.
> The concept in this patch introduces is the same as for signal_struct,
> i.e. reference counting for life-cycle management is decoupled from
> reference counting live taks using the object.

I will need convincing that life-cycle ref-counting needs to be decoupled
from usage ref-counting. I see what you're saying here and in the other
reply about where the notification is coming from (release vs put, etc),
but I think it'd be better if the EPOLLHUP was handled internally to the
VFS due to the kernel end of the file being closed.

> There's probably some trickery possible but the second counter is just
> the correct way of doing this imho and has precedence. The patch also
> lifts the waitqeue from struct notification into into sruct
> seccomp_filter. This is cleaner overall and let's us avoid having to
> take the notifier mutex since we neither need to read nor modify the
> notifier specific aspects of the seccomp filter. In the exit path I'd
> very much like to avoid having to take the notifier mutex for each
> filter in the task's filter hierarchy.

I guess this is a minor size/speed trade-off (every seccomp_filter
struct grows by 1 pointer regardless of the presence of USER_NOTIF
rules attached...). But I think this is an optimization detail, and I
need to understand why we can't just close the file on filter free.

-- 
Kees Cook
