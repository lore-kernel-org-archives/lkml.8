Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC94C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 462BA20756
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgEORYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 13:24:50 -0400
Received: from foss.arm.com ([217.140.110.172]:59964 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbgEORYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 13:24:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2FEF1042;
        Fri, 15 May 2020 10:24:48 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 161EA3F305;
        Fri, 15 May 2020 10:24:47 -0700 (PDT)
Date:   Fri, 15 May 2020 18:24:45 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hch@lst.de
Subject: [GIT PULL] arm64 fixes for 5.7-rc6
Message-ID: <20200515172443.GA1749@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 fix below. Thanks.

The following changes since commit 027d0c7101f50cf03aeea9eebf484afd4920c8d3:

  arm64: hugetlb: avoid potential NULL dereference (2020-05-07 09:24:15 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to d51c214541c5154dda3037289ee895ea3ded5ebd:

  arm64: fix the flush_icache_range arguments in machine_kexec (2020-05-11 12:02:14 +0100)

----------------------------------------------------------------
Fix flush_icache_range() second argument in machine_kexec() to be an
address rather than size.

----------------------------------------------------------------
Christoph Hellwig (1):
      arm64: fix the flush_icache_range arguments in machine_kexec

 arch/arm64/kernel/machine_kexec.c | 1 +
 1 file changed, 1 insertion(+)

-- 
Catalin
