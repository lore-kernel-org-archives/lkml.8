Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A13CC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41092082E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580747556;
	bh=pYJmhRfn9YOi7piJCSMO3M5A4Rv0EXDHpAb2QRyajSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dzftVUhYDUcqNLRMngA5mUW7QSxFTWQYj5uZzT8dQ7aXRMX+7rBfAuDOoHIM+j5zi
	 mRqNdvE2TxR/A4mVBaI1XFt8zJ3DZfLrB0NB49s67oqma5TxYX1GwnXy9SjO+JDJ7t
	 k4W2cZ7QtINwdNEi5c30VfGgqVDsnpMwEuTGij5o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730443AbgBCQcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:32:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:46152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730101AbgBCQc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:32:27 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BFAC217BA;
        Mon,  3 Feb 2020 16:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747547;
        bh=pYJmhRfn9YOi7piJCSMO3M5A4Rv0EXDHpAb2QRyajSE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oqKv5m0EWjjiISFnBapw8q5x8MDM6mDPd2fbxkfjZWJGxOwoxqgR2194/f9gaUyf/
         j0YLJ3YTCCeYZySZkO8Ro7gqJywly9vYUeaBwBOMMP88zd/M339uh8HSC3pctYGGRm
         5keeuMMn95WqU5BgQXzKk+kFd6VxULUKv0YUc8X8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Anderson <jasona.594@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 38/70] platform/x86: GPD pocket fan: Allow somewhat lower/higher temperature limits
Date:   Mon,  3 Feb 2020 16:19:50 +0000
Message-Id: <20200203161917.952945455@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161912.158976871@linuxfoundation.org>
References: <20200203161912.158976871@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 1f27dbd8265dbb379926c8f6a4453fe7fe26d7a3 ]

Allow the user to configure the fan to turn on / speed-up at lower
thresholds then before (20 degrees Celcius as minimum instead of 40) and
likewise also allow the user to delay the fan speeding-up till the
temperature hits 90 degrees Celcius (was 70).

Cc: Jason Anderson <jasona.594@gmail.com>
Reported-by: Jason Anderson <jasona.594@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/gpd-pocket-fan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/gpd-pocket-fan.c b/drivers/platform/x86/gpd-pocket-fan.c
index 73eb1572b9662..b471b86c28fe8 100644
--- a/drivers/platform/x86/gpd-pocket-fan.c
+++ b/drivers/platform/x86/gpd-pocket-fan.c
@@ -127,7 +127,7 @@ static int gpd_pocket_fan_probe(struct platform_device *pdev)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(temp_limits); i++) {
-		if (temp_limits[i] < 40000 || temp_limits[i] > 70000) {
+		if (temp_limits[i] < 20000 || temp_limits[i] > 90000) {
 			dev_err(&pdev->dev, "Invalid temp-limit %d (must be between 40000 and 70000)\n",
 				temp_limits[i]);
 			temp_limits[0] = TEMP_LIMIT0_DEFAULT;
-- 
2.20.1



