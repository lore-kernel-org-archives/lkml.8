Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA1AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 00:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3C4020888
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 00:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590627586;
	bh=vzFsK0uZn8FT7qx2c568pKl6hoqO6DKr1GFwtLmOzXw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=oQ/kaz3a8/QK18wYXNb0C8Q75Dj++ZvoirlKg1Wfdle4U9rZNGV/6GfBC2SWLENoT
	 FSA/Y9m9d59SCYB8guk7+V4MPM+liLnm0cbnAEBXJmZ7V4aBH0lNXao6AXXRoRUaOb
	 MfchFgoQqR4P5iOJZLeBdCgJb+a+aEyJgS3zGU94=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgE1A7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 20:59:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:35564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgE1A7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 20:59:45 -0400
Received: from guoren-Inspiron-7460.lan (unknown [89.208.247.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90CFE207CB;
        Thu, 28 May 2020 00:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590627584;
        bh=vzFsK0uZn8FT7qx2c568pKl6hoqO6DKr1GFwtLmOzXw=;
        h=From:To:Cc:Subject:Date:From;
        b=0fsjCmS+jQjb+yzf5tQemzRFuHLSODBnpUVwKmHxlu92C2mUBd6nV8KcRqy3E3+U+
         Ah5h5ZM9mEoozL/zlBE0941UNgIu2/EMWKfmT8/6mPKLNfEWyQ7sQd3Xn8Z2X9WhWa
         nOTWizI3n1yTsssTKQnk1bmqflnlO0PkE0T9TwYc=
From:   guoren@kernel.org
To:     torvalds@linux-foundation.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-csky@vger.kernel.org
Subject: [GIT PULL] csky updates for v5.7-rc8
Date:   Thu, 28 May 2020 08:59:32 +0800
Message-Id: <1590627572-10100-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the 4 fixups for v5.7-rc8.

Best Regards
 Guo Ren

The following changes since commit 9cb1fd0efd195590b828b9b865421ad345a4a145:

  Linux 5.7-rc7 (2020-05-24 15:32:54 -0700)

are available in the git repository at:

  https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.7-rc8

for you to fetch changes up to f36e0aab6f1f78d770ce859df3f07a9c5763ce5f:

  csky: Fixup CONFIG_DEBUG_RSEQ (2020-05-28 00:18:36 +0000)

----------------------------------------------------------------
csky updates for 5.7-rc8

Another 4 fixups for csky:
 - fixup req_syscall debug
 - fixup abiv2 syscall_trace
 - fixup preempt enable
 - Cleanup regs usage in entry.S

----------------------------------------------------------------
Guo Ren (4):
      csky: Fixup CONFIG_PREEMPT panic
      csky: Fixup abiv2 syscall_trace break a4 & a5
      csky: Coding convention in entry.S
      csky: Fixup CONFIG_DEBUG_RSEQ

 arch/csky/abiv1/inc/abi/entry.h     |   6 --
 arch/csky/abiv2/inc/abi/entry.h     |   8 +--
 arch/csky/include/asm/thread_info.h |   6 ++
 arch/csky/kernel/entry.S            | 117 ++++++++++++++++++------------------
 4 files changed, 66 insertions(+), 71 deletions(-)
