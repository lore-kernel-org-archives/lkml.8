Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67E3C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99545206F5
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbgDHQJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 12:09:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:63799 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729808AbgDHQJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 12:09:30 -0400
IronPort-SDR: 4JwhL5J0cj7U9/H0d2MbteuZBwQADikyRU8uEFWZ+INTNMqeUE/VsyD3h1dP7yNhbw9Tnx0R+a
 7GR1EPpaMXcg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 09:09:28 -0700
IronPort-SDR: 5iOVPGhhfw7aAOWYoReV+Bj+iDDvUXL4ajrWE57V2LowKP+KHPRgapnX4x+N3K4Ocb+WIKmTwN
 ixrWxoSLj/JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,359,1580803200"; 
   d="scan'208";a="451655833"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 08 Apr 2020 09:09:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 66064130; Wed,  8 Apr 2020 19:09:25 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org,
        Darren Hart <dvhart@infradead.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/6] platform/x86: intel_cht_int33fe: clean up series
Date:   Wed,  8 Apr 2020 19:09:00 +0300
Message-Id: <20200408160905.12101-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I started looking into the intel_cht_int33fe driver for an example of use
software node API, I have noticed that it's hard to get and code a bit messy.
Here is a clean up, main part of which is to introduce node groups and API to
register and unregister them. This and some pre-existing APIs can be used in
the driver.

So, because of cross-subsystem nature of this series, I may recommend to create
myself the immutable branch which can be pulled to Rafael's and Greg's trees
respectively. I'm also open for other proposals how to proceed.

Andy Shevchenko (6):
  device property: export set_secondary_fwnode() to modules
  software node: Allow register and unregister software node groups
  platform/x86: intel_cht_int33fe: Convert software node array to group
  platform/x86: intel_cht_int33fe: Convert to use set_secondary_fwnode()
  platform/x86: intel_cht_int33fe: Switch to use
    acpi_dev_hid_uid_match()
  platform/x86: intel_cht_int33fe: Fix spelling issues

 drivers/base/core.c                           |   1 +
 drivers/base/swnode.c                         |  48 ++++++++
 .../platform/x86/intel_cht_int33fe_typec.c    | 106 +++++++++---------
 include/linux/property.h                      |   3 +
 4 files changed, 108 insertions(+), 50 deletions(-)

-- 
2.25.1

