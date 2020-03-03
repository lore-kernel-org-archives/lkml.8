Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DF8C3F2D8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F772166E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583204300;
	bh=AFLhECNdQynG25OAfG50zgqOns9HClcAwKK6FJTao+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kBa8s21FWzUSKF1gd9DQv8ENIfdniH7ImwQIFp9QIA3M4kPaa7KKQpze/oOsR9CuH
	 FIlv48FdM2XDFMQuFqb3kI/QLbq41gVz5bNZTupMeoRkbtK3VQPVROtLpgicPvX28W
	 1X07BY25YPpJnlVERSPQW33qwyFuUTfspyqKPcW0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbgCCCsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 21:48:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:43216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728220AbgCCCr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 21:47:57 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCFF92469C;
        Tue,  3 Mar 2020 02:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583203676;
        bh=AFLhECNdQynG25OAfG50zgqOns9HClcAwKK6FJTao+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DZhlJxQ4yLZZcHpcGNB+87cn+UQAN1/jSKSDXqWQGuW0mKE/keLs/nN4RRp5SCD35
         TR8XW2wEFePA3AXCAkCFalX1PlUhT/rEZQ7ry7L/k1es1hsUv9oH0c466VGS7Amsr2
         DAh5Cz4glc5X4zQTt5qY/KaBWmFw6DdDBCk15fAQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Maxime Ripard <maxime@cerno.tech>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 13/58] drm/modes: Make sure to parse valid rotation value from cmdline
Date:   Mon,  2 Mar 2020 21:46:55 -0500
Message-Id: <20200303024740.9511-13-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303024740.9511-1-sashal@kernel.org>
References: <20200303024740.9511-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephan Gerhold <stephan@gerhold.net>

[ Upstream commit e6980a727154b793adb218fbc7b4d6af52a7e364 ]

A rotation value should have exactly one rotation angle.
At the moment there is no validation for this when parsing video=
parameters from the command line. This causes problems later on
when we try to combine the command line rotation with the panel
orientation.

To make sure that we generate a valid rotation value:
  - Set DRM_MODE_ROTATE_0 by default (if no rotate= option is set)
  - Validate that there is exactly one rotation angle set
    (i.e. specifying the rotate= option multiple times is invalid)

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Link: https://patchwork.freedesktop.org/patch/msgid/20200117153429.54700-2-stephan@gerhold.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_modes.c                       |  7 +++++++
 drivers/gpu/drm/selftests/drm_cmdline_selftests.h |  1 +
 .../gpu/drm/selftests/test-drm_cmdline_parser.c   | 15 +++++++++++++--
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index 88232698d7a00..3fd35e6b9d535 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -1672,6 +1672,13 @@ static int drm_mode_parse_cmdline_options(char *str, size_t len,
 		}
 	}
 
+	if (!(rotation & DRM_MODE_ROTATE_MASK))
+		rotation |= DRM_MODE_ROTATE_0;
+
+	/* Make sure there is exactly one rotation defined */
+	if (!is_power_of_2(rotation & DRM_MODE_ROTATE_MASK))
+		return -EINVAL;
+
 	mode->rotation_reflection = rotation;
 
 	return 0;
diff --git a/drivers/gpu/drm/selftests/drm_cmdline_selftests.h b/drivers/gpu/drm/selftests/drm_cmdline_selftests.h
index 6d61a0eb5d64f..84e6bc050bf2c 100644
--- a/drivers/gpu/drm/selftests/drm_cmdline_selftests.h
+++ b/drivers/gpu/drm/selftests/drm_cmdline_selftests.h
@@ -53,6 +53,7 @@ cmdline_test(drm_cmdline_test_rotate_0)
 cmdline_test(drm_cmdline_test_rotate_90)
 cmdline_test(drm_cmdline_test_rotate_180)
 cmdline_test(drm_cmdline_test_rotate_270)
+cmdline_test(drm_cmdline_test_rotate_multiple)
 cmdline_test(drm_cmdline_test_rotate_invalid_val)
 cmdline_test(drm_cmdline_test_rotate_truncated)
 cmdline_test(drm_cmdline_test_hmirror)
diff --git a/drivers/gpu/drm/selftests/test-drm_cmdline_parser.c b/drivers/gpu/drm/selftests/test-drm_cmdline_parser.c
index 013de9d27c35d..035f86c5d6482 100644
--- a/drivers/gpu/drm/selftests/test-drm_cmdline_parser.c
+++ b/drivers/gpu/drm/selftests/test-drm_cmdline_parser.c
@@ -856,6 +856,17 @@ static int drm_cmdline_test_rotate_270(void *ignored)
 	return 0;
 }
 
+static int drm_cmdline_test_rotate_multiple(void *ignored)
+{
+	struct drm_cmdline_mode mode = { };
+
+	FAIL_ON(drm_mode_parse_command_line_for_connector("720x480,rotate=0,rotate=90",
+							  &no_connector,
+							  &mode));
+
+	return 0;
+}
+
 static int drm_cmdline_test_rotate_invalid_val(void *ignored)
 {
 	struct drm_cmdline_mode mode = { };
@@ -888,7 +899,7 @@ static int drm_cmdline_test_hmirror(void *ignored)
 	FAIL_ON(!mode.specified);
 	FAIL_ON(mode.xres != 720);
 	FAIL_ON(mode.yres != 480);
-	FAIL_ON(mode.rotation_reflection != DRM_MODE_REFLECT_X);
+	FAIL_ON(mode.rotation_reflection != (DRM_MODE_ROTATE_0 | DRM_MODE_REFLECT_X));
 
 	FAIL_ON(mode.refresh_specified);
 
@@ -913,7 +924,7 @@ static int drm_cmdline_test_vmirror(void *ignored)
 	FAIL_ON(!mode.specified);
 	FAIL_ON(mode.xres != 720);
 	FAIL_ON(mode.yres != 480);
-	FAIL_ON(mode.rotation_reflection != DRM_MODE_REFLECT_Y);
+	FAIL_ON(mode.rotation_reflection != (DRM_MODE_ROTATE_0 | DRM_MODE_REFLECT_Y));
 
 	FAIL_ON(mode.refresh_specified);
 
-- 
2.20.1

