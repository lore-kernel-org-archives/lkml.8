Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105FDC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 18:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7845208E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 18:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585851232;
	bh=pYGJneW0Bmp2tknxwrSzJcXNsyUA/ThNVaxlj6nTfhs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1zB9CA2w4FvOzdUqI0QnMd78WUfzIXjenOSsd643CEVuDwFzuaU0yB/7rQ7BtyEQl
	 5/OMamV23H2OC97hPXcsQHcaINI3JJakw13/b/Cqwm3A6g3mXwheNDAs+CtRzoVG7M
	 ilOpwRpZ8wMQS/0An+0xGnobylKil4dCuA7TmtFk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388408AbgDBSNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 14:13:51 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:33400 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgDBSNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 14:13:51 -0400
Received: by mail-il1-f194.google.com with SMTP id k29so4595756ilg.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 11:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vi4zRrqziAo04k8rvHrmlLJFgzlYKjS0kTdMFuK1Z6s=;
        b=PwtgFMlDrJr+T28ZgQPXqQRSdILsngq+W1wXnrJr0HnNPBzjyzGM8othw5MpjAWkUK
         e0WUNoIkV/j8sz1z/DHE6eKw6stKTcfqusX+IAAG5LYgCrbZdxCo+E9pUfk0hCMXI7ly
         5uu2EPMSO6rKiE9FUZd/rqM2Ht3RpePu6jJ2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vi4zRrqziAo04k8rvHrmlLJFgzlYKjS0kTdMFuK1Z6s=;
        b=k/Kfju3a06iQC85ChNOGLScRoUEeyNU2ZmjlNfSq6PzhnoMlzcxBEtgQFmFJibxsC1
         kUuIMD5c2B4pgE7UHdLTVKAZXhg0bOe+uyyFpEnicLbydjdDw6Esz6U/nFGXPXpa5T2P
         EhbHXTlF84xiYEAdJZGR5b3wXuqhEXghHv+c/1/XFgHh2MDxwug6uh8cyJbFT/BoiXaT
         9SiNH5GGqRhDStUhUCCSi5N5es4kHaqYOf9BvzNmBF295ck9aYPQwrnwQs8RfSEurFZU
         TQ6hjjFOXhayOJCb4YXzlnq7qVouPVvxmjLfHPprvEbzy8W7EOfVVyk0r1ykYeU1ePJs
         lkeA==
X-Gm-Message-State: AGi0PuZGW3RMFK0Kf/yzjWuXmH3FoObJKgdykwvdt2H+bS5GRywC1Fd5
        ReeXagi7ZIWfP6X4gXcm3bCjGwVynaA=
X-Google-Smtp-Source: APiQypJYxEfMlQFWCfe39iBwlFHgaWPrl5rl1fl8hp33OhGdvK07Lk/oLMEeoCrc6tnL02PP1xfgrA==
X-Received: by 2002:a92:79cc:: with SMTP id u195mr4761015ilc.131.1585851229151;
        Thu, 02 Apr 2020 11:13:49 -0700 (PDT)
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com. [209.85.166.177])
        by smtp.gmail.com with ESMTPSA id v11sm1966292ilk.68.2020.04.02.11.13.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 11:13:47 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id j69so4530894ila.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 11:13:47 -0700 (PDT)
X-Received: by 2002:a05:6e02:543:: with SMTP id i3mr4909476ils.223.1585851227538;
 Thu, 02 Apr 2020 11:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200331080111.GA20569@gmail.com> <CAHk-=wjpBohNkBSxyPfC7w8165usbU5TuLohdbPs+D0bUYqJhQ@mail.gmail.com>
 <CAHk-=wijWvUfEkqUZRpvo9FCaJNsioS_qZT+iNWUdqQ6eO8Ozw@mail.gmail.com>
 <87v9mioj5r.fsf@nanos.tec.linutronix.de> <CAHk-=wh3_WTKeR=TTbPpbJYjC8DOPcDPJhhoopTVs3WJimsT=A@mail.gmail.com>
 <20200402134051.GC9352@zn.tnic> <CAHk-=whCw-WFbHhq6uYZcXrMEoi4y_FhZk48adf4JePxBzmFsg@mail.gmail.com>
 <20200402172443.GG9352@zn.tnic> <CAHk-=whhJmgbBaz9s=+OPgBVRyYOweLB=4n42snqSRJ7WePwFw@mail.gmail.com>
 <20200402180359.GI9352@zn.tnic>
In-Reply-To: <20200402180359.GI9352@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Apr 2020 11:13:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=whkQwEJxg9XBO9nBk=aCade8Obk+EvVjzTRT1R+nq3eYw@mail.gmail.com>
Message-ID: <CAHk-=whkQwEJxg9XBO9nBk=aCade8Obk+EvVjzTRT1R+nq3eYw@mail.gmail.com>
Subject: Re: [GIT PULL] x86 cleanups for v5.7
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Matz <matz@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 2, 2020 at 11:04 AM Borislav Petkov <bp@alien8.de> wrote:
>
> My only worry is that if we had that support, we would have to keep two
> versions of the facilities which use it - one with asm goto with outputs
> and one without.

That's why it took three years for me to merge the "unsafe_put_user()"
stuff. I only did it once other issues had made PeterZ and people
decide that "asm goto is a required feature" for some of the other
stuff (static branches, whatever).

Because when it comes to small details like "we can remove a test and
a branch", it generally isn't worth the code complexity to have two
different copies. Particularly with how messy uaccess.h was.

The reason I did the additional uaccess.h cleanups was exactly because
I think I can have a CONFIG_ASM_GOTO_OUTPUTS thing, and minimize the
differences the same way we minimize them with CC_SET/CC_OUT doe the
__GCC_ASM_FLAG_OUTPUTS__ compiler support flag.

I haven't actually sat down to _do_ it, though. I spent several hours
on the cleanups as a break from pulling stuff during the merge window,
but this _is_ my busy time..

              Linus
