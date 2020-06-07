Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA02C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 16:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 999C720663
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 16:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="go8R/K04"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgFGQzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 12:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgFGQzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 12:55:03 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633A5C08C5C3
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jun 2020 09:55:03 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 205so15042868qkg.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 09:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=m6WtQLhR0r/W4r5T3VW54q3AlLZTnBXeKgOtgipjTig=;
        b=go8R/K04LWrUtBsDhV7LuYtzj5d6yh68sNLwVhl5yGQen6vgl6RzKJFzZFol7tV4l6
         AErMCBKvZyc3KYfNcTeX6SlWOWUxYgPw9uLdmuG7cW4E5MoFP3pzlINT9VVBN5RZzpNi
         OMke08w5v+R7SyvelSlOB5IIQSij5RfagVS0gId3I6g+grtpVsp0tSO1d4STRMJeJv80
         ntA5t36irZkFnoyxvMs2kMxXrNuT8v1vWKZehJt7UVLKHOqDr6v1rzbAZGOvusIqYKQv
         zRqawE7R6ADDaoF+WPZ+x1zOvPbKYM1M1FUPk3QFs7li2jGZUit/oRCVu1bhIl6iXrAJ
         dKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=m6WtQLhR0r/W4r5T3VW54q3AlLZTnBXeKgOtgipjTig=;
        b=eA11nZd7gNDPcyBf9TSEwu0gBFi3KVBa46V92swIXsG5S9wkPGDceTcLbwPgLPJbzz
         XSqUzrmVJFYadZkigwDLwyDUEEt2ob/JmTF/KvYM3v1pCGh3qZr/Ha7d6y1l4U9brtgy
         5VNNsIwXIu9C5JVB7O9iyLp+2puXqovXZgbMl2o4JVV1y9cbGnMhrlJveHTvA7pKvTrm
         E3gT0VyWPnRFrPc9UjJ4nJRiyZM+vupCW5WLvu7G8Ve+6+qQwTsYi/QR8wOvD7nrtlU8
         725D/mJcHFNAy3zAPE29c2DrLSkfE6WIPrigHLO2LCkwh66gpVvnBs8fHobylGUzllIu
         Z/0w==
X-Gm-Message-State: AOAM5309Ercjg02iNrnKhi0QIBlkuKICneFrYojUlqa0sTYabZSkxMGC
        LJKvEv7JBkMdZU42ZCyWG1OmHg==
X-Google-Smtp-Source: ABdhPJzkE0t7uKkGxF5XQ8XHJgriZFtqQy5jtlADwyy0bMKVp0BXCoepQz+krZx9VgaOqhEPVZbOkg==
X-Received: by 2002:a37:b444:: with SMTP id d65mr18800554qkf.411.1591548902254;
        Sun, 07 Jun 2020 09:55:02 -0700 (PDT)
Received: from localhost ([2605:a601:a61a:4700:f53d:f961:b0d3:6284])
        by smtp.gmail.com with ESMTPSA id w10sm5652552qtc.15.2020.06.07.09.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 09:55:01 -0700 (PDT)
From:   Jon Mason <jdmason@kudzu.us>
X-Google-Original-From: Jon Mason <jdm@athena.kudzu.us>
Date:   Sun, 7 Jun 2020 12:55:01 -0400
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
Subject: [GIT PULL] NTB patches for v5.8
Message-ID: <20200607165501.GA7336@athena.kudzu.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,
Here are a lot of NTB bug fixes and Intel Icelake for v5.8.  Please
consider pulling them.

Thanks,
Jon



The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://github.com/jonmason/ntb tags/ntb-5.8

for you to fetch changes up to 2130c0ba69d69bb21f5c52787f2587db00d13d8a:

  NTB: ntb_test: Fix bug when counting remote files (2020-06-05 20:02:09 -0400)

----------------------------------------------------------------
Intel Icelake NTB support, Intel driver bug fixes, and lots of bug fixes
for ntb tests

----------------------------------------------------------------
Dave Jiang (3):
      ntb: intel: Add Icelake (gen4) support for Intel NTB
      ntb: intel: add hw workaround for NTB BAR alignment
      ntb: intel: fix static declaration

Jiasen Lin (1):
      NTB: Fix static check warning in perf_clear_test

Logan Gunthorpe (9):
      ntb: hw: remove the code that sets the DMA mask
      NTB: ntb_tool: reading the link file should not end in a NULL byte
      NTB: Revert the change to use the NTB device dev for DMA allocations
      NTB: Fix the default port and peer numbers for legacy drivers
      NTB: ntb_pingpong: Choose doorbells based on port number
      NTB: perf: Don't require one more memory window than number of peers
      NTB: perf: Fix support for hardware that doesn't have port numbers
      NTB: perf: Fix race condition when run with ntb_test
      NTB: ntb_test: Fix bug when counting remote files

Maciej Grochowski (1):
      include/ntb: Fix typo in ntb_unregister_device description

Sanjay R Mehta (4):
      ntb_perf: pass correct struct device to dma_alloc_coherent
      ntb_tool: pass correct struct device to dma_alloc_coherent
      ntb_perf: increase sleep time from one milli sec to one sec
      ntb_perf: avoid false dma unmap of destination address

Wesley Sheng (1):
      NTB: correct ntb_peer_spad_addr and ntb_peer_spad_read comment typos

 drivers/ntb/core.c                      |   9 +-
 drivers/ntb/hw/amd/ntb_hw_amd.c         |   4 -
 drivers/ntb/hw/idt/ntb_hw_idt.c         |   6 -
 drivers/ntb/hw/intel/Makefile           |   2 +-
 drivers/ntb/hw/intel/ntb_hw_gen1.c      |  49 +--
 drivers/ntb/hw/intel/ntb_hw_gen1.h      |   1 +
 drivers/ntb/hw/intel/ntb_hw_gen3.c      |  13 +-
 drivers/ntb/hw/intel/ntb_hw_gen3.h      |   8 +
 drivers/ntb/hw/intel/ntb_hw_gen4.c      | 552 ++++++++++++++++++++++++++++++++
 drivers/ntb/hw/intel/ntb_hw_gen4.h      | 100 ++++++
 drivers/ntb/hw/intel/ntb_hw_intel.h     |  12 +
 drivers/ntb/test/ntb_perf.c             |  49 +--
 drivers/ntb/test/ntb_pingpong.c         |  14 +-
 drivers/ntb/test/ntb_tool.c             |   9 +-
 include/linux/ntb.h                     |   6 +-
 tools/testing/selftests/ntb/ntb_test.sh |   2 +-
 16 files changed, 751 insertions(+), 85 deletions(-)
 create mode 100644 drivers/ntb/hw/intel/ntb_hw_gen4.c
 create mode 100644 drivers/ntb/hw/intel/ntb_hw_gen4.h
