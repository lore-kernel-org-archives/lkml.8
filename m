Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D628DC54F70
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 18:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8D252075E
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 18:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587319932;
	bh=dqSkdX+gADiKrEy242RtXCo5PPZGV6FUJ2j3yPTuXcY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=VuJFp6zbLY2VqnjgAuMZoBHfZF0QP25dEE/8FglW3MrO1xlI0+V/hrtysYIojxN1I
	 89G6v4SKWH1/IRQLGIdg2SQmHfUsvBQG0t/kwGIC0SbKEI1xKpkSbGU7Hm2ZsbDOTE
	 ZLsf1/F/0M+NlRrGRQp0xcHoohjThL3OMsv50J1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgDSSML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 14:12:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbgDSSML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 14:12:11 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E24BA2075E;
        Sun, 19 Apr 2020 18:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587319931;
        bh=dqSkdX+gADiKrEy242RtXCo5PPZGV6FUJ2j3yPTuXcY=;
        h=From:To:Cc:Subject:Date:From;
        b=QpEbxbg2/+LJ8hmCDGGO9pyYTcPrdzxO5nwkgyULS8lKeTHy2UIUAaqpe9f68gbq1
         wN2DhwC1h6FFPCQtQU67+2QliMWjP27hZBxI53ZA2hSe06bon1wZ5U95hBJOU2MQBM
         3khLF3xGkeSB0xOwBOAZ6iHLtPC5HFBHEDVl7JxU=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v5.7-rc1
Date:   Sun, 19 Apr 2020 11:12:10 -0700
Message-Id: <20200419181210.204996-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to ca6df49d62d7cc4c1653a4d9b1ecc61ecd530e02:

  clk: sprd: don't gate uart console clock (2020-04-13 12:20:07 -0700)

----------------------------------------------------------------
Two build fixes for a couple clk drivers and a fix for the Unisoc serial
clk where we want to keep it on for earlycon.

----------------------------------------------------------------
Arnd Bergmann (2):
      clk: asm9260: fix __clk_hw_register_fixed_rate_with_accuracy typo
      clk: mmp2: fix link error without mmp2

Chunyan Zhang (1):
      clk: sprd: don't gate uart console clock

 drivers/clk/clk-asm9260.c      |  2 +-
 drivers/clk/mmp/clk-pll.c      | 33 ++++++++++++++++++++++++++++++++-
 drivers/clk/mmp/clk.c          | 31 -------------------------------
 drivers/clk/mmp/clk.h          |  7 -------
 drivers/clk/sprd/sc9863a-clk.c |  3 ++-
 5 files changed, 35 insertions(+), 41 deletions(-)

-- 
Sent by a computer, using git, on the internet
