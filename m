Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676DDC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 17:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31E7F207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 17:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgIBRJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 13:09:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727088AbgIBRJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 13:09:19 -0400
Received: from gaia (unknown [46.69.195.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81C1520709;
        Wed,  2 Sep 2020 17:09:14 +0000 (UTC)
Date:   Wed, 2 Sep 2020 18:09:11 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     will@kernel.org, james.morse@arm.com, tglx@linutronix.de,
        mingo@redhat.com, dyoung@redhat.com, bhe@redhat.com,
        corbet@lwn.net, John.P.donnelly@oracle.com,
        prabhakar.pkin@gmail.com, bhsharma@redhat.com, horms@verge.net.au,
        robh+dt@kernel.org, arnd@arndb.de, nsaenzjulienne@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        guohanjun@huawei.com, xiexiuqi@huawei.com, huawei.libin@huawei.com,
        wangkefeng.wang@huawei.com
Subject: Re: [PATCH v11 3/5] arm64: kdump: reimplement crashkernel=X
Message-ID: <20200902170910.GB16673@gaia>
References: <20200801130856.86625-1-chenzhou10@huawei.com>
 <20200801130856.86625-4-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200801130856.86625-4-chenzhou10@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 01, 2020 at 09:08:54PM +0800, Chen Zhou wrote:
> There are following issues in arm64 kdump:
> 1. We use crashkernel=X to reserve crashkernel below 4G, which
> will fail when there is no enough low memory.
> 2. If reserving crashkernel above 4G, in this case, crash dump
> kernel will boot failure because there is no low memory available
> for allocation.
> 3. Since commit 1a8e1cef7603 ("arm64: use both ZONE_DMA and ZONE_DMA32"),
> if the memory reserved for crash dump kernel falled in ZONE_DMA32,
> the devices in crash dump kernel need to use ZONE_DMA will alloc
> fail.
> 
> To solve these issues, change the behavior of crashkernel=X.
> crashkernel=X tries low allocation in ZONE_DMA, and fall back to
> high allocation if it fails.
> 
> If requized size X is too large and leads to very little free memory
> in ZONE_DMA after low allocation, the system may not work normally.
> So add a threshold and go for high allocation directly if the required
> size is too large. The value of threshold is set as the half of
> the low memory.
> 
> If crash_base is outside ZONE_DMA, try to allocate at least 256M in
> ZONE_DMA automatically. "crashkernel=Y,low" can be used to allocate
> specified size low memory.

Except for the threshold to keep zone ZONE_DMA memory,
reserve_crashkernel() looks very close to the x86 version. Shall we try
to make this generic as well? In the first instance, you could avoid the
threshold check if it takes an explicit ",high" option.

-- 
Catalin
