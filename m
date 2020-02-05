Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B1BC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 23:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F4821927
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 23:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580945284;
	bh=awZGcHfkIWwCNetTyJ7pCMgAfv9Tbgmgd2mWkjeCIkU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=FsEtUZXqa3wp8K9hObTiYR5nmczqsl50nxQ8qgQkUxiQuTKybkYGU0cypSrrbkzzE
	 b92asOILD6jDJPo4GO8cnQP85/aPCw2XTqOOgJtqoOtkfF0Pp3e20OVXZUnlyQHTPP
	 IUZfdBVvr1MyBY/g4MFknGgMdVO9Ic4HTDqR61nE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgBEX2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 18:28:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:38352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727415AbgBEX2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 18:28:03 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2C272082E;
        Wed,  5 Feb 2020 23:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580945283;
        bh=awZGcHfkIWwCNetTyJ7pCMgAfv9Tbgmgd2mWkjeCIkU=;
        h=From:To:Cc:Subject:Date:From;
        b=TL/pHUWzLi76ObaKjZv+aXgGODVi4TZyhVo81ye1yStcxnw0fQ1DlgV9AFIWsESzY
         WlARgIf8g6TcKYggpDQpQIs8lVdMaL2rogYtTOfXsla69mf0CfXNZkgEvNQYSfZL4d
         rMh9K7aP/g3ACjo9DkjRablK42KjZkCT1112SgqE=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v2 0/4] clk_phase error caching problems
Date:   Wed,  5 Feb 2020 15:27:58 -0800
Message-Id: <20200205232802.29184-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is a follow up to[1] which I sent out a few months
ago. We no longer cache the clk phase if it's an error value, so that
things like debugfs don't return us nonsense values for the phase.

Futhermore, the last patch fixes up the locking so that debugfs code
can avoid doing a recursive prepare lock because we know what we're
doing in that case. While we get some more functions, we avoid taking
the lock again.

Changes from v1:
 * A pile of new patches
 * Rebased to clk-next
 * New patch to bail out of registration if getting the phase fails

Cc: Douglas Anderson <dianders@chromium.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Jerome Brunet <jbrunet@baylibre.com>

Stephen Boyd (4):
  clk: Don't cache errors from clk_ops::get_phase()
  clk: Use 'parent' to shorten lines in __clk_core_init()
  clk: Move rate and accuracy recalc to mostly consumer APIs
  clk: Bail out when calculating phase fails during clk registration

 drivers/clk/clk.c | 119 +++++++++++++++++++++++++++-------------------
 1 file changed, 70 insertions(+), 49 deletions(-)

[1] https://lkml.kernel.org/r/20191001174439.182435-1-sboyd@kernel.org

base-commit: 5df867145f8adad9e5cdf9d67db1fbc0f71351e9
-- 
Sent by a computer, using git, on the internet

