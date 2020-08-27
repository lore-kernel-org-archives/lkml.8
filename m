Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B603C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECE9A2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgH0OOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:14:30 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2699 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727793AbgH0OFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 10:05:39 -0400
Received: from lhreml715-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 36C2CADED43E460CC271;
        Thu, 27 Aug 2020 15:05:01 +0100 (IST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.87.119) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 27 Aug 2020 15:05:01 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bp@alien8.de>, <mchehab@kernel.org>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <rrichter@marvell.com>
CC:     <linuxarm@huawei.com>
Subject: [PATCH V2 topic-edac-5.1 0/2] EDAC: Add support for reporting the non-standard errors to vendor drivers
Date:   Thu, 27 Aug 2020 15:01:26 +0100
Message-ID: <20200827140128.1113-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.47.87.119]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml715-chm.china.huawei.com (10.201.108.66)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Presently non-standard HW errors are not reported to the vendor drivers
for the recovery.
This patch set adds support for reporting the non-standard errors to the
registered vendor drivers.
Also adds HIP08 EDAC driver, for the  recovery of the PCIe OEM errors on
HiSilicon HIP08.

RFC -> V2
1.Add error recovery for the PCIe local errors
2.Removed code for the other OEM errors from HIP08 edac driver
  because there is no current requirement for the recovery.
    
Shiju Jose (2):
  EDAC: Add support for reporting the non-standard errors to the vendor
    drivers
  EDAC: Add handling for the PCIe OEM errors on HiSilicon HIP08

 drivers/acpi/apei/ghes.c                    |   5 +
 drivers/edac/Makefile                       |   3 +-
 drivers/edac/edac_non_standard.c            | 124 ++++++++++++++
 drivers/edac/hisi_hip08_edac_non_standard.c | 255 ++++++++++++++++++++++++++++
 include/linux/edac_non_standard.h           |  74 ++++++++
 5 files changed, 460 insertions(+), 1 deletion(-)
 create mode 100644 drivers/edac/edac_non_standard.c
 create mode 100644 drivers/edac/hisi_hip08_edac_non_standard.c
 create mode 100644 include/linux/edac_non_standard.h

-- 
1.9.1


