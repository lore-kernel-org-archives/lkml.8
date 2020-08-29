Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4510EC433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 17:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FA3C20838
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 17:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598722262;
	bh=/SI0obcZq9bkPaoP0Z619Tex4rORpqWPy8a2rewpEh8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=JEgc3lEOj1iPIXOpk3QO2/ftEhcw1ACnIxSBPjeXMKurFz+7PNZYP09eX5QjA6Hsw
	 TaGycxEByaRy9cytXRFNQ5ZPRvptRT/uAkJ2VENpfTHRoK1lvmgmYyiJYrH1L40nxg
	 YvSspr2F44m+N4D+H33Wb69M1YU1ywL//+HFDaDk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgH2Ra7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 13:30:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:36194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728139AbgH2Ra5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 13:30:57 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00F3B20757;
        Sat, 29 Aug 2020 17:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598722257;
        bh=/SI0obcZq9bkPaoP0Z619Tex4rORpqWPy8a2rewpEh8=;
        h=Date:From:To:Cc:Subject:From;
        b=MyOcuZX6DM3iSiz1YXtse4HetaQK/fsw5AAhnLAijmEewifPAWgxXW6RSKcrZDSbE
         XaSBFhqI2N3uHpQBcdypL4kR0IVXSwI8mQw+oxBvJTLaW9FtpMU8Sc1mvNa+kPptRt
         m5g9FwRKi4prerZ7nFbkLnDoapr+pRvtq1w89SyA=
Date:   Sat, 29 Aug 2020 12:37:02 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [GIT PULL] fallthrough fixes for 5.9-rc3
Message-ID: <20200829173702.GA22301@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit df561f6688fef775baa341a0f5d960becd248b11:

  treewide: Use fallthrough pseudo-keyword (2020-08-23 17:36:59 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/fallthrough-fixes-5.9-rc3

for you to fetch changes up to c165a08d2b2857c91c627039c4881f9d7ad1a3bd:

  arm64/cpuinfo: Remove unnecessary fallthrough annotation (2020-08-27 15:44:32 -0500)

----------------------------------------------------------------
fallthrough fixes for 5.9-rc3

Hi Linus,

Please, pull the following patches that fix some minor issues introduced
by the recent treewide fallthrough conversions:

- Fix identation issue.
- Fix erroneous fallthrough annotation.
- Remove unnecessary fallthrough annotation.
- Fix code comment changed by fallthrough conversion.

Thanks

----------------------------------------------------------------
Dan Carpenter (1):
      afs: Remove erroneous fallthough annotation

Gustavo A. R. Silva (3):
      iio: dpot-dac: fix code comment in dpot_dac_read_raw()
      media: dib0700: Fix identation issue in dib8096_set_param_override()
      arm64/cpuinfo: Remove unnecessary fallthrough annotation

 arch/arm64/kernel/cpuinfo.c                 |  1 -
 drivers/iio/dac/dpot-dac.c                  |  3 ++-
 drivers/media/usb/dvb-usb/dib0700_devices.c | 10 +++++-----
 fs/afs/flock.c                              |  1 -
 4 files changed, 7 insertions(+), 8 deletions(-)
