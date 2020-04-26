Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66497C55199
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 10:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4302F2071C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 10:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587898019;
	bh=2L369ClarAU5q22Tp7/oXWac72EQxXgYsmeHOPmWQf8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=SvGLm0Q+E2y6TReMEzx+zPfcj8fVgT7VaQJ6HkKDs6fPkATOYLRhdkiXvKTvfWLgK
	 i6Pr6EYJl1371k3P2UdL06ta6OVZ1iZvOfhFTd0fUbc1kFo/BmR6tJCY9V6ruD2xYT
	 7lb4AVPg0E0FAPYVRVAjZeGzaoSjrCO++qM0Zfq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgDZKq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 06:46:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbgDZKq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 06:46:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10F692070A;
        Sun, 26 Apr 2020 10:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587898017;
        bh=2L369ClarAU5q22Tp7/oXWac72EQxXgYsmeHOPmWQf8=;
        h=Date:From:To:Cc:Subject:From;
        b=K9JR8Zjj0rJUEuU7AAR/yQN3L8Zxlf+LdnKP55SykkXdmBtjvU55C5/950SmZUGKy
         Q2Kd33dmIivzhT3aLBwZ4AOO0eWxsrI35lXzaUptTFGQeZqgbDYOR39abaqY/TuCE2
         h3/xmf3gy7CAheS3sjdRps1/MkcWaZ3f7A2J+YhM=
Date:   Sun, 26 Apr 2020 12:46:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [GIT PULL] Driver core fixes for 5.7-rc3
Message-ID: <20200426104655.GA2120547@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.7-rc3

for you to fetch changes up to 5a3577039cbe0bbb8e7a12d2790e23039b8a8618:

  firmware_loader: revert removal of the fw_fallback_config export (2020-04-26 10:42:15 +0200)

----------------------------------------------------------------
Driver core fixes for 5.7-rc3

Here are some small firmware/driver core/debugfs fixes for 5.7-rc3.

The debugfs change is now possible as now the last users of
debugfs_create_u32() have been fixed up in the different trees that got
merged into 5.7-rc1, and I don't want it creeping back in.

The firmware changes did cause a regression in linux-next, so the final
patch here reverts part of that, re-exporting the symbol to resolve that
issue.  All of these patches, with the exception of the final one, have
been in linux-next with only that one reported issue.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Arnd Bergmann (1):
      firmware: imx: fix compile-testing

Christoph Hellwig (1):
      firmware_loader: remove unused exports

Greg Kroah-Hartman (1):
      debugfs: remove return value of debugfs_create_u32()

Luis Chamberlain (1):
      firmware_loader: revert removal of the fw_fallback_config export

 Documentation/filesystems/debugfs.rst         |  4 ++--
 drivers/base/firmware_loader/fallback_table.c |  1 -
 drivers/firmware/imx/Kconfig                  |  4 ++--
 fs/debugfs/file.c                             | 15 +++------------
 include/linux/debugfs.h                       | 12 ++++--------
 5 files changed, 11 insertions(+), 25 deletions(-)
