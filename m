Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E506C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 020D220776
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbgE2SfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 14:35:14 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:33791 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgE2SfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 14:35:13 -0400
Received: from mail-qt1-f177.google.com ([209.85.160.177]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mo7eX-1jCZxr1EdP-00pcj3; Fri, 29 May 2020 20:35:12 +0200
Received: by mail-qt1-f177.google.com with SMTP id q14so2496852qtr.9;
        Fri, 29 May 2020 11:35:12 -0700 (PDT)
X-Gm-Message-State: AOAM531ip0QtN1WmZHjViqfpfC8pZ9MCYNKc7H5tCEoKqAP8ZOW+UMVy
        W/tOc8r5S44mPXf9xQh4ptixR0fbuTEGGZ6XtB0=
X-Google-Smtp-Source: ABdhPJz0GQVZ8aEOYoh2Eg686R2qtyZBwglBT2H2SkC4sf7A7FKjV8ciE5SbxV0sBfMPwA64WiBDRICxg4mo/fBWltM=
X-Received: by 2002:ac8:4742:: with SMTP id k2mr2866567qtp.304.1590777311089;
 Fri, 29 May 2020 11:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200512123449.16517-1-grygorii.strashko@ti.com> <a132765e-f4e4-a1e8-fb43-239188fecf1b@ti.com>
In-Reply-To: <a132765e-f4e4-a1e8-fb43-239188fecf1b@ti.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 29 May 2020 20:34:54 +0200
X-Gmail-Original-Message-ID: <CAK8P3a31DYOn1TyjxCYM7ebc9nL5EFKsNpSHkq55bG54Bns+MA@mail.gmail.com>
Message-ID: <CAK8P3a31DYOn1TyjxCYM7ebc9nL5EFKsNpSHkq55bG54Bns+MA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] soc: ti: add k3 platforms chipid module driver
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        DTML <devicetree@vger.kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Q9W+52SULKFtgzWoCw+EUKRpyRSmDk8YwQqg5h3wVUcrDA//U0a
 GE0LQgdKilNze/uK/dj8stZXGVV+q587Qv+TN2q6n3iBRRPsKY/OkxKJb1mMTKVS/AsDDGi
 b8ejSWZGeGOIYUV8uK1a22Btub0w7eJhf0ZYX/51POjLWfcqCsy08S7eJ4DRPAg9nqQU1mI
 PmKWA8kaYqo4cGVSdYfHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kk+sK2FQofQ=:XP8tVX5SiluXxjmND/m6kz
 hJSOuVukEjdEF/yUn3A9g5sFy7lLbGXJHAeURVY3q5yn2nIoY3HD7XuJSN370ePTqPY4EgPpl
 T9tN8RpFYd+KbERBMr5rULXSaWP6QGsymzcFjd5XNsk78QatjIbC1wlsw1oEVSMZ3et7FZuif
 qrsdz806c5cpUyVwxhyHPPVjU0er7cQwiiUsrCd4yr6ra5Sym/qAKPC2eTihVqnd1+sx2SGsN
 waB1nvsixknhfabVfXjciaedYAvvoOielKS3GWY1lfIF+pDGgU8saaGPKMubzcHr82WAriAbX
 X3YyssFi6nmqSk609zmfjigxikKypGt/7Jc7P92+TURY1/qetaFn3UqmLtX2/1h2joRXZvnr9
 B6I1iXAZN1uepzPDu2kBxSGjFtFbsAr7O8FvvMbU3wFaMP7IvCBsW09x0wq2LDtZNAySfi1YS
 KbjO+8sgSIj3ao+1lPGWS85UDrZrvnkiSDc6hicNxBZvBXwkLNFAKntvDoOks7B0D4jlKZkpb
 2wWk1wF29sRXa48ONOGNV1ype4AYhP+JpLB1Ga9cY1pP3J/d8I6wr7bvrbfuCiWLqxF0ylCbS
 u2c+Kn38wr7nkjKluLWTa5Gif+2f+dMDWlTLM1cvKfGnbvTuueimfEdzn+Nrnpkr5AQGkr2KL
 nrhF20B2Rmohtp9gKy2SGQbWeMLPKWdnBx3gHyZDdsEJznTo7G+fK/g6z3HUB4wPrVP4va3oL
 8AZT2QqLYxDsPPgqbDRvTWAoGEAKdWLNge25xuV9KtSPFd0EafKWUIRI/iW9KWLesq2MAC9St
 Ss5dMydVdAeKQxDef0bgaHSBOEOi62LJ+X/dlmrXgfOK42k5II=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 8:22 PM Grygorii Strashko
<grygorii.strashko@ti.com> wrote:
> On 12/05/2020 15:34, Grygorii Strashko wrote:

> >   .../bindings/soc/ti/k3-socinfo.yaml           |  40 +++++
> >   drivers/soc/ti/Kconfig                        |  10 ++
> >   drivers/soc/ti/Makefile                       |   1 +
> >   drivers/soc/ti/k3-socinfo.c                   | 152 ++++++++++++++++++
> >   4 files changed, 203 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/soc/ti/k3-socinfo.yaml
> >   create mode 100644 drivers/soc/ti/k3-socinfo.c
> >
>
> Any chances you can pick this up?

I merged a version of this driver from Santosh's pull request into the
arm/drviers tree yesterday.

Is there something missing?

       Arnd
