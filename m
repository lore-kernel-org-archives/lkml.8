Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B6AC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 09:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC000207F9
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 09:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbgE3Jkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 05:40:33 -0400
Received: from mga04.intel.com ([192.55.52.120]:31957 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727947AbgE3Jkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 05:40:32 -0400
IronPort-SDR: jyfxuyR+0cVCPwgkHFqU112qIqYQvbJZmbp5x9kjJQjuvP7iAMcbn0JEIAB2014HynI5GZNvW/
 0ktgjZXkjoBQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2020 02:40:32 -0700
IronPort-SDR: IT5C/iOxEUZuk5iMsY7WpqDpqM8Lde/Rm23FhU9tQWWdYtl68yJR5poXALOHn9kFobofZDtH5N
 ElUzvOheL23g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,451,1583222400"; 
   d="scan'208";a="271475662"
Received: from lkp-server01.sh.intel.com (HELO 9f9df8056aac) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 30 May 2020 02:40:30 -0700
Received: from kbuild by 9f9df8056aac with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jexyf-0000eW-Tz; Sat, 30 May 2020 09:40:29 +0000
Date:   Sat, 30 May 2020 17:39:52 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Jonathan, Bakker," <xc-racer2@live.ca>
Cc:     kbuild-all@lists.01.org, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH regulator] regulator: max8998:
 max8998_get_current_limit() can be static
Message-ID: <20200530093952.GA95399@ff281034de1d>
References: <202005301757.zXvAYTUt%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005301757.zXvAYTUt%lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 4ffea5e083f8 ("regulator: max8998: Add charger regulator")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 max8998.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/max8998.c b/drivers/regulator/max8998.c
index 668ced0064179..ab16790a02068 100644
--- a/drivers/regulator/max8998.c
+++ b/drivers/regulator/max8998.c
@@ -415,7 +415,7 @@ int max8998_set_current_limit(struct regulator_dev *rdev,
 				  sel, rdev->desc->csel_mask);
 }
 
-int max8998_get_current_limit(struct regulator_dev *rdev)
+static int max8998_get_current_limit(struct regulator_dev *rdev)
 {
 	struct max8998_data *max8998 = rdev_get_drvdata(rdev);
 	struct i2c_client *i2c = max8998->iodev->i2c;
