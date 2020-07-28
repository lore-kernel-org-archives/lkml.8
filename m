Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C8AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5B5B2074F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="QuyJxVG4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgG1J4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 05:56:04 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:65235 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbgG1J4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 05:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595930163; x=1627466163;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KhvNa8E40sXAjwFl0sqFki4lRCuz5/nv22mAe6ewzeA=;
  b=QuyJxVG4Q2htSdvspev4fqfUJu2O4pFXJ3ONIT//1ZWwStisLFzEk4EJ
   W01uHfSiQm+my9X/JELRZ1o9mynl1CoLRTTfVsyZENLCMx3GiapqUQG30
   Q6SgFciMopk6wG/Mri9k7iV93GZvjB7pRbnDQao0uR+WqdC5txNgtoobB
   ZMjknmVfpsd/i5Lr/0PJTUGr4jhD1WSpl/SvMJPYtHVNV2BLvZhwyoi4+
   QQBBVroQe+8fOLUVsbeUrnYkNaRLLSpkNMuhRmyR++OlxArD2ts5Srh5d
   Xy/rWkDD+kXy4n9tc4YzCUNXdRpF9O2unXoyZNM1A44dNWE/heyPcCOEY
   w==;
IronPort-SDR: 83JkuCKG7D1qAdNvrKfIem0ne4IQrJruMShDWB8fBEJvwBknXCGwROl1o4Azw/MHix89Y4dCKw
 xGo3R8g94fH8wga1HArMilEpSf0z8T/u8vvDkHd8yI44yPd//qad/Ku4pM1cCIkLZrCyqdl0cM
 3UNDmgFClj7G2oOJYhNjmYtiNDikdKC8j1nmvh6lE70bU9rIfZwb881leNZhWl2WAWM1mQKTi7
 AQfg/WNtbzcpgVnIOs2N3MJhT0V9FdIvKUInAlt9NGw9ojFu4tkPL8eRAroxs5O5YfM3zCdVbU
 3Nk=
X-IronPort-AV: E=Sophos;i="5.75,406,1589266800"; 
   d="scan'208";a="83495961"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2020 02:56:02 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 28 Jul 2020 02:55:15 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 28 Jul 2020 02:55:59 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     Luis Alberto Herrera <luisalberto@google.com>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>,
        "Miquel Raynal" <miquel.raynal@bootlin.com>,
        Jethro Beekman <jethro@fortanix.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] mtd: revert "spi-nor: intel: provide a range for poll_timout"
Date:   Tue, 28 Jul 2020 12:55:58 +0300
Message-ID: <159592990737.214287.1329265893720399161.b4-ty@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200610224652.64336-1-luisalberto@google.com>
References: <20200610224652.64336-1-luisalberto@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jun 2020 22:46:49 +0000, Luis Alberto Herrera wrote:
> This change reverts aba3a882a178: "mtd: spi-nor: intel: provide a range
> for poll_timout". That change introduces a performance regression when
> reading sequentially from flash. Logging calls to intel_spi_read without
> this change we get:
> 
> Start MTD read
> [   20.045527] intel_spi_read(from=1800000, len=400000)
> [   20.045527] intel_spi_read(from=1800000, len=400000)
> [  282.199274] intel_spi_read(from=1c00000, len=400000)
> [  282.199274] intel_spi_read(from=1c00000, len=400000)
> [  544.351528] intel_spi_read(from=2000000, len=400000)
> [  544.351528] intel_spi_read(from=2000000, len=400000)
> End MTD read
> 
> [...]

Applied to spi-nor/next, thanks!

[1/1] mtd: revert "spi-nor: intel: provide a range for poll_timout"
      https://git.kernel.org/mtd/c/e93a977367b2

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@microchip.com>
