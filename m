Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37246C47256
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 18:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21DB020746
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 18:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbgEESnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 14:43:06 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:37614 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728481AbgEESnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 14:43:05 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jW2Wr-00021N-RA; Tue, 05 May 2020 12:42:54 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jW2We-0003Ln-ST; Tue, 05 May 2020 12:42:53 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Hari Bathini <hbathini@linux.ibm.com>
Cc:     Joonsoo Kim <js1304@gmail.com>, kernel-team@lge.com,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Christoph Hellwig <hch@infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Huang Rui <ray.huang@amd.com>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Pavel Machek <pavel@ucw.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Laura Abbott <labbott@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>
References: <1588130803-20527-1-git-send-email-iamjoonsoo.kim@lge.com>
        <1588130803-20527-4-git-send-email-iamjoonsoo.kim@lge.com>
        <87h7wzvjko.fsf@x220.int.ebiederm.org>
        <CAAmzW4MrD75+Prw=fQ=d5uXKgGy3urBwmxnNtoNsw5M1m9xjYQ@mail.gmail.com>
        <87ftcfpzjn.fsf@x220.int.ebiederm.org>
        <87368fmkel.fsf_-_@x220.int.ebiederm.org>
        <54a53bfe-6929-2790-9b1d-943e9f47cd62@linux.ibm.com>
Date:   Tue, 05 May 2020 13:39:16 -0500
In-Reply-To: <54a53bfe-6929-2790-9b1d-943e9f47cd62@linux.ibm.com> (Hari
        Bathini's message of "Tue, 5 May 2020 23:14:32 +0530")
Message-ID: <87sggekyzv.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jW2We-0003Ln-ST;;;mid=<87sggekyzv.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18HfHnjNf3TDWBm0cCNEfte5KG+vbwADIo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC][PATCH] kexec: Teach indirect pages how to live in high memory
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hari Bathini <hbathini@linux.ibm.com> writes:

> On 05/05/20 3:29 am, Eric W. Biederman wrote:
>> 
>> Recently a patch was proposed to kimage_alloc_page to slightly alter
>> the logic of how pages allocated with incompatible flags were
>> detected.  The logic was being altered because the semantics of the
>> page alloctor were changing yet again.
>> 
>> Looking at that case I realized that there is no reason for it to even
>> exist.  Either the indirect page allocations and the source page
>> allocations could be separated out, or I could do as I am doing now
>> and simply teach the indirect pages to live in high memory.
>> 
>> This patch replaced pointers of type kimage_entry_t * with a new type
>> kimage_entry_pos_t.  This new type holds the physical address of the
>> indirect page and the offset within that page of the next indirect
>> entry to write.  A special constant KIMAGE_ENTRY_POS_INVALID is added
>> that kimage_image_pos_t variables that don't currently have a valid
>> may be set to.
>> 
>> Two new functions kimage_read_entry and kimage_write_entry have been
>> provided to write entries in way that works if they live in high
>> memory.
>> 
>> The now unnecessary checks to see if a destination entry is non-zero
>> and to increment it if so have been removed.  For safety new indrect
>> pages are now cleared so we have a guarantee everything that has not
>> been used yet is zero.  Along with this writing an extra trailing 0
>> entry has been removed, as it is known all trailing entries are now 0.
>> 
>> With highmem support implemented for indirect pages
>> kimage_image_alloc_page has been updated to always allocate
>> GFP_HIGHUSER pages, and handling of pages with different
>> gfp flags has been removed.
>> 
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>
> Eric, the patch failed with data access exception on ppc64. Using the below patch on top
> got me going...

Doh!  Somehow I thought I had put that logic or something equivalent
into kimage_write_entry and it appears I did not.  I will see if I can
respin the patch.

Thank you very much for testing.

Eric


> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 45862fd..bef52f1 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -570,7 +570,12 @@ static int kimage_add_entry(struct kimage *image, kimage_entry_t entry)
>  			return -ENOMEM;
>  
>  		ind_addr = page_to_boot_pfn(page) << PAGE_SHIFT;
> -		kimage_write_entry(image->entry_pos, ind_addr | IND_INDIRECTION);
> +
> +		/* If it is the first entry, handle it here */
> +		if (!image->head)
> +			image->head = ind_addr | IND_INDIRECTION;
> +		else
> +			kimage_write_entry(image->entry_pos, ind_addr | IND_INDIRECTION);
>  
>  		clear_highpage(page);
>  
> @@ -623,7 +628,11 @@ int __weak machine_kexec_post_load(struct kimage *image)
>  
>  void kimage_terminate(struct kimage *image)
>  {
> -	kimage_write_entry(image->entry_pos, IND_DONE);
> +	/* This could be the only entry in case of kdump */
> +	if (!image->head)
> +		image->head = IND_DONE;
> +	else
> +		kimage_write_entry(image->entry_pos, IND_DONE);
>  }
>  
>  #define for_each_kimage_entry(image, pos, entry) 				\
>
>
> Thanks
> Hari
