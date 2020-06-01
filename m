Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2A3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E07820738
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="G8VBKHYp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgFAPII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 11:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgFAPIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 11:08:06 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6513C05BD43
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 08:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qAq4uZ1ttFHDy5aUeojvBZHoZbUCeHSbfFMRl/qdBE4=; b=G8VBKHYp6BPpkFO36U+zS3RVK
        obm6EzNkbWV96jdLQYzj7dE5RbCCLSSt2eyHIkM9o7NFcLH4zRseHFG0Izd6MoPudDbU3niLN14gX
        18w+vkdkwwbiFbS11D5pnEtsHMfD7cS4brzCeLCCtQcDctZEg1N1TF3rlwgtDz4BX3odXY6TXaWrX
        TyHl94ebQ4baDbFRfPfIuuOl4IadWVVWY9SbZdIFivhX7rEfbDfdG9rq7aYVUSkmSnbrUjAHQkyM+
        DVZTH1+95ni1Xjror6gru5515fDs+1zLmbmLup/brhbhbvKvxYMGYF60bhL2OZQYtSujhofGRCnyH
        jznMtmynw==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:48056)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jfm2W-0000c6-Ea; Mon, 01 Jun 2020 16:07:48 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jfm2T-0003P7-K4; Mon, 01 Jun 2020 16:07:45 +0100
Date:   Mon, 1 Jun 2020 16:07:45 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Enrico Weigelt <info@metux.net>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Ben Dooks <ben-linux@fluff.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 5/5] arm: kexec_file: load zImage or uImage, initrd and
 dtb
Message-ID: <20200601150745.GL1551@shell.armlinux.org.uk>
References: <20200601142754.26139-1-l.stelmach@samsung.com>
 <CGME20200601142811eucas1p1604c8e6ca06c09f1ec821ea5e1918c53@eucas1p1.samsung.com>
 <20200601142754.26139-6-l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200601142754.26139-6-l.stelmach@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 04:27:54PM +0200, Łukasz Stelmach wrote:
> This is kexec_file_load implementation for ARM. It loads zImage and
> initrd from file descripters and resuses DTB.
> 
> Most code is derived from arm64 kexec_file_load implementation
> and from kexec-tools.

Please make the uImage loader able to be configured out of the
kernel; it's a legacy image format now, and some of us just don't
use it anymore.  That way, those who wish to have it can, and
those who wish not to can have a smaller kernel.

> Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
> ---
>  arch/arm/Kconfig                     |  15 ++
>  arch/arm/include/asm/image.h         |  26 ++++
>  arch/arm/include/asm/kexec.h         |  14 ++
>  arch/arm/kernel/Makefile             |   5 +-
>  arch/arm/kernel/kexec_uimage.c       |  80 ++++++++++
>  arch/arm/kernel/kexec_zimage.c       | 199 +++++++++++++++++++++++++
>  arch/arm/kernel/machine_kexec.c      |  11 +-
>  arch/arm/kernel/machine_kexec_file.c | 209 +++++++++++++++++++++++++++
>  8 files changed, 554 insertions(+), 5 deletions(-)
>  create mode 100644 arch/arm/kernel/kexec_uimage.c
>  create mode 100644 arch/arm/kernel/kexec_zimage.c
>  create mode 100644 arch/arm/kernel/machine_kexec_file.c
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index c77c93c485a0..6adb849cb304 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1917,6 +1917,21 @@ config KEXEC
>  	  is properly shutdown, so do not be surprised if this code does not
>  	  initially work for you.
>  
> +config KEXEC_FILE
> +	bool "Kexec file based system call (EXPERIMENTAL)"
> +	depends on (!SMP || PM_SLEEP_SMP)
> +	depends on USE_OF
> +	select KEXEC_CORE
> +	select CRC32
> +	help
> +	  This is new version of kexec system call. This system call is
> +	  file based and takes file descriptors as system call argument
> +	  for kernel and initramfs as opposed to list of segments as
> +	  accepted by previous system call.
> +
> +	  The kernel to be loaded MUST support Flattened Device Tree
> +	  (selected with CONFIG_USE_OF).
> +
>  config ATAGS_PROC
>  	bool "Export atags in procfs"
>  	depends on ATAGS && KEXEC
> diff --git a/arch/arm/include/asm/image.h b/arch/arm/include/asm/image.h
> index 624438740f23..95f23837b04f 100644
> --- a/arch/arm/include/asm/image.h
> +++ b/arch/arm/include/asm/image.h
> @@ -8,8 +8,13 @@
>  			 (((x) >>  8) & 0x0000ff00) |  \
>  			 (((x) <<  8) & 0x00ff0000) |  \
>  			 (((x) << 24) & 0xff000000))
> +#define UIMAGE_MAGIC(x) (x)
>  #else
>  #define ZIMAGE_MAGIC(x) (x)
> +#define UIMAGE_MAGIC(x) ((((x) >> 24) & 0x000000ff) | \
> +			 (((x) >>  8) & 0x0000ff00) |  \
> +			 (((x) <<  8) & 0x00ff0000) |  \
> +			 (((x) << 24) & 0xff000000))
>  #endif
>  
>  #define ARM_ZIMAGE_MAGIC1 ZIMAGE_MAGIC(0x016f2818)
> @@ -17,6 +22,12 @@
>  #define ARM_ZIMAGE_MAGIC3 ZIMAGE_MAGIC(0x5a534c4b)
>  #define ARM_ZIMAGE_MAGIC4 ZIMAGE_MAGIC(0x5a534344)
>  
> +#define ARM_UIMAGE_MAGIC UIMAGE_MAGIC(0x27051956)
> +#define ARM_UIMAGE_NAME_LEN		32
> +#define ARM_UIMAGE_TYPE_KERNEL		2
> +#define ARM_UIMAGE_TYPE_KERNEL_NOLOAD	14
> +#define ARM_UIMAGE_ARCH_ARM		2
> +
>  #ifndef __ASSEMBLY__
>  
>  #include <linux/types.h>
> @@ -33,6 +44,21 @@ struct arm_zimage_header {
>  	__le32 extension_tag_offset;
>  };
>  
> +struct arm_uimage_header {
> +	__be32 magic;
> +	__be32 hdr_crc;
> +	__be32 time;
> +	__be32 size;
> +	__be32 load;
> +	__be32 entry;
> +	__be32 crc;
> +	__u8   os;
> +	__u8   arch;
> +	__u8   type;
> +	__u8   comp;
> +	__u8   name[ARM_UIMAGE_NAME_LEN];
> +};
> +
>  struct arm_zimage_tag {
>  	struct tag_header hdr;
>  	union {
> diff --git a/arch/arm/include/asm/kexec.h b/arch/arm/include/asm/kexec.h
> index 22751b5b5735..fda35afa7195 100644
> --- a/arch/arm/include/asm/kexec.h
> +++ b/arch/arm/include/asm/kexec.h
> @@ -83,6 +83,20 @@ static inline struct page *boot_pfn_to_page(unsigned long boot_pfn)
>  }
>  #define boot_pfn_to_page boot_pfn_to_page
>  
> +#ifdef CONFIG_KEXEC_FILE
> +
> +extern const struct kexec_file_ops kexec_zimage_ops;
> +extern const struct kexec_file_ops kexec_uimage_ops;
> +
> +struct kimage;
> +
> +extern int load_other_segments(struct kimage *image,
> +		unsigned long kernel_load_addr, unsigned long kernel_size,
> +		char *initrd, unsigned long initrd_len,
> +		unsigned long initrd_offset, char *cmdline);
> +
> +#endif /* CONFIG_KEXEC_FILE */
> +
>  #endif /* __ASSEMBLY__ */
>  
>  #endif /* CONFIG_KEXEC */
> diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
> index 89e5d864e923..466c683bb551 100644
> --- a/arch/arm/kernel/Makefile
> +++ b/arch/arm/kernel/Makefile
> @@ -3,6 +3,7 @@
>  # Makefile for the linux kernel.
>  #
>  
> +CFLAGS_kexec_zimage.o := -DTEXT_OFFSET=$(TEXT_OFFSET)
>  CPPFLAGS_vmlinux.lds := -DTEXT_OFFSET=$(TEXT_OFFSET)
>  AFLAGS_head.o        := -DTEXT_OFFSET=$(TEXT_OFFSET)
>  
> @@ -56,7 +57,9 @@ obj-$(CONFIG_FUNCTION_TRACER)	+= entry-ftrace.o
>  obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o insn.o patch.o
>  obj-$(CONFIG_FUNCTION_GRAPH_TRACER)	+= ftrace.o insn.o patch.o
>  obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o insn.o patch.o
> -obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
> +obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec.o relocate_kernel.o
> +obj-$(CONFIG_KEXEC_FILE)	+= machine_kexec_file.o kexec_zimage.o	\
> +				   kexec_uimage.o
>  # Main staffs in KPROBES are in arch/arm/probes/ .
>  obj-$(CONFIG_KPROBES)		+= patch.o insn.o
>  obj-$(CONFIG_OABI_COMPAT)	+= sys_oabi-compat.o
> diff --git a/arch/arm/kernel/kexec_uimage.c b/arch/arm/kernel/kexec_uimage.c
> new file mode 100644
> index 000000000000..47033574e24e
> --- /dev/null
> +++ b/arch/arm/kernel/kexec_uimage.c
> @@ -0,0 +1,80 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Kexec uImage loader
> + *
> + * Copyright (C) 2020 Samsung Electronics
> + * Author: Łukasz Stelmach <l.stelmach@samsung.com>
> + */
> +
> +#define pr_fmt(fmt)	"kexec_file(uImage): " fmt
> +
> +#include <asm/image.h>
> +#include <linux/crc32.h>
> +#include <linux/err.h>
> +#include <linux/kexec.h>
> +
> +#define crc32_ones(crc, buf, len) \
> +	(crc32(crc ^ 0xffffffff, buf, len) ^ 0xffffffff)
> +
> +static int uimage_probe(const char *uimage_buf, unsigned long uimage_len)
> +{
> +	const struct arm_uimage_header *h =
> +		(struct arm_uimage_header *) uimage_buf;
> +	struct arm_uimage_header uhdr;
> +	unsigned long zoff = sizeof(struct arm_uimage_header);
> +	uint32_t crc;
> +
> +	if (h->magic != ARM_UIMAGE_MAGIC)
> +		return -EINVAL;
> +
> +	if (h->type != ARM_UIMAGE_TYPE_KERNEL &&
> +	    h->type != ARM_UIMAGE_TYPE_KERNEL_NOLOAD){
> +		pr_debug("Invalid image type: %d\n", h->type);
> +		return -EINVAL;
> +	}
> +
> +	if (h->arch != ARM_UIMAGE_ARCH_ARM) {
> +		pr_debug("Invalidy image arch: %d\n", h->arch);
> +		return -EINVAL;
> +	}
> +
> +	memcpy((char *)&uhdr, h, sizeof(uhdr));
> +	crc = be32_to_cpu(uhdr.hdr_crc);
> +	uhdr.hdr_crc = 0;
> +
> +	if (crc32_ones(0, (char *)&uhdr, sizeof(uhdr)) != crc) {
> +		pr_debug("Corrupt header, CRC do not match\n");
> +		return -EINVAL;
> +	}
> +
> +	crc = be32_to_cpu(uhdr.crc);
> +	if (crc32_ones(0, uimage_buf + zoff, uimage_len - zoff) != crc) {
> +		pr_debug("Corrupt zImage, CRC do not match\n");
> +		return -EINVAL;
> +	}
> +
> +	return kexec_zimage_ops.probe(uimage_buf + zoff,
> +				      uimage_len - zoff);
> +}
> +
> +static void *uimage_load(struct kimage *image,
> +				char *uimage, unsigned long uimage_len,
> +				char *initrd, unsigned long initrd_len,
> +				char *cmdline, unsigned long cmdline_len)
> +{
> +	const struct arm_uimage_header *h =
> +		(struct arm_uimage_header *) uimage;
> +	unsigned long zimage_offset = sizeof(struct arm_uimage_header);
> +
> +	pr_debug("Loading uImage");
> +	return kexec_zimage_ops.load(image,
> +				     uimage + zimage_offset,
> +				     uimage_len - zimage_offset,
> +				     initrd, initrd_len,
> +				     cmdline, cmdline_len);
> +}
> +
> +const struct kexec_file_ops kexec_uimage_ops = {
> +	.probe = uimage_probe,
> +	.load = uimage_load,
> +};
> diff --git a/arch/arm/kernel/kexec_zimage.c b/arch/arm/kernel/kexec_zimage.c
> new file mode 100644
> index 000000000000..d09795fc9072
> --- /dev/null
> +++ b/arch/arm/kernel/kexec_zimage.c
> @@ -0,0 +1,199 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Kexec zImage loader
> + *
> + * Copyright (C) 2020 Samsung Electronics
> + * Author: Łukasz Stelmach <l.stelmach@samsung.com>

Please credit me as part author of this - you have taken some of my
code from the userspace kexec tool (such as the contents of
find_extension_tag()) and copied it in here, so this is not all your
own work.

> + */
> +
> +#define pr_fmt(fmt)	"kexec_file(zImage): " fmt
> +
> +#include <asm/image.h>
> +#include <asm/unaligned.h>
> +#include <linux/err.h>
> +#include <linux/kexec.h>
> +#include <linux/memblock.h>
> +
> +#define byte_size(t)    ((t)->hdr.size << 2)
> +
> +static const void *find_extension_tag(const char *buf,
> +						       unsigned long len,
> +						       uint32_t tag_id)
> +{
> +	const struct arm_zimage_header *h = (const struct arm_zimage_header *)buf;
> +	const struct arm_zimage_tag *tag;
> +	uint32_t offset, size;
> +	uint32_t max = len - sizeof(struct tag_header);
> +
> +	if (len < sizeof(*h) ||
> +	    h->magic != ARM_ZIMAGE_MAGIC1 ||
> +	    h->magic2 != ARM_ZIMAGE_MAGIC2)
> +		return NULL;
> +
> +	for (offset = h->extension_tag_offset;
> +	     (tag = (void *)(buf + offset)) != NULL &&
> +		     offset < max &&
> +		     (size = le32_to_cpu(byte_size(tag))) != 0 &&
> +		     offset + size < len;
> +	     offset += size) {
> +		pr_debug("  offset 0x%08x tag 0x%08x size %u\n",
> +			  offset, le32_to_cpu(tag->hdr.tag), size);
> +		if (tag->hdr.tag == tag_id)
> +			return tag;
> +	}
> +
> +	return NULL;
> +}
> +
> +static int zimage_probe(const char *kernel_buf, unsigned long kernel_len)
> +{
> +	const struct arm_zimage_header *h =
> +		(struct arm_zimage_header *)(kernel_buf);
> +
> +	if (!h || (kernel_len < sizeof(*h)))
> +		return -EINVAL;
> +
> +	if ((h->magic != ARM_ZIMAGE_MAGIC1) ||
> +	    (h->magic2 != ARM_ZIMAGE_MAGIC2))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +
> +#if defined(DEBUG)
> +#define debug_offsets() ({			\
> +	pr_debug("Image offsets:\n");		\
> +	pr_debug("  kernel 0x%08lx 0x%08lx\n", kernel_offset, kernel_len); \
> +	pr_debug("  zimage 0x%08lx 0x%08lx\n", zimage_offset, zimage_len); \
> +	pr_debug("  initrd 0x%08lx 0x%08lx\n", initrd_offset, initrd_len); \
> +})
> +#else
> +#define debug_offsets()
> +#endif
> +
> +static void *zimage_load(struct kimage *image,
> +				char *zimage, unsigned long zimage_len,
> +				char *initrd, unsigned long initrd_len,
> +				char *cmdline, unsigned long cmdline_len)
> +{
> +	struct arm_zimage_header *h;
> +	struct kexec_buf kbuf;
> +	struct kexec_segment *zimage_segment;
> +	const struct arm_zimage_tag *klsz_tag;
> +	const struct arm_zimage_tag_dc *dcsz_tag;
> +	int ret = -EINVAL;
> +
> +	unsigned long zimage_mem = 0x20000; /* malloc 64kB + stack 4 kB + some bss */
> +	unsigned long kernel_len = zimage_len * 4; /* 4:1 compression */

This has been proven wrong.

> +	unsigned long kernel_offset = memblock_start_of_DRAM() +
> +		ALIGN(TEXT_OFFSET, PAGE_SIZE);

TEXT_OFFSET is actually a property of the loaded kernel, not of the
currently running kernel.  I have a patch to add that into the zImage
tag.

> +	unsigned long zimage_offset = kernel_offset +
> +		ALIGN(kernel_len, PAGE_SIZE);
> +	unsigned long initrd_offset = zimage_offset +
> +		ALIGN(zimage_len + zimage_mem, PAGE_SIZE);

Since kernel_len is wrong, these will be wrong... please only fall
back to this if you don't find the extension tag - in other words,
declare the variables here, but don't initialise them, set them
lower down in the file if we fail to find the extension tag.

> +
> +	if (image->type == KEXEC_TYPE_CRASH) {
> +		kernel_offset += crashk_res.start;
> +		zimage_offset += crashk_res.start;
> +		initrd_offset += crashk_res.start;
> +	}
> +	debug_offsets();
> +
> +	h = (struct arm_zimage_header *)zimage;
> +
> +	klsz_tag = find_extension_tag(zimage, zimage_len, ZIMAGE_TAG_KRNL_SIZE);
> +	if (klsz_tag) {
> +		uint32_t *p = (void *)zimage +
> +			le32_to_cpu(klsz_tag->u.krnl_size.size_ptr);
> +		uint32_t edata_size = le32_to_cpu(get_unaligned(p));
> +		uint32_t bss_size = le32_to_cpu(klsz_tag->u.krnl_size.bss_size);
> +
> +		kernel_len = edata_size + bss_size;
> +
> +		pr_debug("Decompressed kernel sizes:\n");
> +		pr_debug(" text+data 0x%08lx bss 0x%08lx total 0x%08lx\n",
> +			 (unsigned long)edata_size,
> +			 (unsigned long)bss_size,
> +			 (unsigned long)kernel_len);
> +
> +		zimage_offset = kernel_offset + ALIGN(edata_size, PAGE_SIZE);
> +		initrd_offset = zimage_offset +
> +			max(ALIGN(zimage_len + 0x20000, PAGE_SIZE),
> +			    ALIGN((unsigned long)bss_size, PAGE_SIZE));
> +		debug_offsets();

This looks incorrect to me.  Please see the kexec tool - what its doing
in its corresponding section that you copied some of this code from is
carefully thought out and can't be simplified.  Ergo, I think this is
wrong.

> +	}
> +
> +	dcsz_tag = find_extension_tag(zimage, zimage_len,
> +				      ZIMAGE_TAG_DECOMP_SIZE);
> +	if (dcsz_tag) {
> +		uint32_t bss_size = le32_to_cpu(dcsz_tag->u.decomp_size.bss_size);
> +		uint32_t stack_size = le32_to_cpu(dcsz_tag->u.decomp_size.stack_size);
> +		uint32_t malloc_size = le32_to_cpu(dcsz_tag->u.decomp_size.malloc_size);
> +
> +		zimage_mem = bss_size + stack_size + malloc_size;
> +
> +		pr_debug("Decompressor memory requirements:\n");
> +		pr_debug(" bss 0x%08lx stack 0x%08lx malloc 0x%08lx total 0x%08lx\n",
> +			 (unsigned long)bss_size,
> +			 (unsigned long)stack_size,
> +			 (unsigned long)malloc_size,
> +			 zimage_mem);
> +
> +		initrd_offset = max(ALIGN(zimage_offset + zimage_len +
> +					  bss_size + stack_size +
> +					  malloc_size, PAGE_SIZE),
> +				    ALIGN(kernel_offset + kernel_len, PAGE_SIZE));
> +		debug_offsets();
> +	}
> +
> +	/*
> +	 * zImage MUST be loaded into the first 128 MiB of physical
> +	 * memory for proper memory detection. Should the uncompressed
> +	 * kernel be larger than 128 MiB, zImage relocation becomes
> +	 * unavoidable and it is best to rely on the relocation code.
> +	 */
> +	if (((zimage_offset - kernel_offset) + PAGE_SIZE + 0x8000) >= SZ_128M) {
> +		pr_debug("The kernel is too big (%ld MiB) to avoid "
> +			 "zImage relocation. Loading zimage at 0x%08lx\n",
> +			 ((zimage_offset - kernel_offset) >> 20),
> +			 kernel_offset);
> +		zimage_offset = kernel_offset;
> +	}
> +
> +	kbuf.image = image;
> +	kbuf.top_down = false;
> +
> +	kbuf.buf_min = zimage_offset;
> +	kbuf.buf_max = ULONG_MAX;
> +	kbuf.buffer = zimage;
> +	kbuf.bufsz = zimage_len;
> +	kbuf.buf_align = PAGE_SIZE;
> +
> +	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
> +	kbuf.memsz = zimage_len;
> +
> +	ret = kexec_add_buffer(&kbuf);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	pr_debug("Loaded zImage at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
> +		 kbuf.mem, kbuf.bufsz, kbuf.memsz);
> +
> +	initrd_offset += kbuf.mem - zimage_offset;
> +	debug_offsets();
> +
> +	zimage_segment = &image->segment[image->nr_segments - 1];
> +	image->start = zimage_segment->mem;
> +
> +	ret = load_other_segments(image,
> +				  zimage_segment->mem, zimage_segment->memsz,
> +				  initrd, initrd_len, initrd_offset,
> +				  cmdline);
> +	return ERR_PTR(ret);
> +}
> +
> +const struct kexec_file_ops kexec_zimage_ops = {
> +	.probe = zimage_probe,
> +	.load = zimage_load,
> +};
> diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
> index c10a2dfd53d1..2e4780efabb4 100644
> --- a/arch/arm/kernel/machine_kexec.c
> +++ b/arch/arm/kernel/machine_kexec.c
> @@ -93,10 +93,13 @@ int machine_kexec_prepare(struct kimage *image)
>  					       current_segment->memsz))
>  			return -EINVAL;
>  
> -		err = get_user(header, (__be32*)current_segment->buf);
> -		if (err)
> -			return err;
> -
> +		if (image->file_mode) {
> +			header = *(__be32 *)current_segment->buf;
> +		} else {
> +			err = get_user(header, (__be32 *)current_segment->buf);
> +			if (err)
> +				return err;
> +		}
>  		if (header == cpu_to_be32(OF_DT_HEADER))
>  			image->arch.kernel_r2 = current_segment->mem;
>  	}
> diff --git a/arch/arm/kernel/machine_kexec_file.c b/arch/arm/kernel/machine_kexec_file.c
> new file mode 100644
> index 000000000000..ead680f1e795
> --- /dev/null
> +++ b/arch/arm/kernel/machine_kexec_file.c
> @@ -0,0 +1,209 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * kexec_file for arm
> + *
> + * Copyright (C) 2018 Linaro Limited
> + * Copyright (C) 2020 Samsung Electronics
> + * Authors:
> + *     AKASHI Takahiro <takahiro.akashi@linaro.org>
> + *     Łukasz Stelmach <l.stelmach@samsung.com>
> + *
> + */
> +
> +#define pr_fmt(fmt) "kexec_file: " fmt
> +
> +#include <linux/kexec.h>
> +#include <linux/libfdt.h>
> +#include <linux/of_fdt.h>
> +#include <linux/random.h>
> +
> +/* relevant device tree properties */
> +#define FDT_PROP_INITRD_START	"linux,initrd-start"
> +#define FDT_PROP_INITRD_END	"linux,initrd-end"
> +#define FDT_PROP_BOOTARGS	"bootargs"
> +#define FDT_PROP_RNG_SEED	"rng-seed"
> +
> +static int setup_dtb(struct kimage *image,
> +		     unsigned long initrd_load_addr, unsigned long initrd_len,
> +		     char *cmdline, void *dtb)
> +{
> +	int off, ret;
> +
> +	ret = fdt_path_offset(dtb, "/chosen");
> +	if (ret < 0)
> +		goto out;
> +
> +	off = ret;
> +
> +	/* add bootargs */
> +	if (cmdline) {
> +		ret = fdt_setprop_string(dtb, off, FDT_PROP_BOOTARGS, cmdline);
> +		if (ret)
> +			goto out;
> +	} else {
> +		ret = fdt_delprop(dtb, off, FDT_PROP_BOOTARGS);
> +		if (ret && (ret != -FDT_ERR_NOTFOUND))
> +			goto out;
> +	}
> +
> +	/* add initrd-* */
> +	if (initrd_load_addr) {
> +		ret = fdt_setprop_u64(dtb, off, FDT_PROP_INITRD_START,
> +				      initrd_load_addr);
> +		if (ret)
> +			goto out;
> +
> +		ret = fdt_setprop_u64(dtb, off, FDT_PROP_INITRD_END,
> +				      initrd_load_addr + initrd_len);
> +		if (ret)
> +			goto out;
> +	} else {
> +		ret = fdt_delprop(dtb, off, FDT_PROP_INITRD_START);
> +		if (ret && (ret != -FDT_ERR_NOTFOUND))
> +			goto out;
> +
> +		ret = fdt_delprop(dtb, off, FDT_PROP_INITRD_END);
> +		if (ret && (ret != -FDT_ERR_NOTFOUND))
> +			goto out;
> +	}
> +
> +	/* add rng-seed */
> +	if (rng_is_initialized()) {
> +		char seed[128];
> +		get_random_bytes(seed, sizeof(seed));
> +
> +		ret = fdt_setprop(dtb, off, FDT_PROP_RNG_SEED,
> +				  seed, sizeof(seed));
> +		if (ret)
> +			goto out;
> +	} else {
> +		pr_notice("RNG is not initialised: omitting \"%s\" property\n",
> +				FDT_PROP_RNG_SEED);
> +		ret = 0;
> +	}
> +
> +out:
> +	if (ret)
> +		return (ret == -FDT_ERR_NOSPACE) ? -ENOMEM : -EINVAL;
> +
> +	return 0;
> +}
> +/*
> + * More space needed so that we can add initrd, bootargs and kaslr-seed.
> + */
> +#define DTB_EXTRA_SPACE 0x1000
> +
> +static int create_dtb(struct kimage *image,
> +		      unsigned long initrd_load_addr, unsigned long initrd_len,
> +		      char *cmdline, void **dtb)
> +{
> +	void *buf;
> +	size_t buf_size;
> +	size_t cmdline_len;
> +	int ret;
> +
> +	cmdline_len = cmdline ? strlen(cmdline) : 0;
> +	buf_size = fdt_totalsize(initial_boot_params)
> +			+ cmdline_len + DTB_EXTRA_SPACE;
> +
> +	for (;;) {
> +		buf = vmalloc(buf_size);
> +		if (!buf)
> +			return -ENOMEM;
> +
> +		/* duplicate a device tree blob */
> +		ret = fdt_open_into(initial_boot_params, buf, buf_size);
> +		if (ret)
> +			return -EINVAL;
> +
> +		ret = setup_dtb(image, initrd_load_addr, initrd_len,
> +				cmdline, buf);
> +		if (ret) {
> +			vfree(buf);
> +			if (ret == -ENOMEM) {
> +				/* unlikely, but just in case */
> +				buf_size += DTB_EXTRA_SPACE;
> +				continue;
> +			} else {
> +				return ret;
> +			}
> +		}
> +
> +		/* trim it */
> +		fdt_pack(buf);
> +		*dtb = buf;
> +
> +		return 0;
> +	}
> +}
> +
> +int load_other_segments(struct kimage *image,
> +			unsigned long zimage_load_addr,
> +			unsigned long zimage_len,
> +			char *initrd,
> +			unsigned long initrd_len,
> +			unsigned long initrd_offset,
> +			char *cmdline)
> +{
> +	struct kexec_buf kbuf;
> +	void *dtb = NULL;
> +	unsigned long initrd_load_addr = 0;
> +	unsigned long dtb_len;
> +	int ret = 0;
> +
> +	kbuf.image = image;
> +	/* not allocate anything below the kernel */
> +	kbuf.buf_min = initrd_offset;
> +	if (initrd) {
> +		kbuf.buffer = initrd;
> +		kbuf.bufsz = initrd_len;
> +		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
> +		kbuf.memsz = initrd_len;
> +		kbuf.buf_align = PAGE_SIZE;
> +		kbuf.buf_max = ULONG_MAX;
> +		kbuf.top_down = false;
> +
> +		ret = kexec_add_buffer(&kbuf);
> +		if (ret)
> +			goto out_err;
> +
> +		pr_debug("Loaded initrd at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
> +				kbuf.mem, kbuf.bufsz, kbuf.memsz);
> +
> +		initrd_load_addr = kbuf.mem;
> +		kbuf.buf_min = initrd_load_addr + kbuf.memsz;
> +	}
> +
> +	/* load dtb */
> +	ret = create_dtb(image, initrd_load_addr, initrd_len, cmdline, &dtb);
> +	if (ret) {
> +		pr_err("Preparing for new dtb failed\n");
> +		goto out_err;
> +	}
> +
> +	dtb_len = fdt_totalsize(dtb);
> +	kbuf.buffer = dtb;
> +	kbuf.bufsz = dtb_len;
> +	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
> +	kbuf.memsz = dtb_len;
> +	kbuf.buf_align = PAGE_SIZE;
> +	kbuf.buf_max = ULONG_MAX;
> +	kbuf.top_down = false;
> +
> +	ret = kexec_add_buffer(&kbuf);
> +	if (ret)
> +		goto out_err;
> +
> +	pr_debug("Loaded dtb at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
> +		 kbuf.mem, kbuf.bufsz, kbuf.memsz);
> +	return 0;
> +out_err:
> +	vfree(dtb);
> +	return ret;
> +}
> +
> +const struct kexec_file_ops * const kexec_file_loaders[] = {
> +	&kexec_uimage_ops,
> +	&kexec_zimage_ops,
> +	NULL
> +};
> -- 
> 2.26.2
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC for 0.8m (est. 1762m) line in suburbia: sync at 13.1Mbps down 424kbps up
