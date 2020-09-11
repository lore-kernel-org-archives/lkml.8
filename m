Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48927C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07065221EB
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599840973;
	bh=FHvyb4YZgNi7A1rAW27pN0TMAcoCOgzJV9MBqHtD1zk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zx73osrYCoXHYbROGOnOcTPHVyIsxCHRRM16p1xao5zFZSZy/QKBt9TRa4zxHL4j/
	 2BzTrx5KniAAmrd9gPB1khwRh+qypXX6w8jSLgnfnYiw2syNszJDhb6UR7yRrHhi1Y
	 YyWHfuuvhF8Zpb0MSl7CB4MuFSC3s1bjK2gllCGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgIKQQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:16:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:59466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgIKPbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:31:55 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE6E3206E9;
        Fri, 11 Sep 2020 15:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599838315;
        bh=FHvyb4YZgNi7A1rAW27pN0TMAcoCOgzJV9MBqHtD1zk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c9YTBNGFbO526oLa7IxaFS1Ac6jLa/MRtq8fur3NAQ9nzzpgqcW//ucF3ax75U3Fo
         EAdWKWfzTSWv0Pd4B2XSRPYpBPMCY2xyqgJ14zNed48Q+Jv8u37fR5XNFTu9rhVSCn
         BAIBYlEKFViWDAvtVa80jOzvzjUTuCvZEBkAEU3M=
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        rcampbell@nvidia.com, akpm@linux-foundation.org,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan.Cameron@Huawei.com, linux-kernel@vger.kernel.org,
        Suzuki Poulose <suzuki.poulose@arm.com>, ziy@nvidia.com
Subject: Re: [PATCH V2 0/2] arm64/mm: Enable THP migration
Date:   Fri, 11 Sep 2020 16:31:48 +0100
Message-Id: <159983265112.1321153.11672723276282744978.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1599627183-14453-1-git-send-email-anshuman.khandual@arm.com>
References: <1599627183-14453-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Sep 2020 10:23:01 +0530, Anshuman Khandual wrote:
> This series enables THP migration on arm64 via ARCH_ENABLE_THP_MIGRATION.
> But first this modifies all existing THP helpers like pmd_present() and
> pmd_trans_huge() etc per expected generic memory semantics as concluded
> from a previous discussion here.
> 
> https://lkml.org/lkml/2018/10/9/220
> 
> [...]

Applied to arm64 (for-next/mm), thanks!

[1/2] arm64/mm: Change THP helpers to comply with generic MM semantics
      https://git.kernel.org/arm64/c/b65399f6111b
[2/2] arm64/mm: Enable THP migration
      https://git.kernel.org/arm64/c/53fa117bb33c

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
