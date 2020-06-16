Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B54C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 09:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7F3E20707
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 09:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgFPJU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 05:20:26 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6332 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726052AbgFPJUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 05:20:25 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 00982DC7001A3BFF068A;
        Tue, 16 Jun 2020 17:20:23 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Tue, 16 Jun 2020 17:20:16 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <guohanjun@huawei.com>, <wangxiongfeng2@huawei.com>
Subject: [PATCH 0/2] ACPI: sysfs: add missing newlines when printing acpi module parameters
Date:   Tue, 16 Jun 2020 17:14:07 +0800
Message-ID: <1592298849-41530-1-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I cat module parameters in '/sys/module/acpi/parameters/',
I found several parameters need a newline.

[root@hulk-202 ~]# cd /sys/module/acpi/parameters/
[root@hulk-202 parameters]# cat acpica_version
20180810[root@hulk-202 parameters]# cat ec_event_clearing
query[root@hulk-202 parameters]# 
[root@localhost parameters]# cat trace_method_name
(null)[root@localhost parameters]# cat trace_state
disable[root@localhost parameters]#

Xiongfeng Wang (2):
  ACPI: EC: add a newline when printing module parameter
    'ec_event_clearing'
  ACPI: sysfs: add missing newlines when printing module parameters

 drivers/acpi/ec.c    |  8 ++++----
 drivers/acpi/sysfs.c | 12 ++++++------
 2 files changed, 10 insertions(+), 10 deletions(-)

-- 
1.7.12.4

