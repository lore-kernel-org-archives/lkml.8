Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B51C3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 09:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA80C20870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 09:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgCEJVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 04:21:55 -0500
Received: from foss.arm.com ([217.140.110.172]:45410 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgCEJVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 04:21:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E856031B;
        Thu,  5 Mar 2020 01:21:54 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E87323F534;
        Thu,  5 Mar 2020 01:21:53 -0800 (PST)
Date:   Thu, 5 Mar 2020 09:21:51 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: linux-next: manual merge of the akpm tree with the arm64 tree
Message-ID: <20200305092151.GB1729062@arrakis.emea.arm.com>
References: <20200305165046.42e62969@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305165046.42e62969@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 04:50:46PM +1100, Stephen Rothwell wrote:
> Today's linux-next merge of the akpm tree got a conflict in:
> 
>   arch/arm64/mm/mmu.c
> 
> between commit:
> 
>   bbd6ec605c0f ("arm64/mm: Enable memory hot remove")
> 
> from the arm64 tree and patch:
> 
>   37be0f08b1cc ("arm64/mm: implement unmap_hotplug_p4d_range")
> 
> from the akpm tree.
> 
> I fixed it up (I just dropped the latter (and its followup fix) for today)

Thanks Stephen. Anshuman integrated those fixes in his memory hotremove
series.

-- 
Catalin
