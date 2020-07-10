Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F850C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13CE920836
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgGJP3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 11:29:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:52140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbgGJP3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 11:29:12 -0400
Received: from localhost.localdomain (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F090120720;
        Fri, 10 Jul 2020 15:29:10 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     will@kernel.org, Zhenyu Ye <yezhenyu2@huawei.com>
Cc:     arm@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xiexiangyou@huawei.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1] arm64: tlb: don't set the ttl value in flush_tlb_page_nosync
Date:   Fri, 10 Jul 2020 16:29:08 +0100
Message-Id: <159439494095.22236.16676727348403184772.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200710094158.468-1-yezhenyu2@huawei.com>
References: <20200710094158.468-1-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jul 2020 17:41:58 +0800, Zhenyu Ye wrote:
> flush_tlb_page_nosync() may be called from pmd level, so we
> can not set the ttl = 3 here.
> 
> The callstack is as follows:
> 
> 	pmdp_set_access_flags
> 		ptep_set_access_flags
> 			flush_tlb_fix_spurious_fault
> 				flush_tlb_page
> 					flush_tlb_page_nosync

Applied to arm64 (for-next/tlbi), thanks!

[1/1] arm64: tlb: don't set the ttl value in flush_tlb_page_nosync
      https://git.kernel.org/arm64/c/61c11656b67b

-- 
Catalin

