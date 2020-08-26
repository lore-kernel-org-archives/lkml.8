Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F2AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73E0C2177B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598449399;
	bh=Usry8lMIVew1NYhp5JNI5XF5OA4Tqv1LJTvuEDx2kqY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=NoBu16lAFM8SXkad48XNvDSAINx4Q3e3FFL57THnnRTjVtkcS34RkIMdT9pUoujJv
	 mAPtOn2XAmCCC9iZS+cboCaCuhWlYGe68RGijWzTPlIJM5Mx36rQr+uafdP2g2+fDg
	 j70YOzRdStPhnP4L91/8nBZ9MKECBIEN0TMvUkX0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbgHZNnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:43:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730290AbgHZNl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 09:41:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9F0C208E4;
        Wed, 26 Aug 2020 13:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598449317;
        bh=Usry8lMIVew1NYhp5JNI5XF5OA4Tqv1LJTvuEDx2kqY=;
        h=Date:From:To:Cc:Subject:From;
        b=W3rhiy+51Lcm2sbbAkgabvzYVULScPCUOxjJOQP5VkI9pBagEdXqnG6F4qNVGxIhz
         oNG2LJNT3wspOETBywziwnLc238UbDYj5HFU6vmC2aiuyVCJTTl3XDrS7KFkaLWW10
         qKv6Oi8DEt3jp6rsxgpmCcpzveqplMPHb4yTHziI=
Date:   Wed, 26 Aug 2020 15:42:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.9-rc3
Message-ID: <20200826134211.GA3881983@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.9-rc3

for you to fetch changes up to 9c97cecab0d49e40460d9b5230ab4bf036f59491:

  Merge tag 'misc-habanalabs-fixes-2020-08-22' of git://people.freedesktop.org/~gabbayo/linux into char-misc-linus (2020-08-23 13:20:47 +0200)

----------------------------------------------------------------
Char/Misc driver fixes for 5.9-rc3

Here are some small char and misc and other driver subsystem fixes for
5.9-rc3.

The majority of these are tiny habanalabs driver fixes, but also in here
are:
	- speakup build fixes now that it is out of staging and got
	  exposed to more build systems all of a sudden
	- mei driver fix

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Colin Ian King (1):
      habanalabs: fix incorrect check on failed workqueue create

Dan Carpenter (2):
      habanalabs: Fix memory corruption in debugfs
      habanalabs: Fix a loop in gaudi_extract_ecc_info()

Greg Kroah-Hartman (1):
      Merge tag 'misc-habanalabs-fixes-2020-08-22' of git://people.freedesktop.org/~gabbayo/linux into char-misc-linus

Oded Gabbay (1):
      habanalabs: set max power according to card type

Ofir Bitton (9):
      habanalabs: unmap PCI bars upon iATU failure
      habanalabs: Validate user address before mapping
      habanalabs: validate packet id during CB parse
      habanalabs: verify user input in cs_ioctl_signal_wait
      habanalabs: set clock gating according to mask
      habanalabs: proper handling of alloc size in coresight
      habanalabs: validate FW file size
      habanalabs: check correct vmalloc return code
      habanalabs: correctly report inbound pci region cfg error

Samuel Thibault (2):
      speakup: Fix wait_for_xmitr for ttyio case
      speakup: only build serialio when ISA is enabled

Tomas Winkler (1):
      mei: hdcp: fix mei_hdcp_verify_mprime() input parameter

 drivers/accessibility/speakup/Kconfig              | 13 ++-
 drivers/accessibility/speakup/Makefile             |  2 +-
 drivers/accessibility/speakup/serialio.c           |  8 +-
 drivers/accessibility/speakup/spk_priv.h           |  1 -
 drivers/accessibility/speakup/spk_ttyio.c          |  7 ++
 drivers/accessibility/speakup/spk_types.h          |  1 +
 drivers/accessibility/speakup/synth.c              |  2 +-
 drivers/misc/habanalabs/common/command_buffer.c    | 16 +++-
 .../misc/habanalabs/common/command_submission.c    |  8 ++
 drivers/misc/habanalabs/common/debugfs.c           |  8 +-
 drivers/misc/habanalabs/common/device.c            |  9 ++-
 drivers/misc/habanalabs/common/firmware_if.c       |  9 +++
 drivers/misc/habanalabs/common/habanalabs.h        |  7 +-
 drivers/misc/habanalabs/common/memory.c            |  9 ++-
 drivers/misc/habanalabs/common/mmu.c               |  2 +-
 drivers/misc/habanalabs/common/pci.c               |  8 +-
 drivers/misc/habanalabs/common/sysfs.c             |  7 +-
 drivers/misc/habanalabs/gaudi/gaudi.c              | 92 ++++++++++++++++------
 drivers/misc/habanalabs/gaudi/gaudiP.h             |  3 +-
 drivers/misc/habanalabs/gaudi/gaudi_coresight.c    |  8 +-
 drivers/misc/habanalabs/goya/goya.c                | 31 ++++++++
 drivers/misc/habanalabs/goya/goya_coresight.c      |  8 +-
 drivers/misc/mei/hdcp/mei_hdcp.c                   | 40 ++++++----
 23 files changed, 226 insertions(+), 73 deletions(-)
