Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7DAC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 14:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AE9624957
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 14:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588947515;
	bh=53LwO8rnv+vb4J1WHGH9CksX2tbljO195oAcSXz+zfg=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=NU9AWqMDV/ZhOHKHr6u95vYNVhOopRhKEJZC3svOEWzQy+ZgHbGSToGrlaqwkxY4B
	 lGbek5IZNZU97sfrgy3lJ0BL3wW+m1HGrF4z+sAd1SnR1clP1sVLhMcV19422VFrMp
	 wf2J4ofUL8QbrvCxIrzpoxauCHPSSYBlMDG2Nlbg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgEHOSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 10:18:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:36192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbgEHOSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 10:18:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB41E207DD;
        Fri,  8 May 2020 14:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588947512;
        bh=53LwO8rnv+vb4J1WHGH9CksX2tbljO195oAcSXz+zfg=;
        h=Date:From:To:Cc:Subject:From;
        b=pUuLUk6gufSxT23nM59YWonLFjs8D5FMFjfV37pt4j1l+KlS/50UuqqBld5K+leUf
         oz/Lu+6lLdvrU4Rnl7n8n61g2hVoiCKUMGNgMfl0ddRuhZSYNo7dCWoTT/Z/tZC5eY
         W5LMRNeapFSWBjgTYUspmmajeA+O2+VkX0f5vVzg=
Date:   Fri, 8 May 2020 16:18:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [GIT PULL] Driver core fixes for 5.7-rc5
Message-ID: <20200508141830.GA357188@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6a8b55ed4056ea5559ebe4f6a4b247f627870d4c:

  Linux 5.7-rc3 (2020-04-26 13:51:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.7-rc5

for you to fetch changes up to 2a15483b401c0b07e44b43b95414e36f32c02f32:

  regulator: Revert "Use driver_deferred_probe_timeout for regulator_init_complete_work" (2020-04-29 19:57:45 +0200)

----------------------------------------------------------------
Driver core fixes for 5.7-rc5

Here are a number of small driver core fixes for 5.7-rc5 to resolve a
bunch of reported issues with the current tree.

Biggest here are the reverts and patches from John Stultz to resolve a
bunch of deferred probe regressions we have been seeing in 5.7-rc right
now.

Along with those are some other smaller fixes:
	- coredump crash fix
	- devlink fix for when permissive mode was enabled
	- amba and platform device dma_parms fixes
	- component error silenced for when deferred probe happens

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
James Hilliard (1):
      component: Silence bind error on -EPROBE_DEFER

John Stultz (4):
      driver core: Revert default driver_deferred_probe_timeout value to 0
      driver core: Use dev_warn() instead of dev_WARN() for deferred_probe_timeout warnings
      driver core: Ensure wait_for_device_probe() waits until the deferred_probe_timeout fires
      regulator: Revert "Use driver_deferred_probe_timeout for regulator_init_complete_work"

Luis Chamberlain (1):
      coredump: fix crash when umh is disabled

Saravana Kannan (1):
      driver core: Fix handling of fw_devlink=permissive

Ulf Hansson (2):
      driver core: platform: Initialize dma_parms for platform devices
      amba: Initialize dma_parms for amba devices

 drivers/amba/bus.c              |  1 +
 drivers/base/component.c        |  8 +++++---
 drivers/base/core.c             |  7 ++++++-
 drivers/base/dd.c               | 20 ++++++++------------
 drivers/base/platform.c         |  2 ++
 drivers/regulator/core.c        | 25 +++++++++++--------------
 fs/coredump.c                   |  8 ++++++++
 include/linux/amba/bus.h        |  1 +
 include/linux/platform_device.h |  1 +
 kernel/umh.c                    |  5 +++++
 10 files changed, 48 insertions(+), 30 deletions(-)
