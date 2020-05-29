Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31E4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 03:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8514320721
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 03:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590723768;
	bh=nlJ7XGjhXqoaT2+Qzcx6TtsURlGROuObxiaUNBRgc8c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uRsRQHlUusjJirWYFIqQxYeFznhFeMRsH+IRCXo8IYDohYnSWjc2JOX6bfJoza8tO
	 tdwpxfo+qi35eYgFCNbMy4R8s0HcZ6EuXzmgSb1Tt6o5qLT0V8vySgKJx89LzwcFy3
	 h/CqaWZQ9mwd2G+rfqZUQ8V2Ak26JNfWAtgddS98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406663AbgE2Dmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 23:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388880AbgE2Dmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 23:42:45 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CA3C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 20:42:45 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id b6so842367ljj.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 20:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ykCqer43vvinTLl1/KaSTddkvLcnjIn2m2bT/JiFhwY=;
        b=E2rNqx0swaCy081n6r34uQJWGEBtWcGNDZzf83xsFcZDAUMLwb8XgmJ5cMfUy50Whw
         Q13wMk7KW68F+h5PLSKyBMeYVXY/H3tdiRjBMyTs1/9BXGS7QKjCvNYoq9h9U7oAv/RJ
         lbHJGbX8Jd1OJmqDQDSIzju38gQE7bg+bU298=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ykCqer43vvinTLl1/KaSTddkvLcnjIn2m2bT/JiFhwY=;
        b=rIx1RNiyX6iItsWAtQnpkBUISf+SstHrxME79TwcZb7hjb+zwr/WE6wqeH5hjAK6Nx
         /NFjnV5CFT7pScgkWZhWp2klO1Ve+fU7W2Rcnd5K147FUghMzq7fhh3uG+hqZpMWOVIX
         RMIHjG7gJNWxQ4m4vjWstZ+KZuC3OO5T4dLROQHnN+gKVAOF9g1L4OePCSsCDJjHIF8G
         0UsqD1jy6vgfo1ZHK3SqEmWmr51L2EbJg12aNRhR5RSLGBHTKjkvSfTWenOStM+05rBo
         tNeh7FkHhNnAS2ZMg1qxCtxxBOzq/uq7R8NQVZagshqPGk+PHfWWhgRekeJHZJKSkF2F
         IkMQ==
X-Gm-Message-State: AOAM5305dln0Roiwp1Vw5hGev6WrXWOrSzdSx7/BCYJ9Y6cC9ZTLGjsW
        DRlLcAeCwimeL/wznTVg5q8nGAnmA7Y=
X-Google-Smtp-Source: ABdhPJwiOxj+1b3HUlWVz2PJj6eKet/6vD+npnEzyY07IGpre0iSCJRaSdhqoKZdKZ/0ZRzcfmVB6w==
X-Received: by 2002:a2e:95d2:: with SMTP id y18mr2896006ljh.342.1590723763368;
        Thu, 28 May 2020 20:42:43 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id k27sm1976702lfe.88.2020.05.28.20.42.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 20:42:42 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id e4so827839ljn.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 20:42:42 -0700 (PDT)
X-Received: by 2002:a2e:9f43:: with SMTP id v3mr3270285ljk.285.1590723761862;
 Thu, 28 May 2020 20:42:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200529000345.GV23230@ZenIV.linux.org.uk> <20200529000419.4106697-1-viro@ZenIV.linux.org.uk>
 <20200529000419.4106697-2-viro@ZenIV.linux.org.uk> <CAHk-=wgnxFLm3ZTwx3XYnJL7_zPNSWf1RbMje22joUj9QADnMQ@mail.gmail.com>
 <20200529014753.GZ23230@ZenIV.linux.org.uk> <CAHk-=wiBqa6dZ0Sw0DvHjnCp727+0RAwnNCyA=ur_gAE4C05fg@mail.gmail.com>
 <20200529031036.GB23230@ZenIV.linux.org.uk>
In-Reply-To: <20200529031036.GB23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 May 2020 20:42:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgM0KbsiYd+USqbiDgW8WyvAFMfLXMgebc7Z+-Q6WjZqQ@mail.gmail.com>
Message-ID: <CAHk-=wgM0KbsiYd+USqbiDgW8WyvAFMfLXMgebc7Z+-Q6WjZqQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] dlmfs: convert dlmfs_file_read() to copy_to_user()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 8:10 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> BTW, regarding uaccess - how badly does the following offend your taste?
> Normally I'd just go for copy_from_user(), but these syscalls just might
> be hot enough for overhead to matter...

Hmm. So the code itself per se doesn't really offend me, but:

> +static inline int unkludge_sigmask(void __user *sig,
> +                                  sigset_t __user **up,
> +                                  size_t *sigsetsize)

That's a rather odd function, and if there's a reason for it I have no
issue, but I dislike the combination of "odd semantics" together with
"nondescriptive naming".

"unkludge" really doesn't describe anything.

Why is that "sig" pointer "void __user *" instead of being an actually
descriptive structure pointer:

   struct sigset_argpack {
        sigset_t __user *sigset;
        size_t sigset_size;
  };

and then it would be "struct sigset_size_argpack __user *" instead?
And same with compat_uptr_t */compat_size_t for the compat case?

Yeah, yeah, maybe I got that struct definition wrong when writing it
in the email, but wouldn't that make it much more understandable?

Then the output arguments could be just a pointer to that struct too
(except now in kernel space), and change that "unkludge" to
"get_sigset_argpack()", and the end result would be

    static inline int get_sigset_argpack(
          struct sigset_argpack __user *uarg,
          struct sigset_argpack *out)

and I think the implementation would be simpler and more
understandable too when it didn't need those odd casts and "+sizeof"
things etc..

So then the call-site would go from

>         size_t sigsetsize = 0;
>         sigset_t __user *up = NULL;
>
>         if (unkludge_sigmask(sig, &up, &sigsetsize))
>                 return -EFAULT;

to

>         struct sigset_argpack argpack = { NULL, 0 };
>
>         if (get_sigset_argpack(sig, &argpack))
>                 return -EFAULT;

and now you can use "argpack.sigset" and "argpack.sigset_size".

No?

Same exact deal for the compat case, where you'd just need that compat
struct (using "compat_uptr_t" and "compat_size_t"), and then

>         struct compat_sigset_argpack argpack = { 0, 0 };
>
> +       if (get_compat_sigset_argpack(sig, &argpack))
> +               return -EFAULT;

and then you use the result with "compat_ptr(argpack.sigset)" and
"argpack.sigset_size".

Or did I mis-read anything and get confused by that code in your patch?

                 Linus
