Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46EBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 00:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DC9B2067B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 00:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgFDAM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 20:12:26 -0400
Received: from mga01.intel.com ([192.55.52.88]:17980 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgFDAM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 20:12:26 -0400
IronPort-SDR: rykNK4llDOAaIrdT6GL/fjo2+08FyTLOCIHr+5QJxgCMur5SpdIv4wYnPnQcWued3wwX5uWszL
 gGZitSrnVLPQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 17:12:25 -0700
IronPort-SDR: vLKpQoiUNSz8CAkq+y/Z+ba6UdkKLP7XcEPAKUm++OYCjS/AT36sZnoj+kmjxIg29FJeaUauXC
 HKeH8BDefzHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,470,1583222400"; 
   d="scan'208";a="269244460"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga003.jf.intel.com with ESMTP; 03 Jun 2020 17:12:24 -0700
Date:   Wed, 3 Jun 2020 17:12:43 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Brendan Shanks <bshanks@codeweavers.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, ebiederm@xmission.com,
        andi@notmuch.email, Babu.Moger@amd.com
Subject: Re: [PATCH] x86/umip: Add emulation/spoofing for SLDT and STR
 instructions
Message-ID: <20200604001243.GA24742@ranerica-svr.sc.intel.com>
References: <20200602184212.10813-1-bshanks@codeweavers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602184212.10813-1-bshanks@codeweavers.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 11:42:12AM -0700, Brendan Shanks wrote:
> Add emulation/spoofing of SLDT and STR for both 32- and 64-bit
> processes.
> 
> Wine users have found a small number of Windows apps using SLDT that
> were crashing when run on UMIP-enabled systems.
> 
> Reported-by: Andreas Rammhold <andi@notmuch.email>
> Originally-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> Signed-off-by: Brendan Shanks <bshanks@codeweavers.com>
> ---
>  arch/x86/kernel/umip.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
> index 8d5cbe1bbb3b..59dfceac5cc0 100644
> --- a/arch/x86/kernel/umip.c
> +++ b/arch/x86/kernel/umip.c
> @@ -64,6 +64,8 @@
>  #define UMIP_DUMMY_GDT_BASE 0xfffffffffffe0000ULL
>  #define UMIP_DUMMY_IDT_BASE 0xffffffffffff0000ULL
>  
> +#define UMIP_DUMMY_TASK_REGISTER_SELECTOR 0x40
> +
>  /*
>   * The SGDT and SIDT instructions store the contents of the global descriptor
>   * table and interrupt table registers, respectively. The destination is a
> @@ -244,16 +246,24 @@ static int emulate_umip_insn(struct insn *insn, int umip_inst,
>  		*data_size += UMIP_GDT_IDT_LIMIT_SIZE;
>  		memcpy(data, &dummy_limit, UMIP_GDT_IDT_LIMIT_SIZE);
>  
> -	} else if (umip_inst == UMIP_INST_SMSW) {
> -		unsigned long dummy_value = CR0_STATE;
> +	} else if (umip_inst == UMIP_INST_SMSW || umip_inst == UMIP_INST_SLDT ||
> +		   umip_inst == UMIP_INST_STR) {
> +		unsigned long dummy_value;
> +
> +		if (umip_inst == UMIP_INST_SMSW)
> +			dummy_value = CR0_STATE;
> +		else if (umip_inst == UMIP_INST_STR)
> +			dummy_value = UMIP_DUMMY_TASK_REGISTER_SELECTOR;
> +		else
> +			dummy_value = 0;

Perhaps you can return a non-zero value for SLDT if it has an LDT, as
Andy had suggested. Maybe this can be implemented by looking at
current->mm->context.ldt

I guess the non-zero value can be (GDT_ENTRY_LDT*8).

Thanks and BR,
Ricardo
