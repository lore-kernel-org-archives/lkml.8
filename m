Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD47BC2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 08:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE6F22206
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 08:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgDIIqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 04:46:54 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12702 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725987AbgDIIqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 04:46:54 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 11114BFF47C643743604;
        Thu,  9 Apr 2020 16:46:37 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Thu, 9 Apr 2020
 16:46:28 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <clemens@ladisch.de>, <jdelvare@suse.com>, <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH RESEND] hwmon: (k10temp) make some symbols static
Date:   Thu, 9 Apr 2020 16:45:02 +0800
Message-ID: <20200409084502.42126-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warning:

drivers/hwmon/k10temp.c:189:12: warning: symbol 'k10temp_temp_label' was
not declared. Should it be static?
drivers/hwmon/k10temp.c:202:12: warning: symbol 'k10temp_in_label' was
not declared. Should it be static?
drivers/hwmon/k10temp.c:207:12: warning: symbol 'k10temp_curr_label' was
not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/hwmon/k10temp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 3f37d5d81fe4..9915578533bb 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -186,7 +186,7 @@ static long get_raw_temp(struct k10temp_data *data)
 	return temp;
 }
 
-const char *k10temp_temp_label[] = {
+static const char *k10temp_temp_label[] = {
 	"Tctl",
 	"Tdie",
 	"Tccd1",
@@ -199,12 +199,12 @@ const char *k10temp_temp_label[] = {
 	"Tccd8",
 };
 
-const char *k10temp_in_label[] = {
+static const char *k10temp_in_label[] = {
 	"Vcore",
 	"Vsoc",
 };
 
-const char *k10temp_curr_label[] = {
+static const char *k10temp_curr_label[] = {
 	"Icore",
 	"Isoc",
 };
-- 
2.17.2

