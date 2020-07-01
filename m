Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A364C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 328D220772
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="VdneFFkO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730653AbgGANI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:08:59 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:38335 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbgGANI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 09:08:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1593608938; x=1625144938;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=VKwS50NdRwYJmqPFLGH1texrN5hjEA5vBdcV/V+qfZQ=;
  b=VdneFFkOxpaeAHe4jrTnn7dPT9wq8n8bCHauYvzTZ3p2EF343xyaQldL
   pmDWg+dlH8wzW2oQDXhP1Fzohl6yvSNpoiCXkW5qExilB3+FOWODN9Nhu
   6PGDJlacGEhmjTjD/d4bUvm8hKlWZmtKJeVkR1fE4m+JXtzxRClIXaVql
   8oxKNyfkgFwrk5uMv317LoqUQcB3SQY70X1ebXC5jY9KSvls7chG1/DlT
   L0ZcLOtxUm50g/Zr7DBgzwQSy6EB4Thd8nbhS+7l6+jBCGzF8CyCWHQlr
   kxZrCjcHqsiVhmltLcEHv+1xVadL6HurZNNFkbcqxc97hldEG5CRbJHU0
   g==;
IronPort-SDR: WIruR+F/LtPVKqBonGYqY/+WM9ERNj9FeZfa02nXcDVSen/vcsTFu+Y0vebqkTVGGflWXn4893
 RsHQC5Lk2fy3ngTRYr/IjDWNMyYgE9WVKxLfcUO1r8KTsGOBDNFYpv1uat/vDhLrhh5sPdU4/c
 M2TCgiNOQeXtuXWg+w11w9wdZSgPdGRIk9iFsGHMJQY7vMFCDDYeh4weMsKCsxHQlD25gMv2iN
 s1yCgdGwX+3BlrFgwg1aVHdKAQVXKK7MjD1Ufz2qq6LFvHNNJK8csKlXXr9qp0Nnerykj1qu62
 n7M=
X-IronPort-AV: E=Sophos;i="5.75,300,1589266800"; 
   d="scan'208";a="82222619"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Jul 2020 06:08:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 1 Jul 2020 06:08:57 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 1 Jul 2020 06:08:54 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <davem@davemloft.net>,
        <kuba@kernel.org>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH net-next 0/4] net: macb: few code cleanups
Date:   Wed, 1 Jul 2020 16:08:47 +0300
Message-ID: <1593608931-3718-1-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Patches in this series cleanup a bit macb code.

Thank you,
Claudiu Beznea

Claudiu Beznea (4):
  net: macb: do not set again bit 0 of queue_mask
  net: macb: use hweight_long() to count set bits in queue_mask
  net: macb: do not initialize queue variable
  net: macb: remove is_udp variable

 drivers/net/ethernet/cadence/macb_main.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

-- 
2.7.4

