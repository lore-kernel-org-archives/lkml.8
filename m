Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0D5C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 11:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FCC12073C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 11:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729923AbgBMLVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 06:21:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:46682 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729526AbgBMLVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 06:21:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7C1E7B196;
        Thu, 13 Feb 2020 11:21:01 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] usb: audio-v2: Add uac2_effect_unit_descriptor definition
Date:   Thu, 13 Feb 2020 12:20:58 +0100
Message-Id: <20200213112059.18745-2-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200213112059.18745-1-tiwai@suse.de>
References: <20200213112059.18745-1-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UAC2 Effect Unit Descriptor has a slightly different definition
from other similar ones like Processing Unit or Extension Unit.
Define it here so that it can be used in USB-audio driver in a later
patch.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/linux/usb/audio-v2.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/usb/audio-v2.h b/include/linux/usb/audio-v2.h
index ba4b3e3327ff..cb9900b34b67 100644
--- a/include/linux/usb/audio-v2.h
+++ b/include/linux/usb/audio-v2.h
@@ -156,6 +156,18 @@ struct uac2_feature_unit_descriptor {
 	__u8 bmaControls[0]; /* variable length */
 } __attribute__((packed));
 
+/* 4.7.2.10 Effect Unit Descriptor */
+
+struct uac2_effect_unit_descriptor {
+	__u8 bLength;
+	__u8 bDescriptorType;
+	__u8 bDescriptorSubtype;
+	__u8 bUnitID;
+	__le16 wEffectType;
+	__u8 bSourceID;
+	__u8 bmaControls[]; /* variable length */
+} __attribute__((packed));
+
 /* 4.9.2 Class-Specific AS Interface Descriptor */
 
 struct uac2_as_header_descriptor {
-- 
2.16.4

