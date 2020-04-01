Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83677C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 22:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B9B120787
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 22:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585781147;
	bh=IC4jfBMRmPyPMvnuIoBhvgeO9nc5BkeGIDo25nxH9QA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BPz2Km/8D9Ri4tUcu/G3vSuad9vyiqcTsdW6uJQOYmzCpbxZKsyfr69Y3wGW9O3iB
	 E7zKDCwq3XjAhTCpU4QgWl3wkaNTmG2SfH8gyoL/6C1ustQ6yeN8LXYHwdar22yKrR
	 jPp9o3F4TNmlPF9ZwyL7dW3aCQBREQaWJVX/xba8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388543AbgDAWpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 18:45:46 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35097 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387467AbgDAWpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 18:45:45 -0400
Received: by mail-lj1-f194.google.com with SMTP id k21so1246364ljh.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 15:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9c8qE3qcn/L/b5/Y0N7wYbMH02+9//QHBv0eQQ/FuU4=;
        b=H/wJ4p8U+3BtQeYyXOMSFkuPezkyzi2+f8geb/E5TjtsL26u79zAu4vV+a/MyRvEXG
         oyifgLlndtUxR5iodJdHnv07AGwyiKZshXBAomJte1RgCuT/uT/vKnDbnJLFfSRbQl75
         DHD6mW2/OaqjbNNx5KNTt9kenv463q5xVd7Js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9c8qE3qcn/L/b5/Y0N7wYbMH02+9//QHBv0eQQ/FuU4=;
        b=Ha6+oKWL8U6j0XM0UL0E6Jkr4tG1jdhXQK0p6a5l35CTaGnMdXp7QF14fgyD47w+Qq
         OOa+9JkRJsFdWnzFEMFC6dWW0n4RPxCHD19QFoXqE+KoeM7sWOQf9mgj6Y4Q12E1fuM6
         ofDA8VMI2GoxsQrsDnZZJvDvPs49IhNTbQ/imi9v1anQX1zSpBkZApoRbQJXbShaJs+n
         kxSOR6l+2xeF9Q7zfVdgxsx0vuEQKdUrsX2KUsa8i02IhzvzbZvM2hAuZyCEbzBCnPIU
         yMf2XZBp6CBpoF0lhdq5QXqM68jngDLMfyAJfwZJnD1CcZsZkK4WQLmXaxLVaO8PgojA
         mcsA==
X-Gm-Message-State: AGi0PubOjPKm92iPCf11PdWunfGUl28uNMASonolvAnmzXzDoAGzf0iZ
        YQRLInPxcV9W4INeTOyUZS6ZFFyo/Tc=
X-Google-Smtp-Source: APiQypIw/lstPU0LI6/99LSjehU/+/+hX2zt4dtXX1/i3YjMNa+9td0VhO0yckXMDhubnisrrqoFrg==
X-Received: by 2002:a2e:8246:: with SMTP id j6mr263484ljh.162.1585781143271;
        Wed, 01 Apr 2020 15:45:43 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id h9sm1907552ljk.96.2020.04.01.15.45.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 15:45:42 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id g27so1173442ljn.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 15:45:41 -0700 (PDT)
X-Received: by 2002:a05:651c:50e:: with SMTP id o14mr247886ljp.241.1585781141160;
 Wed, 01 Apr 2020 15:45:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200331080111.GA20569@gmail.com> <CAHk-=wjpBohNkBSxyPfC7w8165usbU5TuLohdbPs+D0bUYqJhQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjpBohNkBSxyPfC7w8165usbU5TuLohdbPs+D0bUYqJhQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Apr 2020 15:45:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wijWvUfEkqUZRpvo9FCaJNsioS_qZT+iNWUdqQ6eO8Ozw@mail.gmail.com>
Message-ID: <CAHk-=wijWvUfEkqUZRpvo9FCaJNsioS_qZT+iNWUdqQ6eO8Ozw@mail.gmail.com>
Subject: Re: [GIT PULL] x86 cleanups for v5.7
To:     Ingo Molnar <mingo@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 11:09 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Lovely. This now makes my local boot-test tree be much closer to my
> upstream tree, since I've had my clang asm-goto stuff in my boot tree
> (and it had that series from Al).

Side note: I've extended on the x86 uaccess cleanups a bit with a
couple of commits:

  x86: start using named parameters for low-level uaccess asms
  x86: get rid of 'rtype' argument to __get_user_asm() macro
  x86: get rid of 'rtype' argument to __put_user_goto() macro
  x86: get rid of 'errret' argument to __get_user_xyz() macross
  x86: remove __put_user_asm() infrastructure

which I _tried_ to make complete no-ops (comparing code generation
before and after). Sadly, one of them (the "get rid of 'rtype'
argument to __get_user_asm" one) causes gcc to pick different
registers for me because now the temporary variables have different
sizes.

(The others cause line number data changes, of course, but I didn't
see any _code_ changes).

So that one commit results in a lot of small noise changes to the
generated code for me, but the few I looked at closer all looked the
same (mostly just different register, sometimes odd improvements where
it avoided doing a stupid "andq $0xffffffff", and in one or two cases
it seemed to randomly just change the stack frame size, sometimes to
the better, sometimes to worse).

The others should be purely semantically identical.

It was all just small prep to make the patch I have for "asm goto with
outputs" have a smaller footprint - particularly when I try to then
make it work with compilers that don't have the capability, and I need
to have different output registers for that case.

I'm not planning on actually doing that patch this merge window, it's
just not ready enough. But just in case somebody (Al?) is still
working on the uaccess.h file, letting you know about my preparatory
cleanups.

                Linus
