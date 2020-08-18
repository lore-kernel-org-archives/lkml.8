Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78A8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 10:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7B78204EA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 10:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597745764;
	bh=7QFow5W2s6oDQibtM0FiMFbpeiHnvbnbTZ/KkwlAH7c=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=fsUKEYE8n4GuD+4NgcH2HPtS3cZUlVodqJxZE32tQNSbsm5yHtoJalB96WyQ6/yDq
	 Tg0/PTpuZAILAyjEKk3dJhqqDdM78deyLLWd2zpso1J3nO9RnWNy0v1evh0mc0HhOm
	 mHC7OudrKUZcWBT2V1ABoECYZDb99UxkZMHPXhec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgHRKQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 06:16:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbgHRKQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 06:16:00 -0400
Received: from kernel.org (unknown [87.70.91.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07F04204EA;
        Tue, 18 Aug 2020 10:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597745760;
        bh=7QFow5W2s6oDQibtM0FiMFbpeiHnvbnbTZ/KkwlAH7c=;
        h=Date:From:To:Cc:Subject:From;
        b=yG92nWRztznaip7ezTK4uBpyp6hOjdEeVxJuN7k/vkBWNRTqANzekw0oIm+XDgmi7
         r5E6L9+DuVCUD5AAy+s0YCP+pWC79mdOZiJpYomubcdb9InBGgNKSOyj/Ehnh/tQQh
         VMB+r6jraqTX/90SnswAN3WuLj68h2TDlepqp8KE=
Date:   Tue, 18 Aug 2020 13:15:49 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jessica Clarke <jrtc27@jrtc27.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Fix regression in IA-64 caused by page table allocation
 refactoring
Message-ID: <20200818101549.GN752365@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock.git tags/fixes-2020-08-18

for you to fetch changes up to bd05220c7be3356046861c317d9c287ca50445ba:

  arch/ia64: Restore arch-specific pgd_offset_k implementation (2020-08-17 21:50:54 +0300)

----------------------------------------------------------------
Fix regression in IA-64 caused by page table allocation refactoring

The refactoring and consolidation of <asm/pgalloc.h> caused regression
on parisc and ia64. The fix for parisc made it into v5.9-rc1 while the
fix ia64 got delayed a bit and here it is.

----------------------------------------------------------------
Jessica Clarke (1):
      arch/ia64: Restore arch-specific pgd_offset_k implementation

 arch/ia64/include/asm/pgtable.h | 9 +++++++++
 include/linux/pgtable.h         | 2 ++
 2 files changed, 11 insertions(+)

-- 
Sincerely yours,
Mike.
