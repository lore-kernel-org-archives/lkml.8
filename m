Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05816C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 11:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA4882070A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 11:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595246186;
	bh=/UaHuvv/N6zEnDH3a7uxqwhmtAhJjPRJyrmfudr9r4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r4heDN7wQKYjAZZaQh0Ts8Jhb4XhYRcfU+DWDSu39exAkYXDHYtShDvyEEsvUGpFX
	 h8A4nYbfTKOjBP3WhZmEQlkqvQb4gNv8vPBD+nJz5BfAR3caSuSBjyYHspi2MzAiVC
	 DA1ahXGtAU/tYS4imq93KXDfDlIKnxFtKHorLpDg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgGTL4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 07:56:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728469AbgGTL4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 07:56:25 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D1CC20773;
        Mon, 20 Jul 2020 11:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595246184;
        bh=/UaHuvv/N6zEnDH3a7uxqwhmtAhJjPRJyrmfudr9r4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JgpMW2ZHb8ZkEKMlQlIKL2GYAEYHFnR2OPW2FX1bGSOOH5BPUbgD74/ljwX/cK7w1
         RAEeANkHk+VP9qURl4vMyo92BPscXjjMkJA/nemw/7LYmrOaUmV3zsewyLjKtoogmv
         xlUMv/7geCOuzDv5gmRJkjPmTpVmqwfChleN71U4=
From:   Will Deacon <will@kernel.org>
To:     joro@8bytes.org, robh+dt@kernel.org,
        Krishna Reddy <vdumpa@nvidia.com>, robin.murphy@arm.com,
        jonathanh@nvidia.com, treding@nvidia.com
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-tegra@vger.kernel.org,
        bhuntsman@nvidia.com, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, bbiswas@nvidia.com,
        talho@nvidia.com, praithatha@nvidia.com, yhsu@nvidia.com,
        nicoleotsuka@gmail.com, nicolinc@nvidia.com,
        linux-kernel@vger.kernel.org, snikam@nvidia.com,
        devicetree@vger.kernel.org, mperttunen@nvidia.com
Subject: Re: [PATCH v11 0/5] NVIDIA ARM SMMU Implementation
Date:   Mon, 20 Jul 2020 12:56:09 +0100
Message-Id: <159523385148.790143.14826100945729579786.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200718193457.30046-1-vdumpa@nvidia.com>
References: <20200718193457.30046-1-vdumpa@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jul 2020 12:34:52 -0700, Krishna Reddy wrote:
> Changes in v11:
> Addressed Rob comment on DT binding patch to set min/maxItems of reg property in else part.
> Rebased on top of https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=for-joerg/arm-smmu/updates.
> 
> Changes in v10:
> Perform SMMU base ioremap before calling implementation init.
> Check for Global faults across both ARM MMU-500s during global interrupt.
> Check for context faults across all contexts of both ARM MMU-500s during context fault interrupt.
> Add new DT binding nvidia,smmu-500 for NVIDIA implementation.
> https://lkml.org/lkml/2020/7/8/57
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/5] iommu/arm-smmu: move TLB timeout and spin count macros
      https://git.kernel.org/will/c/cd8479cf0de9
[2/5] iommu/arm-smmu: ioremap smmu mmio region before implementation init
      https://git.kernel.org/will/c/6c019f4e697e
[3/5] iommu/arm-smmu: add NVIDIA implementation for ARM MMU-500 usage
      https://git.kernel.org/will/c/aab5a1c88276
[4/5] dt-bindings: arm-smmu: add binding for Tegra194 SMMU
      https://git.kernel.org/will/c/3d2deb0cdb69
[5/5] iommu/arm-smmu: Add global/context fault implementation hooks
      https://git.kernel.org/will/c/aa7ec73297df

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
