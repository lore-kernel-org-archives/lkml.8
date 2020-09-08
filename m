Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABFEC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C8F7215A4
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599560115;
	bh=0yVg4VB9wLo7/HcSqfX02PS0qyjpPXXI+/tghmjqUsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rC9Q2lrE6hGnYfIN4pfJYxvmMN9beO5RDNye664bPm24m1i757/tz905OfCbHZiyY
	 ON/uxDLlgP+2HxrrlBMhp41IUP2yCx8hXHuzkCGIxJaj36P6a2uWJphaV8yCeO39WH
	 8EmifvbMC127/tUydECyU78b62OiOxrHVxGic/Ts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgIHKPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 06:15:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728966AbgIHKMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 06:12:35 -0400
Received: from mail.kernel.org (ip5f5ad5ce.dynamic.kabel-deutschland.de [95.90.213.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8156321D7B;
        Tue,  8 Sep 2020 10:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599559952;
        bh=0yVg4VB9wLo7/HcSqfX02PS0qyjpPXXI+/tghmjqUsw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e38+G2nCFBUoDUoF+fz5A8o5ijqJDQaNcvCHxYr26na4YykpjN8D/WJrud+bKE1ah
         fwhId2ca83Oz7WvoTX8OcFe8qKZEQSeLqFwWaJMF0uDwC2suV3t2EEcJvvHWTUV+Lv
         7yFg8uXyuQWYa0pEy5v1eCRfL1NdEegkPQtCcGq4=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kFac1-00B3qd-2i; Tue, 08 Sep 2020 12:12:29 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] media: atomisp: print a warning if error while setting downscaler
Date:   Tue,  8 Sep 2020 12:12:23 +0200
Message-ID: <20d420b6ccec9c8013336437781da0f0c7ffabac.1599141140.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599141140.git.mchehab+huawei@kernel.org>
References: <cover.1599141140.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20200908101223.-boY-j80RM79vWn_bA4YCwy1nJzJ7KUUjdlF0YSGnh8@z>

As warned by gcc:

    drivers/staging/media/atomisp//pci/isp/kernels/dvs/dvs_1.0/ia_css_dvs.host.c:237:31: warning: variable ‘isp_data_ptr’ set but not used [-Wunused-but-set-variable]

ia_css_vf_configure() logic has an error var that detects troubles
when setting the kernel for downscaling. The driver just ignores
it, without producing any warning. Add at least a warning message
on such cases.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../media/atomisp/pci/isp/kernels/vf/vf_1.0/ia_css_vf.host.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/staging/media/atomisp/pci/isp/kernels/vf/vf_1.0/ia_css_vf.host.c b/drivers/staging/media/atomisp/pci/isp/kernels/vf/vf_1.0/ia_css_vf.host.c
index 3b850bb2d39d..dd3670972936 100644
--- a/drivers/staging/media/atomisp/pci/isp/kernels/vf/vf_1.0/ia_css_vf.host.c
+++ b/drivers/staging/media/atomisp/pci/isp/kernels/vf/vf_1.0/ia_css_vf.host.c
@@ -13,6 +13,8 @@
  * more details.
  */
 
+#include "atomisp_internal.h"
+
 #include "ia_css_vf.host.h"
 #include <assert_support.h>
 #include <ia_css_err.h>
@@ -129,6 +131,9 @@ ia_css_vf_configure(
 	const struct ia_css_binary_info *info = &binary->info->sp;
 
 	err = configure_kernel(info, out_info, vf_info, downscale_log2, &config);
+	if (err)
+		dev_warn(atomisp_dev, "Couldn't setup downscale\n");
+
 	configure_dma(&config, vf_info);
 
 	if (vf_info)
-- 
2.26.2

