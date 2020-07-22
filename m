Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F92AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 14:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0558220709
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 14:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fMGg4E7N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbgGVOLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 10:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbgGVOLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 10:11:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C79AC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 07:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=uFFH4Xq1BWwBgm4mlKSS6V8FjQkrdMjX6cr2JU/SzoA=; b=fMGg4E7NO/xdGGEvfiDkDQnn2U
        m05LcXSsIid9eL958AfEGFx/JOeXSz1oFp4fXYgDUbLaAMGOZKuj6CRtzUPbojgZZ113UHcWiqlMm
        BK7u54Y+VSW3F+gsovxfXtG1uRhsyTHK4gQRP+pmXOEOI3Vr1nX5T40EERgpqFxVUnof1Ybci3Z9E
        mQmsHI07wD4uXqQhtF492y8juvMmsrX6gAmgPzMn6nZP5geT0lhzBQkLM7nkpHerNjzzUuH/fPD1I
        sr69bRy8O6FQ8WS0gwYxG00UrdGHTbirl35ySrF3MUaw8S5+lC4Te3ncSgx45SLpH3pQtlQWz0S5x
        jXaAikgA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyFTL-0005FL-3p; Wed, 22 Jul 2020 14:11:51 +0000
Date:   Wed, 22 Jul 2020 15:11:51 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] XArray for 5.8
Message-ID: <20200722141151.GO15516@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 4fa640dc52302b5e62b01b05c755b055549633ae:

  Merge tag 'vfio-v5.8-rc7' of git://github.com/awilliam/linux-vfio into master (2020-07-20 13:30:59 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/willy/xarray.git tags/xarray-5.8

for you to fetch changes up to f177a7956685320eef43d248d39f61a74290f031:

  XArray: Test multiorder marked iteration (2020-07-22 09:58:48 -0400)

----------------------------------------------------------------
XArray updates for 5.8

 - Fix the test suite after introduction of the local_lock
 - Fix a bug in the IDA spotted by Coverity
 - Add a few more tests to the test suite

----------------------------------------------------------------
Matthew Wilcox (Oracle) (4):
      radix tree test suite: Fix compilation
      ida: Free allocated bitmap in error path
      XArray: Test two more things about xa_cmpxchg
      XArray: Test multiorder marked iteration

 include/linux/radix-tree.h                  |  3 ++-
 lib/idr.c                                   |  1 +
 lib/radix-tree.c                            |  1 -
 lib/test_xarray.c                           | 25 +++++++++++++++++++++++++
 tools/testing/radix-tree/idr-test.c         | 29 +++++++++++++++++++++++++++++
 tools/testing/radix-tree/linux/kernel.h     |  1 +
 tools/testing/radix-tree/linux/local_lock.h |  8 ++++++++
 tools/testing/radix-tree/test.h             |  4 ----
 8 files changed, 66 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/radix-tree/linux/local_lock.h

