Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDD8C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 15:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3466206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 15:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgEHPJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 11:09:32 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:54513 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgEHPJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 11:09:32 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MjgfT-1irf7o0M5T-00lFas for <linux-kernel@vger.kernel.org>; Fri, 08 May
 2020 17:09:31 +0200
Received: by mail-lf1-f51.google.com with SMTP id t11so1689249lfe.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 08:09:31 -0700 (PDT)
X-Gm-Message-State: AOAM530Pn9BR8qzcjL+GFfP5nMDesNa74cvbtC3j94y3mk/dGx54LD+z
        MSklkJbGyKE8ctKg5X6OCzu+t5PwaA1YvX0SUa4=
X-Google-Smtp-Source: ABdhPJxQTJvBxDHCeBcrIroxz7DIxKTCpk9OLakfO/rC7s9A/0Q8QNVbgj27+JUd8Lwb0GZl3fLDJInQ7S1gIX7Ciss=
X-Received: by 2002:a19:8293:: with SMTP id e141mr2254449lfd.173.1588950570609;
 Fri, 08 May 2020 08:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200507224530.2993316-1-Jason@zx2c4.com> <20200508090202.7s3kcqpvpxx32syu@butterfly.localdomain>
 <CAHmME9pTZTa9AEUL0-ojTr7P-F7NYe8OR9=-GBPaQNpnSDrEiw@mail.gmail.com>
 <20200508113336.2vdfdnc6tqyx4pu6@butterfly.localdomain> <CAK8P3a0dJ0vNnktcoWFiPKB4NJbeyf7nvwWf0YLyeUyxT5pvQg@mail.gmail.com>
 <c774d7371a9599526090e63e85f61e69bddf4795.camel@perches.com>
In-Reply-To: <c774d7371a9599526090e63e85f61e69bddf4795.camel@perches.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 8 May 2020 17:09:14 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2KU_4FVCYt73mmpodV3Q7ipS579BDMnai-m9HgaiFYiA@mail.gmail.com>
Message-ID: <CAK8P3a2KU_4FVCYt73mmpodV3Q7ipS579BDMnai-m9HgaiFYiA@mail.gmail.com>
Subject: Re: [PATCH] Kconfig: default to CC_OPTIMIZE_FOR_PERFORMANCE_O3 for
 gcc >= 10
To:     Joe Perches <joe@perches.com>
Cc:     Oleksandr Natalenko <oleksandr@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:jnlZ2mGuY9zBu6M0Wkn2F+YDgiUNrmvpkl4ziRh1qf4DPugCa88
 Sx5cINnzOYTgrwCWtPGrBFi/DY6LbD3qr8HOCEcfFP2BOC2ILLM5DgwpVnInj3nyTHdYQTk
 KQOCYCv1QgS0gSUbh/f56SnJ86d2yxA7HlKMdjMRGZFrnEFriQRX4g/WFcyd83uF+oNKjr0
 fldGTySofrAtEE24+/zlA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ghYUkd9M7S0=:EUM+U6Y69xk/OWRvE4Gn2g
 zXK2/chy4z0ZCxK6CNXuTCI6C2pquo/wUJB6fdfpli/WFmvSWH4z7vFlKxGI0eiqzxym/sJ2y
 +1MrwmN/db3TgDv0Eu1VtXIhDo5PRfMhBoUoF6gclX2oovHJdXMG3zeOej/srAZCQcT17LSug
 pf2f93NZsIG2KhJHi4HtpyjdzZd7PgOaHw1JVlvtrXouLjmu2YwaUfP6qmFq1LFmiyYB/MusG
 +UU+UNr4ax/JpGVhtJgaBXjc6zwkIT9nQSWKn78jPIETOgZbLj1mLO3ycf5cnjhAu8AFC6KjQ
 xbF0GB5b6Tjsk7Kle0twWpqrq4b2hJ4nMJ/YIP6MrS7fiL7Ph7YPjm4Yi7DOZpcWu/NfnMnxD
 ng2iFMU/64PAsuWTI05NdeRrJekXgxaQ6lpFuUMguPb+vdb/Jj2omk58LiN3HK0TvjIOzbmuw
 z4PIhwTYtYHea9mnlOck+McvZ3MNnXPIP3rtwtdjckpgcuq9Ha/IIf5zs3CrdSM4uHgLJjtdG
 6x6xdLNZv2BpE0jlHc8p+JCGjgI1ur6DjDhHW9xC7l8KQ2lBXAzZ2ZgC75L4iKlZuUQ+ghyau
 Gw7vw0s9faAQaUy4Nmcs4m9+8XVbG454QRzN2JDZ2rgdd+8BxQ65OcRerXbJlWJQS50HsiFAL
 K4KCdUK+0vvYtv5nq/GBz9Ve2VP1TjRp68BEYPjrXvok0K61x4LKqOrfw3TGt7HHVKIo3X5Cn
 wJACiGfJKqqT6sl/MofbtrFLo4RlCliR4OmBAJBM50Q741loJ54M8Eq7ZpAkWuYoYdp7YW+Yt
 uAdWz5dfAqskXeUr2vPH5rkcQ4BOgexLRlNuAHO9xs3/m+h07g=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 5:06 PM Joe Perches <joe@perches.com> wrote:
>
> On Fri, 2020-05-08 at 13:49 +0200, Arnd Bergmann wrote:
> > Personally, I'm more interested in improving compile speed of the kernel
>
> Any opinion on precompiled header support?

I have not tried it. IIRC precompiled headers usually work best for projects
that have a large header with all the global declarations that gets included
everywhere, while Linux has always tried (with different amounts of success)
to minimize the number of headers that get included per file.

       Arnd
