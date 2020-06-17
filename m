Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF72C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 19:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A9DD208D5
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 19:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592423134;
	bh=qzsvYZpLBWgdL32sHZOFJvtYArIngqyXEv1j1eEpj50=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=oasfbWA6sm7FN3N8bKUpqjVq3XmzRKNyNrncOd3wKNGUOXg4YiQzcaKjrjbus0Kw8
	 Y45HUCWBxdacfeqnc2wgubq2J75cGPz2331njVNP/u0X4Cc+3Nvx2KcBPfCfRHFJfw
	 TzHY2fYHmzb9I9/f3umLrUdy30GfZy+nFmWpg4EY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgFQTpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 15:45:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgFQTpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 15:45:32 -0400
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9646207DD;
        Wed, 17 Jun 2020 19:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592423131;
        bh=qzsvYZpLBWgdL32sHZOFJvtYArIngqyXEv1j1eEpj50=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vWuJpvkS3nMzD4rpcnRTURrI7swxeURZIvHnsdHUzWgKuUA57aphpLQdZK4TI6/0S
         epXUwSbwRtN8nh6fhue9ZMfIcmG/btGq23VZPQnPF62psObqO1YNb2pCBBFAvXYoTp
         beQwWLXPGKgokrWwiGOBrgqgTjP2Xx0Anhf11C1Y=
Date:   Wed, 17 Jun 2020 12:45:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vijay Balakrishna <vijayb@linux.microsoft.com>
Cc:     Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Subject: Re: [PATCH v2][RFC] kdump: append kernel build-id string to
 VMCOREINFO
Message-Id: <20200617124531.753b42152682219f267b75a1@linux-foundation.org>
In-Reply-To: <1591849672-34104-1-git-send-email-vijayb@linux.microsoft.com>
References: <1591849672-34104-1-git-send-email-vijayb@linux.microsoft.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jun 2020 21:27:52 -0700 Vijay Balakrishna <vijayb@linux.microsoft.com> wrote:

> Make kernel GNU build-id available in VMCOREINFO.  Having
> build-id in VMCOREINFO facilitates presenting appropriate kernel
> namelist image with debug information file to kernel crash dump
> analysis tools.  Currently VMCOREINFO lacks uniquely identifiable
> key for crash analysis automation.
> 
> Regarding if this patch is necessary or matching of linux_banner
> and OSRELEASE in VMCOREINFO employed by crash(8) meets the
> need -- IMO, build-id approach more foolproof, in most instances it
> is a cryptographic hash generated using internal code/ELF bits unlike
> kernel version string upon which linux_banner is based that is
> external to the code.  I feel each is intended for a different purpose.
> Also OSRELEASE is not suitable when two different kernel builds
> from same version with different features enabled.
> 
> Currently for most linux (and non-linux) systems build-id can be
> extracted using standard methods for file types such as user mode crash
> dumps, shared libraries, loadable kernel modules etc.,  This is an
> exception for linux kernel dump.  Having build-id in VMCOREINFO brings
> some uniformity for automation tools.
> 
> ...
>
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -11,6 +11,8 @@
>  #include <asm/page.h>
>  #include <asm/sections.h>
>  
> +#include <crypto/sha.h>
> +
>  /* vmcoreinfo stuff */
>  unsigned char *vmcoreinfo_data;
>  size_t vmcoreinfo_size;
> @@ -376,6 +378,53 @@ phys_addr_t __weak paddr_vmcoreinfo_note(void)
>  }
>  EXPORT_SYMBOL(paddr_vmcoreinfo_note);
>  
> +#define NOTES_SIZE (&__stop_notes - &__start_notes)
> +#define BUILD_ID_MAX SHA1_DIGEST_SIZE
> +#define NT_GNU_BUILD_ID 3
> +
> +struct elf_note_section {
> +	struct elf_note	n_hdr;
> +	u8 n_data[];
> +};
> +
> +/*
> + * Add build ID from .notes section as generated by the GNU ld(1)
> + * or LLVM lld(1) --build-id option.
> + */
> +static void add_build_id_vmcoreinfo(void)
> +{
> +	char build_id[BUILD_ID_MAX * 2 + 1];
> +	int n_remain = NOTES_SIZE;
> +
> +	while (n_remain >= sizeof(struct elf_note)) {
> +		const struct elf_note_section *note_sec =
> +			&__start_notes + NOTES_SIZE - n_remain;
> +		const u32 n_namesz = note_sec->n_hdr.n_namesz;
> +
> +		if (note_sec->n_hdr.n_type == NT_GNU_BUILD_ID &&
> +		    n_namesz != 0 &&
> +		    !strcmp((char *)&note_sec->n_data[0], "GNU")) {

Is it guaranteed that n_data[] is null-terminated?

> +			if (note_sec->n_hdr.n_descsz <= BUILD_ID_MAX) {
> +				const u32 n_descsz = note_sec->n_hdr.n_descsz;
> +				const u8 *s = &note_sec->n_data[n_namesz];
> +
> +				s = PTR_ALIGN(s, 4);
> +				bin2hex(build_id, s, n_descsz);
> +				build_id[2 * n_descsz] = '\0';
> +				VMCOREINFO_BUILD_ID(build_id);
> +				return;
> +			}
> +			pr_warn("Build ID is too large to include in vmcoreinfo: %u > %u\n",
> +				note_sec->n_hdr.n_descsz,
> +				BUILD_ID_MAX);
> +			return;
> +		}
> +		n_remain -= sizeof(struct elf_note) +
> +			ALIGN(note_sec->n_hdr.n_namesz, 4) +
> +			ALIGN(note_sec->n_hdr.n_descsz, 4);
> +	}
> +}
> +
>  static int __init crash_save_vmcoreinfo_init(void)
>  {
>  	vmcoreinfo_data = (unsigned char *)get_zeroed_page(GFP_KERNEL);

