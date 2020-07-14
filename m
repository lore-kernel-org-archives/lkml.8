Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD72C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90DC0206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730734AbgGOJcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 05:32:01 -0400
Received: from mga11.intel.com ([192.55.52.93]:1641 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgGOJcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 05:32:00 -0400
IronPort-SDR: ibLZjUObc7nqp2v80E0V0O+b7hOI36pF0CqRwXXwgAcNPF6e64KISVdnpf6LHhqH+ODNJgWMZo
 9KXss1IophYQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="147119277"
X-IronPort-AV: E=Sophos;i="5.75,354,1589266800"; 
   d="scan'208";a="147119277"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 02:32:00 -0700
IronPort-SDR: wb/vu2F4P4Luom+m/Nzi3Mr2RRUdF5pPkZlb3vgbCJe+yJxvXC5vYRURDLZcG5o2+sBBQoPFFt
 STU0he2MnR0w==
X-IronPort-AV: E=Sophos;i="5.75,354,1589266800"; 
   d="scan'208";a="460006199"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 02:31:56 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH 0/2] soundwire: sdw.h: fix PRBS/Static_1 swapped
Date:   Wed, 15 Jul 2020 05:37:42 +0800
Message-Id: <20200714213744.24674-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix PRBS/Static_1 swapped definitions and indentation in sdw.h

Pierre-Louis Bossart (2):
  soundwire: sdw.h: fix PRBS/Static_1 swapped definitions
  soundwire: sdw.h: fix indentation

 include/linux/soundwire/sdw.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

-- 
2.17.1

