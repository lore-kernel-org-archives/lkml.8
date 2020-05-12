Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249F1C54E8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 11:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E69DA206CC
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 11:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="M/W12HfS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbgELLsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 07:48:45 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:40253 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726187AbgELLso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 07:48:44 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04CBmA5T021217;
        Tue, 12 May 2020 13:48:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=D3pNqSIt8oGGo+ly3QButpe43l6v+9Np/M1AzLOvJCI=;
 b=M/W12HfS1hio1seh0PZLywV5bMNlbMxml6KwapJMqZmTDmQp06gXG9mC8T7ZaaV9Y5d9
 8bVSySBO1L0JN9KxGaxL1t9c8WluBbt5ypxEazZeAAbs54Mcift4KNJhYZlcz9XmAe98
 +cW/ZOKWG1VrCwWSbrIWk7iZGNgnUa1iMc37hyEixJdW98xAqkt36aKrM5eSUtikCJkL
 W4PwWmg8XxhQekfC7turFxWEd7xFTLkq6KFvcbw4EAbOh5LLQ8IlW7FzdtS1Ld5g0xJG
 jzeilpvjEyIiO0ROM3kpytRP/B4fmWYyknxAZoXc1lvktahMbYzf4YaECuXT0b0/L1ge Zw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30wj9wg9mh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 May 2020 13:48:26 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 409CE10002A;
        Tue, 12 May 2020 13:48:23 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2D6802AC5B9;
        Tue, 12 May 2020 13:48:23 +0200 (CEST)
Received: from localhost (10.75.127.48) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 12 May 2020 13:48:22
 +0200
From:   Christophe Kerello <christophe.kerello@st.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Christophe Kerello <christophe.kerello@st.com>
Subject: [PATCH v5 0/2] mtd: rawnand: stm32_fmc2: rebase cosmetic change on top of nand/next
Date:   Tue, 12 May 2020 13:47:46 +0200
Message-ID: <1589284068-4079-1-git-send-email-christophe.kerello@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG4NODE1.st.com (10.75.127.10) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-12_03:2020-05-11,2020-05-12 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set of patches is a rebase of the patches that were not applied
on nand/next.

Changes in v5:
 - rebase on top of nand/next

Changes in v3:
 - add Miquel reviewed-by tag

Christophe Kerello (2):
  mtd: rawnand: stm32_fmc2: cosmetic change to use nfc instead of    
    fmc2 where relevant
  mtd: rawnand: stm32_fmc2: use FIELD_PREP/FIELD_GET macros

 drivers/mtd/nand/raw/stm32_fmc2_nand.c | 987 ++++++++++++++++-----------------
 1 file changed, 488 insertions(+), 499 deletions(-)

-- 
1.9.1

