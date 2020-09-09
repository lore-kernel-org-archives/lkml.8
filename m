Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37734C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C48C9215A4
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=micron.com header.i=@micron.com header.b="jsuU9I4S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730727AbgIIQQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:16:30 -0400
Received: from mail-mw2nam10on2059.outbound.protection.outlook.com ([40.107.94.59]:5025
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730980AbgIIQMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:12:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRFmgqL1RlHhqZm6ZyQxj2mXTQ4pLXolCB00dcYTVMTBNIo9Qoq+/zZC1ziPtfk2MEdxn7fNN1Jej8Z11o6GsigRS6qZ/t7G/JTwpcObwVmOGp1KOEocJcm1guiEKh/0IxB84KZmcnpIp51E2TiLuS6VGjyIGKuDoqeERMLudOv0/WgURbZ9AXPxEicaNnTiv1nIIg/p9YBtuPxTqIiBY4Q8qkkFj63LNcuh+pqBbC+xbxGTVhZc1tqKGX3OUYbZh3Ygdw1GcMh2drWmOC8HWDPy51A0UtgDfH5XsYVpzU564duY2GAARP7wUlXpJbmHuBjL9Q4rgPZPhxOEo5dUvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJuVv5zkVb526PZF/d3E2BRZRfsHyUd4/QkageKHiWM=;
 b=f5PkLRL4oKpTDApMo2lMdoVK432bN/KQtu4Hh4rkSgoKgeBEt24ENst3cazE6eYZy2cWTTc0rGjVVcjULsDj1KxzDEWYgkO1NVJMFwYCS/cpldt7+HT4rxWJeyUxrpp046lxQPtWbVFnc0QbO0VZU5DxI2eYvYMX2ypM2GsRqi6tEXZTvc6pz3L/biheQiruMLTiGQyaotkFOFQN+liukY+VAc3c5+DVmtWyQgWwupMnllaArFl+SFBLUuvwoejiP2qUF8t2CVLjZyyjEJFp3IqLJy3pou/fLC3wFh8ul6hgLoO9iJia54OcL6ihbMlOapTrnqE3n4QN/vFyjzA/jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJuVv5zkVb526PZF/d3E2BRZRfsHyUd4/QkageKHiWM=;
 b=jsuU9I4SL87mzKgHcHNqCVsCttkbkFfRSWtiL0CzWtfPkV5uOx0cRF/B1erBgCtlsXd9SWlIDzypQciO0uzJrj7JML1JXHsxs1HoMqLXEUOMzMVORNNZ8QO7QLrW+TcVNyYch0+I1ReZuN36ZUXTCe4GW07VU6UHMPArz8PNDcY=
Received: from MN2PR08MB6397.namprd08.prod.outlook.com (2603:10b6:208:1aa::10)
 by MN2PR08MB6400.namprd08.prod.outlook.com (2603:10b6:208:1b0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.17; Wed, 9 Sep
 2020 14:11:08 +0000
Received: from MN2PR08MB6397.namprd08.prod.outlook.com
 ([fe80::e519:cf8c:ff65:46b8]) by MN2PR08MB6397.namprd08.prod.outlook.com
 ([fe80::e519:cf8c:ff65:46b8%8]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 14:11:08 +0000
From:   "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
To:     Thirumalesha Narasimhappa <nthirumalesha7@gmail.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] [RESEND PATCH v3] mtd: spinand: micron: add support for
 MT29F2G01AAAED
Thread-Topic: [EXT] [RESEND PATCH v3] mtd: spinand: micron: add support for
 MT29F2G01AAAED
Thread-Index: AQHWhpnqi22BOgrP8UCIMQh4ntSW+algSK/A
Date:   Wed, 9 Sep 2020 14:11:07 +0000
Message-ID: <MN2PR08MB6397100B7E24ED8FDA7830E2B8260@MN2PR08MB6397.namprd08.prod.outlook.com>
References: <20200909111418.22549-1-nthirumalesha7@gmail.com>
In-Reply-To: <20200909111418.22549-1-nthirumalesha7@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc3NoaXZhbXVy?=
 =?us-ascii?Q?dGh5XGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02?=
 =?us-ascii?Q?Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNGJiY2VhMTUtZjJhNi0xMWVhLWIyMDMt?=
 =?us-ascii?Q?OTgzYjhmNzQ1MjUxXGFtZS10ZXN0XDRiYmNlYTE3LWYyYTYtMTFlYS1iMjAz?=
 =?us-ascii?Q?LTk4M2I4Zjc0NTI1MWJvZHkudHh0IiBzej0iMTE2NzciIHQ9IjEzMjQ0MTM0?=
 =?us-ascii?Q?MjY0NzU3NTgyMCIgaD0iMHNab2kzSmFZNE9scHUyTHZFMytaOU9LaDVVPSIg?=
 =?us-ascii?Q?aWQ9IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFB?=
 =?us-ascii?Q?RkFLQUFBTXBSVU9zNGJXQWNkVjluMFJJNUVneDFYMmZSRWprU0FRQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUhBQUFBRGdDUUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUVCQVFBQkFBQUFCZzR6NFFBQUFBQUFBQUFBQUFBQUFKNEFBQUJ0?=
 =?us-ascii?Q?QUdrQVl3QnlBRzhBYmdCZkFHNEFZUUJ1QUdRQVh3QndBSElBYVFCdEFHRUFj?=
 =?us-ascii?Q?Z0I1QUY4QWF3QmxBSGtBZHdCdkFISUFaQUJ6QUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHMEFhUUJqQUhJQWJ3QnVB?=
 =?us-ascii?Q?RjhBYmdCaEFHNEFaQUJmQUhNQVpRQmpBRzhBYmdCa0FHRUFjZ0I1QUY4QWF3?=
 =?us-ascii?Q?QmxBSGtBZHdCdkFISUFaQUJ6QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFB?=
 =?us-ascii?Q?QUFDQUFBQUFBQ2VBQUFBYmdCaEFHNEFaQUJmQUdjQWJBQnZBR0lBWVFCc0FB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFB?=
 =?us-ascii?Q?QnVBR0VBYmdCa0FGOEFhQUJwQUdjQWFBQmZBR01BYndCdUFHWUFhUUJrQUdV?=
 =?us-ascii?Q?QWJnQmpBR1VBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUc0QVlRQnVBR1FBWHdC?=
 =?us-ascii?Q?dEFHRUFjd0JyQUdrQWJnQm5BRjhBYkFCaEFIa0FaUUJ5QUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFB?=
 =?us-ascii?Q?QUFBQUNBQUFBQUFDZUFBQUFiZ0JoQUc0QVpBQmZBRzBBWVFCMEFHVUFjZ0Jw?=
 =?us-ascii?Q?QUdFQWJBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRB?=
 =?us-ascii?Q?QUFCdUFHRUFiZ0JrQUY4QWJRQnZBR1FBZFFCc0FHVUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBRzRBWVFCdUFHUUFY?=
 =?us-ascii?Q?d0J3QUhJQWJ3QmpBR1VBY3dCekFGOEFaUUJ4QUhVQWFRQndBRzBBWlFCdUFI?=
 =?us-ascii?Q?UUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFB?=
 =?us-ascii?Q?QUFBQUFBQ0FBQUFBQUNlQUFBQWJnQmhBRzRBWkFCZkFITUFNUUF6QURBQVh3?=
 =?us-ascii?Q?QmtBR1VBY3dCcEFHY0FiZ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFK?=
 =?us-ascii?Q?NEFBQUJ1QUdFQWJnQmtBRjhBY3dBeEFETUFNQUJmQUhBQVlRQnlBSFFBWXdC?=
 =?us-ascii?Q?dkFHUUFaUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHNEFZUUJ1QUdR?=
 =?us-ascii?Q?QVh3QnpBREVBTkFBd0FGOEFaQUJsQUhNQWFRQm5BRzRBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFB?=
 =?us-ascii?Q?QUFBQUFBQUFDQUFBQUFBQ2VBQUFBYmdCaEFHNEFaQUJmQUhNQU1RQTBBREFB?=
 =?us-ascii?Q?WHdCd0FHRUFjZ0IwQUdNQWJ3QmtBR1VBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFB?=
 =?us-ascii?Q?QUo0QUFBQnVBR0VBYmdCa0FGOEFjd0F4QURVQU1BQmZBR1FBWlFCekFHa0Fa?=
 =?us-ascii?Q?d0J1QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUc0QVlRQnVB?=
 =?us-ascii?Q?R1FBWHdCekFERUFOUUF3QUY4QWNBQmhBSElBZEFCakFHOEFaQUJsQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?UUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFiZ0JoQUc0QVpBQmZBSE1BTVFBMkFE?=
 =?us-ascii?Q?QUFYd0JrQUdVQWN3QnBBR2NBYmdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFB?=
 =?us-ascii?Q?QUFBSjRBQUFCdUFHRUFiZ0JrQUY4QWN3QXhBRFlBTUFCZkFIQUFZUUJ5QUhR?=
 =?us-ascii?Q?QVl3QnZBR1FBWlFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQSIvPjwvbWV0YT4?=
 =?us-ascii?Q?=3D?=
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=micron.com;
x-originating-ip: [165.225.203.35]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12b66136-76dc-4232-f703-08d854ca329a
x-ms-traffictypediagnostic: MN2PR08MB6400:
x-microsoft-antispam-prvs: <MN2PR08MB64002E113807D12A71CD0E74B8260@MN2PR08MB6400.namprd08.prod.outlook.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6ow98UZ/IwaYsFQTc1L5SU3dTTdYusX4PVqinYXS+t4le8mbuxePCI2YbHOmHY7RxTMVKVVK3NqCjzfhslwhZFvE/40Fy59ddqofwc4oOv/uMByqacmMk0NgvU1KkndUKRroUFHnFGORpEEb70WgpkwsJ3UrjiMImJisB0FQFsrGSnMDvCdAjlJ6C6D4KtZGF0owTLlk80Ua0w4AaxvuwmKKCyU9AD8fpEwFiH0kOXrWpkT8F1SXTpnSKPbgU8S1MNSocW5poLPHa0wSlFayHy9SFbt1GOA7jEdY7fwpw65/JBG5TutulObjJxRj3M8osfBSnnWmRojUFb4pKGfAXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR08MB6397.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(26005)(64756008)(66476007)(83380400001)(66446008)(66556008)(76116006)(8676002)(55236004)(33656002)(186003)(86362001)(66946007)(54906003)(30864003)(55016002)(316002)(9686003)(52536014)(5660300002)(4326008)(478600001)(6916009)(6506007)(7696005)(2906002)(8936002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: rWJ27efhweDMNwjaAydKU9YsyB2PlyQgQqSJmWBCn8tBoIl+XE5JhjUrOGPOD93pL+3Y0jGtL5xivTYJ2M3YlSIArqmgbouZH1Zkm8H97JT1Bh5Musr+gb5yTpqwTjXvr29I5F5hrJDIedlOYpsJFn38khMF6y8KomcyO8vxXB9oExn3QL1N+cI/P6+t3k3c2y94j4IBWatUjCLCX26OiMmrbG8KuxSuEHdm5zKiIHN2gZrvxQWjOn4PQYBuaqNQ2cbPEYU6us0eX48Zkpxx0eiZnLwoLA9wVyeN1cuG4aU+ZYw6ldEtkUFfJ6Vuwky5oedG4IMMqhC36Dxiz/UW3vpSpFfWDvWYHMLqpOFcJZmi316GOyViOKe/7Gmjn1/ElJu2mUdzzazGVxIyyNW4oo3KFvKv9yShhExqa8pZmyyXGve0FUsPbvCdtYi7aFLEqCbLTUeq8MSVAnc0R/c+1wjoz1ByqXn2UzzPRTM2X9uwa2zO81B9Kn5AVfTXTJm7I7YLwRy6PmpAVEe7vd/TphxEktCWfNErN0JB6vfGALsq7zWpZZQ76KAuLZKYZmgxZ4YW0kbvoyHn/L4zCGMEjPhzfxtHjp2O5Fay+FW2brPWzbKvsUuCHx5s6WMTZzguzp8ErEHBPUDOWGcLKc67mg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR08MB6397.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b66136-76dc-4232-f703-08d854ca329a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2020 14:11:07.9918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +XCsrM0WlRLom4nvK0vnR3/DLhMk1iSWB11aNmvf6hEMTgr9goRSgz2ROevMSGjXpdUjbQ55Dllntr6PglYHOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR08MB6400
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thirumalesha,

I think it is better to split the patch into two:
1. Changes for the devices which are already present
2. For the device MT29F2G01AAAED, which you want to add

>=20
> The MT29F2G01AAAED is a single die, 2Gb Micron SPI NAND Flash with 4-bit
> ECC
>=20
> Signed-off-by: Thirumalesha Narasimhappa <nthirumalesha7@gmail.com>
> ---
>  v3: As per the review comments,
>      1. Renamed read_cache_variants as quadio_read_cache_variants,
> write_cache_variants as
> 	x4_write_cache_variants/x1_write_cache_variants,
> update_cache_variants as
> 	x4_update_cache_variants/x1_update_cache_variants,
> read_cache_variants
> 	as x4_read_cache_variants
>      2. Renamed micron_8_ooblayout as micron_grouped_ooblayout &
> mt29f2g01aaaed_ooblayout as
> 	micron_interleaved_ooblayout
>      3. Generalized page size based oob section check in
> mt29f2g01aaaed_ooblayout_ecc function
> 	and separate case check for two bytes BBM reserved in
> mt29f2g01aaaed_ooblayout_free function
>      4. Removed mt29f2g01aaaed_ecc_get_status function &
> MICRON_STATUS_ECC_1TO4_BITFLIPS
>=20
>  v2: removed SPINAND_SELECT_TARGET as per the comments & fixed typo
> errors
>=20
>  drivers/mtd/nand/spi/micron.c | 141 ++++++++++++++++++++++++----------
>  1 file changed, 101 insertions(+), 40 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.=
c
> index 5d370cfcdaaa..fa8c20f37611 100644
> --- a/drivers/mtd/nand/spi/micron.c
> +++ b/drivers/mtd/nand/spi/micron.c
> @@ -28,7 +28,7 @@
>=20
>  #define MICRON_SELECT_DIE(x)	((x) << 6)
>=20
> -static SPINAND_OP_VARIANTS(read_cache_variants,
> +static SPINAND_OP_VARIANTS(quadio_read_cache_variants,
>  		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL,
> 0),
>  		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
>  		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL,
> 0),
> @@ -36,14 +36,27 @@ static SPINAND_OP_VARIANTS(read_cache_variants,
>  		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
>  		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
>=20
> -static SPINAND_OP_VARIANTS(write_cache_variants,
> +static SPINAND_OP_VARIANTS(x4_write_cache_variants,
>  		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
>  		SPINAND_PROG_LOAD(true, 0, NULL, 0));
>=20
> -static SPINAND_OP_VARIANTS(update_cache_variants,
> +static SPINAND_OP_VARIANTS(x4_update_cache_variants,
>  		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
>  		SPINAND_PROG_LOAD(false, 0, NULL, 0));
>=20
> +/* Micron  MT29F2G01AAAED Device */
> +static SPINAND_OP_VARIANTS(x4_read_cache_variants,
> +		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
> +
> +static SPINAND_OP_VARIANTS(x1_write_cache_variants,
> +		SPINAND_PROG_LOAD(true, 0, NULL, 0));
> +
> +static SPINAND_OP_VARIANTS(x1_update_cache_variants,
> +		SPINAND_PROG_LOAD(false, 0, NULL, 0));
> +
>  static int micron_8_ooblayout_ecc(struct mtd_info *mtd, int section,
>  				  struct mtd_oob_region *region)
>  {
> @@ -69,11 +82,49 @@ static int micron_8_ooblayout_free(struct mtd_info
> *mtd, int section,
>  	return 0;
>  }
>=20
> -static const struct mtd_ooblayout_ops micron_8_ooblayout =3D {
> +static int mt29f2g01aaaed_ooblayout_ecc(struct mtd_info *mtd, int sectio=
n,
> +					struct mtd_oob_region *region)
> +{
> +	struct spinand_device *spinand =3D mtd_to_spinand(mtd);
> +
> +	if (section >=3D spinand->base.memorg.pagesize /
> +			mtd->ecc_step_size)
> +		return -ERANGE;
> +
> +	region->offset =3D (section * 16) + 8;
> +	region->length =3D 8;
> +
> +	return 0;
> +}
> +
> +static int mt29f2g01aaaed_ooblayout_free(struct mtd_info *mtd, int secti=
on,
> +					 struct mtd_oob_region *region)
> +{
> +	if (section >=3D 4)
> +		return -ERANGE;

You can deduce the max section with pagesize/ecc_step_size as in the above =
function.

> +
> +	if (section) {
> +		region->offset =3D 16 * section;
> +		region->length =3D 8;
> +	} else {
> +		/* section 0 has two bytes reserved for the BBM */
> +		region->offset =3D 2;
> +		region->length =3D 6;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct mtd_ooblayout_ops micron_grouped_ooblayout =3D {
>  	.ecc =3D micron_8_ooblayout_ecc,
>  	.free =3D micron_8_ooblayout_free,
>  };
>=20
> +static const struct mtd_ooblayout_ops micron_interleaved_ooblayout =3D {
> +	.ecc =3D mt29f2g01aaaed_ooblayout_ecc,
> +	.free =3D mt29f2g01aaaed_ooblayout_free,

I would rename mt29f2g01aaaed_ to a more common one.

> +};
> +
>  static int micron_select_target(struct spinand_device *spinand,
>  				unsigned int target)
>  {
> @@ -120,55 +171,55 @@ static const struct spinand_info
> micron_spinand_table[] =3D {
>=20
> SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x24),
>  		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
>  		     NAND_ECCREQ(8, 512),
> -		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> -					      &write_cache_variants,
> -					      &update_cache_variants),
> +
> SPINAND_INFO_OP_VARIANTS(&quadio_read_cache_variants,
> +					      &x4_write_cache_variants,
> +					      &x4_update_cache_variants),
>  		     0,
> -		     SPINAND_ECCINFO(&micron_8_ooblayout,
> +		     SPINAND_ECCINFO(&micron_grouped_ooblayout,
>  				     micron_8_ecc_get_status)),
>  	/* M79A 2Gb 1.8V */
>  	SPINAND_INFO("MT29F2G01ABBGD",
>=20
> SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x25),
>  		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
>  		     NAND_ECCREQ(8, 512),
> -		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> -					      &write_cache_variants,
> -					      &update_cache_variants),
> +
> SPINAND_INFO_OP_VARIANTS(&quadio_read_cache_variants,
> +					      &x4_write_cache_variants,
> +					      &x4_update_cache_variants),
>  		     0,
> -		     SPINAND_ECCINFO(&micron_8_ooblayout,
> +		     SPINAND_ECCINFO(&micron_grouped_ooblayout,
>  				     micron_8_ecc_get_status)),
>  	/* M78A 1Gb 3.3V */
>  	SPINAND_INFO("MT29F1G01ABAFD",
>=20
> SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x14),
>  		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
>  		     NAND_ECCREQ(8, 512),
> -		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> -					      &write_cache_variants,
> -					      &update_cache_variants),
> +
> SPINAND_INFO_OP_VARIANTS(&quadio_read_cache_variants,
> +					      &x4_write_cache_variants,
> +					      &x4_update_cache_variants),
>  		     0,
> -		     SPINAND_ECCINFO(&micron_8_ooblayout,
> +		     SPINAND_ECCINFO(&micron_grouped_ooblayout,
>  				     micron_8_ecc_get_status)),
>  	/* M78A 1Gb 1.8V */
>  	SPINAND_INFO("MT29F1G01ABAFD",
>=20
> SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x15),
>  		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
>  		     NAND_ECCREQ(8, 512),
> -		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> -					      &write_cache_variants,
> -					      &update_cache_variants),
> +
> SPINAND_INFO_OP_VARIANTS(&quadio_read_cache_variants,
> +					      &x4_write_cache_variants,
> +					      &x4_update_cache_variants),
>  		     0,
> -		     SPINAND_ECCINFO(&micron_8_ooblayout,
> +		     SPINAND_ECCINFO(&micron_grouped_ooblayout,
>  				     micron_8_ecc_get_status)),
>  	/* M79A 4Gb 3.3V */
>  	SPINAND_INFO("MT29F4G01ADAGD",
>=20
> SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x36),
>  		     NAND_MEMORG(1, 2048, 128, 64, 2048, 80, 2, 1, 2),
>  		     NAND_ECCREQ(8, 512),
> -		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> -					      &write_cache_variants,
> -					      &update_cache_variants),
> +
> SPINAND_INFO_OP_VARIANTS(&quadio_read_cache_variants,
> +					      &x4_write_cache_variants,
> +					      &x4_update_cache_variants),
>  		     0,
> -		     SPINAND_ECCINFO(&micron_8_ooblayout,
> +		     SPINAND_ECCINFO(&micron_grouped_ooblayout,
>  				     micron_8_ecc_get_status),
>  		     SPINAND_SELECT_TARGET(micron_select_target)),
>  	/* M70A 4Gb 3.3V */
> @@ -176,33 +227,33 @@ static const struct spinand_info
> micron_spinand_table[] =3D {
>=20
> SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x34),
>  		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
>  		     NAND_ECCREQ(8, 512),
> -		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> -					      &write_cache_variants,
> -					      &update_cache_variants),
> +
> SPINAND_INFO_OP_VARIANTS(&quadio_read_cache_variants,
> +					      &x4_write_cache_variants,
> +					      &x4_update_cache_variants),
>  		     SPINAND_HAS_CR_FEAT_BIT,
> -		     SPINAND_ECCINFO(&micron_8_ooblayout,
> +		     SPINAND_ECCINFO(&micron_grouped_ooblayout,
>  				     micron_8_ecc_get_status)),
>  	/* M70A 4Gb 1.8V */
>  	SPINAND_INFO("MT29F4G01ABBFD",
>=20
> SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x35),
>  		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
>  		     NAND_ECCREQ(8, 512),
> -		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> -					      &write_cache_variants,
> -					      &update_cache_variants),
> +
> SPINAND_INFO_OP_VARIANTS(&quadio_read_cache_variants,
> +					      &x4_write_cache_variants,
> +					      &x4_update_cache_variants),
>  		     SPINAND_HAS_CR_FEAT_BIT,
> -		     SPINAND_ECCINFO(&micron_8_ooblayout,
> +		     SPINAND_ECCINFO(&micron_grouped_ooblayout,
>  				     micron_8_ecc_get_status)),
>  	/* M70A 8Gb 3.3V */
>  	SPINAND_INFO("MT29F8G01ADAFD",
>=20
> SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x46),
>  		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 2),
>  		     NAND_ECCREQ(8, 512),
> -		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> -					      &write_cache_variants,
> -					      &update_cache_variants),
> +
> SPINAND_INFO_OP_VARIANTS(&quadio_read_cache_variants,
> +					      &x4_write_cache_variants,
> +					      &x4_update_cache_variants),
>  		     SPINAND_HAS_CR_FEAT_BIT,
> -		     SPINAND_ECCINFO(&micron_8_ooblayout,
> +		     SPINAND_ECCINFO(&micron_grouped_ooblayout,
>  				     micron_8_ecc_get_status),
>  		     SPINAND_SELECT_TARGET(micron_select_target)),
>  	/* M70A 8Gb 1.8V */
> @@ -210,13 +261,23 @@ static const struct spinand_info
> micron_spinand_table[] =3D {
>=20
> SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x47),
>  		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 2),
>  		     NAND_ECCREQ(8, 512),
> -		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> -					      &write_cache_variants,
> -					      &update_cache_variants),
> +
> SPINAND_INFO_OP_VARIANTS(&quadio_read_cache_variants,
> +					      &x4_write_cache_variants,
> +					      &x4_update_cache_variants),
>  		     SPINAND_HAS_CR_FEAT_BIT,
> -		     SPINAND_ECCINFO(&micron_8_ooblayout,
> +		     SPINAND_ECCINFO(&micron_grouped_ooblayout,
>  				     micron_8_ecc_get_status),
>  		     SPINAND_SELECT_TARGET(micron_select_target)),
> +	/* M69A 2Gb 3.3V */
> +	SPINAND_INFO("MT29F2G01AAAED",
> +
> SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x9F),
> +		     NAND_MEMORG(1, 2048, 64, 64, 2048, 80, 2, 1, 1),
> +		     NAND_ECCREQ(4, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&x4_read_cache_variants,
> +					      &x1_write_cache_variants,
> +					      &x1_update_cache_variants),
> +		     0,
> +		     SPINAND_ECCINFO(&micron_interleaved_ooblayout, NULL)),
>  };
>=20
>  static int micron_spinand_init(struct spinand_device *spinand)
> --
> 2.17.1

Thanks,
Shiva

