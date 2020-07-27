Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D217C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 425B12072E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zFSrD8T4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbgG0Md7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 08:33:59 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:63584 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbgG0Md6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 08:33:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595853237; x=1627389237;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IZQlZGNtosjkY1BTFF856UFpmZkCHqAhPaAMwvSuxaM=;
  b=zFSrD8T4POrDLzzPbWOIk0CKimXhJKG4btESFCntRs2WKAV8qEP42dCe
   1pZjnao+FFerK00NZiQsyNAHUkdLbqZ28buALNtKwIol0QT3x/u/kMpq8
   ozXVAG+r62fNqUPKIOTZpAhv0JtmyImJu9lmDITX3ylI8mhi3wih5jQsZ
   8q56i3bwAfitktDCz66Y7NMbiewqpAu1bXx8qncnzbV0rrr1ZApUsgaEt
   DqvhdFcWrL2mcEiVpbqGxQoCLgepFKXGDUjyjNyUzhhkQ3wPv54G5puwm
   dpHjI4IOlNzLaZ1kETkPlzxgeY4V2ER0SdksYA1lsPEul4EVkBphe7/TP
   g==;
IronPort-SDR: FA8jFvW+fpnDsWy2BmShj3vdgj2KTnzFgF9zcDKJi8TTi9dPx+abSDW/160FVz5ZgPGughJHJl
 SNjc4BjzvCv2qi+hCpt65dgBEDGgLhgLuYefO0nSctBBJOoCgHCF/UNMDbnHHBEWtBa6FRdNq6
 HXnHtlRY7EQjbryYg73RMyQDV44CXmpOhaTwGNoto/r0AfkJ+X0opLLeHUWtMhzBc29e8ltjkv
 AlCrCEs1QPhdxwnwf7x2V/U4rXORtJ7oEnqJ7+WC3cA5SPqd8BZC21u6FHcxFi+PqYz7lWv9qQ
 JUw=
X-IronPort-AV: E=Sophos;i="5.75,402,1589266800"; 
   d="scan'208";a="81386719"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jul 2020 05:33:57 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 27 Jul 2020 05:33:11 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 27 Jul 2020 05:33:09 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <linux-mtd@lists.infradead.org>,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        <linux-kernel@vger.kernel.org>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: Re: [PATCH v2 1/1] drivers: mtd: spi-nor: update read capabilities for w25q64 and s25fl064k
Date:   Mon, 27 Jul 2020 15:33:44 +0300
Message-ID: <159585278401.156466.6163208089372747874.b4-ty@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200529071655.739-1-rayagonda.kokatanur@broadcom.com>
References: <20200529071655.739-1-rayagonda.kokatanur@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 May 2020 12:46:55 +0530, Rayagonda Kokatanur wrote:
> Both w25q64 and s25fl064k nor flash support QUAD and DUAL read
> command, hence update the same in flash_info table.
> 
> This is tested on Broadcom Stingray SoC (bcm958742t).

Applied to spi-nor/next, thanks!

[1/1] mtd: spi-nor: update read capabilities for w25q64 and s25fl064k
      https://git.kernel.org/mtd/c/99eae48fd4c5

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@microchip.com>
