Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13D3C38A2F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 12:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9277A21D79
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 12:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgDRMKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 08:10:25 -0400
Received: from 8bytes.org ([81.169.241.247]:36290 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgDRMKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 08:10:25 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 945EE342; Sat, 18 Apr 2020 14:10:23 +0200 (CEST)
Date:   Sat, 18 Apr 2020 14:10:22 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Qian Cai <cai@lca.pw>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] iommu/amd: fix a race in fetch_pte()
Message-ID: <20200418121022.GA6113@8bytes.org>
References: <20200407021246.10941-1-cai@lca.pw>
 <7664E2E7-04D4-44C3-AB7E-A4334CDEC373@lca.pw>
 <20200408141915.GJ3103@8bytes.org>
 <527B0883-F59D-4C7A-8102-743872801EFC@lca.pw>
 <4FAF3A63-8DC8-4489-B5FE-95B716EF25AE@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4FAF3A63-8DC8-4489-B5FE-95B716EF25AE@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 09:42:41PM -0400, Qian Cai wrote:
> So, this is still not enough that would still trigger storage driver offline under
> memory pressure for a bit longer. It looks to me that in fetch_pte() there are
> could still racy?

Yes, your patch still looks racy. You need to atomically read
domain->pt_root to a stack variable and derive the pt_root pointer and
the mode from that variable instead of domain->pt_root directly. If you
read the domain->pt_root twice there could still be an update between
the two reads.
Probably the lock in increase_address_space() can also be avoided if
pt_root is updated using cmpxchg()?

Regards,

	Joerg

