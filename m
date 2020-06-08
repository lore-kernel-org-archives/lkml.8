Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAA7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE7AD20760
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591659942;
	bh=qwUWf6gPEAo0RWe2h0rpmiMF6XJTd6r4hEWaMEbOJBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EiAaYXxgEOrl3GA1YfWI+ckGNbxZ7VqPgRr0SAGZ5S7GCrq+ro5DrqoB97JEbxeFt
	 hwyDTBmFMWZNnNY4ih7lOWVM32G7wRKHTYFnDl+74YuFbZcGojFoWjL4RKjGnOrs3w
	 smNi7+iYIB3C8x41/cgZ18UMBvH7h27r7RxKk1J0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732459AbgFHXpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:45:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:54300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731997AbgFHX0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:26:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C454D2078D;
        Mon,  8 Jun 2020 23:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658796;
        bh=qwUWf6gPEAo0RWe2h0rpmiMF6XJTd6r4hEWaMEbOJBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J6G3QVILLq7sUxxjl/Etm6vxsO/2FMQRCTH72f6cayd5APDe0oZZrF6QT0a+yamI6
         KKYEWUxGXNr7tGi81Mj/Odm913ug9yPAEhsI00Rx1/1EiNkfNA0ISdBgOysaq4YWjU
         dQWm4VS6d2L2Vl7asDezlA5C0wfsozPgzsTFzngQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 70/72] platform/x86: hp-wmi: Convert simple_strtoul() to kstrtou32()
Date:   Mon,  8 Jun 2020 19:24:58 -0400
Message-Id: <20200608232500.3369581-70-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608232500.3369581-1-sashal@kernel.org>
References: <20200608232500.3369581-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 5cdc45ed3948042f0d73c6fec5ee9b59e637d0d2 ]

First of all, unsigned long can overflow u32 value on 64-bit machine.
Second, simple_strtoul() doesn't check for overflow in the input.

Convert simple_strtoul() to kstrtou32() to eliminate above issues.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/hp-wmi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
index 06a3c1ef8eee..952544ca0d84 100644
--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -474,8 +474,14 @@ static ssize_t postcode_show(struct device *dev, struct device_attribute *attr,
 static ssize_t als_store(struct device *dev, struct device_attribute *attr,
 			 const char *buf, size_t count)
 {
-	u32 tmp = simple_strtoul(buf, NULL, 10);
-	int ret = hp_wmi_perform_query(HPWMI_ALS_QUERY, HPWMI_WRITE, &tmp,
+	u32 tmp;
+	int ret;
+
+	ret = kstrtou32(buf, 10, &tmp);
+	if (ret)
+		return ret;
+
+	ret = hp_wmi_perform_query(HPWMI_ALS_QUERY, HPWMI_WRITE, &tmp,
 				       sizeof(tmp), sizeof(tmp));
 	if (ret)
 		return ret < 0 ? ret : -EINVAL;
-- 
2.25.1

