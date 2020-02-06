Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E186C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 14:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D708521741
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 14:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FbUGxv1c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgBFOgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 09:36:07 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35411 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727918AbgBFOgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 09:36:06 -0500
Received: by mail-oi1-f196.google.com with SMTP id b18so4780990oie.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 06:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IT/4zHjOh200HmYb8h25YpjZhD6lgpiv0/9/WWAiH68=;
        b=FbUGxv1cxFUWutiz0bnXFJNyshJXi/tv2Jr+GuW6lP8L+c5HcXG5pfeiWOLEgd4Qx8
         Sn3Efn+nbaedB/q4+Oy9AtDnOfUU131sBlrg8DDHTT8U4/wXszEJzMwVYThnogvFtyze
         jx/u+jfWDnkGoZpu4OoEQRPHIQjkrQ1uc4SOgZsfjalnoyN4RNqscTpfjryx4FTUjayl
         Zu0kW0NB/ieBh17uzdXQ5x8ZKuJ32grittiNKnN1APDVjYe3OGVI4wEzhzZiPirAac34
         Px6TQPEPs5fmP8lfa1/sajlOtzcuVHaPO+IgoCXxG1WlLeJ1f+WAwLGow5LuV0qP1us4
         orTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IT/4zHjOh200HmYb8h25YpjZhD6lgpiv0/9/WWAiH68=;
        b=Rxw8Dy5g14iOcVrgOZm6GCSjQkJyEVVUdiCHf57smUTa2qA+pm3mCoXD0Fp4gZ5vNe
         JajuvUDHnTFypdMgKAsSiBG/htyQMx2AE5gZYhza3Zy3sGXspNvztGBNhjgnRxlaSStv
         91wrgNMO7ETPE9FtanYmZnn9h5VkWC+Ea6rVu+xBtc3ZZS2A4rhz3ZCbD/EaL4/SH6oG
         mHL44R8gnVLSbetRyVNO9x8NF2SyZYMmuogI5ppeqf9bt000kX0jAxOm3klwKI7AqNpK
         kPdTTxL53N1qDdHPqCXvdH6kNQ5uH1qQAVZMlcPsqhvR+RUZ01t1V98E3K7RqsrtSeZA
         FXFg==
X-Gm-Message-State: APjAAAVeZk0kx9zHX8OO+XkOpbSK6bI4eI4Spgq4rJkdb5UQCJqSE1im
        a2Ln/Vb/G3CrfUkZJiYOv3/C62w8CnDmfTLL5jsTQA==
X-Google-Smtp-Source: APXvYqzqcGokq1CUeO2aXkm8mHvS33y1M1bXkU3p/NdtErFcl8f3TRsnUFrsAPotbe9pQ1F6FtnG80cx64mMUXKNx2U=
X-Received: by 2002:aca:d4c1:: with SMTP id l184mr7225694oig.172.1580999765419;
 Thu, 06 Feb 2020 06:36:05 -0800 (PST)
MIME-Version: 1.0
References: <20200206035235.2537-1-cai@lca.pw> <480a7dde-f678-c07b-2231-4da8e0a38753@nvidia.com>
 <1580997681.7365.14.camel@lca.pw>
In-Reply-To: <1580997681.7365.14.camel@lca.pw>
From:   Marco Elver <elver@google.com>
Date:   Thu, 6 Feb 2020 15:35:53 +0100
Message-ID: <CANpmjNNX1apK0izjPhRG3kG-O_iKG1nGrOEL+PAvpH86QLXZMg@mail.gmail.com>
Subject: Re: [PATCH -next] mm: mark a intentional data race in page_zonenum()
To:     Qian Cai <cai@lca.pw>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>, ira.weiny@intel.com,
        dan.j.williams@intel.com, jack@suse.cz,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Feb 2020 at 15:01, Qian Cai <cai@lca.pw> wrote:
>
> On Wed, 2020-02-05 at 20:50 -0800, John Hubbard wrote:
> > On 2/5/20 7:52 PM, Qian Cai wrote:
> > > The commit 07d802699528 ("mm: devmap: refactor 1-based refcounting for
> > > ZONE_DEVICE pages") introduced a data race as page->flags could be
> >
> > Hi,
> >
> > I really don't think so. This "race" was there long before that commit.
> > Anyway, more below:
> >
> > > accessed concurrently as noticied by KCSAN,
> > >
> > >   BUG: KCSAN: data-race in page_cpupid_xchg_last / put_page
> > >
> > >   write (marked) to 0xfffffc0d48ec1a00 of 8 bytes by task 91442 on cpu 3:
> > >    page_cpupid_xchg_last+0x51/0x80
> > >    page_cpupid_xchg_last at mm/mmzone.c:109 (discriminator 11)
> > >    wp_page_reuse+0x3e/0xc0
> > >    wp_page_reuse at mm/memory.c:2453
> > >    do_wp_page+0x472/0x7b0
> > >    do_wp_page at mm/memory.c:2798
> > >    __handle_mm_fault+0xcb0/0xd00
> > >    handle_pte_fault at mm/memory.c:4049
> > >    (inlined by) __handle_mm_fault at mm/memory.c:4163
> > >    handle_mm_fault+0xfc/0x2f0
> > >    handle_mm_fault at mm/memory.c:4200
> > >    do_page_fault+0x263/0x6f9
> > >    do_user_addr_fault at arch/x86/mm/fault.c:1465
> > >    (inlined by) do_page_fault at arch/x86/mm/fault.c:1539
> > >    page_fault+0x34/0x40
> > >
> > >   read to 0xfffffc0d48ec1a00 of 8 bytes by task 94817 on cpu 69:
> > >    put_page+0x15a/0x1f0
> > >    page_zonenum at include/linux/mm.h:923
> > >    (inlined by) is_zone_device_page at include/linux/mm.h:929
> > >    (inlined by) page_is_devmap_managed at include/linux/mm.h:948
> > >    (inlined by) put_page at include/linux/mm.h:1023
> > >    wp_page_copy+0x571/0x930
> > >    wp_page_copy at mm/memory.c:2615
> > >    do_wp_page+0x107/0x7b0
> > >    __handle_mm_fault+0xcb0/0xd00
> > >    handle_mm_fault+0xfc/0x2f0
> > >    do_page_fault+0x263/0x6f9
> > >    page_fault+0x34/0x40
> > >
> > >   Reported by Kernel Concurrency Sanitizer on:
> > >   CPU: 69 PID: 94817 Comm: systemd-udevd Tainted: G        W  O L 5.5.0-next-20200204+ #6
> > >   Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019
> > >
> > > Both the read and write are done only with the non-exclusive mmap_sem
> > > held. Since the read only check for a specific bit in the flag, even if
> >
> >
> > Perhaps a clearer explanation is that the read of the page flags is always
> > looking at a bit range (zone number: up to 3 bits) that is not being written to by
> > the writer.
> >
> >
> > > load tearing happens, it will be harmless, so just mark it as an
> > > intentional data races using the data_race() macro.
> > >
> > > Signed-off-by: Qian Cai <cai@lca.pw>
> > > ---
> > >   include/linux/mm.h | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > index 52269e56c514..cafccad584c2 100644
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h
> > > @@ -920,7 +920,7 @@ vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf);
> > >
> > >   static inline enum zone_type page_zonenum(const struct page *page)
> > >   {
> > > -   return (page->flags >> ZONES_PGSHIFT) & ZONES_MASK;
> > > +   return data_race((page->flags >> ZONES_PGSHIFT) & ZONES_MASK);
> >
> >
> > I don't know about this. Lots of the kernel is written to do this sort
> > of thing, and adding a load of "data_race()" everywhere is...well, I'm not
> > sure if it's really the best way.  I wonder: could we maybe teach this
> > kcsan thing to understand a few of the key idioms, particularly about page
> > flags, instead of annotating all over the place?
>
> My understanding is that it is rather difficult to change the compilers, but it
> is a good question and I Cc Marco who is the maintainer for KCSAN that might
> give you a definite answer.

The problem is that there is no general idiom where we could say with
confidence that a data race is safe across the whole kernel. Here it
might not matter, but somewhere else it might matter a lot.

If you think that it turns out the entire file may be littered with
'data_race()', and you do not want to use annotations, you can
blacklist the file. I already had to do this for other files in mm/,
because concurrent flag modification/checking is pervasive and a lot
of them seem 'benign'. We decided to revisit those files later.

Feel free to add 'KCSAN_SANITIZE_memory.o := n' or whatever other
files you think are full of these to mm/Makefile.

The only problem I see with that is that it's not obvious what is
concurrently modified and what isn't. The annotations would have
helped document what is happening.

Thanks,
-- Marco
