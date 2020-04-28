Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6897C83001
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1AF7206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588085417;
	bh=wLkMog+C31R9s35T9i+aq0ijLlgLzB9NiqhRDEWFHMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OkrHYMyNPLOPSdWmZRW4tduXb9vJ+uaI4zit2LUd/szMe6vgrioK9nVBcWYbOxQBu
	 FCwmXvXqpBWwvTnU74Vjz8SeaODRWXhvRNyhuxDDJIF+AWsejZdLeUi9OC8ithYO4+
	 Bkhg4s8bNmlWao/Fc3ipymFJH8KTuRbZcZ92W7pc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbgD1OuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:50:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728137AbgD1OuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 10:50:03 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A4902070B;
        Tue, 28 Apr 2020 14:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588085403;
        bh=wLkMog+C31R9s35T9i+aq0ijLlgLzB9NiqhRDEWFHMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uB8e0UjJMU74eFifX38zXKgiEWe5bPcwPZo6dQ4B8kxElcPzsVdGWiWxaUJXmWQht
         HMqWj7ty10mNGN1QhEW6R0qQw3+wJ/YhtTkQXXiSAgij77C1YfHWYuwNI86nwJwmmW
         AI7IT2t8GdCO5wjcb3fuXrLuo20ZTElweDMz59l4=
From:   Will Deacon <will@kernel.org>
To:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Zenghui Yu <yuzenghui@huawei.com>, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
        maz@kernel.org
Subject: Re: [PATCH] KVM: arm64: Drop PTE_S2_MEMATTR_MASK
Date:   Tue, 28 Apr 2020 15:49:41 +0100
Message-Id: <158808189342.219357.12380979087402977148.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415105746.314-1-yuzenghui@huawei.com>
References: <20200415105746.314-1-yuzenghui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Apr 2020 18:57:46 +0800, Zenghui Yu wrote:
> The only user of PTE_S2_MEMATTR_MASK macro had been removed since
> commit a501e32430d4 ("arm64: Clean up the default pgprot setting").
> It has been about six years and no one has used it again.
> 
> Let's drop it.

Applied to arm64 (for-next/misc), thanks!

[1/1] KVM: arm64: Drop PTE_S2_MEMATTR_MASK
      https://git.kernel.org/arm64/c/f4be140fa33f

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
