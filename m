Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA934C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 13:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A817720838
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 13:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbgCCNrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 08:47:05 -0500
Received: from foss.arm.com ([217.140.110.172]:47272 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728877AbgCCNrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 08:47:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DC8CFEC;
        Tue,  3 Mar 2020 05:47:04 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4043D3F6C4;
        Tue,  3 Mar 2020 05:47:03 -0800 (PST)
Subject: Re: sunxi: a83t: does not boot anymore in BigEndian
To:     Corentin Labbe <clabbe.montjoie@gmail.com>, maz@kernel.org,
        wens@csie.org, mripard@kernel.org
Cc:     mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux@armlinux.org.uk
References: <20200303074326.GA9935@Red>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <65498b8e-a6c3-9edb-873f-6c011582a2eb@arm.com>
Date:   Tue, 3 Mar 2020 13:47:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200303074326.GA9935@Red>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/2020 7:43 am, Corentin Labbe wrote:
> Hello
> 
> My sun8i-a83t-bananapi-m3 does not boot anymore in BE.
> Others sunxi platform I have seems not affected (a10, a20, a64, h3, h5, h6)
> 
> I have bisected this problem:
> git bisect start
> # bad: [98d54f81e36ba3bf92172791eba5ca5bd813989b] Linux 5.6-rc4
> git bisect bad 98d54f81e36ba3bf92172791eba5ca5bd813989b
> # bad: [d5226fa6dbae0569ee43ecfc08bdcd6770fc4755] Linux 5.5
> git bisect bad d5226fa6dbae0569ee43ecfc08bdcd6770fc4755
> # good: [219d54332a09e8d8741c1e1982f5eae56099de85] Linux 5.4
> git bisect good 219d54332a09e8d8741c1e1982f5eae56099de85
> # bad: [8c39f71ee2019e77ee14f88b1321b2348db51820] Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> git bisect bad 8c39f71ee2019e77ee14f88b1321b2348db51820
> # bad: [3b397c7ccafe0624018cb09fc96729f8f6165573] Merge tag 'regmap-v5.5' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap
> git bisect bad 3b397c7ccafe0624018cb09fc96729f8f6165573
> # good: [924ea58dadea23cc28b60d02b9c0896b7b168a6f] Merge tag 'mt76-for-kvalo-2019-11-20' of https://github.com/nbd168/wireless
> git bisect good 924ea58dadea23cc28b60d02b9c0896b7b168a6f
> # good: [3f3c8be973af10875cfa1e7b85a535b6ba76b44f] Merge tag 'for-linus-5.5a-rc1-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip
> git bisect good 3f3c8be973af10875cfa1e7b85a535b6ba76b44f
> # bad: [642356cb5f4a8c82b5ca5ebac288c327d10df236] Merge git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
> git bisect bad 642356cb5f4a8c82b5ca5ebac288c327d10df236
> # good: [57d8154f15e89f53dfb412f4ed32ebe3c3d755a0] crypto: atmel-aes - Change data type for "lastc" buffer
> git bisect good 57d8154f15e89f53dfb412f4ed32ebe3c3d755a0
> # bad: [752272f16dd18f2cac58a583a8673c8e2fb93abb] Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
> git bisect bad 752272f16dd18f2cac58a583a8673c8e2fb93abb
> # good: [9477f4449b0b011ce1d058c09ec450bfcdaab784] KVM: VMX: Add helper to check reserved bits in IA32_PERF_GLOBAL_CTRL
> git bisect good 9477f4449b0b011ce1d058c09ec450bfcdaab784
> # bad: [cd7056ae34af0e9424da97bbc7d2b38246ba8a2c] Merge remote-tracking branch 'kvmarm/misc-5.5' into kvmarm/next
> git bisect bad cd7056ae34af0e9424da97bbc7d2b38246ba8a2c
> # bad: [c7892db5dd6afe921ead502aff7440a1e450d947] KVM: arm64: Select TASK_DELAY_ACCT+TASKSTATS rather than SCHEDSTATS
> git bisect bad c7892db5dd6afe921ead502aff7440a1e450d947
> # bad: [8564d6372a7d8a6d440441b8ed8020f97f744450] KVM: arm64: Support stolen time reporting via shared structure
> git bisect bad 8564d6372a7d8a6d440441b8ed8020f97f744450
> # bad: [55009c6ed2d24fc0f5521ab2482f145d269389ea] KVM: arm/arm64: Factor out hypercall handling from PSCI code
> git bisect bad 55009c6ed2d24fc0f5521ab2482f145d269389ea
> # bad: [6a7458485b390f48e481fcd4a0b20e6c5c843d2e] KVM: arm64: Document PV-time interface
> git bisect bad 6a7458485b390f48e481fcd4a0b20e6c5c843d2e
> # bad: [dcac930e9901d765234bc15004db4f7d4416db71] Merge remote-tracking branch 'arm64/for-next/smccc-conduit-cleanup' into kvm-arm64/stolen-time
> git bisect bad dcac930e9901d765234bc15004db4f7d4416db71
> # first bad commit: [dcac930e9901d765234bc15004db4f7d4416db71] Merge remote-tracking branch 'arm64/for-next/smccc-conduit-cleanup' into kvm-arm64/stolen-time
> 
> But bisect lead to a merge request.

FWIW once you've bisected to a merge commit, you can always then try 
bisecting down the merged branch itself (i.e. between 5.4-rc3 and 
e6ea46511b1a in this case) to narrow things down further.

Given that that branch is supposed to be a functionally-inert cleanup, 
and (judging by the DTS) this platform apparently isn't using PSCI 
anyway, it does seem a bit odd. Can you get any earlycon/earlyprintk 
output to suggest what the actual cause of the boot failure is?

Robin.
