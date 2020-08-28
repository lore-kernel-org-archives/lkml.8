Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE0EC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 09:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6798920776
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 09:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="hcHzqWLn";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="hcHzqWLn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbgH1JAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 05:00:32 -0400
Received: from mail-eopbgr60046.outbound.protection.outlook.com ([40.107.6.46]:32432
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728455AbgH1JA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 05:00:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNV1EgqvxCXRb4M0w6/xbMizRHwLg/HT5zT/Qlt4zvg=;
 b=hcHzqWLnXzuan+uE8cI04STBUZSR58bGo6W47ngNy4ZlbLQgWzff+vP12j/thKLPshKDrQoY29NBq2Ogp2Rf/PAXdMH9sdwxYWtEqPUMYS8Y0uY6exIO+D/13wdUNjUUU0SrFptazm9BfihURXskvBcMgLIJbTWGFay93xvZVHA=
Received: from AM6PR10CA0059.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:80::36)
 by AM0PR08MB3780.eurprd08.prod.outlook.com (2603:10a6:208:10a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Fri, 28 Aug
 2020 09:00:23 +0000
Received: from AM5EUR03FT063.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:80:cafe::be) by AM6PR10CA0059.outlook.office365.com
 (2603:10a6:209:80::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Fri, 28 Aug 2020 09:00:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT063.mail.protection.outlook.com (10.152.16.226) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Fri, 28 Aug 2020 09:00:23 +0000
Received: ("Tessian outbound e8cdb8c6f386:v64"); Fri, 28 Aug 2020 09:00:23 +0000
X-CR-MTA-TID: 64aa7808
Received: from 271d4ba23c7d.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id B2C72757-E2B2-4F69-9F7A-6FAF324FB9B2.1;
        Fri, 28 Aug 2020 09:00:18 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 271d4ba23c7d.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 28 Aug 2020 09:00:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQepLLZD4xLtoGjIe+TNYG6/4lkmCnqiunK4lMCztDbYW785tkDOFej+pvB6+FP2/xTeFm6TLq/qQezjRT2v9o94y2LouL/9nveD0faCJsOPt15CH1iBnFebE4T7BJ3DSz3aGN1sGIsETrUMMSUUhTEJO2Zt9xtqsweJHCFAteK7h+y7amkSKq/pwTFfYYtSjy6T0/LaXF9LwMLkLa4np/quPj4aw3C7/2iw+NlGDtE4uhH63Hno+dSu3VL8K4XRhGcMr4RICyuwZx+BB7vwu5sl0uFzzNfvju5XVUmpBIyAIVtF/uDaSSpBSuMbCn8t8hTjSiXuSIy2STJ0Rqim6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNV1EgqvxCXRb4M0w6/xbMizRHwLg/HT5zT/Qlt4zvg=;
 b=PusyJdV+k0X2xUD3wgMfobXmq4AJm2fARR5201TS4rodSSN314vmICTm84GmfW6fyEi5CEA6IpGCA5WBhmUlAzpyHH4P/NtS8UuxLY9yvvpb9N9PnHglDzVFeRURpmYqI6o2VdWMj7fNoO8rG7Gd9Pmc5XkjK4BmLN6oLxQ6savPc7WJHpG3ITgMRnv3mAr4ocTrRZYy/AM1Wmndnfa9Bj6ZT93UCePOcoL9Yd1cghVkr54gQb5hr/1Ctm+tpD9JVWQW2B+OUohnZ+eJGx98BbJ0qvXBAlILz3sNcRmyFyTVrz30uqQdBUW03Um8YLJ6gq8Wcz9fopSM+UCxtctQyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNV1EgqvxCXRb4M0w6/xbMizRHwLg/HT5zT/Qlt4zvg=;
 b=hcHzqWLnXzuan+uE8cI04STBUZSR58bGo6W47ngNy4ZlbLQgWzff+vP12j/thKLPshKDrQoY29NBq2Ogp2Rf/PAXdMH9sdwxYWtEqPUMYS8Y0uY6exIO+D/13wdUNjUUU0SrFptazm9BfihURXskvBcMgLIJbTWGFay93xvZVHA=
Received: from DB7PR08MB3355.eurprd08.prod.outlook.com (2603:10a6:5:18::18) by
 DB6PR0802MB2246.eurprd08.prod.outlook.com (2603:10a6:4:86::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.26; Fri, 28 Aug 2020 09:00:17 +0000
Received: from DB7PR08MB3355.eurprd08.prod.outlook.com
 ([fe80::4939:f528:10d4:539c]) by DB7PR08MB3355.eurprd08.prod.outlook.com
 ([fe80::4939:f528:10d4:539c%2]) with mapi id 15.20.3326.023; Fri, 28 Aug 2020
 09:00:17 +0000
From:   Al Grant <Al.Grant@arm.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Qi Liu <liuqi115@huawei.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>
Subject: RE: [RFC PATCH v2] coresight: etm4x: Modify core-commit of cpu to
 avoid the overflow of HiSilicon ETM
Thread-Topic: [RFC PATCH v2] coresight: etm4x: Modify core-commit of cpu to
 avoid the overflow of HiSilicon ETM
Thread-Index: AQHWfLLppG26t7CXUUaoLKbWoN+liqlNLbqg
Date:   Fri, 28 Aug 2020 09:00:16 +0000
Message-ID: <DB7PR08MB3355B59AE058823AEE3B372E86520@DB7PR08MB3355.eurprd08.prod.outlook.com>
References: <1597824397-29894-1-git-send-email-liuqi115@huawei.com>
 <20200827204426.GD22307@xps15>
In-Reply-To: <20200827204426.GD22307@xps15>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 120E5C085748F242AAF919DF04ED6BD0.0
x-checkrecipientchecked: true
Authentication-Results-Original: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=arm.com;
x-originating-ip: [81.147.117.183]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9a9e1ef2-9b24-4458-03c9-08d84b30cc70
x-ms-traffictypediagnostic: DB6PR0802MB2246:|AM0PR08MB3780:
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
X-Microsoft-Antispam-PRVS: <AM0PR08MB3780559DC60E50272C53110D86520@AM0PR08MB3780.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: th/IouflloVmrD3BkOU05KccJWMnweZn1VluqCHb+ioEjjoTjZRdkeqXpVAeiGBDdjeasXezieR05Nfp5SpqsvlHZBqIUNfcbfCD5z7FwFZV/YIBJ0eO9Ln2TT5hha4orrQe6ixZ0Bc0USCdqr6aPDtrGwo9wOtNKUFO9hOmYMbvX7Sfu0ZM0o9XzvGc9OOuQSlhAIDPfY+chwAjwBtKo7GWlWeXJw0445eJ191aEiz3IGsU7dIbyw2aqzG4LlYkaNNEEdv5gpYtdnqY0vJYmBldVv1+iRxguCU/QyWtjiDkf3UL5z6stXk8I0SW39gdBDTNkLrVFRV2fk4RyUUWGYHCgRG34CT3O2jrtzQ0lWIMRr8nBav3EY7NmiEnCWJ5CTshnG4LUuWcTiirgXxgWUV3q3GA+UTKQJNn3J6qh+ZGUeULBbTI1rZSvEC8uRujop5STnKGbZDAs1ilZR/rOA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR08MB3355.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(6029001)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(66946007)(4326008)(26005)(55016002)(71200400001)(316002)(33656002)(86362001)(7696005)(83380400001)(186003)(6506007)(9686003)(66446008)(66476007)(966005)(54906003)(110136005)(64756008)(66556008)(76116006)(8936002)(478600001)(8676002)(52536014)(2906002)(5660300002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: EqTYwGyQU0lfYuEK4YhaJzT+aWetByufsYSCBSnWAjL/HLSTyxz7jUUJNgCYhgxioo0/y1OPX+Rco9fBmu+O0wlN9xI7qysL8FzlTYFU0EBIcdH3NdEM3OohA15PiU5tQ2HS1PHoBc10bRICloeBphsd1C4xSZNutakcsgkxlaSljmjlkQ+rgE0jaDvgEXX39F3BN9e+NT9MfQB1UuCreRxF6WGwst2Nyj2VfWqvqXcai/MhEcxmewCWBBrwXReLzLCoUq+PJKlkEZPihZpp/5FjYae/SJrnH+yr7R6ofUOoyH2+JDehK6Jw2sumGV1Qjq2SACsfv1tQYt45nw1t+8ujfO0NrXQs0VBLldw5lBNpetU2Sm61vH+7n7LmAT1KMK2NxJInuKuL1HtHCWPS+AU3MIZIRWB9VOiN5PBNBRuxcEz+24K4o/7+bwmHxIwVP3xi2tcpt7N4ERPmwg8lrcX/HPUblZFXzXuKQweM+4tq4C1wqdcLXr3fehqsClWy1VZZyv26WsGfGK8AqjuTEzYJ0fLLLpIpVdj86JEYw55rc3s3haYs9eYWobeMAFPpEa35e+d3SfiFSxH7xQtg5Ue/dsU5YjrzkKnGD0sOOyOmhpuaIgZDPlEvsOs0WhWzB3ew2Kce8O+HdNzmh+4ivA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2246
Original-Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT063.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0ef816b6-0139-4316-6b4f-08d84b30c8e6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ggd8SjdlBeXYgTJHJnUhy5rLTQmTrXJtu9yZoLTKlGM1mjmU+hFzvdvNBvDtEGftF/usOi7QDtm/QqKYS+iaQjUSyz/o58Xb+UCteUPGoRCFbsBh9Nuu9SomuejmB3mwLhynmV1ocgyZ6w24hEu4Aym9tFbKxBeNWYV0FAHrcfFeao73efNFUitQFwj3egqDYb/PzO3O0+7xPwfiK7d/tFPvHx2ng17pM5MVt2Daj1GWXodnzN/QMQdtpGT3wirxB0W0XaI99S4oJ+TLaLO08z9tyFksCfPDPl3B33jrw3rRnynoqqzvajJCP7Vc1K2dh3ac9rG3L/dzEKGahW9iHAJmVgngnEjivkaALE77bVXgqzGcbV/elQ3juvx/ZHukhM5jDi8yAPe2wsZPhVjaXPw6lo51j/KNf4p2os2sU/6bQoFWvzVA9QhkrG1//YduZjZhV/JR5hgXkR73XMlT+LJxoMseMhmUfVlEEgZbVshstNy3URaTwSGV6rGhY/uq
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(6029001)(4636009)(396003)(39860400002)(376002)(346002)(136003)(46966005)(107886003)(55016002)(8936002)(8676002)(52536014)(9686003)(316002)(70586007)(70206006)(86362001)(110136005)(36906005)(478600001)(33656002)(336012)(2906002)(82310400002)(5660300002)(54906003)(6506007)(4326008)(82740400003)(47076004)(186003)(356005)(7696005)(966005)(81166007)(26005)(83380400001)(32563001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2020 09:00:23.2681
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9e1ef2-9b24-4458-03c9-08d84b30cc70
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT063.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3780
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0aGlldSBhbmQgQ1MgbWFpbnRhaW5lcnMsDQoNCj4gSGkgTGl1LA0KPiANCj4gT24gV2Vk
LCBBdWcgMTksIDIwMjAgYXQgMDQ6MDY6MzdQTSArMDgwMCwgUWkgTGl1IHdyb3RlOg0KPiA+IFdo
ZW4gdG9vIG11Y2ggdHJhY2UgaW5mb3JtYXRpb24gaXMgZ2VuZXJhdGVkIG9uLWNoaXAsIHRoZSBF
VE0gd2lsbA0KPiA+IG92ZXJmbG93LCBhbmQgY2F1c2UgZGF0YSBsb3NzLiBUaGlzIGlzIGEgY29t
bW9uIHBoZW5vbWVub24gb24gRVRNDQo+ID4gZGV2aWNlcy4NCj4gPg0KPiA+IEJ1dCBzb21ldGlt
ZXMgd2UgZG8gbm90IHdhbnQgdG8gbG9zZSBwZXJmb3JtYW5jZSB0cmFjZSBkYXRhLCBzbyB3ZQ0K
PiA+IHN1cHByZXNzIHRoZSBzcGVlZCBvZiBpbnN0cnVjdGlvbnMgc2VudCBmcm9tIENQVSBjb3Jl
IHRvIEVUTSB0byBhdm9pZA0KPiA+IHRoZSBvdmVyZmxvdyBvZiBFVE0uDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBRaSBMaXUgPGxpdXFpMTE1QGh1YXdlaS5jb20+DQo+ID4gLS0tDQo+ID4NCj4g
PiBDaGFuZ2VzIHNpbmNlIHYxOg0KPiA+IC0gRVRNIG9uIEhpU2lsaWNvbiBIaXAwOSBwbGF0Zm9y
bSBzdXBwb3J0cyBiYWNrcHJlc3N1cmUsIHNvIGRvZXMgbm90DQo+ID4gbmVlZCB0byBtb2RpZnkg
Y29yZSBjb21taXQuDQo+ID4NCj4gPiAgZHJpdmVycy9od3RyYWNpbmcvY29yZXNpZ2h0L2NvcmVz
aWdodC1ldG00eC5jIHwgNDMNCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDQzIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2h3dHJhY2luZy9jb3Jlc2lnaHQvY29yZXNpZ2h0LWV0bTR4LmMNCj4gPiBiL2RyaXZl
cnMvaHd0cmFjaW5nL2NvcmVzaWdodC9jb3Jlc2lnaHQtZXRtNHguYw0KPiA+IGluZGV4IDc3OTdh
NTcuLjc2NDFmODkgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9od3RyYWNpbmcvY29yZXNpZ2h0
L2NvcmVzaWdodC1ldG00eC5jDQo+ID4gKysrIGIvZHJpdmVycy9od3RyYWNpbmcvY29yZXNpZ2h0
L2NvcmVzaWdodC1ldG00eC5jDQo+ID4gQEAgLTQzLDYgKzQzLDEwIEBAIE1PRFVMRV9QQVJNX0RF
U0MoYm9vdF9lbmFibGUsICJFbmFibGUgdHJhY2luZw0KPiBvbiBib290Iik7DQo+ID4gICNkZWZp
bmUgUEFSQU1fUE1fU0FWRV9ORVZFUgkgIDEgLyogbmV2ZXIgc2F2ZSBhbnkgc3RhdGUgKi8NCj4g
PiAgI2RlZmluZSBQQVJBTV9QTV9TQVZFX1NFTEZfSE9TVEVEIDIgLyogc2F2ZSBzZWxmLWhvc3Rl
ZCBzdGF0ZSBvbmx5ICovDQo+ID4NCj4gPiArI2RlZmluZSBDT1JFX0NPTU1JVF9DTEVBUgkweDMw
MDANCj4gPiArI2RlZmluZSBDT1JFX0NPTU1JVF9TSElGVAkxMg0KPiA+ICsjZGVmaW5lIEhJU0lf
RVRNX0FNQkFfSURfVjEJMHgwMDBiNmQwMQ0KPiA+ICsNCj4gPiAgc3RhdGljIGludCBwbV9zYXZl
X2VuYWJsZSA9IFBBUkFNX1BNX1NBVkVfRklSTVdBUkU7DQo+ID4gbW9kdWxlX3BhcmFtKHBtX3Nh
dmVfZW5hYmxlLCBpbnQsIDA0NDQpOw0KPiA+IE1PRFVMRV9QQVJNX0RFU0MocG1fc2F2ZV9lbmFi
bGUsIEBAIC0xMDQsMTEgKzEwOCw0MCBAQCBzdHJ1Y3QNCj4gPiBldG00X2VuYWJsZV9hcmcgew0K
PiA+ICAJaW50IHJjOw0KPiA+ICB9Ow0KPiA+DQo+ID4gK3N0YXRpYyB2b2lkIGV0bTRfY3B1X2Fj
dGxyMV9jZmcodm9pZCAqaW5mbykgew0KPiA+ICsJc3RydWN0IGV0bTRfZW5hYmxlX2FyZyAqYXJn
ID0gKHN0cnVjdCBldG00X2VuYWJsZV9hcmcgKilpbmZvOw0KPiA+ICsJdTY0IHZhbDsNCj4gPiAr
DQo+ID4gKwlhc20gdm9sYXRpbGUoIm1ycyAlMCxzM18xX2MxNV9jMl81IiA6ICI9ciIodmFsKSk7
DQo+ID4gKwl2YWwgJj0gfkNPUkVfQ09NTUlUX0NMRUFSOw0KPiA+ICsJdmFsIHw9IGFyZy0+cmMg
PDwgQ09SRV9DT01NSVRfU0hJRlQ7DQo+ID4gKwlhc20gdm9sYXRpbGUoIm1zciBzM18xX2MxNV9j
Ml81LCUwIiA6IDogInIiKHZhbCkpOyB9DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCBldG00X2Nv
bmZpZ19jb3JlX2NvbW1pdChpbnQgY3B1LCBpbnQgdmFsKSB7DQo+ID4gKwlzdHJ1Y3QgZXRtNF9l
bmFibGVfYXJnIGFyZyA9IHswfTsNCj4gPiArDQo+ID4gKwlhcmcucmMgPSB2YWw7DQo+ID4gKwlz
bXBfY2FsbF9mdW5jdGlvbl9zaW5nbGUoY3B1LCBldG00X2NwdV9hY3RscjFfY2ZnLCAmYXJnLCAx
KTsNCj4gDQo+IEZ1bmN0aW9uIGV0bTRfZW5hYmxlL2Rpc2FibGVfaHcoKSBhcmUgYWxyZWFkeSBy
dW5uaW5nIG9uIHRoZSBDUFUgdGhleSBhcmUNCj4gc3VwcG9zZWQgdG8gc28gbm8gbmVlZCB0byBj
YWxsIHNtcF9jYWxsX2Z1bmN0aW9uX3NpbmdsZSgpLg0KPiANCj4gPiArfQ0KPiA+ICsNCj4gPiAg
c3RhdGljIGludCBldG00X2VuYWJsZV9odyhzdHJ1Y3QgZXRtdjRfZHJ2ZGF0YSAqZHJ2ZGF0YSkg
IHsNCj4gPiAgCWludCBpLCByYzsNCj4gPiArCXN0cnVjdCBhbWJhX2RldmljZSAqYWRldjsNCj4g
PiAgCXN0cnVjdCBldG12NF9jb25maWcgKmNvbmZpZyA9ICZkcnZkYXRhLT5jb25maWc7DQo+ID4g
IAlzdHJ1Y3QgZGV2aWNlICpldG1fZGV2ID0gJmRydmRhdGEtPmNzZGV2LT5kZXY7DQo+ID4gKwlz
dHJ1Y3QgZGV2aWNlICpkZXYgPSBkcnZkYXRhLT5jc2Rldi0+ZGV2LnBhcmVudDsNCj4gPiArDQo+
ID4gKwlhZGV2ID0gY29udGFpbmVyX29mKGRldiwgc3RydWN0IGFtYmFfZGV2aWNlLCBkZXYpOw0K
PiA+ICsJLyoNCj4gPiArCSAqIElmIEVUTSBkZXZpY2UgaXMgSGlTaWxpY29uIEVUTSBkZXZpY2Us
IHJlZHVjZSB0aGUNCj4gPiArCSAqIGNvcmUtY29tbWl0IHRvIGF2b2lkIEVUTSBvdmVyZmxvdy4N
Cj4gPiArCSAqLw0KPiA+ICsJaWYgKGFkZXYtPnBlcmlwaGlkID09IEhJU0lfRVRNX0FNQkFfSURf
VjEpDQo+IA0KPiBEbyB5b3UgaGF2ZSBhbnkgZG9jdW1lbnRhdGlvbiBvbiB0aGlzIGJhY2sgcHJl
c3N1cmUgZmVhdHVyZT8gIEkgZG91YnQgdGhpcyBpcw0KPiBzcGVjaWZpYyB0byBIaXAwOSBwbGF0
Zm9ybSBhbmQgYXMgc3VjaCB3b3VsZCBwcmVmZXIgdG8gaGF2ZSBhIG1vcmUgZ2VuZXJpYw0KPiBh
cHByb2FjaCB0aGF0IHdvcmtzIG9uIGFueSBwbGF0Zm9ybSB0aGF0IHN1cHBvcnRzIGl0Lg0KDQpJ
dCdzIG5vdCBhIHN0YW5kYXJkIEFybSBhcmNoaXRlY3R1cmUgZmVhdHVyZSwgdGhpcyBpcyBhIG1v
ZGVsLXNwZWNpZmljIHJlZ2lzdGVyLg0KU29tZSBjb3JlcyBtYXkgYmUgYWJsZSB0byB0aHJvdHRs
ZSB0aHJvdWdocHV0IHVuZGVyIHVzZXIgY29udHJvbCwNCmJ1dCB0aGlzIGlzbid0IHN0YW5kYXJk
aXplZC4gSXQgbWF5IChhcyBpbiB0aGlzIGNhc2UpIGJlIHNvbWV0aGluZyB0aGF0IHlvdQ0Kd2Fu
dCB0byBlbmFibGUgd2hlbmV2ZXIgeW91IGVuYWJsZSBFVE0gLSBhbmQsIEkgZ3Vlc3MsIGRpc2Fi
bGUgd2hlbmV2ZXINCnlvdSBkaXNhYmxlIEVUTS4gSXQncyBhIGJpdCB1bmNsZWFuIHRvIGhhdmUg
bW9kZWwtc3BlY2lmaWMgY29kZSBpbiB0aGUgbWFpbg0KRVRNIGRyaXZlciwgYW5kIG5hbWVzIGxp
a2UgQ09SRV9DT01NSVRfQ0xFQVIgcmVhbGx5IG91Z2h0IHRvIGJlIG1vcmUNCnNwZWNpZmljLCBi
dXQgSSBkb24ndCBzZWUgdGhhdCBpdCdzIG1vcmUgdWdseSB0aGFuIHRoZSBtb2RlbC1zcGVjaWZp
YyBjb2RlIGluDQplLmcuIGFyY2gvYXJtNjQva2VybmVsL3BlcmZfZXZlbnQuYyBvciBpdHMgZXF1
aXZhbGVudCBvbiBvdGhlciBhcmNoaXRlY3R1cmVzLg0KDQpJZGVhbGx5LCBhIGNvcmUgdGhhdCBo
YXMgYW4gaW5oZXJlbnQgZGlmZmljdWx0eSBnZW5lcmF0aW5nIEVUTSBhdCBmdWxsIHNwZWVkLA0K
aS5lLiB3aGVyZSB0aGUgRVRNIGNhbid0IGtlZXAgdXAgd2l0aCB0aGUgY29yZSBwaXBlbGluZSwg
d291bGQgcmVkdWNlDQpjb21taXQgcmF0ZSBhdXRvbWF0aWNhbGx5LCBhbmQgc29tZSBhbHJlYWR5
IGRvLiBTbyBpZiB0aGlzIGNvcmUgbmVlZHMgaXQNCnRvIGJlIGRvbmUgbWFudWFsbHkgdmlhIGEg
c3lzdGVtIHJlZ2lzdGVyLCB3ZSBtaWdodCBhbGxvdyB0aGF0IGluIHRoZQ0Kc2FtZSB3YXkgYXMg
d2UgbWlnaHQgYWxsb3cgb3RoZXIgY29yZS1zcGVjaWZpYyBhY3Rpb25zIHRoYXQgbmVlZCB0byBi
ZQ0KZG9uZSB0byBlbmFibGUgRVRNLg0KDQpUaGVyZSBhcmUgb2YgY291cnNlIGlzc3VlcyB3aXRo
IHRyYWNlIG92ZXJmbG93IGF0IGFsbCBzdGFnZXMgdXAgdG8gYW5kDQppbmNsdWRpbmcgaGFydmVz
dGluZyB0cmFjZSBmcm9tIGJ1ZmZlcnMgaW50byBwZXJmLmRhdGEgKGZvciB3aGljaCBzb2x1dGlv
bnMNCm1pZ2h0IGludm9sdmUgRFZGUywgdHJhY2Ugc3Ryb2JpbmcsIHNjaGVkdWxpbmcgZXRjLiks
IGFuZCBJIGFtIGFzc3VtaW5nDQp0aGlzIHBhdGNoIGlzIG5vdCBhZGRyZXNzaW5nIHRob3NlIGJ1
dCBkZWFsaW5nIHdpdGggYSB2ZXJ5IHNwZWNpZmljIGNvbmNlcm4NCmFib3V0IG92ZXJmbG93IHdp
dGhpbiB0aGUgY29yZSBhbmQgaXRzIEVUTS4NCg0KQWwNCg0KDQo+IA0KPiBBbnlvbmUgb24gdGhl
IENTIG1haWxpbmcgbGlzdCB0aGF0IGtub3dzIHdoYXQgdGhpcyBpcyBhYm91dD8NCj4gDQo+IFRo
YW5rcywNCj4gTWF0aGlldQ0KPiANCj4gPiArCQlldG00X2NvbmZpZ19jb3JlX2NvbW1pdChkcnZk
YXRhLT5jcHUsIDEpOw0KPiA+DQo+ID4gIAlDU19VTkxPQ0soZHJ2ZGF0YS0+YmFzZSk7DQo+ID4N
Cj4gPiBAQCAtNDcyLDEwICs1MDUsMjAgQEAgc3RhdGljIHZvaWQgZXRtNF9kaXNhYmxlX2h3KHZv
aWQgKmluZm8pICB7DQo+ID4gIAl1MzIgY29udHJvbDsNCj4gPiAgCXN0cnVjdCBldG12NF9kcnZk
YXRhICpkcnZkYXRhID0gaW5mbzsNCj4gPiArCXN0cnVjdCBkZXZpY2UgKmRldiA9IGRydmRhdGEt
PmNzZGV2LT5kZXYucGFyZW50Ow0KPiA+ICAJc3RydWN0IGV0bXY0X2NvbmZpZyAqY29uZmlnID0g
JmRydmRhdGEtPmNvbmZpZzsNCj4gPiAgCXN0cnVjdCBkZXZpY2UgKmV0bV9kZXYgPSAmZHJ2ZGF0
YS0+Y3NkZXYtPmRldjsNCj4gPiArCXN0cnVjdCBhbWJhX2RldmljZSAqYWRldjsNCj4gPiAgCWlu
dCBpOw0KPiA+DQo+ID4gKwlhZGV2ID0gY29udGFpbmVyX29mKGRldiwgc3RydWN0IGFtYmFfZGV2
aWNlLCBkZXYpOw0KPiA+ICsJLyoNCj4gPiArCSAqIElmIEVUTSBkZXZpY2UgaXMgSGlTaWxpY29u
IEVUTSBkZXZpY2UsIHJlc3VtZSB0aGUNCj4gPiArCSAqIGNvcmUtY29tbWl0IGFmdGVyIEVUTSB0
cmFjZSBpcyBjb21wbGV0ZS4NCj4gPiArCSAqLw0KPiA+ICsJaWYgKGFkZXYtPnBlcmlwaGlkID09
IEhJU0lfRVRNX0FNQkFfSURfVjEpDQo+ID4gKwkJZXRtNF9jb25maWdfY29yZV9jb21taXQoZHJ2
ZGF0YS0+Y3B1LCAwKTsNCj4gPiArDQo+ID4gIAlDU19VTkxPQ0soZHJ2ZGF0YS0+YmFzZSk7DQo+
ID4NCj4gPiAgCWlmICghZHJ2ZGF0YS0+c2tpcF9wb3dlcl91cCkgew0KPiA+IC0tDQo+ID4gMi44
LjENCj4gPg0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xw0KPiBDb3JlU2lnaHQgbWFpbGluZyBsaXN0DQo+IENvcmVTaWdodEBsaXN0cy5saW5hcm8ub3Jn
DQo+IGh0dHBzOi8vbGlzdHMubGluYXJvLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2NvcmVzaWdodA0K
