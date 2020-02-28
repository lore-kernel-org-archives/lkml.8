Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D06EC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D3CA2469F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgB1PXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:23:01 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:40860 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726650AbgB1PXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:23:01 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D8DD125A82D882BC737;
        Fri, 28 Feb 2020 23:22:53 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Fri, 28 Feb 2020 23:22:44 +0800
From:   John Garry <john.garry@huawei.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>,
        <andriy.shevchenko@linux.intel.com>, <linuxarm@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH RFC 0/3] spi/HiSilicon v3xx: Support dual and quad mode through DMI quirks
Date:   Fri, 28 Feb 2020 23:18:48 +0800
Message-ID: <1582903131-160033-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As discussed during the original HiSilicon v3xx SPI driver upstreaming,
currently there is no method for the ACPI SPI Serial Bus Connection
Resource Descriptor to define the data buswidth [0], [1].

So we can look to get the ACPI spec updated for this, and I have
submitted a proposal for a new feature here:
https://bugzilla.tianocore.org/show_bug.cgi?id=2557

However I am not sure how successful that will be.

In the meantime, as an alternate approach, this RFC proposes to allow the
SPI controller driver override the device buswidth. In this example,
the driver uses DMI quirks to discover the host machine and set the 
buswidth override accordingly when the machine is known to support
dual or quad mode of operation.

I also have included a fix for dual and quad modes in the driver.

Comments welcome. thanks.

[0] https://lore.kernel.org/linux-mtd/20200109212842.GK3702@sirena.org.uk/
[1] https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf, 
     19.6.126

John Garry (3):
  spi: Allow SPI controller override device buswidth
  spi: HiSilicon v3xx: Properly set CMD_CONFIG for Dual/Quad modes
  spi: HiSilicon v3xx: Use DMI quirk to set controller buswidth override
    bits

 drivers/spi/spi-hisi-sfc-v3xx.c | 99 ++++++++++++++++++++++++++++++++-
 drivers/spi/spi.c               |  4 +-
 include/linux/spi/spi.h         |  3 +
 3 files changed, 104 insertions(+), 2 deletions(-)

-- 
2.17.1

