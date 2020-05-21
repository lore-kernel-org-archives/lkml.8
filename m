Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C8DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 18:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93FD120DD4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 18:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Jw6jRG04"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbgEUSy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 14:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729092AbgEUSyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 14:54:25 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C503C061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 11:54:25 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id o19so6323828qtr.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 11:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cYMBhfpKSVpBIO/3+lowqB34JysColOLCRdaR1mrBas=;
        b=Jw6jRG04ZTc3jnB7F8CZZ7srm5Hdsy4j3GCjDHV4fjX4QkQLi2jShjsbLFam9I9suH
         v2sXZ4NhkhGjahiZAVkjxx7weX9JMp0UqxSkDYzj9ou6jHJU1ObGJ/J/6Xw/txzJC8bI
         i88QyPKqaTUXfq+v88TOAYWICYPktXxfhVBHXVnOlETyhPN4MGzt0hjK3q4jcIl58eUS
         Y/h8lPiIp2Lgvqi/cI7Wyie87niSwsSxVy+mCHpbxbY+5y9+A4uNXn/3Dm0Xe/asugFf
         X5CEHyG056fkOKjzw/l5PtHY2wy7xEtvAx9AxPNxPuGIGQGN0XW4O0owTuRvkYT3mni9
         hENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cYMBhfpKSVpBIO/3+lowqB34JysColOLCRdaR1mrBas=;
        b=MEs5e+AXHdb1wrRAQJ5FKA8N53mrwlPnGJxPWCdr/+hSsascuWGYA/P3HQmgru+cJW
         1mG3C4z3ueWD6r9U+/FX/bU4Cz+gwq1+lf8KQ7m6dxYNhlygpUpDdBNvSEkiwa1TDPV9
         /AgAXbwwLm1bsJ5CYrql1vV2C/S6kDMcUCO8UGBOmIxmf2TZ+QvxH2TmaMhPnL6zCiBP
         I8X4rfs4qDIKIy3ZUpO9Qoo/chwIHQS4TDPPrXJqVylKs2tXIw4dWB6jsYLyUuNm5QyF
         U0dHmuLAxcs/oUDJxf09d645k9+DeXcA3Gn4iQM3KVplZhPZqJu9LduGW+AD6tBAKiPc
         sprQ==
X-Gm-Message-State: AOAM533LRHtn/yobDX5IxeknFVdiUAdHEKknMwYi9DtxoUc1VNP+LMW1
        xizmxGD3YV2+o/t48jq3FIxnjA==
X-Google-Smtp-Source: ABdhPJyub1oqbKXoCve6QcB+m9SV7N6KXDDe72Zgd9l+tC8UaZ1kDZcF8xC5kAWWxATcklA0wfbUDQ==
X-Received: by 2002:ac8:340b:: with SMTP id u11mr12386650qtb.38.1590087262669;
        Thu, 21 May 2020 11:54:22 -0700 (PDT)
Received: from ovpn-112-192.phx2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id e28sm5519430qkn.17.2020.05.21.11.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 11:54:22 -0700 (PDT)
Date:   Thu, 21 May 2020 14:54:19 -0400
From:   Qian Cai <cai@lca.pw>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Zi Yan <ziy@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH mmotm] mm/vmstat: Add events for PMD based THP migration
 without split fix
Message-ID: <20200521185419.GB6367@ovpn-112-192.phx2.redhat.com>
References: <alpine.LSU.2.11.2005210643340.482@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2005210643340.482@eggly.anvils>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 06:49:51AM -0700, Hugh Dickins wrote:
> Fix 5.7-rc6-mm1 page migration crash in unmap_and_move(): when the
> page to be migrated has been freed from under us, that is considered 
> a MIGRATEPAGE_SUCCESS, but no newpage has been allocated (and I don't
> think it would ever need to be counted as a successful THP migration).
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
> Fix to mm-vmstat-add-events-for-pmd-based-thp-migration-without-split.patch
> 
>  mm/migrate.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- 5.7-rc6-mm1/mm/migrate.c	2020-05-20 12:21:56.117693827 -0700
> +++ linux/mm/migrate.c	2020-05-20 15:08:12.319476978 -0700
> @@ -1248,7 +1248,7 @@ out:
>  	 * we want to retry.
>  	 */
>  	if (rc == MIGRATEPAGE_SUCCESS) {
> -		if (PageTransHuge(newpage))
> +		if (newpage && PageTransHuge(newpage))

Should this be

if (!IS_ERR_OR_NULL(newpage) && PageTransHuge(newpage)) ?

I have also crashed here due to the buggy commit,

unmap_and_move() -> PageTransHuge(page) -> page->compound_head

but it said 0x00000008 instead of NULL which is aweful a lot like,

https://lore.kernel.org/linux-mm/20200512215813.GA487759@cmpxchg.org/

Interesting thing is I applied this patch and the problem went away, but not
sure if it could still be ERR_PTR sometimes just not always?

[  210.929981][ T4159] BUG: Kernel NULL pointer dereference on read at 0x00000008
[  210.930009][ T4159] Faulting instruction address: 0xc0000000005196c8
[  210.930027][   C61] irq event stamp: 270727
[  210.930028][ T4159] Oops: Kernel access of bad area, sig: 11 [#1]
[  210.930033][ T4159] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=256 DEBUG_PAGEALLOC NUMA PowerNV
[  210.930058][   C61] hardirqs last  enabled at (270726): [<c000000000adcc44>] _raw_spin_unlock_irqrestore+0x94/0xd0
[  210.930064][ T4159] Modules linked in: kvm_hv kvm ip_tables x_tables xfs sd_mod tg3 bnx2x libphy mdio firmware_class ahci libahci libata dm_mirror dm_region_hash dm_log dm_mod
[  210.930083][   C61] hardirqs last disabled at (270727): [<c000000000adc8dc>] _raw_spin_lock_irqsave+0x3c/0xa0
[  210.930086][   C61] softirqs last  enabled at (270556): [<c000000000addbdc>] __do_softirq+0x6dc/0xaa8
[  210.930125][ T4159] CPU: 109 PID: 4159 Comm: test.sh Not tainted 5.7.0-rc6-next-20200521+ #112
[  210.930163][   C61] softirqs last disabled at (270559): [<c000000000129544>] run_ksoftirqd+0x74/0xc0
[  210.930260][ T4159] NIP:  c0000000005196c8 LR: c000000000519568 CTR: 0000000000000000
[  210.930307][ T4159] REGS: c0002005b10af570 TRAP: 0300   Not tainted  (5.7.0-rc6-next-20200521+)
[  210.930342][ T4159] MSR:  900000000280b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 24248242  XER: 00000000
[  210.930403][ T4159] CFAR: c000000000519570 DAR: 0000000000000008 DSISR: 40000000 IRQMASK: 0 
[  210.930403][ T4159] GPR00: c000000000519568 c0002005b10af800 c000000001765500 0000000000000000 
[  210.930403][ T4159] GPR04: c000000001c18d28 0000000000000006 0000000035279396 fffffffef69809d2 
[  210.930403][ T4159] GPR08: 0000201cc6240000 0000000000000000 0000000000000000 0000000000000008 
[  210.930403][ T4159] GPR12: 0000000000008000 c000201fff670600 0000000000000000 c00c000805312a00 
[  210.930403][ T4159] GPR16: c00000000050b090 c000000000c857d0 c00c000805312a80 0000000000000000 
[  210.930403][ T4159] GPR20: 0000000000000001 0000000000000000 c0002005b10af978 c000201ffc7c8780 
[  210.930403][ T4159] GPR24: fffffffffffffff5 0000000000000002 0000000020000000 0000000000000000 
[  210.930403][ T4159] GPR28: 0000000000000007 0000000000000001 0000000000000000 c00c000805312a08 
[  210.930740][ T4159] NIP [c0000000005196c8] migrate_pages+0xc18/0x1ad0
[  210.930775][ T4159] LR [c000000000519568] migrate_pages+0xab8/0x1ad0
[  210.930824][ T4159] Call Trace:
[  210.930843][ T4159] [c0002005b10af800] [c000000000519568] migrate_pages+0xab8/0x1ad0 (unreliable)
[  210.930882][ T4159] [c0002005b10af910] [c00000000050b6fc] do_migrate_range+0x25c/0x8f0
[  210.930940][ T4159] [c0002005b10afa10] [c00000000050e974] __offline_pages+0x6e4/0x8b0
[  210.930988][ T4159] [c0002005b10afb40] [c000000000887f6c] memory_block_action+0xac/0xc0
[  210.931016][ T4159] [c0002005b10afba0] [c000000000888618] memory_subsys_offline+0x58/0xa0
[  210.931030][ T4159] [c0002005b10afbd0] [c0000000008621a0] device_offline+0x100/0x140
[  210.931080][ T4159] [c0002005b10afc10] [c000000000888938] state_store+0x108/0x190
[  210.931128][ T4159] [c0002005b10afc50] [c00000000085b628] dev_attr_store+0x38/0x60
[  210.931176][ T4159] [c0002005b10afc70] [c0000000006b9790] sysfs_kf_write+0x70/0xb0
[  210.931211][ T4159] [c0002005b10afcb0] [c0000000006b895c] kernfs_fop_write+0x11c/0x270
[  210.931249][ T4159] [c0002005b10afd00] [c00000000057bcac] __vfs_write+0x3c/0x70
[  210.931273][ T4159] [c0002005b10afd20] [c00000000057f0ac] vfs_write+0xcc/0x200
[  210.931319][ T4159] [c0002005b10afd70] [c00000000057f44c] ksys_write+0x7c/0x140
[  210.931345][ T4159] [c0002005b10afdc0] [c000000000039e78] system_call_exception+0x108/0x1d0
[  210.931395][ T4159] [c0002005b10afe20] [c00000000000c9f0] system_call_common+0xf0/0x278
[  210.931445][ T4159] Instruction dump:
[  210.931476][ T4159] 9bad0988 e90d0028 3d22ff9f 3929c670 7d49402a 394a0001 7d49412a 4bafdec5 
[  210.931492][ T4159] 60000000 4bfff544 2fbe0000 409e04c4 <e93b0008> 71290001 40820928 e93b0000 
[  210.931521][ T4159] ---[ end trace 03092b3800dbb5cb ]---
[  211.416724][ T4159] 
[  212.416810][ T4159] Kernel panic - not syncing: Fatal exception
[  213.829268][ T4159] ---[ end Kernel panic - not syncing: Fatal exception ]---

>  			thp_migration_success(true);
>  		put_page(page);
>  		if (reason == MR_MEMORY_FAILURE) {
> 
