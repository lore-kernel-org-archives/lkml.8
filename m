Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6E4C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD032080C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgCSOQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:16:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:45660 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbgCSOQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:16:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4919DAE6F;
        Thu, 19 Mar 2020 14:16:21 +0000 (UTC)
Date:   Thu, 19 Mar 2020 15:16:19 +0100
From:   Joerg Roedel <jroedel@suse.de>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Qian Cai <cai@lca.pw>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: silence a RCU-list debugging warning
Message-ID: <20200319141619.GC611@suse.de>
References: <20200317150326.1659-1-cai@lca.pw>
 <36b9e69b-ee3f-c17d-1788-64448ce8bc14@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36b9e69b-ee3f-c17d-1788-64448ce8bc14@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 01:27:53PM +0800, Lu Baolu wrote:
> On 2020/3/17 23:03, Qian Cai wrote:
> > dmar_find_atsr() calls list_for_each_entry_rcu() outside of an RCU read
> > side critical section but with dmar_global_lock held. Silence this
> > false positive.
> > 
> >   drivers/iommu/intel-iommu.c:4504 RCU-list traversed in non-reader section!!
> >   1 lock held by swapper/0/1:
> >   #0: ffffffff9755bee8 (dmar_global_lock){+.+.}, at: intel_iommu_init+0x1a6/0xe19
> > 
> >   Call Trace:
> >    dump_stack+0xa4/0xfe
> >    lockdep_rcu_suspicious+0xeb/0xf5
> >    dmar_find_atsr+0x1ab/0x1c0
> >    dmar_parse_one_atsr+0x64/0x220
> >    dmar_walk_remapping_entries+0x130/0x380
> >    dmar_table_init+0x166/0x243
> >    intel_iommu_init+0x1ab/0xe19
> >    pci_iommu_init+0x1a/0x44
> >    do_one_initcall+0xae/0x4d0
> >    kernel_init_freeable+0x412/0x4c5
> >    kernel_init+0x19/0x193
> > 
> > Signed-off-by: Qian Cai <cai@lca.pw>
> 
> How about changing the commit subject to
> "iommu/vt-d: Silence RCU-list debugging warning in dmar_find_atsr()"?
> 
> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Fixed up the subject and applied it, thanks.
