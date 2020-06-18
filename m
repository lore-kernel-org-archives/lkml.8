Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BC6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 679A22083B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592448636;
	bh=YPzz4H8pRJPKgR9c3fl1iGtB6EgAkhkiYDDNODbhzMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=euC7MWOhax+tSX/QYeK0Xnk9ynHFOhXVXygBb3Y+PdpROlbTjhlwsgAYwQ6s5FNRc
	 luq76+exF8zzj4LfZHS4DBeoXa2zp1wxk4nHl1eGqDCb36nhQuph3xL/DEiKfrgPIm
	 pYkK8gSGtq4ru/GOHFPOBdlQZAffuk+h5nbZ31rg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgFRBJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:09:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:35046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726909AbgFRBJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:09:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61B8E2193E;
        Thu, 18 Jun 2020 01:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442541;
        bh=YPzz4H8pRJPKgR9c3fl1iGtB6EgAkhkiYDDNODbhzMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RQOEzgxVM0ABlrOOxduNPsZUHR83Ow92gfO0Vi3bHRN0nuMP3Xxwc/54UZkGOLzmz
         AQ7CV84grMJolmMzO15uLpizRwCQhvVvApMbnJZGrBb+kXrdTxtT2fl48MPVdcAv27
         wLqX15eQCrV01waZv3yV/xMv7WI2PdzQBup7YfxM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wen Yang <wenyang@linux.alibaba.com>,
        chenqiwu <chenqiwu@xiaomi.com>, Sasha Levin <sashal@kernel.org>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 5.7 042/388] usb: roles: Switch on role-switch uevent reporting
Date:   Wed, 17 Jun 2020 21:02:19 -0400
Message-Id: <20200618010805.600873-42-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

[ Upstream commit 3e63cff384e625f09758ce8f4d01ae3033402b63 ]

Right now we don't report to user-space a role switch when doing a
usb_role_switch_set_role() despite having registered the uevent callbacks.

This patch switches on the notifications allowing user-space to see
role-switch change notifications and subsequently determine the current
controller data-role.

example:
PFX=/devices/platform/soc/78d9000.usb/ci_hdrc.0

root@somebox# udevadm monitor -p

KERNEL[49.894994] change $PFX/usb_role/ci_hdrc.0-role-switch (usb_role)
ACTION=change
DEVPATH=$PFX/usb_role/ci_hdrc.0-role-switch
SUBSYSTEM=usb_role
DEVTYPE=usb_role_switch
USB_ROLE_SWITCH=ci_hdrc.0-role-switch
SEQNUM=2432

Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Wen Yang <wenyang@linux.alibaba.com>
Cc: chenqiwu <chenqiwu@xiaomi.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Link: https://lore.kernel.org/r/20200508162937.2566818-1-bryan.odonoghue@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/roles/class.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
index 5b17709821df..27d92af29635 100644
--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@ -49,8 +49,10 @@ int usb_role_switch_set_role(struct usb_role_switch *sw, enum usb_role role)
 	mutex_lock(&sw->lock);
 
 	ret = sw->set(sw, role);
-	if (!ret)
+	if (!ret) {
 		sw->role = role;
+		kobject_uevent(&sw->dev.kobj, KOBJ_CHANGE);
+	}
 
 	mutex_unlock(&sw->lock);
 
-- 
2.25.1

