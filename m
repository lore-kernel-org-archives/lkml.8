Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19971C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E507220772
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TVHkz2HN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbgGAMxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 08:53:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46131 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730520AbgGAMxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 08:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593608031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ylks6ZC4AGq74KjZ8OmBYSrj4mT7YR7HWbuFUZxGUUk=;
        b=TVHkz2HN7N4Y7aFsvzOT9gyTcx+Js1nd1KxMZNh7OPj5LD3CqN5Zh5j3240U7hQEkFOQAV
        /GI2sHniWy09q131yLtdUQ0ZZazBPLcCeu8wz4UsL8mpaUA/yttOOg4GCROn7FkedV9Khp
        SZPZKEY16HAHXT8H5SZrKSx2c7VAR/E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-c3-vNlfMNbWRmerX0_OETA-1; Wed, 01 Jul 2020 08:53:49 -0400
X-MC-Unique: c3-vNlfMNbWRmerX0_OETA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD95DBFC1;
        Wed,  1 Jul 2020 12:53:47 +0000 (UTC)
Received: from [10.72.8.21] (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A72A10013C0;
        Wed,  1 Jul 2020 12:53:37 +0000 (UTC)
Subject: Re: [PATCH 04/11] ppc64/kexec_file: avoid stomping memory used by
 special regions
To:     Dave Young <dyoung@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>
References: <159319825403.16351.7253978047621755765.stgit@hbathini.in.ibm.com>
 <159319831192.16351.17443438699302756548.stgit@hbathini.in.ibm.com>
 <20200701074012.GA4496@dhcp-128-65.nay.redhat.com>
Cc:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kexec-ml <kexec@lists.infradead.org>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Eric Biederman <ebiederm@xmission.com>
From:   piliu <piliu@redhat.com>
X-Enigmail-Draft-Status: N1110
Message-ID: <bc8fe308-5ce9-1ca6-c832-7c3a75a732d2@redhat.com>
Date:   Wed, 1 Jul 2020 20:53:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20200701074012.GA4496@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/01/2020 03:40 PM, Dave Young wrote:
> Hi Hari,
> On 06/27/20 at 12:35am, Hari Bathini wrote:
>> crashkernel region could have an overlap with special memory regions
>> like  opal, rtas, tce-table & such. These regions are referred to as
>> exclude memory ranges. Setup this ranges during image probe in order
>> to avoid them while finding the buffer for different kdump segments.
>> Implement kexec_locate_mem_hole_ppc64() that locates a memory hole
>> accounting for these ranges. Also, override arch_kexec_add_buffer()
>> to locate a memory hole & later call __kexec_add_buffer() function
>> with kbuf->mem set to skip the generic locate memory hole lookup.
>>
>> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
>> ---
>>  arch/powerpc/include/asm/crashdump-ppc64.h |   10 +
>>  arch/powerpc/include/asm/kexec.h           |    7 -
>>  arch/powerpc/kexec/elf_64.c                |    7 +
>>  arch/powerpc/kexec/file_load_64.c          |  292 ++++++++++++++++++++++++++++
>>  4 files changed, 312 insertions(+), 4 deletions(-)
>>  create mode 100644 arch/powerpc/include/asm/crashdump-ppc64.h
>>
> [snip]
>>  /**
>> + * get_exclude_memory_ranges - Get exclude memory ranges. This list includes
>> + *                             regions like opal/rtas, tce-table, initrd,
>> + *                             kernel, htab which should be avoided while
>> + *                             setting up kexec load segments.
>> + * @mem_ranges:                Range list to add the memory ranges to.
>> + *
>> + * Returns 0 on success, negative errno on error.
>> + */
>> +static int get_exclude_memory_ranges(struct crash_mem **mem_ranges)
>> +{
>> +	int ret;
>> +
>> +	ret = add_tce_mem_ranges(mem_ranges);
>> +	if (ret)
>> +		goto out;
>> +
>> +	ret = add_initrd_mem_range(mem_ranges);
>> +	if (ret)
>> +		goto out;
>> +
>> +	ret = add_htab_mem_range(mem_ranges);
>> +	if (ret)
>> +		goto out;
>> +
>> +	ret = add_kernel_mem_range(mem_ranges);
>> +	if (ret)
>> +		goto out;
>> +
>> +	ret = add_rtas_mem_range(mem_ranges, false);
>> +	if (ret)
>> +		goto out;
>> +
>> +	ret = add_opal_mem_range(mem_ranges, false);
>> +	if (ret)
>> +		goto out;
>> +
>> +	ret = add_reserved_ranges(mem_ranges);
>> +	if (ret)
>> +		goto out;
>> +
>> +	/* exclude memory ranges should be sorted for easy lookup */
>> +	sort_memory_ranges(*mem_ranges);
>> +out:
>> +	if (ret)
>> +		pr_err("Failed to setup exclude memory ranges\n");
>> +	return ret;
>> +}
> 
> I'm confused about the "overlap with crashkernel memory", does that mean
> those normal kernel used memory could be put in crashkernel reserved
> memory range?  If so why can't just skip those areas while crashkernel
> doing the reservation?
I raised the same question in another mail. As Hari's answer, "kexec -p"
skips these ranges in user space. And the same logic should be done in
"kexec -s -p"

Regards,
Pingfan

