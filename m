Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C9CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 09:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6624D20758
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 09:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="eXOPx3Ux";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="eXOPx3Ux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgGMJ1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 05:27:20 -0400
Received: from mail-eopbgr50080.outbound.protection.outlook.com ([40.107.5.80]:36071
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726380AbgGMJ1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 05:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktqyTXTQ8slB1nPqGv58oq5YK53EK1LDit7WFJXoLGE=;
 b=eXOPx3UxjXiGI/wV4JOHl1HP9V1l743uvUSJO5s5Ca9J6yyxff5iKsXgUzj8yO9cryIzfyD62ft6KdemFlNEkzaMphAF2pA0fnnLgO9OIJPFavOBWh7q3uteXKX6OkoE3Q9uO1Vhd1aoyCvIqnHEa/5vUbAHCHtgUJFl0Z+nbaY=
Received: from AM6P195CA0045.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:87::22)
 by AM5PR0801MB1668.eurprd08.prod.outlook.com (2603:10a6:203:3c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Mon, 13 Jul
 2020 09:27:15 +0000
Received: from VE1EUR03FT019.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:87:cafe::49) by AM6P195CA0045.outlook.office365.com
 (2603:10a6:209:87::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend
 Transport; Mon, 13 Jul 2020 09:27:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT019.mail.protection.outlook.com (10.152.18.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21 via Frontend Transport; Mon, 13 Jul 2020 09:27:15 +0000
Received: ("Tessian outbound 8f45de5545d6:v62"); Mon, 13 Jul 2020 09:27:15 +0000
X-CR-MTA-TID: 64aa7808
Received: from ca9a6465f8ba.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id BE0D2469-719F-4932-8D30-0C64809EFF17.1;
        Mon, 13 Jul 2020 09:27:10 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ca9a6465f8ba.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 13 Jul 2020 09:27:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHtsIA53CcbFp6YvtXt7Ier3uynoQuljlFdA6m/tnDWZ3c9ZZJk/EP0pw29cXRvM50KkxWnriZOHjgsowzCYjk8GFBMVkOfkxHBmXrKG5HgF5xWutOskmjlp/MxuNyo0ZYq9LQwMn9pocaUl4cWfzGZ0NUIPDFXm67qcMMxctDOb4NE2Y2H+zEDJWi7GLdPpWedFYraqCI2++0r5zHLAKxt/JiHPYn6iNPGd8N0w3B10YP6iJ2cgvU9ZaRRmjw8726PF4AAQvAJZKRKs+DqYm0flZ/GKYpb6OeRbyRd7WoCNFG+gEovaURuNkHrCB3Oq30HELGhsK47C8DRKUhi9KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktqyTXTQ8slB1nPqGv58oq5YK53EK1LDit7WFJXoLGE=;
 b=j+96OX3TJCb5DtvQrslf9mH/1otpqH3+h52DRL6GkfIDLN3GRyW5k4q5xqr3acAd/jVhvZ59FkMuLO1y0dwhlmdHqs0fZl0PNi/iuGnh3+c2plPmJ499fmXxlJaIlT0T69cJTn1BLrNWqiK9LeAnIDF2DJ285C5pc1lNfbNe54gU+xEpLeJtZDz2UYL5UFWpGkRVZIbgipEyhL+1k3gXK2j4YH8BzabnTVEdLYNNODYyTRRKwtdU/s3kBjtmhGWd058bIDX0z38xsxmXSvtuWIYchnr3F4dfRToA6Zkdf+9qHjcLc+G34QUJSJHAyXVB/KyPCwCJWYw904I/fV7Sfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktqyTXTQ8slB1nPqGv58oq5YK53EK1LDit7WFJXoLGE=;
 b=eXOPx3UxjXiGI/wV4JOHl1HP9V1l743uvUSJO5s5Ca9J6yyxff5iKsXgUzj8yO9cryIzfyD62ft6KdemFlNEkzaMphAF2pA0fnnLgO9OIJPFavOBWh7q3uteXKX6OkoE3Q9uO1Vhd1aoyCvIqnHEa/5vUbAHCHtgUJFl0Z+nbaY=
Received: from HE1PR0802MB2555.eurprd08.prod.outlook.com (2603:10a6:3:e0::7)
 by HE1PR0802MB2154.eurprd08.prod.outlook.com (2603:10a6:3:c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Mon, 13 Jul
 2020 09:27:08 +0000
Received: from HE1PR0802MB2555.eurprd08.prod.outlook.com
 ([fe80::9:c111:edc1:d65a]) by HE1PR0802MB2555.eurprd08.prod.outlook.com
 ([fe80::9:c111:edc1:d65a%6]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 09:27:07 +0000
From:   Jianyong Wu <Jianyong.Wu@arm.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
CC:     "ericvh@gmail.com" <ericvh@gmail.com>,
        "lucho@ionkov.net" <lucho@ionkov.net>,
        "v9fs-developer@lists.sourceforge.net" 
        <v9fs-developer@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Steve Capper <Steve.Capper@arm.com>,
        Kaly Xin <Kaly.Xin@arm.com>, Justin He <Justin.He@arm.com>,
        Wei Chen <Wei.Chen@arm.com>
Subject: RE: [PATCH v4] 9p: retrieve fid from file when file instance exist.
Thread-Topic: [PATCH v4] 9p: retrieve fid from file when file instance exist.
Thread-Index: AQHWVqNFh0jRTickF0iry5ExQ23IOakAp7MAgASadZA=
Date:   Mon, 13 Jul 2020 09:27:07 +0000
Message-ID: <HE1PR0802MB2555EB19FCA15EB3B14F50BAF4600@HE1PR0802MB2555.eurprd08.prod.outlook.com>
References: <20200710101548.10108-1-jianyong.wu@arm.com>
 <20200710110850.GB17924@nautica>
In-Reply-To: <20200710110850.GB17924@nautica>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: ed950a98-65a4-48ea-b8a2-67be0068ed30.1
x-checkrecipientchecked: true
Authentication-Results-Original: codewreck.org; dkim=none (message not signed)
 header.d=none;codewreck.org; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.111]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 43ba1fa3-e4fa-4dcc-861f-08d8270eee63
x-ms-traffictypediagnostic: HE1PR0802MB2154:|AM5PR0801MB1668:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1668C022C057B274E1268093F4600@AM5PR0801MB1668.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: sWixdSRwC2vlRWP3n9KXJ36OC0BupltgW56xYa7moOqg4IuMyzEXUfUt7gygJqib7LJLBb7QHPoKsDH0yf79SMPDGC9Y97050kRZP6H292Biip4duPu5QxN5jyXpKjhXS7/qRwo4/Nckb3FejetdsooRcL4Wb9dOvKiAkHXQOcVrtmwp/A25uzG3OGcuHDFQmQegUaTepNaUF5lJRWWkLwGbT6l2Kt3tXr5GEIJ7vmtjFyD41PxCh5Zzq0kXov+oCBebE/G7axCzFO8FLhgXAgKx1Y4aFaYYWWJKvS7kI2Vyt7QKewZsiSVvWUBe/1rPQqmOF3Q76cCgPsZSzA9bEA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2555.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(8936002)(54906003)(66556008)(66946007)(66476007)(66446008)(64756008)(86362001)(316002)(5660300002)(8676002)(6916009)(83380400001)(55016002)(71200400001)(9686003)(76116006)(26005)(7696005)(33656002)(6506007)(2906002)(52536014)(4326008)(53546011)(478600001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 7vVg3S1GIjzDIkpmSs0ABzDsCg+byRHRkYjL1rwXgteixAVIi0Wz4fBx+6WgLrhxo92sF+wYidYJXjQvQU87ZKHp2SPJKRHhqp4i2UM28uvJ5oPNyKi1hlJBHJ3KilaOei87P2zzsbqxJLhfay0fZ7pli3pE5ZRvUfjHwJSBzjimGas24PIRmvp6RAehzZ7zum2yOhz5axVOc/mRPQwABgm+WNlRwr6Yv2bmwgCV59J30J/elC+W0upVD1LK4dBEIv38YNSOuV71xz+1fCvavUBD5HnRwDlyWL234PKfDF0O7Qf4cNDoJYhCm7CTpjoNlsvnjpLrkpVR4pBfUDub2/FTQDrf7gN/47YAqxrh6qVypqfcNWMRCao7N23nTHQ20jXI7QMF9cyV9xpiL15YtUAd1Gp+gXeG0VZcUzMQpcuCHiKt+PjujHZmF5J0LH3fNaaA5EZ9cnI5ah2Zq6H3gzk8koSgUdbBjcihqd4ceGs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2154
Original-Authentication-Results: codewreck.org; dkim=none (message not signed)
 header.d=none;codewreck.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT019.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(46966005)(83380400001)(70206006)(81166007)(33656002)(54906003)(26005)(70586007)(336012)(47076004)(6862004)(6506007)(52536014)(53546011)(7696005)(55016002)(478600001)(316002)(8676002)(82310400002)(8936002)(356005)(4326008)(86362001)(5660300002)(2906002)(82740400003)(36906005)(9686003)(186003);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6c653939-e617-41d4-a0c6-08d8270ee9e0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S2/C4gnVbpCGTPDvSZA7fNcUD/utKP55rS8pRu6jbDkRlL7Z8QcoL72Rhgc/SHADVccsQ2TehPf63yRCIRuB38pH9b3ugBPZU3AATNHrV77yRtDq8BUXywd17D3DIhbuVofKfrmvcJXhnbPAsovvsndP5M077aDyfwtTQinAva7iFMb4w6GjWp/ZXT2O+QvPBuH/sUkqyg8VaxXALn4/qUquTQO4EojLimqSNKs8bK/M/TqTpLEs+knoxJ8KkUpKdqvI9P8kurdfC4lodcYQFBqvPXjQggiluvazzdn+vwck+BcOijeSApqBW2/bg6cZZvflJT5NXSAR90+PSf2QZE3jY/W+D52TaHxWG6aCthbUNKWReBtNowClyARDYt5a2MUnaTRLxvc/ERkxcSo+Iw==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 09:27:15.4330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ba1fa3-e4fa-4dcc-861f-08d8270eee63
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT019.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1668
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRG9taW5pcXVlIE1hcnRp
bmV0IDxhc21hZGV1c0Bjb2Rld3JlY2sub3JnPg0KPiBTZW50OiBGcmlkYXksIEp1bHkgMTAsIDIw
MjAgNzowOSBQTQ0KPiBUbzogSmlhbnlvbmcgV3UgPEppYW55b25nLld1QGFybS5jb20+DQo+IENj
OiBlcmljdmhAZ21haWwuY29tOyBsdWNob0Bpb25rb3YubmV0OyB2OWZzLQ0KPiBkZXZlbG9wZXJA
bGlzdHMuc291cmNlZm9yZ2UubmV0OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBTdGV2
ZQ0KPiBDYXBwZXIgPFN0ZXZlLkNhcHBlckBhcm0uY29tPjsgS2FseSBYaW4gPEthbHkuWGluQGFy
bS5jb20+OyBKdXN0aW4gSGUNCj4gPEp1c3Rpbi5IZUBhcm0uY29tPjsgV2VpIENoZW4gPFdlaS5D
aGVuQGFybS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjRdIDlwOiByZXRyaWV2ZSBmaWQg
ZnJvbSBmaWxlIHdoZW4gZmlsZSBpbnN0YW5jZSBleGlzdC4NCj4NCj4gSmlhbnlvbmcgV3Ugd3Jv
dGUgb24gRnJpLCBKdWwgMTAsIDIwMjA6DQo+ID4gSW4gdGhlIGN1cnJlbnQgc2V0YXR0ciBpbXBs
ZW1lbnRhdGlvbiBpbiA5cCwgZmlkIGlzIGFsd2F5cyByZXRyaWV2ZWQNCj4gPiBmcm9tIGRlbnRy
eSBubyBtYXR0ZXIgZmlsZSBpbnN0YW5jZSBleGlzdHMgb3Igbm90LiBJZiBzbywgdGhlcmUgbWF5
IGJlDQo+ID4gc29tZSBpbmZvIHJlbGF0ZWQgdG8gb3BlbmVkIGZpbGUgaW5zdGFuY2UgZHJvcHBl
ZC4gU28gaXQncyBiZXR0ZXIgdG8NCj4gPiByZXRyaWV2ZSBmaWQgZnJvbSBmaWxlIGluc3RhbmNl
IHdoZW4gaXQgaXMgcGFzc2VkIHRvIHNldGF0dHIuDQo+ID4NCj4gPiBmb3IgZXhhbXBsZToNCj4g
PiBmZD1vcGVuKCJ0bXAiLCBPX1JEV1IpOw0KPiA+IGZ0cnVuY2F0ZShmZCwgMTApOw0KPiA+DQo+
ID4gVGhlIGZpbGUgY29udGV4dCByZWxhdGVkIHdpdGggdGhlIGZkIHdpbGwgYmUgbG9zdCBhcyBm
aWQgaXMgYWx3YXlzDQo+ID4gcmV0cmlldmVkIGZyb20gZGVudHJ5LCB0aGVuIHRoZSBiYWNrZW5k
IGNhbid0IGdldCB0aGUgaW5mbyBvZiBmaWxlDQo+ID4gY29udGV4dC4gSXQgaXMgYWdhaW5zdCB0
aGUgb3JpZ2luYWwgaW50ZW50aW9uIG9mIHVzZXIgYW5kIG1heSBsZWFkIHRvDQo+ID4gYnVnLg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmlhbnlvbmcgV3UgPGppYW55b25nLnd1QGFybS5jb20+
DQo+ID4gLS0tDQo+DQo+DQo+IEZvciBuZXh0IHRpbWUsIHlvdSBjYW4gYWRkIGFyYml0cmFyeSBj
b21tZW50cyAoZS5nLiBkZXNjcmliZSBicmllZmx5DQo+IGRpZmZlcmVuY2VzIGZyb20gcHJldmlv
dXMgdmVyc2lvbnMpIGFmdGVyIHRoZSAtLS0gbGluZS4NCj4NCj4gRm9yIG90aGVycywgdGhpcyBp
bml0cyBmaWQgdG8gTlVMTCBpbiBib3RoIGZ1bmN0aW9uczsgdGhhbmtzIGZvciBwaWNraW5nIGl0
IHVwIEknbGwNCj4gcmVmcmVzaCB0aGUgcGF0Y2guDQo+DQpPaywNCg0KVGhhbmtzDQpKaWFueW9u
Zw0KPiAtLQ0KPiBEb21pbmlxdWUNCklNUE9SVEFOVCBOT1RJQ0U6IFRoZSBjb250ZW50cyBvZiB0
aGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgYXJlIGNvbmZpZGVudGlhbCBhbmQgbWF5IGFs
c28gYmUgcHJpdmlsZWdlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwg
cGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGFuZCBkbyBub3QgZGlzY2xvc2Ug
dGhlIGNvbnRlbnRzIHRvIGFueSBvdGhlciBwZXJzb24sIHVzZSBpdCBmb3IgYW55IHB1cnBvc2Us
IG9yIHN0b3JlIG9yIGNvcHkgdGhlIGluZm9ybWF0aW9uIGluIGFueSBtZWRpdW0uIFRoYW5rIHlv
dS4NCg==
