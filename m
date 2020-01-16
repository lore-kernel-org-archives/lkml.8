Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FBCC33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D055F2073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579201234;
	bh=sujWSidxGQh0FrodT21X75t2dAsJYhleL/Z93fr0TOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PXPqf1W05WHbA77PBS1c+CTKHg5MwZQvXcepe/0knI4myM/0l/fvbmbn/r23a+Wos
	 d0dfRDyYASvMCS4WgcHtaxxvMgPzmAj5zR2pdNQzEHzbWpS+EvQfuBgvWyFPttHVpG
	 E1/TvJ8AS7EFkhixw4rmcSv9s7QX6SM+R5YN3Qc8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388881AbgAPRGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:06:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:35766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388823AbgAPRGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:06:04 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D982A22464;
        Thu, 16 Jan 2020 17:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194363;
        bh=sujWSidxGQh0FrodT21X75t2dAsJYhleL/Z93fr0TOg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P5pLo4XWTbVGO61eKMpQBGOIEz8Dt2wVOHmyNDkaWCYvsHPA8j4dlsU88qjsUExRO
         YQil4kPuC/kDifcTuHLpJ9R/4MzCI4YgNqx03qsxqHsqK2AJJhmx77XsDnbr9+XGff
         57A3DCwF5BWU3QFv5Po6HlKGYPbcuIUlkgENixBQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        Darren Hart <dvhart@infradead.org>,
        Sasha Levin <sashal@kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 299/671] platform/x86: alienware-wmi: fix kfree on potentially uninitialized pointer
Date:   Thu, 16 Jan 2020 11:58:57 -0500
Message-Id: <20200116170509.12787-36-sashal@kernel.org>
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

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 98e2630284ab741804bd0713e932e725466f2f84 ]

Currently the kfree of output.pointer can be potentially freeing
an uninitalized pointer in the case where out_data is NULL. Fix this
by reworking the case where out_data is not-null to perform the
ACPI status check and also the kfree of outpoint.pointer in one block
and hence ensuring the pointer is only freed when it has been used.

Also replace the if (ptr != NULL) idiom with just if (ptr).

Fixes: ff0e9f26288d ("platform/x86: alienware-wmi: Correct a memory leak")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/alienware-wmi.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/alienware-wmi.c b/drivers/platform/x86/alienware-wmi.c
index f10af5c383c5..c0d1555735cd 100644
--- a/drivers/platform/x86/alienware-wmi.c
+++ b/drivers/platform/x86/alienware-wmi.c
@@ -522,23 +522,22 @@ static acpi_status alienware_wmax_command(struct wmax_basic_args *in_args,
 
 	input.length = (acpi_size) sizeof(*in_args);
 	input.pointer = in_args;
-	if (out_data != NULL) {
+	if (out_data) {
 		output.length = ACPI_ALLOCATE_BUFFER;
 		output.pointer = NULL;
 		status = wmi_evaluate_method(WMAX_CONTROL_GUID, 0,
 					     command, &input, &output);
-	} else
+		if (ACPI_SUCCESS(status)) {
+			obj = (union acpi_object *)output.pointer;
+			if (obj && obj->type == ACPI_TYPE_INTEGER)
+				*out_data = (u32)obj->integer.value;
+		}
+		kfree(output.pointer);
+	} else {
 		status = wmi_evaluate_method(WMAX_CONTROL_GUID, 0,
 					     command, &input, NULL);
-
-	if (ACPI_SUCCESS(status) && out_data != NULL) {
-		obj = (union acpi_object *)output.pointer;
-		if (obj && obj->type == ACPI_TYPE_INTEGER)
-			*out_data = (u32) obj->integer.value;
 	}
-	kfree(output.pointer);
 	return status;
-
 }
 
 /*
-- 
2.20.1

