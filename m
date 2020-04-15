Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AE9C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84F66206F9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410631AbgDORB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:01:29 -0400
Received: from mga18.intel.com ([134.134.136.126]:27177 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410622AbgDORB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:01:26 -0400
IronPort-SDR: /Ga5i6zCi2haum2xqlXNYSqvowNCTCMmjMQrah1d8DLRrL6dtr7zLHvj5mScAd5QcU6Cmwuqol
 2OpWXxU9hbTg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 10:01:08 -0700
IronPort-SDR: n7cMLOLNzez15kkjGiIJhffRyXquXfIWmHSMWp+MbBxr0fsVCM6G5D6ZMMffQBwbFwEzHsIMIr
 plUQ4fyAhECA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,387,1580803200"; 
   d="scan'208";a="453994111"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 15 Apr 2020 10:01:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 38D98190; Wed, 15 Apr 2020 20:01:03 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 0/3] lib/vsprintf: Introduce %ptT for time64_t
Date:   Wed, 15 Apr 2020 20:00:43 +0300
Message-Id: <20200415170046.33374-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is a logical continuation of previously applied %ptR for struct rtc_time.
We have few users of time64_t that would like to print it.

Andrew, since Petr can't pay attention on this perhaps it can be passed thru
your tree?

Sergey, Steven, what do you think?

In v3:
- added tag (Alexandre)
- dropped for now USB Tegra patch (Thierry wasn't clear about)

In v2:
- drop #ifdef CONFIG_RTC_LIB with time64_to_rtc_time() altogether
  (Petr, Alexandre)
- update default error path message along with test case for it
- add Hans' Ack for patch 3

Andy Shevchenko (3):
  lib/vsprintf: Print time64_t in human readable format
  ARM: bcm2835: Switch to use %ptT
  [media] usb: pulse8-cec: Switch to use %ptT

 Documentation/core-api/printk-formats.rst | 22 ++++++++--------
 drivers/firmware/raspberrypi.c            | 12 +++------
 drivers/media/usb/pulse8-cec/pulse8-cec.c |  6 +----
 lib/test_printf.c                         | 13 +++++++---
 lib/vsprintf.c                            | 31 +++++++++++++++++++++--
 5 files changed, 55 insertions(+), 29 deletions(-)

-- 
2.25.1

