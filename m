Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E76C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9677D20674
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844667;
	bh=AFLhECNdQynG25OAfG50zgqOns9HClcAwKK6FJTao+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g2iseD8eKymuqShRUEaG789pKLtesWz1UpoUeIzC0wFCLCw2iABZehngQpFT8dj/7
	 zIPTtLvqquFkBbHjmbGfW1O8G4cn4Gn3lXathPF94Mugt7lq03EKXTbTASDzukUHGq
	 1UvAbgltba9bS8gyMQhlyDnW4kMRP6dqRoVpfQAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgCJMvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:51:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:56036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728754AbgCJMvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:51:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3E4420674;
        Tue, 10 Mar 2020 12:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844663;
        bh=AFLhECNdQynG25OAfG50zgqOns9HClcAwKK6FJTao+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tcyO+Ifqxc8SWkXVx4TRYqp8XcgPjMIeWi5EQr3/jALIf993XdoUJpyfzo9baZ8XA
         /oxEGpdhKAf/mPEV6crO/C0oApyJaFTI8jF24mW7OPZIhQYBh+vMco5vZovtzaWIHV
         bpmKnkHi2UueY4UmCmvMRDE6Z3ytt2ZlfL9PpRGE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        Maxime Ripard <maxime@cerno.tech>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 024/168] drm/modes: Make sure to parse valid rotation value from cmdline
Date:   Tue, 10 Mar 2020 13:37:50 +0100
Message-Id: <20200310123638.093106428@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123635.322799692@linuxfoundation.org>
References: <20200310123635.322799692@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



