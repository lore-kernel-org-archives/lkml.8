Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F87C10F28
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 16:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B3F2087F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 16:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583684041;
	bh=FOZtm+sZaEsklmiN4Qru2br3I5Q+K2JFdHn+lydCpto=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Q+16K52qbemxxaV3I5D7+TXFR61VMQSvYpWjELwe/34bmgWWiehTgbxom7gKKNQLW
	 lO0RC/Rnd6243RaPNi/cZJ+F3VouPMgVQXfwCMHlT/5hObmyDq5DE83ANQ+LNslFha
	 OpBExI+pLZ2DWWE5rx/uNqi2rVGFj2mK/zTRQMr8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgCHQNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 12:13:39 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45506 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbgCHQNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 12:13:39 -0400
Received: by mail-lf1-f65.google.com with SMTP id b13so5607505lfb.12
        for <linux-kernel@vger.kernel.org>; Sun, 08 Mar 2020 09:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9fflaZi2UDVZ02k3k/RokCFQn7Pfzg3BqnCFeFHrwcQ=;
        b=Ux/BYy2D/0BDknBxP5XF9Vb2SrCqej/YbyUgzxQBobI82+SW8igeOOJgYKgOJtn91T
         mETvuGT4urqeqoyB0ElzLJdBrz2kvodpdZjNjutIhUdQqLnc/A1fHT2rat/oT0va8VcT
         w+SBkQpVXN5KHhjtJzkptAkJQugKS/A3o02yQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9fflaZi2UDVZ02k3k/RokCFQn7Pfzg3BqnCFeFHrwcQ=;
        b=EI87H+rGqy1wZNnf0Wcez3DzgkAUoZYifsGoKYU9EOd09JdHGDFxuL9F/1JZhpVVrp
         tf/lMD9jez4prVLFDeMnWJoIeEiQAyEJ1EKMYsbzD8iFcoRffQsxOdSuf1uhx6YaZ8vh
         oOvzkw3OP7UA/URnOhmZ0yvYryYIX3t4gnpSPHjDJJS6ArNF+CamXZolZjnDTQlenmLt
         truLNL5+hCkF5oWSNNjlLT+nohYyCAZZfIZ+64xJMW7+lHmklY63iMOB4DjbJiKa0OaA
         VP/0NtCGeyvvKArF/nETDoUdWzO4I3frHlIArFCk+ZCEqy+bwsn6uL3SJN8b1lYL+QuB
         Ehhg==
X-Gm-Message-State: ANhLgQ3UxQOz4fLsHooiklUN2p4WwuNTKk9cZy2CqXK2lb/+i//SzWV2
        znljWZZT+7RlOTYA42O5Abe/M8W6y0Kzpg==
X-Google-Smtp-Source: ADFU+vtXO5PQFviPwagcISv4C0OxCOm+P96reUnHOdxtGU67FdyGD3ZEqb7R9UGk3G8mZ/cEhQKJng==
X-Received: by 2002:a19:4856:: with SMTP id v83mr7216667lfa.151.1583684014526;
        Sun, 08 Mar 2020 09:13:34 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id l8sm6197291lfc.31.2020.03.08.09.13.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Mar 2020 09:13:33 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id n20so4306891ljg.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Mar 2020 09:13:33 -0700 (PDT)
X-Received: by 2002:a2e:5850:: with SMTP id x16mr7075784ljd.209.1583684012806;
 Sun, 08 Mar 2020 09:13:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200307135822.3894-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <6f2e27de-c820-7de3-447d-cd9f7c650add@suse.com> <20200308065258.GE3983392@kroah.com>
In-Reply-To: <20200308065258.GE3983392@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 8 Mar 2020 11:13:16 -0500
X-Gmail-Original-Message-ID: <CAHk-=wjCcCmQig8w8QEfyqyXACLzDc7b4TSW-KzAMzmS-QvJ+Q@mail.gmail.com>
Message-ID: <CAHk-=wjCcCmQig8w8QEfyqyXACLzDc7b4TSW-KzAMzmS-QvJ+Q@mail.gmail.com>
Subject: Re: [PATCH v2] Add kernel config option for fuzz testing.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Garrett <mjg59@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 8, 2020 at 12:53 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> No, anything that just evaluates the code should be fine, we want static
> analyzers to be processing those code paths.  Just not to run them as
> root on a live system.

So I can see the reason to run fuzz testing as root, but I have to
admit to hating the "special config option for this" approach.

I'd *much* rather see some way to just lock down certain things
individually. The patch in here just added the config option, which is
the least interesting part.

The things that that config option then would want to disable - those
are the things that maybe we want to have a way for the system admin
just generally say "disable this".

Nothing to do with fuzzing, imho.

            Linus
