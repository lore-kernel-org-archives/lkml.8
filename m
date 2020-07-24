Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE200C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 908F52074A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgGXIOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 04:14:46 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:44661 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgGXIOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 04:14:45 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M42zo-1jysqq0f9k-0003bn for <linux-kernel@vger.kernel.org>; Fri, 24 Jul
 2020 10:14:44 +0200
Received: by mail-qt1-f174.google.com with SMTP id o22so6090206qtt.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 01:14:43 -0700 (PDT)
X-Gm-Message-State: AOAM531Eitt9lseBhkip8q7TGf2XPd5Lf3vC7Pepj5YwLUX/XLVtF7H0
        Z4jgR8Y5tofbNeOaia/key/ASzQCQ8F9yPDY3ZU=
X-Google-Smtp-Source: ABdhPJygisjtG0/T5RZOpGU5w2vxR1Ybi3XIk/oHG1gnkzduo22/qOY0PE84/zvIhSqmrnDmSiaO0gHwgOoBfMX/5hA=
X-Received: by 2002:ac8:7587:: with SMTP id s7mr8295990qtq.304.1595578483047;
 Fri, 24 Jul 2020 01:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-831c4073-aefa-4aa0-a583-6a17f9aff9b7@palmerdabbelt-glaptop1>
 <d7e3cbb7-c12a-bce2-f1db-c336d15f74bd@ghiti.fr> <7cb2285e-68ba-6827-5e61-e33a4b65ac03@ghiti.fr>
 <54af168083aee9dbda1b531227521a26b77ba2c8.camel@kernel.crashing.org>
 <cade70e2-0179-2650-41c5-036679aaf30c@ghiti.fr> <418d5f3d3f42bbc79c5cf30e18ec89edfe2dbd26.camel@kernel.crashing.org>
In-Reply-To: <418d5f3d3f42bbc79c5cf30e18ec89edfe2dbd26.camel@kernel.crashing.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 24 Jul 2020 10:14:26 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3dap8tDQVf3B9DdjQm0A_QtCwv3+tW6AUxC1Xq_VoL=A@mail.gmail.com>
Message-ID: <CAK8P3a3dap8tDQVf3B9DdjQm0A_QtCwv3+tW6AUxC1Xq_VoL=A@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] riscv: Move kernel mapping to vmalloc zone
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Alex Ghiti <alex@ghiti.fr>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
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
X-Provags-ID: V03:K1:HDwZL9icJfxyMmpxtY3DvBs7U9uzzEZ0jHaAzBBDsJ2so8pPZPS
 /wu/uOwXTpyPAdvrdgc4tnVagGr+uPCi76sAKJu6/QBK/4wi+QMt9bYLK9z+5BAXlPfQC8L
 lNVgPy1/NlmfVW0LriHqIpzdJCRzPS0ouPnnOVWdZBWTfn7nIfjdAyE726HqyxyPwG2JIug
 P1+JDJ5B6Vxw4iUncm3qA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3PfhPQFARng=:lZ2ZWn6Ajn53EoqwHCDtHX
 UrEtsq7ay2AIwwoaVqYR1sv9V4WgUpUsOkgzWchvn2cUt95RxwJW5ZeF2dLGZRyXbOYD6YYLA
 96V3YbIoN9M4k9KtVyJ7h3N4/rCeOA5iyrwEY5H6SjQXXYIhDZBsbTuhJYrotVp9hrwCqYwKE
 0A4knKgLbl/daJmCATmq8BASlWR0xmMfjOAV1t/nYQsUB/rG1w9lngehZNluY6K6mPzhfNEzZ
 IdKvuscX69ZwcpM9jJTdRGCjtVS2xf8S5JTQH7JkXTanqF8SRZrmjL2Pac93vR934TL9zl3xx
 4Z0zBhFKV+axcFsCC6ciZT5q3cWBVeplIzbD3QofoCDTHnpTsNSqfzTAbP9A6Vj4ATBU2CamC
 iaSanrrvDxYBsvcDZLRWoauYgpIBPzLxzH8OxAaToxp+C9EjNZUIfOybSmZTAjfLlA/ATLW+J
 LQGmTQokI5jxyjDB9DeXNcrdaw/HwWGNQnisBK4eDz3jfjzW2fpR/IJNEsT8GLkn4qWEywve2
 /cPTPCKk1/VYlw14VK0e6ruFH/6Ii6gZUE9Y46PzKFLXA2rqoLUooRPlPztoch3E9dqqCIbO5
 pWmXmemJXA1EuaBsqViGldVKFIOYzJo72lnkzviYIvykms52QT9WFTiOVZwLRbQ4miCL/2bUW
 IxOkm4LhdFM5Dbre/mgNQe/f8Z8JhHOG5hKSUF5CMumvGrYZvOXSMHL8TSBP6KlENyHb17ilG
 MAhgGIlgAOnnR/d0emkx/JpidMkSa8oCyPjDd00xtUBY0KtLtEZUaEYNnZepZlg9osHqxebj7
 UTxzWF/T3hqkXY7WkwtWZzNe+dpRXozJn6Fr4SRZXRCCtoczwPqlvJm9uEI04SokT9Kht0tM6
 JxYgrWjfiLIkda034QKfWEC7nzKhXOc9/piHRTKbNdOlxdeGMmGRjxLCI51p/TLVuhiS1VVuK
 lByu/L20B+iqWcBpeePZ0ms4XblV+OAI2Mn1tL797sTaAMvol/sWY
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 12:34 AM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Thu, 2020-07-23 at 01:21 -0400, Alex Ghiti wrote:
> > > works fine with huge pages, what is your problem there ? You rely on
> > > punching small-page size holes in there ?
> > >
> >
> > ARCH_HAS_STRICT_KERNEL_RWX prevents the use of a hugepage for the kernel
> > mapping in the direct mapping as it sets different permissions to
> > different part of the kernel (data, text..etc).
>
> Ah ok, that can be solved in a couple of ways...
>
> One is to use the linker script to ensure those sections are linked
> HUGE_PAGE_SIZE appart and moved appropriately by early boot code. One
> is to selectively degrade just those huge pages.
>
> I'm not familiar with the RiscV MMU (I should probably go have a look)
> but if it's a classic radix tree with huge pages at PUD/PMD level, then
> you could just degrade the one(s) that cross those boundaries.

That would work, but if the system can otherwise use 1GB-sized pages,
that might mean degrading the first gigabyte into a mix of 2MB pages
and 4KB pages.

If the kernel is in vmalloc space and vmap is able to use 2MB pages
for contiguous chunks of the mapping, you get a somewhat better
TLB usage.

However, this also means that a writable mapping exists in the
linear mapping for any executable part of the kernel (.text in
both vmlinux and modules). Do we have that on other architectures
as well, or is this something that ought to be prevented with
STRICT_KERNEL_RWX/STRICT_MODULE_RWX?

     Arnd
