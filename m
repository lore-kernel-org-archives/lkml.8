Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032BDC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE8C320768
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbgGXHUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:20:45 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:45293 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbgGXHUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:20:45 -0400
Received: from mail-qt1-f171.google.com ([209.85.160.171]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MjjGV-1keHEv2wmp-00lBo2 for <linux-kernel@vger.kernel.org>; Fri, 24 Jul
 2020 09:20:42 +0200
Received: by mail-qt1-f171.google.com with SMTP id t23so3149267qto.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 00:20:42 -0700 (PDT)
X-Gm-Message-State: AOAM530SuF7OG5XqMfg6GPpaYbF5q46RH1mT0E0GSteu2NH74iM3qB+N
        iWSyCo+GeZOwFaBxdjis+5M28VZmfusqDhGu4e4=
X-Google-Smtp-Source: ABdhPJxmIVXnbEioXbPXSA7ZMWes4VKvilueIEtCY7yjI+BhfVsAWHUQWo3DE1p/ihdJ0qb68PSFrNOEs1zZFP+V6+8=
X-Received: by 2002:ac8:688e:: with SMTP id m14mr1188191qtq.7.1595575241528;
 Fri, 24 Jul 2020 00:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a34sT2bQbkZUjaxaShzCkn+s35pXxS0UNhqGFu+t2hZYw@mail.gmail.com>
 <mhng-820ebe55-b4a3-4ab3-b848-6d3551b43091@palmerdabbelt-glaptop1>
 <CAK8P3a2VHXDLK6iba=NxSQ-t=9P7LSwzwx3XrK=N=M+qoX_oeQ@mail.gmail.com> <CAOnJCULmX+vUcpEmBd5w7xjtZSFk=Ju2V=wBJCOXHQ8m9yG9-Q@mail.gmail.com>
In-Reply-To: <CAOnJCULmX+vUcpEmBd5w7xjtZSFk=Ju2V=wBJCOXHQ8m9yG9-Q@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 24 Jul 2020 09:20:25 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2u9Z6wfyRduC7396929t4VnJQ0cXMiMWO7o6tgx_uNOw@mail.gmail.com>
Message-ID: <CAK8P3a2u9Z6wfyRduC7396929t4VnJQ0cXMiMWO7o6tgx_uNOw@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] riscv: Move kernel mapping to vmalloc zone
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Atish Patra <Atish.Patra@wdc.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Linux-MM <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>,
        Zong Li <zong.li@sifive.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:4RxKmOPWc9H9BLSFLVfdf0UfPQUj6IMmf++wlXBiilqiu6BgDbp
 k42jkriobOIuL+51rooxxuB+q6jzOeCiFJf/LcyZ6ORD/rlw6P0heIhL+L/MAl//rVRqx4A
 w4VZofKyhsebEzEvwumKMYDH4ksDyradhOXaxaOAxlphb38B13v9gEOM1nriup/ArXpRYF8
 2YsXtYKIyg6bxPLYOiUMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2xAHuEgwJFI=:rfCHtkHsWokaz4xcBIPZQy
 OZUzWD5xEs7YaQT3R+DJLkoFZRZ+R8HjY6crXeSNBLDBPyXCfkW+yGxP/UWg8z9UVcg7n7bA0
 DXfjhp2U6RyE/YsQOoCB+P35cdZQldjtJOxrSXV6ipzTP+yuVhzCQB9VK0c8QUpxDrnGeueiR
 ezG4owhdxVtkAq3L+KcQFcWAxsMfbDMY/pwBeEL9MC0eOKIgeV9NJYCy54Kl5pLCqdS3t1ucu
 JdccXirMi/CI5dFP1VAmMGIqP70srVikM4myxxk3UDVtGbSfc6ypX4nsCtQAXXE1pn8EX0pAO
 CxO1zyj3uLN2+R06OcqpG2LbapWroIDaNh0Wip73n1oZ8t/LoErvreX++hUWV9MKi9n8vMDsj
 ZGwvvO8dUcqmffQxDSYmgIt1K5d5v4EHSQ7r86t81uVfOGS6kULmojkkSVqygsymQXOEMtJOk
 7E3rEjVkXVbkC7uE26f2zskWrgHEoQmZEl1X5hgGi8ltwDc7lNGLhW5nQBN0iM6YcqH9emT8H
 6qQfs/f3D0loAomPtzUZ6FeucmgO6XHLU9ol8DM5yfXY+Yqan8G+wvpYfvVSCh5gATZ2rYEW+
 rKLapG5M3FESQS0wFSxTgCQK/DtRFm0tGoYr6iAYqVzkxFmaKySDNceyaXPmMwKXDnNMLh3Hx
 IDEUs/FlI3EWHCfWDEZq7GaZIHIz3JqogtlFyGI6HWSZ0tRxvbDTfklmE8SlOLaUe/+rdmVRc
 38rLHq79CFNfxCMr8731gBxR5bQenX+feVJG5gPD159A9DpoPKJ/fCiPZtQdkZq1fYze0Tx84
 47Eg1eHEztfVfzEnTtyvAbRI5gBib4PDt8g2LNQoVxFG6uyox3I9+Pz7DGvviAJ2ln+IYRr6F
 YgaaX9pS2wQSVtRkgb24qiTY916Q8O6G6HCpshReijiEY+OyXFAmVxPTmeLP/KYTn/qP2U+fV
 94Vajy67VckXwljRzIgYmUpZsJslxP9wLuHlNYxGbtLLYeJzi3/gv
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 11:06 PM Atish Patra <atishp@atishpatra.org> wrote:
>
> On Wed, Jul 22, 2020 at 1:23 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > I just noticed that rv32 allows 2GB of lowmem rather than just the usual
> > 768MB or 1GB, at the expense of addressable user memory. This seems
> > like an unusual choice, but I also don't see any reason to change this
> > or make it more flexible unless actual users appear.
> >
>
> I am a bit confused here. As per my understanding, RV32 supports 1GB
> of lowmem only
> as the page offset is set to 0xC0000000. The config option
> MAXPHYSMEM_2GB is misleading
> as RV32 actually allows 1GB of physical memory only.

Ok, in that case I was apparently misled by the Kconfig option name.

I just tried building a kernel to see what the boundaries actually are,
as this is not the only confusing bit. Here is what I see:

0x9dc00000 TASK_SIZE/FIXADDR_START   /* code comment says 0x9fc00000 */
0x9e000000 FIXADDR_TOP/PCI_IO_START
0x9f000000 PCI_IO_END/VMEMMAP_START
0xa0000000 VMEMMAP_END/VMALLOC_START
0xc0000000 VMALLOC_END/PAGE_OFFSET

Having exactly 1GB of linear map does make a lot of sense. Having PCI I/O,
vmemmap and fixmap come out of the user range means you get slightly
different behavior in user space if there are any changes to that set, but
that is probably fine as well, if you want the flexibility to go to a 2GB linear
map and expect user space to deal with that as well.

There is one common trick from arm32 however that you might want to
consider: if vmalloc was moved above the linear map rather than below,
the size of the vmalloc area can dynamically depend on the amount of
RAM that is actually present rather than be set to a fixed value.

On arm32, there is around 240MB of vmalloc space if the linear map
is fully populated with RAM, but it can grow to use all of the avaialable
address space if less RAM was detected at boot time (up to 3GB
depending on CONFIG_VMSPLIT).

> Any memory blocks beyond
> DRAM + 1GB are removed in setup_bootmem. IMHO, The current config
> should clarify that.
>
> Moreover, we should add 2G split under a separate configuration if we
> want to support that.

Right. It's probably not needed immediately, but can't hurt either.

    Arnd
