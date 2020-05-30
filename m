Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40C5C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 13:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4529207BC
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 13:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgE3NEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 09:04:05 -0400
Received: from mga06.intel.com ([134.134.136.31]:52784 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728998AbgE3NEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 09:04:00 -0400
IronPort-SDR: vuuinOjozXFNAD6XRybi80IQrgEMuyJU+3K1jbGxVN13CchpsObykcuulFGed7VB2hBw9LMBBZ
 eJgCm1E4p4Rg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2020 06:03:59 -0700
IronPort-SDR: ZieiPcbQVgrkj8PLXTFCPg6f4e/uQNCLV/aic+Unk5Bg8OJ9l4SlyvjV/XsODs7MoNozXHpD7j
 UYsotjDUpHqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,451,1583222400"; 
   d="scan'208";a="267835779"
Received: from lkp-server01.sh.intel.com (HELO 9f9df8056aac) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 30 May 2020 06:03:58 -0700
Received: from kbuild by 9f9df8056aac with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jf19Z-0000hN-At; Sat, 30 May 2020 13:03:57 +0000
Date:   Sat, 30 May 2020 21:03:14 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Jonathan, Bakker," <xc-racer2@live.ca>
Cc:     kbuild-all@lists.01.org, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH regulator] regulator: max8998:
 max8998_set_current_limit() can be static
Message-ID: <20200530130314.GA73557@d7d8dbfb64ff>
References: <202005302128.HV9kPNGq%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005302128.HV9kPNGq%lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 4ffea5e083f8 ("regulator: max8998: Add charger regulator")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 max8998.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/max8998.c b/drivers/regulator/max8998.c
index 668ced0064179..340413bba0c5f 100644
--- a/drivers/regulator/max8998.c
+++ b/drivers/regulator/max8998.c
@@ -371,8 +371,8 @@ static int max8998_set_voltage_buck_time_sel(struct regulator_dev *rdev,
 	return 0;
 }
 
-int max8998_set_current_limit(struct regulator_dev *rdev,
-			      int min_uA, int max_uA)
+static int max8998_set_current_limit(struct regulator_dev *rdev,
+				     int min_uA, int max_uA)
 {
 	struct max8998_data *max8998 = rdev_get_drvdata(rdev);
 	struct i2c_client *i2c = max8998->iodev->i2c;
