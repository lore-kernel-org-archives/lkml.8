Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624E0C433F1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37BAA2065E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260309;
	bh=3lBGO2Iv9sJPX2bMerkCQLqWXSqK1YKfsw4sgDb4muU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cxv1sXSKGeNJFrTrKisGKkm8IRs2Gwwjh6nOP7cjmsTDjDO1HP8P0eBFGz4cCo8Mj
	 fjIDesPd/VaXc44RXG5lxTqeR2Oh/QMeM0xYiByjg3/6ocx8wuvwswbeHc/LWc7n5m
	 VbSzHwPTP/gbtdssTC2Mni0c6bL1RwBkSY3kNPAs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731275AbgGTPvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:51:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:48736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730108AbgGTPvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:51:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF9DD2065E;
        Mon, 20 Jul 2020 15:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260302;
        bh=3lBGO2Iv9sJPX2bMerkCQLqWXSqK1YKfsw4sgDb4muU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=paEPmxt3/0nxzORPCxm/hY92GhuyhfZaD+GM/AOxKDIwKT9FjPGMNz8kJG/JhRtLh
         F0cr5l9wv0s6ttTayjgYOvveVuYHDJwU7mXGdETOkSMPUTYjmN83LFI4lMMNycXICW
         6rXXTaC6Pof8oQ4av5fy55B+yieFU5rtNpUCrpmM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 053/133] ACPI: video: Use native backlight on Acer Aspire 5783z
Date:   Mon, 20 Jul 2020 17:36:40 +0200
Message-Id: <20200720152806.275847284@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152803.732195882@linuxfoundation.org>
References: <20200720152803.732195882@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 1c8fbc1f9bfb804ef2f0d4ee9397ab800e33f23a ]

The Acer Aspire 5783z shipped with Windows 7 and as such does not trigger
our "win8 ready" heuristic for prefering the native backlight interface.

Still ACPI backlight control doesn't work on this model, where as the
native (intel_video) backlight interface does work. Add a quirk to
force using native backlight control on this model.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/video_detect.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 214c4e2e8ade1..5f0178967d14c 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -328,6 +328,15 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Precision 7510"),
 		},
 	},
+	{
+	 .callback = video_detect_force_native,
+	 .ident = "Acer Aspire 5738z",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5738"),
+		DMI_MATCH(DMI_BOARD_NAME, "JV50"),
+		},
+	},
 
 	/*
 	 * Desktops which falsely report a backlight and which our heuristics
-- 
2.25.1



