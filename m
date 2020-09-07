Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8067FC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 524762080A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbgIGRv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:51:28 -0400
Received: from mga17.intel.com ([192.55.52.151]:8872 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729214AbgIGMFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 08:05:36 -0400
IronPort-SDR: vYDYrzkPl2EqgtZoYm3GDTySrgOqY2oturlWiBq7Bx/6EpxCp+ExnQW9TiP+TEO0Rlc0WHsCs/
 lgDd3KmnPMzg==
X-IronPort-AV: E=McAfee;i="6000,8403,9736"; a="138043146"
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="138043146"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 05:05:35 -0700
IronPort-SDR: 2CBlObCO96DDrKtRle/9/mG0KaS4vvXMxVvOVT/BzpwxDNLDMD4HSCzkDvUGfy45+IIZP+ASZ8
 Ct81pGEywADg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="406818222"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Sep 2020 05:05:33 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH v2 0/2] Move fwnode_connection_find_match() under drivers/base/property.c
Date:   Mon,  7 Sep 2020 15:05:30 +0300
Message-Id: <20200907120532.37611-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is second version of this series. I forgot to remove the file
from Documentation/driver-api/index.rst. Hopefully these are now OK.

The original cover letter:

Hi,

This was the last patch in my series that removed struct
device_connection [1]. It's now split into two separate patches.

[1] https://lore.kernel.org/lkml/20200904125123.83725-1-heikki.krogerus@linux.intel.com/

thanks,

*** BLURB HERE ***

Heikki Krogerus (2):
  device property: Move fwnode_connection_find_match() under
    drivers/base/property.c
  Documentation: Remove device connection documentation

 .../driver-api/device_connection.rst          |  43 --------
 Documentation/driver-api/index.rst            |   1 -
 drivers/base/Makefile                         |   2 +-
 drivers/base/devcon.c                         | 101 ------------------
 drivers/base/property.c                       |  73 +++++++++++++
 include/linux/device.h                        |   9 --
 include/linux/property.h                      |  14 +++
 7 files changed, 88 insertions(+), 155 deletions(-)
 delete mode 100644 Documentation/driver-api/device_connection.rst
 delete mode 100644 drivers/base/devcon.c

-- 
2.28.0

