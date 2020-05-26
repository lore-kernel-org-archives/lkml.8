Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F28C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34A4520888
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590520978;
	bh=6On+KNxi2h+8pn98CNm7T673+q/i/0hDn4FTzkTPWtA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bG2o3O/Epap1rgxpPhA1cD4N+6sifymbQvpny//EpZWXAhkMUPd8SKQdDJGIeVaFs
	 iQhEZqhzy+mTjHdMD9oy0PNqB5cs6BdPUlZmmx5WchP/pywvJJ/49kxUE5g/gvqSl6
	 G8+yl2DLSc6WFImLL0/kGDDt5qkIsy/qVfOiBBlA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403773AbgEZTJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390459AbgEZTJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:09:37 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EB9C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 12:09:36 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id w15so12940090lfe.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 12:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pi7IfY8EL+u6ttkRQz4iCrS9Fa10FeMQvAFvCPT5Q1o=;
        b=d4/CJAZZ4MGGFhSRIPRhWDkI9hNgjugJ81vx1Pai5jXBREs/3FdcNld4cAowD7a77m
         rDrWSV/dLZRqrcxqc/fWmo3wipA5zOocQdPUxfi/9hs6bsQW8gqWqpMc2MVLF2kzLc66
         wDFSaBIu7gdvdelSIp294R4Os1XqDz8Dull78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pi7IfY8EL+u6ttkRQz4iCrS9Fa10FeMQvAFvCPT5Q1o=;
        b=UiDYiTUsL9HMhd9LQ87YFd1FeDnf8A5FxasTlEyROMks4myXUUUcMWIrfB5/8mce65
         HsSfM4cOxNTPLw/18G1NqNIb7JuNwqD6BJov1MGyfALaA9snUGpGC0CGSbcoP6ULfXKs
         azxnAqpcafjJPv07tPaoLDYwoCvaQLmcHvwM+soUA50ZdEdOTwt+IQ7qPp7LpPNA8nza
         jIAfHjP/gQgoBa6uEYdT/fu9Wamlf9oFRudSdUN1M9e7vcWNNrg28+H9nhl22TLb4dDq
         L0tnC32Ao6Fg3H0OmlM8vsNLaqx7+Lp/nqwQP/a0tdx69vhLdnutYxP69Vtbnxtr3OmT
         rSaA==
X-Gm-Message-State: AOAM5339ZHnzqtvT2/oiEVS8W4Y8vzlxhRza5kMfbNzQI+d8Ge3dkRMN
        qBbh+rnwcXLW//1wrc2GGfbasdMWsYs=
X-Google-Smtp-Source: ABdhPJzlAuSvfHcSBhKdPAoY3VFkY4CFAudPVWBi4QjbQ+vGRzJwTmKc2oRPS83xmneT1ZJzmPiRkw==
X-Received: by 2002:ac2:48b7:: with SMTP id u23mr1217452lfg.86.1590520174130;
        Tue, 26 May 2020 12:09:34 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id 72sm174361lfa.52.2020.05.26.12.09.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 12:09:33 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id h188so12997647lfd.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 12:09:33 -0700 (PDT)
X-Received: by 2002:a05:6512:62:: with SMTP id i2mr1167668lfo.152.1590520172727;
 Tue, 26 May 2020 12:09:32 -0700 (PDT)
MIME-Version: 1.0
References: <871rn6a6e5.fsf@x220.int.ebiederm.org>
In-Reply-To: <871rn6a6e5.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 26 May 2020 12:09:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh5cddDjyS2Av57Oc=qaowkx0XrtuJN=sErcq08qpnb7w@mail.gmail.com>
Message-ID: <CAHk-=wh5cddDjyS2Av57Oc=qaowkx0XrtuJN=sErcq08qpnb7w@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull exec fix for v5.7
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 11:42 AM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> While working on my exec cleanups I found a bug in exec that winds
> up miscomputing the ambient credentials during exec.  Andy appears
> as to credentials are computed for both the script and the interpreter.

Can you rephrase that?

I tried to figure out what you were trying to say, and I can't. I
suspect a whole line or two is missing, or you were re-writing that
thing and stopped in the middle or something.

I'm also somewhat confused by your placement of that

        new->cap_ambient = old->cap_ambient;

which doesn't seem to make a lot of sense. It's before the code even
checks that the old ambient is valid, which I guess doesn't really
matter (an error is an error, and the newly set state will not be used
in that case), but aside from that it's just in an odd place.

It's not near any other code that affects the new capabilities.
Wouldn't it have made more sense to do this where we then clear
cap_ambient if it's a setid binary?

So this pull just confuses me for a couple of reasons - I'm not saying
it's wrong, but at a minimum I'd like to get a merge message that
makes more sense..

               Linus
