Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF970C433E3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80F5E207F9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594134864;
	bh=nDHHUj4tN2fihv82K94trrpOrL8ziYi2I+QD6CQeNWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fa0B4c3MKVFJ+eVlVmi628jAJLvc9xgULB9VqAjK/hGj+ZgRc3U2oVqdrsyjuA9Uw
	 0IDveJRCyWsoWtV+vvEy8xPrLrTUaVF39g6N1WDQS/TM679DzEGrZNjuqyGswWs1SY
	 6I0RnyAuVtcr9spIDsz0JBm4PO095MlhgQGmQfRU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbgGGPOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:14:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:53592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728470AbgGGPOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:14:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4FC220738;
        Tue,  7 Jul 2020 15:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594134858;
        bh=nDHHUj4tN2fihv82K94trrpOrL8ziYi2I+QD6CQeNWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XqV1sqPWvR2DeSQ/k5/Mn95/RHmC0CuSo4lxLXyz/oqc2r/QeF6onKnsFu+0MJtqx
         zWpRcCf+wGSMsK/ju7ocmaAGgZwLI+kP+j37PZbL1qgJGJzsjiMdonh2Y9FRyFV0tD
         /2IdCwAi4oGyRwJc3DcH2mo7uMcPxFVMtgc4+hjo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 15/24] hwmon: (acpi_power_meter) Fix potential memory leak in acpi_power_meter_add()
Date:   Tue,  7 Jul 2020 17:13:47 +0200
Message-Id: <20200707145749.714012154@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707145748.952502272@linuxfoundation.org>
References: <20200707145748.952502272@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>

[ Upstream commit 8b97f9922211c44a739c5cbd9502ecbb9f17f6d1 ]

Although it rarely happens, we should call free_capabilities()
if error happens after read_capabilities() to free allocated strings.

Fixes: de584afa5e188 ("hwmon driver for ACPI 4.0 power meters")
Signed-off-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Link: https://lore.kernel.org/r/20200625043242.31175-1-misono.tomohiro@jp.fujitsu.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/acpi_power_meter.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index e27f7e12c05bb..9b4ad6c74041e 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -895,7 +895,7 @@ static int acpi_power_meter_add(struct acpi_device *device)
 
 	res = setup_attrs(resource);
 	if (res)
-		goto exit_free;
+		goto exit_free_capability;
 
 	resource->hwmon_dev = hwmon_device_register(&device->dev);
 	if (IS_ERR(resource->hwmon_dev)) {
@@ -908,6 +908,8 @@ static int acpi_power_meter_add(struct acpi_device *device)
 
 exit_remove:
 	remove_attrs(resource);
+exit_free_capability:
+	free_capabilities(resource);
 exit_free:
 	kfree(resource);
 exit:
-- 
2.25.1



