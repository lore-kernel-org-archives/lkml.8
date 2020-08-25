Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DD3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D74142075F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgHYODt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 10:03:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:59244 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgHYN74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 09:59:56 -0400
IronPort-SDR: BDxlDaRmHKGz4tx5aLvCkE3ForFS1ygc1frhDvW/bWCeac1jFrMrqnztBjDDuGDEa+LSscXpJW
 wtRpSO4m4pDA==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="217659379"
X-IronPort-AV: E=Sophos;i="5.76,352,1592895600"; 
   d="scan'208";a="217659379"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 06:59:54 -0700
IronPort-SDR: hIX9GWXNsuutTILIgAn9Fwym76hrvk2/jJ0pmD/1uXZwPpFRLlF7KBUEHRORwv3S3XMjh5sVak
 wUSSnTSChd/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,352,1592895600"; 
   d="scan'208";a="402725549"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Aug 2020 06:59:52 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH 0/3] PM operations for software nodes
Date:   Tue, 25 Aug 2020 16:59:48 +0300
Message-Id: <20200825135951.53340-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

Unfortunately the last patch depends on this:
https://lore.kernel.org/linux-usb/20200821131101.81915-1-heikki.krogerus@linux.intel.com/

Would it be easiest that Felipe took care of these (assuming they are
acceptable)?

thanks,

Heikki Krogerus (3):
  software node: Power management operations for software nodes
  software node: Introduce device_add_software_node()
  usb: dwc3: pci: Register a software node for the dwc3 platform device

 drivers/base/power/common.c |   8 +-
 drivers/base/swnode.c       | 569 +++++++++++++++++++++++++++++++++++-
 drivers/usb/dwc3/dwc3-pci.c | 175 ++++++-----
 include/linux/property.h    |  13 +
 4 files changed, 666 insertions(+), 99 deletions(-)

-- 
2.28.0

