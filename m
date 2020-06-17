Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4CEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACEAA21841
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fPMTh8hF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgFQV72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 17:59:28 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51504 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgFQV71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 17:59:27 -0400
Received: from [192.168.0.109] (unknown [209.134.121.133])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4675820B7192;
        Wed, 17 Jun 2020 14:59:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4675820B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1592431166;
        bh=vXF/AK+HilS0mky+64QCLgW+nVTkEVVzDGGQtIvSA+k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fPMTh8hFAAiXhQEKxLk0gac9P0G2gGX9W7+19fPNzepTEKB5ul0CZtVePLCz2qivx
         9Uge20dlFk81QI3MAeJmcOmbf1CFsLG3rGAHonTQEpms840tNubH4Apx1nW2zHB1Z3
         F7vJJT2kApaZzaqhvaHwWwGBQLwJamdv4txpv7y8=
Subject: Re: [PATCH v2][RFC] kdump: append kernel build-id string to
 VMCOREINFO
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Tyler Hicks <tyhicks@linux.microsoft.com>
References: <1591849672-34104-1-git-send-email-vijayb@linux.microsoft.com>
 <20200617124531.753b42152682219f267b75a1@linux-foundation.org>
From:   Vijay Balakrishna <vijayb@linux.microsoft.com>
Message-ID: <4bf02b0f-fc24-eb28-cf5c-419e7161f707@linux.microsoft.com>
Date:   Wed, 17 Jun 2020 14:59:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200617124531.753b42152682219f267b75a1@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Andrew.  See inline.

On 6/17/2020 12:45 PM, Andrew Morton wrote:
> On Wed, 10 Jun 2020 21:27:52 -0700 Vijay Balakrishna <vijayb@linux.microsoft.com> wrote:
> 
>> Make kernel GNU build-id available in VMCOREINFO.  Having
>> build-id in VMCOREINFO facilitates presenting appropriate kernel
>> namelist image with debug information file to kernel crash dump
>> analysis tools.  Currently VMCOREINFO lacks uniquely identifiable
>> key for crash analysis automation.
>>
>> Regarding if this patch is necessary or matching of linux_banner
>> and OSRELEASE in VMCOREINFO employed by crash(8) meets the
>> need -- IMO, build-id approach more foolproof, in most instances it
>> is a cryptographic hash generated using internal code/ELF bits unlike
>> kernel version string upon which linux_banner is based that is
>> external to the code.  I feel each is intended for a different purpose.
>> Also OSRELEASE is not suitable when two different kernel builds
>> from same version with different features enabled.
>>
>> Currently for most linux (and non-linux) systems build-id can be
>> extracted using standard methods for file types such as user mode crash
>> dumps, shared libraries, loadable kernel modules etc.,  This is an
>> exception for linux kernel dump.  Having build-id in VMCOREINFO brings
>> some uniformity for automation tools.
>>
>> ...
>>
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -11,6 +11,8 @@
>>   #include <asm/page.h>
>>   #include <asm/sections.h>
>>   
>> +#include <crypto/sha.h>
>> +
>>   /* vmcoreinfo stuff */
>>   unsigned char *vmcoreinfo_data;
>>   size_t vmcoreinfo_size;
>> @@ -376,6 +378,53 @@ phys_addr_t __weak paddr_vmcoreinfo_note(void)
>>   }
>>   EXPORT_SYMBOL(paddr_vmcoreinfo_note);
>>   
>> +#define NOTES_SIZE (&__stop_notes - &__start_notes)
>> +#define BUILD_ID_MAX SHA1_DIGEST_SIZE
>> +#define NT_GNU_BUILD_ID 3
>> +
>> +struct elf_note_section {
>> +	struct elf_note	n_hdr;
>> +	u8 n_data[];
>> +};
>> +
>> +/*
>> + * Add build ID from .notes section as generated by the GNU ld(1)
>> + * or LLVM lld(1) --build-id option.
>> + */
>> +static void add_build_id_vmcoreinfo(void)
>> +{
>> +	char build_id[BUILD_ID_MAX * 2 + 1];
>> +	int n_remain = NOTES_SIZE;
>> +
>> +	while (n_remain >= sizeof(struct elf_note)) {
>> +		const struct elf_note_section *note_sec =
>> +			&__start_notes + NOTES_SIZE - n_remain;
>> +		const u32 n_namesz = note_sec->n_hdr.n_namesz;
>> +
>> +		if (note_sec->n_hdr.n_type == NT_GNU_BUILD_ID &&
>> +		    n_namesz != 0 &&
>> +		    !strcmp((char *)&note_sec->n_data[0], "GNU")) {
> 
> Is it guaranteed that n_data[] is null-terminated?

 From ELF(5) "Notes (Nhdr)" section:

>        n_namesz  The length of the name field in bytes.  The contents will immediately follow this note in memory.  The name is null  terminated.   For
>                  example, if the name is "GNU", then n_namesz will be set to 4.

Vijay

> 
>> +			if (note_sec->n_hdr.n_descsz <= BUILD_ID_MAX) {
>> +				const u32 n_descsz = note_sec->n_hdr.n_descsz;
>> +				const u8 *s = &note_sec->n_data[n_namesz];
>> +
>> +				s = PTR_ALIGN(s, 4);
>> +				bin2hex(build_id, s, n_descsz);
>> +				build_id[2 * n_descsz] = '\0';
>> +				VMCOREINFO_BUILD_ID(build_id);
>> +				return;
>> +			}
>> +			pr_warn("Build ID is too large to include in vmcoreinfo: %u > %u\n",
>> +				note_sec->n_hdr.n_descsz,
>> +				BUILD_ID_MAX);
>> +			return;
>> +		}
>> +		n_remain -= sizeof(struct elf_note) +
>> +			ALIGN(note_sec->n_hdr.n_namesz, 4) +
>> +			ALIGN(note_sec->n_hdr.n_descsz, 4);
>> +	}
>> +}
>> +
>>   static int __init crash_save_vmcoreinfo_init(void)
>>   {
>>   	vmcoreinfo_data = (unsigned char *)get_zeroed_page(GFP_KERNEL);
