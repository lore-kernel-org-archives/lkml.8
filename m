Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDF6C47257
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 10:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C0BA208DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 10:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ow1M+5cp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgEHKEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 06:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgEHKEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 06:04:31 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D61BC05BD09
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 03:04:31 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e16so1168605wra.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 03:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3ahmjo7zWj9jAF2hUJ67B2bDxaSBhv7Y9eLaU0WOfHs=;
        b=Ow1M+5cpGoKhWIgArtKKdDwzijj4tPOSBLNMT4uEWbCCdOY+v3p+h51Tuyq/2uxqdO
         qwYA6XIh2oBLvDb5IYdxEienwVhPwBQ6WPyyHW4iy3BTjThXhZRLOqg7rcb2dc3Q4qSM
         zd+XliY65XMylQmL3UkGsQqEYt+rNjKCcDT8WOPaCNtA/+WxGOHgUy7Q+MZeXre3FEJB
         Uvz1guxee4h+GfdY5rM5IDKy/68yXPskbFLb7PpMUEwOZTcxRB7nODkAkJGSRhyn/KwL
         Qu+AxulP295egIYe3FFgQDt+ZxGhz/S4aGq68urvQbL3qqNCvDcYy0Mnqb2ld+Wx+6ei
         a01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3ahmjo7zWj9jAF2hUJ67B2bDxaSBhv7Y9eLaU0WOfHs=;
        b=kAn9IT7kJldFz0TqXbzMJ+CViZmOPlxJNNtevX88DRkYJRjF1T+87CM/YERnMyIgqe
         t+88UTm7X6cLl6dWPs/1oggrS2k1JugGiDkOMNhmBvRO4i8whxmG503IyyhftBFFdZV7
         zh/R7mkDEduvlqzltfsYEh6nH9aFYbaHUKI/cl14yh1Pj+9q/FTuDeUXRd7/Hsg1XhpV
         gvnB6ekWCfPVuFkdmjOQ+hu0gW9gTg4LKgt5tX7crMae0Tl8r7eihcofXSwgNhSFjYlM
         SUTzMIzbLDJuU4E0U4EMebfRQLZdbnyWYAzQTGGtE/JWlYwEZ9JKj0kWfGwVk1QqRXLd
         d4HA==
X-Gm-Message-State: AGi0PubR2lGaa7gZUmp0N7QGYYE1gsZiVzA2VxF/8bTut0vMLPimgbv1
        /balpoownsqKmmLjoOi6wNA9DQd9XhY=
X-Google-Smtp-Source: APiQypLKry7qhaWWoWsKrrbZvd9kXc6HTKRQxi4oXWoq/OWFOW1Rb0C+lIlByPLfibQJKGURGtJt7w==
X-Received: by 2002:adf:fa92:: with SMTP id h18mr2098339wrr.260.1588932269512;
        Fri, 08 May 2020 03:04:29 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id c25sm12210763wmb.44.2020.05.08.03.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 03:04:28 -0700 (PDT)
Date:   Fri, 8 May 2020 11:04:25 +0100
From:   Quentin Perret <qperret@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, sudeep.holla@arm.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, viresh.kumar@linaro.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        fweisbec@gmail.com, tkjos@google.com, kernel-team@android.com
Subject: Re: [PATCH 08/14] sched/core: Export runqueues per-cpu array
Message-ID: <20200508100425.GA239353@google.com>
References: <20200507181012.29791-1-qperret@google.com>
 <20200507181012.29791-9-qperret@google.com>
 <20200508080759.GL5298@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508080759.GL5298@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 May 2020 at 10:07:59 (+0200), Peter Zijlstra wrote:
> On Thu, May 07, 2020 at 07:10:06PM +0100, Quentin Perret wrote:
> > It will be needed by schedutil once modularized, export it.
> > 
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > ---
> > This is only needed for cpu_rq() -> cpu_bw_dl() in schedutil, so there is
> > probably an alternative if exporting this isn't desirable.
> > ---
> >  kernel/sched/core.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index dbaf3f63df22..537eb45b4274 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -36,6 +36,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_se_tp);
> >  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized_tp);
> >  
> >  DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
> > +EXPORT_SYMBOL_GPL(runqueues);
> 
> NAK, never going to happen.

Well, I should have seen that one coming :-)

As mentioned in the commit message, we might be able to work around.
I'll cook something for v2.

Thanks,
Quentin
