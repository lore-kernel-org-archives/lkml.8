Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9DCC2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 21:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1877820CC7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 21:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586642259;
	bh=XBbe5BbFKHr/BNOxK2gb4zx8BC2kw0b5jB2RIzd4EoQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hUOYkYDFw1A52AyLNfvylzlnjrr1iItfoXI4ZkYiQIekxIDo4FLub/mMQ5lTRY6+U
	 cOrj6YnxdnovsaadcjW8P4zBlsUBPB/hBSPFYBc2Q5KlwNWHO+LSMwilswvuHGtBCw
	 zENxH7cqkT+eytLkebOKYQuvb5E97I3b8Ex8lXXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgDKV5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 17:57:36 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41896 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgDKV5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 17:57:36 -0400
Received: by mail-lf1-f66.google.com with SMTP id u10so2661764lfo.8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 14:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q5vLdYFGqj1bYiIUdQ61hra2oz8tq68EbdpEdoVgOsw=;
        b=T2FceHqJIuxt9TVAJrtUQnBGZHCDtB7hA1dGLHRLH8Fzj9cA2pIG0jjqoBlkxdIcqV
         DcX0+JxmGyt4Y7lKSJb12cD2/SY6ua5/VxGdLwRS/VVkUafYts2EvBSwBkZCD4DBGvQm
         QDFkF5GbcGbZk7TGdLK46MzTf6xCCrKr3gHyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q5vLdYFGqj1bYiIUdQ61hra2oz8tq68EbdpEdoVgOsw=;
        b=Arm3YkWv1ON5kKhbWoALReH3DycNGIZbFWZ0XLnQMU0Lb8u1tf/ewHfj07OGFRn8l2
         0MQdHV3/Dn3b/AxIRVdgeO2tTij4UI2iCDe0shIL4JSNkzQu59ywR981txoO5UTU8fpA
         fOO+t8jQZilRdxH8pbabRhOtakClXdvhHDRhiFmEIqqItmxE33JKUb8SGOE6U5rkjWsG
         BkyXY2qkd27b9LiZXJPJA1z6eBQjMZVpzLIQeE5g4PpuS1Ft4IBMDd4j4h2kjTIWCWNJ
         RyRXaCqp1EMizm27bn4cWyg2csWSprmoa2cGGV6AxIHZsR4yeKsF4TNBdKXiybrjdSKm
         gPIQ==
X-Gm-Message-State: AGi0PuZsa4cieZkpo3sJvlqMhlKkINT5TT/8n0d1G9pVZ3sJZNo4+3Qz
        IKXQDCZy9YPLPKUsqZuHPqO7g1xSouQ=
X-Google-Smtp-Source: APiQypI+rBfHLWyjrRBFUOFlqldeXlOE28TPVMH05U/wCzqEMtIt5QL1dXPL46TpjtA3xq7BOMzkfg==
X-Received: by 2002:a19:4014:: with SMTP id n20mr6007700lfa.6.1586642253585;
        Sat, 11 Apr 2020 14:57:33 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id r23sm4659539lfi.33.2020.04.11.14.57.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Apr 2020 14:57:32 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id k28so3799009lfe.10
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 14:57:32 -0700 (PDT)
X-Received: by 2002:a19:9109:: with SMTP id t9mr6334308lfd.10.1586642251904;
 Sat, 11 Apr 2020 14:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <AM6PR03MB51708FD4226E07AB7CB0D6A7E4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wjaoYM4gXdAyYY=u8PaYj2LXUvcfp=8DKum8f1DM+Ws0A@mail.gmail.com>
 <AM6PR03MB5170F924EA69A81D79BD0929E4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whMKC5F-=QQP=fCNRuTF+ZGiNtLEKvx7KekpK1JtrwDhw@mail.gmail.com>
 <CAHk-=whJ8khGBqfqh6ZmHsKjcyyBLm5xgkgLW_AC_=82iFBWoQ@mail.gmail.com>
 <AM6PR03MB51700B243E34BF4A59FF33CFE4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whJttTNFQn1fMYp91LZ90iHE7B2THZ8NjQ7fBwmWX9k6w@mail.gmail.com>
 <87imi8nzlw.fsf@x220.int.ebiederm.org> <CAHk-=wgh4zts+3hdkGzHLJ6pBGumcJ=23gRbMfubDrLstis2Bg@mail.gmail.com>
 <CAHk-=whKHpERyVv2-C+kxq9KV_mJPW3hkGDpn6f4yOvs+au8SA@mail.gmail.com>
 <20200411182043.GA3136@redhat.com> <CAHk-=wgwXpKepChGi4ZhQVxZxD0ic8s2CDXvUmqBTMaKGz-fjg@mail.gmail.com>
 <AM6PR03MB5170660DA597EAAAC0AC1B5BE4DF0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wjXxM0VnLN6iwVeORwxED5QgXS_AXUJ4+Af3jUeFY21gw@mail.gmail.com>
 <AM6PR03MB5170E360AE2E27F632874DAEE4DF0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wgWHkBzFazWJj57emHPd3Dg9SZHaZqoO7-AD+UbBTJgig@mail.gmail.com>
In-Reply-To: <CAHk-=wgWHkBzFazWJj57emHPd3Dg9SZHaZqoO7-AD+UbBTJgig@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 Apr 2020 14:57:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiMm+LC7vwjtCXs9qp2t+Qp=N=Bzv8_R_=NVFDO4QHN7A@mail.gmail.com>
Message-ID: <CAHk-=wiMm+LC7vwjtCXs9qp2t+Qp=N=Bzv8_R_=NVFDO4QHN7A@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 11, 2020 at 2:21 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> You're confused.
>
> There *was* that callback already. It happened when the thread exited and became a zombie. No ordering has changed.

Also, stop calling this a "deadlock" like you do, when you're talking
about the kernel behavior.

That only - again - shows that you're confused.

The kernel at no point was deadlocked.

The kernel had two events - the exit of one thread, and the execve()
of another - that it wanted to return to the tracer.

The tracer isn't listening to the first one, and the kernel is waiting
for the tracer to do so. The tracer wants to get the second one, but
it's not happening until the tracer has dealt with the first one.

That's a deadlock FOR THE TRACER.

But it's not a deadlock for the kernel. See the difference?

It literally is absolutely not at all different from a user space
application that deadlocks on a full pipe buffer, because it's not
emptying it - and it's not emptying it because it's trying to just
write more data to it.

See? It's a user space bug. It really is that simple.

Here, I'll give you this program just so that you can run it and see
for yourself how it hangs:

    #include <unistd.h>

    char buffer[1024*1024];

    int main(void)
    {
        int fd[2];
        pipe(fd);
        write(fd[1], buffer, sizeof(buffer));
        read(fd[0], buffer, sizeof(buffer));
    }

and it's *exactly* the same thing. The kernel buffer for the pipe
fills up, so the write() ends up hanging. There's a read() there to
empty the buffer, but that program will never get to it, because the
write hangs.

Is the above a kernel deadlock? No.

And anybody who calls it a "deadlock" when talking to kernel people is
confused and should be ignored.

So stop calling the ptrace() issue a deadlock when talking to kernel
people - it just means annoys and confuses them. I literally thought
something completely different was going on initially because you and
Eric called it a deadlock: I thought that one thread was tracing
another, and that the SIGKILL didn't resolve it.

But no. It's not a kernel deadlock at all, it's something much
"simpler". It is the same exact thing as the stupid buggy example
program above, except instead of using "write()" and waiting for
something that will never happen because the write needs another thing
to happen first, the buggy ptrace test program is using 'ptrace()' to
wait for something that will never happen.

Now, admittedly there is _one_ big difference: ptrace() is a garbage
interface. Nobody disputes that.

ptrace() is absolutely horrible for so many reasons. One reason it's
horrible is that it doesn't have a nonblocking mode with poll(), like
the write() above would have, and that people who use read and write
can do. You can fix the stupid deadlock with the above read/write loop
by switching over to nonblocking IO and a poll loop - doing the same
with ptrace is more difficult, because ptrace() just isn't that kind
of interface.

And with read/write, you could also (and this is even more common)
just used multiple processes (or threads), so that one process does
reading, and another does writing. Again, ptrace() is a shitty
interface and doesn't really allow for that very well, although maybe
it could be made to work that way too.

But even with ptrace, you could have made the tracing program set a
signal handler for SIGCHLD *before* it started doing forks and stuff,
and then exit of the first thread should have caused a signal, and you
could have reaped it there, and it should work with ptrace.

But that garbage ptrace() test program didn't do even that. So it ends
up hanging, waiting for an event that never happens, because it didn't
do that other thing it needed to do - *EXACTLY* like the "write()"
ends up hanging, waiting for that read() that will never happen,
because the garbage test-program did things wrong.

So as long as you guys keep talking about "deadlocks", the _only_
thing you are showing is that you don't understand the problem.

It's not a deadlock - it's a buggy test.

Now, what I've suggested are a couple of ways to make ptrace()
friendlier to use, and thus allow that stupid test to work the way you
seem to want it to work.

Basically, execve() doesn't have a lot of reasons to really wait for
the threads it waits for, and the only real thing it needs to do is to
make sure they are killed. But maybe it can just ignore them once they
are dead.

Or alternatively, it can just say "if you didn't reap the zombie
threads, I'll reap them for you".

Or, as mentioned, we can do nothing, and just let buggy user space
tracing programs hang. It's not the _kernels_ problem if you write
buggy code in user space, this is not anything we've ever helped with
before, so it's not like it's a regression.

(Although it can be a regression for your buggy program if you used to
- for example - do threading entirely using some user-space library,
and didn't have threads that the kernel knew about, and so when your
program did 'execve()' it just got rid of those threads
automatically).

                 Linus
