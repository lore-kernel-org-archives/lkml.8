Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D00AC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 14:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A57E206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 14:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgGOOOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 10:14:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbgGOOOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 10:14:47 -0400
Received: from localhost.localdomain (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B4CD2065D;
        Wed, 15 Jul 2020 14:14:45 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>, robin.murphy@arm.com,
        Barry Song <song.bao.hua@hisilicon.com>,
        linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH V3] arm64/hugetlb: Reserve CMA areas for gigantic pages on 16K and 64K configs
Date:   Wed, 15 Jul 2020 15:14:43 +0100
Message-Id: <159482247206.6053.9810199700278348926.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1593578521-24672-1-git-send-email-anshuman.khandual@arm.com>
References: <1593578521-24672-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jul 2020 10:12:01 +0530, Anshuman Khandual wrote:
> Currently 'hugetlb_cma=' command line argument does not create CMA area on
> ARM64_16K_PAGES and ARM64_64K_PAGES based platforms. Instead, it just ends
> up with the following warning message. Reason being, hugetlb_cma_reserve()
> never gets called for these huge page sizes.
> 
> [   64.255669] hugetlb_cma: the option isn't supported by current arch
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/hugetlb: Reserve CMA areas for gigantic pages on 16K and 64K configs
      https://git.kernel.org/arm64/c/abb7962adc80

-- 
Catalin

