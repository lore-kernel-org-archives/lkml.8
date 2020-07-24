Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECAAC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 00:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95D3A2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 00:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsZog7S2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbgGXA61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 20:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbgGXA61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 20:58:27 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE785C0619D3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 17:58:26 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id t131so8243344iod.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 17:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=/hwv8aeqxQFc770ydGll5SHnDNU+mIuRLVZfjHpDppo=;
        b=bsZog7S2uysndCYTS9xU78SThmFHV2CSeD4zHXCLHovasdnKb8u3qK3v+6EtCW20bH
         9l608OBF/dlVCJlXKBBWnvHCzEAHK/OjKEI2ZvGZGC9+VavITM6HqtZBFKlSv1xG6hdB
         TCB4ZmEZ4VmkVaYJuRy0fx1I1X8ugF/Rccv9tz3XvqytDzumE8eIdCNn0BaelrGKCGCj
         hxuhO0FVXYhnRKFTe+CbVZjbaSEZ9NAE3B95kyGyrI9QsjPVthVqi0cn0/cC+VZ/MP3i
         H2JbYkLhmJu5YiCqqmrv/LaOOt75F3NeYl3o0Azduiy6PmZz1/LR3i+Mk+BpKU8I7lJq
         K62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=/hwv8aeqxQFc770ydGll5SHnDNU+mIuRLVZfjHpDppo=;
        b=INcxi88qcIfkFg0N5FsNxVgDMMyo9udWo1AJEzbgXLufLpjjmQ0A0O6G95ZSHXqOez
         jaGX+FRSeNYk9KLyBFWuQ4+R5vcTbTQaqV7l+unL9fxKAVCh9akDdJmoy4OsA494uRlN
         dgPKSf6DNygl6aeMp+pGGNVQa5M9rcz9YjbF4T+vjJfUZ8KPA9+3dbsuS0FfxCTFn7fj
         U3kMiyZZldoBOd5VMPZCyuuHlAk/tNfD8grMooZtcfKCxKhcIOjeZdVj4cCembDzjU0H
         TUHZ/rEDe7oV+p1/5HKpduwwp+4M+wIPxSynnoq8ay/b85DHfKzY6O3H4PYPZc6rGMlj
         WOzg==
X-Gm-Message-State: AOAM532CnBwAEA7L19R3puQ0jjDMeYNmBe5v9bBTK5fvhGyVgz91wcvA
        ASEfVJ3nEtD4xZsLO3TwJKrMrdDJa9Ksq9z4nn8=
X-Google-Smtp-Source: ABdhPJybKuecvvTfI1D+tt2La8TEvNnz33oTLTz2XwvoV6KBpR10uLyg+gK49AQxUsPUYk9R6OFs5Ujxdc87E1G8ZSo=
X-Received: by 2002:a02:a909:: with SMTP id n9mr7893683jam.70.1595552306254;
 Thu, 23 Jul 2020 17:58:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200723205811.1104520-1-ndesaulniers@google.com>
In-Reply-To: <20200723205811.1104520-1-ndesaulniers@google.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 24 Jul 2020 02:58:15 +0200
Message-ID: <CA+icZUX0jMSmE1ruCKxEyMN2-qWgPLcGHmUJ8XUz3XD6G6CT2w@mail.gmail.com>
Subject: Re: [PATCH 0/2] tracepoint bugfix and cleanup
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 10:58 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> The first patch fixes a reported bug in iterating the
> tracing/printk_formats sysfs node, and is tagged for stable.
>
> The second patch is a small cleanup and is less important than the
> first.
>
> Nick Desaulniers (2):
>   tracepoint: mark __tracepoint_string's __used
>   tracepoint: used attribute definitions from compiler_attributes.h
>

Forgot to CC CBL-ML on...?

2/2 tracepoint: used attribute definitions from compiler_attributes.h

I didn't see it in my inbox.

- Sedat -

>  include/linux/tracepoint.h | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> --
> 2.28.0.rc0.105.gf9edc3c819-goog
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200723205811.1104520-1-ndesaulniers%40google.com.
