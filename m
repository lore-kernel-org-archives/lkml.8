Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8208C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C69E22070A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592476868;
	bh=d47JNBDZ8HjBsWecMHBNaWgIc0Y2d08em6JOHbbn70w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vFakF1IHl6v4EgBz2ybOOKfZJ+5A4ihXTylwhneXP0RGrvOBZFPTeLJZuMdUDmCCs
	 jnyHC7ZwX+fr7QMBtcIQFDFWUF4JwMRK2ZsHZ0cVembnptAc5FIb9LcmD80tE889kA
	 8GKgYbrGT/sZJ7uUIF4kQLmUdm9COuWPAsfGQnnA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbgFRKlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 06:41:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:39350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727037AbgFRKlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 06:41:00 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FF432078D;
        Thu, 18 Jun 2020 10:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592476860;
        bh=d47JNBDZ8HjBsWecMHBNaWgIc0Y2d08em6JOHbbn70w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dvbhEaD338Bux0jtW8vZs1CQenKznloBU9gk1WfzE6BY/OvDUdSQFkoaG7MXg45Oe
         eUWHMMeP7KHvWb9bpr9T9HswneWAolWQQKBMhpZCRXVEc9Rx0dt2LInqYLJbuX3L/I
         mWutvlef6ACRmIOOpuD8P7meyHqJaj+5xBrUVkik=
From:   Will Deacon <will@kernel.org>
To:     Barry Song <song.bao.hua@hisilicon.com>, nsaenzjulienne@suse.de,
        steve.capper@arm.com, catalin.marinas@arm.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, Matthias Brugger <matthias.bgg@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v3] arm64: mm: reserve hugetlb CMA after numa_init
Date:   Thu, 18 Jun 2020 11:40:48 +0100
Message-Id: <159247315562.10407.5629141346603814230.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200617215828.25296-1-song.bao.hua@hisilicon.com>
References: <20200617215828.25296-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jun 2020 09:58:28 +1200, Barry Song wrote:
> hugetlb_cma_reserve() is called at the wrong place. numa_init has not been
> done yet. so all reserved memory will be located at node0.

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: mm: reserve hugetlb CMA after numa_init
      https://git.kernel.org/arm64/c/618e07865b74

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
