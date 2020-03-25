Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3C2C2D0E5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 20:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C34020773
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 20:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MEGiICJV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgCYUKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 16:10:38 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:54820 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbgCYUKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 16:10:37 -0400
Received: by mail-pj1-f67.google.com with SMTP id np9so1501269pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 13:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jNzyH7EnpWUf8Zb+Itt1+uHYTbc8/5pBIyHGqaUSrO4=;
        b=MEGiICJVD1Daf2cbxxrPQ0bmN7kE511daNuEf5YVKbSSU2fc8eGqlezUG6hF5WAWWN
         4Z29itskZCX43JaPGxgVCCfwcgR7A1FJ2drYNDTMQGykPlEuY6XGU7FqQpPoSz6Qmdpf
         EjY6ys62ECz5N1bvBAw9OHQ1TY8+Bh7xiiKgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jNzyH7EnpWUf8Zb+Itt1+uHYTbc8/5pBIyHGqaUSrO4=;
        b=WjKAFq8mbbrcsdaOX57cRimvUEztOU5kq0FTTHLbxvbDGIVmuH5NeKg77sy7StgeI/
         ILTK8HuGFUgOAi5IM3gLBXZr8D1XE8M1wyvdNU4JzognVQV3DPaMHRqr16UkdztZmfoJ
         RNKu6MIF6zW5QK7As3pMbq1BRxPl0L6BSk2KqZ1QFxl+gkP1jE9PlXwHjTnCoOnpaLYV
         8sMhqS8sKyR87AdKUWVIHs4x5UbyKT8jb51Pbr8ediOsXaU4PbOJJLHNEQizvVy/A8mj
         kb2Eb4LMCW2r37pp0aQ+xVIp9lJ8Zt5HNRbttjza3MpgcZjgKzmbkBHhkxDB+8B39V3T
         hz2g==
X-Gm-Message-State: ANhLgQ3+rA9gd111km+ThXI3axTjlx2toR9UahbHB1y5a0rjcjkRmbNH
        UYV3RdN/pDbXVw40+XuMh7qIMQ==
X-Google-Smtp-Source: ADFU+vsYp5M/XTtN+TcZk2Nh+XRbqEFhcmQJdL17aNi4dFQGvV40j4QHfLEelW8iB1jV1eqXRaU4+Q==
X-Received: by 2002:a17:90a:7105:: with SMTP id h5mr5632351pjk.54.1585167034299;
        Wed, 25 Mar 2020 13:10:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q9sm17708439pgs.89.2020.03.25.13.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 13:10:33 -0700 (PDT)
Date:   Wed, 25 Mar 2020 13:10:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Terrell <nickrterrell@gmail.com>
Cc:     Nick Terrell <terrelln@fb.com>, linux-kernel@vger.kernel.org,
        Chris Mason <clm@fb.com>, linux-kbuild@vger.kernel.org,
        x86@kernel.org, gregkh@linuxfoundation.org,
        Petr Malat <oss@malat.biz>, Kernel Team <Kernel-team@fb.com>,
        Adam Borowski <kilobyte@angband.pl>,
        Patrick Williams <patrickw3@fb.com>, rmikey@fb.com,
        mingo@kernel.org, Patrick Williams <patrick@stwcx.xyz>
Subject: Re: [PATCH v3 0/8] Add support for ZSTD-compressed kernel and
 initramfs
Message-ID: <202003251309.349484C8E@keescook>
References: <20200325195849.407900-1-nickrterrell@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325195849.407900-1-nickrterrell@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 12:58:41PM -0700, Nick Terrell wrote:
> From: Nick Terrell <terrelln@fb.com>
> 
> Hi all,
> 
> I attempted to send this patch on March 19, but it got rejected by the
> mailing lists for some reason, so I'm resending it.
> 
> This patch set adds support for a ZSTD-compressed kernel, ramdisk, and
> initramfs in the kernel boot process. ZSTD-compressed ramdisk and initramfs
> are supported on all architectures. The ZSTD-compressed kernel is only
> hooked up to x86 in this patch set.
> 
> Zstandard requires slightly more memory during the kernel decompression
> on x86 (192 KB vs 64 KB), and the memory usage is independent of the
> window size.
> 
> Zstandard requires memory proprortional to the window size used during
> compression for decompressing the ramdisk image, since streaming mode is
> used. Newer versions of zstd (1.3.2+) list the window size of a file
> with `zstd -lv <file>'. The absolute maximum amount of memory required
> is just over 8 MB, but it can be controlled at compression time.
> 
> This patch set has been boot tested with buildroot and QEMU based off
> of linux-5.6-rc6.
> 
> On i386 and x86_64 I have tested the following configurations:
> * zstd compressed kernel and a separate zstd compressed initramfs
> * zstd compressed kernel and a built-in zstd compressed initramfs
> * gzip compressed kernel and a separate gzip compressed initramfs
> * gzip compressed kernel and a built-in gzip compressed initramfs
> 
> On arm and aarch64 I tested the same configurations, except that the kernel is
> always gzip compressed.
> 
> Facebook has been using v1 of these patches on x86_64 devices for more than 6
> months. When we switched from a xz compressed initramfs to a zstd compressed
> initramfs decompression time shrunk from 12 seconds to 3 seconds. When we
> switched from a xz compressed kernel to a zstd compressed kernel we saved 2
> seconds of boot time.
> 
> Facebook has been using v2 of these patches on aarch64 devices for a few weeks.
> When we switched from an lzma compressed initramfs to a zstd compressed initramfs
> decompression time shrunk from 27 seconds to 8 seconds.
> 
> The zstd compressed kernel is smaller than the gzip compressed kernel but larger
> than the xz or lzma compressed kernels, and it decompresses faster than
> everything except lz4. See the table below for the measurement of an x86_64
> kernel ordered by compressed size:
> 
> algo	size
> xz  	 6,509,792
> lzma	 6,856,576
> zstd	 7,399,157
> gzip	 8,522,527
> bzip	 8,629,603
> lzo 	 9,808,035
> lz4 	10,705,570
> none	32,565,672
> 
> v1 -> v2:
> - Rebase
>   - usr/Makefile and init/Kconfig were changed so the patches were updated
> - No functional changes except to rebase
> - Split the patches up into smaller chunks
> 
> v2 -> v3:
> - Add *.zst to the .gitignore in patch 8
> - Style nits in patch 3
> - Rename the PREBOOT macro to ZSTD_PREBOOT and XXH_PREBOOT in patches
>   1 through 3
> 
> Best,
> Nick Terrell
> 

Hi! Just resending Reviewed-by, since it looks like the earlier v3
didn't make it to the mailing list, as Nick just pointed out to me:

https://lore.kernel.org/lkml/202003201109.00FDE311A7@keescook/

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Adam Borowski (1):
>   .gitignore: add ZSTD-compressed files
> 
> Nick Terrell (7):
>   lib: prepare zstd for preboot environment
>   lib: prepare xxhash for preboot environment
>   lib: add zstd support to decompress
>   init: add support for zstd compressed kernel
>   usr: add support for zstd compressed initramfs
>   x86: bump ZO_z_extra_bytes margin for zstd
>   x86: Add support for ZSTD compressed kernel
> 
>  .gitignore                        |   1 +
>  Documentation/x86/boot.rst        |   6 +-
>  arch/x86/Kconfig                  |   1 +
>  arch/x86/boot/compressed/Makefile |   5 +-
>  arch/x86/boot/compressed/misc.c   |   4 +
>  arch/x86/boot/header.S            |   8 +-
>  arch/x86/include/asm/boot.h       |   6 +-
>  include/linux/decompress/unzstd.h |  11 +
>  init/Kconfig                      |  15 +-
>  lib/Kconfig                       |   4 +
>  lib/Makefile                      |   1 +
>  lib/decompress.c                  |   5 +
>  lib/decompress_unzstd.c           | 338 ++++++++++++++++++++++++++++++
>  lib/xxhash.c                      |  21 +-
>  lib/zstd/decompress.c             |   2 +
>  lib/zstd/fse_decompress.c         |   9 +-
>  lib/zstd/zstd_internal.h          |  14 +-
>  scripts/Makefile.lib              |  15 ++
>  usr/Kconfig                       |  20 ++
>  usr/Makefile                      |   1 +
>  20 files changed, 460 insertions(+), 27 deletions(-)
>  create mode 100644 include/linux/decompress/unzstd.h
>  create mode 100644 lib/decompress_unzstd.c
> 
> -- 
> 2.25.1
> 

-- 
Kees Cook
