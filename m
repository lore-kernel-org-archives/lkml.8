Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC48C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83EB521974
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592579347;
	bh=nAuGnWonfd4HyO/pjCA+qAebhmiKun4xJwaQv4aG8GE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mZoc2pOVP96UJvP/TlLnRGb487pXVNAJngqGyCxf5viBH046ZqtQa8IFK301cFJkO
	 5lVhsHQTARUa97ws0d22nS4jJeWX3heqTerMt5Fiqr79zNx5mH1/GSTIPPEwTXQiR+
	 tp1cCKXew4Q1C9pqpzdH7l9mpC2iEQMdH6fPkODc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391850AbgFSPJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:09:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:38636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391842AbgFSPJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:09:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1017321941;
        Fri, 19 Jun 2020 15:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579340;
        bh=nAuGnWonfd4HyO/pjCA+qAebhmiKun4xJwaQv4aG8GE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sIrbJ8oI2Lp4icpYmufTdKNNpRGjgzKsHkWpsbSSZcjKvsPMNylb7IInJ8ohcxsm9
         Ab76soxgBAP5gtP3r7oaTIlu7d5X4CdQrGg0kWE1YveWIgt4IOAuvnFxUTa4+ayL35
         NUzra7geUZKRP86BsFFINqaTvZ+dTf3pA2ThGZk0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 099/261] platform/x86: intel-vbtn: Use acpi_evaluate_integer()
Date:   Fri, 19 Jun 2020 16:31:50 +0200
Message-Id: <20200619141654.615155203@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141649.878808811@linuxfoundation.org>
References: <20200619141649.878808811@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 18937875a231d831c309716d6d8fc358f8381881 ]

Use acpi_evaluate_integer() instead of open-coding it.

This is a preparation patch for adding a intel_vbtn_has_switches()
helper function.

Fixes: de9647efeaa9 ("platform/x86: intel-vbtn: Only activate tablet mode switch on 2-in-1's")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel-vbtn.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/intel-vbtn.c
index b74932307d69..3b3789bb8ec5 100644
--- a/drivers/platform/x86/intel-vbtn.c
+++ b/drivers/platform/x86/intel-vbtn.c
@@ -118,28 +118,21 @@ static void detect_tablet_mode(struct platform_device *device)
 	const char *chassis_type = dmi_get_system_info(DMI_CHASSIS_TYPE);
 	struct intel_vbtn_priv *priv = dev_get_drvdata(&device->dev);
 	acpi_handle handle = ACPI_HANDLE(&device->dev);
-	struct acpi_buffer vgbs_output = { ACPI_ALLOCATE_BUFFER, NULL };
-	union acpi_object *obj;
+	unsigned long long vgbs;
 	acpi_status status;
 	int m;
 
 	if (!(chassis_type && strcmp(chassis_type, "31") == 0))
-		goto out;
+		return;
 
-	status = acpi_evaluate_object(handle, "VGBS", NULL, &vgbs_output);
+	status = acpi_evaluate_integer(handle, "VGBS", NULL, &vgbs);
 	if (ACPI_FAILURE(status))
-		goto out;
-
-	obj = vgbs_output.pointer;
-	if (!(obj && obj->type == ACPI_TYPE_INTEGER))
-		goto out;
+		return;
 
-	m = !(obj->integer.value & TABLET_MODE_FLAG);
+	m = !(vgbs & TABLET_MODE_FLAG);
 	input_report_switch(priv->input_dev, SW_TABLET_MODE, m);
-	m = (obj->integer.value & DOCK_MODE_FLAG) ? 1 : 0;
+	m = (vgbs & DOCK_MODE_FLAG) ? 1 : 0;
 	input_report_switch(priv->input_dev, SW_DOCK, m);
-out:
-	kfree(vgbs_output.pointer);
 }
 
 static int intel_vbtn_probe(struct platform_device *device)
-- 
2.25.1



