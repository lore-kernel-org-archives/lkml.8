Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C04BC4332E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 18:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E0A20784
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 18:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584989805;
	bh=MYdkl/jxDbJfyu2GWw/TLeKg+7Fd0BLq2i0Btmr7zWA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OA1YY1ZnFJmgkrgOh/fZ328oY/bPHFk2SXlnKMrNdUwC5b9eWTnEdog1NC1J+Qwln
	 UpP/gaXHVb9eweWy8fjl8Rem6bGeGd/YO3Qn9hDH3ZO7LABt7+/wRXiSNBowFKcKZZ
	 O5uZuTJhBK0unoEkV8Y96eSouMkAMa4hzvD1rEtI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbgCWS4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 14:56:44 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33340 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbgCWS4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 14:56:43 -0400
Received: by mail-lj1-f195.google.com with SMTP id f20so4025ljm.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 11:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LnAuRr24BeBiCaWRmNKvs3htfBw7kg4EbtNTvA2ob3Q=;
        b=g/uC/iqqSI1SlqsN/VoEJ65Z/HqOKhFNEyGaoJ4orgECAB/IB/W/u4x5nZnbDO9sFj
         A3Z3+JVlznfF9YYCrnOsbClSYp19qyZqYpr5w6Ya9TiQc5bl4hlnZ2ZHZ3DELInljExR
         Tk0SZNI6CnjH4KEI5Bd6+PPGvc5mptTz3sClA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LnAuRr24BeBiCaWRmNKvs3htfBw7kg4EbtNTvA2ob3Q=;
        b=X9aeVYXRsdqHCaDpD3qncbGckN3JmtijweyhPvwIkA+XU+REjs1FTr7iGHsLpzEBdS
         jSnTMhLFA6c+VMKw+f3tGQU5B/aJGO92u3XghLUuVc22D+CLxpJGLRZgc07SsjUA6GmV
         YN4ygSg+6ixWjM9D7wJJR8LAYrvJSQZwKQJ9RppdJwWEV5pCd3NzUMt/63YT06GnlVIP
         hOdf5Ev76c57L6zxei4qXVXpZUEFEhf86wpg5G7nVECbvr2IdO/vooJBTqRI/lLu8L3x
         xQeCZskn94HJw9/xhmq3xYUhJK0NwjIgrKGT93casDyPOqVrIwJO/2QRGOrsfBVn5nmH
         W7CA==
X-Gm-Message-State: ANhLgQ16KIoXl8GJZ9EUqwoKtOVDlef82mND+T1KOI/ExzHiBjfwwE0F
        +3bSl6AOxcKKj0Y9zexbfP2l61vmJMM=
X-Google-Smtp-Source: ADFU+vvki6UM4dxpPXcP1O5We13geyzXWbIP2g9tdlhUhRQHo/sadxIbNwUqe4Nop7y5yqEcvtKtYw==
X-Received: by 2002:a2e:6809:: with SMTP id c9mr6749001lja.251.1584989799633;
        Mon, 23 Mar 2020 11:56:39 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id i18sm8903190lfe.15.2020.03.23.11.56.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 11:56:38 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id g27so7046465ljn.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 11:56:38 -0700 (PDT)
X-Received: by 2002:a2e:b4cb:: with SMTP id r11mr397546ljm.201.1584989798248;
 Mon, 23 Mar 2020 11:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200323183620.GD23230@ZenIV.linux.org.uk> <20200323183819.250124-1-viro@ZenIV.linux.org.uk>
 <20200323183819.250124-17-viro@ZenIV.linux.org.uk>
In-Reply-To: <20200323183819.250124-17-viro@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 Mar 2020 11:56:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg=Bmjzh=CFcngo+xWK7XWMTH=kLWgxtBjsC4a1-9PuPg@mail.gmail.com>
Message-ID: <CAHk-=wg=Bmjzh=CFcngo+xWK7XWMTH=kLWgxtBjsC4a1-9PuPg@mail.gmail.com>
Subject: Re: [RFC][PATCH 17/22] x86: setup_sigcontext(): list
 user_access_{begin,end}() into callers
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 11:40 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> -static int setup_sigcontext(struct sigcontext __user *sc, void __user *fpstate,
> +static __always_inline int setup_sigcontext(struct sigcontext __user *sc, void __user *fpstate,

Same deal here: just marking it __always_inline is not enough - make
the naming show that this does the unsafe accesses.

So call it "unsafe_setup_sigcontext()" if you're doing unsafe
accesses, so that *EVERYTHING* that gets done in between the
"user_access_begin/end()" is clearly marked as being special.

Not just for objdump, but for people too.

              Linus
