Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B8AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 10:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79DB620776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 10:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731959AbgEZKls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 06:41:48 -0400
Received: from foss.arm.com ([217.140.110.172]:48908 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731882AbgEZKlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 06:41:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BE771FB;
        Tue, 26 May 2020 03:41:46 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0C5E3F52E;
        Tue, 26 May 2020 03:41:43 -0700 (PDT)
Subject: Re: [PATCH 1/2] x86: mm: ptdump: Calculate effective permissions
 correctly
To:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Jan Beulich <jbeulich@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20200521152308.33096-1-steven.price@arm.com>
 <20200521152308.33096-2-steven.price@arm.com>
 <20200522180741.GB1337@Qians-MacBook-Air.local>
From:   Steven Price <steven.price@arm.com>
Message-ID: <430c8ab4-e7cd-6933-dde6-087fac6db872@arm.com>
Date:   Tue, 26 May 2020 11:41:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200522180741.GB1337@Qians-MacBook-Air.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/2020 19:07, Qian Cai wrote:
> On Thu, May 21, 2020 at 04:23:07PM +0100, Steven Price wrote:
>> --- a/arch/x86/mm/dump_pagetables.c
>> +++ b/arch/x86/mm/dump_pagetables.c
>> @@ -249,10 +249,22 @@ static void note_wx(struct pg_state *st, unsigned long addr)
>> @@ -270,16 +282,10 @@ static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
>>   	struct seq_file *m = st->seq;
>>   
>>   	new_prot = val & PTE_FLAGS_MASK;
>> +	new_eff = st->prot_levels[level];
> 
> This will trigger,
> 
> .config (if ever matters):
> https://raw.githubusercontent.com/cailca/linux-mm/master/x86.config
> 
> [  104.532621] UBSAN: array-index-out-of-bounds in arch/x86/mm/dump_pagetables.c:284:27
> [  104.542620] index -1 is out of range for type 'pgprotval_t [5]'

Doh! In this case the result (new_eff) is never actually used: the -1 is 
used just to flush the last proper entry out, so in this case val == 0 
which means the following statement sets new_eff = 0. But obviously an 
out-of-bounds access isn't great. Thanks for testing!

The following patch should fix it up by making the assignment 
conditional on val != 0.

Andrew: Would you like me to resend, or can you squash in the below?

Steve

-----8<----
diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index 17aa7ac94a34..ea9010113f69 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -282,10 +282,10 @@ static void note_page(struct ptdump_state *pt_st, 
unsigned long addr, int level,
  	struct seq_file *m = st->seq;

  	new_prot = val & PTE_FLAGS_MASK;
-	new_eff = st->prot_levels[level];
-
  	if (!val)
  		new_eff = 0;
+	else
+		new_eff = st->prot_levels[level];

  	/*
  	 * If we have a "break" in the series, we need to flush the state that
