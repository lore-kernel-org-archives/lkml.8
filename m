Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA8BC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F275A20729
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="igf4iLXw";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="igf4iLXw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbgGUKDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 06:03:43 -0400
Received: from mail-eopbgr80088.outbound.protection.outlook.com ([40.107.8.88]:34433
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729102AbgGUKDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 06:03:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ai0ey2mHfLjQfUqBOluMkvMKLAwoke6W22MKuXHDOYU=;
 b=igf4iLXwjAHXkgyTwVkNdV8ypcf26UYmESybooSB/UhFp8XJLztPvYazHLeYmIeDIw0Iaoa7yU4H9odaf5sA0fFiHyo08YIewFicbvX2gZo/nQZcbccgyT41z6EYUXMdjCIgrCvjH3q9t6rn68kiFCzLkmiP3yK5THEBOj2lzx4=
Received: from MRXP264CA0039.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:14::27)
 by DB7PR08MB3434.eurprd08.prod.outlook.com (2603:10a6:10:42::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18; Tue, 21 Jul
 2020 10:03:32 +0000
Received: from VE1EUR03FT013.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:500:14:cafe::1e) by MRXP264CA0039.outlook.office365.com
 (2603:10a6:500:14::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend
 Transport; Tue, 21 Jul 2020 10:03:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT013.mail.protection.outlook.com (10.152.19.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.18 via Frontend Transport; Tue, 21 Jul 2020 10:03:32 +0000
Received: ("Tessian outbound 7de93d801f24:v62"); Tue, 21 Jul 2020 10:03:31 +0000
X-CR-MTA-TID: 64aa7808
Received: from ea91dfd565cb.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 6FF2EB22-C626-4A05-A06D-817920D350B2.1;
        Tue, 21 Jul 2020 10:03:26 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ea91dfd565cb.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 21 Jul 2020 10:03:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VsQfnNkY5/ZD0BEtfUkIVAt511x/F/BfjfazSo22zkrDBLa7kSQu2RNLDZprw1IC2fIZy0RZFI1lKX/rlMSHdIm4VjCbd3oJCbaBVU8Eq7YOouZziR/gxlhZh2Gu4MZzEdyGlJX8HKvKRaF0SvLpjt/X2Z/wBM2Va9k1t44ku20PUjsgi9oF/JWVbmTf5iUo8THytS8dMnF7qmp0+coStdxleHT0/vE8heIw6C9/p7zbhEFlv0GBmNM9vIWZG0dt7YKkLBJHOp2w7EUxTXfN6yL3aiOHK0/EpVmUBX8AOUD7+/yeDyZadknLkYvO8fDjTtdvTSrBeOLmh9kJRVin5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ai0ey2mHfLjQfUqBOluMkvMKLAwoke6W22MKuXHDOYU=;
 b=H0BvvWWORVFCUFbRMWIdU1mjJXVv14XHlhzVYR6CpXQKl8W8z+9dMz/QEnvRkIG+BilktCKHYnNzG1lgirUu0x7ej6g1DRIE4Z10BscR9hBMBblth8XzBjS6Sl68xzU1i0yprdQrDE5Onjdt80ABCnsaboP0gXlq54VSOrYb05qIMn4bGa0w87DUYiJaL0/Glj7UVbnmyEzkpCpO1TFA/rUTU88azIMPhTY36glUzF+lph6+o1UnXqUqzux8p5GOCHWkGKjvVtv+840yrz4b3GxgeXLGya9/utRr+20Rf1BRxR2zuA75oJNBEH6ETIKIx+BuPk9lfZKbu6hvWrIX4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ai0ey2mHfLjQfUqBOluMkvMKLAwoke6W22MKuXHDOYU=;
 b=igf4iLXwjAHXkgyTwVkNdV8ypcf26UYmESybooSB/UhFp8XJLztPvYazHLeYmIeDIw0Iaoa7yU4H9odaf5sA0fFiHyo08YIewFicbvX2gZo/nQZcbccgyT41z6EYUXMdjCIgrCvjH3q9t6rn68kiFCzLkmiP3yK5THEBOj2lzx4=
Received: from HE1PR0802MB2555.eurprd08.prod.outlook.com (2603:10a6:3:e0::7)
 by HE1PR0801MB1833.eurprd08.prod.outlook.com (2603:10a6:3:80::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Tue, 21 Jul
 2020 10:03:24 +0000
Received: from HE1PR0802MB2555.eurprd08.prod.outlook.com
 ([fe80::9:c111:edc1:d65a]) by HE1PR0802MB2555.eurprd08.prod.outlook.com
 ([fe80::9:c111:edc1:d65a%6]) with mapi id 15.20.3195.026; Tue, 21 Jul 2020
 10:03:24 +0000
From:   Jianyong Wu <Jianyong.Wu@arm.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
CC:     "ericvh@gmail.com" <ericvh@gmail.com>, "hch@lst.de" <hch@lst.de>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "lucho@ionkov.net" <lucho@ionkov.net>,
        "v9fs-developer@lists.sourceforge.net" 
        <v9fs-developer@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kaly Xin <Kaly.Xin@arm.com>, Justin He <Justin.He@arm.com>,
        Wei Chen <Wei.Chen@arm.com>
Subject: RE: [RFC PATCH 1/2] vfs: pass file down when getattr to avoid losing
 info.
Thread-Topic: [RFC PATCH 1/2] vfs: pass file down when getattr to avoid losing
 info.
Thread-Index: AQHWXjeiNMxBqXo7yk2X9SbcHqU0bakQjqwAgAE4FHA=
Date:   Tue, 21 Jul 2020 10:03:23 +0000
Message-ID: <HE1PR0802MB2555AA0A535543B214155BE7F4780@HE1PR0802MB2555.eurprd08.prod.outlook.com>
References: <20200720014622.37364-1-jianyong.wu@arm.com>
 <20200720014622.37364-2-jianyong.wu@arm.com> <20200720145340.GA13275@nautica>
In-Reply-To: <20200720145340.GA13275@nautica>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 690fd59d-d198-432f-baef-9141a2033527.1
x-checkrecipientchecked: true
Authentication-Results-Original: codewreck.org; dkim=none (message not signed)
 header.d=none;codewreck.org; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.113]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fdef0d77-3b23-4850-26d8-08d82d5d5342
x-ms-traffictypediagnostic: HE1PR0801MB1833:|DB7PR08MB3434:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB7PR08MB34348874652456BBEA931A81F4780@DB7PR08MB3434.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 3xtN0brkvolQZCtBkC4SKfoVvX2KkrxpBUZ9aRcMUgrdfvjfdHZlFAVpM7AYwOmxej20efX3NEadMeI+uXJI7QrGFhufoIfFZiWcJSGgCExWHOYBuXIqdDVuP+HrCky34fjVDH9udlfxXRIuMqDZW2wChv5zAXGq8xjhGoTOTU1T85ESxsvafduGMPkkkfUxUbSr0+0CyAmPwFZgvz23DvQqxd+zEgvveVGGWU24ou8MkBI27P26RraH1oelBJC4rR4VZSqkTt0dcx+YLWij84LvLl2329GIF3IXneLWk2bJ6Y0orLs6TVfqHx+SOzEjyMY43tsgkwQmVM4cqEU4XKKSIw+W43Ljp5kV1n86Gc/GzGdO19zYiM4sQv3/lOp8eODoYY+2J4ChYd0yTfDpig==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2555.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(8936002)(966005)(2906002)(76116006)(66946007)(66476007)(66556008)(64756008)(66446008)(71200400001)(83380400001)(8676002)(6916009)(7696005)(316002)(54906003)(5660300002)(33656002)(55016002)(53546011)(6506007)(9686003)(478600001)(52536014)(86362001)(186003)(26005)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: fvioaT89p7hh7QLSOUSvW0wPh8oD1YKlet6tCDPc2BA5e+NfmWIGt2utj93zyHG4Pe056q0nZCIwxIT3AZmErCIlclqOD3frX4c7p9+V1Zee3xIzlJWKxd38pifUmQXOytrnWmTA0PgDIV5v/zyMyFQTIJAY9uxslwlXGsvFwFeQiATwqmdKm48Qb8+w+G+RQPmeEIabVN3sjMHZXVxNqdR+2i6oh4zCAUKMHFdp5GzF5fK5wirYCBAEqmeIUMzL+TgJ/N33u7AdfTrZw+KefHy4D2wXFbDF6JRr+4Cc8IB+Ip0FCPXs6SoMZq7pMInA530K8d8Y76qmSQvOQPt0/KMjkp6RoaZTi2Un1MKIa6nNX+IcyZ4slupUI3FgUAZXVlrV3W/5OEIzILK8ccTamrN/xcp8MhLaLFDNaBaKv8tZX6+D/YYX0dlUkAWUayrP4gl9QGUx44tAvXdSgsy28hwFrLz8gXfFnmvsG0ZOLvE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1833
Original-Authentication-Results: codewreck.org; dkim=none (message not signed)
 header.d=none;codewreck.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT013.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(396003)(39860400002)(346002)(46966005)(6862004)(52536014)(36906005)(82310400002)(2906002)(81166007)(356005)(9686003)(33656002)(86362001)(5660300002)(55016002)(8936002)(316002)(336012)(82740400003)(478600001)(53546011)(6506007)(966005)(7696005)(70586007)(26005)(8676002)(186003)(54906003)(47076004)(4326008)(83380400001)(70206006);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 12df63be-d024-46cc-2363-08d82d5d4e5e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xkWE36j0p5Zo+Bu2YpWHi/gbYUg/1rxSzmCR2UY3P9R9LdGuU+RUqp9qRc0zN1+r/eFy94+sWzXhsSlUKRCUd8I6GmgNNuVKRPuXcQmEci4yvWZAUu6M8c/A2b+hOFT5Ux1KvoYKbaXY1J4u0OKALb8+Esc4F1MXFZGN3PPlW/AMp+k3CUphxo7k+aUybw6/1OJiMvs+prmY4WUnS6H1X9WH2nOC3wFN8LJZLLGKhyb/F+TWvNz8PHNytA2IsnuEmOdraZos+tamIpeSIR/zqnmgpDZAmhSzA/DR9HzMnAZYoiKkw4Gb4qPpYTrbxRefVDm8zEYhYqInz/yukwluRQyF6AoyiW/oiAIymeqkJsmSu+LO6LTD10bAWe5JkGCW6VXTQxjhXrUPEoCESK+pJJIieTPY4thq0ayc22Bg7qZQIn+IqEVhFpAtktk66ROQX5ipsPcYBc7H+1rfwEVySWKoXotF4ZTjUSrYDbpLc5s=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2020 10:03:32.3528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdef0d77-3b23-4850-26d8-08d82d5d5342
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT013.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3434
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRG9taW5pcXVlIE1hcnRp
bmV0IDxhc21hZGV1c0Bjb2Rld3JlY2sub3JnPg0KPiBTZW50OiBNb25kYXksIEp1bHkgMjAsIDIw
MjAgMTA6NTQgUE0NCj4gVG86IEppYW55b25nIFd1IDxKaWFueW9uZy5XdUBhcm0uY29tPg0KPiBD
YzogZXJpY3ZoQGdtYWlsLmNvbTsgaGNoQGxzdC5kZTsgZGhvd2VsbHNAcmVkaGF0LmNvbTsNCj4g
bHVjaG9AaW9ua292Lm5ldDsgdjlmcy1kZXZlbG9wZXJAbGlzdHMuc291cmNlZm9yZ2UubmV0OyBs
aW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgS2FseSBYaW4gPEthbHkuWGluQGFybS5j
b20+OyBKdXN0aW4gSGUNCj4gPEp1c3Rpbi5IZUBhcm0uY29tPjsgV2VpIENoZW4gPFdlaS5DaGVu
QGFybS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIDEvMl0gdmZzOiBwYXNzIGZpbGUg
ZG93biB3aGVuIGdldGF0dHIgdG8gYXZvaWQgbG9zaW5nDQo+IGluZm8uDQo+DQo+IEppYW55b25n
IFd1IHdyb3RlIG9uIE1vbiwgSnVsIDIwLCAyMDIwOg0KPiA+IEN1cnJlbnRseSwgZ2V0dGluZyBh
dHRyaWJ1dGUgZm9yIGEgZmlsZSByZXByZXNlbnRlZCBieSBmZCBpcyBhbHdheXMgYnkNCj4gPiBp
bm9kZSBvciBwYXRoIHdoaWNoIG1heSBsZWFkIHRvIGJ1ZyBmb3IgYSBjZXJ0YWluIG5ldHdvcmsg
ZmlsZSBzeXN0ZW0uDQo+ID4gQWRkaW5nIGZpbGUgc3RydWN0IGludG8gc3RydWN0IGtzdGF0IGFu
ZCBhc3NpZ25pbmcgZmlsZSBmb3IgaXQgaW4NCj4gPiB2ZnNfc3RhdHhfZmQgY2FuIGF2b2lkIHRo
aXMgaXNzdWUuIFRoaXMgY2hhbmdlIHJlZmVycyB0byBzdHJ1Y3QgaXN0YXQuDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBKaWFueW9uZyBXdSA8amlhbnlvbmcud3VAYXJtLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgZnMvc3RhdC5jICAgICAgICAgICAgfCAxICsNCj4gPiAgaW5jbHVkZS9saW51eC9zdGF0
LmggfCA2ICsrKysrKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2ZzL3N0YXQuYyBiL2ZzL3N0YXQuYw0KPiA+IGluZGV4IDQ0Zjhh
ZDM0NmRiNC4uMGRlZTU0ODdmNmQ2IDEwMDY0NA0KPiA+IC0tLSBhL2ZzL3N0YXQuYw0KPiA+ICsr
KyBiL2ZzL3N0YXQuYw0KPiA+IEBAIC0xNDcsNiArMTQ3LDcgQEAgaW50IHZmc19zdGF0eF9mZCh1
bnNpZ25lZCBpbnQgZmQsIHN0cnVjdCBrc3RhdCAqc3RhdCwNCj4gPiAgcmV0dXJuIC1FSU5WQUw7
DQo+ID4NCj4gPiAgZiA9IGZkZ2V0X3JhdyhmZCk7DQo+ID4gK3N0YXQtPmZpbHAgPSBmLmZpbGU7
DQo+ID4gIGlmIChmLmZpbGUpIHsNCj4gPiAgZXJyb3IgPSB2ZnNfZ2V0YXR0cigmZi5maWxlLT5m
X3BhdGgsIHN0YXQsDQo+ID4gICAgICByZXF1ZXN0X21hc2ssIHF1ZXJ5X2ZsYWdzKTsNCj4gPiBk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zdGF0LmggYi9pbmNsdWRlL2xpbnV4L3N0YXQuaCBp
bmRleA0KPiA+IDU2NjE0YWY4M2Q0YS4uNDc1NWM1MjhkNDlhIDEwMDY0NA0KPiA+IC0tLSBhL2lu
Y2x1ZGUvbGludXgvc3RhdC5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9zdGF0LmgNCj4gPiBA
QCAtNDgsNiArNDgsMTIgQEAgc3RydWN0IGtzdGF0IHsNCj4gPiAgc3RydWN0IHRpbWVzcGVjNjQg
YnRpbWU7LyogRmlsZSBjcmVhdGlvbiB0aW1lDQo+ICovDQo+ID4gIHU2NGJsb2NrczsNCj4gPiAg
dTY0bW50X2lkOw0KPiA+ICsNCj4gPiArLyoNCj4gPiArICogTm90IGFuIGF0dHJpYnV0ZSwgYnV0
IGFuIGF1eGlsaWFyeSBpbmZvIGZvciBmaWxlc3lzdGVtcyB3YW50aW5nIHRvDQo+ID4gKyAqIGlt
cGxlbWVudCBhbiBmc3RhdCgpIGxpa2UgbWV0aG9kLg0KPiA+ICsgKi8NCj4gPiArc3RydWN0IGZp
bGUqZmlscDsNCj4NCj4gSnVzdCwgbm8gOyBkb24ndCB0b3VjaCB0aGlzLCBpdCBpc24ndCBsaWtl
bHkgdG8gZ2V0IGFjY2VwdGVkIGV2ZXIuDQo+IGZpbGUgb3BlcmF0aW9ucyBzaG91bGQgYWxsIGhh
dmUgYSBmaWxwIGFyb3VuZCBhbHJlYWR5LCB3ZSBuZWVkIHRvIGZpeCB0aGlzIGluIG91cg0KPiBj
b2RlLg0KPg0KT2ssIGJ1dCBJIHRoaW5rIGl0IG1heSBub3QgYmUgYW4gZWFzeSBqb2IgdG8gZml4
IGl0IGluc2lkZSA5cC4NCg0KPiAoYWxzbyBtaXNzaW5nIHF1aXRlIGEgZmV3IENjIGlmIHlvdSBl
dmVyIHdhbnQgdG8gdG91Y2ggdGhlc2UgYml0cywgYXQgbGVhc3QNCj4gbGludXgtZnNkZXZlbEAp
DQo+IHRoYW5rcy4gU2hvdWxkIGhhdmUgYWRkZWQgdGhlbS4NCj4NCj4NCj4gRldJVyB0aGUgcHJv
YmxlbSBoYXMgYmVlbiBkaXNjdXNzZWQgYSBmZXcgdGltZXMgcHJldmlvdXNseS4NCj4NCj4gSSdk
IGFwcHJlY2lhdGUgaWYgeW91IGNvdWxkIHRha2Ugb3ZlciBmcm9tIEVyaWMgYW5kIEdyZWcncyBv
bGQgc2VyaWVzIHRoYXQNCj4gaW50ZW5kZWQgdG8gZml4IHRoYXQ6DQo+IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2xrbWwvMTQ2NjU5ODMyNTU2LjE1NzgxLjE3NDE0ODA2OTc1NjQxNTE2NjgzLg0K
PiBzdGdpdEBiYWhpYS5sYW4vDQo+DQo+IGl0IGludHJvZHVjZWQgYSByYWNlIHNvbWV3aGVyZSwg
YnV0IHRoZSBpZGVhIGxvb2tlZCBnb29kIGF0IHRoZSB0aW1lIHNvIGl0J3MNCj4gd29ydGggbG9v
a2luZyBpbnRvLg0KDQpUaGFua3MsIEkgd2lsbCBsb29rIGludG8gaXQgdG8gZmluZCBzb21lIGlk
ZWFzLiBpZiBJIGNhbiBnZXQgdGhlIHNvbHV0aW9uLCBJIHdpbGwgYmUgYmFjay4NCg0KVGhhbmtz
DQpKaWFueW9uZw0KPg0KPiAtLQ0KPiBEb21pbmlxdWUNCklNUE9SVEFOVCBOT1RJQ0U6IFRoZSBj
b250ZW50cyBvZiB0aGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgYXJlIGNvbmZpZGVudGlh
bCBhbmQgbWF5IGFsc28gYmUgcHJpdmlsZWdlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVk
IHJlY2lwaWVudCwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGFuZCBkbyBu
b3QgZGlzY2xvc2UgdGhlIGNvbnRlbnRzIHRvIGFueSBvdGhlciBwZXJzb24sIHVzZSBpdCBmb3Ig
YW55IHB1cnBvc2UsIG9yIHN0b3JlIG9yIGNvcHkgdGhlIGluZm9ybWF0aW9uIGluIGFueSBtZWRp
dW0uIFRoYW5rIHlvdS4NCg==
