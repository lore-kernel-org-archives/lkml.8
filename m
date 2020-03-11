Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E209C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E651C208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbgCKMkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 08:40:09 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:23511 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729383AbgCKMkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 08:40:08 -0400
X-IronPort-AV: E=Sophos;i="5.70,540,1574092800"; 
   d="scan'208";a="86170022"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Mar 2020 20:39:37 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id E669850A9980;
        Wed, 11 Mar 2020 20:29:38 +0800 (CST)
Received: from [10.167.226.60] (10.167.226.60) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Wed, 11 Mar 2020 20:39:35 +0800
Subject: Re: Is this code chunk in init_apic_mappings() superfluous?
To:     Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
CC:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
References: <978293b9-8e9f-55f6-6ec4-e2d66c4db0de@cn.fujitsu.com>
 <87imjg9zgp.fsf@nanos.tec.linutronix.de>
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <3859d094-676d-7e17-0655-9d0091a0d47c@cn.fujitsu.com>
Date:   Wed, 11 Mar 2020 20:39:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87imjg9zgp.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.60]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: E669850A9980.A881E
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/20 7:27 PM, Thomas Gleixner wrote:
> Cao jin <caoj.fnst@cn.fujitsu.com> writes:
>> Hi,
>>
>> I am trying to figure the following code chunk out:
>>
>> 	if (x2apic_mode) {
>> 		boot_cpu_physical_apicid = read_apic_id();
>> 		return;
>> 	}
>>
>> As my understanding, even in x2APIC mode, boot_cpu_physical_apicid is
>> also got via early_acpi_process_madt --> ... --> register_lapic_address,
>> so, is it for any corner case I am not aware?
> 
> The case when there are neither ACPI nor valid mptables. Unlikely, but
> possible in theory.
> 

I noticed this case in its calling comments, but failed to associate it
with a x2APIC...

So init_apic_mapping() is for 2 corner cases that doesn't map APIC
register before: one you mentioned here, and MP default configuration
the other.

Thanks Thomas.

-- 
Sincerely,
Cao jin


