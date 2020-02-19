Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4022C7114E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 21:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78CA02465D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 21:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="W7yNuWHa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgBSVzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 16:55:45 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34708 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgBSVzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 16:55:44 -0500
Received: by mail-qk1-f193.google.com with SMTP id c20so1708524qkm.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 13:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oXUWpHjcjyL4pSSPcqAy+aUHyOM86zgY+JkKG4C5ctI=;
        b=W7yNuWHaso4wSD6j2o5+l5mVwMu9RJEBlknWjo7qilDmUG0xrNgU/CCQ2z+5CLdugK
         3w0HKJ/k3ChIh1hbkERSWPCbctvcD7KzwHbYCb5L+JfoxnOLxQUhkJCzaiwaRoaXP/jU
         QckrX373TLmPxqD9ygxVWvZVp6+pwtA6GwnfkVyemHw1+199XPSHk7s8/oarWvBrFOHE
         HedqezkTVG23hiBpZqK7aBlSH3SR4buAuuWkk3tYLMGQApiHYLYHdncRq8Trg/DegAGa
         Lr6J8GO/oP2Fa/uWSQF/fYy2jLSDFDxzXBxrI3+Urz1lzYT9glxIdZ5FQVf3RQFPMOyN
         uDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oXUWpHjcjyL4pSSPcqAy+aUHyOM86zgY+JkKG4C5ctI=;
        b=CxT6i4mg205Za886/OdFbGlLunbHoDPzLXUR58oAE0RiSFgVMxO1+83MmzhrghVLlX
         lwfn7m5VKOXBZqBpiq4MVNGW/rwR5yNxySH1LtCUTy+cGxIoWspYlRaTP9vBoVAFYErz
         qbN9tjbTM8B0V+Whp68tejGBjm9fwo4xi/6NvSePXNiLFlJVJk+pHQpJldjaUZ7eNonl
         WFChbScLgaUrlugi/erIabdixI9OsoBL0dLZcKKDH5+0a8MDjw5DlMrZn8VpNUM4eoVk
         bweJO5twyZs2KMc8ubtust230P42UYCNzvlXJjTsIxn61oTl3LBIpDnV8EjXoykpi3qB
         pJHA==
X-Gm-Message-State: APjAAAXTK7hYqvpM1TnlPhPAkXF0ilDFulidGM2MJ55rqi9tXMpJcRds
        Agtp1ncTgZW322YUDQY/p1irHQ==
X-Google-Smtp-Source: APXvYqzY/nMwCyJtH8MQqZfF5V4++1XVUG9pp0fuYGJTlO+mA1LnWn3bx0Nt6VcYLFuCcH2eJ+fEVw==
X-Received: by 2002:a05:620a:13a7:: with SMTP id m7mr25240325qki.500.1582149342702;
        Wed, 19 Feb 2020 13:55:42 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 193sm581254qki.38.2020.02.19.13.55.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Feb 2020 13:55:42 -0800 (PST)
Message-ID: <1582149340.7365.103.camel@lca.pw>
Subject: Re: [PATCH -next v2] mm: annotate a data race in page_zonenum()
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     John Hubbard <jhubbard@nvidia.com>, paulmck@kernel.org,
        elver@google.com, david@redhat.com, jack@suse.cz,
        ira.weiny@intel.com, dan.j.williams@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 19 Feb 2020 16:55:40 -0500
In-Reply-To: <c1b1b448-ec64-c245-896c-462c55d94b3b@nvidia.com>
References: <1581619089-14472-1-git-send-email-cai@lca.pw>
         <c1b1b448-ec64-c245-896c-462c55d94b3b@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, since you had picked the similar one which also depends
on ASSERT_EXCLUSIVE_*, can you pick up this patch as well?

On Thu, 2020-02-13 at 13:20 -0800, John Hubbard wrote:
> On 2/13/20 10:38 AM, Qian Cai wrote:
> >  BUG: KCSAN: data-race in page_cpupid_xchg_last / put_page
> > 
> >  write (marked) to 0xfffffc0d48ec1a00 of 8 bytes by task 91442 on cpu 3:
> >   page_cpupid_xchg_last+0x51/0x80
> >   page_cpupid_xchg_last at mm/mmzone.c:109 (discriminator 11)
> >   wp_page_reuse+0x3e/0xc0
> >   wp_page_reuse at mm/memory.c:2453
> >   do_wp_page+0x472/0x7b0
> >   do_wp_page at mm/memory.c:2798
> >   __handle_mm_fault+0xcb0/0xd00
> >   handle_pte_fault at mm/memory.c:4049
> >   (inlined by) __handle_mm_fault at mm/memory.c:4163
> >   handle_mm_fault+0xfc/0x2f0
> >   handle_mm_fault at mm/memory.c:4200
> >   do_page_fault+0x263/0x6f9
> >   do_user_addr_fault at arch/x86/mm/fault.c:1465
> >   (inlined by) do_page_fault at arch/x86/mm/fault.c:1539
> >   page_fault+0x34/0x40
> > 
> >  read to 0xfffffc0d48ec1a00 of 8 bytes by task 94817 on cpu 69:
> >   put_page+0x15a/0x1f0
> >   page_zonenum at include/linux/mm.h:923
> >   (inlined by) is_zone_device_page at include/linux/mm.h:929
> >   (inlined by) page_is_devmap_managed at include/linux/mm.h:948
> >   (inlined by) put_page at include/linux/mm.h:1023
> >   wp_page_copy+0x571/0x930
> >   wp_page_copy at mm/memory.c:2615
> >   do_wp_page+0x107/0x7b0
> >   __handle_mm_fault+0xcb0/0xd00
> >   handle_mm_fault+0xfc/0x2f0
> >   do_page_fault+0x263/0x6f9
> >   page_fault+0x34/0x40
> > 
> >  Reported by Kernel Concurrency Sanitizer on:
> >  CPU: 69 PID: 94817 Comm: systemd-udevd Tainted: G        W  O L 5.5.0-next-20200204+ #6
> >  Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019
> > 
> > A page never changes its zone number. The zone number happens to be
> > stored in the same word as other bits which are modified, but the zone
> > number bits will never be modified by any other write, so it can accept
> > a reload of the zone bits after an intervening write and it don't need
> > to use READ_ONCE(). Thus, annotate this data race using
> > ASSERT_EXCLUSIVE_BITS() to also assert that there are no concurrent
> > writes to it.
> > 
> > Suggested-by: Marco Elver <elver@google.com>
> > Signed-off-by: Qian Cai <cai@lca.pw>
> > ---
> > 
> > v2: use ASSERT_EXCLUSIVE_BITS().
> 
> 
> Much cleaner, thanks to this new macro. You can add:
> 
> 
>     Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> 
> 
> thanks,
