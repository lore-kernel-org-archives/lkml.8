Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E3CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 13:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB85C206D5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 13:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbgEVNba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 09:31:30 -0400
Received: from 4.mo177.mail-out.ovh.net ([46.105.37.72]:34282 "EHLO
        4.mo177.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729367AbgEVNba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 09:31:30 -0400
X-Greylist: delayed 419 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 May 2020 09:31:27 EDT
Received: from player756.ha.ovh.net (unknown [10.110.115.182])
        by mo177.mail-out.ovh.net (Postfix) with ESMTP id B92A612FE56
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 15:24:26 +0200 (CEST)
Received: from 3mdeb.com (85-222-117-222.dynamic.chello.pl [85.222.117.222])
        (Authenticated sender: krystian.hebel@3mdeb.com)
        by player756.ha.ovh.net (Postfix) with ESMTPSA id 8ADB811C7B1D3;
        Fri, 22 May 2020 13:24:02 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-97G002d4487a8e-2fca-4765-9259-b8e2fabc2189,FCEDB92AD14E9058E5246D4C75F3ACF5DAAC6A74) smtp.auth=krystian.hebel@3mdeb.com
Subject: Re: [GRUB PATCH RFC 15/18] i386/txt: Add Intel TXT core
 implementation
To:     Daniel Kiper <daniel.kiper@oracle.com>, grub-devel@gnu.org,
        linux-kernel@vger.kernel.org, trenchboot-devel@googlegroups.com,
        x86@kernel.org
Cc:     alexander.burmashev@oracle.com, andrew.cooper3@citrix.com,
        ard.biesheuvel@linaro.org, dpsmith@apertussolutions.com,
        eric.snowberg@oracle.com, javierm@redhat.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        lukasz.hawrylko@linux.intel.com, michal.zygowski@3mdeb.com,
        mjg59@google.com, phcoder@gmail.com, pirot.krol@3mdeb.com,
        pjones@redhat.com, ross.philipson@oracle.com
References: <20200504232132.23570-1-daniel.kiper@oracle.com>
 <20200504232132.23570-16-daniel.kiper@oracle.com>
From:   Krystian Hebel <krystian.hebel@3mdeb.com>
Message-ID: <7056a782-714a-c3e9-7c5b-9659c67e9949@3mdeb.com>
Date:   Fri, 22 May 2020 15:24:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504232132.23570-16-daniel.kiper@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Ovh-Tracer-Id: 15170938297460448174
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedruddufedgieefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepmfhrhihsthhirghnucfjvggsvghluceokhhrhihsthhirghnrdhhvggsvghlseefmhguvggsrdgtohhmqeenucggtffrrghtthgvrhhnpedvieeuhfegvdfhhfeiveeltdelieeuteeljeffteefgeeuleefhfdvudegleelueenucffohhmrghinhepfehmuggvsgdrtghomhenucfkpheptddrtddrtddrtddpkeehrddvvddvrdduudejrddvvddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeehiedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehkrhihshhtihgrnhdrhhgvsggvlhesfehmuggvsgdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.05.2020 01:21, Daniel Kiper wrote:
> +static grub_err_t
> +init_txt_heap (struct grub_slaunch_params *slparams, struct grub_txt_acm_header *sinit)
> +{
> +  grub_uint8_t *txt_heap;
> +  grub_uint32_t os_sinit_data_ver, sinit_caps;
> +  grub_uint64_t *size;
> +  struct grub_txt_os_mle_data *os_mle_data;
> +  struct grub_txt_os_sinit_data *os_sinit_data;
> +  struct grub_txt_heap_end_element *heap_end_element;
> +  struct grub_txt_heap_event_log_pointer2_1_element *heap_event_log_pointer2_1_element;
> +#ifdef GRUB_MACHINE_EFI
> +  struct grub_acpi_rsdp_v20 *rsdp;
> +#endif
> +
> +  /* BIOS data already verified in grub_txt_verify_platform(). */
> +
> +  txt_heap = grub_txt_get_heap ();
> +
> +  /* OS/loader to MLE data. */
> +
> +  os_mle_data = grub_txt_os_mle_data_start (txt_heap);
> +  size = (grub_uint64_t *) ((grub_addr_t) os_mle_data - sizeof (grub_uint64_t));
There is 'grub_txt_os_mle_data_size()' in previous patch, it would look 
better.
> +  *size = sizeof (*os_mle_data) + sizeof (grub_uint64_t);
> +
> +  grub_memset (os_mle_data, 0, sizeof (*os_mle_data));
> +
> +  os_mle_data->version = GRUB_SL_OS_MLE_STRUCT_VERSION;
> +  os_mle_data->zero_page_addr = (grub_uint32_t)(grub_addr_t) slparams->params;
> +  os_mle_data->saved_misc_enable_msr = grub_rdmsr (GRUB_MSR_X86_MISC_ENABLE);
> +
> +  os_mle_data->ap_wake_block = slparams->ap_wake_block;
> +
> +  save_mtrrs (os_mle_data);
> +
> +  /* OS/loader to SINIT data. */
> +
> +  os_sinit_data_ver = grub_txt_supported_os_sinit_data_ver (sinit);
> +
> +  if (os_sinit_data_ver < OS_SINIT_DATA_MIN_VER)
> +    return grub_error (GRUB_ERR_BAD_DEVICE,
> +		       N_("unsupported OS to SINIT data version in SINIT ACM: %d"
> +		       " expected >= %d"), os_sinit_data_ver, OS_SINIT_DATA_MIN_VER);
> +
> +  os_sinit_data = grub_txt_os_sinit_data_start (txt_heap);
> +  size = (grub_uint64_t *) ((grub_addr_t) os_sinit_data - sizeof (grub_uint64_t));
Ditto
> +
> +  *size = sizeof(grub_uint64_t) + sizeof (struct grub_txt_os_sinit_data) +
> +	  sizeof (struct grub_txt_heap_end_element);
> +
> +  if (grub_get_tpm_ver () == GRUB_TPM_12)
> +    *size += sizeof (struct grub_txt_heap_tpm_event_log_element);
> +  else if (grub_get_tpm_ver () == GRUB_TPM_20)
> +    *size += sizeof (struct grub_txt_heap_event_log_pointer2_1_element);
> +  else
> +    return grub_error (GRUB_ERR_BAD_DEVICE, N_("unsupported TPM version"));
> +
> +  grub_memset (os_sinit_data, 0, *size);
> +
> +#ifdef GRUB_MACHINE_EFI
> +  rsdp = grub_acpi_get_rsdpv2 ();
> +
> +  if (rsdp == NULL)
> +    return grub_printf ("WARNING: ACPI RSDP 2.0 missing\n");
> +
> +  os_sinit_data->efi_rsdt_ptr = (grub_uint64_t)(grub_addr_t) rsdp;
> +#endif
> +
> +  os_sinit_data->mle_ptab = slparams->mle_ptab_target;
> +  os_sinit_data->mle_size = slparams->mle_size;
> +
> +  os_sinit_data->mle_hdr_base = slparams->mle_header_offset;
> +
> +  /* TODO: Check low PMR with RMRR. Look at relevant tboot code too. */
> +  /* TODO: Kernel should not allocate any memory outside of PMRs regions!!! */
> +  os_sinit_data->vtd_pmr_lo_base = 0;
> +  os_sinit_data->vtd_pmr_lo_size = ALIGN_DOWN (grub_mmap_get_highest (0x100000000),
> +					       GRUB_TXT_PMR_ALIGN);
> +
> +  os_sinit_data->vtd_pmr_hi_base = ALIGN_UP (grub_mmap_get_lowest (0x100000000),
> +					     GRUB_TXT_PMR_ALIGN);
> +  os_sinit_data->vtd_pmr_hi_size = ALIGN_DOWN (grub_mmap_get_highest (0xffffffffffffffff),
> +					       GRUB_TXT_PMR_ALIGN);
> +  os_sinit_data->vtd_pmr_hi_size -= os_sinit_data->vtd_pmr_hi_base;
Could it be done with just one PMR, from 0 to top of memory, or would 
TXT complain?
> +
> +  grub_dprintf ("slaunch",
> +		"vtd_pmr_lo_base: 0x%" PRIxGRUB_UINT64_T " vtd_pmr_lo_size: 0x%"
> +		PRIxGRUB_UINT64_T " vtd_pmr_hi_base: 0x%" PRIxGRUB_UINT64_T
> +		" vtd_pmr_hi_size: 0x%" PRIxGRUB_UINT64_T "\n",
> +		os_sinit_data->vtd_pmr_lo_base, os_sinit_data->vtd_pmr_lo_size,
> +		os_sinit_data->vtd_pmr_hi_base, os_sinit_data->vtd_pmr_hi_size);
> +
>
> <snip>
>
> +/*
> + * The MLE page tables have to be below the MLE and have no special regions in
> + * between them and the MLE (this is a bit of an unwritten rule).
> + * 20 pages are carved out of memory below the MLE. That leave 18 page table
> + * pages that can cover up to 36M .
> + * can only contain 4k pages
> + *
> + * TODO: TXT Spec p.32; List section name and number with PT MLE requirments here.
> + *
> + * TODO: This function is not able to cover MLEs larger than 1 GiB. Fix it!!!
> + * After fixing inrease GRUB_TXT_MLE_MAX_SIZE too.
> + */

What do you mean by "special regions"? In TXT spec it is written that 
there may be no holes
in the virtual address space:

"There may not be any invalid (not-present) page table entries after the 
first valid
entry (i.e. there may not be any gaps in the MLE’s linear address space)."

Also that spec:
"A breadth-first search of page tables must produce increasing physical 
addresses."

Maybe I misunderstood, but does it mean that the paging structures 
themselves cannot
be mapped? Or does it apply to the page tables only, not to the 
addresses of pages in PTEs?

> +void
> +grub_txt_setup_mle_ptab (struct grub_slaunch_params *slparams)
> +{
> +  grub_uint8_t *pg_dir, *pg_dir_ptr_tab = slparams->mle_ptab_mem, *pg_tab;
IMHO using 'grub_uint64_t' would result in less type casting and cleaner 
code below.
> +  grub_uint32_t mle_off = 0, pd_off = 0;
> +  grub_uint64_t *pde, *pte;
> +
> +  grub_memset (pg_dir_ptr_tab, 0, slparams->mle_ptab_size);
> +
> +  pg_dir         = pg_dir_ptr_tab + GRUB_PAGE_SIZE;
> +  pg_tab         = pg_dir + GRUB_PAGE_SIZE;
> +
> +  /* Only use first entry in page dir ptr table */
> +  *(grub_uint64_t *)pg_dir_ptr_tab = MAKE_PT_MLE_ENTRY(pg_dir);
> +
> +  /* Start with first entry in page dir */
> +  *(grub_uint64_t *)pg_dir = MAKE_PT_MLE_ENTRY(pg_tab);
> +
> +  pte = (grub_uint64_t *)pg_tab;
> +  pde = (grub_uint64_t *)pg_dir;
> +
> +  do
> +    {
> +      *pte = MAKE_PT_MLE_ENTRY(slparams->mle_start + mle_off);
> +
> +      pte++;
> +      mle_off += GRUB_PAGE_SIZE;
> +
> +      if (!(++pd_off % 512))
> +        {
> +          /* Break if we don't need any additional page entries */
> +          if (mle_off >= slparams->mle_size)
> +            break;
> +          pde++;
> +          *pde = MAKE_PT_MLE_ENTRY(pte);
> +        }
> +    } while (mle_off < slparams->mle_size);
> +}
>
> <snip>
>
> +grub_err_t
> +grub_txt_boot_prepare (struct grub_slaunch_params *slparams)
> +{
> +  grub_err_t err;
> +  struct grub_txt_mle_header *mle_header;
> +  struct grub_txt_acm_header *sinit_base;
> +
> +  sinit_base = grub_txt_sinit_select (grub_slaunch_module ());
> +
> +  if (sinit_base == NULL)
> +    return grub_errno;
> +
> +  err = init_txt_heap (slparams, sinit_base);
> +
> +  if (err != GRUB_ERR_NONE)
> +    return err;
> +
> +  /* Update the MLE header. */
> +  mle_header = (struct grub_txt_mle_header *)(grub_addr_t) (slparams->mle_start + slparams->mle_header_offset);
> +  mle_header->first_valid_page = 0;
> +  mle_header->mle_end = slparams->mle_size;
> +
> +  slparams->sinit_acm_base = (grub_uint32_t)(grub_addr_t) sinit_base;
> +  slparams->sinit_acm_size = sinit_base->size * 4;
> +
> +  grub_tpm_relinquish_lcl (0);
> +
> +  err = set_mtrrs_for_acmod (sinit_base);
> +  if (err)
> +    return grub_error (err, N_("secure launch failed to set MTRRs for ACM"));
> +
> +  err = grub_txt_prepare_cpu ();
> +  if ( err )
> +    return err;
> +
> +  if (!(grub_rdmsr (GRUB_MSR_X86_APICBASE) & GRUB_MSR_X86_APICBASE_BSP))
> +    return grub_error (GRUB_ERR_BAD_DEVICE, N_("secure launch must run on BSP"));
This test should be the first one, before messing with TPM and MTTRs.
> +
> +  return GRUB_ERR_NONE;
> +}
Best regards,

-- 
Krystian Hebel
Firmware Engineer
https://3mdeb.com | @3mdeb_com

