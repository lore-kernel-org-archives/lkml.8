Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2F2C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A8E20637
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582273650;
	bh=hVrg8rRe/pnLXFS4sp1Q4wJtlR5vsf1nCybQKCaUqxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nOUMG8PnzGFivdTuq42qIKD/SAZVNqBXh+PXyIZTQUxyDFN4yUVlCv4LD6CVp7/dM
	 0iiSFOPGfxXTjxxAFUUsjGeZ4zDaDKpaI2mwgs17w0M4erhrkcVHZzofhPGeaGL0wf
	 kn3dO/Uvk6JTzsRzAcGq6VRPxlVDxknrFgzcQeTU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388249AbgBUIVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:21:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:33028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731212AbgBUIVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:21:41 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5368520578;
        Fri, 21 Feb 2020 08:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582273300;
        bh=hVrg8rRe/pnLXFS4sp1Q4wJtlR5vsf1nCybQKCaUqxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IkZlmuiIM6kz9JgnSp9Vur1g24/YA402G/UkVUtN3ZG3ldQwyEE8K0u1Hb6npjcUO
         im+Xt6q4K9REbMeDio8Vpp/7dYtI4Ay32rdP3h9bGr4f+wisWkaEsQlgvwbf8dlYvc
         vXCA+XeaJ22IEXZOTf/wtQbxOcWFjdM43fPvk8uI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 118/191] visorbus: fix uninitialized variable access
Date:   Fri, 21 Feb 2020 08:41:31 +0100
Message-Id: <20200221072305.058595998@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072250.732482588@linuxfoundation.org>
References: <20200221072250.732482588@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



