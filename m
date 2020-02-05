Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E91BC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 07:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 509AF20702
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 07:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="XLnF2s0z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="Rt7Zz+pF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgBEH7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 02:59:52 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:36022 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725875AbgBEH7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 02:59:52 -0500
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 25A72405CC;
        Wed,  5 Feb 2020 07:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1580889591; bh=043OqkSFL25wYaIR0zrHiWXe4294KpVbMlMrwIeUsyI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=XLnF2s0zPO7YaE/PWn2v6Gk9OAzTF2PjpCQRTJNT/8gNgIGhpDA01TTu7uKtnrt6a
         Mq5nPAYCJrukGX0nlGuceNsnezcZWA+442N2cDthiohpbHsQ5Z2xGOd1+7Zyx7kxLJ
         99cBOsqIxqq5DMKNKJ/ztw8oUKkYCUv/mnFXyh67E9+w2ARImFZ6uXvSqQDejkR6hD
         Mn5fPB6U6UALnNu/FsVkGoUPxfI2aMzIVzH8nXag/j9Pqct8S0EM1QllSrDf+JawBp
         bwSp4v/lo0/e9Petp/1uYJqReu1Dm2h4yFDJLe5SGql4z5y49+r/TuZrKmEwbooFvt
         Cf8P6k148IlWg==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id AD966A008A;
        Wed,  5 Feb 2020 07:59:50 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 4 Feb 2020 23:59:50 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Tue, 4 Feb 2020 23:59:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2k4lTXCBVrVmFI1wIZ3sj/LpoTxk+BLGCnr5JjugbdrPqtGod6Q4OT7Dl/Mx55lqTkZu6MrI2DImVLTcZXDqqj9k7BQI651rBOMYiKRwk4XlzurnTdNEH8+ijetWNxq+DghtZont5F5VdbHxnPX9siujwXeJuhxJi5ZqtQkco6IZzBBL3VbIk8sV+ag30VKtG4m29kgTnLMPWUxykI+vHUmcuT/+VdbqSG1qIxBHVXm2RBnQbIjfgAFtr6k4iHHI0lqaQbf9repE9vOEAEM6iSF4drpthFmR9TitA5+qXbyMNQX3FyYcmYMMIDBMD5MIvTKHduCsDGr49GGZYWS+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=043OqkSFL25wYaIR0zrHiWXe4294KpVbMlMrwIeUsyI=;
 b=TJJQ+iuk4bbw0JOl+MMhryyuq8BGkE6IzsY5mdl/J1mMdh9vZRYcZ0Zoe9YJeqoVhkRaq8c/KgSYNfi4KA5vHVRAyzwJbZPjP8dgEzaYzrz871MTk9PvzxBjKVbjlEKwlsruTaRb9sGKgGXcyZcoaE93rftFvRCTasUoppUG5d1X4Ov+ZEMTv11ulKzDmOy5v7dVG6mnrqCPOtu2q878mpVVlmtFcngV8y2O63+s4RwS+ByVlj5x987KaV2AOH8tTbj9leO5oIJNeFI4Uj5rqqwa04okaaKx7EKYLqHtSUvEkBEkomjAfJrlQwPkaKj5ME5swmpbNOd8guA3hWzJiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=043OqkSFL25wYaIR0zrHiWXe4294KpVbMlMrwIeUsyI=;
 b=Rt7Zz+pFpNb46jgsKjTxzc3JklWRTn8cPvdZZqCjN0g9EIKaV8SkMKTACS7Ew7b9C1pcdMeJicEUnSDB/6XiKK+xTj3IaNuchZKe0GohW/LDuaF15RPDsMg4blLAJ8xnRYHRK2ye1RMnkvOZAvMvVPff4NGLLFrzDHS+MRcai/Y=
Received: from MN2PR12MB4093.namprd12.prod.outlook.com (52.135.51.203) by
 MN2PR12MB4127.namprd12.prod.outlook.com (52.135.48.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Wed, 5 Feb 2020 07:59:49 +0000
Received: from MN2PR12MB4093.namprd12.prod.outlook.com
 ([fe80::35cf:644a:cfa6:72f8]) by MN2PR12MB4093.namprd12.prod.outlook.com
 ([fe80::35cf:644a:cfa6:72f8%7]) with mapi id 15.20.2707.020; Wed, 5 Feb 2020
 07:59:49 +0000
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     John Keeping <john@metanate.com>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:DESIGNWARE USB2 DRD IP DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc2: Implement set_selfpowered()
Thread-Topic: [PATCH] usb: dwc2: Implement set_selfpowered()
Thread-Index: AQHV23AHZCKSO2mqU0iflYr2FT5Mp6gMPZgA
Date:   Wed, 5 Feb 2020 07:59:48 +0000
Message-ID: <34b74e48-a3ea-f68f-540e-121ae98afb31@synopsys.com>
References: <20200204152933.2216615-1-john@metanate.com>
In-Reply-To: <20200204152933.2216615-1-john@metanate.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hminas@synopsys.com; 
x-originating-ip: [46.162.196.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f98e3073-4d20-4e1f-78c0-08d7aa115f95
x-ms-traffictypediagnostic: MN2PR12MB4127:
x-microsoft-antispam-prvs: <MN2PR12MB4127E50641EC8106CE46E9F7A7020@MN2PR12MB4127.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0304E36CA3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(366004)(396003)(39860400002)(189003)(199004)(8936002)(86362001)(8676002)(4326008)(81166006)(81156014)(71200400001)(6506007)(6916009)(2906002)(66946007)(53546011)(31686004)(76116006)(186003)(64756008)(66476007)(91956017)(26005)(5660300002)(66446008)(66556008)(6512007)(6486002)(54906003)(36756003)(31696002)(2616005)(316002)(478600001)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR12MB4127;H:MN2PR12MB4093.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K+dC8N9x+2JK0LT59dEy2C5Gtimbb+cvVknqboAGOuCSLnvGJd6f+DZLGVL3v5T7VUsP4PW3MQqTN3qRQeAs71E+oP2x2CNlMPRrUymJeENd/8kQeHJ4skyDFg50wauA83VQ9oGwt+r3VCSwCk5ibAmVKxNLGNSYxVPwKGIhLYi+EWiJVKB/FbYdXrTB9EDRYlHReYtl6KB3MCtw5VQ6TkeO5PLLAb1Am9qtQVyFpOWPsc8+IbAC5C+SLEJ5P1XeCJk4Yvp2pLU/k93UtFwuKm4ryjVf8vnjVBynWsot2zPwV+6n+X4Bvbzjrgecjcy4yhIlc9XJ9PeqkwLoEnfWINPfqClc1sivUWfAYOuIovbEpBhe/oaD6AcVthgNXbZ4IAP+SIBvscPwTFkP0eRoA2uFvpPsmD+FJsXcydcMResASCcUtuX+r2luhzzSHX3tRU/5+MhOh5gwiX+TBdYqYrO/ZCSe8Nbk4k7KMsaCyi+luix7Uc0y3AOrlq2Cx63g
x-ms-exchange-antispam-messagedata: NknX2THh2TiHs7qpMcn4T8HFwt2gtxU3G1QVfy1aE9AjgEM0Pr35XUniSdXCvpyofd9RowAqEuKJPvWO7HPk4fLYANyEVPxPA1Is5pRO7e/t6q4sJaSGh5q5ldr0mNFWSd5QCQllCSVo8pHLBvzdQA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1EB4C66095B70546A53BA7176C1335AE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f98e3073-4d20-4e1f-78c0-08d7aa115f95
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2020 07:59:48.8532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TRNbL/fxlOJf8EVmpOSWFI8LjX8YtyE0rYSMApFHlTexSliyAhE7+FreHYBDuv91DNuJfmYx0bmPzmLVHYVcLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4127
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9obiwNCg0KT24gMi80LzIwMjAgNzoyOSBQTSwgSm9obiBLZWVwaW5nIHdyb3RlOg0KPiBk
d2MyIGFsd2F5cyByZXBvcnRzIGFzIHNlbGYtcG93ZXJlZCBpbiByZXNwb25zZSB0byBhIGRldmlj
ZSBzdGF0dXMNCj4gcmVxdWVzdC4gIEltcGxlbWVudCB0aGUgc2V0X3NlbGZwb3dlcmVkKCkgb3Bl
cmF0aW9ucyBzbyB0aGF0IHRoZSBnYWRnZXQNCj4gY2FuIHJlcG9ydCBhcyBidXMtcG93ZXJlZCB3
aGVuIGFwcHJvcHJpYXRlLg0KPiANCj4gVGhpcyBpcyBtb2RlbGxlZCBvbiB0aGUgZHdjMyBpbXBs
ZW1lbnRhdGlvbi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEpvaG4gS2VlcGluZyA8am9obkBtZXRh
bmF0ZS5jb20+DQoNCkdvb2QgY2F0Y2guIEp1c3Qgb25lIGNvbmNlcm4uIFlvdXIgcGF0Y2ggcGFy
dGlhbGx5IGZpeCBteSBwYXRjaCB0aGlzIGlzIA0Kd2h5IEkgdGhpbmsgeW91IG5lZWQgdG8gYWRk
IEZpeGVzIHRhZyBvdGhlcndpc2UgaXQgY2FuIGNyZWF0ZSBtZXJnZSANCmNvbmZsaWN0IGlmIHlv
dXIgcGF0Y2ggd2lsbCBiZSBtZXJnZWQgdG8gbmV4dCBlYXJsaWVyIHRoYW4gbXkuDQoNClRoYW5r
cywNCk1pbmFzDQoNCg0KPiAtLS0NCj4gICBkcml2ZXJzL3VzYi9kd2MyL2dhZGdldC5jIHwgMjQg
KysrKysrKysrKysrKysrKysrKysrKystDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIzIGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2My
L2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMi9nYWRnZXQuYw0KPiBpbmRleCAyNzE3ZjQ0MDFi
OTcuLjc2YzBhNTI0MjE3NSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMi9nYWRnZXQu
Yw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MyL2dhZGdldC5jDQo+IEBAIC0xNjQ2LDcgKzE2NDYs
OCBAQCBzdGF0aWMgaW50IGR3YzJfaHNvdGdfcHJvY2Vzc19yZXFfc3RhdHVzKHN0cnVjdCBkd2My
X2hzb3RnICpoc290ZywNCj4gICANCj4gICAJc3dpdGNoIChjdHJsLT5iUmVxdWVzdFR5cGUgJiBV
U0JfUkVDSVBfTUFTSykgew0KPiAgIAljYXNlIFVTQl9SRUNJUF9ERVZJQ0U6DQo+IC0JCXN0YXR1
cyA9IDEgPDwgVVNCX0RFVklDRV9TRUxGX1BPV0VSRUQ7DQo+ICsJCXN0YXR1cyA9IGhzb3RnLT5n
YWRnZXQuaXNfc2VsZnBvd2VyZWQgPDwNCj4gKwkJCSBVU0JfREVWSUNFX1NFTEZfUE9XRVJFRDsN
Cj4gICAJCXN0YXR1cyB8PSBoc290Zy0+cmVtb3RlX3dha2V1cF9hbGxvd2VkIDw8DQo+ICAgCQkJ
ICBVU0JfREVWSUNFX1JFTU9URV9XQUtFVVA7DQo+ICAgCQlyZXBseSA9IGNwdV90b19sZTE2KHN0
YXR1cyk7DQo+IEBAIC00NTMwLDYgKzQ1MzEsMjYgQEAgc3RhdGljIGludCBkd2MyX2hzb3RnX2dh
ZGdldF9nZXRmcmFtZShzdHJ1Y3QgdXNiX2dhZGdldCAqZ2FkZ2V0KQ0KPiAgIAlyZXR1cm4gZHdj
Ml9oc290Z19yZWFkX2ZyYW1lbm8odG9faHNvdGcoZ2FkZ2V0KSk7DQo+ICAgfQ0KPiAgIA0KPiAr
LyoqDQo+ICsgKiBkd2MyX2hzb3RnX3NldF9zZWxmcG93ZXJlZCAtIHNldCBpZiBkZXZpY2UgaXMg
c2VsZi9idXMgcG93ZXJlZA0KPiArICogQGdhZGdldDogVGhlIHVzYiBnYWRnZXQgc3RhdGUNCj4g
KyAqIEBpc19zZWxmcG93ZXJlZDogV2hldGhlciB0aGUgZGV2aWNlIGlzIHNlbGYtcG93ZXJlZA0K
PiArICoNCj4gKyAqIFNldCBpZiB0aGUgZGV2aWNlIGlzIHNlbGYgb3IgYnVzIHBvd2VyZWQuDQo+
ICsgKi8NCj4gK3N0YXRpYyBpbnQgZHdjMl9oc290Z19zZXRfc2VsZnBvd2VyZWQoc3RydWN0IHVz
Yl9nYWRnZXQgKmdhZGdldCwNCj4gKwkJCQkgICAgICBpbnQgaXNfc2VsZnBvd2VyZWQpDQo+ICt7
DQo+ICsJc3RydWN0IGR3YzJfaHNvdGcgKmhzb3RnID0gdG9faHNvdGcoZ2FkZ2V0KTsNCj4gKwl1
bnNpZ25lZCBsb25nIGZsYWdzOw0KPiArDQo+ICsJc3Bpbl9sb2NrX2lycXNhdmUoJmhzb3RnLT5s
b2NrLCBmbGFncyk7DQo+ICsJZ2FkZ2V0LT5pc19zZWxmcG93ZXJlZCA9ICEhaXNfc2VsZnBvd2Vy
ZWQ7DQo+ICsJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmaHNvdGctPmxvY2ssIGZsYWdzKTsNCj4g
Kw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+ICAgLyoqDQo+ICAgICogZHdjMl9oc290Z19w
dWxsdXAgLSBjb25uZWN0L2Rpc2Nvbm5lY3QgdGhlIFVTQiBQSFkNCj4gICAgKiBAZ2FkZ2V0OiBU
aGUgdXNiIGdhZGdldCBzdGF0ZQ0KPiBAQCAtNDYyMSw2ICs0NjQyLDcgQEAgc3RhdGljIGludCBk
d2MyX2hzb3RnX3ZidXNfZHJhdyhzdHJ1Y3QgdXNiX2dhZGdldCAqZ2FkZ2V0LCB1bnNpZ25lZCBp
bnQgbUEpDQo+ICAgDQo+ICAgc3RhdGljIGNvbnN0IHN0cnVjdCB1c2JfZ2FkZ2V0X29wcyBkd2My
X2hzb3RnX2dhZGdldF9vcHMgPSB7DQo+ICAgCS5nZXRfZnJhbWUJPSBkd2MyX2hzb3RnX2dhZGdl
dF9nZXRmcmFtZSwNCj4gKwkuc2V0X3NlbGZwb3dlcmVkCT0gZHdjMl9oc290Z19zZXRfc2VsZnBv
d2VyZWQsDQo+ICAgCS51ZGNfc3RhcnQJCT0gZHdjMl9oc290Z191ZGNfc3RhcnQsDQo+ICAgCS51
ZGNfc3RvcAkJPSBkd2MyX2hzb3RnX3VkY19zdG9wLA0KPiAgIAkucHVsbHVwICAgICAgICAgICAg
ICAgICA9IGR3YzJfaHNvdGdfcHVsbHVwLA0KPiANCg==
