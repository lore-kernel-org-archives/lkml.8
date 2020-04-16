Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD01C352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A189520787
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="ECIiDJuA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503325AbgDPJI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 05:08:58 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.1]:34844 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2503034AbgDPJGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 05:06:18 -0400
Received: from [100.113.2.32] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-a.eu-central-1.aws.symcld.net id 74/53-32015-400289E5; Thu, 16 Apr 2020 09:06:12 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEJsWRWlGSWpSXmKPExsWSoS+Yo8usMCP
  OYP97dYv7X48yWlzeNYfNgcnjzrU9bB6fN8kFMEWxZuYl5VcksGbcXniSpeAqe8WUo+sYGxhP
  sHcxcnEwCixllrg7/xFzFyMnkHOMReLKOg6IxGZGid+9P9lAHBaBE8wSnfcuMII4QgLzmSQWL
  j7CBOHcZZTo/NzODtLPJmAhMfnEAzYQW0QgUmLH15OMIDazQLnE/h/fwGqEBaIl9j58zwxREy
  NxfNlUFgjbSuLOmXlgNouAqsS6Mw1gc3gFYiU+7O5khlh2jFHi6FGIZk4BHYn2/c+ZIA6Xlfj
  SuJoZYpm4xK0n88HiEgICEkv2nGeGsEUlXj7+xwpRnypxsukGI0RcR+Ls9SdQtpLE3Ya3UPWy
  Epfmd0PFfSWufTkIFdeSuHt6A1TcQmJJdyvQ0RxAtorEv0OVEOEciT3fDkOdoAZkH2GBsGUkv
  s5eDA44CYG5LBJz5q5in8BoMAvJ2bOARjELaEqs36UPEVaUmNL9kH0WOCgEJU7OfMKygJFlFa
  NFUlFmekZJbmJmjq6hgYGuoaGxrrGuhYVeYpVuol5qqW5yal5JUSJQUi+xvFivuDI3OSdFLy+
  1ZBMjMOGkFDJH7GC8tva93iFGSQ4mJVHeHpkZcUJ8SfkplRmJxRnxRaU5qcWHGGU4OJQkeI3l
  gHKCRanpqRVpmTnA5AeTluDgURLhXQ/SyltckJhbnJkOkTrFaMwx4eXcRcwcR+YuXcQsxJKXn
  5cqJc6rCjJJAKQ0ozQPbhAsKV9ilJUS5mVkYGAQ4ilILcrNLEGVf8UozsGoJMx7URZoCk9mXg
  ncvldApzABnRLtMB3klJJEhJRUA9PuUut5N804T5aYxH/4MPH+Gq+8OZzbGk4WZL/gqsgzOMo
  i9f71jj9t3yx53P6lZPetu3a90jvI6YHwifxA3ZaG7v2Bx3d35M2Y7vTWasbyS7ZbRPJWCl1Y
  MnXL9uSNO+tqD77TsxRkavdpe+rXcHL2GYfE3C3PHFiZU/fdcNnUb/z7f8r3ReZG3+uVr1X13
  juy8XRWXOfvqU57P+zSuFf9Zt/KiYb7u5runVE7Kr2h7ELX63DNnZUChT83OTD/b9c/uC8pSJ
  HhcrH1fp25j/8nZQdET9o2wzRR59fkyEDeKac/lzknfXZdeqq9rnbaP9Fow4J6oUnx5nN/Nmh
  vXhq27q9T9E6hNQt7wg1r/gQqsRRnJBpqMRcVJwIAWvQ2SkUEAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-5.tower-223.messagelabs.com!1587027971!2339957!1
X-Originating-IP: [104.47.17.108]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 31367 invoked from network); 16 Apr 2020 09:06:11 -0000
Received: from mail-db8eur05lp2108.outbound.protection.outlook.com (HELO EUR05-DB8-obe.outbound.protection.outlook.com) (104.47.17.108)
  by server-5.tower-223.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 16 Apr 2020 09:06:11 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2dUC+pLUotlNwQY50mCjguj4gLeXSJgyMFx7fQkpTgZ/JuHMg5h3VPlZWskFD+2kLDZdEnGYkfit7K5ijfekO4kd6GHUUFDCspTPwEGCeGmqYq5yydowPauiRPsm3oBaN3+W3wnSKu2EwazAUncvMODmqe6psvDP4ErAGbOgeAmuI4sFi50yASyNFzSplHhIHLtAXNrAFcyeHcMebR1VvOnWt+nwqyikoKfq/ekz04vZpbR0cHuWE3HjiCaZSDqclbnfRcZjHloIgGl+kdVW+gCaDxeP7ekEsMDwwnXCsvJte/36aqF5twuwBafb+Y1M8KI3VZjPc5a8tzm3KAZgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7S626BDOQgHoC4NC4xlGH4GPh/1GTf4C+us0YH2rqHM=;
 b=SqsDVcAUYUb2Cw2y3VaIa40Gvxi5GBvyEq+H6pb7PC33oh9pyUexDFG8GXfDBbV4f5su3V3keMZ1S1QI9+YhyqTM2Y5xYY3UJf312NyvQo+VfpvuOxqDKHDBN64uoiz8vO929k5zbIEPmfTCX/esC0AVe6rgmc7USBLm5kilI3tkxV4qOJlxlJBZ9jg7VWeO50sfkmPDZVK6OibimrlBq353MKwsa+hEIEwK7db2bk+15/FKvg6Il9ghZ05Ib+RGBgVEOf2ip6vgFV5HBmBifLFG9VdN9RmuakmfzixbI6Mhmvv6bTWUgSQCI1zCeChzBoR6z9VycfwrIPRO8W0l5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7S626BDOQgHoC4NC4xlGH4GPh/1GTf4C+us0YH2rqHM=;
 b=ECIiDJuApN/UPypKwD1TiqwSrNjzZZX2Jz6SJW1jpMp6tvY3J06dbqTJs+rcqdt4PKyzJXhDm9XF8RMyzO3icmb/SLUsabUTraziNvCij+T11Xj8Da0cBAY1IYIbaH0Vn2VIOof16skJ6gJQ92mrfgqlvF2tPngO3fzl1fQiPqQ=
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:52::13)
 by AM6PR10MB2421.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:48::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.26; Thu, 16 Apr
 2020 09:06:10 +0000
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::993f:cdb5:bb05:b01]) by AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::993f:cdb5:bb05:b01%7]) with mapi id 15.20.2900.028; Thu, 16 Apr 2020
 09:06:10 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [RESEND v2 PATCH 2/2] mfd: da9063: Add support for latest DA
 silicon revision
Thread-Topic: [RESEND v2 PATCH 2/2] mfd: da9063: Add support for latest DA
 silicon revision
Thread-Index: AQHWC/EOAb3d4ssyhEOMElYvBjh5Bqh7c/2AgAAQjzA=
Date:   Thu, 16 Apr 2020 09:06:10 +0000
Message-ID: <AM6PR10MB22636366A37AD47ECEB30B7580D80@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1586162737.git.Adam.Thomson.Opensource@diasemi.com>
 <f468a3c56496edf3641b41cbd7797b344c8a99dc.1586162737.git.Adam.Thomson.Opensource@diasemi.com>
 <20200416080631.GV2167633@dell>
In-Reply-To: <20200416080631.GV2167633@dell>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [146.200.27.209]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5206411f-7fcc-43fb-3e74-08d7e1e5680f
x-ms-traffictypediagnostic: AM6PR10MB2421:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR10MB24215FAB3C3219593F40BA7BA7D80@AM6PR10MB2421.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0375972289
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(366004)(396003)(136003)(39850400004)(346002)(376002)(478600001)(55016002)(81156014)(2906002)(86362001)(9686003)(8936002)(8676002)(55236004)(186003)(71200400001)(52536014)(107886003)(4326008)(6506007)(53546011)(33656002)(26005)(7696005)(76116006)(66476007)(66556008)(66446008)(64756008)(66946007)(316002)(110136005)(4744005)(5660300002)(54906003);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iG76w9t/G5lc6yX6RDN2eyq8W+mguYwld0Bx7x1f6zJ/cdFQk8a+q2Xv26lbtJTptGXnEEmRxJFDJxcZRVwYxtwL61+PykVfPsqnXDEyf5JPZ8hC5YrEVh4RNXLAxrjdY54tBoAO91KbjZiF1c0gh1J0nLsyJkQrMgWEPXaS6W+M5xi4wpuX4jTUvJmneZwoWjXy5JdtYM5yAkJNT6P6uIuCwb975QydDYkJMaHsqoHMRN0H1YH3l9NDU0PY3T742nN0e2f8K4tQ+MXuMNgqHMK7g7YIseivN1QV11FgilATuT27t9qMupqWu84GMpL8cwHCvfwBtYUmKfQAnAzMNTg0ccEmEj/3VfQeW4ZqwYyisEH3tJpqDGlzRrHRk+N8n80IJPikLkDvgrnXkq/KQ+9pk3IExzfxcZwCz5s6GUR7bmLOBCUwVHRILlsZkDsp
x-ms-exchange-antispam-messagedata: 4GAEWna2xSZBR6xOW/OSwJxhp+ONm0WYRXcbVBPWOe4Gq2fUB+yOuYjeJ1oWn7VnEBfGqN87iW4D5p2ctbWkr/hqwGENaXNT6hyxMIcOiT74mXQaKXksUqR3IhjvggLqazOH1ba3WkrGCXfnu0tHZA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5206411f-7fcc-43fb-3e74-08d7e1e5680f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2020 09:06:10.4804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wmXOXDW92Jy0c+DRYeVSPl3JQ5LOZNnbfkO8u9ycDlRxMWekzJxNAvLEgcEk6xVh14cO+xesigeXcOJhfi8hlsz+C+tB//f6bLBojKD5sUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2421
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTYgQXByaWwgMjAyMCAwOTowNywgTGVlIEpvbmVzIHdyb3RlOg0KDQo+IE9uIE1vbiwgMDYg
QXByIDIwMjAsIEFkYW0gVGhvbXNvbiB3cm90ZToNCj4gDQo+ID4gVGhpcyB1cGRhdGUgYWRkcyBu
ZXcgcmVnbWFwIHRhYmxlcyB0byBzdXBwb3J0IHRoZSBsYXRlc3QgREEgc2lsaWNvbg0KPiA+IHdo
aWNoIHdpbGwgYXV0b21hdGljYWxseSBiZSBzZWxlY3RlZCBiYXNlZCBvbiB0aGUgY2hpcCBhbmQg
dmFyaWFudA0KPiA+IGluZm9ybWF0aW9uIHJlYWQgZnJvbSB0aGUgZGV2aWNlLg0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogQWRhbSBUaG9tc29uIDxBZGFtLlRob21zb24uT3BlbnNvdXJjZUBkaWFz
ZW1pLmNvbT4NCj4gPiBBY2tlZC1mb3ItTUZELWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL21mZC9kYTkwNjMtaTJjLmMgICAgICAgIHwg
OTENCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0NCj4gPiAgaW5j
bHVkZS9saW51eC9tZmQvZGE5MDYzL2NvcmUuaCB8ICAxICsNCj4gPiAgMiBmaWxlcyBjaGFuZ2Vk
LCA4MiBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4gDQo+IENhbiB0aGlzIHBhdGNo
IGJlIGFwcGxpZWQgb24gaXRzIG93bj8NCg0KU2FkbHkgbm90LiBSZWxpZXMgb24gYSBuZXcgc3dp
dGNoIHN0YXRlbWVudCBhZGRlZCBieSB0aGUgZmlyc3QgcGF0Y2guDQo=
