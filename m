Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D013CC433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 12:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF80120773
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 12:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbgGMMVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 08:21:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbgGMMV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 08:21:29 -0400
Received: from gaia (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C95920738;
        Mon, 13 Jul 2020 12:21:26 +0000 (UTC)
Date:   Mon, 13 Jul 2020 13:21:24 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     maz@kernel.org, steven.price@arm.com, guohanjun@huawei.com,
        Zhenyu Ye <yezhenyu2@huawei.com>, will@kernel.org,
        olof@lixom.net, suzuki.poulose@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        zhangshaokun@hisilicon.com, prime.zeng@hisilicon.com,
        linux-arch@vger.kernel.org, kuhn.chenqun@huawei.com,
        xiexiangyou@huawei.com, linux-mm@kvack.org, arm@kernel.org
Subject: Re: [PATCH v2 0/2] arm64: tlb: add support for TLBI RANGE
 instructions
Message-ID: <20200713122123.GC15829@gaia>
References: <20200710094420.517-1-yezhenyu2@huawei.com>
 <159440712962.27784.4664678472466095995.b4-ty@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159440712962.27784.4664678472466095995.b4-ty@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 08:11:19PM +0100, Catalin Marinas wrote:
> On Fri, 10 Jul 2020 17:44:18 +0800, Zhenyu Ye wrote:
> > NOTICE: this series are based on the arm64 for-next/tlbi branch:
> > git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/tlbi
> > 
> > --
> > ARMv8.4-TLBI provides TLBI invalidation instruction that apply to a
> > range of input addresses. This series add support for this feature.
> > 
> > [...]
> 
> Applied to arm64 (for-next/tlbi), thanks!
> 
> [1/2] arm64: tlb: Detect the ARMv8.4 TLBI RANGE feature
>       https://git.kernel.org/arm64/c/a2fd755f77ff
> [2/2] arm64: tlb: Use the TLBI RANGE feature in arm64
>       https://git.kernel.org/arm64/c/db34a081d273

I'm dropping these two patches from for-next/tlbi and for-next/core.
They need a check on whether binutils supports the new "tlbi rva*"
instructions, otherwise the build mail fail.

I kept the latest incarnation of these patches on devel/tlbi-range for
reference.

-- 
Catalin
