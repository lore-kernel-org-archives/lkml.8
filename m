Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AB2C35242
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 01:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8DA12082F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 01:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgBOBrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 20:47:48 -0500
Received: from mga14.intel.com ([192.55.52.115]:23828 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727740AbgBOBrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 20:47:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 17:47:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,442,1574150400"; 
   d="scan'208";a="434975914"
Received: from gosalsar-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.252.136.64])
  by fmsmga006.fm.intel.com with ESMTP; 14 Feb 2020 17:47:46 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v3 0/5] soundwire: intel: add DAI callbacks
Date:   Fri, 14 Feb 2020 19:47:35 -0600
Message-Id: <20200215014740.27580-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing mainline code is missing most of the DAI callbacks needed
for a functional implementation, and the existing ones need to be
modified to provide the relevant information to ASoC/SOF drivers.

As suggested by Vinod, these patches are shared first - with the risk
that they are separated from the actual DAI enablement, so reviewers
might wonder why they are needed in the first place.

For reference, the complete set of 90+ patches required for SoundWire
on Intel platforms is available here:

https://github.com/thesofproject/linux/pull/1692

Changes since v2:
Add missing kfree for stream name (feedback from Vinod)

changes since v1:
Fix string allocation (only feedback from Vinod)

Pierre-Louis Bossart (2):
  soundwire: intel: rename res field as link_res
  soundwire: intel: free all resources on hw_free()

Rander Wang (3):
  soundwire: intel: add prepare support in sdw dai driver
  soundwire: intel: add trigger support in sdw dai driver
  soundwire: intel: add sdw_stream_setup helper for .startup callback

 drivers/soundwire/intel.c | 198 ++++++++++++++++++++++++++++++++++----
 1 file changed, 178 insertions(+), 20 deletions(-)

-- 
2.20.1

