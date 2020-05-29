Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413CFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 01:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2516B20707
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 01:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438252AbgE2BAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 21:00:13 -0400
Received: from mail.loongson.cn ([114.242.206.163]:46056 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2438243AbgE2BAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 21:00:08 -0400
Received: from [10.20.42.25] (unknown [10.20.42.25])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxz2lzXtBekXs6AA--.1668S3;
        Fri, 29 May 2020 08:59:32 +0800 (CST)
Subject: Re: [PATCH v7 2/4] mm/memory.c: Update local TLB if PTE entry exists
To:     Andrew Morton <akpm@linux-foundation.org>
References: <1590546320-21814-1-git-send-email-maobibo@loongson.cn>
 <1590546320-21814-3-git-send-email-maobibo@loongson.cn>
 <20200528122342.11e51dd9c7698d68632f2a81@linux-foundation.org>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paulburton@kernel.org>,
        Dmitry Korotin <dkorotin@wavecomp.com>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
        Stafford Horne <shorne@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "Maciej W. Rozycki" <macro@wdc.com>, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>
From:   maobibo <maobibo@loongson.cn>
Message-ID: <b577bca0-4218-12e6-d63f-0d12cb0a60f9@loongson.cn>
Date:   Fri, 29 May 2020 08:59:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20200528122342.11e51dd9c7698d68632f2a81@linux-foundation.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dxz2lzXtBekXs6AA--.1668S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww4kKr1fXrWfuFyDCw18Grg_yoW8GFWkpa
        yfAan8ta1Ivr45Ar4xX3WDur4rZ3WFqFZ7try0krWjka9xKw4fK3y3Cayvvr4UAFn3WFnI
        qF4jqFWrZanrZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvEb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xK
        xwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
        1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
        b7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
        vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73UjIFyTuYvjxUg0D7DUUUU
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/29/2020 03:23 AM, Andrew Morton wrote:
> On Wed, 27 May 2020 10:25:18 +0800 Bibo Mao <maobibo@loongson.cn> wrote:
> 
>> If two threads concurrently fault at the same page, the thread that
>> won the race updates the PTE and its local TLB. For now, the other
>> thread gives up, simply does nothing, and continues.
>>
>> It could happen that this second thread triggers another fault, whereby
>> it only updates its local TLB while handling the fault. Instead of
>> triggering another fault, let's directly update the local TLB of the
>> second thread. Function update_mmu_tlb is used here to update local
>> TLB on the second thread, and it is defined as empty on other arches.
>>
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -2752,6 +2752,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>>  		new_page = old_page;
>>  		page_copied = 1;
>>  	} else {
>> +		update_mmu_tlb(vma, vmf->address, vmf->pte);
>>  		mem_cgroup_cancel_charge(new_page, memcg, false);
>>  	}
>>  
> 
> When applying your patches on top of the -mm tree's changes, the above
> hunk didn't apply.  The entire `else' block was removed by
> https://ozlabs.org/~akpm/mmotm/broken-out/mm-memcontrol-convert-anon-and-file-thp-to-new-mem_cgroup_charge-api.patch
> 
> I assumed that dropping this hunk was appropriate.  Please check?
yes, that is appropriate. Sorry to bother you, originally I should format the
patch based on mm-tree.

