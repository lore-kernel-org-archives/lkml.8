Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA57C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98653207F7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="GbuEjRaU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgHLPPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 11:15:47 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:37122 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726489AbgHLPPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 11:15:33 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 3A0CF4C8B1;
        Wed, 12 Aug 2020 15:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received; s=mta-01; t=1597245330; x=
        1599059731; bh=WwjPfLnomL2r+HVIJaHtMZVaUiKzFEyoEtIATOH76YY=; b=G
        buEjRaUaNwzJY86BzNuWkSqAwqfLjuKUGGwhWfH6i34Jyq73OHB8FDZdWaeU5YIV
        05PPXNliL+N6k2qyxhYeo71xxK51Iha2Tms1fWZo6zJ393ltIG90KYxRZuE6ueMe
        dhOywejDY1fIE6lLFnFuGaHOnD5aPrnsna95U6FfQM=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pfm51ryF4SZ1; Wed, 12 Aug 2020 18:15:30 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 8AD5A4C89B;
        Wed, 12 Aug 2020 18:15:29 +0300 (MSK)
Received: from localhost.dev.yadro.com (10.199.2.34) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Wed, 12 Aug 2020 18:15:29 +0300
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
CC:     Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] enable lock interface for macronix chips
Date:   Wed, 12 Aug 2020 18:18:16 +0300
Message-ID: <20200812151818.16699-1-i.mikhaylov@yadro.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.2.34]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TB(Top/Bottome protection bit) is not present in the status register for
macronix chips, do not touch TB bit in status register in this case.
Enable lock interface for most of macronix chips which are suitable for it.

Tested only mx25l51245g (BP0-3).

Ivan Mikhaylov (2):
  mtd: spi-nor: do not touch TB bit without SPI_NOR_HAS_TB
  mtd: spi-nor: enable lock interface for macronix chips

 drivers/mtd/spi-nor/core.c     | 22 +++++++---
 drivers/mtd/spi-nor/macronix.c | 75 ++++++++++++++++++++++------------
 2 files changed, 66 insertions(+), 31 deletions(-)

-- 
2.21.1

