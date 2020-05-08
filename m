Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08D5C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A1862496D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbgEHNEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:04:45 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:43063 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729403AbgEHNEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:04:44 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MWiUg-1jda6M41pw-00X5Sl for <linux-kernel@vger.kernel.org>; Fri, 08 May
 2020 15:04:43 +0200
Received: by mail-qt1-f172.google.com with SMTP id p12so1098308qtn.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 06:04:42 -0700 (PDT)
X-Gm-Message-State: AGi0PuY5Ti0+VgcYk494vqasUJQwfTeM231S0FinofdigCBuyAqeRtz3
        iDDwAcjX8/V8HzQ2UGq4a8709cBC1FkMvP1EBOU=
X-Google-Smtp-Source: APiQypIZ9fdqzV8K0kDUREFLcJsaykAVZ2bsF1OGHTkx0WBZDXdS7/8/nju+VojGbtFyqXxRP7MUeq1/6F/8sVfJ8cs=
X-Received: by 2002:ac8:4c8d:: with SMTP id j13mr2841736qtv.142.1588943081780;
 Fri, 08 May 2020 06:04:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200507224530.2993316-1-Jason@zx2c4.com> <20200508090202.7s3kcqpvpxx32syu@butterfly.localdomain>
 <CAHmME9pTZTa9AEUL0-ojTr7P-F7NYe8OR9=-GBPaQNpnSDrEiw@mail.gmail.com>
 <20200508113336.2vdfdnc6tqyx4pu6@butterfly.localdomain> <CAK8P3a0dJ0vNnktcoWFiPKB4NJbeyf7nvwWf0YLyeUyxT5pvQg@mail.gmail.com>
 <CAHmME9p7Hri-vHfwR9GY1gPo91jVx4-hTqsZVRHiioUENRHibA@mail.gmail.com>
In-Reply-To: <CAHmME9p7Hri-vHfwR9GY1gPo91jVx4-hTqsZVRHiioUENRHibA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 8 May 2020 15:04:25 +0200
X-Gmail-Original-Message-ID: <CAK8P3a06DmZr4cJt=v+1uT4sT-E3yWkeg-YioyjK3GZR5Twunw@mail.gmail.com>
Message-ID: <CAK8P3a06DmZr4cJt=v+1uT4sT-E3yWkeg-YioyjK3GZR5Twunw@mail.gmail.com>
Subject: Re: [PATCH] Kconfig: default to CC_OPTIMIZE_FOR_PERFORMANCE_O3 for
 gcc >= 10
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Oleksandr Natalenko <oleksandr@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:WtDCZNNOTxD3Xnxd13MZ0sZLkIez7V9W7kTAVGAzwjW02gEwKEb
 CzwwYOceaBhhylEk8GJDq6Wu/TXgpHM1qPbVJNszenKlYXCA+kAoKGyI3q0V1nIdf512iMk
 cRI8koOOa1tUi44QHIamukp1np1WgICPtYsgIiX+f+jXx3liQtbNO106Gx6Ub5KIeti2hNa
 DFDZ7g9gYtjZ8tvsvtAHQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ep5r8y5ZDnE=:wbxWA3LoH1dAhmPCmfc+kH
 iRg2MnuPVTcv6Z0u8juC/zvS9FNaN2upKEiZwNsFd1OnZykQNhlA06Apjs+zm0tKGGj7ZM4Qw
 a03mcFCSmZtMlGwKTAxieYpMgIZm1Oy9Im3uOR2Mmws3ayix7kB/py/GyFOWVsazFN1Ep7HE2
 8higksKovRTCHnrYjReiDr7WlHu2QuUdDja1xMHtvCIn40MiFY13gzVI004QuArGAN6MQQ0Kg
 dJ9lZA9s8AKKYYoQSOYhMd3kCHnSmKF/rdovPNLPvt6YAtIaQaojUrQTx0mSfRL7Mx9F5ScY2
 Bnvv2zS+0vwtgLWPeW5lPrrdrK371ynh5/ksmjzK0RkLDBwufKoW8cm8VBKS+KPH/K3iZHs5b
 zWlLP0raSnmr/k6z9W2oLVsUdtqBjii6jk5f+bnqFjWoNuWctRBEhsOoSjyv2EodJXl9hMwNq
 JauphDDIWSkSY0qSO0ztE8CIwESexwpOcR9veall4WzDZ04sf60i5Q5AdnpTi3qUTV06d8NbN
 vHlAfHPx9/jn4Y58cZEsbWUKe0JSnMU1g6tlQVGynHk1OWf0SvKPzRvd8a/Zub8mG5Owd5+6W
 xnfzKyNxlUrBbndbDwpxv1u3ZM9N+zTZdxglZOhg4Qekps0WxdAfcJJSLEKxFxKt0J6MRW3FQ
 2l3rRwBBGoFALaXbbIK4rE7Iwqc8qCkXOI3kbOxpG430YtHawwRiWiEbAcpV8WgecXeaNbjP/
 tTyQlGhofLM7V00rAYYV1Naj8kSTo/abuXLlepXye8St8oJZMN3j4DYT4NerwpmTAgq77qxHf
 4U8vlmGWzrNWGHLyAPb04nA4Sp4eVSWaH9djEsEUxotUbUnM3s=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 2:07 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> On Fri, May 8, 2020 at 5:56 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> The other significant thing -- and what prompted this patchset -- is
> it looks like gcc 10 has lowered the inlining degree for -O2, and put
> gcc 9's inlining parameters from -O2 into gcc-10's -O3.

I suspect it is more complicated than that, as there are a number of
parameters that determine inlining decisions. It's also not clear whether
the ones for -O3 are generally better than the ones with -O2, or if it's
just that whatever changed caused a few surprises but is otherwise
preferable.

Did you see regressions in specific modules, or just a general slowdown
or growth in object size as the result?

      Arnd
