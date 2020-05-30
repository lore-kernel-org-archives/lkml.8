Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEE7C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 06:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA7D4207F9
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 06:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590821797;
	bh=xrFsxx88YfCDOsT9CXP87w2g2TCYrLu1dZPyf+iyKFk=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=0/gGC+8+2L+X6vjkXPuwS+IoundWX+WQukieKIqf2ny35fRD1E0DbSsIqeGcgTk+N
	 Q3dCN+hyOi5OBdDmOMvm131ZIdshYCWnCA2/NQhRw3MOsecBSrI9IX+U0M0tdvNc8i
	 eJd23uRRpbQGOIpobRs9/7+S0iLxmfDVdF6Acyb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgE3G4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 02:56:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:44988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728842AbgE3G4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 02:56:06 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9926721789;
        Sat, 30 May 2020 06:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590821763;
        bh=xrFsxx88YfCDOsT9CXP87w2g2TCYrLu1dZPyf+iyKFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uhj8ubLW1nU8Arl2U9AwZ4jZecnzF5hSo036TwAv6tm8NQS4FPVicSMMxGLjZVyPs
         bjcG1zxC7o1JXetYO+Ol+szQXkfkHQ1MHRo1AgPtaXhbd+ANhYtfHGF8qA7psMpwd/
         Rijax7aTeJuXEILqEREsFJ/QSmLWmxEqrCZYWxZ8=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jevPV-001hpx-HO; Sat, 30 May 2020 08:56:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH v2 24/41] media: atomisp: Remove unnecessary NULL check in atomisp_param
Date:   Sat, 30 May 2020 08:55:41 +0200
Message-Id: <3d2b4d8162c9b52b9510425265c5580928ab7cca.1590821410.git.mchehab+huawei@kernel.org>
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

drivers/staging/media/atomisp/pci/atomisp_cmd.c:4278:17: warning:
address of 'config->info' will always evaluate to 'true'
[-Wpointer-bool-conversion]
                if (!&config->info) {
                    ~ ~~~~~~~~^~~~

config cannot be NULL because it comes from an ioctl, which ensures that
the user is not giving us an invalid pointer through copy_from_user. If
config is not NULL, info cannot be NULL. Remove this check.

Link: https://github.com/ClangBuiltLinux/linux/issues/1036

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/media/atomisp/pci/atomisp_cmd.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_cmd.c b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
index 4913469df2bb..5f34e7586ee4 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_cmd.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
@@ -4270,7 +4270,6 @@ int atomisp_set_parameters(struct video_device *vdev,
 int atomisp_param(struct atomisp_sub_device *asd, int flag,
 		  struct atomisp_parm *config)
 {
-	struct atomisp_device *isp = asd->isp;
 	struct ia_css_pipe_config *vp_cfg =
 		    &asd->stream_env[ATOMISP_INPUT_STREAM_GENERAL].
 		    pipe_configs[IA_CSS_PIPE_ID_VIDEO];
@@ -4281,10 +4280,6 @@ int atomisp_param(struct atomisp_sub_device *asd, int flag,
 		    atomisp_css_get_dvs_grid_info(
 			&asd->params.curr_grid_info);
 
-		if (!&config->info) {
-			dev_err(isp->dev, "ERROR: NULL pointer in grid_info\n");
-			return -EINVAL;
-		}
 		atomisp_curr_user_grid_info(asd, &config->info);
 
 		/* We always return the resolution and stride even if there is
-- 
2.26.2

