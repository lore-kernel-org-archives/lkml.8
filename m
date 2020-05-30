Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA1AC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 06:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A57E6206C3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 06:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590821959;
	bh=oqc98StvgmA7z0fSgQB6Aim2CtSwhSejWpxjl/8s6/s=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=LAYWNDpCsEf+18YedNT6ky5xvvCTLxQngK4rD85t42EMxhYUp4BILgeoi3E6x0Qj4
	 eTmVesAQ9sq+MeyUYDeG0j2EerMFee75vgIzzAdAoDHCC49usmgEMwE154Jb3TYHrp
	 So0/NFFhzBRA9z2JDnIOObsAXSeWXlUmS6thTp5c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgE3G7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 02:59:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728841AbgE3G4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 02:56:06 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9628C2176B;
        Sat, 30 May 2020 06:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590821763;
        bh=oqc98StvgmA7z0fSgQB6Aim2CtSwhSejWpxjl/8s6/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NWFDQBTwwLRKuN6wcO9Wbu1fRa01fAY4XnsCdOw5YJ2zKAvUrXAc8bbx87ZLwOdL0
         7pN22SE0EtTYX2liFNea+arUesW6LaKESTw3WFySULoO7bfoGkQ+9SE/xV2mXwxSMt
         OK9kVTOpBkwhVYVZWvXUonRjIw74RrSCjjKZ7Cz8=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jevPV-001hpo-FH; Sat, 30 May 2020 08:56:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        kbuild test robot <lkp@intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH v2 22/41] media: atomisp: Remove second increment of count in atomisp_subdev_probe
Date:   Sat, 30 May 2020 08:55:39 +0200
Message-Id: <84be50326cb07f7329012a40bc25edf7d2bade84.1590821410.git.mchehab+huawei@kernel.org>
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

From: Nathan Chancellor <natechancellor@gmail.com>

Clang warns:

../drivers/staging/media/atomisp/pci/atomisp_v4l2.c:1097:3: warning:
variable 'count' is incremented both in the loop header and in the loop
body [-Wfor-loop-analysis]
                count++;
                ^

This was probably unintentional, remove it.

Link: https://github.com/ClangBuiltLinux/linux/issues/1036

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/media/atomisp/pci/atomisp_v4l2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_v4l2.c b/drivers/staging/media/atomisp/pci/atomisp_v4l2.c
index c89d477a3948..374b1bb6c339 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_v4l2.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_v4l2.c
@@ -1098,7 +1098,6 @@ static int atomisp_subdev_probe(struct atomisp_device *isp)
 		if (camera_count)
 			break;
 		msleep(SUBDEV_WAIT_TIMEOUT);
-		count++;
 	}
 	/* Wait more time to give more time for subdev init code to finish */
 	msleep(5 * SUBDEV_WAIT_TIMEOUT);
-- 
2.26.2

