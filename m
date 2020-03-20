Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439BDC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1230020709
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgCTQ36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 12:29:58 -0400
Received: from mga09.intel.com ([134.134.136.24]:15377 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727134AbgCTQ35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 12:29:57 -0400
IronPort-SDR: niFNy566xWoR9aCc1MoJe+KUVntQluTu/uOEAJi72OKmxhd8ZTRsPqhSdmpvBLbkMy1xT+/dx5
 pwlx8LY6lu3A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2020 09:29:57 -0700
IronPort-SDR: jLQtEbie7YuqwURQm/zDNhY5Oq8+ZRoMQNxb4exNSeTKB4yBnvlWcWS/Txw03CWPHrZfUMgnVz
 EkupLXALqyCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,285,1580803200"; 
   d="scan'208";a="248930809"
Received: from manallet-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.255.34.12])
  by orsmga006.jf.intel.com with ESMTP; 20 Mar 2020 09:29:54 -0700
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
Subject: [PATCH 0/5] soundwire: add sdw_master_device support on Qualcomm platforms
Date:   Fri, 20 Mar 2020 11:29:42 -0500
Message-Id: <20200320162947.17663-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset provides the support for sdw_master_device and
sdw_master_driver reviewed earlier and accepted as 'sane' by Greg KH.

This patchset only focuses on Qualcomm platforms and addresses all
previous comments and objections from Vinod Koul: there is no driver
used and no overhead added by this patchset. Many thanks to Srinivas
Kandagatla for testing these patches on Qualcomm devices and
contributing the missing DT parsing fix.

The transition from platform devices to sdw_master_devices on Intel
platforms was already provided and will be re-sent separately when
this infrastructure change is agreed.

Pierre-Louis Bossart (4):
  soundwire: bus_type: add master_device/driver support
  soundwire: bus_type: protect cases where no driver name is provided
  soundwire: qcom: fix error handling in probe
  soundwire: qcom: add sdw_master_device support

Srinivas Kandagatla (1):
  soundwire: master: use device node pointer from master device

 drivers/soundwire/Makefile         |   2 +-
 drivers/soundwire/bus_type.c       | 143 +++++++++++++++++++++++++++--
 drivers/soundwire/master.c         | 130 ++++++++++++++++++++++++++
 drivers/soundwire/qcom.c           |  49 ++++++++--
 drivers/soundwire/slave.c          |   7 +-
 include/linux/soundwire/sdw.h      |  59 ++++++++++++
 include/linux/soundwire/sdw_type.h |  36 +++++++-
 7 files changed, 407 insertions(+), 19 deletions(-)
 create mode 100644 drivers/soundwire/master.c


base-commit: 1ce7139436603dda9e155df0c3e275c87a725761
-- 
2.20.1

