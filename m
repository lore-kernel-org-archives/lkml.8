Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06413C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C389120760
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593468005;
	bh=N2IbsRFaLFjDTh/NoWJYWlGOxlpbKvfzjTvumYUSvPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=juEQ8mnxA+WskalyBUClfTOCO9jYLm083ESMywL+KpSR7F6C/tTA3uuMlq08OEmIv
	 rDS8FngXwQVgKpS1CRqlrRSzhNQZhJ7YQtHq0eKoSTsY1b65eL0iXBW66bBuR5PFrC
	 dv6os6IA1GBUTvU+WcChsbHjmK9aGCUKmFJd0RNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgF2WAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 18:00:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbgF2SfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:35:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAF5F24794;
        Mon, 29 Jun 2020 15:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444102;
        bh=N2IbsRFaLFjDTh/NoWJYWlGOxlpbKvfzjTvumYUSvPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Au9mtUTGUPsMVThKbanopAsuwm/sGRH0NhW6OJ7WN3ln/4V4f2yPym3Z/Au3AKdXe
         ABok8IPTI1DJ0ZjSYB8GP6XBxIS4s0HPfRZHAvR2D82Jv7v6mrU8IvPJAyIy/74bIy
         WvrmN9lIZY8k0DtT+Da+QxJjr4d4iKhMzRG/FjsA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.7 213/265] ACPI: configfs: Disallow loading ACPI tables when locked down
Date:   Mon, 29 Jun 2020 11:17:26 -0400
Message-Id: <20200629151818.2493727-214-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629151818.2493727-1-sashal@kernel.org>
References: <20200629151818.2493727-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.7.7-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.7.7-rc1
X-KernelTest-Deadline: 2020-07-01T15:14+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jason A. Donenfeld" <Jason@zx2c4.com>

commit 75b0cea7bf307f362057cc778efe89af4c615354 upstream.

Like other vectors already patched, this one here allows the root
user to load ACPI tables, which enables arbitrary physical address
writes, which in turn makes it possible to disable lockdown.

Prevents this by checking the lockdown status before allowing a new
ACPI table to be installed. The link in the trailer shows a PoC of
how this might be used.

Link: https://git.zx2c4.com/american-unsigned-language/tree/american-unsigned-language-2.sh
Cc: 5.4+ <stable@vger.kernel.org> # 5.4+
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/acpi_configfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_configfs.c b/drivers/acpi/acpi_configfs.c
index ece8c1a921cc1..88c8af455ea3f 100644
--- a/drivers/acpi/acpi_configfs.c
+++ b/drivers/acpi/acpi_configfs.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/configfs.h>
 #include <linux/acpi.h>
+#include <linux/security.h>
 
 #include "acpica/accommon.h"
 #include "acpica/actables.h"
@@ -28,7 +29,10 @@ static ssize_t acpi_table_aml_write(struct config_item *cfg,
 {
 	const struct acpi_table_header *header = data;
 	struct acpi_table *table;
-	int ret;
+	int ret = security_locked_down(LOCKDOWN_ACPI_TABLES);
+
+	if (ret)
+		return ret;
 
 	table = container_of(cfg, struct acpi_table, cfg);
 
-- 
2.25.1

