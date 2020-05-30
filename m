Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3B2C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 05:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD3AD2070E
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 05:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IdNDjOgm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgE3FrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 01:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgE3FrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 01:47:15 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0F5C08C5C9
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 22:47:15 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d10so895499pgn.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 22:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BoA/INZroFtItV/iUCz8gafV2NQduUm36i/XBcyO+xs=;
        b=IdNDjOgmnKyOBVD4OE2Bbr+JVCa3HtAad+vPplvuE/NQ2TQBeUBKuN3eOnYe9ko9vz
         kVRWouLyEZhhX5piOnBKhSPr7n4REkNha/cIX3tZ9HpQsham7Pyguyvl+85b9EThRi+v
         1KpF/zXkxX927vBWirEKwoQLi/urVq5wnNnzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BoA/INZroFtItV/iUCz8gafV2NQduUm36i/XBcyO+xs=;
        b=UAVwajc05bZ2bifDlvb2KdKcilOmKZGGEJmNnY2aIBukUqqjAfjV90X5qTQY3c/QoL
         LfClNWC7z5UgiOE/bgpd1IF7sSQrY1IX03zWOdsgtFZ2G/Un5wOC8PYaE9kGM77xLrML
         7KmtGbq9DNd2+aynsb1wybKbKQKqxeHeBHKLpP0h0jk9EPu6EviaoWF/F2GyxCUhKWOf
         V28MALYjTaeT7BnCFsaCUe1QGgIw4jmBy+0QhMJc+itLbGmhlP/+U4eSmVgOgOZkeyTk
         NWkS79zjffA9NmPG6vjuf/5I33xO/8ApynvEJTcnsEe1J6bvWZYs78wybi6TWX1i0siL
         SZmw==
X-Gm-Message-State: AOAM533eCa7n+eHAGbBwj//OE54FatVyW3TYZ7s0mgLThSurWkTr6fqL
        190jxKbWoIZDGvwtAPdcrfsJHQ==
X-Google-Smtp-Source: ABdhPJy4BQ/Ta88jdkynZNCghHVwX+7gTVf3Vx5bheGiuOzFi1retuxn/WT8Bu/XzYZBrlA9f0H2OA==
X-Received: by 2002:a62:b402:: with SMTP id h2mr12316432pfn.221.1590817634467;
        Fri, 29 May 2020 22:47:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y5sm8630017pff.150.2020.05.29.22.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 22:47:13 -0700 (PDT)
Date:   Fri, 29 May 2020 22:47:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     christian.brauner@ubuntu.com,
        containers@lists.linux-foundation.org, cyphar@cyphar.com,
        jannh@google.com, jeffv@google.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, palmer@google.com, rsesek@google.com,
        tycho@tycho.ws, Matt Denton <mpdenton@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 2/3] seccomp: Introduce addfd ioctl to seccomp user
 notifier
Message-ID: <202005292223.1701AB31@keescook>
References: <20200528110858.3265-1-sargun@sargun.me>
 <20200528110858.3265-3-sargun@sargun.me>
 <202005282345.573B917@keescook>
 <20200530011054.GA14852@ircssh-2.c.rugged-nimbus-611.internal>
 <202005291926.E9004B4@keescook>
 <20200530035817.GA20457@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200530035817.GA20457@ircssh-2.c.rugged-nimbus-611.internal>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 30, 2020 at 03:58:18AM +0000, Sargun Dhillon wrote:
> Isn't the "right" way to do this to allocate a bunch of file descriptors,
> and fill up the user buffer with them, and then install the files? This
> seems to like half-install the file descriptors and then error out.
> 
> I know that's the current behaviour, but that seems like a bad idea. Do
> we really want to perpetuate this half-broken state? I guess that some
> userspace programs could be depending on this -- and their recovery
> semantics could rely on this. I mean this is 10+ year old code.

Right -- my instincts on this are to leave the behavior as-is. I've
been burned by so many "nothing could possible rely on THIS" cases. ;)

It might be worth adding a comment (or commit log note) that describes
the alternative you suggest here. But I think building a common helper
that does all of the work (and will get used in three^Wfour places now)
is the correct way to refactor this.

Oh hey! Look at scm_detach_fds_compat(). It needs this too. (And it's
missing the cgroup tracking.) That would fix:

48a87cc26c13 ("net: netprio: fd passed in SCM_RIGHTS datagram not set correctly")
d84295067fc7 ("net: net_cls: fd passed in SCM_RIGHTS datagram not set correctly")

So, yes, let's get this fixed up. I'd say first fix the missing sock
update in the compat path (so it can be CCed stable). Then fix the missing
sock update in pidfd_getfd() (so it can be CCed stable), then write the
helper with a refactoring of scm_detach_fds(), scm_detach_fds_compat(),
and pidfd_getfd(). And then add the addfd seccomp user_notif ioctl cmd.

-- 
Kees Cook
