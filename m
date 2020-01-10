Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A690C33CA3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 14:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D48AF2080D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 14:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o9Mih6qI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgAJOsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 09:48:47 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46050 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbgAJOsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 09:48:47 -0500
Received: by mail-qk1-f196.google.com with SMTP id x1so1994490qkl.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 06:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sFl1naCgTqbK89uRYkRmWghDEhCYtKJccfK1ql3J+3U=;
        b=o9Mih6qISmR7g2GlHhPw7YWjv06+eFio3Vn6JhH5CwHuiF7pkoEvkKexop9L6W9vH1
         kwsrn29ojVftlzIxIxGE0+qxLuUtZ2NoToPuaMhqIQRP+Ai4QVZTzvHer0aqm5kwhe7r
         s8vMw7gMPf/FoDa9sffnsJ6W0kHdGm9SSDiwJGH1sIisgo9zU9JC1K0sJT4zCvcEM4mW
         8f6yRRbBQvlxlXVPSzTDmlFasnhgcziev7QxMsz/u//GZNZkNTUed7F4PeZXqw+/5hi8
         9PQsTdu3beHvMK3aPbAS5Wfo06fkTUT/wSoBuJw9OkM5o7xp5OxsqehySfvkD+W8mHiO
         KVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sFl1naCgTqbK89uRYkRmWghDEhCYtKJccfK1ql3J+3U=;
        b=lYAay167IqQY6fBVhlugBfmP+sEfgHKzYskjM3sTkRA7yNKPlTMdzhyGWRXuzy5vIX
         E0BwopP4GNxnA4pL4G4Lu+ji+ZYeOJhqc4WzQgirxxpVOUfZudXju18SwKrqXLAnne41
         Q6pa+Z9uI3bK3f/XDLQ7ZAxC51adu2zNaBBQb5wMwK3Z3LqWvztdY69E5q/htH6tYJNQ
         o0BvBF7KGH2HvyqpyeZOsU2AVsJdjuO+SaK0hUvPCs7Rko1ecYKmO89n9Y/18OBO2N1T
         1vrbSyxhrSBMJpT8lwCRG/zuP/STs8/JqssTqZgKYOzt7TVh1HiefN4if6mGbpxjJpAx
         zrAw==
X-Gm-Message-State: APjAAAWadBor8MkNNwPcW5RkeTR/dxNMuuVHTXr808zXNwEx6QmcwN45
        v0hxtXcYAp6aRRAjPzfJVrqAX8kFpRbJle5CgDs16g==
X-Google-Smtp-Source: APXvYqwtpnXgeB9AZDLqrlnF7ub1PKzUna6i6N6Bg2B6L8dfxHLyudhjTrmXsO6gJRpXwtaU5kXa9OsGe/pj9YvNmrI=
X-Received: by 2002:a05:620a:1136:: with SMTP id p22mr3581899qkk.8.1578667725837;
 Fri, 10 Jan 2020 06:48:45 -0800 (PST)
MIME-Version: 1.0
References: <000000000000946842058bc1291d@google.com> <000000000000ddae64059bc388dc@google.com>
 <20200110094502.2d6015ab@gandalf.local.home>
In-Reply-To: <20200110094502.2d6015ab@gandalf.local.home>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 10 Jan 2020 15:48:34 +0100
Message-ID: <CACT4Y+Z2M3p+26KROAAnGH-HuuWZdu8Cx1TrN7YhWTh9Exj+rQ@mail.gmail.com>
Subject: Re: WARNING in add_event_to_ctx
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     syzbot <syzbot+704bfe2c7d156640ad7a@syzkaller.appspotmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        arvid.brodin@alten.se, Alexei Starovoitov <ast@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Josef Bacik <jbacik@fb.com>, jolsa@redhat.com,
        Martin KaFai Lau <kafai@fb.com>, kernel-team@fb.com,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 3:45 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 09 Jan 2020 22:50:00 -0800
> syzbot <syzbot+704bfe2c7d156640ad7a@syzkaller.appspotmail.com> wrote:
>
> > syzbot suspects this bug was fixed by commit:
>
> I think these reports need some more information. Like the sample crash
> report, so we don't need to be clicking through links to find it.
> Because I have no idea what bug was fixed.

Hi Steve,

Isn't it threaded to the original report in your client? The message
has both matching subject and In-Reply-To header. At least that was
the idea.

> > commit 311633b604063a8a5d3fbc74d0565b42df721f68
> > Author: Cong Wang <xiyou.wangcong@gmail.com>
> > Date:   Wed Jul 10 06:24:54 2019 +0000
> >
> >      hsr: switch ->dellink() to ->ndo_uninit()
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1005033ee00000
> > start commit:   6fbc7275 Linux 5.2-rc7
> > git tree:       upstream
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=bff6583efcfaed3f
> > dashboard link: https://syzkaller.appspot.com/bug?extid=704bfe2c7d156640ad7a
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1016165da00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12b27be5a00000
> >
> > If the result looks correct, please mark the bug fixed by replying with:
> >
> > #syz fix: hsr: switch ->dellink() to ->ndo_uninit()
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20200110094502.2d6015ab%40gandalf.local.home.
