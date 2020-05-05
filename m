Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B11C47259
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FCCE20836
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730372AbgEEPdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:33:18 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:37727 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730294AbgEEPdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:33:14 -0400
Received: from mail-qv1-f52.google.com ([209.85.219.52]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MWzXj-1jcRci1Yvh-00XKoM for <linux-kernel@vger.kernel.org>; Tue, 05 May
 2020 17:33:09 +0200
Received: by mail-qv1-f52.google.com with SMTP id h6so1186196qvz.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 08:33:09 -0700 (PDT)
X-Gm-Message-State: AGi0PuYgEdWF7KwXpLIp/Dzcu8VUrynE5k3/bss2pHCzZX8bY0J2sBGw
        EQNTdaEDWKglLTCqRsKbuLJ5NlXs0/7kPHnzuM8=
X-Google-Smtp-Source: APiQypKi+Ro1FkVr8aZ7R5oobwEjqddqyrwqKnkhiPYFwQe3BVEOGTB2p+wgr4EGsrM1IFrKfwx/lMZ7RhrsGa/pl/I=
X-Received: by 2002:a0c:ea43:: with SMTP id u3mr3087685qvp.211.1588692788292;
 Tue, 05 May 2020 08:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200505135513.65265-1-arnd@arndb.de> <CAHp75VfmvXotH+NRt_YnNQW8O38Gas+ZfLH00jfhytM8w7ka3w@mail.gmail.com>
In-Reply-To: <CAHp75VfmvXotH+NRt_YnNQW8O38Gas+ZfLH00jfhytM8w7ka3w@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 5 May 2020 17:32:52 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2pXZGbFvXpD5D4trGjxaie_NYi4hhUyYmKmv9A_HfRdA@mail.gmail.com>
Message-ID: <CAK8P3a2pXZGbFvXpD5D4trGjxaie_NYi4hhUyYmKmv9A_HfRdA@mail.gmail.com>
Subject: Re: [PATCH] bitops: avoid clang shift-count-overflow warnings
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:LeKvahs+0QPEYPHY+LX9T6yukbxEy+4e8gezUfPOtOTJQDGlRdt
 hEpqFbgCT3EppHmXwM/XYtvbrVi2iPDIKIazHMALxvvkrDks2XwmXvhx5k6sFlAXWB14usR
 8tMK6l1iOVTwINs7d8svJxNK6Ys86pYHVK3VC6EeLYQAvDTFLrAWlftwe0VNSMXd0UT/l2E
 Av4sx8uYF6tiKN3+M4sfQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0KrKmJxOtJk=:0NfnL/z9P2v4dDW1EBFrkr
 cOYkG9tIQ8hjhthh//OQY8cEb5tdXcQdYX6mbhmum8+uzhEeg/QjdTKIn0o3Rpu/0/cwcgXqP
 3OyVgYrSp19B465gCjtgJetdDVuM1ko/lWdgkcalNvtgzKEaTElfi+D8NN6FJ6LMX7VYxRQjT
 qSRsODXWLnTTytx8zymD/p9jECdYVjSoJey8O8hk5SAJh2s/6v3WHfVcMaPpJID9xcnX04KH1
 5mXvqN63R1nEIPkGT7kng83vHve24Sb72N6aWEGK2dsVGjUGHTnJEr6lf7v/eWmjhmsXyQFeM
 qqFdqDTfnU4GScG51g0c82URB6g1WzB9dC5aVj/9rwip0pNssGDMLrFe8khkuJnE1v08T7hNO
 AH8CMwju+P7Cjc422vwoqIA6T8fhAhJ4ByoVilm/vPZrEwVvJBhU7+LpDNzdUE+8CpkNip1Y1
 zkThna/bdSXwUot6i7FqvAI+gzS2CBwXZJBGL9sn6A9aPNUDhQbmnGvA9AcvQD7QnOS/s1aFd
 TRCg8ZWQ+36qxC6FxNkh3x9jZH9/riMs2L43j1mhNI8dDwm5xV0yqKvCG4LAEIZS/MR6yUP90
 V1cCVCuhvXSgyoM3xvIqJ9AeN/M31irxF4u3rFTFZF+frsJnyX1Ve3TWK3UPqF/H+s5vOW4rv
 cPHwpeCZJzH1hpksmaD4RHWyE23oJHHA4psrI7SDoEplWxISej5332ureXd4Zgw+hKjf99OTY
 ZqYVgxqNA4ZiyQjcXfSpg5U13pdV1E/OwghDW4Jg+jjgWfY5SoQIEb0/gW7Xp49QxwuUADG6m
 WMvlhee1AQ68LeMaZKJCnstSjpX0cWv4bC2CSSMJlW9H02zDeg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 4:08 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, May 5, 2020 at 4:58 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > Clang normally does not warn about certain issues in inline functions when
> > it only happens in an eliminated code path. However if something else
> > goes wrong, it does tend to complain about the definition of hweight_long()
> > on 32-bit targets:
>
> Shouldn't it be fixed in CLang?
>
> > include/linux/bitops.h:75:41: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
> >         return sizeof(w) == 4 ? hweight32(w) : hweight64(w);
> >                                                ^~~~~~~~~~~~
>
> sizeof(w) is compile-time constant. It can easily drop the second part
> without even looking at it.
>
> > Adding an explicit cast to __u64 avoids that warning and makes it easier
> > to read other output.
>
> Looks like papering over the real issue.

I'm not sure if there is anything to be done about it in clang, since it
always does syntactic analysis before dead-code elimination by design.

It is a bit odd though that it only prints the warning sometimes, but
I suspect this is also something that works as designed. Maybe someone
on the clang-built-linux list knows more about the background.

         Arnd
