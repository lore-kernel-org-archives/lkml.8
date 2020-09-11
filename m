Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE93C2BC11
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 11:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B634E221EB
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 11:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qZhud8Wj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbgIKLt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 07:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgIKLrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 07:47:41 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FBFC061756
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 04:22:02 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d9so7098212pfd.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 04:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r7iKwByK7Ggxs8fF2MRwOWTinXH26LnGp7HdZEqOG6Q=;
        b=qZhud8Wj7fz6kWEmRxUNxCQIon3sPVCHBPTOPWLKdt1awlufpCoSZ+Hl9NGNiQ1GIX
         y1xfSkU4FNQwuAvg2z09TsRBDrOfpPeQozYvSzPFCM8DJzOv4g7gOIt8xJa9xSlc4bWV
         8f/s9RvyymcxC4dyCWxFK1zTsKgdZoAg9x5qY2PIWPxM2dK+xDneaVGDdHVI0QOORdoX
         qIG8e6DQOSIZlU4GOnGuiqT+Z3a1FIj6XmbXRe9/ggtKLXeaIsxqxSKbJJ4oAq6C1q7Y
         COtHCsjrKZFmJKNtlxykIKp0ozB1/rjA01mG/4PnuoDy2XFjsykNaEzdjreT+TwabLeT
         ocwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r7iKwByK7Ggxs8fF2MRwOWTinXH26LnGp7HdZEqOG6Q=;
        b=UQ4JgCqdRiZhElX48hLproyXlIm5/QcyK+ONdC0gv1z+2R50lzWE+T598GksTzOtGi
         aLGTBMYJUo0fkvCV03iZpU2VNOfdNqwb8JC5RvCopuF//XgIcyBKHGLEZWBQyN9+ZUXp
         Sgc5E1XRvyZ6ckuyET5LOvQ+9wXgeM6LQjhJYNvGaSGayC8a3TuZI4uTe8CFBDzqI4ML
         48dKioXKcj+P/kt1WVNP2KE0QclJdBHKm3nwb1wnGKuBl/XmjMJaG+He/COKUf+2hhFC
         oMj38MpSCnu2jNajojvRGdVc0ra6ZSuqj0eN/3Coc4JXQcxr1X/WzFAgtcBnmHnStKuQ
         EXmg==
X-Gm-Message-State: AOAM533yixZJRyZC1YLyipbFF36OJ2jBF3zwvGgNewQPkTrTInuihWOr
        E61CycWBuysg4JkxaPqVl8dD36EvAAlpq45f
X-Google-Smtp-Source: ABdhPJxvV8pHMvC2FG3jV/h453vH5VuGsPOD4dGB6qz7UdRDp+6KSGm5e2IeBbgrWR3SXBZ6rtNUGQ==
X-Received: by 2002:a17:902:c411:b029:d0:589f:6e1c with SMTP id k17-20020a170902c411b02900d0589f6e1cmr1955532plk.0.1599823321403;
        Fri, 11 Sep 2020 04:22:01 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id n127sm1981068pfn.155.2020.09.11.04.21.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 04:22:00 -0700 (PDT)
Subject: Re: [PATCH] pipe: honor IOCB_NOWAIT
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cedfa436-47a3-7cbc-1948-75d0e28cfdc5@kernel.dk>
 <20200911011205.GG1236603@ZenIV.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <719f095d-43fa-7e93-e8c8-bb22f2505501@kernel.dk>
Date:   Fri, 11 Sep 2020 05:21:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200911011205.GG1236603@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/20 7:12 PM, Al Viro wrote:
> On Mon, Sep 07, 2020 at 09:21:02AM -0600, Jens Axboe wrote:
>> Pipe only looks at O_NONBLOCK for non-blocking operation, which means that
>> io_uring can't easily poll for it or attempt non-blocking issues. Check for
>> IOCB_NOWAIT in locking the pipe for reads and writes, and ditto when we
>> decide on whether or not to block or return -EAGAIN.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
>> ---
>>
>> If this is acceptable, then I can add S_ISFIFO to the whitelist on file
>> descriptors we can IOCB_NOWAIT try for, then poll if we get -EAGAIN
>> instead of using thread offload.
> 
> Will check.

Thanks!

> In the meanwhile, blacklist eventpoll again.  Because your
> attempts at "nonblocking" there had been both ugly as hell *AND* fail
> to prevent blocking.  And frankly, I'm very tempted to rip that crap
> out entirely.  Seriously, *look* at the code you've modified in
> do_epoll_ctl().  And tell me why the hell is grabbing ->mtx in that
> function needs to be infested with trylocks, while exact same mutex
> taken in loop_check_proc() called under those is fine with mutex_lock().
> Ditto for calls of vfs_poll() inside ep_insert(), GFP_KERNEL allocations
> in ep_ptable_queue_proc(), synchronize_rcu() callable from ep_modify()
> (from the same function), et sodding cetera.

Ugh missed the loop_check_proc() part :/

The original patch wasn't that pretty, in my defense the whole thing is
pretty ugly to begin with. It'd need serious rewriting to become
palatable. If you want to yank the patch, I've got no problem with that.

> No, this is _not_ an invitation to spread the same crap over even more
> places in there; I just want to understand where had that kind of voodoo
> approach comes from.  And that's directly relevant for this patch,
> because it looks like the same kind of thing.

The pipe patch is way cleaner, and pretty much to the point. Don't think
that's a fair comparison.

> What is your semantics for IOCB_NOWAIT?  What should and what should _not_
> be waited for?

Basically it's don't wait for space (if write) if it's full, don't wait
for data if it's empty. O_NONBLOCK for the operation, instead of as a
file state. The locking isn't strictly required, and it's basically
impossible to avoid various deeper down items like memory allocations
potentially blocking, so...

-- 
Jens Axboe

