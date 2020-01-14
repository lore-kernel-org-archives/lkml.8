Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C85AC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 23:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D75A24670
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 23:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgANXwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 18:52:40 -0500
Received: from mga01.intel.com ([192.55.52.88]:7290 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728757AbgANXwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 18:52:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 15:52:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,320,1574150400"; 
   d="scan'208";a="217922976"
Received: from emkilgox-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.251.0.151])
  by orsmga008.jf.intel.com with ESMTP; 14 Jan 2020 15:52:37 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 0/5] soundwire: stream: fix state machines and transitions
Date:   Tue, 14 Jan 2020 17:52:22 -0600
Message-Id: <20200114235227.14502-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing stream support works fine with simple cases, but does not
map well with ALSA transitions for underflows/resume where prepare()
can be called multiple times. Concurrency with multiple devices per
links or multiple streams enabled on the same link also needs to be
fixed.

These patches are the result of hours of validation on the Intel side
and should benefit other implementations since there is nothing
hardware-specific. The Intel-specific changes being reviewed do depend
on those stream changes though to be functional.

Changes since v1:
Removed spurious code block change flagged by Vinod

No change (replies provided in v1 thread)
Github link issue is public, no reason to remove it
Bandwidth computation on ALSA prepare/start (for resume cases) handled
internally in stream layer.
Kept emacs comment formatting.
No additional code/test for concurrent streams (not supported due to locking)

Bard Liao (1):
  soundwire: stream: only prepare stream when it is configured.

Pierre-Louis Bossart (2):
  soundwire: stream: update state machine and add state checks
  soundwire: stream: do not update parameters during DISABLED-PREPARED
    transition

Rander Wang (2):
  soundwire: stream: fix support for multiple Slaves on the same link
  soundwire: stream: don't program ports when a stream that has not been
    prepared

 Documentation/driver-api/soundwire/stream.rst | 61 +++++++++----
 drivers/soundwire/stream.c                    | 90 ++++++++++++++++---
 2 files changed, 124 insertions(+), 27 deletions(-)

-- 
2.20.1

