Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E060C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2B38206C9
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="SHaJDFwy";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="WQjjKh29"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgIIJDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 05:03:17 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:2358 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726605AbgIIJDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 05:03:14 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08991P0w000533;
        Wed, 9 Sep 2020 02:03:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0220;
 bh=/JIqeIMliPpLI7MXfGCJv+nmaDcf2OutKVubInCaDQk=;
 b=SHaJDFwya6Lk5EXeDyD2FScojOkgeSxF85GFLIOe2uHga54xEJA26qcaG0AU/n4ogn1I
 OERJNbp/iPIpDquccZJgDQ14lGE6Fvh9pwzEepgOIVjM/R4zWLA8PfGuMmqDezlK2R2I
 ujLoP7ngV+yp0WKXHMntZg+NQkygw2uTszXUUQP4LmwOpm+FsmKE/mdOuLTZPxKc3xje
 TkpgEB7iqtDEL78GeIZOz3etl6TPNHvNzA+kyP7bM0imLy4bxYVFJ9CJgQWp7snYF8RL
 9wG2bqKDGqX/xQTwp6189ucQzLFUqYbXcxO1Sn2vRZ79PsFctLi5pYtIaJkhRPaV+UDW 3w== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 33c81py38h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 02:03:11 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 9 Sep
 2020 02:03:10 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 9 Sep 2020 02:03:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndvPO7ugEb6MB3G7TiciLwUM7KpirrhUUia1/91nHor0fwtQaucqRJPzOvZItEe+EhFJRdIqfi/V/TSLsTBgAN1IXna7vDAyQWaIvICB2n8ZJRITVhafSdT8T5y29kTN0F1MYx2e3GSppvyaK49I/qOXorRNcY+VFdFZ1owMV6fE4bePnDyBmsFaGC3mLQCftprGR5TIzBmL81dfgqp987DlqsA1rdccrIU+2n+AhEy1Ue1P2jpe4xc5FFfVSJsqUKX+FL3XWt9+hULZOmznVql/yFbjqggnzaGaThTqbL4otq78dAf1Oz9yglVAzscdfdvTB1Cs3YCyT/MUfJ/j4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JIqeIMliPpLI7MXfGCJv+nmaDcf2OutKVubInCaDQk=;
 b=LKqUEjAbyELVU/HDGH39a0h6PHRXdtBnFyygwdvhqBE1ReUBHh4QHckkempo1GO+NACpU7Kncxa7VSRdu1xZF542GlAuvGPZey59PEX3FXF7oLjoHCZd4mi04KBY6uJ6DWkVn9h0UaH845QKgbSXILZiBMrz6v1ozA08sUsQmSZDz6Fu3zOSa0whSZ8gg0clLRqqBPQS87id0aXkez39EeFATOu5xpbLG9R81Ol/Grt6j4WGYVz6B1hb9Cl3qlkrzFayfV6jX5CCUOnuG/mUpzi9nUooNMk9ASYPz1JoIMA+6Bure/Q/czcFEbSyoVT89GRknVvqmuJshTjDelfoYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JIqeIMliPpLI7MXfGCJv+nmaDcf2OutKVubInCaDQk=;
 b=WQjjKh2927XgrrUiODLNVF+ua+Epm4bzacsBtIP5Td83rE68PXAX3MyGcmVVkpZvRQQ4QfBGr8krNpqbZCKsypjtkzo7h9xHigDGE2dkD8F9/VCmYlhyhRIMlHcGChHZclHUZEVjQtzAvKo/xfNBA30+/HZhk7RU1i79V1iD3D8=
Received: from DM6PR18MB3052.namprd18.prod.outlook.com (2603:10b6:5:167::19)
 by DM6PR18MB3131.namprd18.prod.outlook.com (2603:10b6:5:1c1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.18; Wed, 9 Sep
 2020 09:03:08 +0000
Received: from DM6PR18MB3052.namprd18.prod.outlook.com
 ([fe80::905a:ebb4:369c:ae1b]) by DM6PR18MB3052.namprd18.prod.outlook.com
 ([fe80::905a:ebb4:369c:ae1b%7]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 09:03:08 +0000
From:   Nilesh Javali <njavali@marvell.com>
To:     Igor Russkikh <irusskikh@marvell.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-spdx@vger.kernel.org" <linux-spdx@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] [PATCH 0/5 REBASED to v5.9-rc4] Qlogic drivers: Convert to
 SPDX license identifiers
Thread-Topic: [EXT] [PATCH 0/5 REBASED to v5.9-rc4] Qlogic drivers: Convert to
 SPDX license identifiers
Thread-Index: AQHWhn6QL3LPlNANDEaj6Qg9hD4b46lgAk3Q
Date:   Wed, 9 Sep 2020 09:03:08 +0000
Message-ID: <DM6PR18MB305266178BB9982CBDF05319AF260@DM6PR18MB3052.namprd18.prod.outlook.com>
References: <20200908123451.7215-1-lukas.bulwahn@gmail.com>
 <e5688d4c-f512-6705-6bb1-db832828fb35@marvell.com>
In-Reply-To: <e5688d4c-f512-6705-6bb1-db832828fb35@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [117.220.251.152]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ca57eff-70a0-4234-646d-08d8549f2bad
x-ms-traffictypediagnostic: DM6PR18MB3131:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR18MB3131DD8E854F20BC686588C6AF260@DM6PR18MB3131.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OJR2kr3aK8BEJOW+HC+Xp3SSEYJde+C/foGlEJ3/+X2ZJxsraYsohR3q17AbGQKrPUPbAg+H6+GZCmFDgCqUD3mSUeaW5Ul0h+V6nAgy9guImHiH08+oh/jAK6TxAjVoVMlU9ERZOR2EdoO60N1RBcAisoagTB/wA4cOm6RrMoC09Hae66Mgjm76Q3Zk+5rDINFHrHEgyREAiyMXsQwaD40nEjAa8CUpgx0nHrqg3Yv2/hxkIlJ7mSeUVc9xboNsR6SRB8wnRj7yd0nHa2O3QhS09Vl5nriefiovWyH5L95LQYgeoaLGfJwPIz1z0LHXpvCdjEM2XV3myncKAEu2xQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR18MB3052.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(8676002)(55016002)(2906002)(110136005)(83380400001)(4326008)(9686003)(71200400001)(4744005)(33656002)(64756008)(66446008)(66476007)(66556008)(76116006)(8936002)(66946007)(478600001)(6506007)(186003)(7696005)(5660300002)(316002)(53546011)(52536014)(86362001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Y69SUTcdgNPWbNZ6xwpBb/t4w8fWTTRbAxi4SPhbKjGx7I6uy+WqJaP4HNSOhMs2wF97Q1iGYyxbDjYVNLRZmfHpx8T7JCrflfI6ZNG6LYPaEvKC0eFXyCoJVophb2riEA+k8gKbeql6Kn4UY4lOzrc2suDFz9T5N5NLbqC5LQMAJ6LO2YV2wU73kHs+XvSeMgPAEHy8OUFflzHb+ZbDL1GBin3izmKVWbD85RGaa6hBYmCuYuQIJp86PR3zjuoqgsuOP6k304GnMp2lAKELbJu9Qh6JYIq11f2NufWTYEoYDL9Bvc+waYHz1IRMFv32BO+4pkitnZtoebYajqS2DLZgZTseZCdmPA20SkYWtTuqP5sGUJv62uZxfshdzT96isHqc0t/dtGN2g/6Ty5hl4DexSvLrcBspbZzvoW/LekcP/q9ZyCdp91XC8u+Nuqn2S4YUemd8JVd3GIQQY39l0FH8AhdR10YPVIkh4FFUVjRgQF3jD+kVuAL6OXsNi3wUXbe4i9Zhi2E4TOQJ4N+o3ykqO6pQ3Q9CzTGjqrXJxw9QOulRYB3JUF95uFkZ7lpUmppWT6akjqpFNY0a/kVUdpPxQzUlxNmEoj/TaMAp33Tx78THD4ymUw92rvZC7uymM0ZEyVu2AZoH0Nug9XyDw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR18MB3052.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca57eff-70a0-4234-646d-08d8549f2bad
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2020 09:03:08.1842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jaUMjU6GsnonaO6xj/j5Hv7w1zhMH2MP/DJstfSBkttH4+91/A5ak5Gh0lZec+ZVRGMBiC9qcsXHzGokme2I/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3131
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-09_03:2020-09-08,2020-09-09 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

THVrYXMsDQoNCkkgaGF2ZSBBY2tlZCBmb3IgdGhlIHN0b3JhZ2UgZHJpdmVycyBhbmQgb3B0IGZv
ciBvcHRpb24gQiBiZWxvdyBmb3Igc3BkeCBtYWludGFpbmVycyB0byBwaWNrLg0KDQpUaGFua3Ms
DQpOaWxlc2gNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJZ29yIFJ1
c3NraWtoIDxpcnVzc2tpa2hAbWFydmVsbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgU2VwdGVt
YmVyIDksIDIwMjAgMToyNSBQTQ0KPiBUbzogTHVrYXMgQnVsd2FobiA8bHVrYXMuYnVsd2FobkBn
bWFpbC5jb20+OyBUaG9tYXMgR2xlaXhuZXINCj4gPHRnbHhAbGludXRyb25peC5kZT47IGxpbnV4
LXNwZHhAdmdlci5rZXJuZWwub3JnDQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBOaWxlc2ggSmF2YWxpIDxuamF2YWxpQG1hcnZlbGwuY29tPg0KPiBTdWJqZWN0OiBSZTogW0VY
VF0gW1BBVENIIDAvNSBSRUJBU0VEIHRvIHY1LjktcmM0XSBRbG9naWMgZHJpdmVyczogQ29udmVy
dCB0bw0KPiBTUERYIGxpY2Vuc2UgaWRlbnRpZmllcnMNCj4gDQo+IA0KPiANCj4gPiBJZ29yLCBj
YW4geW91IHBsZWFzZSBhY2sgdGhlc2UgcGF0Y2hlcz8NCj4gPg0KPiA+IElnb3IsIHBsZWFzZSBh
bHNvIGxldCB1cyBrbm93Og0KPiA+ICAgQS4gaWYgeW91IHdpbGwgcGljayB0aGVtIHVwIGFuZCBs
ZXQgdGhlbSB0cmF2ZWwgdGhyb3VnaCB5b3VyIHRyZWUsIG9yDQo+ID4gICBCLiBpZiB0aGUgc3Bk
eCBtYWludGFpbmVycyBzaGFsbCBwaWNrIHRoZW0gdXAgYW5kIHRoZXkgc2hhbGwgcm91dGUgdGhl
bQ0KPiA+ICAgICAgZGlyZWN0bHkgdG8gTGludXMuDQo+IA0KPiBUaGFua3MgTHVrYXMsDQo+IA0K
PiBBY2tlZCBvbiBldGhlcm5ldCBkcml2ZXIgcGF0Y2hlcy4gRm9yIHN0b3JhZ2UgZHJpdmVycyBJ
IGJlbGlldmUgeW91J2xsIGhhdmUNCj4gQUNLIGZyb20gTmlsZXNoLg0KPiANCj4gV2UgZG9uJ3Qg
bWFuYWdlIG91ciBvd24gdHJlZSwgd2Ugbm9ybWFsbHkgZG8gZGlyZWN0bHkgb24gbmV0ZGV2IGxp
c3QuDQo+IFRodXMgSSB0aGluayBpdHMgc2FmZSB0byBnbyB3aXRoIChCKSBhbmQgZG8gdGhpcyB0
aHJvdWdoIHNwZHggdHJlZS4NCj4gDQo+IFJlZ2FyZHMsDQo+ICAgSWdvcg0K
