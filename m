Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FD0C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 06:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 849E020801
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 06:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590821780;
	bh=3goC8OB6qeZ0rHTPEgwao31zlEt51Co3ej14dAQU+3k=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=i2d54DunzjFMCEwICPca5liTRiPAFblZaHXCNUnsIdLE6srpryXQiqrEEWzuYnwgX
	 9g93tySfQBfY5/PM93MfVRRH9Q/B+4fgzyuSSaqzvNc0bBK5NcDJyZBqqF0CCswrxc
	 rlxyhP4oblIvfYkeDF/ofQzSDhV4JoGYqq/fd7Vw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgE3G4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 02:56:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:44912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728786AbgE3G4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 02:56:05 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16A0520C09;
        Sat, 30 May 2020 06:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590821763;
        bh=3goC8OB6qeZ0rHTPEgwao31zlEt51Co3ej14dAQU+3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NMaHqJFaAlu1/ddoZC959Yhj39KFFJUMCmDIGbmv6mPvBMnOHUew6sansjyZpGEzl
         uFZzMXJB+xwuDGv/A0gIHYCYXRzlCK0XkEsLSVexN2EObdt6VvrACf6C6osqrEgrdW
         5Z+7mOg5Ng4Iq7Id68OE6Hbm3IyevwOnEm3TGQVU=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jevPV-001hoz-0Q; Sat, 30 May 2020 08:56:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/41] media: atomisp: get rid of a warning message
Date:   Sat, 30 May 2020 08:55:29 +0200
Message-Id: <f4f659f8de12e2ad175772be0579ba3c524c2f52.1590821410.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1590821410.git.mchehab+huawei@kernel.org>
References: <cover.1590821410.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a warning message about an unused code. The code that
were using it were commented out, due to a problem causing the
firmware load to fail on the machines we're using for testing.

Change the place where we're commenting the code out, in order
to avoid the warning.

Fixes: 95d1f398c4dc ("media: atomisp: keep the ISP powered on when setting it")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../staging/media/atomisp/pci/atomisp_v4l2.c   | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_v4l2.c b/drivers/staging/media/atomisp/pci/atomisp_v4l2.c
index b30a2e54067c..c89d477a3948 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_v4l2.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_v4l2.c
@@ -734,6 +734,10 @@ static int atomisp_mrfld_pre_power_down(struct atomisp_device *isp)
 * WA for DDR DVFS enable/disable
 * By default, ISP will force DDR DVFS 1600MHz before disable DVFS
 */
+
+#if 0
+// Used only by atomisp_mrfld_power
+
 static void punit_ddr_dvfs_enable(bool enable)
 {
 	int door_bell = 1 << 8;
@@ -758,9 +762,12 @@ static void punit_ddr_dvfs_enable(bool enable)
 	if (max_wait == -1)
 		pr_info("DDR DVFS, door bell is not cleared within 3ms\n");
 }
+#endif
 
 static int atomisp_mrfld_power(struct atomisp_device *isp, bool enable)
 {
+// FIXME: at least with ISP2401, the code below causes the driver to break
+#if 0
 	unsigned long timeout;
 	u32 val = enable ? MRFLD_ISPSSPM0_IUNIT_POWER_ON :
 			   MRFLD_ISPSSPM0_IUNIT_POWER_OFF;
@@ -817,22 +824,21 @@ static int atomisp_mrfld_power(struct atomisp_device *isp, bool enable)
 
 	dev_err(isp->dev, "IUNIT power-%s timeout.\n", enable ? "on" : "off");
 	return -EBUSY;
+#else
+	return 0;
+#endif
 }
 
 /* Workaround for pmu_nc_set_power_state not ready in MRFLD */
 int atomisp_mrfld_power_down(struct atomisp_device *isp)
 {
-	return 0;
-// FIXME: at least with ISP2401, the code below causes the driver to break
-//	return atomisp_mrfld_power(isp, false);
+	return atomisp_mrfld_power(isp, false);
 }
 
 /* Workaround for pmu_nc_set_power_state not ready in MRFLD */
 int atomisp_mrfld_power_up(struct atomisp_device *isp)
 {
-	return 0;
-// FIXME: at least with ISP2401, the code below causes the driver to break
-//	return atomisp_mrfld_power(isp, true);
+	return atomisp_mrfld_power(isp, true);
 }
 
 int atomisp_runtime_suspend(struct device *dev)
-- 
2.26.2

