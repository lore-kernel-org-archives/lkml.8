Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C131DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F3B82087C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596198673;
	bh=Y+uzvw6La8cpDyqZxCJoUnVBzBginAmYSHNOecgvji4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=K8ax3QutyxtziIVlOuyk0Lu1rsK0IxF4H7IjcWaPFHqX9AfdV9zwSBU4xMYL8qLyK
	 fexGiprqsGF/wS88guRoW7qrTqgQ12tMXyvbPd+osD38q4wqncHjNurlBjxI7a+Oll
	 xDI5uvQ+1TF2NXi991Gg4UnjPaxP6VFDEMetlGqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733247AbgGaMbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:31:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:45794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733237AbgGaMbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:31:10 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D14A4206FA;
        Fri, 31 Jul 2020 12:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596198669;
        bh=Y+uzvw6La8cpDyqZxCJoUnVBzBginAmYSHNOecgvji4=;
        h=Date:From:To:Cc:Subject:From;
        b=nTBWdNVUo3KHaVJT+yHTWbJdo0gaFtFkILm9N9DT60KOENe3krIbNlX3xenn3jlTF
         mvXl++gsTEYGVYgK+yrR6Xhvw832LG9tcJtYpgJXSHuE19ux0XWhWRMV2Bd6J2oUDH
         y1BpkT2jRA/fQx1DeWi3p8ZadDJg2nlQm+4pf5dg=
Date:   Fri, 31 Jul 2020 13:31:05 +0100
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc8/final
Message-ID: <20200731123105.GB26817@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these arm64 fixes for -rc8/final. The main one is to fix the
build after Willy's per-cpu entropy changes this week. Although that was
already resolved elsewhere, the arm64 fix here is useful cleanup anyway.
Other than that, we've got a fix for building with Clang's integrated
assembler and a fix to make our IPv4 checksumming robust against invalid
header lengths (this only seems to be triggerable by injected errors).

Cheers,

Will

--->8

The following changes since commit 7b7891c7bdfd61fc9ed6747a0a05efe2394dddc6:

  arm64: vdso32: Fix '--prefix=' value for newer versions of clang (2020-07-23 10:57:32 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 6a7389f0312f01bb6641d37b395548a2922a057c:

  MAINTAINERS: Include drivers subdirs for ARM PMU PROFILING AND DEBUGGING entry (2020-07-30 17:05:34 +0100)

----------------------------------------------------------------
arm64 fixes for -rc8

- Fix build breakage due to circular headers

- Fix build regression when using Clang's integrated assembler

- Fix IPv4 header checksum code to deal with invalid length field

- Fix broken path for Arm PMU entry in MAINTAINERS

----------------------------------------------------------------
John Garry (1):
      MAINTAINERS: Include drivers subdirs for ARM PMU PROFILING AND DEBUGGING entry

Marc Zyngier (1):
      arm64: Drop unnecessary include from asm/smp.h

Robin Murphy (1):
      arm64: csum: Fix handling of bad packets

Sami Tolvanen (1):
      arm64/alternatives: move length validation inside the subsection

 MAINTAINERS                          | 2 +-
 arch/arm64/include/asm/alternative.h | 4 ++--
 arch/arm64/include/asm/checksum.h    | 5 +++--
 arch/arm64/include/asm/smp.h         | 1 -
 4 files changed, 6 insertions(+), 6 deletions(-)
