Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F65DC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 11:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 410A12070A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 11:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbgCZLpK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 07:45:10 -0400
Received: from mail-oln040092071108.outbound.protection.outlook.com ([40.92.71.108]:13131
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727948AbgCZLpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 07:45:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=guKjNLNOzhaR8zmHUXmJmFOpTjVVJHKLlyCcURoIa07CiqMBGoYZfs3lyJtNaewojiLzz4dZIZQB5EZ8UKwd2Ss9PcYnW6+xoiWRmc8Dzq4Rw24vBCqIPDtDDXNunBlnNMdYbfweb8cY9ju/DbAH+SHxHYxGv4F5cUfDMBscE3x17zwHvBdtVLm/2LQB+pL3cjRGqFaC48+MMb2sjTAUphH2C/pNIKHW8WgrzxSR5ZG8RqgD5HCkvFJvjh+xRIZawDX86XIxkrH8rOZm0dTbGrP1a7FutJFwWPpU53Bxl5OnZFtMSkm9xF4n41aYCdoNXqXNOqJ3xU3Zi4vs6u+i6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubZ0J+6WJ4jMurRddyNk8osUo5OHq/ij8Qb25ZoaKi4=;
 b=B8P87RpRU9yPcHThyuxCf6KmQoU382HJ0wB0I93cLwI5tpMk4QtXKrJ2Xt+nF7vm9kU8KLyzdOFPG3tEq8KdyuvQUC8q/neOqCDmZ3UVT6D6EnZqTRR8o+C4xEeowG4lDVdw0vSwOzQblOIAf+Ku01YmcL2tVJhxAzZbmPZJJubExH2JC/xvSYXooe7MV55CvKRIWNtD4edjsRTglns7Y5jrNBwsLEG0EJs4kgwCsb/D38+eByQ94sVNe9yg9p5TqFPv/x4ii/psU4PBy2qdXcMrXCj0punW4Rn2zLF/eYSX7pQB8VT64c0e9nhBGnTLwpbJ/Wc7DQ7qMyG6tJc49w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DB5EUR03FT011.eop-EUR03.prod.protection.outlook.com
 (2a01:111:e400:7e0a::47) by
 DB5EUR03HT217.eop-EUR03.prod.protection.outlook.com (2a01:111:e400:7e0a::221)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.17; Thu, 26 Mar
 2020 11:45:07 +0000
Received: from PR1PR05MB5546.eurprd05.prod.outlook.com (10.152.20.55) by
 DB5EUR03FT011.mail.protection.outlook.com (10.152.20.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.17 via Frontend Transport; Thu, 26 Mar 2020 11:45:07 +0000
Received: from PR1PR05MB5546.eurprd05.prod.outlook.com
 ([fe80::558c:f4bc:44ce:6add]) by PR1PR05MB5546.eurprd05.prod.outlook.com
 ([fe80::558c:f4bc:44ce:6add%7]) with mapi id 15.20.2835.023; Thu, 26 Mar 2020
 11:45:07 +0000
From:   outlook user <Pingo-Power@hotmail.fr>
To:     LKML <linux-kernel@vger.kernel.org>
Subject: ScreenPad diplay
Thread-Topic: ScreenPad diplay
Thread-Index: AQHWA2JAGSO8/iYYv0mN949P/Zm2CKhawG/g
Date:   Thu, 26 Mar 2020 11:45:07 +0000
Message-ID: <PR1PR05MB554664CE22000F934D6A5C0397CF0@PR1PR05MB5546.eurprd05.prod.outlook.com>
References: <PR1PR05MB55466D0D588E939CC540423A97CF0@PR1PR05MB5546.eurprd05.prod.outlook.com>
In-Reply-To: <PR1PR05MB55466D0D588E939CC540423A97CF0@PR1PR05MB5546.eurprd05.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:66FACCD22849A9C44744A328B12558187F469C02D6C74F0CAAE4BBB42C12907D;UpperCasedChecksum:CF98F2CC4DC45552E8EA5E781DC427E17871E557F2A8113A3CB2D31311286981;SizeAsReceived:6869;Count:45
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [JXbT2XcAehuIt6f7BKLg68Z8CpS4/K34]
x-ms-publictraffictype: Email
x-incomingheadercount: 45
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 385b2bca-9497-4e1a-3b43-08d7d17b21ec
x-ms-traffictypediagnostic: DB5EUR03HT217:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 594TJ0SjQNOASPZjNzpyVZ5jN2AR2QEx7mrLoSSADZf2UrGyeWpI64QJCGnI7fP2lNiULdHf5SRyjV5X76+Ahyo2GjmS9tPS07FoyP8Mz9fO3b3JiiJSNpdBCvFK3ITOiKjMvqndTb7Ujd4HS42J3Qt/ZXB4DBGaPPD1SP306Z47I195H2Jjq8QdEYhh2Z+m
x-ms-exchange-antispam-messagedata: +hWdnBbUcw73A3Q1tn4eDRSZmleYNqH+6/vQJiwrYv6OrVe4Z9t071DRDA/khwq6IpAKmXUwmG205xNi3RvNivWMeWByNJObWQ8sBFc7e9+FcSmWyYeCZrJ7S3NI9b+LJ0+tX6NcYRkgDxitzKoSlQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 385b2bca-9497-4e1a-3b43-08d7d17b21ec
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2020 11:45:07.5927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5EUR03HT217
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not on the mailing list, I want to receive a carbon copy of each reply to this topic

When I run the system on Intel APU, Xrandr say that I've only eDP-1 (connected) (my main screen) and HDMI-1 (disconnected) (the HDMI port of my computer). The KDE UI stills seems to detects somethings because he pops up the equivalent of "Super+P" pop-up in
 Windows (the one who asks you where you want to diplay your desktop). But here, only the HDMI port and main screen works, not the ScreenPad, I don't know where to find logs of why the display manager pops up

When I run it on nVidia GPU (optimus-manager to switch), the ScreenPad goes on, on a black screen. Xrandr lists eDP-1 (same), HDMI-0 (connected) and HDMI-1 (not connected). I guess here that HDMI-0 should be the ScreenPad. But I don't know how to display something
 on it, or even manipulate the display. If i change resolution it doesn't changes anything on the ScreenPad, not even a flickering
