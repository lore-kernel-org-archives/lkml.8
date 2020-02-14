Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0C4C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A662086A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581695788;
	bh=hVrg8rRe/pnLXFS4sp1Q4wJtlR5vsf1nCybQKCaUqxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NJe7xAwwEfI8YT+thK0i4Ghhsvj7obRb1bXCqmGUncPCpNZk+NvmPtF1F50aNs4ut
	 YX4SxeCEvy9dM2BcRjFxsAr3SXuj9Jm+JCWNVrW0+3ukkGNYcuZ4fNo1ERgA6F2kWC
	 vDF750GgJydlrMmZLWZ8RpFLtzniogUwlOUi/IIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387812AbgBNP41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:56:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:38150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387757AbgBNP4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:56:21 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A68D2082F;
        Fri, 14 Feb 2020 15:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695781;
        bh=hVrg8rRe/pnLXFS4sp1Q4wJtlR5vsf1nCybQKCaUqxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LScIfIr93l1svA6/KDcDWi8wjMd5UUAywVSAZkQ4688LQrxkVqKFA7LCdUgxL9wnx
         fVRWuWfws2hLLQ8qi7pYGMUMNqnOCaGAj5tJapmAiJN1vFENb3Ulo9EMIjZ18tDFb3
         NZaysSTDP17uuqBMdlwGCNUklviRgA8cUOfGYx3E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, sparmaintainer@unisys.com
Subject: [PATCH AUTOSEL 5.5 345/542] visorbus: fix uninitialized variable access
Date:   Fri, 14 Feb 2020 10:45:37 -0500
Message-Id: <20200214154854.6746-345-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit caf82f727e69b647f09d57a1fc56e69d22a5f483 ]

The setup_crash_devices_work_queue function only partially initializes
the message it sends to chipset_init, leading to undefined behavior:

drivers/visorbus/visorchipset.c: In function 'setup_crash_devices_work_queue':
drivers/visorbus/visorchipset.c:333:6: error: '((unsigned char*)&msg.hdr.flags)[0]' is used uninitialized in this function [-Werror=uninitialized]
  if (inmsg->hdr.flags.response_expected)

Set up the entire structure, zero-initializing the 'response_expected'
flag.

This was apparently found by the patch that added the -O3 build option
in Kconfig.

Fixes: 12e364b9f08a ("staging: visorchipset driver to provide registration and other services")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20200107202950.782951-1-arnd@arndb.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/visorbus/visorchipset.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/visorbus/visorchipset.c b/drivers/visorbus/visorchipset.c
index ca752b8f495fa..cb1eb7e05f871 100644
--- a/drivers/visorbus/visorchipset.c
+++ b/drivers/visorbus/visorchipset.c
@@ -1210,14 +1210,17 @@ static void setup_crash_devices_work_queue(struct work_struct *work)
 {
 	struct controlvm_message local_crash_bus_msg;
 	struct controlvm_message local_crash_dev_msg;
-	struct controlvm_message msg;
+	struct controlvm_message msg = {
+		.hdr.id = CONTROLVM_CHIPSET_INIT,
+		.cmd.init_chipset = {
+			.bus_count = 23,
+			.switch_count = 0,
+		},
+	};
 	u32 local_crash_msg_offset;
 	u16 local_crash_msg_count;
 
 	/* send init chipset msg */
-	msg.hdr.id = CONTROLVM_CHIPSET_INIT;
-	msg.cmd.init_chipset.bus_count = 23;
-	msg.cmd.init_chipset.switch_count = 0;
 	chipset_init(&msg);
 	/* get saved message count */
 	if (visorchannel_read(chipset_dev->controlvm_channel,
-- 
2.20.1

