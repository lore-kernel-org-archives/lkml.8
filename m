Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDA6C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 11:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E824921775
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 11:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ONYb77D/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbgBFLNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 06:13:16 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34189 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbgBFLNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 06:13:15 -0500
Received: by mail-oi1-f193.google.com with SMTP id l136so4202447oig.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 03:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h2zaw6iYfCWOwDZ0jhzlPX+I4JIVjefxCpHGGlUTe4o=;
        b=ONYb77D/SZI16E9+HCdImeDUPdAG6Mr6whETfwFD/8yOkEPWUogsT0L+v7jxLgNgYM
         bdJzQr5rIdFpNCUd66hCFhq7P5RMFf4Wxj1XqaCQg4tgUN54X1cZc43hHrBR/6L81wmV
         LuvZmhlbyYuaus5JRJIk6GuIfYStFXOulZnuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h2zaw6iYfCWOwDZ0jhzlPX+I4JIVjefxCpHGGlUTe4o=;
        b=DuAwjJGuz7QGU+2BWYQ8Rcj5RGrUGxU9lpCIC1TFT3OO8VXLfVgDrvLHtBMv0tOLdO
         lIv4w4e/i2B9O2/3NCaLi59iIqyyB0VMh6dBAvM5GpuAIY7TYtl8x2CgYcl7sEWRiVI1
         zYDfwLygheKYVpeCGv6VG7Zl4nT4pCiRBPIxXMY8dV6pDs05HbKi2/AqkmPtuFI9HUa8
         EgzmBO6lgsE1JXeo3Cs7EerpBa6Z8iggheU+RB7vU8/NrwSPj20U+BfhSjaPxVM534lT
         F3VHP/lEqnSuRgILFKqVuFOJigVMyy73S1AcpuU7r677yTHo903k6UN46fc9k2tD6vFK
         2FPA==
X-Gm-Message-State: APjAAAWTj4T5bLErOfzLQMeaqBFKPYPDJHEHIRr3r9AnFjWxGza+HQvE
        GsXoTsVN6vrDn0VxBzuYtaMd1Q==
X-Google-Smtp-Source: APXvYqyIa+w8uVZWsJjTzzUF/R5VXZjIBSHbL4sGbqYcstUELKfDTdrqa7br00Jr065reLHSrmm8RA==
X-Received: by 2002:aca:aa0a:: with SMTP id t10mr6231066oie.156.1580987594941;
        Thu, 06 Feb 2020 03:13:14 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h1sm983317otm.34.2020.02.06.03.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 03:13:13 -0800 (PST)
Date:   Thu, 6 Feb 2020 03:13:12 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        arjan@linux.intel.com, rick.p.edgecombe@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [RFC PATCH 11/11] x86/boot: Move "boot heap" out of .bss
Message-ID: <202002060251.681292DE63@keescook>
References: <20200205223950.1212394-1-kristen@linux.intel.com>
 <20200205223950.1212394-12-kristen@linux.intel.com>
 <20200206001103.GA220377@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206001103.GA220377@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 07:11:05PM -0500, Arvind Sankar wrote:
> From: Kees Cook <keescook@chromium.org>
> > This seems to be a trivial change because head_{64,32}.S already only
> > copies up to the start of the .bss section, so any growth in the .bss
> > area was already not meaningful when placing the image in memory. The
> > .bss size is, however, reflected in the boot params "init_size", so the
> > memory range calculations included the "boot_heap" region. Instead of
> > wasting the on-disk image size bytes, just account for this heap area
> > when identifying the mem_avoid ranges, and leave it out of the .bss
> > section entirely. For good measure, also zero initialize it, as this
> > was already happening for when zeroing the entire .bss section.
> 
> I'm not sure I follow this: the reason the bzImage currently contains
> .bss and a fix for it is in a patch I have out for review at
> https://lore.kernel.org/lkml/20200109150218.16544-1-nivedita@alum.mit.edu

Ah! Thank you. Yes, that's _much_ cleaner. I could not figure out why
the linker was actually keeping the .bss section allocated in the
on-disk image. :) We've only had this bug for 10 years. ;)

> This alone shouldn't make much of a difference across compressors. The
> entire .bss is just stored uncompressed as 0's in bzImage currently.
> The only thing that gets compressed is the original kernel ELF file. Is
> the difference above just from this patch, or is it including the
> overhead of function-sections?

With bzip2, it's a 4MB heap in .bss. Other compressors are 64KB. With
fg-kaslr, the heap is 64MB in .bss. It made the bzImage huge. ;) Another
thought I had to deal with the memory utilization in the fg-kaslr shuffle
was to actually choose _two_ kernel locations in memory (via a refactoring
of choose_random_location()). One to decompress into and the other to
write out during the shuffle. Though the symbol table still needs to be
reconstructed, etc, so probably just best to leave it all in the regular
heap (or improve the ZO heap allocator which doesn't really implement
free()).

> It is not necessary for it to contain .bss to get the correct init_size.
> The latter is calculated (in x86/boot/header.S) based on the offset of
> the _end symbol in the compressed vmlinux, so storing the .bss is just a
> bug.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/boot/header.S#n559

Yes, thank you for the reminder. I couldn't find the ZO_INIT_SIZE when I
was staring at this, since I only looked around the compressed/ directory.
:)

I should add this:

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index d7408af55738..346e36ae163e 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -346,7 +346,7 @@ static void handle_mem_options(void)
  * in header.S, and the memory diagram is based on the one found in
  * misc.c.
  *
  * The following conditions are already enforced by the image layouts
  * and
- * associated code:
+ * associated code (see ../boot/header.S):
  *  - input + input_size >= output + output_size
  *  - kernel_total_size <= init_size
  *  - kernel_total_size <= output_size (see Note below)


-- 
Kees Cook
