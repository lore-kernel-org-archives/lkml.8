Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F23C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1122820704
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u+RDQPE1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388295AbgEZQS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 12:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728280AbgEZQS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 12:18:57 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88019C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 09:18:57 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 23so10371373pfy.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 09:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iSh71IsMqjVcHLkoit8W8c+kNI1QUMO+CiEGYra3TPc=;
        b=u+RDQPE1BrJiZ0y/2neMhWm2dV7NaP3cvNkfgME6XRBnj8eJ7YKKKlGezZW2eptPVw
         nKXaVyE/pmMezs+5f10wefnn6McnYQR2RJ8itImtsDIG7LRu9aoQw4qohRv66XPn1Rxq
         RgKbFNAJ/N7WirvozWWW0JYRQy25n67JZWGTJlyVEIbg2hv5az8XR6N+9fIc1Aqvtm8U
         XGWfW82cVwcGnHDRytgNNsl5abskbCsNM52ZyvSwo9i2OYUJzEGDEv1oHJjfYqhipO8I
         a/0OCjSTpQH7yokwGG0whMMzWzyiiRfLI5XM+uovDiy9GLE/TDw1HssAwa4O8tzvi9rd
         0VRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=iSh71IsMqjVcHLkoit8W8c+kNI1QUMO+CiEGYra3TPc=;
        b=Sf8afXKgtnc3flktU2mjk1cJDZ7bf16H2Kwz8di7QX8Ay0TYM5R//06rfgPYOuQFAm
         sw8eyYAFnAvDaaPOzie7vObqxjIK2n2TJFpaPC7kb/oYT0sQg9fmlx1+YW+oNp3BpAc/
         kXlaF8gJhej+HH6f6tB5O7Ec0xh8Oxb3bcmTPdDPZtUE1sqLsfehPKHfTYy/aQAmAs5K
         OZo+VnjVLott5YMQnvfK6QK7+Vb9vCLtxevBCUTFWZljEJs8tBeH1Jx/n3Ch/L6Hne/C
         DiZr4wi4dUViZ6ps5XKIZAPi6CNQuiFYbtE/p2FLDte1vyXn8PcAe7e8X58qd6SKA1no
         Mn2A==
X-Gm-Message-State: AOAM530NVoHcysYj6I8+mey6GUTmsoQts6JW2/OjNUCGknBI3/i5cR08
        afeMEJBbmvQ2xbIFcyehoXIxxHc6
X-Google-Smtp-Source: ABdhPJye2lIBq7qqxB+0rvraRxnxce4TqR2kibTrka0xkmN+Vbuvb4hEayuK7eUN9Jh4laHNzEgzgA==
X-Received: by 2002:a63:5c4c:: with SMTP id n12mr1819826pgm.320.1590509936993;
        Tue, 26 May 2020 09:18:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q44sm72118pja.29.2020.05.26.09.18.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 09:18:56 -0700 (PDT)
Subject: Re: [PATCH v5 04/18] sparc32: mm: Reduce allocation size for PMD and
 PTE tables
To:     Will Deacon <will@kernel.org>, Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, elver@google.com, tglx@linutronix.de,
        paulmck@kernel.org, mingo@kernel.org, peterz@infradead.org,
        "David S. Miller" <davem@davemloft.net>
References: <20200511204150.27858-5-will@kernel.org>
 <20200517000050.GA87467@roeck-us.net> <20200517000750.GA157503@roeck-us.net>
 <20200518083715.GA31383@willie-the-truck>
 <20200520170306.GG1118872@kernel.org>
 <6034a1b5-d4f6-c836-142c-9b3b06db3246@roeck-us.net>
 <20200520195110.GH1118872@kernel.org>
 <c80c04a4-75d0-6a47-3813-dea9325b6623@roeck-us.net>
 <20200524123256.GN1118872@kernel.org>
 <20200526132634.GC27166@willie-the-truck>
 <20200526140126.GD27166@willie-the-truck>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <b75f988a-a132-cf05-cbd6-8b00e4bbcc3c@roeck-us.net>
Date:   Tue, 26 May 2020 09:18:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200526140126.GD27166@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/20 7:01 AM, Will Deacon wrote:
> On Tue, May 26, 2020 at 02:26:35PM +0100, Will Deacon wrote:
>> On Sun, May 24, 2020 at 03:32:56PM +0300, Mike Rapoport wrote:
>>> On Thu, May 21, 2020 at 04:02:11PM -0700, Guenter Roeck wrote:
>>>> On 5/20/20 12:51 PM, Mike Rapoport wrote:
>>>>> On Wed, May 20, 2020 at 12:03:31PM -0700, Guenter Roeck wrote:
>>>>>> With above patch applied on top of Ira's patch, I get:
>>>>>>
>>>>>> BUG: spinlock recursion on CPU#0, S01syslogd/139
>>>>>>  lock: 0xf5448350, .magic: dead4ead, .owner: S01syslogd/139, .owner_cpu: 0
>>>>>> CPU: 0 PID: 139 Comm: S01syslogd Not tainted 5.7.0-rc6-next-20200518-00002-gb178d2d56f29-dirty #1
>>>>>> [f0067a64 :
>>>>>> do_raw_spin_lock+0xa8/0xd8 ]
>>>>>> [f00d5034 :
>>>>>> copy_page_range+0x328/0x804 ]
>>>>>> [f0025be4 :
>>>>>> dup_mm+0x334/0x434 ]
>>>>>> [f0027124 :
>>>>>> copy_process+0x1224/0x12b0 ]
>>>>>> [f0027344 :
>>>>>> _do_fork+0x54/0x30c ]
>>>>>> [f0027670 :
>>>>>> do_fork+0x5c/0x6c ]
>>>>>> [f000de44 :
>>>>>> sparc_do_fork+0x18/0x38 ]
>>>>>> [f000b7f4 :
>>>>>> do_syscall+0x34/0x40 ]
>>>>>> [5010cd4c :
>>>>>> 0x5010cd4c ]
>>>>>>
>>>>>> Looks like yet another problem.
>>>>>
>>>>> I've checked the patch above on top of the mmots which already has Ira's
>>>>> patches and it booted fine. I've used sparc32_defconfig to build the
>>>>> kernel and qemu-system-sparc with default machine and CPU. 
>>>>>
>>>>
>>>> Try sparc32_defconfig+SMP.
>>>  
>>> I see a differernt problem, but this could be related:
>>>
>>> INIT: version 2.86 booting
>>> rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
>>> 	(detected by 0, t=5252 jiffies, g=-935, q=3)
>>> rcu: All QSes seen, last rcu_sched kthread activity 5252 (-68674--73926), jiffies_till_next_fqs=1, root ->qsmask 0x0
>>> rcu: rcu_sched kthread starved for 5252 jiffies! g-935 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
>>> rcu: 	Unless rcu_sched kthread gets sufficient CPU time, OOM is now expected behavior.
>>> rcu: RCU grace-period kthread stack dump:
>>> rcu_sched       R  running task        0    10      2 0x00000000
>>>
>>> I'm running a bit old debian [1] with qemu-img-sparc.
>>>
>>> My bisect pointed at commit 8c8f3156dd40 ("sparc32: mm: Reduce
>>> allocation size for PMD and PTE tables"). The commit ID is valid for
>>> next-20200522.
>>
>> Can you try the diff below please?
> 
> Actually, that's racy. New version below!
> 

Applied on top of next-20200526, with defconfig+SMP, I still get:

BUG: Bad page state in process swapper/0  pfn:0069f

many times. Did I have to revert something else ? Sorry, I lost track.


Note that "-smp 2" on SS-10 works for me (with the same page state
messages).

Guenter


> Will
> 
> --->8
> 
> diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
> index c861c0f0df73..068029471aa4 100644
> --- a/arch/sparc/mm/srmmu.c
> +++ b/arch/sparc/mm/srmmu.c
> @@ -363,11 +363,16 @@ pgtable_t pte_alloc_one(struct mm_struct *mm)
>  
>  	if ((ptep = pte_alloc_one_kernel(mm)) == 0)
>  		return NULL;
> +
>  	page = pfn_to_page(__nocache_pa((unsigned long)ptep) >> PAGE_SHIFT);
> -	if (!pgtable_pte_page_ctor(page)) {
> -		__free_page(page);
> -		return NULL;
> +
> +	spin_lock(&mm->page_table_lock);
> +	if (page_ref_inc_return(page) == 2 && !pgtable_pte_page_ctor(page)) {
> +		page_ref_dec(page);
> +		ptep = NULL;
>  	}
> +	spin_unlock(&mm->page_table_lock);
> +
>  	return ptep;
>  }
>  
> @@ -376,7 +381,12 @@ void pte_free(struct mm_struct *mm, pgtable_t ptep)
>  	struct page *page;
>  
>  	page = pfn_to_page(__nocache_pa((unsigned long)ptep) >> PAGE_SHIFT);
> -	pgtable_pte_page_dtor(page);
> +
> +	spin_lock(&mm->page_table_lock);
> +	if (page_ref_dec_return(page) == 1)
> +		pgtable_pte_page_dtor(page);
> +	spin_unlock(&mm->page_table_lock);
> +
>  	srmmu_free_nocache(ptep, SRMMU_PTE_TABLE_SIZE);
>  }
>  
> diff --git a/mm/Kconfig b/mm/Kconfig
> index c1acc34c1c35..97458119cce8 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -192,6 +192,9 @@ config MEMORY_HOTREMOVE
>  # Default to 4 for wider testing, though 8 might be more appropriate.
>  # ARM's adjust_pte (unused if VIPT) depends on mm-wide page_table_lock.
>  # PA-RISC 7xxx's spinlock_t would enlarge struct page from 32 to 44 bytes.
> +# SPARC32 allocates multiple pte tables within a single page, and therefore
> +# a per-page lock leads to problems when multiple tables need to be locked
> +# at the same time (e.g. copy_page_range()).
>  # DEBUG_SPINLOCK and DEBUG_LOCK_ALLOC spinlock_t also enlarge struct page.
>  #
>  config SPLIT_PTLOCK_CPUS
> @@ -199,6 +202,7 @@ config SPLIT_PTLOCK_CPUS
>  	default "999999" if !MMU
>  	default "999999" if ARM && !CPU_CACHE_VIPT
>  	default "999999" if PARISC && !PA20
> +	default "999999" if SPARC32
>  	default "4"
>  
>  config ARCH_ENABLE_SPLIT_PMD_PTLOCK
> 

