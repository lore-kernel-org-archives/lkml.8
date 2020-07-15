Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475BBC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 17:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24947206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 17:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgGORFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 13:05:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:35094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbgGORFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 13:05:30 -0400
Received: from localhost.localdomain (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0C5F2065E;
        Wed, 15 Jul 2020 17:05:27 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     olof@lixom.net, guohanjun@huawei.com, maz@kernel.org,
        Zhenyu Ye <yezhenyu2@huawei.com>, suzuki.poulose@arm.com,
        will@kernel.org, steven.price@arm.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kuhn.chenqun@huawei.com, zhangshaokun@hisilicon.com,
        linux-arm-kernel@lists.infradead.org, xiexiangyou@huawei.com,
        arm@kernel.org, prime.zeng@hisilicon.com,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 0/3] arm64: tlb: add support for TLBI RANGE instructions
Date:   Wed, 15 Jul 2020 18:05:25 +0100
Message-Id: <159483264095.31859.17352107236921556251.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200715071945.897-1-yezhenyu2@huawei.com>
References: <20200715071945.897-1-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jul 2020 15:19:42 +0800, Zhenyu Ye wrote:
> NOTICE: this series are based on the arm64 for-next/tlbi branch:
> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/tlbi
> 
> ARMv8.4-TLBI provides TLBI invalidation instruction that apply to a
> range of input addresses. This series add support for this feature.
> 
> --
> ChangeList:
> v3:
> - add check on whether binutils supports ARMv8.4-a instructions.
> - pass -march=armv8.4-a to KBUILD_CFLAGS.
> - make __TLBI_RANGE_PAGES to be 'unsigned long' explicitly.
> 
> [...]

Applied to arm64 (for-next/tlbi), thanks!

[1/3] arm64: tlb: Detect the ARMv8.4 TLBI RANGE feature
      https://git.kernel.org/arm64/c/b620ba54547c
[2/3] arm64: enable tlbi range instructions
      https://git.kernel.org/arm64/c/7c78f67e9bd9
[3/3] arm64: tlb: Use the TLBI RANGE feature in arm64
      https://git.kernel.org/arm64/c/d1d3aa98b1d4

(I introduced a system_supports_tlb_range() to avoid the IS_ENABLED
twice)

-- 
Catalin

