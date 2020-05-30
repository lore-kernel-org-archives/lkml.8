Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7265C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 06:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C073D20776
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 06:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590821971;
	bh=JKmzSE0kGmg7cmLoJkHr7QbAEfATLjopfGTrvBS2jDE=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=cXPCNjHdurVhFY8cl0m82HUfCu80RMTEnduPw8Ui6woymISdPKFZ6DHIakAz+2t8K
	 yNvNnRXrM3zF8Gy7ajjjKhiqvOfj2OWSZGBvkEP3okhItbcMS94qXffOMMiIE/1PVj
	 55in5DJyAvmmUjaY6bbKpNB0gWyq0jvlzd4XBv9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbgE3G7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 02:59:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728820AbgE3G4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 02:56:05 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30D7D214D8;
        Sat, 30 May 2020 06:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590821763;
        bh=JKmzSE0kGmg7cmLoJkHr7QbAEfATLjopfGTrvBS2jDE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bEvx7CPeCZSmEAdFnPTTcStqZoPn9ipThhEjRhvezwhW9/S3e2biBsGQ2U0EV0s4c
         ZK+pmFelocVLWEeOlOjj5iKjQ5H0aVrp1NPLz0AlsUCIsxwrrEHSgQXlZU78EV3i8+
         wmpwKUZhLeJWluOqtf+gXAdeMPJKujTUA4tyMoL8=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jevPV-001hp4-2C; Sat, 30 May 2020 08:56:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/41] media: atomisp: fix driver caps
Date:   Sat, 30 May 2020 08:55:30 +0200
Message-Id: <b82ba20c1e1d031754ac1cebfa91ece3ecf857a8.1590821410.git.mchehab+huawei@kernel.org>
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

This device driver is not MC-centric. So, remove the wrong
caps from it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/media/atomisp/pci/atomisp_subdev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_subdev.c b/drivers/staging/media/atomisp/pci/atomisp_subdev.c
index 830aefad9312..2bde2c8ea460 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_subdev.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_subdev.c
@@ -1343,8 +1343,7 @@ int atomisp_subdev_register_entities(struct atomisp_sub_device *asd,
 	 * Should any of those use V4L2_CAP_META_OUTPUT? Probably yes.
 	 */
 
-	device_caps = V4L2_CAP_IO_MC |
-		      V4L2_CAP_VIDEO_CAPTURE |
+	device_caps = V4L2_CAP_VIDEO_CAPTURE |
 		      V4L2_CAP_STREAMING;
 
 	/* Register the subdev and video node. */
-- 
2.26.2

