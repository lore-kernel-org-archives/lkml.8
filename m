Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33C2C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99763207D0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgGJTLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 15:11:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726872AbgGJTLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 15:11:23 -0400
Received: from localhost.localdomain (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D397A2075D;
        Fri, 10 Jul 2020 19:11:20 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     maz@kernel.org, steven.price@arm.com, guohanjun@huawei.com,
        Zhenyu Ye <yezhenyu2@huawei.com>, will@kernel.org,
        olof@lixom.net, suzuki.poulose@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        zhangshaokun@hisilicon.com, prime.zeng@hisilicon.com,
        linux-arch@vger.kernel.org, kuhn.chenqun@huawei.com,
        xiexiangyou@huawei.com, linux-mm@kvack.org, arm@kernel.org
Subject: Re: [PATCH v2 0/2] arm64: tlb: add support for TLBI RANGE instructions
Date:   Fri, 10 Jul 2020 20:11:19 +0100
Message-Id: <159440712962.27784.4664678472466095995.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200710094420.517-1-yezhenyu2@huawei.com>
References: <20200710094420.517-1-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jul 2020 17:44:18 +0800, Zhenyu Ye wrote:
> NOTICE: this series are based on the arm64 for-next/tlbi branch:
> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/tlbi
> 
> --
> ARMv8.4-TLBI provides TLBI invalidation instruction that apply to a
> range of input addresses. This series add support for this feature.
> 
> [...]

Applied to arm64 (for-next/tlbi), thanks!

[1/2] arm64: tlb: Detect the ARMv8.4 TLBI RANGE feature
      https://git.kernel.org/arm64/c/a2fd755f77ff
[2/2] arm64: tlb: Use the TLBI RANGE feature in arm64
      https://git.kernel.org/arm64/c/db34a081d273

-- 
Catalin

