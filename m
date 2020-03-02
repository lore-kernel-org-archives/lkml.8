Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3715C3F2D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 14:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C806214DB
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 14:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J7auA5MD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgCBOZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 09:25:49 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40034 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbgCBOZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 09:25:48 -0500
Received: by mail-qk1-f194.google.com with SMTP id m2so10120428qka.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 06:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lmUh8YY8ynplPa3dGXZIi9wFulS7zPcu7CuZdhanZXQ=;
        b=J7auA5MDFr2qqbjZP4Kcx2XgvkIVefmjam+S1vE5Yr/H6T0wmWuCENZrf/UwxRPGYk
         YnIpiGm0zyKRB2rcVQdvt1T6ssglc4GHXnHRsc39ED7oKswuiGGYkyOYRXVjoDCGFGv9
         IogF27dnR8wFP87Zm7mvGJHy4gzsNU7ACDWu9Y3QKxSgT7SHvz6E8MG19epG3WgAUVlW
         UqUN29DYFuhmGxIdcy0SiOL1jIBa+sy1VcITHDf3wfyXIrzvhufshwrEAc+ZM8d6ZPPz
         Mf/LW96HhBJaoNAFECZwo5cCAz8LDrsH6oiEm4en+KZ2QFtKTFGGUYYGiACswStES6NO
         YRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lmUh8YY8ynplPa3dGXZIi9wFulS7zPcu7CuZdhanZXQ=;
        b=OeBrhidTHx6jWhZRt2Jf5roiulvOTIZxVC1Ybmsj/iFdw2bo1sTpKMBE9XWEv7ESqa
         B/wRzk0fTpk6qRKE1CwRmryWc/0kwJBKjXPw69r/eEMz0P3kYCi5K2ti+D6i8e+vywy2
         9xOeWbucPthKfxOTiPLhwmFeRyax1R8/TRfDvIcnnEsJFk/1BFjr0dA0svDiBSgG4Li2
         fKPNUCmC0jZjO+P0FLh3mlEXgyP1H/XjvxKUunfJMhY5RW7BoSDbQrIodCWQPmwutJcQ
         9ATR3M6NX1MH7ln66chiMyMGsXvOkJjKr2D2y9Exv92nrio78Vl4zUlj+hNeQysBwwbm
         xhYQ==
X-Gm-Message-State: APjAAAVgfTeGWe47umr/US/3EtNBtZZqaKR163ntISn70/PVfYlOHdks
        z5Lv0emoq+UZO7LoiI3PJaHnjbw8mFwaXlj/okLukQ==
X-Google-Smtp-Source: APXvYqwDlqh3lh0XUXAR770jEfFmjHFeSpPxkDZZzRR62/nhK1NcL8KQ6zaZFa7ORSuAAf4nKeZsy/i2ppA7uidgKIU=
X-Received: by 2002:a37:88b:: with SMTP id 133mr15643952qki.256.1583159146786;
 Mon, 02 Mar 2020 06:25:46 -0800 (PST)
MIME-Version: 1.0
References: <0000000000003cbb40059f4e0346@google.com> <CAHC9VhQVXk5ucd3=7OC=BxEkZGGLfXv9bESX67Mr-TRmTwxjEg@mail.gmail.com>
 <17916d0509978e14d9a5e9eb52d760fa57460542.camel@redhat.com>
 <CAHC9VhQnbdJprbdTa_XcgUJaiwhzbnGMWJqHczU54UMk0AFCtw@mail.gmail.com>
 <CACT4Y+azQXLcPqtJG9zbj8hxqw4jE3dcwUj5T06bdL3uMaZk+Q@mail.gmail.com>
 <CAHC9VhRRDJzyene2_40nhnxRV_ufgyaU=RrFxYGsnxR4Z_AWWw@mail.gmail.com>
 <55b362f2-9e6b-2121-ad1f-61d34517520b@i-love.sakura.ne.jp>
 <CAHC9VhT51-xezOmy1SM4eP_jFH9A8Tc05wY=cwDg7oC=FgYbYQ@mail.gmail.com>
 <CACT4Y+YgoyBCoPYxXOb8oQjXYc+Q-cZLPi6y1Yrx_mnfzOQafQ@mail.gmail.com> <CAHC9VhTsKCJf8bjOT+cxWZEX1y4c57KcVz0Y2c3vRGnJJQA4pA@mail.gmail.com>
In-Reply-To: <CAHC9VhTsKCJf8bjOT+cxWZEX1y4c57KcVz0Y2c3vRGnJJQA4pA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 2 Mar 2020 15:25:35 +0100
Message-ID: <CACT4Y+bjB1TWZgrQiq0m57NL8T6rJX4b_vPRsoYTY0Lwqh2qVw@mail.gmail.com>
Subject: Re: kernel panic: audit: backlog limit exceeded
To:     Paul Moore <paul@paul-moore.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+9a5e789e4725b9ef1316@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 2, 2020 at 2:43 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Mon, Mar 2, 2020 at 3:47 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > On Fri, Feb 28, 2020 at 2:09 PM Paul Moore <paul@paul-moore.com> wrote:
> > > On Fri, Feb 28, 2020 at 5:03 AM Tetsuo Handa
> > > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > > > On 2020/02/28 9:14, Paul Moore wrote:
> > > > > We could consider adding a fuzz-friendly build time config which would
> > > > > disable the panic failsafe, but it probably isn't worth it at the
> > > > > moment considering the syzbot's pid namespace limitations.
> > > >
> > > > I think adding a fuzz-friendly build time config does worth. For example,
> > > > we have locations where printk() emits "BUG:" or "WARNING:" and fuzzer
> > > > misunderstands that a crash occurred. PID namespace is irrelevant.
> > > > I proposed one at
> > > > https://lkml.kernel.org/r/20191216095955.9886-1-penguin-kernel@I-love.SAKURA.ne.jp .
> > > > I appreciate your response.
> > >
> > > To be clear, I was talking specifically about the intentional panic in
> > > audit_panic().  It is different from every other panic I've ever seen
> > > (perhaps there are others?) in that it doesn't indicate a serious
> > > error condition in the kernel, it indicates that audit records were
> > > dropped.  It seems extreme to most people, but some use cases require
> > > that the system panic rather than lose audit records.
> > >
> > > My suggestion was that we could introduce a Kconfig build flag that
> > > syzbot (and other fuzzers) could use to make the AUDIT_FAIL_PANIC case
> > > in audit_panic() less panicky.  However, as syzbot isn't currently
> > > able to test the kernel's audit code due to it's pid namespace
> > > restrictions, it doesn't make much sense to add this capability.  If
> > > syzbot removes that restriction, or when we get to the point that we
> > > support multiple audit daemons, we can revisit this.
> >
> > Yes, we need some story for both panic and pid ns.
> >
> > We also use a separate net ns, but allow fuzzer to create some sockets
> > in the init net ns to overcome similar limitations. This is done using
> > a pseudo-syscall hack:
> > https://github.com/google/syzkaller/blob/4a4e0509de520c7139ca2b5606712cbadc550db2/executor/common_linux.h#L1546-L1562
> >
> > But the pid ns is different and looks a bit harder as we need it
> > during send of netlink messages.
> >
> > As a strawman proposal: the comment there says "for now":
> >
> > /* Only support auditd and auditctl in initial pid namespace
> >  * for now. */
> > if (task_active_pid_ns(current) != &init_pid_ns)
> >   return -EPERM;
> >
> > What does that mean? Is it a kind of TODO? I mean if removing that
> > limitation is useful for other reasons, then maybe we could kill 2
> > birds with 1 stone.
>
> Long story made short - the audit subsystem doesn't handle namespaces
> or containers as well as it should.  Work is ongoing to add the
> necessary support, but it isn't there yet and I don't want us to just
> start removing restrictions until we have the proper support in place
> (this what I alluded to with my "... when we get to the point that we
> support multiple audit daemons, we can revisit this").

I see. Thanks for context.

FTR we've started collecting such cases
(panic-but-working-as-intended-and-hard-to-selectively-filter-out) in
https://github.com/google/syzkaller/issues/1622. So that they are not
lost in future.
