Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACDEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5971A206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgHRG5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 02:57:32 -0400
Received: from mga05.intel.com ([192.55.52.43]:4385 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbgHRG5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 02:57:31 -0400
IronPort-SDR: n32qMfSFmKRbLbDzVdgmP/lnCWOTje46d3krbf54LIyR6to+Eqn79lzyuKRoQoMKvEOYTFFy+4
 qPfKja+6NYfQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="239677728"
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="239677728"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 23:57:31 -0700
IronPort-SDR: V3KhmU5Clvx4NiUO1jdxjBN2Cr27ujmjf7G+9+9vSGB0V/9AHcFaLyaNAVYsozrwak3b4cm94q
 2HeX8p4aAk2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="328881907"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga002.fm.intel.com with ESMTP; 17 Aug 2020 23:57:29 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     linux-kernel@vger.kernel.org, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com
Cc:     andriy.shevchenko@intel.com, thomas.langer@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com,
        "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v1 0/9] extcon: extcon-ptn5150: Add the USB external connector support
Date:   Tue, 18 Aug 2020 14:57:18 +0800
Message-Id: <20200818065727.50520-1-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB external connector chip PTN5150 used on the Intel LGM SoC
boards to detect the USB type and connection.
---
v1:
  - Initial version

Ramuthevar Vadivel Murugan (9):
  extcon: extcon-ptn5150: Switch to GENMASK() for vendor and device ID's
  extcon: extcon-ptn5150: Switch to GENMASK() for VBUS detection macro
  extcon: extcon-ptn5150: Switch to BIT() macro for cable attach
  extcon: extcon-ptn5150: Switch to BIT() for cable detach macro
  extcon: extcon-ptn5150: Switch to GENMASK() for port attachment macro
  extcon: extcon-ptn5150: Set and get the VBUS and POLARITY property
    state
  extcon: extcon-ptn5150: Add USB debug accessory support
  extcon: extcon-ptn5150: Add USB analog audio accessory support
  extcon: extcon-ptn5150: Remove unused variable and extra space

 drivers/extcon/extcon-ptn5150.c | 135 ++++++++++++++++++++++++----------------
 1 file changed, 82 insertions(+), 53 deletions(-)

-- 
2.11.0

