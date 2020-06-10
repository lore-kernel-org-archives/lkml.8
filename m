Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EADC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 02:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 559782072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 02:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgFJCtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 22:49:50 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5873 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725798AbgFJCtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 22:49:50 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E102CF37577217DAED07;
        Wed, 10 Jun 2020 10:49:44 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Wed, 10 Jun 2020 10:49:34 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <harryxiyou@gmail.com>, <alex.shi@linux.alibaba.com>,
        <corbet@lwn.net>
CC:     <mchehab+huawei@kernel.org>, <chenzhou10@huawei.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] docs/zh_CN: update sysfs.txt about show() usage
Date:   Wed, 10 Jun 2020 10:53:33 +0800
Message-ID: <20200610025333.84010-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the show() usage according to the English version.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 Documentation/translations/zh_CN/filesystems/sysfs.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/translations/zh_CN/filesystems/sysfs.txt b/Documentation/translations/zh_CN/filesystems/sysfs.txt
index fcf620049d11..9481e3ed2a06 100644
--- a/Documentation/translations/zh_CN/filesystems/sysfs.txt
+++ b/Documentation/translations/zh_CN/filesystems/sysfs.txt
@@ -213,10 +213,12 @@ Sysfs 将会为每次读写操作调用一次这个方法。这使得这些方
 
 - 缓冲区应总是 PAGE_SIZE 大小。对于i386，这个值为4096。
 
-- show() 方法应该返回写入缓冲区的字节数，也就是 snprintf()的
+- show() 方法应该返回写入缓冲区的字节数，也就是 scnprintf()的
   返回值。
 
-- show() 应始终使用 snprintf()。
+- show() 方法在将格式化返回值返回用户空间的时候，禁止使用snprintf()。
+  如果可以保证不会发生缓冲区溢出，可以使用sprintf()，否则必须使用
+  scnprintf()。
 
 - store() 应返回缓冲区的已用字节数。如果整个缓存都已填满，只需返回
   count 参数。
-- 
2.20.1

