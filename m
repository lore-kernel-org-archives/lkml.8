Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A98C2D0E7
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA074215A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Bh1JR39j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731885AbgDAIs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 04:48:29 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38264 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgDAIs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 04:48:29 -0400
Received: by mail-ed1-f66.google.com with SMTP id e5so28685206edq.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 01:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=feZj/1ocB6XIjJoDVsEEUrA2KaXFHt0B9wSHktP2ddQ=;
        b=Bh1JR39j+h1CpltTDW6HGFEOaXTLaNjNFTs/HHcXupyutEFcwNSNmspuDLCGf1ngc3
         3JpOjmwFyMJKqlOxTzogrVowaOb1QIi3j8ZxAAP5+dTIDs2wrDYNiFzAC1pNenb81J4x
         Y0o8J2WvYge0HdtQtAaBdaJuC6fhVWSw5yAjGewymen6zoiqepG1Pu2f2Syh3qjkbnM9
         63NpYqgZavpVqDdE02NRa8sgSS+1zoZJSGdCFyiEDE6u1Wuo2Qc2ha1yyqNmK6L2A0tu
         +GaivKSH2OYfiaNQXJyXBJPXwLpUUs6miQI82ISI/kufkqup77wKyM4fD8QUJdtlbmOJ
         Hi9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=feZj/1ocB6XIjJoDVsEEUrA2KaXFHt0B9wSHktP2ddQ=;
        b=FIJ+tzB/xDzRQmNjCMfO80PV90VbmPhrcghoI5kuD3PdJgW0Y7DKaAeSUfe9N8rma6
         JPGn8nPsKLC6ELERRoRdRtPBXrenFzbZORjxoLePSX0nvdCZoApuQOnRK19JkvgEMriT
         W5QwgpchIn00Db9z07SFsZ2ok4ra/RlcPgOcSRgvg+TSJcdPa20qm7Kbkrt7GQq0h/w6
         TBbGilIR//UE0d79n5oaRh9H55Oh9Pcu7uo2yvBELQYlzwu67rT7m+W5Ux9dJ/JZ8iuk
         J5ilvMGSgSOUrMaGuuSHOLnUx9c7rAg13o6XArTyTny75xDrxmyiLRAisUScUOVVtREP
         XPiA==
X-Gm-Message-State: ANhLgQ1XszQdRHhxoQvFkdZ8dScVII3LJfN7OP2NhglzccG7j9QJQwbJ
        6Up7SJC0XM6ELMdIEUMTSJqvs0Zmx3HuCoC3xekNxA==
X-Google-Smtp-Source: ADFU+vuVdufBykICW7DqF15W3KALGotPW1gMa6p2yo6taAqlQuWcuvysMS1tCXsRtLbaLnYvh0bX4T16tZYwkhRj3fU=
X-Received: by 2002:a05:6402:b17:: with SMTP id bm23mr19586972edb.165.1585730907196;
 Wed, 01 Apr 2020 01:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200327071202.2159885-1-alastair@d-silva.org> <20200327071202.2159885-3-alastair@d-silva.org>
In-Reply-To: <20200327071202.2159885-3-alastair@d-silva.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 1 Apr 2020 01:48:16 -0700
Message-ID: <CAPcyv4h9uDxHDb0iN+zwhPB=By8Ps8cwTyipf6b64v+ruzhchg@mail.gmail.com>
Subject: Re: [PATCH v4 02/25] mm/memory_hotplug: Allow check_hotplug_memory_addressable
 to be called from drivers
To:     "Alastair D'Silva" <alastair@d-silva.org>
Cc:     "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kurz <groug@kaod.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 29, 2020 at 10:23 PM Alastair D'Silva <alastair@d-silva.org> wrote:
>
> When setting up OpenCAPI connected persistent memory, the range check may
> not be performed until quite late (or perhaps not at all, if the user does
> not establish a DAX device).
>
> This patch makes the range check callable so we can perform the check while
> probing the OpenCAPI Persistent Memory device.
>
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>
> ---
>  include/linux/memory_hotplug.h | 5 +++++
>  mm/memory_hotplug.c            | 4 ++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index f4d59155f3d4..9a19ae0d7e31 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -337,6 +337,11 @@ static inline void __remove_memory(int nid, u64 start, u64 size) {}
>  extern void set_zone_contiguous(struct zone *zone);
>  extern void clear_zone_contiguous(struct zone *zone);
>
> +#ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
> +int check_hotplug_memory_addressable(unsigned long pfn,
> +                                    unsigned long nr_pages);
> +#endif /* CONFIG_MEMORY_HOTPLUG_SPARSE */

Let's move this to include/linux/memory.h with the other
CONFIG_MEMORY_HOTPLUG_SPARSE declarations, and add a dummy
implementation for the CONFIG_MEMORY_HOTPLUG_SPARSE=n case.

Also, this patch can be squashed with the next one, no need for it to
be stand alone.


> +
>  extern void __ref free_area_init_core_hotplug(int nid);
>  extern int __add_memory(int nid, u64 start, u64 size);
>  extern int add_memory(int nid, u64 start, u64 size);
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 0a54ffac8c68..14945f033594 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -276,8 +276,8 @@ static int check_pfn_span(unsigned long pfn, unsigned long nr_pages,
>         return 0;
>  }
>
> -static int check_hotplug_memory_addressable(unsigned long pfn,
> -                                           unsigned long nr_pages)
> +int check_hotplug_memory_addressable(unsigned long pfn,
> +                                    unsigned long nr_pages)
>  {
>         const u64 max_addr = PFN_PHYS(pfn + nr_pages) - 1;
>
> --
> 2.24.1
>
