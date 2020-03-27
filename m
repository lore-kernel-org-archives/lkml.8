Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF55C2D0ED
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF92206E6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="VuEVVEz/";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="VuEVVEz/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbgC0RCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 13:02:02 -0400
Received: from mail-eopbgr130050.outbound.protection.outlook.com ([40.107.13.50]:60171
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726515AbgC0RCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 13:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfT+kca4GLNNh9u4rlHJEk+/N0PILO4/pBqrj87G/18=;
 b=VuEVVEz/9yoK4xYIoGRqYTN5C8cwkVbeYmVDLOfK2LGa7zH7RRww35whweT+tGbhBNIt3N6/m73mbwvUYQu48t6wd3ZeSJBT8lae+2YC6YSQ2TWVfYjYU6WBhp8XpRAOJYBsGEduxgd1WqsAQYynUkq6JsBF+m23kBhkTjIYYpM=
Received: from VI1PR0701CA0041.eurprd07.prod.outlook.com
 (2603:10a6:800:90::27) by HE1PR08MB2873.eurprd08.prod.outlook.com
 (2603:10a6:7:30::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Fri, 27 Mar
 2020 17:01:55 +0000
Received: from VE1EUR03FT036.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:800:90:cafe::3b) by VI1PR0701CA0041.outlook.office365.com
 (2603:10a6:800:90::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.9 via Frontend
 Transport; Fri, 27 Mar 2020 17:01:54 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT036.mail.protection.outlook.com (10.152.19.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.17 via Frontend Transport; Fri, 27 Mar 2020 17:01:54 +0000
Received: ("Tessian outbound 19f8d550f75c:v48"); Fri, 27 Mar 2020 17:01:54 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f4805d5f11123ead
X-CR-MTA-TID: 64aa7808
Received: from b8e79db3fe2a.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A4944EE2-CB12-420A-B914-C2162DFA389E.1;
        Fri, 27 Mar 2020 17:01:48 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b8e79db3fe2a.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 27 Mar 2020 17:01:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xhz5fWzcgDZqbWdBeR3xTI1eq+b9MEZPClfzFEnqSxSZtockjAA1IH+s3tUALXWWbDLA0mrgcHSvGg+jE3HowXISBzlf2E+07QlrKLS5WQAgqChHsTawFvfGMfhq18+4wWyx3yHXof2dMG5wp2EWHBrg1l+uB+G/ruyd4mbtCj1II34eov9FbImJwuIMQWI/CVuLO2qliq2zHRdFNhzfjaKrr89XQ20OiXJg4hZy+xSQg3+CzeliOQ6te+ragXPG8PkRklsxBz3g0Y/qZLaYNG1WsJyliHGItPIDFyX+wkvlsHsGsB/f0As0OL4R1+rBLkKZXkVHBxtQ6ZIAzg6Spg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfT+kca4GLNNh9u4rlHJEk+/N0PILO4/pBqrj87G/18=;
 b=WvdCEV+D5UxlO8Sl1rHg6HMfzubLaZDiNlgMTOfrHpgWgnwaOIyv6Habn8qtLChfSABWb+Np9d2x037xxDd8GNI0H9OlB4WAkmK/dVZBlpR+ecxSmvKY242OUVlox8Cv8+coTzCrfVqvDhM83zfWrATP6oJyqMeD0g4eHCc828YrVXz5h1v3a2kmJoJnPj8j32b80w3E/qd63B/8IDeOAxrhsw9DZkP5WmZxGRCsw2+9UJLnGwgZREadXoOd9ymbAMzj14O2NcrXksuRzdiBSIVOW2Jz4k3pDPiIquZ3knJdsDOhPLksoGsTjc17h+cWAwjdr8qFPlPXLtWHG/Y9Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfT+kca4GLNNh9u4rlHJEk+/N0PILO4/pBqrj87G/18=;
 b=VuEVVEz/9yoK4xYIoGRqYTN5C8cwkVbeYmVDLOfK2LGa7zH7RRww35whweT+tGbhBNIt3N6/m73mbwvUYQu48t6wd3ZeSJBT8lae+2YC6YSQ2TWVfYjYU6WBhp8XpRAOJYBsGEduxgd1WqsAQYynUkq6JsBF+m23kBhkTjIYYpM=
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Grant.Likely@arm.com; 
Received: from DB8PR08MB4010.eurprd08.prod.outlook.com (20.179.10.207) by
 DB8SPR01MB0016.eurprd08.prod.outlook.com (20.179.251.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.18; Fri, 27 Mar 2020 17:01:46 +0000
Received: from DB8PR08MB4010.eurprd08.prod.outlook.com
 ([fe80::4521:d746:9e7:4ae3]) by DB8PR08MB4010.eurprd08.prod.outlook.com
 ([fe80::4521:d746:9e7:4ae3%5]) with mapi id 15.20.2835.023; Fri, 27 Mar 2020
 17:01:46 +0000
From:   Grant Likely <grant.likely@arm.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     nd@arm.com, Grant Likely <grant.likely@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] Add documentation on meaning of -EPROBE_DEFER
Date:   Fri, 27 Mar 2020 17:01:32 +0000
Message-Id: <20200327170132.17275-1-grant.likely@arm.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0047.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::35)
 To DB8PR08MB4010.eurprd08.prod.outlook.com (2603:10a6:10:ab::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from moist.secretlab.ca (92.40.174.1) by LO2P123CA0047.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend Transport; Fri, 27 Mar 2020 17:01:45 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [92.40.174.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b9a9b07f-eea9-48e2-2e07-08d7d2708d61
X-MS-TrafficTypeDiagnostic: DB8SPR01MB0016:|DB8SPR01MB0016:|HE1PR08MB2873:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR08MB2873F217EB9B54B4D404788195CC0@HE1PR08MB2873.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;OLM:9508;
X-Forefront-PRVS: 0355F3A3AE
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB4010.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(4326008)(2906002)(8676002)(26005)(66556008)(66476007)(6506007)(66946007)(55236004)(1076003)(36756003)(6512007)(86362001)(5660300002)(8936002)(81156014)(81166006)(6666004)(186003)(478600001)(956004)(316002)(44832011)(2616005)(6486002)(52116002)(54906003)(16526019);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Qc3Q8VuOPWX90wCYXk/Mq2C2yNhaty3Gll0Q518+cpEuixPMUkELB0vrBLf0p4vn8Sec03B81Bb2nRANZW5A14bpuY3hzFMViVcyNp1Z/oCd4oSnAzLUTJXW7Ty0LvT8iG9RHn0FL0vUUdKIhnDPY/JsOIaLvyx0IbKxhbvKfnaQ5R07icZvS/IlbiCfX+jJuSX0uSlurywJtV6A+jG6+RlLae2/k2C/n479Ll8d/2HEk8kG8DSOUt+cbjBS8oB59r7x3+apfRm4eqJU3NsHw7MSQcgxDI6TwT/KRCiIzBjUgY5jwmlZnwT64KADpquSZ2hWKMRZn8kje1XLVVGbCBrD+Q1EgrvBHNkDBW+c2uoAz+UVOHVQq8VPxNDLhi+cLex4pV0bC1RjSZyCnLgPMicVHd1MUaL+QO2BHjvO0/Rraehich5Tq6EXnH+sCCet
X-MS-Exchange-AntiSpam-MessageData: lRcCVs+Pavytr2M6cpOsb7GrUWzir73ynlFhCABkrgJMzxE0xpJ5cmYiK1UFC9nuj38Y6bzniHFbaEci3DFBCd66vwg3w8HMXQsi6UlqZ1IyoBv0HlGhGGtWgK8QEeM+6QxUYyT3nZcwPHYEJ5nPpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8SPR01MB0016
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Grant.Likely@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT036.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(136003)(396003)(376002)(39860400002)(46966005)(6506007)(336012)(81156014)(6666004)(82740400003)(2906002)(5660300002)(8676002)(70586007)(16526019)(26005)(356004)(1076003)(44832011)(81166006)(186003)(47076004)(8936002)(4326008)(70206006)(316002)(86362001)(36756003)(36906005)(26826003)(450100002)(956004)(478600001)(54906003)(2616005)(6486002)(107886003)(6512007);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: f88f4bdf-2851-4d5c-9af4-08d7d2708828
X-Forefront-PRVS: 0355F3A3AE
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 13YW+75haqasC2wSI+2qE8LUI7JU8/Y0imdRGzsSP1fWo008pM8BtQXZDHWn587CtilzI+87z4VRyP8SXkO0fJYu0hMe73BwDiaAydbxmi7/Yex+L2OgTgywTUyekEe5Pci/saq36x07K680hBbIhJu0vXss1WYwCvuVtISdoxVVT1bURVtJohp+nxBvOAJvH4gUun0I5ytp4L74rCEmHbMbThHByk+L70m8j0xd8fIkljWPlFmMUeeZVLOUfucCRlkVqz4EBVm87RdyI+WG7YDaqhO1dh+S3p+xLuZGvv4zcswXmHTBB/cN3QDo/i/r0U8ACsXQAxMYymrK31cfKtWHZcsgWj8zwir2PQi2hwQMVcbD1dEyhOaWdvofZHYi+mPCwoDyUdIrrv+cYuTYgkDTbaxjDqOrmvwWkoNOg45Xmps932rtkbYN0kzWZCAjTOmOmNgl/AaN3IrpGpYF23QmSCareki2KdfcRVPoNuSz/vR7uSCpiysTyQ5RT4g/5aDdKGquozHXWW5w0jXN1A==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2020 17:01:54.4959
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9a9b07f-eea9-48e2-2e07-08d7d2708d61
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2873
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a bit of documentation on what it means when a driver .probe() hook
returns the -EPROBE_DEFER error code, including the limitation that
-EPROBE_DEFER should be returned as early as possible, before the driver
starts to register child devices.

Also: minor markup fixes in the same file

Signed-off-by: Grant Likely <grant.likely@arm.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../driver-api/driver-model/driver.rst        | 32 ++++++++++++++++---
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/Documentation/driver-api/driver-model/driver.rst b/Documentation/driver-api/driver-model/driver.rst
index baa6a85c8287..63057d9bc8a6 100644
--- a/Documentation/driver-api/driver-model/driver.rst
+++ b/Documentation/driver-api/driver-model/driver.rst
@@ -4,7 +4,6 @@ Device Drivers
 
 See the kerneldoc for the struct device_driver.
 
-
 Allocation
 ~~~~~~~~~~
 
@@ -167,9 +166,26 @@ the driver to that device.
 
 A driver's probe() may return a negative errno value to indicate that
 the driver did not bind to this device, in which case it should have
-released all resources it allocated::
+released all resources it allocated.
+
+Optionally, probe() may return -EPROBE_DEFER if the driver depends on
+resources that are not yet available (e.g., supplied by a driver that
+hasn't initialized yet).  The driver core will put the device onto the
+deferred probe list and will try to call it again later. If a driver
+must defer, it should return -EPROBE_DEFER as early as possible to
+reduce the amount of time spent on setup work that will need to be
+unwound and reexecuted at a later time.
+
+.. warning::
+      -EPROBE_DEFER must not be returned if probe() has already created
+      child devices, even if those child devices are removed again
+      in a cleanup path. If -EPROBE_DEFER is returned after a child
+      device has been registered, it may result in an infinite loop of
+      .probe() calls to the same driver.
+
+::
 
-	void (*sync_state)(struct device *dev);
+	void	(*sync_state)	(struct device *dev);
 
 sync_state is called only once for a device. It's called when all the consumer
 devices of the device have successfully probed. The list of consumers of the
@@ -212,6 +228,8 @@ over management of devices from the bootloader, the usage of sync_state() is
 not restricted to that. Use it whenever it makes sense to take an action after
 all the consumers of a device have probed.
 
+::
+
 	int 	(*remove)	(struct device *dev);
 
 remove is called to unbind a driver from a device. This may be
@@ -224,11 +242,15 @@ not. It should free any resources allocated specifically for the
 device; i.e. anything in the device's driver_data field.
 
 If the device is still present, it should quiesce the device and place
-it into a supported low-power state::
+it into a supported low-power state.
+
+::
 
 	int	(*suspend)	(struct device *dev, pm_message_t state);
 
-suspend is called to put the device in a low power state::
+suspend is called to put the device in a low power state.
+
+::
 
 	int	(*resume)	(struct device *dev);
 
-- 
2.20.1

