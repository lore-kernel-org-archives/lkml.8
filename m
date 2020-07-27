Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A830C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D129E20663
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Eaug9JeO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbgG0Mdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 08:33:54 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:7868 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbgG0Mdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 08:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595853233; x=1627389233;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XtilPSvSam8OEHgIiWTJY2vcTm66N/Xl5vDBzDpMN6o=;
  b=Eaug9JeOVT6MVqxckY4Dfe62jQJvNSp1IgY8dCrHEE7xnee4k1y2TQdf
   swbTFTIDrJJ0S68ukrwoKJTG7iM2JbO8Z4pIqX9lNc4CnVhd9De1XVGqr
   B1id/iz88OlBRqP+zgd7SRAgmaTuRZc8RgN4dScN5kM6OJQLGq+SjyaCZ
   1q21tBVo+mZ6zMozaJI2YJExgFG3YxNJVotT82zdgWypEqYbmVHhOa8Pj
   coO0izG3blIv04hqurID81avWx0da7ci7dqHFHueMQwlfrOYfiEn6oIvU
   4G5ZGRSW/fM+IlsdxoNdtxlpF2Q7I4MZfsSRdxOOo8nYe3Vrx02Xa9X5W
   Q==;
IronPort-SDR: WzRxzmIqEwjn3JaGiYUZxaTqX8ngHZCOnPX4k+1ghOZUwwr/VCZ36GEziExP0+LsQPfwqfNm12
 XhlWqR3ULbPlkmXno13cfltJgFvs6k77jtjCcmcM6fCKwkB67mihfsKxOs9zPxI7bsLkD6ucqv
 Syluogt7sywKkofN9cwT9LiRjZjJ1OgMJXKTMvSvSeHZjHfgM80h2o43+WBPIaUkNaVmrXMhpH
 3ZwB/6imKuX5YouDwGSd2ksm0aiJc1BOt65jh4jTjdIM5B42CeaO0ndG9HAHdt/qDacktSH7r2
 qRM=
X-IronPort-AV: E=Sophos;i="5.75,402,1589266800"; 
   d="scan'208";a="89236541"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jul 2020 05:33:53 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 27 Jul 2020 05:33:10 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 27 Jul 2020 05:33:05 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        <linux-kernel@vger.kernel.org>, Baurzhan Ismagulov <ibr@ilbers.de>
Subject: Re: [PATCH] mtd: spi-nor: intel-spi: Simulate WRDI command
Date:   Mon, 27 Jul 2020 15:33:42 +0300
Message-ID: <159585278400.156466.5298743072819361191.b4-ty@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <282e1305-fd08-e446-1a22-eb4dff78cfb4@nokia.com>
References: <282e1305-fd08-e446-1a22-eb4dff78cfb4@nokia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jul 2020 16:01:36 +0200, Alexander Sverdlin wrote:
> After spi_nor_write_disable() return code checks were introduced in the
> spi-nor front end intel-spi backend stopped to work because WRDI was never
> supported and always failed.
> 
> Just pretend it was sucessful and ignore the command itself. HW sequencer
> shall do the right thing automatically, while with SW sequencer we cannot
> do it anyway, because the only tool we had was preopcode and it makes no
> sense for WRDI.

Applied to spi-nor/next, thanks!

[1/1] mtd: spi-nor: intel-spi: Simulate WRDI command
      https://git.kernel.org/mtd/c/44a80df4bfce

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@microchip.com>
