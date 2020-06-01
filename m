Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5EDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 14:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D566F20738
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 14:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SndvzTCn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgFAOR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 10:17:56 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40282 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgFAORz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 10:17:55 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 051DvqVe073091;
        Mon, 1 Jun 2020 14:16:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=cBy8vo3wE/R57TJuq2wO/kNka1wDySjW3myZb9nQ8pg=;
 b=SndvzTCnBbm1A7YzGASEfhtI+xgDxCFad3nz+rtrA9vdCNf275EXiwbVwk7Yt3tJVGOu
 Tke+/QW0SDFfKBywV8MSqcZl4zZ6a7ud53w2OT8clKCT4ZcOa9/wDNSqHk3tiMPi/kC3
 DMvmfmwhAJWRQFiia2cL7xYY21tFV62xIz2VNXqpuvMImsiDGRsiIxqF7iDKUweYhaAZ
 unYiz1tVg5bppn5dK57GwwepvHbWOJ37Y5YwOZZCgP0EHl6C7JudpV5B3BwxFFt1RDeq
 ALAy7qXZbpwH5SzcM0lX7hDB7CstbSf9p0eYO2oMxRaREpw8STXhOqHI4ErWSJHPa1RX wA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 31bewqq269-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 01 Jun 2020 14:16:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 051Dvssb133507;
        Mon, 1 Jun 2020 14:16:31 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 31c25ju92g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jun 2020 14:16:30 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 051EGRK7022498;
        Mon, 1 Jun 2020 14:16:28 GMT
Received: from [10.39.241.107] (/10.39.241.107)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Jun 2020 07:16:27 -0700
Subject: Re: [GRUB PATCH RFC 15/18] i386/txt: Add Intel TXT core
 implementation
To:     Krystian Hebel <krystian.hebel@3mdeb.com>,
        Daniel Kiper <daniel.kiper@oracle.com>, grub-devel@gnu.org,
        linux-kernel@vger.kernel.org, trenchboot-devel@googlegroups.com,
        x86@kernel.org
Cc:     alexander.burmashev@oracle.com, andrew.cooper3@citrix.com,
        ard.biesheuvel@linaro.org, dpsmith@apertussolutions.com,
        eric.snowberg@oracle.com, javierm@redhat.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        lukasz.hawrylko@linux.intel.com, michal.zygowski@3mdeb.com,
        mjg59@google.com, phcoder@gmail.com, pirot.krol@3mdeb.com,
        pjones@redhat.com
References: <20200504232132.23570-1-daniel.kiper@oracle.com>
 <20200504232132.23570-16-daniel.kiper@oracle.com>
 <7056a782-714a-c3e9-7c5b-9659c67e9949@3mdeb.com>
From:   Ross Philipson <ross.philipson@oracle.com>
Autocrypt: addr=ross.philipson@oracle.com; keydata=
 mQENBFtHZ04BCADHhtvMImplKfIEOytU7ZH4haZ9eFAqZpGeIpG9D+pzTCuReM2/49bvgNoI
 e1xuiQFO+UEJ8FjedFjDdqY7fSw3xVdX9gLwD1Rmw0Dadc1w6sGbcoOQLHcglesu+BmcKBtU
 tWQZkzCpEShN4etgZThk8469YnAvO08vNZsrizgrpD90T7mEYiNXxIkX87sPGbnBrL1X7RvZ
 TaRXfE8174W+XVwGEpSiO/GjRgLW8+DFZB5MgXpCR993+U1YT9Lz97/MRzr4hqcOYry6LBYi
 s8dOly4oP7gK15oW8Xap9+ur0Jd8Vy8o99Axq+7yunF+2KE2SwP3/w8H3VDpx7EeDhWDABEB
 AAG0KlJvc3MgUGhpbGlwc29uIDxyb3NzLnBoaWxpcHNvbkBvcmFjbGUuY29tPokBVAQTAQgA
 PgIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBFsN7r6v0OZTCaJ1wdpHdTZHiMYcBQJb
 R2eBBQkJZgGzAAoJENpHdTZHiMYcPYcH/Rlp3/F3P4/2i/W0F4yQDVD6rAkejCws4KlbgC5D
 Slkdvk6j8jOW/HNeIY3n+a3mW0iyyhZlipgYAqkK1loDiDxJjc2eUaHxiYWNLQ4CwIj2EC27
 AWCp6hgwHNWmZrdeNbM/Z6LTFQILx5xzgX+86KNqzFV7gOcAaS2qBVz1D83dgrFZaGaao918
 nvfe+SnImo0GaEf8nVDKgsD2zfzMBkk4q/E0mrEADFXwBHSvNCnVyrCN6Ve0dHWgI7SszUDt
 7v01zbGPR5mRfGuyC9gykd2SDCw5/Q27RMWfaPFL/dtiZBljUzb2yW5jicZAz7zNdDcBSUGR
 r//wxtG4k/dBrMW5AQ0EW0dnTwEIAPelEnLDnfJnHdFR+1Thrvv3Udt/1cjqQfHqH4F8zef/
 MsIcPV1skL7qPUYD+CrbasvmqhlPxtJAtN68inPa70fA2g0PtNmLUH1NBb2e6EjOoVZg9ais
 BWfdYUITZouOXs2zCTFsoNWjTJANnXxexbTf1ZEqfzlVtQK+xAnXl3kiL4Y47VMbgDkGedhw
 3ZMWQ2zMMZqYJkPYhtlTXtedhV91DL1347ULwHsvkUJDZ0gL+WU6tYhsCOOiD61x58PfUiFb
 /WkZEPxb96dSSSWrTlLlBWSSD24RnhfbJjfsXeSu9s4XldmGTDkj7jclMVU1xV0BUfqEwhVn
 xR8FlC+dZvkAEQEAAYkBPAQYAQgAJgIbDBYhBFsN7r6v0OZTCaJ1wdpHdTZHiMYcBQJbR2eB
 BQkJZgGyAAoJENpHdTZHiMYcDIAIAIRJrKjIStRvLsOOCX92s9XJPUjrC/xmtVsqVviyFWIC
 QRPQzDE+bDSvRazudBHmcPW+BOOB5B+p7zKZzOGoZV2peG8oA/Y8oCxOYBtpbBaZ5KJexm/g
 BbnJUwb3uhmKtDShHGUCmtq8MZBJBr6Q6xHprOU8Qnzs9Jea8NVwaz9O226Rrg4XVv/sK1Lh
 ++xZfhi7YqKWdx5vdfdnX1xWe8ma0eXLeCDh3V6Ys+Habw1jEbMuafrcVzAbp1rMt2Lju1ls
 BNAoxeViK7QXWfwGTmGJP++jHmo99gMqEtiohf+37N0oS6uYu6kaE7PxsEcOjWKJxW/DdgwO
 eFq+D6xuiKk=
Message-ID: <cc7142e1-708d-aab3-60f2-35b59109d276@oracle.com>
Date:   Mon, 1 Jun 2020 10:16:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <7056a782-714a-c3e9-7c5b-9659c67e9949@3mdeb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9638 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006010103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9638 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 bulkscore=0
 phishscore=0 suspectscore=0 impostorscore=0 cotscore=-2147483648
 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006010103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/20 9:24 AM, Krystian Hebel wrote:
> 
> On 05.05.2020 01:21, Daniel Kiper wrote:
>> +static grub_err_t
>> +init_txt_heap (struct grub_slaunch_params *slparams, struct
>> grub_txt_acm_header *sinit)
>> +{
>> +  grub_uint8_t *txt_heap;
>> +  grub_uint32_t os_sinit_data_ver, sinit_caps;
>> +  grub_uint64_t *size;
>> +  struct grub_txt_os_mle_data *os_mle_data;
>> +  struct grub_txt_os_sinit_data *os_sinit_data;
>> +  struct grub_txt_heap_end_element *heap_end_element;
>> +  struct grub_txt_heap_event_log_pointer2_1_element
>> *heap_event_log_pointer2_1_element;
>> +#ifdef GRUB_MACHINE_EFI
>> +  struct grub_acpi_rsdp_v20 *rsdp;
>> +#endif
>> +
>> +  /* BIOS data already verified in grub_txt_verify_platform(). */
>> +
>> +  txt_heap = grub_txt_get_heap ();
>> +
>> +  /* OS/loader to MLE data. */
>> +
>> +  os_mle_data = grub_txt_os_mle_data_start (txt_heap);
>> +  size = (grub_uint64_t *) ((grub_addr_t) os_mle_data - sizeof
>> (grub_uint64_t));
> There is 'grub_txt_os_mle_data_size()' in previous patch, it would look
> better.
>> +  *size = sizeof (*os_mle_data) + sizeof (grub_uint64_t);
>> +
>> +  grub_memset (os_mle_data, 0, sizeof (*os_mle_data));
>> +
>> +  os_mle_data->version = GRUB_SL_OS_MLE_STRUCT_VERSION;
>> +  os_mle_data->zero_page_addr = (grub_uint32_t)(grub_addr_t)
>> slparams->params;
>> +  os_mle_data->saved_misc_enable_msr = grub_rdmsr
>> (GRUB_MSR_X86_MISC_ENABLE);
>> +
>> +  os_mle_data->ap_wake_block = slparams->ap_wake_block;
>> +
>> +  save_mtrrs (os_mle_data);
>> +
>> +  /* OS/loader to SINIT data. */
>> +
>> +  os_sinit_data_ver = grub_txt_supported_os_sinit_data_ver (sinit);
>> +
>> +  if (os_sinit_data_ver < OS_SINIT_DATA_MIN_VER)
>> +    return grub_error (GRUB_ERR_BAD_DEVICE,
>> +               N_("unsupported OS to SINIT data version in SINIT ACM:
>> %d"
>> +               " expected >= %d"), os_sinit_data_ver,
>> OS_SINIT_DATA_MIN_VER);
>> +
>> +  os_sinit_data = grub_txt_os_sinit_data_start (txt_heap);
>> +  size = (grub_uint64_t *) ((grub_addr_t) os_sinit_data - sizeof
>> (grub_uint64_t));
> Ditto
>> +
>> +  *size = sizeof(grub_uint64_t) + sizeof (struct
>> grub_txt_os_sinit_data) +
>> +      sizeof (struct grub_txt_heap_end_element);
>> +
>> +  if (grub_get_tpm_ver () == GRUB_TPM_12)
>> +    *size += sizeof (struct grub_txt_heap_tpm_event_log_element);
>> +  else if (grub_get_tpm_ver () == GRUB_TPM_20)
>> +    *size += sizeof (struct grub_txt_heap_event_log_pointer2_1_element);
>> +  else
>> +    return grub_error (GRUB_ERR_BAD_DEVICE, N_("unsupported TPM
>> version"));
>> +
>> +  grub_memset (os_sinit_data, 0, *size);
>> +
>> +#ifdef GRUB_MACHINE_EFI
>> +  rsdp = grub_acpi_get_rsdpv2 ();
>> +
>> +  if (rsdp == NULL)
>> +    return grub_printf ("WARNING: ACPI RSDP 2.0 missing\n");
>> +
>> +  os_sinit_data->efi_rsdt_ptr = (grub_uint64_t)(grub_addr_t) rsdp;
>> +#endif
>> +
>> +  os_sinit_data->mle_ptab = slparams->mle_ptab_target;
>> +  os_sinit_data->mle_size = slparams->mle_size;
>> +
>> +  os_sinit_data->mle_hdr_base = slparams->mle_header_offset;
>> +
>> +  /* TODO: Check low PMR with RMRR. Look at relevant tboot code too. */
>> +  /* TODO: Kernel should not allocate any memory outside of PMRs
>> regions!!! */
>> +  os_sinit_data->vtd_pmr_lo_base = 0;
>> +  os_sinit_data->vtd_pmr_lo_size = ALIGN_DOWN (grub_mmap_get_highest
>> (0x100000000),
>> +                           GRUB_TXT_PMR_ALIGN);
>> +
>> +  os_sinit_data->vtd_pmr_hi_base = ALIGN_UP (grub_mmap_get_lowest
>> (0x100000000),
>> +                         GRUB_TXT_PMR_ALIGN);
>> +  os_sinit_data->vtd_pmr_hi_size = ALIGN_DOWN (grub_mmap_get_highest
>> (0xffffffffffffffff),
>> +                           GRUB_TXT_PMR_ALIGN);
>> +  os_sinit_data->vtd_pmr_hi_size -= os_sinit_data->vtd_pmr_hi_base;
> Could it be done with just one PMR, from 0 to top of memory, or would

No because there could be these legacy reserved regions in somewhere
below 4G that might cause hangs if you block DMA to them. So the idea is
the high PMR covers everything > 4G and the low PMR needs special logic
to not block these reserved regions. We are working on better logic for
this now.

> TXT complain?
>> +
>> +  grub_dprintf ("slaunch",
>> +        "vtd_pmr_lo_base: 0x%" PRIxGRUB_UINT64_T " vtd_pmr_lo_size: 0x%"
>> +        PRIxGRUB_UINT64_T " vtd_pmr_hi_base: 0x%" PRIxGRUB_UINT64_T
>> +        " vtd_pmr_hi_size: 0x%" PRIxGRUB_UINT64_T "\n",
>> +        os_sinit_data->vtd_pmr_lo_base, os_sinit_data->vtd_pmr_lo_size,
>> +        os_sinit_data->vtd_pmr_hi_base, os_sinit_data->vtd_pmr_hi_size);
>> +
>>
>> <snip>
>>
>> +/*
>> + * The MLE page tables have to be below the MLE and have no special
>> regions in
>> + * between them and the MLE (this is a bit of an unwritten rule).
>> + * 20 pages are carved out of memory below the MLE. That leave 18
>> page table
>> + * pages that can cover up to 36M .
>> + * can only contain 4k pages
>> + *
>> + * TODO: TXT Spec p.32; List section name and number with PT MLE
>> requirments here.
>> + *
>> + * TODO: This function is not able to cover MLEs larger than 1 GiB.
>> Fix it!!!
>> + * After fixing inrease GRUB_TXT_MLE_MAX_SIZE too.
>> + */
> 
> What do you mean by "special regions"? In TXT spec it is written that
> there may be no holes
> in the virtual address space:
> 
> "There may not be any invalid (not-present) page table entries after the
> first valid
> entry (i.e. there may not be any gaps in the MLE’s linear address space)."
> 
> Also that spec:
> "A breadth-first search of page tables must produce increasing physical
> addresses."
> 
> Maybe I misunderstood, but does it mean that the paging structures
> themselves cannot
> be mapped? Or does it apply to the page tables only, not to the
> addresses of pages in PTEs?

One of the rules for building the page table for the ACM is the following:

Neither the MLE nor the page tables may overlap certain regions of memory:
 - device memory (PCI, PCIe*, etc.)
 - addresses between [640k, 1M] or above Top of Memory (TOM)
 - ISA hole (if enabled)
 - the Intel ® TXT heap or SINIT memory regions
 - Intel ® VT-d DMAR tables

Perhaps the comment could be better...

> 
>> +void
>> +grub_txt_setup_mle_ptab (struct grub_slaunch_params *slparams)
>> +{
>> +  grub_uint8_t *pg_dir, *pg_dir_ptr_tab = slparams->mle_ptab_mem,
>> *pg_tab;
> IMHO using 'grub_uint64_t' would result in less type casting and cleaner
> code below.
>> +  grub_uint32_t mle_off = 0, pd_off = 0;
>> +  grub_uint64_t *pde, *pte;
>> +
>> +  grub_memset (pg_dir_ptr_tab, 0, slparams->mle_ptab_size);
>> +
>> +  pg_dir         = pg_dir_ptr_tab + GRUB_PAGE_SIZE;
>> +  pg_tab         = pg_dir + GRUB_PAGE_SIZE;
>> +
>> +  /* Only use first entry in page dir ptr table */
>> +  *(grub_uint64_t *)pg_dir_ptr_tab = MAKE_PT_MLE_ENTRY(pg_dir);
>> +
>> +  /* Start with first entry in page dir */
>> +  *(grub_uint64_t *)pg_dir = MAKE_PT_MLE_ENTRY(pg_tab);
>> +
>> +  pte = (grub_uint64_t *)pg_tab;
>> +  pde = (grub_uint64_t *)pg_dir;
>> +
>> +  do
>> +    {
>> +      *pte = MAKE_PT_MLE_ENTRY(slparams->mle_start + mle_off);
>> +
>> +      pte++;
>> +      mle_off += GRUB_PAGE_SIZE;
>> +
>> +      if (!(++pd_off % 512))
>> +        {
>> +          /* Break if we don't need any additional page entries */
>> +          if (mle_off >= slparams->mle_size)
>> +            break;
>> +          pde++;
>> +          *pde = MAKE_PT_MLE_ENTRY(pte);
>> +        }
>> +    } while (mle_off < slparams->mle_size);
>> +}
>>
>> <snip>
>>
>> +grub_err_t
>> +grub_txt_boot_prepare (struct grub_slaunch_params *slparams)
>> +{
>> +  grub_err_t err;
>> +  struct grub_txt_mle_header *mle_header;
>> +  struct grub_txt_acm_header *sinit_base;
>> +
>> +  sinit_base = grub_txt_sinit_select (grub_slaunch_module ());
>> +
>> +  if (sinit_base == NULL)
>> +    return grub_errno;
>> +
>> +  err = init_txt_heap (slparams, sinit_base);
>> +
>> +  if (err != GRUB_ERR_NONE)
>> +    return err;
>> +
>> +  /* Update the MLE header. */
>> +  mle_header = (struct grub_txt_mle_header *)(grub_addr_t)
>> (slparams->mle_start + slparams->mle_header_offset);
>> +  mle_header->first_valid_page = 0;
>> +  mle_header->mle_end = slparams->mle_size;
>> +
>> +  slparams->sinit_acm_base = (grub_uint32_t)(grub_addr_t) sinit_base;
>> +  slparams->sinit_acm_size = sinit_base->size * 4;
>> +
>> +  grub_tpm_relinquish_lcl (0);
>> +
>> +  err = set_mtrrs_for_acmod (sinit_base);
>> +  if (err)
>> +    return grub_error (err, N_("secure launch failed to set MTRRs for
>> ACM"));
>> +
>> +  err = grub_txt_prepare_cpu ();
>> +  if ( err )
>> +    return err;
>> +
>> +  if (!(grub_rdmsr (GRUB_MSR_X86_APICBASE) & GRUB_MSR_X86_APICBASE_BSP))
>> +    return grub_error (GRUB_ERR_BAD_DEVICE, N_("secure launch must
>> run on BSP"));
> This test should be the first one, before messing with TPM and MTTRs.
>> +
>> +  return GRUB_ERR_NONE;
>> +}
> Best regards,
> 

