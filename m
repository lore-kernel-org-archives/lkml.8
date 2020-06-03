Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CE5C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 19:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E66812067B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 19:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgFCTbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 15:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgFCTbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 15:31:39 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9A7C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 12:31:38 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jgZ6l-002dSc-EA; Wed, 03 Jun 2020 19:31:27 +0000
Date:   Wed, 3 Jun 2020 20:31:27 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Ian Abbott <abbotti@mev.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [git pull] uaccess comedi compat
Message-ID: <20200603193127.GZ23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	comedi compat ioctls done saner (killing the single biggest pile
of __get_user/__put_user outside of arch/* in process).

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git uaccess.comedi

for you to fetch changes up to bac42fb21259783cb748ae54227a5e755340a396:

  comedi: get rid of compat_alloc_user_space() mess in COMEDI_CMD{,TEST} compat (2020-05-29 10:06:01 -0400)

----------------------------------------------------------------
Al Viro (10):
      comedi: move compat ioctl handling to native fops
      comedi: get rid of indirection via translated_ioctl()
      comedi: get rid of compat_alloc_user_space() mess in COMEDI_CHANINFO compat
      comedi: get rid of compat_alloc_user_space() mess in COMEDI_RANGEINFO compat
      comedi: get rid of compat_alloc_user_space() mess in COMEDI_INSN compat
      comedi: get rid of compat_alloc_user_space() mess in COMEDI_INSNLIST compat
      comedi: lift copy_from_user() into callers of __comedi_get_user_cmd()
      comedi: do_cmdtest_ioctl(): lift copyin/copyout into the caller
      comedi: do_cmd_ioctl(): lift copyin/copyout into the caller
      comedi: get rid of compat_alloc_user_space() mess in COMEDI_CMD{,TEST} compat

 drivers/staging/comedi/Makefile          |   1 -
 drivers/staging/comedi/comedi_compat32.c | 455 -------------------------
 drivers/staging/comedi/comedi_compat32.h |  28 --
 drivers/staging/comedi/comedi_fops.c     | 564 +++++++++++++++++++++++++------
 drivers/staging/comedi/comedi_internal.h |   2 +-
 drivers/staging/comedi/range.c           |  17 +-
 6 files changed, 467 insertions(+), 600 deletions(-)
 delete mode 100644 drivers/staging/comedi/comedi_compat32.c
 delete mode 100644 drivers/staging/comedi/comedi_compat32.h
