Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CADC35240
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 01:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF8222464
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 01:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579828697;
	bh=w9WNDehsM1lFSFmPeMSuZhv8mPkdVYroQ9F1lrDU4GQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SSDivptmt7+g1c5ds2oco4m3VbNrQ6jbd9zQSrIxnGCad4wtwkWau+h9Ng3Kkry4Y
	 ColdbGq2YkQn9GwJl/fWifuav5/uXi7gWMhywU+ZtK8gv0UsiTlB6wPN/8eZCIhl1O
	 SkxdO5TM9Qk21Drz/JaS4dYdM3sEy2XHgkzFVong=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730261AbgAXBSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 20:18:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:33372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729545AbgAXBSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 20:18:12 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFBC821D7E;
        Fri, 24 Jan 2020 01:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579828691;
        bh=w9WNDehsM1lFSFmPeMSuZhv8mPkdVYroQ9F1lrDU4GQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KMF6rzF0anuDYLq6YCAKfzzsZ6prsmPzYKEK5N4MBeQHi8Wv5VaHn8P1ubQjaIlPc
         sFpJYkOWjNTTL0t7Yx9U5IbWX4oztaCR0bW+vMSniLtEDG7N/EOt6jFE9Yhno1iheY
         hc0UKAxJ7SB/sBynSNv78Ue94x4O445WbYQNP600=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Laura Abbott <labbott@fedoraproject.org>,
        Steven Ellis <sellis@redhat.com>,
        Pacho Ramos <pachoramos@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net
Subject: [PATCH AUTOSEL 4.9 2/2] usb-storage: Disable UAS on JMicron SATA enclosure
Date:   Thu, 23 Jan 2020 20:18:08 -0500
Message-Id: <20200124011808.18801-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124011808.18801-1-sashal@kernel.org>
References: <20200124011808.18801-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laura Abbott <labbott@fedoraproject.org>

[ Upstream commit bc3bdb12bbb3492067c8719011576370e959a2e6 ]

Steve Ellis reported incorrect block sizes and alignement
offsets with a SATA enclosure. Adding a quirk to disable
UAS fixes the problems.

Reported-by: Steven Ellis <sellis@redhat.com>
Cc: Pacho Ramos <pachoramos@gmail.com>
Signed-off-by: Laura Abbott <labbott@fedoraproject.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/storage/unusual_uas.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/storage/unusual_uas.h b/drivers/usb/storage/unusual_uas.h
index f15aa47c54a9d..0eb8c67ee1382 100644
--- a/drivers/usb/storage/unusual_uas.h
+++ b/drivers/usb/storage/unusual_uas.h
@@ -163,12 +163,15 @@ UNUSUAL_DEV(0x2537, 0x1068, 0x0000, 0x9999,
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_IGNORE_UAS),
 
-/* Reported-by: Takeo Nakayama <javhera@gmx.com> */
+/*
+ * Initially Reported-by: Takeo Nakayama <javhera@gmx.com>
+ * UAS Ignore Reported by Steven Ellis <sellis@redhat.com>
+ */
 UNUSUAL_DEV(0x357d, 0x7788, 0x0000, 0x9999,
 		"JMicron",
 		"JMS566",
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
-		US_FL_NO_REPORT_OPCODES),
+		US_FL_NO_REPORT_OPCODES | US_FL_IGNORE_UAS),
 
 /* Reported-by: Hans de Goede <hdegoede@redhat.com> */
 UNUSUAL_DEV(0x4971, 0x1012, 0x0000, 0x9999,
-- 
2.20.1

