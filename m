Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92203C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 14:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC3E2070A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 14:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584714503;
	bh=0niX5yJhBANk5/IEJUjBttVj9AstOui80GiFGQ6iwkE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=YJHZ9Bvp01X+4cCVU7mf0wDcb3QPv2J/LccknaPFl01a9iDR6EsiqlW4fM7GQWI0f
	 aE2ucClk7pa5LcQ+BpriV15YT5yApE0yRPptMj4y0V9FR6zHrdbifZc5IWi6TbCxnR
	 94vI8XISPe/KOGck/HAuhLEdDax+je7vqo7BtiMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbgCTO2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 10:28:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727268AbgCTO2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 10:28:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 808BF2070A;
        Fri, 20 Mar 2020 14:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584714501;
        bh=0niX5yJhBANk5/IEJUjBttVj9AstOui80GiFGQ6iwkE=;
        h=Date:From:To:Cc:Subject:From;
        b=IUP1yYbidOW/x1rfheQYwcL0GIwF07vM+U3bBMFBiRPzAtc2Vy0mdGbiaInfM1YLR
         mP4IdOu/E9J9s4LXcSGf/kqvdat5DtWWIAbLqy7jsceZ/BFAvUk/2WivYh2qG5blNc
         LbZEHw6Z5j3U8IBSpmWuqaWqx2HT0KCXnwacenNY=
Date:   Fri, 20 Mar 2020 15:28:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.6-rc7
Message-ID: <20200320142818.GA760640@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2c523b344dfa65a3738e7039832044aa133c75fb:

  Linux 5.6-rc5 (2020-03-08 17:44:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.6-rc7

for you to fetch changes up to add492d2e9446a77ede9bb43699ec85ca8fc1aba:

  intel_th: pci: Add Elkhart Lake CPU support (2020-03-18 11:32:56 +0100)

----------------------------------------------------------------
Char/misc driver fixes for 5.6-rc7

Here are some small different driver fixes for 5.6-rc7
  - binderfs fix, yet again
  - slimbus new device id added
  - hwtracing bugfixes for reported issues and a new device id

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Shishkin (4):
      stm class: sys-t: Fix the use of time_after()
      intel_th: msu: Fix the unexpected state warning
      intel_th: Fix user-visible error codes
      intel_th: pci: Add Elkhart Lake CPU support

Christian Brauner (1):
      binderfs: use refcount for binder control devices too

Srinivas Kandagatla (1):
      slimbus: ngd: add v2.1.0 compatible

 drivers/android/binderfs.c       |  1 +
 drivers/hwtracing/intel_th/msu.c | 13 +++++++------
 drivers/hwtracing/intel_th/pci.c |  5 +++++
 drivers/hwtracing/stm/p_sys-t.c  |  6 +++---
 drivers/slimbus/qcom-ngd-ctrl.c  |  3 +++
 5 files changed, 19 insertions(+), 9 deletions(-)
