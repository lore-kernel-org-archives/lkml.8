Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E662C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81C0720836
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbgFZIIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 04:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729126AbgFZIFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 04:05:44 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC42AC08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 01:05:44 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id DBB1F3FA; Fri, 26 Jun 2020 10:05:41 +0200 (CEST)
Date:   Fri, 26 Jun 2020 10:05:40 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Qian Cai <cai@lca.pw>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 2/2] iommu/amd: Use 'unsigned long' for domain->pt_root
Message-ID: <20200626080539.GP3701@8bytes.org>
References: <20200625145227.4159-1-joro@8bytes.org>
 <20200625145227.4159-3-joro@8bytes.org>
 <20200625153720.GA1127@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625153720.GA1127@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qian,

On Thu, Jun 25, 2020 at 11:37:20AM -0400, Qian Cai wrote:
> On Thu, Jun 25, 2020 at 04:52:27PM +0200, Joerg Roedel wrote:
> > -	u64 pt_root = atomic64_read(&domain->pt_root);
> > +	unsigned long pt_root = domain->pt_root;
> 
> The pt_root might be reload later in case of register pressure where the
> compiler decides to not store it as a stack variable, so it needs
> smp_rmb() here to match to the smp_wmb() in
> amd_iommu_domain_set_pt_root() to make the load visiable to all CPUs.
> 
> Then, smp_rmb/wmb() wouldn't be able to deal with data races, so it
> needs,
> 
> unsigned long pt_root = READ_ONCE(domain->pt_root);
> 
> >  
> >  	pgtable->root = (u64 *)(pt_root & PAGE_MASK);
> >  	pgtable->mode = pt_root & 7; /* lowest 3 bits encode pgtable mode */
> > @@ -164,7 +164,13 @@ static void amd_iommu_domain_get_pgtable(struct protection_domain *domain,
> >  
> >  static void amd_iommu_domain_set_pt_root(struct protection_domain *domain, u64 root)
> >  {
> > -	atomic64_set(&domain->pt_root, root);
> > +	domain->pt_root = root;
> 
> WRITE_ONCE(domain->pt_root, root);

Thanks for your review. I addressed your comments and will send an
updated version shortly.


Regards,

	Joerg

