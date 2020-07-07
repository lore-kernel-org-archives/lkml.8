Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF4DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29F4320738
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594135126;
	bh=R3tobmEphXZondlgLmVPh2nqb+7crFjwTMkVQSBKyZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xpDS8yX9JEal6DJIvmf1Yn10aADKVjkhySZRpxdWovoqBzR+Z9Z5RfCfrMA0FCZ0T
	 DseWnyESGoJdlcTf0kHrTUJeOE6wTtIXMPjte4EoB65Kcympihc/qwX05mxa1OQp+l
	 u6AMZaYQkB0pk3aSOrs9juKg2d4+ur7pcHhKj8Ks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbgGGPSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:18:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:58140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729216AbgGGPSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:18:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E713E2065D;
        Tue,  7 Jul 2020 15:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594135122;
        bh=R3tobmEphXZondlgLmVPh2nqb+7crFjwTMkVQSBKyZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KEzo6mOWpHLg0FB2Vf4CzfUp3aUjlmicw4rTa/zI5I2/WXvH4ZqXdymY3f3xRJZqx
         0VqX5eUQub+t8u7gxaO+CdiLw6NmKv3egLjB59YEz2DUeOs0lyMwWiu1byCa7IOvv6
         JUSCocoufhAxm2duATLfJ1Q4PZ6lI27h5NR+bUYE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 20/36] hwmon: (acpi_power_meter) Fix potential memory leak in acpi_power_meter_add()
Date:   Tue,  7 Jul 2020 17:17:12 +0200
Message-Id: <20200707145750.097909076@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707145749.130272978@linuxfoundation.org>
References: <20200707145749.130272978@linuxfoundation.org>
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
index 2f2fb19669580..2f40da04a9445 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -896,7 +896,7 @@ static int acpi_power_meter_add(struct acpi_device *device)
 
 	res = setup_attrs(resource);
 	if (res)
-		goto exit_free;
+		goto exit_free_capability;
 
 	resource->hwmon_dev = hwmon_device_register(&device->dev);
 	if (IS_ERR(resource->hwmon_dev)) {
@@ -909,6 +909,8 @@ static int acpi_power_meter_add(struct acpi_device *device)
 
 exit_remove:
 	remove_attrs(resource);
+exit_free_capability:
+	free_capabilities(resource);
 exit_free:
 	kfree(resource);
 exit:
-- 
2.25.1



