Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904E1C35647
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C8324650
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582285216;
	bh=0BteZ3cvD0FiYJiJlkZtpdTnBefQoYZkoo1WGUR0x5g=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=v5dDGwr2T2Nwpdro35Eh4heFkFQUP2ikpaNC94ehf7C5ECmPrmCV+/3D26JprU5kL
	 7l6K6uudEIL9rn54hHDxV84iucTQXn59XdMFlyMdNBCt5DyTFyJQSu5MKXuBOj4en5
	 hiyqr94VNl6CzVSxxOwOvB5Xo7kPvS1nTOIk0dGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgBULkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 06:40:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:42050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbgBULkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 06:40:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D88DA222C4;
        Fri, 21 Feb 2020 11:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582285214;
        bh=0BteZ3cvD0FiYJiJlkZtpdTnBefQoYZkoo1WGUR0x5g=;
        h=Date:From:To:Cc:Subject:From;
        b=UNcv92s/g5i0DMnz1EQ4tFgY0XJeQvxF4lHxtoT2ce2qSjWdsPuP39zE1bAbchgB2
         orLZEl40LLAoDyai1KJZgUp3u8UqGD4yD6SfVMFVEFPuUQjCLFU5OFFwOqhhOx8umV
         dmHA0pQbVT0ebKnsMAHpRA89CbLdHe+Fm9Bk8Vw4=
Date:   Fri, 21 Feb 2020 12:40:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.6-rc3
Message-ID: <20200221114012.GA114392@kroah.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.6-rc3

for you to fetch changes up to 74ba569a15a08b988bc059ad515980f51e85be79:

  Merge tag 'misc-habanalabs-fixes-2020-02-11' of git://people.freedesktop.org/~gabbayo/linux into char-misc-linus (2020-02-17 11:58:16 +0100)

----------------------------------------------------------------
Char/Misc fixes for 5.6-rc3

Here are some small char/misc driver fixes for 5.6-rc3.

Also included in here are some updates for some documentation files that
I seem to be maintaining these days.

The driver fixes are:
  - small fixes for the habanalabs driver
  - fsi driver bugfix

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Bartosz Golaszewski (1):
      MAINTAINERS: remove unnecessary ':' characters

Brendan Higgins (1):
      fsi: aspeed: add unspecified HAS_IOMEM dependency

Grant Likely (1):
      Documentation/process: Add Arm contact for embargoed HW issues

Greg Kroah-Hartman (3):
      embargoed-hardware-issues: drop Amazon contact as the email address now bounces
      COPYING: state that all contributions really are covered by this file
      Merge tag 'misc-habanalabs-fixes-2020-02-11' of git://people.freedesktop.org/~gabbayo/linux into char-misc-linus

James Morris (1):
      Documentation/process: Change Microsoft contact for embargoed hardware issues

Oded Gabbay (2):
      habanalabs: halt the engines before hard-reset
      habanalabs: patched cb equals user cb in device memset

Omer Shpigelman (1):
      habanalabs: do not halt CoreSight during hard reset

Tyler Hicks (1):
      Documentation/process: Swap out the ambassador for Canonical

 COPYING                                            |  2 +
 .../process/embargoed-hardware-issues.rst          |  8 ++--
 .../zh_CN/process/embargoed-hardware-issues.rst    |  2 +-
 MAINTAINERS                                        | 22 +++++------
 drivers/fsi/Kconfig                                |  1 +
 drivers/misc/habanalabs/device.c                   |  5 ++-
 drivers/misc/habanalabs/goya/goya.c                | 44 +++++++++++++++++++++-
 7 files changed, 65 insertions(+), 19 deletions(-)
