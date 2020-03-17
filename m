Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2E6C0044D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 01:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1865E2051A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 01:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387396AbgCQBAd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 21:00:33 -0400
Received: from mail-oln040092254011.outbound.protection.outlook.com ([40.92.254.11]:14151
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733182AbgCQBAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 21:00:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDxCkPxXkwD95SQM/CD0Hh34zoFNElKSFG+fO1XHNCCxFdV6YxIg/fGzFYbIGymKwBWpiRXCyEvfb8etptJZ5Stxn30R2iSEstPshY0j74gLqrGEnHfZe8g5fmmNK8dE5LWltJ4JjPaArrzpixz0mdJfZw7nHBGf+A1vGXPymNswSaORdLdLbV/LOJPJIGQ1zOKBW0ivAbeUpiNe64dJo5ho8g6og+BNIjgNfyv46lJge/h/n6NGFIBC4mq4t0QrrqVQcGmnL9gt9O7q8F7fd31NMzG1/RFjG/2MAMCI4PAg8S+7buO6/1wRq6m5Aj7+43np1irSFeEUplrrrA7Dmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sb5AQ09JIqc9zjHIPQxR1tU8nPFrsTNOoQEqXv56ir4=;
 b=UqLc3tK9zazXZMQmDV7Qm8Kn7J+j8QqyLyxuaDWu6nLdLz8Osk4+1QBFHHQiLxgIIez94et3QRMcCBIo9YcQBrIcWQZuOq7TelKqieViHdoWZcGkATUaFzj1Tx0/2rPHPAF+4OBzAhjM4k5txVlV8bzVgVUAN6w2L8Wj0elLwXXPYVCDpIOjtDcBvofK1gBtmTbc7lkESpulsfRl55pDrifckP3KFx3Us5xNCmwlE1Tohjvly5a+hSPfC+4lz9o2pIcXnTFeXAjw6Y6JN9/Ovmex+VpcmqHH0N3XbJO62KRRCtx36iYMhni/LxCw0HMSEbL7jY9ojx6OLfw10TetTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT007.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebe::3a) by
 PU1APC01HT098.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebe::327)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.13; Tue, 17 Mar
 2020 01:00:27 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.252.51) by
 PU1APC01FT007.mail.protection.outlook.com (10.152.252.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.13 via Frontend Transport; Tue, 17 Mar 2020 01:00:27 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2%7]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 01:00:27 +0000
Received: from nicholas-dell-linux (49.196.2.18) by ME2PR01CA0175.ausprd01.prod.outlook.com (2603:10c6:220:20::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14 via Frontend Transport; Tue, 17 Mar 2020 01:00:23 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v4 0/1] nvmem: Add support for write-only instances, and
 clean-up
Thread-Topic: [PATCH v4 0/1] nvmem: Add support for write-only instances, and
 clean-up
Thread-Index: AQHV+/dyMcnDNDQH0E+w4sM+rU8vug==
Date:   Tue, 17 Mar 2020 01:00:26 +0000
Message-ID: <PSXP216MB0438DB7146E07670FCDC1A7280F60@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME2PR01CA0175.ausprd01.prod.outlook.com
 (2603:10c6:220:20::19) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:457FDB5F0EBDAF0E42AAA9112117CB9F0F06A3E8BE67C8EB8D2EF9ABADD78849;UpperCasedChecksum:C1989CBD9715B5118852ABC0B0C872E259514A5CBD7BF6E27F201F6A5BA3665E;SizeAsReceived:7638;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [suqRVjdBTQ6O5CVDT0Jv4XNctelbau3J]
x-microsoft-original-message-id: <20200317010016.GA3654@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: a8827cdf-0207-46a6-e66d-08d7ca0e9412
x-ms-exchange-slblob-mailprops: wjVjg9/kRd1Ha0jL5FI4BHrnrG0JXql/75j9lvbCnKncbVUFH2NnJNvyprtmH5heKhZ0MmXkOvog1cE3WfSczPPrnqDBtr105GTab6CDCa0l8Sr4jidS89AhMpRpYMwHMGpLQpAs1ExVA92Kb7SZCfbPj86EkDtkwp3TfjRfuotlbA520nQYWLk1JF5grj8132v3VnxUFELaHGn76k5C/JJ0wIvVhGqLlMAZTvvRh4jVqCQ/ouVP60IE4ydLZxiCLX5yHbaWbs8GIWnXDO+K5vMjVeKtMEEM501ZQQxhzn80XyK22SgslW/2XGXc7ZraZ2dnm1QlLXmUziEkLPxCHExAfFVYK42QkKj136olBf1+z0vsWIbuHQI7H2Q/eTWE58JGIozDl9xZAvY2e5XZlB+WBs+PbQJXbLuW2/ESjRoB3P3ZlV+M/RpRvBKOUzQBU8sjmlvLbGW50GjySvKUXJ492nZn0D5gVudGKeEtkgL2HtpY0HKYvR67GO5gfWpyYbM83yeQGqxwdfsS/a57as122d2OknsQv33mElEqv4apu71omhT5xu+YopLzxBNWk00mOC620JGavnQUNQDVD5dYeNFyK1+qcOPeyYsfwHKn1RH69fZUibIcAi8HsB1BdVx7WUQ6f4bKZxIJrtUiMU2JZVZEd7D7cmhfZzgOk+8foy90WXjxfjahmzdbkf5ov5m4U42UMoFgKWjsHtkqX+HT3WmRkfzaV9WSIWmiMXPqL+qr4nWaLMSTQtIhYpxrKSYrP/ZV37muoVc4cCOQ5djO3yqpp2j8MmXSxLazMp6i/6cEONXKzsjDR/Ddv93oZXF6MG2RxwzNxXiou0vj6ySEn9t3gHvCKja05/ZtmUblQCaATD6XZzbLEYcPn5DOo5dyOV0+OzP6LIY2JV17hkgpgibz1l+d3w5//7+uvhwvZBS6+SEuaw==
x-ms-traffictypediagnostic: PU1APC01HT098:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M3nsthaExFD9K675IV5i5Ebhvekp/NBRMTglhGsWyvCZmJ4AP0SFR+tTgFSvsypLjeH9zvK1kl10G2SeWCDD4txjcabUjoM2y/LFFA5CozqoNl18nmyCHX3mdYswIbr8hEc3t4AZMQlD7+3PQuIpI51Ph6rfYvtRNi1pDDC4wEtlbMcZxTgAEckoruioswWgBJkX3zGJE/6zHP7hfxVqBCkUqQI3I5M3MKD77wzLL68=
x-ms-exchange-antispam-messagedata: GdyPjITtWi8tKOTwTHkxiF+IKf4QQ76IslGZVVLojpjjakPidf3xI7MCCyjhXlf3UNo5SNb3Dd6bfD75cQxMT90fq10JNqdEoEW4Ed5fKaDZWQMbLcC2eR5fuoEG7WGFs5wbUQ037i9K5TPHrYyxZQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F7884A49FB05C14081783B07BE821BD6@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: a8827cdf-0207-46a6-e66d-08d7ca0e9412
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2020 01:00:27.1108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Previous version: https://lkml.org/lkml/2020/3/9/731

Changed since previous version:

- Hopefully fixed memory leak fully. I set CONFIG_DEBUG_KMEMLEAK and
  according to the leak detector, it is no longer leaking. I believe the
  leak was when setting the device name. I could not find out how to
  free that in the required context. But I avoided it by moving the
  groups above setting the name.

  If you believe there is still a leak, please be specific about what
  you think it is. I have been reading up this week about the driver
  interfaces and trying to figure it out, but I have had trouble finding
  good reading material.

- I squashed the two patches together as advised by Srinivas.

- Changed from -EPERM to -EINVAL for invalid configuration.

Nicholas Johnson (1):
  nvmem: Add support for write-only instances

 drivers/nvmem/core.c        |  9 ++++--
 drivers/nvmem/nvmem-sysfs.c | 56 +++++++++++++++++++++++++++++++------
 2 files changed, 54 insertions(+), 11 deletions(-)

-- 
2.25.1

