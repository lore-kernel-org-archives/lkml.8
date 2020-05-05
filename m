Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DFFC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 675E720675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbgEEPF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:05:56 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:45737 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729289AbgEEPF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:05:56 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MeTwY-1ixkms2AE8-00aVVb for <linux-kernel@vger.kernel.org>; Tue, 05 May
 2020 17:05:54 +0200
Received: by mail-qt1-f174.google.com with SMTP id o10so2182114qtr.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 08:05:54 -0700 (PDT)
X-Gm-Message-State: AGi0PuYgI5VMGcYjoyYUHQGFUh7MRgyK7S4cUYgO7QHvX2U999PO4Lhw
        QUqHftBFOqHMi5Abq1hdMCXRHzaUKvm2/9M1s84=
X-Google-Smtp-Source: APiQypIR7vH0WXUp0OPhxznI7N9wD6FLnsemn1PKoTpVnTbO51oR7Xi+pKQllQDLJGgGte/T9jjh0J1jEWOgAOxSrWk=
X-Received: by 2002:ac8:4e2c:: with SMTP id d12mr3185805qtw.204.1588691153393;
 Tue, 05 May 2020 08:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200505141137.665940-1-arnd@arndb.de> <CANpmjNNwgkVR6kjFudrR4ga--PigU5Mx69HZ1mhCAQ0GCLqQGg@mail.gmail.com>
In-Reply-To: <CANpmjNNwgkVR6kjFudrR4ga--PigU5Mx69HZ1mhCAQ0GCLqQGg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 5 May 2020 17:05:36 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3r35VrKVfpn_q2YYhxkvH9j0+3MnMqgRM6R=QOcsE96Q@mail.gmail.com>
Message-ID: <CAK8P3a3r35VrKVfpn_q2YYhxkvH9j0+3MnMqgRM6R=QOcsE96Q@mail.gmail.com>
Subject: Re: [PATCH] kcsan: fix section mismatch for __write_once_size/blacklisted_initcalls
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Alexander Potapenko <glider@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:wHaPXKqqLF8BrOpibOskofyczDCHi+EE2KBbTlMy29ECZjXUFpY
 KBUMkojGDA+yTK12F/E1mvlhAkC+qwnDpPk3FXFz1Lh+L8pXny5dshocvDsgWEv06YsWuTP
 gw1dttnyA7VtmfDl4UICxzOiEIiE8igtF1sNikn1W41JYuLEopV1dab4LQX6tTk7Y/+e5RX
 M7QUF8U4OLJmZ2JGOQQrA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/J0Xbigm78M=:j0cHlhev7jkoVp9TRG+zKC
 XIDSmOF3ztOR/e9zJ4GuPySw5dBF8JU5SQ1JYsxpIJ+L7fGLVHFqW3yGdG1HOBYUX2z+rvfqC
 QRBa3TqzZY+PmJANv9QoG1LYLHYUuVc52FYqs/I5Uls6Eyy8BhGti8w/Jwb9rxMxhQuXQ0RKT
 rJ9Jhpzxz3t3wrOgjusT9PKM7ZOrwurPzYKwe1qAvbR+r47twAxnN01LJnPvOlSrkGiVi676a
 LUKKKrZVDhJSW2OaoGnjKTSuuww/CJtbVeSUJkSfrkxrFbOU/HbbTQxRK2olTz77HaeQ88NV2
 FiOE0XF6ZuK1RB1R36kMog1sZpdIW6QnV+5CQyTwAJeq/iNPzr7i3md6sUeQ/txUbKeYMG1ns
 LYZCFHRpZit3lnE2cLW9eUpo2lonxbGtKk6WTAVyvDgPonk2CvXYTOPafZDDL7KcrCkbyQpoF
 gsVrRsE0cbd2KrzRlJdXOpG0Dfp17Z0BBbi3ZpAKwHWM0b3HOKB9vTkh1csB264pkEhkjPJra
 mWFlqpNyjto3x2IiGbYrsJzH56mEbyxhhuU8WaNfx71EERdQy9izdY+kaENbXyNPeAY6SYJsw
 CAkwWUJRcPwjUpfH26nK9r0K47NYE+K7nV5R2aSmZSSQvRZ3KveYRt1vM13aLKwA2qgixqsvM
 NCjbZlhcBanUGnBVpubd864ZmJDYbddTkRB32u16gw0Abi01YklU1SwOw/4XpLDuTuL74/QVe
 qtWaj0xXwbSaAL+RYsnziRb+0Ly2PELH/OzGX3/Y3dtNA/eiK3k9yoysreuz1Ti28AEHVSdID
 ogq5JDggZEong6SiQx8/YPV0WkRUPU3Ys1cOsFFVOCzf096PW0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 4:17 PM 'Marco Elver' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
> On Tue, 5 May 2020 at 16:11, Arnd Bergmann <arnd@arndb.de> wrote:
> > So far, my randconfig checks found two such instances, one for read_once
> > and one for write_once. There are probably a couple more in random
> > configurations, but I guess they are rare enough that we can just work
> > around them like this.
>
> [+Cc Will]
>
> Thanks for testing and fixing this. Note that this may no longer be
> necessary once Will's patches land. Also noted here:
> https://lkml.kernel.org/r/CANpmjNNw6M9Gqj6WGTHH4Cegu8roTVu5x6Vqs_tCBxX3gPwL4A@mail.gmail.com
>
> For reference, Will's series:
> https://lore.kernel.org/lkml/20200421151537.19241-1-will@kernel.org/

Right, good point. If that is going to get merged for the same release, we don't
need my workarounds and I'll just keep them applied locally in my linux-next
randconfig tree for the moment.

      Arnd
