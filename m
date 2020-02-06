Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1641C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 14:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C346221775
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 14:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKlSdrD3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgBFO0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 09:26:03 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46218 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbgBFO0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 09:26:02 -0500
Received: by mail-qk1-f193.google.com with SMTP id g195so5625907qke.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 06:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nR1RdUPrKU1WwIP4V69fKACRdVxj4e2JmV7Fy+KOsHg=;
        b=iKlSdrD3lo6OtojyUEGrQL6WfFjwDXw6CBH4yDsHk/vZyglgsRzMGmQm9QRe82Gcqt
         6ydlMwN39lMEcsqKlA6eFEdpfrAPMqtY/99M5KvMv39euvS6SouySMQpG15oNpy0xGZ3
         SX+SliTZaXVmC/w0916ORwisS7ODHwSP++18V6pb7q11JLFd19sEWdhdoZIIjusxc/Uw
         O1SeLxFKhYjNlojf69Fg9rxJoclCnMe3QEZpg+p6Lk/Kgr15Vp2/IJ1ilL/8PwCBRc+D
         nJqwwA4HeqY+5cXMODZ6Z9EG3pxwpoBrUsba2t7ycH99Ko07MqBV0JM0EmdRhjntcFma
         +OFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=nR1RdUPrKU1WwIP4V69fKACRdVxj4e2JmV7Fy+KOsHg=;
        b=Zdvy0kvbMNY4K7FP018H42i2UVaD+mGrASTO2eCttTjzdfrjieZRtUaI+69UEI9Imp
         q4i/Os4QGmCQL8VS4vwSyAmMm7qSz81fdaS43AR2QN+pi0Hq7egIA/6EIceJ1ArCwBIl
         8wwHTwMuqFn3h1O1CQgR/U5yB1y9KJDmrrWHX/CD9iSIGBoDDPA/EBwTg96GdfhKB7Q2
         VGmK/IjdmA6PK8qhNvJ3GB1C0w7YneyiTGTnx6RmjzZQ2ZLs2s7imfhc6yotqDB9aVRg
         TBEXCacinf0ki96P7MYPqFrF7rXsz3pmbEreBIOIVR3GSHZRMj8Er08z1uTSVQjwQGQp
         t20g==
X-Gm-Message-State: APjAAAWPkvwSaE1HO5htRlqjwc3Csy3oTxXC5lmkqxpA781PmWo3qSOo
        2ds4BzurcBVcUlaqXUJ2V26I8NakrbM=
X-Google-Smtp-Source: APXvYqxjx0ABLMaUj/oIQcb1K6ul/jb3Sow74jaG+55IvLa1WfOGJ2YEoTXJ5dysG4KebO8hsa79Ew==
X-Received: by 2002:a05:620a:150e:: with SMTP id i14mr2718113qkk.273.1580999161521;
        Thu, 06 Feb 2020 06:26:01 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id w1sm1748659qtk.31.2020.02.06.06.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 06:26:01 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 6 Feb 2020 09:25:59 -0500
To:     Kees Cook <keescook@chromium.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        arjan@linux.intel.com, rick.p.edgecombe@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [RFC PATCH 11/11] x86/boot: Move "boot heap" out of .bss
Message-ID: <20200206142557.GA3033443@rani.riverdale.lan>
References: <20200205223950.1212394-1-kristen@linux.intel.com>
 <20200205223950.1212394-12-kristen@linux.intel.com>
 <20200206001103.GA220377@rani.riverdale.lan>
 <202002060251.681292DE63@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202002060251.681292DE63@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 03:13:12AM -0800, Kees Cook wrote:
> On Wed, Feb 05, 2020 at 07:11:05PM -0500, Arvind Sankar wrote:
> > From: Kees Cook <keescook@chromium.org>
> > > This seems to be a trivial change because head_{64,32}.S already only
> > > copies up to the start of the .bss section, so any growth in the .bss
> > > area was already not meaningful when placing the image in memory. The
> > > .bss size is, however, reflected in the boot params "init_size", so the
> > > memory range calculations included the "boot_heap" region. Instead of
> > > wasting the on-disk image size bytes, just account for this heap area
> > > when identifying the mem_avoid ranges, and leave it out of the .bss
> > > section entirely. For good measure, also zero initialize it, as this
> > > was already happening for when zeroing the entire .bss section.
> > 
> > I'm not sure I follow this: the reason the bzImage currently contains
> > .bss and a fix for it is in a patch I have out for review at
> > https://lore.kernel.org/lkml/20200109150218.16544-1-nivedita@alum.mit.edu
> 
> Ah! Thank you. Yes, that's _much_ cleaner. I could not figure out why
> the linker was actually keeping the .bss section allocated in the
> on-disk image. :) We've only had this bug for 10 years. ;)
> 
> > This alone shouldn't make much of a difference across compressors. The
> > entire .bss is just stored uncompressed as 0's in bzImage currently.
> > The only thing that gets compressed is the original kernel ELF file. Is
> > the difference above just from this patch, or is it including the
> > overhead of function-sections?
> 
> With bzip2, it's a 4MB heap in .bss. Other compressors are 64KB. With
> fg-kaslr, the heap is 64MB in .bss. It made the bzImage huge. ;) Another

Ah, I just saw that. Makes more sense now -- so my patch actually saves
~4MiB even now for bz2-compressed bzImages.

> thought I had to deal with the memory utilization in the fg-kaslr shuffle
> was to actually choose _two_ kernel locations in memory (via a refactoring
> of choose_random_location()). One to decompress into and the other to
> write out during the shuffle. Though the symbol table still needs to be
> reconstructed, etc, so probably just best to leave it all in the regular
> heap (or improve the ZO heap allocator which doesn't really implement
> free()).
> 
> > It is not necessary for it to contain .bss to get the correct init_size.
> > The latter is calculated (in x86/boot/header.S) based on the offset of
> > the _end symbol in the compressed vmlinux, so storing the .bss is just a
> > bug.
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/boot/header.S#n559
> 
> Yes, thank you for the reminder. I couldn't find the ZO_INIT_SIZE when I
> was staring at this, since I only looked around the compressed/ directory.
> :)
> 

There's another thing I noticed -- you would need to ensure that the
init_size in the header covers your boot heap even if you did split it
out. The reason is that the bootloader will only know to reserve enough
memory for init_size: it's possible it might put the initrd or something
else following the kernel, or theoretically there might be reserved
memory regions or the end of physical RAM immediately following, so you
can't assume that area will be available when you get to extract_kernel.
