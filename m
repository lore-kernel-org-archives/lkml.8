Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CC7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 21:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDD452075A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 21:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="mB7loTYU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgE0VwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 17:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgE0VwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 17:52:06 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260CFC05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 14:52:05 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x11so9691096plv.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 14:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r/RSzQ5rbuoGCqd6AePSlV83s7nSTMTetKOIncJuF98=;
        b=mB7loTYUL7FqAXh3WPyISGZxDyB4FKGdZ0+r4jLg12K0hku5ijijuCcuYp8zKO0NXz
         KMCiPpjtcABYCjKDhHWCdMW+xrHi/t8uRZCdTP5+HraXPmP1BE7o6oMQ5HGVH+NkpDyG
         dzMuUQq7RriAdXjtKnrxrt00iITTkqWScmjloXqCeuqcOc3lLqj0FwqngrNRsiwkH3vp
         /lZJmt4XoapQCgKpWaWd4hTizLbAV4Zs2w41q+7Czyc2d7iJfuRrsbTXb2mdp0Wg/6Dz
         oAkoBItNbIP8YkJK4/6tDw/DL0mVZV8Rpqqyx4BbFv/LxTv7p1MNG0BUuSnOz63QO4UB
         YngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r/RSzQ5rbuoGCqd6AePSlV83s7nSTMTetKOIncJuF98=;
        b=GE+dWKCVLvUX6wzKB1mzYDh5XT35dcWAesSo3x9ouFu36foAX8zKZBYqdeEvETZMNd
         W/mwi13gW45GSHLS3M7vKX05duqVzAqLAIjfP0q8uRGIcmciBzwcj+XmmuAQgLCgOfU6
         JU6jd4LHkkBhmz5Tsv8KOCUcL0sQhKzvHgm5rFwyy+KJVtTJArIINuPz49g8u7d/aCoy
         J8so7FcO9ziftBPSWh9EqL4QlHiNytomDn2bq9NzuLo8JhoPaXa4oWbUB2h8Zsc3cQ48
         G20xqz3JjU36rbKVlj/LA3I2bDpqyO6Y8/jo10CEBURTM7lXUNs89tjFtAKsMv65DG4H
         fQVQ==
X-Gm-Message-State: AOAM530r0DDmTJE7TD+qkqnJb/DGbiYJvqD0jfLGWLf99IcKSLyB/0Mt
        bPpUbw8QY9zlnz/dT5qf6dH60Q==
X-Google-Smtp-Source: ABdhPJzqWZ7W+lfjT82rqnY1rDsuai1IzdTE6rHRQVh0x83kcJ1NUWBlCmhmvTpx8qIfbHxr3R0jKQ==
X-Received: by 2002:a17:90a:fd17:: with SMTP id cv23mr459083pjb.38.1590616324318;
        Wed, 27 May 2020 14:52:04 -0700 (PDT)
Received: from cisco ([2001:420:c0c8:1003::948])
        by smtp.gmail.com with ESMTPSA id w14sm2799084pgi.12.2020.05.27.14.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 14:52:03 -0700 (PDT)
Date:   Wed, 27 May 2020 15:52:03 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Matt Denton <mpdenton@google.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Robert Sesek <rsesek@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: Re: [PATCH 1/2] seccomp: notify user trap about unused filter
Message-ID: <20200527215203.GE4153131@cisco>
References: <20200527111902.163213-1-christian.brauner@ubuntu.com>
 <202005271408.58F806514@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005271408.58F806514@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 02:43:49PM -0700, Kees Cook wrote:
> (While I'm here -- why can there be only one listener per task? The
> notifications are filter-specific, not task-specific?)

Not sure what you mean here?

> > To fix this, we introduce a new "live" reference counter that tracks the
> > live tasks making use of a given filter and when a notifier is
> > registered waiting tasks will be notified that the filter is now empty
> > by receiving a (E)POLLHUP event.
> > The concept in this patch introduces is the same as for signal_struct,
> > i.e. reference counting for life-cycle management is decoupled from
> > reference counting live taks using the object.
> 
> I will need convincing that life-cycle ref-counting needs to be decoupled
> from usage ref-counting.

I think it does, since the refcount is no longer 1:1 with the number
of tasks that have it (a notification fd's struct file has a reference
too).

We could also do it the reverse way, and keep track of how many
notification fds point to a particular file. But somehow we need two
counts.

Maybe it's best to decouple them entirely, and have usage go back to
just being the number of tasks, and introduce a new counter for
notification fds.

> I see what you're saying here and in the other
> reply about where the notification is coming from (release vs put, etc),
> but I think it'd be better if the EPOLLHUP was handled internally to the
> VFS due to the kernel end of the file being closed.
> 
> > There's probably some trickery possible but the second counter is just
> > the correct way of doing this imho and has precedence. The patch also
> > lifts the waitqeue from struct notification into into sruct
> > seccomp_filter. This is cleaner overall and let's us avoid having to
> > take the notifier mutex since we neither need to read nor modify the
> > notifier specific aspects of the seccomp filter. In the exit path I'd
> > very much like to avoid having to take the notifier mutex for each
> > filter in the task's filter hierarchy.
> 
> I guess this is a minor size/speed trade-off (every seccomp_filter
> struct grows by 1 pointer regardless of the presence of USER_NOTIF
> rules attached...). But I think this is an optimization detail, and I
> need to understand why we can't just close the file on filter free.

That seems nicest, agreed.

Tycho
