Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26699C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F142051A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbgCKIIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 04:08:20 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:37377 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgCKIIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 04:08:20 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MplLZ-1jfmZj1NML-00q7kb for <linux-kernel@vger.kernel.org>; Wed, 11 Mar
 2020 09:08:18 +0100
Received: by mail-qt1-f178.google.com with SMTP id l13so883178qtv.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 01:08:18 -0700 (PDT)
X-Gm-Message-State: ANhLgQ3jUXWUdtiVrAg5b8Og/YIAmZibP+/ICMlJ2kAutIXsJXmLTJ5z
        jcGgoN/YIVebu75/8lF18tMmT+NjG66G+SEcSHc=
X-Google-Smtp-Source: ADFU+vs2hxeVvWF6CFcvsnapxW/+7M3Z6M+ve+CzkmMddCW8sT2Z3/y60I2QSZoEPomImODxZOnSGSEEAy3EsgD3YN8=
X-Received: by 2002:ac8:440c:: with SMTP id j12mr1507383qtn.142.1583914097268;
 Wed, 11 Mar 2020 01:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583896344.git.joe@perches.com> <03073a9a269010ca439e9e658629c44602b0cc9f.1583896348.git.joe@perches.com>
In-Reply-To: <03073a9a269010ca439e9e658629c44602b0cc9f.1583896348.git.joe@perches.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 11 Mar 2020 09:08:01 +0100
X-Gmail-Original-Message-ID: <CAK8P3a06imYP7smZ=nJ_X_kqMfubZR0GF-HQ38S0creGqCo9rg@mail.gmail.com>
Message-ID: <CAK8P3a06imYP7smZ=nJ_X_kqMfubZR0GF-HQ38S0creGqCo9rg@mail.gmail.com>
Subject: Re: [PATCH -next 017/491] CELL BROADBAND ENGINE ARCHITECTURE: Use fallthrough;
To:     Joe Perches <joe@perches.com>
Cc:     Jeremy Kerr <jk@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:SWE4REaBgVE7l5sxwzUDei8DYSFOKUAa2yYwhggSCsWs5RRPats
 3kY+rBt4a15hYxAdrN7t+4ljTh4hA5Q/75F3s5vRZbdCysGnSwxDib0QLNL7iXLDao7X3j0
 gloyq81KXxt9Q82ZBrVAl28iJiFBZAxkd2mEcqAWRjJo5ykQPYWjamUX1CBR1ppnaIbCKIO
 j73uMtq1ZtobCrdqnPBAg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OqnbNR+/dgc=:usdyb68wlh/lhGEFNQy000
 r9/y/15+2DQ4aAVmP31NCPPxhEGeE8rGbhK56f4aYqQAEd1mSbBCcvMPEG7KrEpmltilKzHub
 YoSyRahNXBatFKlbCZWoQHH8S7D6mlo1CqFBdbR4INqIcBB6i61IwLgQYkHcTep9P5lG62a57
 rnmKbUvm3o79RjBJBst26qIaJa6kh6ffNL1lCQx2AVrMNEv30KMU6JgDZK+cMJYwOAh1Kulwx
 K1y367BUJC2Iq9pAMkiyntdBjgDVbm4nCEseyA5E7+paObFFoz8lnBto4JOvyTnxUqfyKtbVl
 0tiFI+rB9OtwgXzmfwo1VhCuzoKPXc4UkZVq2RvyTPb1cOWwqqNZVePjtYYtCrtr5WlGB84SM
 cWzg1CN9woNxORi4iRfU5gJlIgrkfYPfKpPaZHVAyHOmUFrJrmezb6zRKrVQi2LvBsSXhvamV
 Mt32VsrxqRKoNITg3xdqncGEocTVqDqM2hCIhMhv9Xn/X31+8BeL4jHyQSB2ONLW/iAXYP9gO
 E/PHYFKDSoau+8bdZAbEBpMIqpBpUgkSkP/h2frXGevqbO5R1iPQXYX6yfVS8OWpKOtt5QStW
 x5LvW/yj2bvtGu/RjK47RVv7e2duFpmo5A97s5GAvIh2eSO1A/AC+GrG5cWz75vBucf9FJVmS
 DyuOnh97l6qEdP+qXFUQFBA2fBzFi3COhK9dL69YBuqM5O9sFCQfkeGjKtpaA+GY14U7icbDT
 PofcFmFUT2dKqNeL/LiBxV8BczA8jAFG7JVsXaK/HaMvYnCoz+HKZTeZxyvw1ZipQwYydrZRr
 zB0DVzhJcpnNkAyebY/rjzTLBzkZp00ef/tLADY6gGgfFCIglI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 6:07 AM Joe Perches <joe@perches.com> wrote:
>
> Convert the various uses of fallthrough comments to fallthrough;
>
> Done via script
> Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/
>
> Signed-off-by: Joe Perches <joe@perches.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
