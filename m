Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CD2C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 19:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE4082078B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 19:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Dd2rfV7e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbgHaThC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 15:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbgHaThB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 15:37:01 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7CEC061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 12:37:01 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id c142so1195579pfb.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 12:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IrMVw0/hWrYQkSqX7bF/wAZoQHkcVpfBV/h523demuE=;
        b=Dd2rfV7eOeVCHvqctE69BdDXH1DJjH5CfajuP4KaIojA00gdQo9eyGGqDtVdlE2Fp4
         1rZeCOtXZKPjzudrD3BXQGLaSnlCcRhsn5Xmv1XZxDDv7mGFIe34e/d+QxuhFBphNbM9
         nJeiQuqCFMG0BbIgQ4CJgD3kqmxhAgDkyd+5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IrMVw0/hWrYQkSqX7bF/wAZoQHkcVpfBV/h523demuE=;
        b=OOQoFqHd+0GO7t8CamYvGCtfl9xz4u1626HcyxTx8ncPkmsAnMV9dlLvHlv2YDBH5Q
         pf9mVq2gahjm2E8x8fIabhKJjtWP/+ArBvX3INSvArhHmYsY303H/z6JVGVi/Gv7VSm6
         B6CBZkL6cwTg7fWK941mEa4+UXvyujEQZWkWaLA22E2Sn/c8CKm7PHhi39iu8jbUaEVg
         GiuawbrORdS7oMzJDYr8jayehuNapSI3ssHtMZnjyJwr4tP5iuMja8TzDfZoeIv0IIcq
         0QYa/PP8H05DytNnMQ94llzJVke14JpjiWlw2nWUvJ9n+nnjskccRBRU6wMjQmhsIT0b
         mAJg==
X-Gm-Message-State: AOAM530QO+wgxeTnYUieFNfxunOT/SFwxQklGT1WscpRlq4xzhnIWw//
        zgQD+PFU7vUcbgsgYMvpeO7J/g==
X-Google-Smtp-Source: ABdhPJzvVleKFM91luZazh30N3OwQmEZJzYLLBGrnl0MdDjuyst4dW9M8SOvFiv1kyAp4+HU7bO+zw==
X-Received: by 2002:aa7:9a44:: with SMTP id x4mr2447134pfj.199.1598902620490;
        Mon, 31 Aug 2020 12:37:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w16sm8923087pfq.13.2020.08.31.12.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 12:36:59 -0700 (PDT)
Date:   Mon, 31 Aug 2020 12:36:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rich Felker <dalias@libc.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Kyle Huey <me@kylehuey.com>,
        Robert O'Callahan <robert@ocallahan.org>
Subject: Re: [PATCH] seccomp: kill process instead of thread for unknown
 actions
Message-ID: <202008311228.A0E7430BC@keescook>
References: <20200829015609.GA32566@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200829015609.GA32566@brightrain.aerifal.cx>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 09:56:13PM -0400, Rich Felker wrote:
> Asynchronous termination of a thread outside of the userspace thread
> library's knowledge is an unsafe operation that leaves the process in
> an inconsistent, corrupt, and possibly unrecoverable state. In order
> to make new actions that may be added in the future safe on kernels
> not aware of them, change the default action from
> SECCOMP_RET_KILL_THREAD to SECCOMP_RET_KILL_PROCESS.
> 
> Signed-off-by: Rich Felker <dalias@libc.org>
> ---
> 
> This fundamental problem with SECCOMP_RET_KILL_THREAD, and that it
> should be considered unsafe and deprecated, was recently noted/fixed
> seccomp in the man page and its example. Here I've only changed the
> default action for new/unknown action codes. Ideally the behavior for
> strict seccomp mode would be changed too but I think that breaks
> stability policy; in any case it's less likely to be an issue since
> strict mode is hard or impossible to use reasonably in a multithreaded
> process.
> 
> Unfortunately changing this now won't help older kernels where unknown
> new actions would still be handled unsafely, but at least it makes it
> so the problem will fade away over time.

I think this is probably fine to change now. I'd always wanted to
"upgrade" the default to KILL_PROCESS, but wanted to wait for
KILL_PROCESS to exist at all for a while first. :)

I'm not aware of any filter generators (e.g. libseccomp, Chrome) that
depend on unknown filter return values to cause a KILL_THREAD, and
everything I've seen indicates that they aren't _accidentally_ depending
on it either (i.e. they both produce "valid" filters). It's possible
that something out there doesn't, and in that case, we likely need to
make a special case for whatever bad filter value it chose, but we can
cross that bridge when we come to it.

I've added Kyle and Robert to CC as well, as they have noticed subtle
changes to seccomp behavior in the past. I *think* this change should be
fine, but perhaps they will see something I don't. :)


> 
>  kernel/seccomp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index d653d8426de9..ce1875fa6b39 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -910,10 +910,10 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
>  			seccomp_init_siginfo(&info, this_syscall, data);
>  			do_coredump(&info);
>  		}
> -		if (action == SECCOMP_RET_KILL_PROCESS)
> -			do_group_exit(SIGSYS);
> -		else
> +		if (action == SECCOMP_RET_KILL_THREAD)
>  			do_exit(SIGSYS);
> +		else
> +			do_group_exit(SIGSYS);

I need to think a little more, but I suspect we should change the coredump
logic (above the quoted code) too... (i.e. "action == SECCOMP_RET_KILL_PROCESS"
-> "action != SECCOMP_RET_KILL_THREAD")

>  	}
>  
>  	unreachable();
> -- 
> 2.21.0
> 

Thanks!

-Kees

-- 
Kees Cook
