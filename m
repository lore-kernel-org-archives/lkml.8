Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1F2C28CBC
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 20:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58BED206F1
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 20:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgECUU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 16:20:59 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:43619 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729099AbgECUU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 16:20:58 -0400
Received: from mail-qv1-f51.google.com ([209.85.219.51]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MofLl-1ipOVd3j0T-00p2xI for <linux-kernel@vger.kernel.org>; Sun, 03 May
 2020 22:20:57 +0200
Received: by mail-qv1-f51.google.com with SMTP id h6so7381691qvz.8
        for <linux-kernel@vger.kernel.org>; Sun, 03 May 2020 13:20:56 -0700 (PDT)
X-Gm-Message-State: AGi0PuYKoW++eLXj4sRT7Jy8JUVPswHIXDzFYVjQaq2m4tKmB9OdqKlY
        ZFRGTleyK2cGAafyIj9+VVnovFD+NtKpc0gFacQ=
X-Google-Smtp-Source: APiQypLk7U5qj8IyY5ZoBu+vmsz3bREidAulTKk3TW1OMmy/wtqeo7wuf7xbabnaAj5tb8Mg2vFK5pPHO+l/RMNUPXI=
X-Received: by 2002:a0c:eb11:: with SMTP id j17mr13526842qvp.197.1588537255801;
 Sun, 03 May 2020 13:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200331093241.3728-1-tesheng@andestech.com> <CAK8P3a3LokurC0n9XiwtPQh9ZgQcswMKY4b+TEsQh1VgYDNeWA@mail.gmail.com>
 <20200408035118.GA1451@andestech.com> <CAK8P3a1JS3_2fWrhNTZx0eTWjJa-GTb4AscTPqydpSP5EB15Yw@mail.gmail.com>
 <20200414151748.GA5624@afzalpc> <CAK8P3a0JW9x-Wk9Ec3+zLjPHbWAvPQx8MF-xe-PnWUgEjRAuTg@mail.gmail.com>
 <20200415135407.GA6553@afzalpc> <20200503145017.GA5074@afzalpc>
In-Reply-To: <20200503145017.GA5074@afzalpc>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 3 May 2020 22:20:39 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3OC5UO72rTDWi6+XgmExJmkATEjscq8hns8Bng06OpcQ@mail.gmail.com>
Message-ID: <CAK8P3a3OC5UO72rTDWi6+XgmExJmkATEjscq8hns8Bng06OpcQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Highmem support for 32-bit RISC-V
To:     afzal mohammed <afzal.mohd.ma@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Alan Kao <alankao@andestech.com>,
        Eric Lin <tesheng@andestech.com>, Gary Guo <gary@garyguo.net>,
        alex@ghiti.fr, David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <steven.price@arm.com>, atish.patra@wdc.com,
        yash.shah@sifive.com, Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Greentime Hu <green.hu@gmail.com>, zong.li@sifive.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:k5+Erw+cJPdqB3fnpnYI8WfJ3ffjUfyLxrJPn1dlJH0vktX2q9+
 Sgge2N2f1tKjcjDWOg+kXI7rU/4WYfzYlyCNMmIgElE5+ub5+eRm4pAGZBeVMvCb2wnt2Zs
 6yc+FfbEKY/omtrqYdd14Hvjnrzt7DnWqP1CkSvMzDYcYMlyD7EBE57nIRaToaKo3mIYoXj
 Ff0BNl8c1unvXnZzIOthw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hokQlYeDozw=:59JxmUcLVOcOj78LjMJiiv
 KjYuUH3uN5iN/4My2eBwkpfInq6aukyDOJdtfQ1TI1KpN4Tw2ZiPsZhpDCdIDRqhM2UrCaV21
 8zdHTVlAyTJ9E/KVMEKWQ5PSn9+H1NY8wP92yMl5c3wN9dpXlN3wFdN9GGJIFl05hwDa6vkGf
 E886zAfmriQucXo/mXq+PYRjSGZ5HNUIG01Cet2klu2oJuTSvhS8II80FgnXQM62eRMr60BLX
 EW0FeXPF1LLT4sCpE6L5zN9iqtRWcygEWXggF016veYp/t64ao1Lb9+HVcRifVCfop6LHBd0M
 7k97gaX4QvcQwixv1R804KTEbyXZPRmZZuFAr1JcSnWmee/Xc+LQGfFpvNJjG4niTOz/Bh3TU
 s2GXf8HI1pdlhxhOcdqJwlkJQ93pKApKZgybmRyh1RxwhxkrSTAg+RAneDIiYl7kdguRgU8JJ
 VXbbcBb0yNmayxXx0pEosuW3hyFkgN5cSEAhjNi74xFLs6KyQq1EB7GmVcoDQsei+42jq5hRn
 d3D7t+WJUlj4yT/+MwycuP8AUlmLTxljhxCxzyZBLD2OIHu2IiVokn+plNqMt1iFrtZv+UO83
 ytNnkVys3z4/fLZ/SeRuTq5jTvcFuzXbl0hsalsG2/z6bQtd9i1UYDRTqVlFt0Eo5zV/h8rpy
 1Agd76Wx0i0c2CzxvCIz8LnpqqgBGdMCzji/VbWtDtYdLaaqNa/hb+QifdV4vRVALqPueb1Do
 AkWnf+J+jarr2Krri0Rn/RUB+CmSdFxxslELHvT8DWvMwUPIwy5pdYyty3r4yF1J1Wkezjt+V
 hf1jsrS6Wcr1I/jDw8/ASxxPOef4rgbu/GeO7WnG4m33LAwi/Q=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 3, 2020 at 4:50 PM afzal mohammed <afzal.mohd.ma@gmail.com> wrote:
>
> Hi Arnd,
>
> > On Tue, Apr 14, 2020 at 09:29:46PM +0200, Arnd Bergmann wrote:
>
> > > Another thing to try early is to move the vmlinux virtual address
> > > from the linear mapping into vmalloc space. This does not require
> > > LPAE either, but it only works on relatively modern platforms that
> > > don't have conflicting fixed mappings there.
>
> i have started by attempting to move static kernel mapping from lowmem
> to vmalloc space. At boot the execution so far has went past assembly
> & reached C, to be specific, arm_memblock_init [in setup_arch()],
> currently debugging the hang that happens after that point.

Ah, good start. Which SoC platform are you running this on? Just making
sure that this won't conflict with static mappings later.

One problem I see immediately in arm_memblock_init() is that it uses
__pa() to convert from virtual address in the linear map to physical,
but now you actually pass an address that is in vmalloc rather than
the linear map. There are certainly more problems like this to come.

> To make things easier in the beginning, ARM_PATCH_PHYS_VIRT is disabled &
> platform specific PHYS_OFFSET is fed, this is planned to be fixed once
> it boots.
>
> [ i will probably start a new thread or hopefully RFC on LAKML ]

Ok, makes sense.

     Arnd
