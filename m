Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFE7C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 09:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B7520838
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 09:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583661179;
	bh=uI6wRp88u82M2uBM+594RPVrzMEJcS0P0ed+Qx0Vlpw=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=wjHtOwnSa/JGnN/ZcygxEmbBMj2GMPZPqAWNrwqum3hORwSQTfu/Q9sK1mKOyxL8x
	 sz996USIxXtgY7nz6CXlNdRZLf8oWP58GULXUnRpKkmmpn6/Kogp9bgZmknppxdoHc
	 qSXKCdUfpP7yKzkvf1TVqsoOHKvpfm7/pEOUyhUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgCHJw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 05:52:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:36746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgCHJw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 05:52:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79C9F20828;
        Sun,  8 Mar 2020 09:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583661176;
        bh=uI6wRp88u82M2uBM+594RPVrzMEJcS0P0ed+Qx0Vlpw=;
        h=Date:From:To:Cc:Subject:From;
        b=RHry37RbPKd4qMNIynP3Q4IuQz97/ytFdNoDIuj2CfUaFijTpe1E8SHUrkVFn6Cwj
         4ddRIBaHabmDetRpl+843yiuw2lc66PAKmQthvRrpgSZgj4i0lSmBu40J6P3XN+bab
         Mj9ntfs2VPAMbKDVCbGM2q4bcbc3wpxOqzFO9pbE=
Date:   Sun, 8 Mar 2020 10:52:54 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [GIT PULL] Driver core fixes for 5.6-rc5
Message-ID: <20200308095254.GA4027132@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.6-rc5

for you to fetch changes up to 77036165d8bcf7c7b2a2df28a601ec2c52bb172d:

  driver core: Skip unnecessary work when device doesn't have sync_state() (2020-03-04 13:46:03 +0100)

----------------------------------------------------------------
Driver core / debugfs fixes for 5.6-rc5

Here are 4 small driver core / debugfs patches for 5.6-rc3

They are:
	- debugfs api cleanup now that all callers for
	  debugfs_create_regset32() have been fixed up.  This was
	  waiting until after the -rc1 merge as these fixes came in
	  through different trees
	- driver core sync state fixes based on reports of minor issues
	  found in the feature

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Greg Kroah-Hartman (1):
      debugfs: remove return value of debugfs_create_regset32()

Saravana Kannan (3):
      driver core: Call sync_state() even if supplier has no consumers
      driver core: Add dev_has_sync_state()
      driver core: Skip unnecessary work when device doesn't have sync_state()

 Documentation/filesystems/debugfs.txt |  6 +++---
 drivers/base/core.c                   | 27 ++++++++++++++++++++-------
 fs/debugfs/file.c                     | 17 ++++-------------
 include/linux/debugfs.h               | 13 ++++++-------
 include/linux/device.h                | 11 +++++++++++
 5 files changed, 44 insertions(+), 30 deletions(-)
