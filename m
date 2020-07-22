Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830B0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 20:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6644B20684
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 20:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732566AbgGVUWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 16:22:45 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:42915 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgGVUWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 16:22:44 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N7zNt-1kuHVR43Kl-0155Dj for <linux-kernel@vger.kernel.org>; Wed, 22 Jul
 2020 22:22:43 +0200
Received: by mail-qt1-f181.google.com with SMTP id 6so2863990qtt.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 13:22:42 -0700 (PDT)
X-Gm-Message-State: AOAM530fNPwjI9AXsKOAxR+2uVFb/GvVoTmCYJXVEyxb4ebysTSew3Lp
        ejnmMiMCvQt9Cnc8dL6vDGjqXZgafUTH3F9aqYo=
X-Google-Smtp-Source: ABdhPJzomOuvyv87HLrmnRqLMg+xagc+vFRLOHIlCjUhIO6Ps1D+MblDa1Ac6NHH61/GfVpqpoR58oXKvv+qOpTZNZk=
X-Received: by 2002:ac8:6743:: with SMTP id n3mr1132159qtp.7.1595449361849;
 Wed, 22 Jul 2020 13:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a34sT2bQbkZUjaxaShzCkn+s35pXxS0UNhqGFu+t2hZYw@mail.gmail.com>
 <mhng-820ebe55-b4a3-4ab3-b848-6d3551b43091@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-820ebe55-b4a3-4ab3-b848-6d3551b43091@palmerdabbelt-glaptop1>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 22 Jul 2020 22:22:25 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2VHXDLK6iba=NxSQ-t=9P7LSwzwx3XrK=N=M+qoX_oeQ@mail.gmail.com>
Message-ID: <CAK8P3a2VHXDLK6iba=NxSQ-t=9P7LSwzwx3XrK=N=M+qoX_oeQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] riscv: Move kernel mapping to vmalloc zone
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Alexandre Ghiti <alex@ghiti.fr>, Albert Ou <aou@eecs.berkeley.edu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linux-MM <linux-mm@kvack.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Mackerras <paulus@samba.org>,
        Zong Li <zong.li@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:9vkYCDJmvYwb5URpXaDM+la+4kepzavYjlt9hqPnJqKRPI6eKW4
 6sOsFIFn47uxY38ztrWUjk+xfOcR6ptqSoEXhVkEUQ95MTZSyMYjog/VrxLAss+sy+xZAJu
 OKVnQnjmtC2vXaYoPglA5FmuqqaxXSM0ZG1gD/DWvFpv4sAcMnEPhR/6dfk6ZNqTACYr754
 kubdmpCEKhXU1sID7DJHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BeYHuheCQD0=:GD9dn33K3tWuL2rvUuTamS
 DPkvmv3u8jAJtJPpBDP+bjHIJVmx3B6N4Kx2Iy9paj9y82diPWi4pKEVCofWY4oT/OMq22sf3
 Qq0BmjyRe6SdpDwH2oBDGoK/XlwN6hoKuZNihDYjUwFz0Tkz5q9eW124hjEVcifytBL4wOgWh
 Y0ui8xsROECASvu0nlaJq47SqC3w3/ZcwAV5jV44m1OPK2u2UO3lksgYM/U7mTdSlyZ/76Kua
 rsjtrZ3292bW5ZR8cwIzblbwZzHFT0BFx6/ymiDkdNCQr7OEqG+CHUwd4OeJEGKMRymBhnS2x
 qz1RtRIHDHXWRwBwJGkN/eefVo3mZp2L2Jz66anFFP/lXy/OCV5B/1OUGwY5qBNry23dM3/eI
 RvOEMgjmEjpYtDM0dVhIQ/U8uIc/OD1MZdto6TtrSQuOeGcVKU+yEJ4JdX/xmobCUii8t45ys
 NIkFaMhbnk5rKv/ERiuHszJfvGvKiBlBqSppadT1kmAxE+20SUY8S+mUwodcVFsYhata31Eg1
 1pTD3JNXXMO4cxyqSdxk5BDndXbsbWqiKt8tek6CSJIViO05fJsnkZVIkOAwoIloT1h3F4FdS
 Z5Lee1BNuWnFkAwLoDLn91fggX8olfJHRK4gkBUQydR4BjBrfzxmh7u9Ov2a8R1v/EjYYxakJ
 piv5LrybbJi8odnVryKx3MA8tByKE1FCd6eZfRyzsr22EAglXSGQmIg4FQKbz/d+UhlQDUj5z
 ukwmSK2NrcYeJFnfu/4SnL2LP4Ar9EIfNFQsrdewCr1GnrtiU21JS2PeWP2h9PXdunZQnKe6i
 ob4gJ6G8w4V4mqFV/ljF0rXzcgQdujBVGsirFEcer2WeuSwTI/SFC9KW+psS/vYfJlRkImj
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 9:52 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> On Wed, 22 Jul 2020 02:43:50 PDT (-0700), Arnd Bergmann wrote:
> > On Tue, Jul 21, 2020 at 9:06 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> > The eventual goal is to have a split of 3840MB for either user or linear map
> > plus and 256MB for vmalloc, including the kernel. Switching between linear
> > and user has a noticeable runtime overhead, but it relaxes both the limits
> > for user memory and lowmem, and it provides a somewhat stronger
> > address space isolation.
>
> Ya, I think we decided not to do that, at least for now.  I guess the right
> answer there will depend on what 32-bit systems look like, and since we don't
> have any I'm inclined to just stick to the fast option.

Makes sense. Actually on 32-bit Arm we see fewer large-memory
configurations in new machines than we had in the past before 64-bit
machines were widely available at low cost, so I expect not to see a
lot new hardware with more than 1GB of DDR3 (two 256Mbit x16 chips)
for cost reasons, and rv32 is likely going to be similar, so you may never
really see a need for highmem or the above hack to increase the
size of the linear mapping.

I just noticed that rv32 allows 2GB of lowmem rather than just the usual
768MB or 1GB, at the expense of addressable user memory. This seems
like an unusual choice, but I also don't see any reason to change this
or make it more flexible unless actual users appear.

       Arnd
