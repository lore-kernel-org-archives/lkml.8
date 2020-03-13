Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7B5C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B4E206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="ryXUt4pH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgCMOlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 10:41:16 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:52821 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgCMOlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 10:41:16 -0400
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: CZLTi7xejXP6nNOhldVOWZxB9MGkC6uPZqQHUFTXGT4h1XIXpNmD3EwjJXQMhO54F0cD/D/p6M
 oi15h+MLBEvcagd4nHMqrF4vOWVUiHxGDhFZvYbjZMgrk01I0UkTJ2QORxUkf3IZBvnHbA96SJ
 0QeJmA4sWyn6LZYkvkZbHQYbV4JDVnEy8/6/s7ZegJ3Tymkfn6HDImBBlSQ4nX1QVdLC7R2PjJ
 MA5gCn27HRHAIXMADdjNkZJL7s3DeRhOHS1dOTM785wgxSU/dY6utr/iOxf5yeQDuH+L40RG7c
 Io8=
X-IronPort-AV: E=Sophos;i="5.70,548,1574146800"; 
   d="scan'208";a="5565075"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Mar 2020 07:41:15 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 13 Mar 2020 07:41:09 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 13 Mar 2020 07:41:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGSmoyDvA7qYqozNUPjzJ3IHnlBSGsfGIIbIJAB/7gVS6MYAj669QIpAuOqnuGO4l89+2kd/P4jvs8TZFTwofEzc/r9yPOC7216p+ED8kMtp+gmCTRT0h/9WuzXrvlH/CtD7jAsc2RdnFHWgcrlpOn81UDjVBvluIEfVM9zN+0R3EaPrrRkXJTV9MmLx4wsZcja7gLMIU8rFJeoIgsKLhuVuzAy5MBTwtkjv7G0vwhItS5HjlUznMSyOQocnS5jmvXiXxWoTG9waEgt6JUhyAtsrXFL7Nv6DHCb7Fa6Xmso/MAsJPLgyzgP2pZ6peJ7MnNIGhZi7iCa2lcgb7TFaCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiiqScKYOQgqjtCf3Jvx9xSnPRY3R9+15OBZ544Xs5k=;
 b=W98hDcm2f09lu79RugnNqtXZ14jPwGAxoSFKWiMxIIHVvTS/Yzxf/+h3rN3UgWlGSW44YVF0+yyhOKjqnH5gTn8gAEu6WPDh7o/Z5QLoLfpV85Pw2t3PRjhEO7T/wh4sSjtFvaUoHcC/JcjGOdZcJZIVsSYYw1V4RQddD8eOdhTYFkkFer6vzsWGG89fbojihq+RYABNxFiUo4DWu8K36y1PN80lpkdFszLBthD5cldV30/wf/6rDE639RphMYvwuHVhqJZAx+lQvKhZyz7H2chmayrAWhcpn/XgFCISszbgm/8DLxDBnNoWxvjQT2A2w9LLfCEP9uBK2v0UHrUjlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiiqScKYOQgqjtCf3Jvx9xSnPRY3R9+15OBZ544Xs5k=;
 b=ryXUt4pHa5iUhF99TTwSUXnocpEH4pL+ENVBsrduVyx9QRzUW/haG+H7PTcqMEjUIeg8B8uMu7+rTfkps0QklRoSLHmHiN0nM0LOYE9F+cWDU6B4qCnH34gDzP3EqL6oouqzDvclPkzuQtAsFYrqZlkftTl+ZoEyZSz6IPaXb18=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (2603:10b6:208:193::29)
 by MN2PR11MB4581.namprd11.prod.outlook.com (2603:10b6:208:26c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18; Fri, 13 Mar
 2020 14:41:12 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb%5]) with mapi id 15.20.2793.018; Fri, 13 Mar 2020
 14:41:12 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <linux-mtd@lists.infradead.org>
CC:     <vigneshr@ti.com>, <bbrezillon@kernel.org>,
        <kstewart@linuxfoundation.org>, <alexandre.belloni@bootlin.com>,
        <linux-aspeed@lists.ozlabs.org>, <thor.thayer@linux.intel.com>,
        <jethro@fortanix.com>, <rfontana@redhat.com>,
        <miquel.raynal@bootlin.com>, <opensource@jilayne.com>,
        <richard@nod.at>, <michal.simek@xilinx.com>,
        <Ludovic.Desroches@microchip.com>, <joel@jms.id.au>,
        <nishkadg.linux@gmail.com>, <john.garry@huawei.com>,
        <vz@mleia.com>, <alexander.sverdlin@nokia.com>,
        <matthias.bgg@gmail.com>, <tglx@linutronix.de>,
        <swboyd@chromium.org>, <mika.westerberg@linux.intel.com>,
        <allison@lohutok.net>, <linux-arm-kernel@lists.infradead.org>,
        <andrew@aj.id.au>, <Nicolas.Ferre@microchip.com>,
        <linux-kernel@vger.kernel.org>, <dinguyen@kernel.org>,
        <michael@walle.cc>, <ludovic.barre@st.com>,
        <linux-mediatek@lists.infradead.org>, <info@metux.net>
Subject: Re: [PATCH 02/23] mtd: spi-nor: Prepare core / manufacturer code
 split
Thread-Topic: [PATCH 02/23] mtd: spi-nor: Prepare core / manufacturer code
 split
Thread-Index: AQHV+UVw1zBm6vyq6ku0E2TrNmSLbg==
Date:   Fri, 13 Mar 2020 14:41:12 +0000
Message-ID: <25973821.h3VOFtvjmD@192.168.1.3>
References: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
 <20200302180730.1886678-3-tudor.ambarus@microchip.com>
 <c5ef3581-e589-1206-3856-dc4000c0b511@ti.com>
In-Reply-To: <c5ef3581-e589-1206-3856-dc4000c0b511@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: abfeb9f3-7d34-4d92-2bd3-08d7c75c9390
x-ms-traffictypediagnostic: MN2PR11MB4581:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB45817EC5F57CA3A3D8644990F0FA0@MN2PR11MB4581.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 034119E4F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(346002)(396003)(136003)(199004)(6506007)(86362001)(53546011)(4326008)(5660300002)(4744005)(81156014)(2906002)(8936002)(81166006)(186003)(8676002)(66556008)(64756008)(316002)(66946007)(76116006)(91956017)(66476007)(66446008)(478600001)(6486002)(7406005)(7416002)(71200400001)(14286002)(9686003)(26005)(6512007)(54906003)(6916009)(39026012);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4581;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LWL/dymZXlFhMLKmOJyLYZ30P1PxKWwLqjWMWzJFIEPfRGt+TVJyR6ma57wbdrlSo8PqhTqDANcA6unWdmZMQblrh6vtp2IAfkZgdhfqsAMuaWW/VKE7AgAgo6dOPkmZn7h6+ovbgKVKB54vSxIaO+KwRd+FkQK2Wq4ccR0xW9F3ijAcMPXR4FPDe2zIRv7cz8ukDl0FNpHZk1mDKfYxKYPejn8qQfzE0xPvpiKqt0v++dvLJJJMl4V7ikKqEZdK4j9brkwVoWURzRtrruZnuZt1Jm82UO5oCYton/M5pq1TS+3MyILvgRQ/5NZs8LvUxtawa31s2mJpd06KHvnRVnWlPh9Xb4bkZMpIQP18YXfp8w/yoQuU3u4DfBu6J1PV7lQa9WU6e4bgq+OLmQtJy2M2PukiwzaJcq+WSMKQoYvLNqY25TEHD0pXQne/ie8i8JIuOEwX4AFCrBIHJgvR+Ln/q1xhK+93RpUsG4jXsgA9ZvrR3goloPpIZDjvMY1b
x-ms-exchange-antispam-messagedata: drXGHBeEAYx3vBt40sRR74rJRqaWk2ULvt7FCmHom5NHvPS/x8a/bEXUOifPmGX2LmuxBXfUoZYSeA+N6kgOqRHtU9Is2Rw1T66vxyaSdjxvKN7wWUkNOL4PrKl4KbXZdBYFH9N4azXEumLXhIAsEw==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D29F883B4B0D684CB6732488EA51455E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: abfeb9f3-7d34-4d92-2bd3-08d7c75c9390
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2020 14:41:12.0833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rPFeuGzLyVLtU0zNI65kwzfypp76xUgknCUE6l5PfvHalsMmt6G/hTgFhsQVkokJJLzIXlU7afZyNnrTB7xfcVCFE3vwKd7F/pzMmDhA0YI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4581
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, March 13, 2020 8:08:44 AM EET Vignesh Raghavendra wrote:
> On 02/03/20 11:37 pm, Tudor.Ambarus@microchip.com wrote:
> > From: Boris Brezillon <bbrezillon@kernel.org>
> >=20
> > Move all SPI NOR controller drivers to a controllers/ sub-directory
> > so that we only have SPI NOR related source files under
> > drivers/mtd/spi-nor/.
> >=20
> > Rename spi-nor.c into core.c, we are about to split this file in multip=
le
> > source files (one per manufacturer, plus one for the SFDP parsing logic=
).
> >=20
> > Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
> > Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>=20
> Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
>=20
>=20
> But there are at least two drivers being moved from spi-nor to spi/
> which would conflict with this change.
>=20

I'll merge the immutable tag provided by Mark and respin this series on top=
 of=20
it, there will be no conflicts.

Cheers,
ta

