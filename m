Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0585AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 00:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3AA0206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 00:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgFJAM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 20:12:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:44463 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbgFJAM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 20:12:57 -0400
IronPort-SDR: kSYsqH3W6hayqi70e0T6Zx55UjnggGJ0nlhFdwzr6+MR9CPOJ81IHPhqsr7jm1vWa3vSQ+G4p3
 ajwkiW7tqJ2Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 17:12:57 -0700
IronPort-SDR: QedeotHzgzWVQLwHRxGMRasI1cjy27kXs+Ra5lTiZAiIL0fYzjcNDfW6FwS9A/bgJRLa26neoF
 qNmadWo9oTKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,493,1583222400"; 
   d="scan'208";a="418566432"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga004.jf.intel.com with ESMTP; 09 Jun 2020 17:12:56 -0700
Date:   Tue, 9 Jun 2020 17:13:10 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Brendan Shanks <bshanks@codeweavers.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, ebiederm@xmission.com,
        andi@notmuch.email, Babu.Moger@amd.com
Subject: Re: [PATCH v4] x86/umip: Add emulation/spoofing for SLDT and STR
 instructions
Message-ID: <20200610001310.GA20597@ranerica-svr.sc.intel.com>
References: <20200609175423.31568-1-bshanks@codeweavers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609175423.31568-1-bshanks@codeweavers.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 10:54:23AM -0700, Brendan Shanks wrote:
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
> v4: Use braces for every clause of the conditional. I tried a switch(),
> but it takes more lines and looks more cluttered (especially with the
> #ifdef).
> Also replace out-of-date comment at top of file.
> 
>  arch/x86/kernel/umip.c | 38 ++++++++++++++++++++++++++------------
>  1 file changed, 26 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
> index 8d5cbe1bbb3b..62f4f0afb979 100644
> --- a/arch/x86/kernel/umip.c
> +++ b/arch/x86/kernel/umip.c
> @@ -45,11 +45,12 @@
>   * value that, lies close to the top of the kernel memory. The limit for the GDT
>   * and the IDT are set to zero.
>   *
> - * Given that SLDT and STR are not commonly used in programs that run on WineHQ
> - * or DOSEMU2, they are not emulated.
> - *
>   * The instruction smsw is emulated to return the value that the register CR0
>   * has at boot time as set in the head_32.
> + * sldt and str are emulated to return the values that the kernel programmatically
> + * assigns:
> + * - sldt returns (GDT_ENTRY_LDT * 8) if an LDT has been set, 0 if not.
> + * - str returns (GDT_ENTRY_TSS * 8).

Probably for consistency with the rest of the document the instruction
names should be capitalized (I know that smsw was not capitalized before
:/). Maybe maintainers can fix this when applying?

Other than that, FWIW:

Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Tested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
