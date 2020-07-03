Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C847C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 10:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7B8F20737
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 10:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Plr1MP36"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgGCKxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 06:53:20 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:56839 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgGCKxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 06:53:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1593773597; x=1625309597;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W1fkCAJHahqWde9HjKMvjQEIsPzCIxPwk7BE7fAwW9w=;
  b=Plr1MP36esP3/at0rCMRtb++hJD7Z8LU367Ub0Tr/wMXieNObV4AEpAl
   aXr+dnEXNMtsCX0EvKjKve/ffihHjS7hJeQAffgsJnjxKOFFTouwi6mRU
   0LbWqZlLoE8t4UObILAIyhDvv3C9A8VcB3yTc9xp/q3OBRx57+rQjo+Ee
   DXKqhCN9rqi24Q6eYjp1t3kqGxNXhuuNP/1sV/vA2HhDZYJ7itQKAGzy8
   kK4uZHv7RIsFjk0IG6u/5lPPP/GLsnA/XmRLaVHyYeQIZ3+qb0UnmRKrY
   q22y7AieFU2MM3Ts0bhx6A7HsUuGj8l5lD8604mWKapXdlISCKSJdetFr
   A==;
IronPort-SDR: S9K8W58IuUR00ZYHbtq8tBOxScvw+HVqKFbmensstoW5mI9sU/nwLfXtXmqFrAnh046mIpN7rr
 SngmwHNwua7i922785Jeh8jEGv901z/Byqc0ocPeU1MvZrnbYnq1NpASvM+BvsPrNSyV2cB6bi
 nsZYSy7G/XzdJ5KHiwQeLH2GRH9e1rJd9vjg6kiMGNn1M6S/xXVZcd7gu8z57K3HyxxeeMX16Q
 1ARMhE74yartfwNRJzoLD/KolH2GZcFdyE3jdXdOpGxTVDxS6gfvGRR4pkPO4MUtfsuJrQEPuc
 PVE=
X-IronPort-AV: E=Sophos;i="5.75,308,1589266800"; 
   d="scan'208";a="78683795"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Jul 2020 03:53:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 3 Jul 2020 03:53:17 -0700
Received: from atudor-ThinkPad-T470p.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 3 Jul 2020 03:52:55 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: Add support for Macronix MX25R1635F
Date:   Fri, 3 Jul 2020 13:53:07 +0300
Message-ID: <159377160989.144291.3836509687644676512.b4-ty@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702140523.6811-1-frieder.schrempf@kontron.de>
References: <20200702140523.6811-1-frieder.schrempf@kontron.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jul 2020 14:05:50 +0000, Schrempf Frieder wrote:
> The MX25R1635F is the smaller sibling of the MX25R3235F that is
> already supported. It's only half the size (16Mb).
> 
> It was tested on the Kontron Electronics i.MX8MM SoM (N8010)
> using raw read and write from and to the mtd device and
> the 'flash_erase' command.

Applied to spi-nor/next, thanks!

[1/1] mtd: spi-nor: macronix: Add support for MX25R1635F
      https://git.kernel.org/mtd/c/482dcb2a04

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@microchip.com>
