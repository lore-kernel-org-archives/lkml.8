Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554C3C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 08:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16EC124672
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 08:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pg7IadZw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgB0IwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 03:52:05 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:50998 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbgB0IwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 03:52:04 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01R8ljgF074508;
        Thu, 27 Feb 2020 08:51:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Avm4uDoVWH5SJRrA1He+tDsM14UgCPKubMerqVy+e8s=;
 b=pg7IadZwmxB8XYAg2XXAOy/MY8DV51+n5uxcX5MYZtCURYLaQuwGUuZSrqde4z1HxxyI
 7DimSfCtXTwBuorAKGY03GXtoomBK/E86mfD4MJxgciBxP+UVBPWCLVUvux+Dxy9ppOR
 n+5oRmGBBz1ZrQLZ6cvKIvBVgPNabi+dBgZQ3jm70eCVeVND1SIXhMpVBEOCpdIS/FBv
 qLwMBSrXPmg88SVRjkJ3R4wamUNjoCBqco50U3+rDUUdBs8wQz/KyaNTOhSNFiCz53L3
 TP1qWvqktCGGaxQbWIIUrGK/cSnqLNqlQD2Yffodkhk5U+OFkJlP1P+bf7DesPUdJjgV nA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2ydybckbv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Feb 2020 08:51:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01R8m6tR157043;
        Thu, 27 Feb 2020 08:51:37 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2ydj4kxnsu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Feb 2020 08:51:37 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01R8pTVF026045;
        Thu, 27 Feb 2020 08:51:33 GMT
Received: from [10.39.232.60] (/10.39.232.60)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Feb 2020 00:51:29 -0800
Subject: Re: [RFC PATCH v3 2/7] mm/asi: ASI entry/exit interface
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, x86@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, liran.alon@oracle.com,
        junaids@google.com, graf@amazon.de, rppt@linux.vnet.ibm.com,
        kuzuno@gmail.com, mgross@linux.intel.com
References: <1582734120-26757-1-git-send-email-alexandre.chartre@oracle.com>
 <1582734120-26757-3-git-send-email-alexandre.chartre@oracle.com>
 <20200226220202.GA28721@iweiny-DESK2.sc.intel.com>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Organization: Oracle Corporation
Message-ID: <efe7eb41-e23d-bf22-50f7-73f47bab4d5e@oracle.com>
Date:   Thu, 27 Feb 2020 09:51:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20200226220202.GA28721@iweiny-DESK2.sc.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002270071
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 phishscore=0 spamscore=0 clxscore=1011 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002270071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/26/20 11:02 PM, Ira Weiny wrote:
> On Wed, Feb 26, 2020 at 05:21:55PM +0100, Alexandre Chartre wrote:
>> Address Space Isolation (ASI) is entered by calling asi_enter() which
>> switches the kernel page-table to the ASI page-table. Isolation is then
>> exited by calling asi_exit() which switches the page-table back to the
>> original kernel page-table.
>>
>> The ASI being used and its state is tracked in a per-cpu ASI session
>> structure (struct asi_session).
>>
>> Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
>> ---
>>   arch/x86/include/asm/asi.h         |    4 ++
>>   arch/x86/include/asm/asi_session.h |   17 +++++++
>>   arch/x86/include/asm/mmu_context.h |   19 +++++++-
>>   arch/x86/include/asm/tlbflush.h    |   12 +++++
>>   arch/x86/mm/asi.c                  |   90 ++++++++++++++++++++++++++++++++++++
>>   5 files changed, 140 insertions(+), 2 deletions(-)
>>   create mode 100644 arch/x86/include/asm/asi_session.h
>>
>> diff --git a/arch/x86/include/asm/asi.h b/arch/x86/include/asm/asi.h
>> index 844a81f..29b745a 100644
>> --- a/arch/x86/include/asm/asi.h
>> +++ b/arch/x86/include/asm/asi.h
>> @@ -44,6 +44,8 @@
>>   
>>   #include <linux/export.h>
>>   
>> +#include <asm/asi_session.h>
>> +
>>   struct asi_type {
>>   	int			pcid_prefix;	/* PCID prefix */
>>   };
>> @@ -80,6 +82,8 @@ struct asi {
>>   extern struct asi *asi_create(struct asi_type *type);
>>   extern void asi_destroy(struct asi *asi);
>>   extern void asi_set_pagetable(struct asi *asi, pgd_t *pagetable);
>> +extern int asi_enter(struct asi *asi);
>> +extern void asi_exit(struct asi *asi);
>>   
>>   #endif	/* __ASSEMBLY__ */
>>   
>> diff --git a/arch/x86/include/asm/asi_session.h b/arch/x86/include/asm/asi_session.h
>> new file mode 100644
>> index 0000000..9d39c93
>> --- /dev/null
>> +++ b/arch/x86/include/asm/asi_session.h
>> @@ -0,0 +1,17 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef ARCH_X86_MM_ASI_SESSION_H
>> +#define ARCH_X86_MM_ASI_SESSION_H
>> +
>> +#ifdef CONFIG_ADDRESS_SPACE_ISOLATION
>> +
>> +struct asi;
>> +
>> +struct asi_session {
>> +	struct asi		*asi;		/* ASI for this session */
>> +	unsigned long		isolation_cr3;	/* cr3 when ASI is active */
>> +	unsigned long		original_cr3;	/* cr3 before entering ASI */
>> +};
>> +
>> +#endif	/* CONFIG_ADDRESS_SPACE_ISOLATION */
>> +
>> +#endif
>> diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
>> index 5f33924..2d65443 100644
>> --- a/arch/x86/include/asm/mmu_context.h
>> +++ b/arch/x86/include/asm/mmu_context.h
>> @@ -14,6 +14,7 @@
>>   #include <asm/paravirt.h>
>>   #include <asm/mpx.h>
>>   #include <asm/debugreg.h>
>> +#include <asm/asi.h>
>>   
>>   extern atomic64_t last_mm_ctx_id;
>>   
>> @@ -349,8 +350,22 @@ static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
>>    */
>>   static inline unsigned long __get_current_cr3_fast(void)
>>   {
>> -	unsigned long cr3 = build_cr3(this_cpu_read(cpu_tlbstate.loaded_mm)->pgd,
>> -		this_cpu_read(cpu_tlbstate.loaded_mm_asid));
>> +	unsigned long cr3;
>> +
>> +	/*
>> +	 * If isolation is active then we need to return the CR3 for the
>> +	 * currently active ASI. This value is stored in the isolation_cr3
>> +	 * field of the ASI session.
>> +	 */
>> +	if (IS_ENABLED(CONFIG_ADDRESS_SPACE_ISOLATION) &&
>> +	    this_cpu_read(cpu_asi_session.asi)) {
>> +		cr3 = this_cpu_read(cpu_asi_session.isolation_cr3);
>> +		/* CR3 read never returns with the NOFLUSH bit */
>> +		cr3 &= ~X86_CR3_PCID_NOFLUSH;
>> +	} else {
>> +		cr3 = build_cr3(this_cpu_read(cpu_tlbstate.loaded_mm)->pgd,
>> +				this_cpu_read(cpu_tlbstate.loaded_mm_asid));
>> +	}
>>   
>>   	/* For now, be very restrictive about when this can be called. */
>>   	VM_WARN_ON(in_nmi() || preemptible());
>> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
>> index 6f66d84..241058f 100644
>> --- a/arch/x86/include/asm/tlbflush.h
>> +++ b/arch/x86/include/asm/tlbflush.h
>> @@ -12,6 +12,7 @@
>>   #include <asm/invpcid.h>
>>   #include <asm/pti.h>
>>   #include <asm/processor-flags.h>
>> +#include <asm/asi.h>
>>   
>>   /*
>>    * The x86 feature is called PCID (Process Context IDentifier). It is similar
>> @@ -239,9 +240,20 @@ struct tlb_state {
>>   	 * context 0.
>>   	 */
>>   	struct tlb_context ctxs[TLB_NR_DYN_ASIDS];
>> +
>> +#ifdef CONFIG_ADDRESS_SPACE_ISOLATION
>> +	/*
>> +	 * The ASI session tracks the ASI being used and its state.
>> +	 */
>> +	struct asi_session asi_session;
>> +#endif
>>   };
>>   DECLARE_PER_CPU_SHARED_ALIGNED(struct tlb_state, cpu_tlbstate);
>>   
>> +#ifdef CONFIG_ADDRESS_SPACE_ISOLATION
>> +#define cpu_asi_session	(cpu_tlbstate.asi_session)
>> +#endif
>> +
>>   /*
>>    * Blindly accessing user memory from NMI context can be dangerous
>>    * if we're in the middle of switching the current user task or
>> diff --git a/arch/x86/mm/asi.c b/arch/x86/mm/asi.c
>> index 0a0ac9d..9fbc921 100644
>> --- a/arch/x86/mm/asi.c
>> +++ b/arch/x86/mm/asi.c
>> @@ -10,6 +10,8 @@
>>   
>>   #include <asm/asi.h>
>>   #include <asm/bug.h>
>> +#include <asm/mmu_context.h>
>> +#include <asm/tlbflush.h>
>>   
>>   struct asi *asi_create(struct asi_type *type)
>>   {
>> @@ -58,3 +60,91 @@ void asi_set_pagetable(struct asi *asi, pgd_t *pagetable)
>>   
>>   }
>>   EXPORT_SYMBOL(asi_set_pagetable);
>> +
>> +static void asi_switch_to_asi_cr3(struct asi *asi)
>> +{
>> +	unsigned long original_cr3, asi_cr3;
>> +	struct asi_session *asi_session;
>> +	u16 pcid;
>> +
>> +	WARN_ON(!irqs_disabled());
>> +
>> +	original_cr3 = __get_current_cr3_fast();
>> +
>> +	/* build the ASI cr3 value */
>> +	asi_cr3 = asi->base_cr3;
>> +	if (boot_cpu_has(X86_FEATURE_PCID)) {
>> +		pcid = original_cr3 & ASI_KERNEL_PCID_MASK;
>> +		asi_cr3 |= pcid;
>> +	}
>> +
>> +	/* get the ASI session ready for entering ASI */
>> +	asi_session = &get_cpu_var(cpu_asi_session);
>> +	asi_session->asi = asi;
>> +	asi_session->original_cr3 = original_cr3;
>> +	asi_session->isolation_cr3 = asi_cr3;
>> +
>> +	/* Update CR3 to immediately enter ASI */
>> +	native_write_cr3(asi_cr3);
>> +}
>> +
>> +static void asi_switch_to_kernel_cr3(struct asi *asi)
> 
> asi is not used in this function?
> 

You are right, I was probably using it in a previous version of the code
and forgot to remote it. I will remove it.
  

>> +{
>> +	struct asi_session *asi_session;
>> +	unsigned long original_cr3;
>> +
>> +	WARN_ON(!irqs_disabled());
>> +
>> +	original_cr3 = this_cpu_read(cpu_asi_session.original_cr3);
>> +	if (boot_cpu_has(X86_FEATURE_PCID))
>> +		original_cr3 |= X86_CR3_PCID_NOFLUSH;
>> +	native_write_cr3(original_cr3);
>> +
>> +	asi_session = &get_cpu_var(cpu_asi_session);
>> +	asi_session->asi = NULL;
>> +}
>> +
>> +int asi_enter(struct asi *asi)
>> +{
>> +	struct asi *current_asi;
>> +	unsigned long flags;
>> +
>> +	/*
>> +	 * We can re-enter isolation, but only with the same ASI (we don't
>> +	 * support nesting isolation).
>> +	 */
>> +	current_asi = this_cpu_read(cpu_asi_session.asi);
>> +	if (current_asi) {
>> +		if (current_asi != asi) {
>> +			WARN_ON(1);
>> +			return -EBUSY;
>> +		}
> 
> if (WARN_ON(current_asi != asi)) {
> 	return -EBUSY;
> 

Yes, much better, will change.

Thanks,

alex.

> 
>> +		return 0;
>> +	}
>> +
>> +	local_irq_save(flags);
>> +	asi_switch_to_asi_cr3(asi);
>> +	local_irq_restore(flags);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(asi_enter);
>> +
>> +void asi_exit(struct asi *asi)
>> +{
>> +	struct asi *current_asi;
>> +	unsigned long flags;
>> +
>> +	current_asi = this_cpu_read(cpu_asi_session.asi);
>> +	if (!current_asi) {
>> +		/* already exited */
>> +		return;
>> +	}
>> +
>> +	WARN_ON(current_asi != asi);
>> +
>> +	local_irq_save(flags);
>> +	asi_switch_to_kernel_cr3(asi);
>> +	local_irq_restore(flags);
>> +}
>> +EXPORT_SYMBOL(asi_exit);
>> -- 
>> 1.7.1
>>
>>
> 
