Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01AEC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB08206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579201325;
	bh=IRmLSqE83uCsKnjCWPMxfFgshRxKOTa8eJMPacvSZ0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TbZVi8O+J79LhyLL17+gnjXPQaCVS90c9mnGzNK1AHxpWgtEXorhYQNo+6x9SmeqX
	 m+fEwKWrBQ1O+zUhQHyVxf1nf2Dw0glrEVGUCDX6Dmv5T4RF8aHQmWH6pok1X4KcJu
	 gTna97691axQJCAwB6NHpcQdTo0JlNgWjBw1AY9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437301AbgAPTCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:02:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:35074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388714AbgAPRFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:05:46 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0D612051A;
        Thu, 16 Jan 2020 17:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194345;
        bh=IRmLSqE83uCsKnjCWPMxfFgshRxKOTa8eJMPacvSZ0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xRyE3qE9XkPxfH2+JyxOs2H2/N76aN3XOgSIi0EkJrgm99r1hIb+DmswKB8rjJ1yG
         GZ9JA6u52W8Wbtwln2NB70OXXycuIj3fQFlvKEuiU8nD4XsWhUjNcdMe1GUk8u7Kxy
         nK0CBxwg507SCqC0VUh9EZiaFL9Ra1fzH+M9cizk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Steven Price <steven.price@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 287/671] firmware: arm_scmi: fix of_node leak in scmi_mailbox_check
Date:   Thu, 16 Jan 2020 11:58:45 -0500
Message-Id: <20200116170509.12787-24-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Price <steven.price@arm.com>

[ Upstream commit fa7fe29a645b4da08efe8ff2392898b88f9ded9f ]

of_parse_phandle_with_args() requires the caller to call of_node_put() on
the returned args->np pointer. Otherwise the reference count will remain
incremented.

However, in this case, since we don't actually use the returned pointer,
we can simply pass in NULL.

Fixes: aa4f886f3893f ("firmware: arm_scmi: add basic driver infrastructure for SCMI")
Signed-off-by: Steven Price <steven.price@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/arm_scmi/driver.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 09119e3f5c01..effc4c17e0fb 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -662,9 +662,7 @@ static int scmi_xfer_info_init(struct scmi_info *sinfo)
 
 static int scmi_mailbox_check(struct device_node *np)
 {
-	struct of_phandle_args arg;
-
-	return of_parse_phandle_with_args(np, "mboxes", "#mbox-cells", 0, &arg);
+	return of_parse_phandle_with_args(np, "mboxes", "#mbox-cells", 0, NULL);
 }
 
 static int scmi_mbox_free_channel(int id, void *p, void *data)
-- 
2.20.1

