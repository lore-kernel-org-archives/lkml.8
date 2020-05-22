Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C70C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 20:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C1E3207CB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 20:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="BzuSYVIp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730968AbgEVUJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 16:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730893AbgEVUJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 16:09:25 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0AEC061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 13:09:25 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id r2so2339028ioo.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 13:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kuxuFImJXS+zMVZOoAVroX3dwfGV7HwfDMWssbC5C1A=;
        b=BzuSYVIpXA7rbNJiFsgqADe+GidjdLuozlif6nBYsRt6MchS6kYsgk18V3kI5F15Dx
         7VNYp9f9kKkWxdE9juayukb2eICEmxERuBAcGpn8aX1Q1jvanglLeWKvsSVhpJGj1C1i
         eFAXZDT+sRebaynrWit+kYbtLiiUZNaTpxeZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kuxuFImJXS+zMVZOoAVroX3dwfGV7HwfDMWssbC5C1A=;
        b=pn/vYQDAQloCs4MS4AC7MO0yC9lb8yNM9wm0rqJi6Q60Un0iWrGGuWXxCgW6b9npRW
         D1MGS+gKGYOlXD/okgLRYzKGkmF0+efmDD2hvvFsiaHu5fznxtoXyNxo8F0DBvYIM/VJ
         8FtIUHOmXcBMOrNFHJqxyb0oa6lG+u74eURhzeM3317h6jx6WTIDb5JRWDGmhSgRtJCD
         CPZYydN95FfHbDdGXehiZ/qycjE05+VXFIEIlkJGH6ZnRmMxvlxrh4JLsZVbWpBzXdP0
         hy0eH/CBGtK25t+wYE512mJrNOi7nQgtbyA/AATRbg6hQW9hsIt6DuKcuZV/OrZXO4J7
         Rukg==
X-Gm-Message-State: AOAM532y+ihLdT6mavk6DBp8b8F6qAdr2qGUvPAdkU8bWbJ0OJK7oWxa
        6MoVlU6LC8qYw+egb2VBPeEBxQ==
X-Google-Smtp-Source: ABdhPJzYYCoJX6l85G6846PNwAdJcv17n8+gt3PxXcY9YhA2VI1NbvUsdUKizD6X1uCV3XLQWunh3w==
X-Received: by 2002:a02:942a:: with SMTP id a39mr9629370jai.50.1590178164366;
        Fri, 22 May 2020 13:09:24 -0700 (PDT)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id t22sm4064358iom.49.2020.05.22.13.09.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 May 2020 13:09:23 -0700 (PDT)
Date:   Fri, 22 May 2020 20:09:22 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Matt Denton <mpdenton@google.com>,
        Chris Palmer <palmer@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: seccomp feature development
Message-ID: <20200522200921.GB25319@ircssh-2.c.rugged-nimbus-611.internal>
References: <202005181120.971232B7B@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005181120.971232B7B@keescook>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 02:04:57PM -0700, Kees Cook wrote:
> Hi!
> 
> This is my attempt at a brain-dump on my plans for nearish-term seccomp
> features. Welcome to my TED talk... ;)
> 
> These are the things I've been thinking about:
> 
> - fd passing
> - deep argument inspection
> - changing structure sizes
> - syscall bitmasks
> 
What's your take on enabling multiple filters with listeners being attached,
so that different seccomp interceptors can operate together. I'm wondering
how this would work.

One idea that I had is adding a new flag to the seccomp filter
installation -- something like NEXT_FILTER_COMPATIBLE. When a filter is
installed with a listener, it will check if all previous filters were
instaled with NEXT_FILTER_COMPATIBLE.

If the call is intercepted by a listener, and the return is overriden,
then it short-circuits, and the subsequent filters are not evaluated.

On the other hand, if the continue response is send, then the
subsequent filters are called.

What do you think?
