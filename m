Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD06C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FEAF2067C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgHRGgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 02:36:51 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35316 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726519AbgHRGgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 02:36:46 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AB9B1CB4D72242937965;
        Tue, 18 Aug 2020 14:36:43 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.174.185.226) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Tue, 18 Aug 2020 14:36:34 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <lorenzo.pieralisi@arm.com>, <guohanjun@huawei.com>,
        <sudeep.holla@arm.com>
CC:     <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v2 0/2] ACPI/IORT: Code cleanups
Date:   Tue, 18 Aug 2020 14:36:23 +0800
Message-ID: <20200818063625.980-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.185.226]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* From v1 [1]:
  - As pointed out by Hanjun, remove two now unused inline functions.
    Compile tested with CONFIG_IOMMU_API is not selected.

[1] https://lore.kernel.org/r/20200817105946.1511-1-yuzenghui@huawei.com

Zenghui Yu (2):
  ACPI/IORT: Drop the unused @ops of iort_add_device_replay()
  ACPI/IORT: Remove the unused inline functions

 drivers/acpi/arm64/iort.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

-- 
2.19.1

