Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B96C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 18:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD3E24672
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 18:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbgANSYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 13:24:04 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:37855 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgANSYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 13:24:03 -0500
Received: from mail-qk1-f170.google.com ([209.85.222.170]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M8xsm-1ilOS40r5C-0063wN for <linux-kernel@vger.kernel.org>; Tue, 14 Jan
 2020 19:24:02 +0100
Received: by mail-qk1-f170.google.com with SMTP id z76so13068361qka.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 10:24:02 -0800 (PST)
X-Gm-Message-State: APjAAAVnctkxZo9DrRMqDDByjJoNNoYjkCVjU2BbEPY6C61d6nZeqYdi
        R/g7lxr836I2QTLeCq6XAwiCwziQrJ79r6tYkGI=
X-Google-Smtp-Source: APXvYqyrNSqB19F9XaGmp4nAqxHMcag70rvh2F3fcN57MONC0cfLQXvvfpqY/aKYjgq+cKGuzZZchXY0quIJn23gO+w=
X-Received: by 2002:a05:620a:a5b:: with SMTP id j27mr23200496qka.286.1579026241111;
 Tue, 14 Jan 2020 10:24:01 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a3wHmr3hgb5H69V68ZA3KCDSFeOekAKmR80MWxgQ7JK=w@mail.gmail.com>
 <CAHk-=wjwSC9H1bkEg-0t0cCU0mO+e0gBH8VQn5LG0XL2rpKnfg@mail.gmail.com>
In-Reply-To: <CAHk-=wjwSC9H1bkEg-0t0cCU0mO+e0gBH8VQn5LG0XL2rpKnfg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 14 Jan 2020 19:23:45 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1yGkCVrNj=qTrBQ=S8UWnkyL98PYdXb+nDnVXK7XsLbg@mail.gmail.com>
Message-ID: <CAK8P3a1yGkCVrNj=qTrBQ=S8UWnkyL98PYdXb+nDnVXK7XsLbg@mail.gmail.com>
Subject: Re: asm-generic: fixes for v5.5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:+pxaaNWspF7DE8AhCtHSXHkpr+B+4w4ktE7S5D56xDT0+/HlWo8
 s2RZ+8rvQo7Qx89UQ6awjy4wNRxT/ECl1RCDxnAwvfJ5seibA482nwFlO4Lpdc7gMfpRM/o
 2vUgBKJ1b5pwu8FDpVYMPUPVV4vSlVQw5LRyKvBpdtz37b7tLPem6Azb2XriUvzCt+YzgzV
 CQcMaed6/Zb1wthvJhDdA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:o5GYgbmFfBk=:obCXeuctv3ViLPMM42PS0g
 FqkcUt6vSqQ1f3Mmpc7iwknaMtX6MHLZgE+wbZF6pdOs0Vwhi03kFwH3bB1u0cD2NPwphuu8t
 dKtxrsZK2jRUQm0spu+CVYO7oP2RC9odIjo5hZjoiAvitXkaCxpGFUUIU3LBwhJpoL3lw0QTD
 Tq71V4ni/B5BSslizTHmf/LExxnb4UnI7mBhDEq/vqv4+5c1HM41kVwCJCfgipsu+jbG0GJ/g
 prb0LTGEV96fpbQ/eBWNAwpeuc0nF8QMtPCias5wqrLo+UtJ7LQ3O/2bJr6uVg2Z5CQyMIiQh
 N2hiEWNC+9zojZxdsLDrpwqOX3N+WpZ6lq528LmejcdFUHJXgLCV8d2bFhyad9p8TAXqByqzv
 4G+nJFg3OAWphSVni2SUCz7IrwQ0ERgYUnJ+XYRP3tBLJzoIV60JEf3ibSiLrDWpB9mWCf2Z1
 lz6pSbsif13hWKC94eNOSqsaRyv7ybZIYCjW8qTPvKoZgF4M2BrGCRCe6bBOKfLSfvtCD3zph
 G1/0x0cFjK5cmZ0pGQG3fA4Ji7LBwQVHuWztYYVhnVoYyCeSDhtqcNDy4Z00JPZXWIZhTFmck
 WBfPIYQj9+MhJQN8XF5r0S1Nabv2hOxHCeBmuMGD7XN0v0zBuaPDWBnFF3PSa8bMyY3tZRkTZ
 u5u7o3+bs10WlnZ1BlLiDi4e8RnJrhXEeh2qdSfKH6yU9fQOm2cOPsVcacx13uhM4WH/+4D9C
 aRpnXqZsVkMfWjnPYWWP6VO2WLqfmb36s//5cH1LOjvLZksir8SlwT36O8hTE+6lc8S6LyTWX
 2z+nLeylLLST1b+d4GHtF4mAYT0Cp+lVBH/C94fyfqFmPMS5ijb0y39fUr2QmLngCJE01g9/0
 0BtRvEE00UPp9F3HI43g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 7:19 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Jan 14, 2020 at 8:23 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
> > tags/asm-generic-5.5
>
> Pulled.
>
> However, I noticed that your email doesn't match my usual git pull
> search terms (which are "git" and "pull" - shocking, I know), so had
> this been during the merge window or some other very busy time for me,
> I might not have noticed the email in a timely manner..
>
> Mind adding "git pull" somewhere? Preferably perhaps to the subject
> line itself, ie a "[GIT PULL]" prefix, because that's also what the
> pr-tracking-bot looks for (well, it's _one_ of the things the bot
> looks for, it might have noticed your email even without it because of
> the pull-request patterns in the body).

Right, I should finally script this better rather than copy-pasting
the pull request ever time.

     Arnd
