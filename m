Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D780AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A844206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596655784;
	bh=+gY4oOBJ8mrW6kXgW8BhqBGT43wWoNSlmR+GcLP1H94=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=iUwkg3meVGplb+b3MNRDzkoR1R0ytijtCGG737mlfkVBiFOPJEy4MH/j9E1Z7hOfu
	 XjlJ8LX1ECGEnyvL9srGslgyog55sEITjQQx9RAxzwfoprMQhaE8xVG1SzGH0sEzc5
	 WW92Bc1b5B487xHiNEXIzT162Pw6jJTtXxMHHK+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgHET3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728587AbgHET3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 15:29:25 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9CDC061575
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 12:29:25 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id z14so11423990ljm.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 12:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oyP1mU6+ebwH2z4wx3gLMWWnEis6gU/VrLrd1AZyGlg=;
        b=fhlYmL/3y0kHtYeNI3bs4iExuMdI3NUu+EGIEiYSvoTfiDoHjdisaOOXhNzoT6ZyHG
         OOtMakr4cVU5Hpag9vrMwmhHolDGMxnAycaLSeCVrr7FdySR03Cx1kvgw+iXe19F2rNI
         jxRORS0aBWPqFjspy7Ks+36oCD6BpLOSCabEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oyP1mU6+ebwH2z4wx3gLMWWnEis6gU/VrLrd1AZyGlg=;
        b=AZzwZWiEKso2iv532QK7VeQqDKo//Tdf/llMf9NIye+mog0zw/fWE0zSBX/jhgDxVK
         Ou1IKBqFqBejUxEmdX7lgYN9C9AZgXdz3bew08qwX2wu7aiymSABdG0OC8ucOG7c6kFg
         N5t9CZrbTa/8iidvCN1RmfeYy1qoQKnVXX8xVuIm8+vuUJC3uQSJi1HfBJEV96LW2Vgk
         t8mz4UwS1Nig3nRye2C5n6aKLtAzp9BGs1m+Q6ztFD+tUqnDJsXHyZCSIn6IMeROBCDy
         /22GJZGdSLRLZ59sRMr5/eZKNOiMHv1DjsfDhx8oA1ZcvwPRT6pOx8vHU1lQOOV4HKkv
         cSCQ==
X-Gm-Message-State: AOAM533UWZ7UoayyqE2tKhk/Lf+49/Yx3nP8hFoZp7YC+5K5WfpsQHpc
        3E824X5Oy6hxei6Au8oxvUdU5WIY3f0=
X-Google-Smtp-Source: ABdhPJziMrIhvehoqJBjpubbj75FFYhoFbsWoryDNSKvQar+Cf3sphVMJRhuzt4A1+JYMO44MFJUZQ==
X-Received: by 2002:a2e:8904:: with SMTP id d4mr2024937lji.400.1596655761953;
        Wed, 05 Aug 2020 12:29:21 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id m12sm1261519ljh.127.2020.08.05.12.29.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 12:29:20 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id z14so11423866ljm.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 12:29:20 -0700 (PDT)
X-Received: by 2002:a2e:7615:: with SMTP id r21mr2026657ljc.371.1596655760225;
 Wed, 05 Aug 2020 12:29:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200803140726.GA752014@infradead.org> <CAHk-=wg1h_XfPbXvisfAUsXU-WiOeCJDUibhxZGu=x9w-VKB0A@mail.gmail.com>
 <CAHk-=wg9dzJOkvysjgdHv5eFJU76EFAwCxNenRxTtq6VWof98Q@mail.gmail.com> <20200805082845.GA25876@infradead.org>
In-Reply-To: <20200805082845.GA25876@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Aug 2020 12:29:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPwB3uWy9FVzD6yhVnDzY9fHth0WaQ0vqmRThhoU6Wrg@mail.gmail.com>
Message-ID: <CAHk-=wgPwB3uWy9FVzD6yhVnDzY9fHth0WaQ0vqmRThhoU6Wrg@mail.gmail.com>
Subject: Re: [GIT PULL] configfs updates for 5.9
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Kai M??kisara" <Kai.Makisara@kolumbus.fi>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Joel Becker <jlbec@evilplan.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lenny Szubowicz <lszubowi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 5, 2020 at 1:28 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> Yes, but this is a fundamental problem with the commit on close
> model that the configfs binary attributes implement, and we have to
> work around that somehow.  The current behavior is to entirely ignore
> errors, which of course has major issues.

Ignoring errors is better than randomly not doing the commit at all,
which is what that patch does.

> I guess the alternative might be to just commit on every ->flush

That's how ->flush() is designed to be used, yes. It's also why it's
named that way.

It can obviously cause problems too, if you have multiple opens (ie
dup/fork) and one file descriptor is closed while another is in the
middle of a series of writes

But honestly, if you do binary writes to sysfs, you should do them as
one single write, and the flush function should take that mutex and
then skip the flush if write_in_progress is true.

Because in *that* case, it has serialized with other writers and we
know that those other writers will flush when closing, and there's no
race.

You can still screw up by doing multiple independent writes and do s
close() in between the writes, but at some point it becomes a "yeah,
that's broken and nobody actually does that" issue.

                Linus
