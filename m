Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B5FC3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2985A2469F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgB1Pay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:30:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:35016 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbgB1Pay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:30:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5ABD8AD11;
        Fri, 28 Feb 2020 15:30:52 +0000 (UTC)
Subject: Re: [PATCH] x86/mm: fix dump_pagetables with Xen PV
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20200221103851.7855-1-jgross@suse.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <0c2ebf01-e8a0-568d-ec0e-366ed37c1b3b@suse.com>
Date:   Fri, 28 Feb 2020 16:30:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200221103851.7855-1-jgross@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping...

On 21.02.20 11:38, Juergen Gross wrote:
> Commit 2ae27137b2db89 ("x86: mm: convert dump_pagetables to use
> walk_page_range") broke Xen PV guests as the hypervisor reserved hole
> in the memory map was not taken into account.
> 
> Fix that by starting the kernel range only at GUARD_HOLE_END_ADDR.
> 
> Fixes: 2ae27137b2db89 ("x86: mm: convert dump_pagetables to use walk_page_range")
> Reported-by: Julien Grall <julien@xen.org>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>   arch/x86/mm/dump_pagetables.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
> index 64229dad7eab..69309cd56fdf 100644
> --- a/arch/x86/mm/dump_pagetables.c
> +++ b/arch/x86/mm/dump_pagetables.c
> @@ -363,13 +363,8 @@ static void ptdump_walk_pgd_level_core(struct seq_file *m,
>   {
>   	const struct ptdump_range ptdump_ranges[] = {
>   #ifdef CONFIG_X86_64
> -
> -#define normalize_addr_shift (64 - (__VIRTUAL_MASK_SHIFT + 1))
> -#define normalize_addr(u) ((signed long)((u) << normalize_addr_shift) >> \
> -			   normalize_addr_shift)
> -
>   	{0, PTRS_PER_PGD * PGD_LEVEL_MULT / 2},
> -	{normalize_addr(PTRS_PER_PGD * PGD_LEVEL_MULT / 2), ~0UL},
> +	{GUARD_HOLE_END_ADDR, ~0UL},
>   #else
>   	{0, ~0UL},
>   #endif
> 

