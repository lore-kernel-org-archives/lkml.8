Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4801C35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 00:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B6A214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 00:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgBFAde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 19:33:34 -0500
Received: from mga09.intel.com ([134.134.136.24]:15431 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbgBFAde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 19:33:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 16:33:34 -0800
X-IronPort-AV: E=Sophos;i="5.70,407,1574150400"; 
   d="scan'208";a="220277840"
Received: from kcaccard-mobl.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.24.10.66])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 16:33:33 -0800
Message-ID: <070d1c64168a5d8a11f7e5aec33a860721fe3d0e.camel@linux.intel.com>
Subject: Re: [RFC PATCH 11/11] x86/boot: Move "boot heap" out of .bss
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        arjan@linux.intel.com, keescook@chromium.org,
        rick.p.edgecombe@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Date:   Wed, 05 Feb 2020 16:33:33 -0800
In-Reply-To: <20200206001103.GA220377@rani.riverdale.lan>
References: <20200205223950.1212394-1-kristen@linux.intel.com>
         <20200205223950.1212394-12-kristen@linux.intel.com>
         <20200206001103.GA220377@rani.riverdale.lan>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-02-05 at 19:11 -0500, Arvind Sankar wrote:
> On Wed, Feb 05, 2020 at 02:39:50PM -0800, Kristen Carlson Accardi
> wrote:
> > From: Kees Cook <keescook@chromium.org>
> > 
> > Currently the on-disk decompression image includes the "dynamic"
> > heap
> > region that is used for malloc() during kernel extraction,
> > relocation,
> > and decompression ("boot_heap" of BOOT_HEAP_SIZE bytes in the .bss
> > section). It makes no sense to balloon the bzImage with "boot_heap"
> > as it is zeroed at boot, and acts much more like a "brk" region.
> > 
> > This seems to be a trivial change because head_{64,32}.S already
> > only
> > copies up to the start of the .bss section, so any growth in the
> > .bss
> > area was already not meaningful when placing the image in memory.
> > The
> > .bss size is, however, reflected in the boot params "init_size", so
> > the
> > memory range calculations included the "boot_heap" region. Instead
> > of
> > wasting the on-disk image size bytes, just account for this heap
> > area
> > when identifying the mem_avoid ranges, and leave it out of the .bss
> > section entirely. For good measure, also zero initialize it, as
> > this
> > was already happening for when zeroing the entire .bss section.
> > 
> > While the bzImage size is dominated by the compressed vmlinux, the
> > difference removes 64KB for all compressors except bzip2, which
> > removes
> > 4MB. For example, this is less than 1% under CONFIG_KERNEL_XZ:
> > 
> > -rw-r--r-- 1 kees kees 7813168 Feb  2 23:39
> > arch/x86/boot/bzImage.stock-xz
> > -rw-r--r-- 1 kees kees 7747632 Feb  2 23:42
> > arch/x86/boot/bzImage.brk-xz
> > 
> > but much more pronounced under CONFIG_KERNEL_BZIP2 (~27%):
> > 
> > -rw-r--r-- 1 kees kees 15231024 Feb  2 23:44
> > arch/x86/boot/bzImage.stock-bzip2
> > -rw-r--r-- 1 kees kees 11036720 Feb  2 23:47
> > arch/x86/boot/bzImage.brk-bzip2
> > 
> > For the future fine-grain KASLR work, this will avoid significant
> > pain,
> > as the ELF section parser will use much more memory during boot and
> > filling the bzImage with megabytes of zeros seemed like a poor
> > idea. :)
> > 
> 
> I'm not sure I follow this: the reason the bzImage currently contains
> .bss and a fix for it is in a patch I have out for review at
> https://lore.kernel.org/lkml/20200109150218.16544-1-nivedita@alum.mit.edu
> 
> This alone shouldn't make much of a difference across compressors.
> The
> entire .bss is just stored uncompressed as 0's in bzImage currently.
> The only thing that gets compressed is the original kernel ELF file.
> Is
> the difference above just from this patch, or is it including the
> overhead of function-sections?
> 
> It is not necessary for it to contain .bss to get the correct
> init_size.
> The latter is calculated (in x86/boot/header.S) based on the offset
> of
> the _end symbol in the compressed vmlinux, so storing the .bss is
> just a
> bug.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/boot/header.S#n559
> 
> From the cover letter:
> > Image Size
> > ----------
> > Adding additional section headers as a result of compiling with
> > -ffunction-sections will increase the size of the vmlinux ELF file.
> > In
> > addition, the vmlinux.bin file generated in
> > arch/x86/boot/compressed by
> > objcopy grows significantly with the current POC implementation.
> > This is
> > because the boot heap size must be dramatically increased to
> > support shuffling
> > the sections and re-sorting kallsyms. With a sample kernel
> > compilation using a
> > stock Fedora config, bzImage grew about 7.5X when CONFIG_FG_KASLR
> > was enabled.
> > This is because the boot heap area is included in the image itself.
> > 
> > It is possible to mitigate this issue by moving the boot heap out
> > of .bss.
> > Kees Cook has a prototype of this working, and it is included in
> > this
> > patchset.
> 
> I am also confused by this -- the boot heap is not part of the
> vmlinux.bin in arch/x86/boot/compressed: that's a stripped copy of
> the
> decompressed kernel, just before we apply the selected compression to
> it
> and vmlinux.relocs.
> 
> Do you mean arch/x86/boot/vmlinux.bin? That is an objcopy of
> compressed/vmlinux, and it grows in size with increasing .bss for the
> same reason as above (rather it's the cause of bzImage growing).

Right, sorry for the confusion - I see now that I could have worded
that better. the cover letter should say "In addition, the vmlinux.bin
file generated by the objcopy in arch/x86/boot/compressed/Makefile
grows significantly with the current POC implementation."


