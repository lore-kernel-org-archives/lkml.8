Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EFBC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 11:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3C4221473
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 11:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593258047;
	bh=clnjadAF4ADdX1WmCkufYNPgpr0eqC+andCSc7+l0JQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=e3V2LZUqPGBWOusksNqnBjQXxRhVjXBP5rGPe9DHLJN+ejEi5sSBtAG15Ruq49M+6
	 8/8kRgF1w+cOSqJTVd77uQZUlxujOjICFIftFnY4hIXgvIV5Qo9MCbbcakjvnF5qzA
	 a3EqnX8Br+u+5raGYm8lJAMYnPdjAWOFCSkoHHVM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgF0Lkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 07:40:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:56836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbgF0Lko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 07:40:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F34E9206A5;
        Sat, 27 Jun 2020 11:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593258044;
        bh=clnjadAF4ADdX1WmCkufYNPgpr0eqC+andCSc7+l0JQ=;
        h=Date:From:To:Cc:Subject:From;
        b=to8LgUhu/SFif/XEQVFHl384DEKanxaIbW3QygIEGgt7ViI8q4fdpVzo3zFYI2/9V
         WrqGYZFV1NB/Rne8KWEEnmGrB7rdo7l7otxD+cx4o6erNCFUCTFvllVRN2HDu0ZXe7
         FE4qMIWZR/7o6kRbdlMVrXLx9eLRsIzwqBxKbZd8=
Date:   Sat, 27 Jun 2020 13:40:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Staging driver fixes for 5.8-rc3
Message-ID: <20200627114037.GA1637063@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.8-rc3

for you to fetch changes up to b65a2d8c8614386f7e8d38ea150749f8a862f431:

  Staging: rtl8723bs: prevent buffer overflow in update_sta_support_rate() (2020-06-16 21:25:38 +0200)

----------------------------------------------------------------
Staging driver fixes for 5.8-rc3

Here are a small number of tiny staging driver fixes for 5.8-rc3.

Not much here, but there were some reported problems to be fixed:
	- 3 wfx driver fixes
	- rtl8723bs driver fix

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Dan Carpenter (1):
      Staging: rtl8723bs: prevent buffer overflow in update_sta_support_rate()

Jérôme Pouiller (3):
      staging: wfx: fix AC priority
      staging: wfx: drop useless loop
      staging: wfx: fix coherency of hif_scan() prototype

 drivers/staging/rtl8723bs/core/rtw_wlan_util.c |  4 +++-
 drivers/staging/wfx/hif_tx.c                   |  6 ++++--
 drivers/staging/wfx/hif_tx.h                   |  2 +-
 drivers/staging/wfx/queue.c                    | 21 +++++++++------------
 drivers/staging/wfx/scan.c                     |  6 +++---
 5 files changed, 20 insertions(+), 19 deletions(-)
