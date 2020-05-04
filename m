Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1309EC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 09:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0AE82054F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 09:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cH+LYADn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgEDJKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 05:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726467AbgEDJKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 05:10:21 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70476C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 02:10:21 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id j21so216294pgb.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 02:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uIbF5zxX6Dw0nqWjJ2TagrefdsSTjGZ8h/iE+ii+4b4=;
        b=cH+LYADnJpxdzvW2+5Q1jFzZ9L9OyZncRQgoZJsu0phKyHmo/b1tb6JE/KAVmXislx
         576Ap7opHZUSUi70vyPGcMe0C9p7leyk8cASBIWKAwGsK8Y00lThuiFS3aNw65PsYLTm
         szhQMtXIBmQ2tAAcHVWgTijiqY0HV7xQgK5xZyE/QR599vulSPnvVwVtjGkKmy/Dtck5
         oIznVkUPaNZ0LtGj6iS59qmm9P3OHQSvVr5i8oQIHTb7kJ5GJncJ11cB4kee+KdWXypI
         BLlZ0XKGbYY2XjNxgkp917C15tyTspqX3/ZW8nK4NnjT3ll8+dlQFg8POxb8ZU3v61ad
         l8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uIbF5zxX6Dw0nqWjJ2TagrefdsSTjGZ8h/iE+ii+4b4=;
        b=FoOi/Buu6uc1JBYEzscZdQZzQn34K357hzskehC+84LCdIVKnCpwGhhaxPFBJU+mpA
         lB9dDpgOqU1R0eqv2WQEeFlrO6yuInwiyNgM49VUoaA9uc0PRKbKK6XtwKtwo30BYzPo
         ssLoAiFEZ8pLaqYepiAtttzcVjTMYDzJjlrY9GJ19e8dvSaQtLafx2pAu8Ln/zerFEKQ
         U/p0/p7QnTKHd6c8J9bzdtIoD3MtyJ841PDVsrdDme9lAMwK6wu/mW3d+am8BYE7Q6Q/
         FZGLJuEG32OgyKGDfSjwT+8n7l5+rOx5FmmgSf/xq1obUwH60zvjZ6rg9/ZmJM3UQ6s5
         ANGg==
X-Gm-Message-State: AGi0PuZSsFRR8xTtn6id1oUT945eCAPCIF+PGgo8VKDayK3i0Kd36h4Z
        l3tKHCeZTICzRG81MhIghLE=
X-Google-Smtp-Source: APiQypJG/fsOYbUSEQYZkHIQLG4hFpTXov1SCNDc2K85TTECtJawhDDWFsEna1ULkqdmyHpan3Z+ag==
X-Received: by 2002:aa7:97b2:: with SMTP id d18mr16995522pfq.89.1588583420829;
        Mon, 04 May 2020 02:10:20 -0700 (PDT)
Received: from localhost ([49.207.53.0])
        by smtp.gmail.com with ESMTPSA id gd17sm1461493pjb.21.2020.05.04.02.10.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 May 2020 02:10:19 -0700 (PDT)
Date:   Mon, 4 May 2020 14:40:18 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
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
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/3] Highmem support for 32-bit RISC-V
Message-ID: <20200504091018.GA24897@afzalpc>
References: <20200331093241.3728-1-tesheng@andestech.com>
 <CAK8P3a3LokurC0n9XiwtPQh9ZgQcswMKY4b+TEsQh1VgYDNeWA@mail.gmail.com>
 <20200408035118.GA1451@andestech.com>
 <CAK8P3a1JS3_2fWrhNTZx0eTWjJa-GTb4AscTPqydpSP5EB15Yw@mail.gmail.com>
 <20200414151748.GA5624@afzalpc>
 <CAK8P3a0JW9x-Wk9Ec3+zLjPHbWAvPQx8MF-xe-PnWUgEjRAuTg@mail.gmail.com>
 <20200415135407.GA6553@afzalpc>
 <20200503145017.GA5074@afzalpc>
 <CAK8P3a3OC5UO72rTDWi6+XgmExJmkATEjscq8hns8Bng06OpcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3OC5UO72rTDWi6+XgmExJmkATEjscq8hns8Bng06OpcQ@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ +linux-arm-kernel

  Context: This is regarding VMSPLIT_4G_4G support for 32-bit ARM as a
  possible replacement to highmem. For that, initially, it is being
  attempted to move static kernel mapping from lowmem to vmalloc space.

  in next reply, i will remove everyone/list !ARM related ]

Hi,

On Sun, May 03, 2020 at 10:20:39PM +0200, Arnd Bergmann wrote:

> Which SoC platform are you running this on? Just making
> sure that this won't conflict with static mappings later.

Versatile Express V2P-CA15 on qemu, qemu options include --smp 2 &
2GB memory.

BTW, i could not convince myself why, except for DEBUG_LL, static io
mappings are used.

> 
> One problem I see immediately in arm_memblock_init()

Earlier it went past arm_memblock_init(), issue was clearing the page
tables from VMALLOC_START in devicemaps_init() thr' paging_init(),
which was like cutting the sitting branch of the tree.

Now it is crashing at debug_ll_io_init() of devicemap_init(), and
printascii/earlycon was & is being used to debug :). Things are going
wrong when it tries to create mapping for debug_ll. It looks like a
conflict with static mapping, which you mentioned above, at the same
time i am not seeing kernel static mapping in the same virtual
address, need to dig deeper.

Also tried removing DEBUG_LL, there is a deafening silence in the
console ;)

> is that it uses
> __pa() to convert from virtual address in the linear map to physical,
> but now you actually pass an address that is in vmalloc rather than
> the linear map.

__virt_to_phys_nodebug() which does the actual work on __pa() invocation
has been modifed to handle that case (ideas lifted from ARM64's
implementation), though currently it is a hack as below (and applicable
only for ARM_PATCH_PHYS_VIRT disabled case), other hacks being
VMALLOC_OFFSET set to 0 and adjusting vmalloc size.

        static inline phys_addr_t __virt_to_phys_nodebug(unsigned long x)
        {
	        phys_addr_t __x = (phys_addr_t)x;

        	if (__x >= 0xf0000000)
	        	return __x - KIMAGE_OFFSET + PHYS_OFFSET;
        	else
	        	return __x - PAGE_OFFSET + PHYS_OFFSET;
        }

Regards
afzal
