Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAEEC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 09:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FFD6206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 09:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kt+4EgUF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgGFJHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 05:07:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56829 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728024AbgGFJHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 05:07:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594026442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SShJmXGA7atFqGfnITwSEtZ2LmnJMbZjAOdugmKURLE=;
        b=Kt+4EgUFFzvqe8kIrjQSVzIf4d9vUyUarE26DGlBxUFWsYplHrz10vamLfCs7R4IyB3gT5
        FZOeMhs625eT6JwmrsxYRARXLN79DsesMl3z6rkLCVgrZ7B5JMzdXaDmEO8NNRli+8UPqz
        //88JZ68lu+oHJjwrXWkJ5JPK2PfQaM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-Zi_68QkjPGSL8uxCZHp9gw-1; Mon, 06 Jul 2020 05:07:20 -0400
X-MC-Unique: Zi_68QkjPGSL8uxCZHp9gw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5970118A0724;
        Mon,  6 Jul 2020 09:07:18 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-78.pek2.redhat.com [10.72.12.78])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A26BD60BF3;
        Mon,  6 Jul 2020 09:07:10 +0000 (UTC)
Date:   Mon, 6 Jul 2020 17:07:07 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Hari Bathini <hbathini@linux.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>,
        Pingfan Liu <piliu@redhat.com>,
        Kexec-ml <kexec@lists.infradead.org>,
        Petr Tesarik <ptesarik@suse.cz>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v2 01/12] kexec_file: allow archs to handle special
 regions while locating memory hole
Message-ID: <20200706090707.GA9048@dhcp-128-65.nay.redhat.com>
References: <159371956443.21555.18251597651350106920.stgit@hbathini.in.ibm.com>
 <159371964681.21555.573193508667543223.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159371964681.21555.573193508667543223.stgit@hbathini.in.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/20 at 01:24am, Hari Bathini wrote:
> Some architectures may have special memory regions, within the given
> memory range, which can't be used for the buffer in a kexec segment.
> Implement weak arch_kexec_locate_mem_hole() definition which arch code
> may override, to take care of special regions, while trying to locate
> a memory hole.
> 
> Also, add the missing declarations for arch overridable functions and
> and drop the __weak descriptors in the declarations to avoid non-weak
> definitions from becoming weak.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> [lkp: In v1, arch_kimage_file_post_load_cleanup() declaration was missing]
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---
> 
> Changes in v2:
> * Introduced arch_kexec_locate_mem_hole() for override and dropped
>   weak arch_kexec_add_buffer().
> * Dropped __weak identifier for arch overridable functions.
> * Fixed the missing declaration for arch_kimage_file_post_load_cleanup()
>   reported by lkp. lkp report for reference:
>     - https://lore.kernel.org/patchwork/patch/1264418/
> 
> 
>  include/linux/kexec.h |   29 ++++++++++++++++++-----------
>  kernel/kexec_file.c   |   16 ++++++++++++++--
>  2 files changed, 32 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index ea67910..9e93bef 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -183,17 +183,24 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
>  				   bool get_value);
>  void *kexec_purgatory_get_symbol_addr(struct kimage *image, const char *name);
>  
> -int __weak arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
> -					 unsigned long buf_len);
> -void * __weak arch_kexec_kernel_image_load(struct kimage *image);
> -int __weak arch_kexec_apply_relocations_add(struct purgatory_info *pi,
> -					    Elf_Shdr *section,
> -					    const Elf_Shdr *relsec,
> -					    const Elf_Shdr *symtab);
> -int __weak arch_kexec_apply_relocations(struct purgatory_info *pi,
> -					Elf_Shdr *section,
> -					const Elf_Shdr *relsec,
> -					const Elf_Shdr *symtab);
> +/* Architectures may override the below functions */
> +int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
> +				  unsigned long buf_len);
> +void *arch_kexec_kernel_image_load(struct kimage *image);
> +int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
> +				     Elf_Shdr *section,
> +				     const Elf_Shdr *relsec,
> +				     const Elf_Shdr *symtab);
> +int arch_kexec_apply_relocations(struct purgatory_info *pi,
> +				 Elf_Shdr *section,
> +				 const Elf_Shdr *relsec,
> +				 const Elf_Shdr *symtab);
> +int arch_kimage_file_post_load_cleanup(struct kimage *image);
> +#ifdef CONFIG_KEXEC_SIG
> +int arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
> +				 unsigned long buf_len);
> +#endif
> +int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
>  
>  extern int kexec_add_buffer(struct kexec_buf *kbuf);
>  int kexec_locate_mem_hole(struct kexec_buf *kbuf);
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 09cc78d..e89912d 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -636,6 +636,19 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
>  }
>  
>  /**
> + * arch_kexec_locate_mem_hole - Find free memory to place the segments.
> + * @kbuf:                       Parameters for the memory search.
> + *
> + * On success, kbuf->mem will have the start address of the memory region found.
> + *
> + * Return: 0 on success, negative errno on error.
> + */
> +int __weak arch_kexec_locate_mem_hole(struct kexec_buf *kbuf)
> +{
> +	return kexec_locate_mem_hole(kbuf);
> +}
> +
> +/**
>   * kexec_add_buffer - place a buffer in a kexec segment
>   * @kbuf:	Buffer contents and memory parameters.
>   *
> @@ -647,7 +660,6 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
>   */
>  int kexec_add_buffer(struct kexec_buf *kbuf)
>  {
> -
>  	struct kexec_segment *ksegment;
>  	int ret;
>  
> @@ -675,7 +687,7 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
>  	kbuf->buf_align = max(kbuf->buf_align, PAGE_SIZE);
>  
>  	/* Walk the RAM ranges and allocate a suitable range for the buffer */
> -	ret = kexec_locate_mem_hole(kbuf);
> +	ret = arch_kexec_locate_mem_hole(kbuf);
>  	if (ret)
>  		return ret;
>  
> 

Acked-by: Dave Young <dyoung@redhat.com>

Thanks
Dave

