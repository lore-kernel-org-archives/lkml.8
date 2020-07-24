Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8C5C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 11:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47D5A20737
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 11:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595591562;
	bh=a2lELlNFJabRxpw0GqSx4Oqhre5ASQ2xePNU+QvwQoc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=WdJ6YKiYbYaxvA3eddei9DoExbidDg0bE4ezYhV5r1VDOOeZbFanxJ1rcQx3Jhj1g
	 nMiZfelGoTSH/NgksVwtjZMJrsMLNRcEchr09Y7v7KLUWjoNsN4UsldV+EdJUPj7aa
	 Eb/2IFGbrW7fIdJCStivtPhdu8KaCpquB0VhiXnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgGXLwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 07:52:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbgGXLwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 07:52:40 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94D13206E3;
        Fri, 24 Jul 2020 11:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595591560;
        bh=a2lELlNFJabRxpw0GqSx4Oqhre5ASQ2xePNU+QvwQoc=;
        h=Date:From:To:Cc:Subject:From;
        b=xvlKKtI8oDrIkykhMuk26p1LGCyI36PFEFKyfOI7OO6gbO4dz/s/A+MmfjoyabaNQ
         akkPEnDS+yxIxBEvxYElYSd3ZPr0o++WvFH8qXU5sixMUPunjvO4wswX9Tmhkzip0S
         G1wSFTXSzZK+EQDUM2RVZUDfkyAOVjE5+VkA8nzI=
Date:   Fri, 24 Jul 2020 12:52:36 +0100
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, kernel-team@android.com
Subject: [GIT PULL] arm64 fix for -rc7
Message-ID: <20200724115236.GB17451@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this tiny arm64 fix for -rc7, which tells recent versions of
clang where to find the assembler for building the compat vDSO.

Cheers,

Will

--->8

The following changes since commit f32ed8eb0e3f0d0ef4ddb854554d60ca5863a9f9:

  drivers/perf: Prevent forced unbinding of PMU drivers (2020-07-17 10:51:44 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 7b7891c7bdfd61fc9ed6747a0a05efe2394dddc6:

  arm64: vdso32: Fix '--prefix=' value for newer versions of clang (2020-07-23 10:57:32 +0100)

----------------------------------------------------------------
arm64 fix for -rc7

- Fix compat vDSO build flags for recent versions of clang

----------------------------------------------------------------
Nathan Chancellor (1):
      arm64: vdso32: Fix '--prefix=' value for newer versions of clang

 arch/arm64/kernel/vdso32/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
