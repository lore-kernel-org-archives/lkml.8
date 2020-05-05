Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C33C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64D71206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbgEEPoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:44:32 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:57819 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729406AbgEEPoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:44:32 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N2Dks-1j9PQO04is-013i4t for <linux-kernel@vger.kernel.org>; Tue, 05 May
 2020 17:44:30 +0200
Received: by mail-qt1-f182.google.com with SMTP id o10so2317001qtr.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 08:44:29 -0700 (PDT)
X-Gm-Message-State: AGi0PubZ3oHpqlDrpxDCWXs0Ex2WfxRUn0vFN+5SCOKpJZjTgRda+P0S
        KBRP3L7xXUja5Zn5tzA4SCurA7+mY6J+rqQqyGE=
X-Google-Smtp-Source: APiQypKNtPguK+ulqQ4i6SK7Ce6bqxOdI3T602y80XUl2TrrVe85Tvx5Ec/8CWUGTZaYu9rhiqgaxxFH/yXelnYzKqM=
X-Received: by 2002:ac8:2bce:: with SMTP id n14mr3338921qtn.18.1588693468940;
 Tue, 05 May 2020 08:44:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200505135513.65265-1-arnd@arndb.de> <CAHp75VfmvXotH+NRt_YnNQW8O38Gas+ZfLH00jfhytM8w7ka3w@mail.gmail.com>
 <CAK8P3a2pXZGbFvXpD5D4trGjxaie_NYi4hhUyYmKmv9A_HfRdA@mail.gmail.com> <CAKwvOd=6jdRedjhcuQ0Bsr5hJ9djp8xLpLmT-bC9Wd-1GYK1fw@mail.gmail.com>
In-Reply-To: <CAKwvOd=6jdRedjhcuQ0Bsr5hJ9djp8xLpLmT-bC9Wd-1GYK1fw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 5 May 2020 17:44:12 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3khvHTf2qALrGQoh5iunHkWOqPXSt1A1_7sO7m2JxMVg@mail.gmail.com>
Message-ID: <CAK8P3a3khvHTf2qALrGQoh5iunHkWOqPXSt1A1_7sO7m2JxMVg@mail.gmail.com>
Subject: Re: [PATCH] bitops: avoid clang shift-count-overflow warnings
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:LCcWCikVgejYL2qzpPBajIzWxxlimPOVFv4PsSFgLzX8bc0OnBV
 pw8XBDLnzAFNjh7G/yUNmxEXrMMDcAojUvOnoQA+YBmh+cljPhWPlXfdcpew7yPtSYJjnLv
 KRzjM9vj1s+UX9gjAExHaUBpgQK9tO/VJFIe59BnaH4yXiX+Qh/T+UFCVDAYyARUXXnVwTq
 rWMzWAgFmLdHNh/0ZcfmQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1B9b7PalzfE=:t99IXN8uM5wZ8Fi0O2neLy
 4iXlCb5oK9uI5kO4T2ds+wyzcuOc6niVDDZbjhlJwHCwjZjFWRoYxOVz9JLhj+i1KTsuvdJjF
 /rupbsXqOoH4gZyT2ohwLwylon3gqct3PzqXvD2IG/JwBEEe7eTpG4u3iImbP44DRg7kxzFwD
 ueEuSwBRHFHdktv38GgZAEcScXZzxaGrGknjlIy7bPTNsKgAeG5nmXAKnMatdQ/5I8BNAy4la
 yONRwghwmtt+LyKzvQkCvIYR6nyCL+FM7by9D//RrVBhC0EcW1X2/uP57HsMJmHu8mMq6MIRt
 DTi6JcYifkcJk1hjurAMQfsIyVZIj0hwrYHF5mNb4gCLAl9pPSs38YC68W6jOZaT4ifYw+ygz
 ULLTcNJjZAI9DFKU2TJmk10lueNJmijGy+sEvG7BiQyxu/z3SJTtWMT9/TU1JSH+Mz85i+dl2
 4vY9A+ROAwGDCk6Kr5rZMYKlb2IzWwL5EKp6R/5e9jPDO1hV1kAJPzFvG8fZ5x5Qx6NcCfgSO
 gmE6dNU69Ub+vYXc95Ud+kSzxBiUmL9RqRpZnZQJK+BVohh+7OyQT07n+0Hi1JSgvnXkPU8Rp
 /cZpg/kGL0p/SSXQtq3IM7ZriwH6iBQT2vO+M0l4KHMw1p3e4XntbIyEQzEDEh5nHav/2S9Sl
 ZFj/+YLHIIvZ8wJUJYUuigUn3WiQIKMQi3MSafEiDIU4AAnT9LLSF2XQ9WeuuJpxLENFTStiP
 I3SxmKu4pwAI4JYoqCWv5SMHv/cRp3YqFC6+uFSqRgCikSCArVGMBejCdhEoFKW2ZdoBTXiUQ
 Am8jS+ZqriL/o+pxQSVfO7lSms1LlEEmSwYbT8Z/jRlXoOaPhA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 5:36 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
> On Tue, May 5, 2020 at 8:33 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > I'm not sure if there is anything to be done about it in clang, since it
> > always does syntactic analysis before dead-code elimination by design.
>
> That's pretty much it.  We had a patch to Clang to use delayed
> diagnostics to delay emitting the warning in case the AST node was
> dropped, but it wasn't accepted in code review.
>
> >
> > It is a bit odd though that it only prints the warning sometimes, but
>
> Sometimes?

Well, the file is included everywhere in the kernel, but we normally
don't get the
warning at all. However, I sometimes make incorrect changes to one file that
cause some other warning, and the result is an stream of warnings about
things like this one that are normally hidden. The shift count warning is the
one that shows up the most. I should try to come up with a better way to
reproduce it.

        Arnd
