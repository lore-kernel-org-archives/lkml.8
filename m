Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1C8C35643
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D46CD206ED
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582274577;
	bh=hVrg8rRe/pnLXFS4sp1Q4wJtlR5vsf1nCybQKCaUqxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xqggwf12lMLeKnjPyxGBOmssRkkb3SzDe+UMsC8YcK2FcuIigqPoYVlvn0dZezYkc
	 7JJFI304lcijiGhox6jIvqaNp7kANNMv8Zu9lS+ErMhBgJeC2dMiIqfe6Ba8CwsTW/
	 8goUjyNIbRt2AhSFBc2CjSSldZkUBK8ZHTC++BTw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbgBUHyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 02:54:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:52792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729510AbgBUHyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:54:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 462672073A;
        Fri, 21 Feb 2020 07:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582271654;
        bh=hVrg8rRe/pnLXFS4sp1Q4wJtlR5vsf1nCybQKCaUqxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pE/WuilmIDTtMQASThJkKUrIx6M9Ev/SITJZCjC1AX66Bwc4ti48Uqyg26jy5NFVp
         CNYzxuyyHuZMWNcjxp+HXn0k8pwEoRC0uzBfhQb+Fgh1t1K4OEPLGTCfZuWCbzavUL
         uSVw0LvGngHcjeUpN2WABIYWIt8y79BqVjYnQlLg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 249/399] visorbus: fix uninitialized variable access
Date:   Fri, 21 Feb 2020 08:39:34 +0100
Message-Id: <20200221072426.647069566@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072402.315346745@linuxfoundation.org>
References: <20200221072402.315346745@linuxfoundation.org>
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



