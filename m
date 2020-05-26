Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD9CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F1F620849
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590519899;
	bh=fsN0OCzjWW9TIqNZmgQDpgpfgraqIGbE+0AuKgWBy0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZTRlr0CkzYk1/u4+sucH+Vz2TK/5CDfhw7HZwkXX+nRkBztbcaOf8fo1Ei8lhFy3Q
	 otcp5zJ58GfYzHBHuWofvWKKMdpRTSsvmz6tVyxO/MGZ6DdSRZo40C6j2FullpL0NR
	 /62TnjzTjTMNY6eFCSJ6auBOgKirBctvvdX2DXdY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391439AbgEZTE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:04:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391425AbgEZTEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:04:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80F1F20849;
        Tue, 26 May 2020 19:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519895;
        bh=fsN0OCzjWW9TIqNZmgQDpgpfgraqIGbE+0AuKgWBy0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q9gfCudjMXGE34R3i5JkB0LIwqcQImewx/rpcIoJ/oX7eObIP94N4+GWY9oq5lZ/j
         4xEj8hHFuaPSpIQHbWVCSD3WOKIU8mHhIypl3UWxGOYKNpyzo3fHKcCfqlxttY4uRb
         fK1k0I+7m0/iRgBCpXen0HzWSYUS8nqBQYzvc9sE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiaojian Cao <xiaojian.cao@cn.alps.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 18/81] HID: alps: ALPS_1657 is too specific; use U1_UNICORN_LEGACY instead
Date:   Tue, 26 May 2020 20:52:53 +0200
Message-Id: <20200526183928.551634385@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183923.108515292@linuxfoundation.org>
References: <20200526183923.108515292@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

[ Upstream commit 185af3e775b693f773d9a4b5a8c3cda69fc8ca0f ]

HID_DEVICE_ID_ALPS_1657 PID is too specific, as there are many other
ALPS hardware IDs using this particular touchpad.

Rename the identifier to HID_DEVICE_ID_ALPS_U1_UNICORN_LEGACY in order
to describe reality better.

Fixes: 640e403b1fd24 ("HID: alps: Add AUI1657 device ID")
Reported-by: Xiaojian Cao <xiaojian.cao@cn.alps.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-alps.c | 2 +-
 drivers/hid/hid-ids.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
index 28ca21014bbe..3489f0af7409 100644
--- a/drivers/hid/hid-alps.c
+++ b/drivers/hid/hid-alps.c
@@ -806,7 +806,7 @@ static int alps_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		break;
 	case HID_DEVICE_ID_ALPS_U1_DUAL:
 	case HID_DEVICE_ID_ALPS_U1:
-	case HID_DEVICE_ID_ALPS_1657:
+	case HID_DEVICE_ID_ALPS_U1_UNICORN_LEGACY:
 		data->dev_type = U1;
 		break;
 	default:
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 53ac5e1ab4bc..2a9cec9764cf 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -81,9 +81,9 @@
 #define HID_DEVICE_ID_ALPS_U1_DUAL_PTP	0x121F
 #define HID_DEVICE_ID_ALPS_U1_DUAL_3BTN_PTP	0x1220
 #define HID_DEVICE_ID_ALPS_U1		0x1215
+#define HID_DEVICE_ID_ALPS_U1_UNICORN_LEGACY         0x121E
 #define HID_DEVICE_ID_ALPS_T4_BTNLESS	0x120C
 #define HID_DEVICE_ID_ALPS_1222		0x1222
-#define HID_DEVICE_ID_ALPS_1657         0x121E
 
 #define USB_VENDOR_ID_AMI		0x046b
 #define USB_DEVICE_ID_AMI_VIRT_KEYBOARD_AND_MOUSE	0xff10
-- 
2.25.1



