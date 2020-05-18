Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FC1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 23:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0B2F20829
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 23:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589843058;
	bh=vTTgvB3JUjULE7uYpMa6wmTcpdP6w+Gge17Ze+4Iieg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RSg7hZXS8nWnlvDv0JaZRQVzPOpJNikzIahUM4UN6BcrYM8b04JSLuKpe8IWxN/A0
	 ub3lug4KY0erUbMFbBPWVcHJUo1goU1VTe4bQWwnKpGdQ3sWMSyeA1JIAwCoGbYzoJ
	 dDxoD8JiHpMLH+uP2v3FdjAB96pa+FgE/lR8K05Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgERXER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 19:04:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:49952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726490AbgERXEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 19:04:16 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3A93207ED;
        Mon, 18 May 2020 23:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589843056;
        bh=vTTgvB3JUjULE7uYpMa6wmTcpdP6w+Gge17Ze+4Iieg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z1iP9xOGKusy7dXpZxmij9FsdSXHE/iAuAUadwQPy4Kgpj8W+sCDMtIsxLC0SX18j
         s1JHrjl8jEQEUtnsVVs8QJofrVz/k0mYVBS9pyPH1y04FT4PMi6RpLzIc+y4NiF8xg
         5jC0xa2bWfrTRV4w8bxA0PAdrb3QU6aP/cTKxwSo=
From:   Will Deacon <will@kernel.org>
To:     joro@8bytes.org, robin.murphy@arm.com,
        Chen Zhou <chenzhou10@huawei.com>
Cc:     catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH -next] iommu/arm-smmu-v3: remove set but not used variable 'smmu'
Date:   Tue, 19 May 2020 00:04:03 +0100
Message-Id: <158981035268.232610.8507071130600467853.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508014955.87630-1-chenzhou10@huawei.com>
References: <20200508014955.87630-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 May 2020 09:49:55 +0800, Chen Zhou wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/iommu/arm-smmu-v3.c:2989:26:
> warning: variable ‘smmu’ set but not used [-Wunused-but-set-variable]
>   struct arm_smmu_device *smmu;

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu-v3: remove set but not used variable 'smmu'
      https://git.kernel.org/will/c/06020196c82e

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
