Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57690C2D0EB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 08:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3957A20733
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 08:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbgC3I6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 04:58:55 -0400
Received: from a3.inai.de ([88.198.85.195]:33608 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728759AbgC3I6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 04:58:55 -0400
Received: by a3.inai.de (Postfix, from userid 65534)
        id 3EAA5588C9AA0; Mon, 30 Mar 2020 10:58:53 +0200 (CEST)
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:10b:45d8::f8])
        by a3.inai.de (Postfix) with ESMTP id BA743588C9A9D;
        Mon, 30 Mar 2020 10:58:52 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     rafael.j.wysocki@intel.com
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] acpica: clear global_lock bits at FACS initialization
Date:   Mon, 30 Mar 2020 10:58:52 +0200
Message-Id: <20200330085852.31328-1-jengelh@inai.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the firmware ROM supplies a FACS table with garbage, and the
firmware code does not clear the global_lock field before booting to a
loader/OS, the garbage bytes in that field (like 0xffffffff) can
indicate that the lock is taken when it is not, thereby preventing
obtaining said lock even though it is otherwise perfectly usable if
the field were not prepopulated with garbage.

Reset the lock to a known good state upon ACPI initialization.

References: https://bugzilla.kernel.org/show_bug.cgi?id=206553
Signed-off-by: Jan Engelhardt <jengelh@inai.de>
---

 drivers/acpi/acpica/tbutils.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index c5f0b8ec70cc..26bdbc585d7e 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -56,6 +56,9 @@ acpi_status acpi_tb_initialize_facs(void)
 								     &facs));
 		acpi_gbl_FACS = facs;
 	}
+	/* Clear potential garbage from the initial FACS table. */
+	if (facs != NULL)
+		facs->global_lock &= ~0x3;
 
 	/* If there is no FACS, just continue. There was already an error msg */
 
-- 
2.26.0

