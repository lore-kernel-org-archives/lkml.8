Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFF6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F990206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731520AbgFIAic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:38:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:64028 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729217AbgFIAh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 20:37:58 -0400
IronPort-SDR: H1Hmc7MDwOZ2/hkuXqqvRN5Wmqh1tPw+Flcx/7GrdEUrXToCau0M1eWgGkx7VEyRZzal71oLfD
 xE4MtXMIUg6g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2020 17:37:58 -0700
IronPort-SDR: p2oalkKzEMvdouJNti5J7BEPx5+c7jbkBE4nwQ9ipUiDR01a+CT8w1l0g7rz8F2ZaJhyJUfyMs
 55AqaSuuyXzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,489,1583222400"; 
   d="scan'208";a="472894832"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga005.fm.intel.com with ESMTP; 08 Jun 2020 17:37:58 -0700
Date:   Mon, 8 Jun 2020 17:38:12 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Brendan Shanks <bshanks@codeweavers.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, ebiederm@xmission.com,
        andi@notmuch.email, Babu.Moger@amd.com
Subject: Re: [PATCH v3] x86/umip: Add emulation/spoofing for SLDT and STR
 instructions
Message-ID: <20200609003812.GA26268@ranerica-svr.sc.intel.com>
References: <20200608224424.7259-1-bshanks@codeweavers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608224424.7259-1-bshanks@codeweavers.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 03:44:24PM -0700, Brendan Shanks wrote:
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
> 
> v3: Use (GDT_ENTRY_TSS * 8) for task register selector instead of
> harcoding 0x40.
> 
>  arch/x86/kernel/umip.c | 32 +++++++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
> index 8d5cbe1bbb3b..166c579b0273 100644
> --- a/arch/x86/kernel/umip.c
> +++ b/arch/x86/kernel/umip.c
> @@ -244,16 +244,35 @@ static int emulate_umip_insn(struct insn *insn, int umip_inst,
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
> +			dummy_value = GDT_ENTRY_TSS * 8;
> +		else if (umip_inst == UMIP_INST_SLDT)
> +		{

This brace should go in the previous line. Also, if you use braces in
the last part of the conditional you should probably use them in the
previous ones. I guess in this case it woudln't improve readability.
Instead, you can probably have a switch instead of the three ifs. That
probably does improve readability and solves the dilemma of needing to
put braces in all the one-line conditionals.

BTW, you should also delete the comment at the top of the file saying
that str and sldt will not be emulated:

diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
index 166c579b0273..0984a55eb8c0 100644
--- a/arch/x86/kernel/umip.c
+++ b/arch/x86/kernel/umip.c
@@ -45,9 +45,6 @@
  * value that, lies close to the top of the kernel memory. The limit for the GDT
  * and the IDT are set to zero.
  *
- * Given that SLDT and STR are not commonly used in programs that run on WineHQ
- * or DOSEMU2, they are not emulated.
- *
  * The instruction smsw is emulated to return the value that the register CR0
  * has at boot time as set in the head_32.
  *

Thanks and BR,
Ricardo
