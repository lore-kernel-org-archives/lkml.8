Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8297FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 21:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62E392074B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 21:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgFHVxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 17:53:01 -0400
Received: from mga06.intel.com ([134.134.136.31]:47521 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbgFHVxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 17:53:01 -0400
IronPort-SDR: 64ruKFBk/CltDJ3xLHq5R978XiZ3yU0lJ9iBgE1pv1C0KJnMXtNMsCqvCQDNCwl7NysnTnuJza
 R/YzNN+hfCKg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2020 14:53:00 -0700
IronPort-SDR: INttxgPbkxeUDgWEefG3ii9OGOMcjk3i2XPkXbPEOauIdyqQMO+JUxP+8sWUYPDayfiXeSyGVe
 PT3NKC5+w9NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,489,1583222400"; 
   d="scan'208";a="306073139"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga008.jf.intel.com with ESMTP; 08 Jun 2020 14:53:00 -0700
Date:   Mon, 8 Jun 2020 14:53:15 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Brendan Shanks <bshanks@codeweavers.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, ebiederm@xmission.com,
        andi@notmuch.email, Babu.Moger@amd.com
Subject: Re: [PATCH v2] x86/umip: Add emulation/spoofing for SLDT and STR
 instructions
Message-ID: <20200608215315.GB23567@ranerica-svr.sc.intel.com>
References: <20200608181454.14210-1-bshanks@codeweavers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608181454.14210-1-bshanks@codeweavers.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 11:14:54AM -0700, Brendan Shanks wrote:
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
> v2: Return (GDT_ENTRY_LDT * 8) for SLDT when an LDT is set.
> 
>  arch/x86/kernel/umip.c | 34 +++++++++++++++++++++++++---------
>  1 file changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
> index 8d5cbe1bbb3b..a85f0b0ec2b9 100644
> --- a/arch/x86/kernel/umip.c
> +++ b/arch/x86/kernel/umip.c
> @@ -64,6 +64,8 @@
>  #define UMIP_DUMMY_GDT_BASE 0xfffffffffffe0000ULL
>  #define UMIP_DUMMY_IDT_BASE 0xffffffffffff0000ULL
>  
> +#define UMIP_DUMMY_TASK_REGISTER_SELECTOR 0x40

One more thing. How was this value selected? Would it be possible to use
GDT_ENTRY_TSS*8? Linux already uses this value.

Thanks and BR,
Ricardo
 
