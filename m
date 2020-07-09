Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E032C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 20:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC73C2076A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 20:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHVkVLq8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgGIUw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 16:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgGIUw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 16:52:56 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A0FC08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 13:52:55 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id 9so3954008ljv.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 13:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fh2AsvdiqBtPIs80v+1OuPIjNrn7s9RuQyFPfypzlb4=;
        b=sHVkVLq8P8Z26hbzD6scTmBB4gmkJS+ZtdGWvu3grwTurjn5/3E2HB3GJ01CWS37bo
         tWBJs24H7vQVvI2+gpzhZnKHeC4kzlIOjliClGT1t9DqwJ6WCxXe/eNwFWLXdpHoS8PP
         wBcGd1ZCIJhO1o1N3iCRHZriNoKbH6XKkPjMFcv1UAjFo4bj5u/DiSvaKiJEJuusRjjS
         9zkWG7tMhe0uQd+coolYdbLQXdEe2z/DLVar22iPEfG7BnBU4vcJ2x75jfrDdXf6XVqv
         7+7afd82HPA/yLLEe6tiSnv27noyQ53CvMN47pmoMRkAjTfKA/Zda1eXMkK2FFtFH6AZ
         OoKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fh2AsvdiqBtPIs80v+1OuPIjNrn7s9RuQyFPfypzlb4=;
        b=srHbBYUfzY5lpyqxeatgfcpgunhdCJbLa4mq7JdXBNNrRpOOUr4nws7cxCGLgTAhmM
         CgoNHFk2v7uHWCJYKUtCm/H6DzmHVH6WkfAqXK5P2fJPjUUoJ5NiryPVVTWhK3nvXzyZ
         yrCY4Yj7JhOGH7aJaKDOdOsFDzqNnwzKemPU+dReN4OViSxFOV0ZPtR4gOfNak/UmA0F
         /khxnwrVGmylCtl0THmwu6B8Ke56KO9v/xM1IELblk9PL+3wSzgc3sFMRvuuRTOyEAcP
         2YzaNiT2gNN20mO2ar9Gx+mklJHpbcHPyeeiXi6cZRrLO9XXDei3/yke05UHo/vJ0qZc
         gxPQ==
X-Gm-Message-State: AOAM530EJP6+s6cjYDNvqCCfslOjg5GFvDwbE0EjkOkNy7uMQl9H6vYl
        Gm87SRXhFacNx7UX+F5dv2mLCd5Dl0zeoOgyhcKNwoVR
X-Google-Smtp-Source: ABdhPJyE3glsyD9QhjYteDniiXEqf7D+KyLAcFcfcclVTVhuIO0c5wDCL8ZJSok3d5oh82avYDkQfU3s3LdoxqE21dU=
X-Received: by 2002:a2e:850f:: with SMTP id j15mr14987332lji.44.1594327974153;
 Thu, 09 Jul 2020 13:52:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdmuYc8rW_H4aQG4DsJzho=F+djd68fp7mzmBp3-wY--Uw@mail.gmail.com>
In-Reply-To: <CAKwvOdmuYc8rW_H4aQG4DsJzho=F+djd68fp7mzmBp3-wY--Uw@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 9 Jul 2020 22:52:42 +0200
Message-ID: <CANiq72n51z9QtFdj1cF72hhQikq7jxCA+TmKKSQcYo34WAPGsw@mail.gmail.com>
Subject: Re: Linux kernel in-tree Rust support
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     alex.gaynor@gmail.com, geofft@ldpreload.com, jbaublitz@redhat.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Thu, Jul 9, 2020 at 8:42 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> Hello folks,
> I'm working on putting together an LLVM "Micro Conference" for the
> upcoming Linux Plumbers Conf
> (https://www.linuxplumbersconf.org/event/7/page/47-attend).  It's not
> solidified yet, but I would really like to run a session on support
> for Rust "in tree."  I suspect we could cover technical aspects of
> what that might look like (I have a prototype of that, was trivial to

Agreed, I wrote one ~half a year ago that compiled TUs through rustc
mimicking what we do with cc to some degree (i.e. no cargo etc.), and
it was quite pleasant.

> wire up KBuild support), but also a larger question of "should we do
> this?" or "how might we place limits on where this can be used?"

Indeed, I would say that is going to be the major topic, not so much
the technical bits.

> Question to folks explicitly in To:, are you planning on attending plumbers?

I wasn't, but it definitely is an interesting topic that I wouldn't
want to miss!

Cheers,
Miguel
