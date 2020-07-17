Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C57C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 10:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C95F02076A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 10:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594982633;
	bh=6I6JgYqOPYPJIJgJ4C1GUEIrc1Hr08T5r1A4SKQv1rk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GTNRrFBEb8snRe7neGuX1+j4yrxB765J8ma69RF7xj6QCcMZ3j8LWstCznnQoPky+
	 VO/omQHHR24MvrQalxW0xXdoN7SCFyOPzK/ultKYRz/7lDgnF3W+INstyXneIEAT9/
	 bJ6K5TZLF/zW92rEVi4ik42nlEnxWmbT0dxe6eBM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgGQKnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 06:43:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbgGQKnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 06:43:52 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D88B20734;
        Fri, 17 Jul 2020 10:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594982631;
        bh=6I6JgYqOPYPJIJgJ4C1GUEIrc1Hr08T5r1A4SKQv1rk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dusBU3PFc8tVsUE0EUeaym/bI6vipNHJj51TVdSCmHJIkN0VI0CXXwZWESOFK9CIN
         b6GjSO5c6l8K5KDc1RjZvrwd//TrVZgjzH4P+ieQXONdX2ft83pROpzcSm9rHhx54f
         QBXuydbo9fNM0lCjKDRa76at+CDtS7QIaArjBuqo=
From:   Will Deacon <will@kernel.org>
To:     mark.rutland@arm.com, Qi Liu <liuqi115@huawei.com>,
        zhangshaokun@hisilicon.com, john.garry@huawei.com
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drivers/perf: Prevent forced unbinding of PMU drivers
Date:   Fri, 17 Jul 2020 11:43:42 +0100
Message-Id: <159497953657.530785.13608435502860855695.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1594975763-32966-1-git-send-email-liuqi115@huawei.com>
References: <1594975763-32966-1-git-send-email-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jul 2020 16:49:23 +0800, Qi Liu wrote:
> Forcefully unbinding PMU drivers during perf sampling will lead to
> a kernel panic, because the perf upper-layer framework call a NULL
> pointer in this situation.
> 
> To solve this issue, "suppress_bind_attrs" should be set to true, so
> that bind/unbind can be disabled via sysfs and prevent unbinding PMU
> drivers during perf sampling.

Applied to arm64 (for-next/fixes), thanks!

[1/1] drivers/perf: Prevent forced unbinding of PMU drivers
      https://git.kernel.org/arm64/c/f32ed8eb0e3f

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
