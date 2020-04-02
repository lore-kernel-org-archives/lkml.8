Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686A3C2BA12
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C3420719
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585844163;
	bh=5sJ1neYRlFfnjmBdPQnALhSYTIW7R6idfr1HV3eUbLU=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=WCWAYvt3lBwwKmpPoDxs0vnhr6ubCLIE9ciuP8RAKTs9QWB27DD8LSxVjtaVqrSOF
	 2EKj4husoAie2hGv4TzrOvdwHBVYW834bN0KZytDF2nwQBcNAmsseiwYOqLjzm0iGk
	 y8eLah9ckpQRjPUhfTIKtfRONNcRmpPtATpny5sg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389805AbgDBQQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 12:16:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:57414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389294AbgDBQQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 12:16:02 -0400
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A046206F6;
        Thu,  2 Apr 2020 16:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585844161;
        bh=5sJ1neYRlFfnjmBdPQnALhSYTIW7R6idfr1HV3eUbLU=;
        h=Date:From:To:Cc:Subject:From;
        b=YuhxEisGg+czlF11Le0CA11rrUCK7T8ASCuF1CFQHyBEUJrvTq/rCB1UujzNyDe1X
         VjK4w+H39cMykLfIt/aFcG9POPQyRHDTTx/mRNNjdzufzincHrkhof11UNEtV2F9Om
         HASncbRRl6laAeF0bd5jKvhXhvlj30rEOQLT8gBM=
Date:   Thu, 2 Apr 2020 09:16:00 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, domenico.andreoli@linux.com
Subject: [GIT PULL] vfs: bug fix for 5.7
Message-ID: <20200402161600.GI80283@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this single vfs bug fix into 5.7 to fix a regression in
userspace hibernation now that the vfs doesn't really allow userspace to
write to active swap devices anymore.

--D

The following changes since commit 98d54f81e36ba3bf92172791eba5ca5bd813989b:

  Linux 5.6-rc4 (2020-03-01 16:38:46 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/vfs-5.7-merge-1

for you to fetch changes up to 56939e014a6c212b317414faa307029e2e80c3b9:

  hibernate: Allow uswsusp to write to swap (2020-03-23 08:22:15 -0700)

----------------------------------------------------------------
New code for 5.7:
 - Fix a regression where we broke the userspace hibernation driver by
   disallowing writes to the swap device.

----------------------------------------------------------------
Domenico Andreoli (1):
      hibernate: Allow uswsusp to write to swap

 fs/block_dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
