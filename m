Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C283EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A5092073B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590696126;
	bh=aVYxP7+2RyedpkJ1nyED5/t7IMRyTZLYOpD/3LzmIQ4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qEBbbW7jVhJU5GKCPDAp9V6d42wMjIUvXHeku2dlP5HIanxpYdZyrwwe+O8nbJDgZ
	 c9h0rBWou+vwB/NcZ9LTmf4Hx5UlWo9h25ShBSI7JJCCn+57jGBYR0BsRo/o4TPDXh
	 1TJ8K/mbMOTqJSQ6NnZUUSMOj8KV01lafFjpfRGk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406860AbgE1UCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 16:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406768AbgE1UCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 16:02:03 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AA6C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 13:02:02 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id o9so3311551ljj.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 13:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZGVDWib6rFI6u2cHNuBS7q44AMVUuGy+tY1n2uOTWt4=;
        b=alKIs44dXi9rsQbYsZDyQcre3mM659EE40dpxqjve1g6kexznQ9xXZerJ7HdKI/Tqr
         QqO5aRe6isuMMCyk4BWaWjTJY/BGoMMgHptuhk6mTO9gVVxK82kSqYr62iC9vAHZZyKQ
         d+hDOFIa4UloPWuFSrvuOA1thoGC52dN+XEJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZGVDWib6rFI6u2cHNuBS7q44AMVUuGy+tY1n2uOTWt4=;
        b=aZsRaBURk45YVzEtgCmzSHZElBGfq5j7SdFE1CXsgn++F71SNKedVifx/ww59PwkYR
         79LSKwmmv1JRTkvtM5zCMsxGQ8VolOADD9+B5qrqFtEcXpXdDP3Fdy0ii9j0iqvyGjPl
         eizTvHmvIri1HYIaDNrPwibalYIqVOz/6Xxwi+7gWjqfUOALcLeO2HW3AzaNnJOn2Ddi
         zAD+mbeFbe/9j1nlS4INb4SwZ/DHBhSMDuFdXLxq7pvwNPXx467FlAz/27EjJB4u4VQX
         VJY6wHGV1WBbOPNgStkquhuuVqtQjy3v1Jp6l2L07n+cE82Mvks+G3b4rU66LSusS9dE
         79xw==
X-Gm-Message-State: AOAM533+tjZPsmW2TqcgjzL0lgVE5vnkdrg6PMVXXv+Sw1pN7TTjC7x0
        iJfu4NOdPr+KV6TBLDitqI9obz0sXMI=
X-Google-Smtp-Source: ABdhPJxNHoszfLWCZ3WCfkuhCzuVKMFO78Elz5ZLqqrPpwImWyoRROaPCCXkATjoL2kIJyisIFUMoA==
X-Received: by 2002:a2e:b0e6:: with SMTP id h6mr2107848ljl.178.1590696119463;
        Thu, 28 May 2020 13:01:59 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id q8sm1616968lfo.13.2020.05.28.13.01.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 13:01:58 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id w15so17266381lfe.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 13:01:57 -0700 (PDT)
X-Received: by 2002:a19:6a0e:: with SMTP id u14mr2466293lfu.192.1590696117511;
 Thu, 28 May 2020 13:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <e3b30905-4497-29b4-4636-a313283dbc56@i-love.sakura.ne.jp>
 <20200528065603.3596-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200528110646.GC11286@linux-b0ei> <e0d6c04f-7601-51e7-c969-300e938dedc0@i-love.sakura.ne.jp>
 <CAHk-=wgz=7MGxxX-tmMmdCsKyYJkuyxNc-4uLP=e_eEV=OzUaw@mail.gmail.com>
In-Reply-To: <CAHk-=wgz=7MGxxX-tmMmdCsKyYJkuyxNc-4uLP=e_eEV=OzUaw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 May 2020 13:01:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjW+_pjJzVRMuCbLhbWLkvEQVYJoXVBYGNW2PUgtX1fDw@mail.gmail.com>
Message-ID: <CAHk-=wjW+_pjJzVRMuCbLhbWLkvEQVYJoXVBYGNW2PUgtX1fDw@mail.gmail.com>
Subject: Re: [PATCH v2] twist: allow converting pr_devel()/pr_debug() into snprintf()
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 12:50 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I still don't understand why this small set of random options couldn't
> just be kernel options that get set on the command line, and that have
> independent and sane and explainable behavior? Why this odd mentality
> of "syzkaller is special"?

And just to clarify: the kernel option wouldn't be "syzcaller_twist"
or something insane like that.

It would be something like "kbd-disable-hotkeys" or whatever: actual
real text that says what it does.

             Linus
