Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECDCC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9986207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578993019;
	bh=U4qK8WsI1/dOSA2dniMIIdegiLR0XxvnX34tPeZJy/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t7nJHYPEkPwYkJRlsnEhDLgGdjqQY8ceLwM4q9epGA0m/KbLSIek8g6sq2sI7mpU9
	 TAvISvEYKHzKd8RF+yKKy4onpU10jGZ21fwiRs561r1XqcYDKvUvHFvNUCamtIajQy
	 eb64vpcYy2RMoLe+GYcTx+vtNVnS+YzFLzvyOaR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgANJKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 04:10:18 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38872 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgANJKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 04:10:17 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so11341033wrh.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 01:10:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HrLjGdCMVDTL1UA4+UplXafRipxIPdku8gSs8VIm2nc=;
        b=IUNgsQSnGThgloPPCx1stBjlGEwe6BRD/YwUvFv/fs0jFK8IQKlbyDFuHepSfVXF3x
         BvAUFFYdWdLHU/7KJecHtg1zfHieA/qr0AN1lV/HV/gKhPj+bU+vIQo7dM1p7Aj59vrq
         vbNf6tnNH3AlmR4XKRs6sc6A+usHwiWhUD/Egg9OtIFDJqRzKC4v1sYvREZNEvqUrfIb
         +2TBskaICEAtBOFWFNeW8QTU0OYxGV355R0o0BIfNpnt1V3FxrFtfagoBJ3+tza3AQ/x
         0WyebU3fTbJDpgjpLMWtH+SEfpmsqHrONemDNoPw4oYRo/2t5QOp9RYrcQnD7vcBGjGf
         Anpg==
X-Gm-Message-State: APjAAAWxCiaVcTbVg/FDDcCbfPdL4/1NE+2VYCN+8Fd1dOIEM71oOb27
        IHWfZyvLhT9hS3FHMh+8+pY=
X-Google-Smtp-Source: APXvYqyRzyIMyQYoJ2BK9aJptwFK6wEoPAqkMHUvJloPzo1uf3Vj4uvPgNtzUmNhMimG3YRv312sIA==
X-Received: by 2002:a5d:5273:: with SMTP id l19mr24032720wrc.175.1578993015321;
        Tue, 14 Jan 2020 01:10:15 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id n10sm18591573wrt.14.2020.01.14.01.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 01:10:14 -0800 (PST)
Date:   Tue, 14 Jan 2020 10:10:13 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     David Hildenbrand <david@redhat.com>, Qian Cai <cai@lca.pw>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        linux-kernel@vger.kernel.org, Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH] mm/page_alloc: Add a reason for reserved pages in
 has_unmovable_pages()
Message-ID: <20200114091013.GD19428@dhcp22.suse.cz>
References: <49fa7dea-00ac-155f-e7b7-eeca206556b5@arm.com>
 <6A58E80B-7A5F-4CAD-ACF1-89BCCBE4D3B1@lca.pw>
 <a0bfcebe-a0f4-95ef-0973-8edd3780d013@redhat.com>
 <f6487dc1-c962-67aa-131e-2eec4f6ca686@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6487dc1-c962-67aa-131e-2eec4f6ca686@arm.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc Ralph]

On Tue 14-01-20 13:49:14, Anshuman Khandual wrote:
> 
> 
> On 10/04/2019 01:55 PM, David Hildenbrand wrote:
> > On 03.10.19 14:14, Qian Cai wrote:
> >>
> >>
> >>> On Oct 3, 2019, at 8:01 AM, Anshuman Khandual <Anshuman.Khandual@arm.com> wrote:
> >>>
> >>> Will something like this be better ?
> >>
> >> Not really. dump_page() will dump PageCompound information anyway, so it is trivial to figure out if went in that path.
> >>
> > 
> > I agree, I use the dump_page() output frequently to identify PG_reserved
> > pages. No need to duplicate that.
> 
> Here in this path there is a reserved page which is preventing
> offlining a memory section but unfortunately dump_page() does
> not print page->flags for a reserved page pinned there possibly
> through memblock_reserve() during boot.
> 
> __offline_pages()
> 	start_isolate_page_range()
> 		set_migratetype_isolate()
> 			has_unmovable_pages()
> 				dump_page() 
> 
> [   64.920970] ------------[ cut here ]------------
> [   64.921718] WARNING: CPU: 16 PID: 1116 at mm/page_alloc.c:8298 has_unmovable_pages+0x274/0x2a8
> [   64.923110] Modules linked in:
> [   64.923634] CPU: 16 PID: 1116 Comm: bash Not tainted 5.5.0-rc6-00006-gca544f2a11ae-dirty #281
> [   64.925102] Hardware name: linux,dummy-virt (DT)
> [   64.925905] pstate: 60400085 (nZCv daIf +PAN -UAO)
> [   64.926742] pc : has_unmovable_pages+0x274/0x2a8
> [   64.927554] lr : has_unmovable_pages+0x298/0x2a8
> [   64.928359] sp : ffff800014fd3a00
> [   64.928944] x29: ffff800014fd3a00 x28: fffffe0017640000 
> [   64.929875] x27: 0000000000000000 x26: ffff0005fcfcda00 
> [   64.930810] x25: 0000000000640000 x24: 0000000000000003 
> [   64.931736] x23: 0000000019840000 x22: 0000000000001380 
> [   64.932667] x21: ffff800011259000 x20: ffff0005fcfcda00 
> [   64.933588] x19: 0000000000661000 x18: 0000000000000010 
> [   64.934514] x17: 0000000000000000 x16: 0000000000000000 
> [   64.935454] x15: ffffffffffffffff x14: ffff8000118498c8 
> [   64.936377] x13: ffff800094fd3797 x12: ffff800014fd379f 
> [   64.937304] x11: ffff800011861000 x10: ffff800014fd3720 
> [   64.938226] x9 : 00000000ffffffd0 x8 : ffff8000106a60d0 
> [   64.939156] x7 : 0000000000000000 x6 : ffff0005fc6261b0 
> [   64.940078] x5 : ffff0005fc6261b0 x4 : 0000000000000000 
> [   64.941003] x3 : ffff0005fc62cf80 x2 : ffffffffffffec80 
> [   64.941927] x1 : ffff800011141b58 x0 : ffff0005fcfcda00 
> [   64.942857] Call trace:
> [   64.943298]  has_unmovable_pages+0x274/0x2a8
> [   64.944056]  start_isolate_page_range+0x258/0x360
> [   64.944879]  __offline_pages+0xf4/0x9e8
> [   64.945554]  offline_pages+0x10/0x18
> [   64.946189]  memory_block_action+0x40/0x1a0
> [   64.946929]  memory_subsys_offline+0x4c/0x78
> [   64.947679]  device_offline+0x98/0xc8
> [   64.948328]  unprobe_store+0xa8/0x158
> [   64.948976]  dev_attr_store+0x14/0x28
> [   64.949628]  sysfs_kf_write+0x40/0x50
> [   64.950273]  kernfs_fop_write+0x108/0x218
> [   64.950983]  __vfs_write+0x18/0x40
> [   64.951592]  vfs_write+0xb0/0x1d0
> [   64.952175]  ksys_write+0x64/0xe8
> [   64.952761]  __arm64_sys_write+0x18/0x20
> [   64.953451]  el0_svc_common.constprop.2+0x88/0x150
> [   64.954293]  el0_svc_handler+0x20/0x80
> [   64.954963]  el0_sync_handler+0x118/0x188
> [   64.955669]  el0_sync+0x140/0x180
> [   64.956256] ---[ end trace b162b4d1cbea304d ]---
> [   64.957063] page:fffffe0017640000 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0
> [   64.958489] raw: 1ffff80000001000 fffffe0017640008 fffffe0017640008 0000000000000000
> [   64.959839] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
> [   64.961174] page dumped because: unmovable page
> 
> The reason is dump_page() does not print page->flags universally
> and only does so for KSM, Anon and File pages while excluding
> reserved pages at boot. Wondering should not we make printing
> page->flags universal ?

We used to do that and this caught me as a surprise when looking again.
This is a result of 76a1850e4572 ("mm/debug.c: __dump_page() prints an
extra line") which is a cleanup patch and I suspect this result was not
anticipated.

The following will do the trick but I cannot really say I like the code
duplication. pr_cont in this case sounds like a much cleaner solution to
me.

diff --git a/mm/debug.c b/mm/debug.c
index 0461df1207cb..4cbf30d03c88 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -89,6 +89,8 @@ void __dump_page(struct page *page, const char *reason)
 		} else
 			pr_warn("%ps\n", mapping->a_ops);
 		pr_warn("flags: %#lx(%pGp)\n", page->flags, &page->flags);
+	} else {
+		pr_warn("flags: %#lx(%pGp)\n", page->flags, &page->flags);
 	}
 	BUILD_BUG_ON(ARRAY_SIZE(pageflag_names) != __NR_PAGEFLAGS + 1);
 

-- 
Michal Hocko
SUSE Labs
