Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EF0C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 11:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58FE20725
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 11:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbgBQL4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 06:56:20 -0500
Received: from foss.arm.com ([217.140.110.172]:34590 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728773AbgBQL4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 06:56:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B821B30E;
        Mon, 17 Feb 2020 03:56:19 -0800 (PST)
Received: from [192.168.0.129] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CEE03F703;
        Mon, 17 Feb 2020 03:56:15 -0800 (PST)
Subject: Re: [PATCH 4/5] mm/vma: Replace all remaining open encodings with
 vma_set_anonymous()
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Richard Fontana <rfontana@redhat.com>
References: <1581915833-21984-1-git-send-email-anshuman.khandual@arm.com>
 <1581915833-21984-5-git-send-email-anshuman.khandual@arm.com>
 <20200217102727.cmd74il6nxfgzvkh@box>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <f2d61f6c-c5e4-1cb9-f6c1-2f78b696fe2e@arm.com>
Date:   Mon, 17 Feb 2020 17:26:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200217102727.cmd74il6nxfgzvkh@box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/17/2020 03:57 PM, Kirill A. Shutemov wrote:
> On Mon, Feb 17, 2020 at 10:33:52AM +0530, Anshuman Khandual wrote:
>> This replaces all remaining open encodings with vma_set_anonymous().
>>
>> Cc: Sudeep Dutt <sudeep.dutt@intel.com>
>> Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Kate Stewart <kstewart@linuxfoundation.org>
>> Cc: Allison Randal <allison@lohutok.net>
>> Cc: Richard Fontana <rfontana@redhat.com>
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  drivers/misc/mic/scif/scif_mmap.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/misc/mic/scif/scif_mmap.c b/drivers/misc/mic/scif/scif_mmap.c
>> index a151d416f39c..1f0dec5df994 100644
>> --- a/drivers/misc/mic/scif/scif_mmap.c
>> +++ b/drivers/misc/mic/scif/scif_mmap.c
>> @@ -580,7 +580,7 @@ static void scif_munmap(struct vm_area_struct *vma)
>>  	 * The kernel probably zeroes these out but we still want
>>  	 * to clean up our own mess just in case.
>>  	 */
>> -	vma->vm_ops = NULL;
>> +	vma_set_anonymous(vma);
>>  	vma->vm_private_data = NULL;
>>  	kref_put(&vmapvt->ref, vma_pvt_release);
>>  	scif_delete_vma(ep, vma);
> 
> This is misleading. The VMA doesn't become anonymous here. This is undo of
> the previously overwritten vm_ops. I think we should leave it opencodded.

I was bit unsure about it as well, thanks for the clarification. Will drop it.
