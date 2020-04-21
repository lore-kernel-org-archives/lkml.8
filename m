Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD4FC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45ED2206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="Q1lcdhwT";
	dkim=pass (1024-bit key) header.d=cisco.onmicrosoft.com header.i=@cisco.onmicrosoft.com header.b="OB2OCWul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgDUQYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 12:24:22 -0400
Received: from rcdn-iport-9.cisco.com ([173.37.86.80]:55703 "EHLO
        rcdn-iport-9.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgDUQYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2368; q=dns/txt; s=iport;
  t=1587486259; x=1588695859;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZBTSKn9bYXZQ+KxhsDceNmbJ1HQ/lrzo/MI3kfCBvRc=;
  b=Q1lcdhwTr4IXTOB0jKOHAg1geEFLzz8qh4kEyaWn8LopFv4f7SKr71it
   xCRTadw8b0JqA29AMPeLo1REKu7J32wSSQCZ29zZkoae/RmkM0HCLM3ds
   BeoWBQjSM6xB7qmi7EZjFvdmtyx8QIj+K38l2d2f/6yhrUjMtCwJmoNBf
   Q=;
IronPort-PHdr: =?us-ascii?q?9a23=3AGnegnR/TKW1auP9uRHGN82YQeigqvan1NQcJ65?=
 =?us-ascii?q?0hzqhDabmn44+8ZR7E/fs4iljPUM2b8P9Ch+fM+4HYEW0bqdfk0jgZdYBUER?=
 =?us-ascii?q?oMiMEYhQslVcKMD0z2KOHjRyc7B89FElRi+iLzPA=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0DvAAC9HZ9e/4cNJK1cChwBAQEBAQc?=
 =?us-ascii?q?BAREBBAQBAYFoBgEBCwGBU1EFbFggBAsqCodaA4pqToIRgQGOJxSIbIEuFIE?=
 =?us-ascii?q?QA1QKAQEBDAEBJQgCBAEBhEQCghckNQgOAgMBAQsBAQUBAQECAQUEbYVWAQu?=
 =?us-ascii?q?FcQEBAQECARIoBgEBNwEECwIBCBgeEBQeJwQOBSKDBYJLAw4gAQ6lfgKBOYg?=
 =?us-ascii?q?tNYIngwABAQWFShcBgg4JFIEkAYJiiVYagUE/gRGCWzU+gmcEgSQKAQcLASE?=
 =?us-ascii?q?sgxiCLY5AF4IaoRsKgkSIC4VwiWspDoJIiFGRNi2PRolAky8CBAIEBQIOAQE?=
 =?us-ascii?q?FgVQBNmZwcBWDJAlHGA2KMYcng3OKVnQCAQGBJY0WAYEKBQEB?=
X-IronPort-AV: E=Sophos;i="5.72,410,1580774400"; 
   d="scan'208";a="667306449"
Received: from alln-core-2.cisco.com ([173.36.13.135])
  by rcdn-iport-9.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 21 Apr 2020 16:24:18 +0000
Received: from XCH-RCD-005.cisco.com (xch-rcd-005.cisco.com [173.37.102.15])
        by alln-core-2.cisco.com (8.15.2/8.15.2) with ESMTPS id 03LGOIE7013104
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 21 Apr 2020 16:24:18 GMT
Received: from xhs-rcd-003.cisco.com (173.37.227.248) by XCH-RCD-005.cisco.com
 (173.37.102.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 21 Apr
 2020 11:24:18 -0500
Received: from xhs-rcd-001.cisco.com (173.37.227.246) by xhs-rcd-003.cisco.com
 (173.37.227.248) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 21 Apr
 2020 11:24:17 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (72.163.14.9) by
 xhs-rcd-001.cisco.com (173.37.227.246) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 21 Apr 2020 11:24:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TESVFLMfLHroAXO5XM+pU8D3vk6FRdXBaNZipgW8MAuMg6DXg7+FeRcPQIFDmVvw7VsoLNv7jKcR594nScR8YVvDGVOU76BjGH+WqPTAn6Oe7zNn+4g2qPHZYduALlzKBi1EnVAzYR0h/g6HvPyWi5tzHQnNuRostjkIUsqyNe7P163p6smogmQ1hzVVL1D7QkHTgT3a+f6KCFP9p7bpQxAzzFFNdDEtXUHEztQc9OX5XBirXFhtoQaJAvzSL70PqfifbUaboXtnoGR+GzVfwDW9QWI8fakCet92u6am+owDHHL3W6pyCSHoM14bQ7ptrOdovWH98h5dJx2ZjQqqEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBTSKn9bYXZQ+KxhsDceNmbJ1HQ/lrzo/MI3kfCBvRc=;
 b=Pw5dUSRLaBJ6lbPVNsuKBITGTlJGmih7H7UdoOE2kaXg3Y3yR3+vPGaqQa9mqUvxZPFNLlshkJF1b+XTKszQEMlk+Q0M7tq7M8WPwXMXUFV/cPMrc6EuVIjX5SBrVkfnRX8MlYYN/m/KIDEQ7HEFEyGkiv4g8YuPHuF7ZjpnRYueocBOvCM7/uxx2EDIR0Fd9cHO/V0xNUKx7hc+5Eon7Onb7Dy9nRjK5DxMsebgzpD/ONewiegMJTqd5HRdk6ykgv5o3SRSBVuWjfNswHsysKlHWNrHMVSkWVxl6cvdpzNWRCdkhOqc8CFsKHOqLUckMGdCzvuD9aKhGrnU9FkbAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBTSKn9bYXZQ+KxhsDceNmbJ1HQ/lrzo/MI3kfCBvRc=;
 b=OB2OCWulGSfoHIwsTT1RRRex+iYB2UJQ1b7ZwSVozrwhy37GfKhdPmSiFqIvVidRMLhNh29qxsL+PNVAFjIxhY7fxa4qlyuFBwtnwxcZsBe+3AezYfUBn+7oYuRwq2DeYfA0Xl7uJzDyltDcxlsdWQmYDkc8lIlVR7GlB7C91WI=
Received: from BYAPR11MB3205.namprd11.prod.outlook.com (2603:10b6:a03:1e::32)
 by BYAPR11MB3287.namprd11.prod.outlook.com (2603:10b6:a03:1c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Tue, 21 Apr
 2020 16:24:14 +0000
Received: from BYAPR11MB3205.namprd11.prod.outlook.com
 ([fe80::d015:3039:2595:7222]) by BYAPR11MB3205.namprd11.prod.outlook.com
 ([fe80::d015:3039:2595:7222%7]) with mapi id 15.20.2921.030; Tue, 21 Apr 2020
 16:24:14 +0000
From:   "Daniel Walker (danielwa)" <danielwa@cisco.com>
To:     "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>
CC:     "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: Add 4B_OPCODES flag to n25q256a
Thread-Topic: [PATCH] mtd: spi-nor: Add 4B_OPCODES flag to n25q256a
Thread-Index: AQHWF/lMc3ECMdgUBUCVtkLu7h92/g==
Date:   Tue, 21 Apr 2020 16:24:14 +0000
Message-ID: <20200421162414.GE9016@zorba>
References: <20200417174620.16420-1-danielwa@cisco.com>
 <12178429.kzmL6e4XO6@192.168.0.120> <20200420162550.GZ24466@zorba>
 <9715610.TpusJ8o3lr@192.168.0.120>
In-Reply-To: <9715610.TpusJ8o3lr@192.168.0.120>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=danielwa@cisco.com; 
x-originating-ip: [128.107.241.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53c63e6f-c566-4731-c935-08d7e6106ec9
x-ms-traffictypediagnostic: BYAPR11MB3287:
x-ld-processed: 5ae1af62-9505-4097-a69a-c1553ef7840e,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3287D53930485A49EA1A9753DDD50@BYAPR11MB3287.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 038002787A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3205.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(7916004)(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(2906002)(33716001)(54906003)(316002)(81156014)(66946007)(966005)(1076003)(6916009)(5660300002)(71200400001)(6486002)(8936002)(8676002)(6512007)(4326008)(33656002)(186003)(76116006)(53546011)(478600001)(26005)(66476007)(6506007)(64756008)(66556008)(9686003)(86362001)(66446008);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: cisco.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mEwUPusPtPzLVlGAiRQ/5nM71huhL8BKuZXGq25KVITPSuw4t842F7ZR+B/5VhuffsRQZFS3XGVC0cJfjYtLbLnQH1SJlWYhioceGo7RIdp+kOZ4zc4ya58AD6N6F+moiNGdhbuA4GxV3GaDGuv3OJRPpz0APk2LGDJMuKMKvoF+B8Q7dzjyWwhdqbA93dpBsyFFS3YVoILz0F+l1uNZuN5Y80btq806CCgXLPh9/+M+8V044ar+IcRNBR+6kltmxgqklgh/a9/Skg5Ikl1i3yv6ETy9KcAzmNwDfZ3b8gyf7sm/Hi81Fq1ddUwTzoE+H7Au7KP5yNhW9eIa7IftUfhXojyMbJ/XoArBNvjNxfcdQOkbN0BChrXTQwx9aEXmpwYOdFaXp6DnYgPbSSbfhXn3LdyeWSzDOws7kW8iLaXvUHv1gp2GudyCRCck8gMpP8caoLuUz2DtCarvNAuemcaNNoXMxGzC8DmM/JBL2xQQJLzWEYkslSZ1ywCOPWFCWkiNaYs3WsirZ0GRPAvLbA==
x-ms-exchange-antispam-messagedata: tOga0wLXqL9IeWFQBR+9aRKkMDVMMz/o6mWn6rDwmJY7bnDpuXay4Pq3Cso1kuy7v6sUHdd8n4RJzn5dgGh7masNYVLV2G+HlL1fqaxvFEavLHHEbFSUKN9ke3oqLW6AYlbfEwfO6zAe6HUc2/bV5w==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <29FDC119F0A59D43AFF5BA83E79ED2F4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c63e6f-c566-4731-c935-08d7e6106ec9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2020 16:24:14.7478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ZHsy4zJWSxU+koYnG8e4iXcg8JFqXFnGqbOxGTuVDcv3/YDL+SHeY/OnxSq1PKDH8Gq6PRnlnlsfVXW+jxdUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3287
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.37.102.15, xch-rcd-005.cisco.com
X-Outbound-Node: alln-core-2.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 04:52:01AM +0000, Tudor.Ambarus@microchip.com wrote=
:
> On Monday, April 20, 2020 7:25:51 PM EEST Daniel Walker (danielwa) wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the
> > content is safe
> > On Mon, Apr 20, 2020 at 03:45:59PM +0000, Tudor.Ambarus@microchip.com w=
rote:
> > > Hi, Daniel,
> > >=20
> > > On Friday, April 17, 2020 8:46:19 PM EEST Daniel Walker wrote:
> > > > EXTERNAL EMAIL: Do not click links or open attachments unless you k=
now
> > > > the
> > > > content is safe
> > > >=20
> > > > The n25q256a supports 4-byte opcodes so lets add the flag.
> > >=20
> > > This is not true for all the n25q256a flashes. SPINOR_OP_PP_4B,
> > > SPINOR_OP_BE_4K_4B and SPINOR_OP_SE_4B are valid just for the part nu=
mbers
> > > N25Q256A83ESF40x, N25Q256A83E1240x, and N25Q256A83ESFA0F.
> > >=20
> > > You need to differentiate between the aforementioned flashes and the =
rest
> > > in the n25q256a, in order to add the 4-byte opcodes flag.
> >=20
> > How do you suggest I do that ? Can I add a new entry into this table wi=
th
> > more specific information about the chips ?
> >=20
>=20
> We need to find a differentiator at runtime. If we are lucky, there might=
 be=20
> some SFDP changes between the 4-byte opcodes capable flashes and the rest=
.=20
> Please dump all the sfdp tables, we can start from there. There's a threa=
d=20
> that might interest you, see http://u-boot.10912.n7.nabble.com/Regression=
s-in-MTD-SPI-FLASH-td382956.html#a383126.
=20
The thread seems to indicate that it's not easy to identify the chips which
support this.

Inside our device tree we identify that our flash is compatible with,
compatible =3D "jedec,spi-nor";

Would it make sense to add further identification of the chips into the dev=
ice
tree, or allow some level of control over the SPI_NOR_4B_OPCODES flag into =
the
device tree. Since it would seems identification of the chips is not trivia=
l.

> A more elegant way to solve it, is by parsing the 4bait sfdp table, but I=
=20
> haven't checked if this flash supports it or not. Anyway, not something t=
hat=20
> we can control, the manufacturer should add it.

We can investigate, our hardware team is claiming the only way to know if
physically reading what's on the chip.

Daniel=
