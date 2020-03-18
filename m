Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79325C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 10:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46A512076C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 10:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ZootnJ/C";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="P0lJc+rq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgCRKkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 06:40:36 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:52656 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727790AbgCRKkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 06:40:33 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id AFCCE40386;
        Wed, 18 Mar 2020 10:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1584528031; bh=upeiXR8A2t1k1/A1io1I4kRG+PaCRERXe0g9i/T/ro4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ZootnJ/C+sqVqzottAVjzdXiBSzFJkGVQkN8FNu4JSqCOxbqp1+Na6YaZcBV9p9PB
         /s3+ONnVmWICxamweb9pem0WvevViBdLiJFswCbpqf4zeSyPVNKJUZEnEvKgUxeUXA
         6yUGHVOQaBBHB6kAU5ylMEAhZKf3DvxUwPVA2agUaQuDubwWTKwFBPa29lbBQIHMa4
         Bcfe8wOEnoItqyV5HQcmCQ6n01Nq3MLzFDuoQI34oODI+xQePU10A+JFanCZmqtoXg
         J1ReSSzRB9YYSgbiJlJ0QXsABmxNLIR4FX60s1tfZJrQX8bjTOpMo/rzIp9xKbV9r1
         oz5usZxEJHrkg==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id B8584A00B1;
        Wed, 18 Mar 2020 10:40:27 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 18 Mar 2020 03:40:20 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 18 Mar 2020 03:40:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFDLz/fHSkOsBGTfvdXTYciLuZ3hECmOf1VCcml07UOAmEWIcmwEPo63SWb+jdZ87B0aq8LRJ6bLnymVQAoXjGO8k7r1yLjjgvPrXIDAoI9iITDI2anzT98x05fDrFPt+lS+NvtMs7VTZrA1AQ/a5Ed58yZJuALTVk28Wy6A8XLFa7WOhRR2dpbgEQf3SxDh4u4MmTX5Iu5Cq7tiLK7b2Q0WaYkVrdG/VlTyHjW2hx+kHYESN4b8lsT0eegITQqN7IFS3+JS8zrUWxvP+v4DLlXy0IeUU6q7ctXhbkIm0cmpzPxva06Fx+zRdFnENGG4o6t9Wz6up+QItSPeuPEtWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upeiXR8A2t1k1/A1io1I4kRG+PaCRERXe0g9i/T/ro4=;
 b=PDLCfSiTCId2bo1DLw31lCLIKSg2K7YIEsHzEc/OvZsspgjqW32aHFwKo8PToEEJVR87zx7vXkWcVdYfNA/HtHHsw6yfXTNCmfkfO5QUZkBEZZg5CBMmjtyggiAL0uTctbyAMhH6uwk31FXTKG4kx0rcJjKFwWHXecgygnrWrj8ZLFybXD6tZ212QtRW8YHENNhS+dAUwgpXWwdq5X2K2Du0NxzVbaBtDE6ySM+O+RFHqRZhe4htUCdzveBfCONo97yon4Lmbnd8lhN435bK7p7uP4YQoQ80Ux60QAWlDkQMq3CJDuh7WGdmDdULHld++AaXDCJtTY8VpLdn4BN3hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upeiXR8A2t1k1/A1io1I4kRG+PaCRERXe0g9i/T/ro4=;
 b=P0lJc+rqLE8XAzVKPfepG5gBJNuese8nt3H6vl+PRv+QT8bz4jXt+pU+SGe1rORQZDINmAuoIvwPWuuSv9BO5w1LpGxzvqiIFCIjT1q1fg6pLyDmG85feonvEEs0F6T2C900zIWI9Lvfk5h5lyu34n55nsnzEpppopX+5rd8mE8=
Received: from SN1PR12MB2557.namprd12.prod.outlook.com (2603:10b6:802:22::15)
 by SN1PR12MB2400.namprd12.prod.outlook.com (2603:10b6:802:2f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.22; Wed, 18 Mar
 2020 10:40:18 +0000
Received: from SN1PR12MB2557.namprd12.prod.outlook.com
 ([fe80::4443:6274:1aeb:4c80]) by SN1PR12MB2557.namprd12.prod.outlook.com
 ([fe80::4443:6274:1aeb:4c80%7]) with mapi id 15.20.2835.013; Wed, 18 Mar 2020
 10:40:17 +0000
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Dejin Zheng <zhengdejin5@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jeffrey.t.kirsher@intel.com" <jeffrey.t.kirsher@intel.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "treding@nvidia.com" <treding@nvidia.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tomas.winkler@intel.com" <tomas.winkler@intel.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "sergei.shtylyov@cogentembedded.com" 
        <sergei.shtylyov@cogentembedded.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/5] usb: dwc2: convert to
 devm_platform_get_and_ioremap_resource
Thread-Topic: [PATCH v3 4/5] usb: dwc2: convert to
 devm_platform_get_and_ioremap_resource
Thread-Index: AQHV+tLl/NGJLAQPKkuA5ghKUS2FRahOLZMA
Date:   Wed, 18 Mar 2020 10:40:17 +0000
Message-ID: <f39917e0-2ee1-076c-c199-3e728ab063d2@synopsys.com>
References: <20200315140525.21780-1-zhengdejin5@gmail.com>
 <20200315140525.21780-5-zhengdejin5@gmail.com>
In-Reply-To: <20200315140525.21780-5-zhengdejin5@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hminas@synopsys.com; 
x-originating-ip: [46.162.196.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb4a79d1-7d35-4182-4e0b-08d7cb28c009
x-ms-traffictypediagnostic: SN1PR12MB2400:
x-microsoft-antispam-prvs: <SN1PR12MB2400C579B4EABBE71EC6577CA7F70@SN1PR12MB2400.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 03468CBA43
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(346002)(396003)(376002)(199004)(81166006)(81156014)(4326008)(2906002)(26005)(5660300002)(7416002)(6512007)(66946007)(76116006)(36756003)(6486002)(64756008)(66476007)(66556008)(66446008)(8676002)(91956017)(8936002)(478600001)(186003)(2616005)(110136005)(86362001)(316002)(31696002)(6506007)(53546011)(31686004)(71200400001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR12MB2400;H:SN1PR12MB2557.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qob8ALxI2FNycyOJ4QTP/N47skZwZ8CIRh6IGw/VaWS6RHTCRu9kigztqS1DZ9wgZ5h8e/pGi31KMqTaBhQSe8DQZXTV51i4wEIETBxNT70f3yUKLJ+hpHsiEtaCOCVRkVKgOxFwqoOFbFbdpYkUz+PCqx6ksMWbvM5Nla/RkRO3kkNCv73JTqWjAqWqwypXcHws+f52q+YTYiy3+dYDAaIByjgr33J4qx8tKINc9dDIgJ2SkHMJuBacM3wptSguZFpocGBOBXvKucVFOxJ5ixYb+V7sy0bmfflOm2qkFAe2k/80wwzMmtB8GxonM060TWr5n69O4NZUpG9nHzWfM1rmHIT2dMvoGX5pX0FNUTue7MIhkATxFPTxlM8gQUGfn+JChMQweN0s21+GPAuvik5pLcaBHphRnjnTzwzTtgbufvC8+gePB+IVKRQs3RxM1kbZe7aqVbayJH114SV12wrw30k+5FP+HoU0tjbbigC53FjY6H7zYLC0MSBv/+2G
x-ms-exchange-antispam-messagedata: QHWag8hur0RNFg2ETZlPPbFo353ydLhfeNWcD50wV8cLhFqmy7RYbcYmSUekud32LL6cSLAwIKlkoUwCgJ/oVWOpTZNr9AhmwiXkvtIAtbHOMIBT593TIcLe8m6+1rwRbVSXOXaoJSu4wSU6SCNp8Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7775985701F06F4D828D8D7AEF0297B1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bb4a79d1-7d35-4182-4e0b-08d7cb28c009
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2020 10:40:17.5880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d11puotNg6xfZ4M9MMJ1fSK1SXgGDsEuDc89WGq4Ikt9ao5FdS2qWlfD0YBXN0IivE9NEDaKseaJvFeUqoBWnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2400
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDMvMTUvMjAyMCA2OjA1IFBNLCBEZWppbiBaaGVuZyB3cm90ZToNCj4gVXNlIGRldm1f
cGxhdGZvcm1fZ2V0X2FuZF9pb3JlbWFwX3Jlc291cmNlKCkgdG8gc2ltcGxpZnkgY29kZSwgd2hp
Y2gNCj4gY29udGFpbnMgcGxhdGZvcm1fZ2V0X3Jlc291cmNlKCkgYW5kIGRldm1faW9yZW1hcF9y
ZXNvdXJjZSgpLCBpdCBhbHNvDQo+IGdldCB0aGUgcmVzb3VyY2UgZm9yIHVzZSBieSB0aGUgZm9s
bG93aW5nIGNvZGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEZWppbiBaaGVuZyA8emhlbmdkZWpp
bjVAZ21haWwuY29tPg0KDQpBY2tlZC1ieTogTWluYXMgSGFydXR5dW55YW4gPGhtaW5hc0BzeW5v
cHN5cy5jb20+DQoNCj4gLS0tDQo+IHYyIC0+IHYzOg0KPiAJLSBjYWxsIHRoZSByZW5hbWUgZnVu
Y3Rpb24gZGV2bV9wbGF0Zm9ybV9nZXRfYW5kX2lvcmVtYXBfcmVzb3VyY2UoKQ0KPiANCj4gdjEg
LT4gdjI6DQo+IAktIGFkZCB0aGlzIHBhdGNoIGZvciBhZGQgc29tZSByZWFsIHVzZXJzIG9mIHRo
aXMgZnVuY3Rpb24uDQo+ICAgDQo+ICAgZHJpdmVycy91c2IvZHdjMi9wbGF0Zm9ybS5jIHwgMyAr
LS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMi9wbGF0Zm9ybS5jIGIvZHJpdmVycy91
c2IvZHdjMi9wbGF0Zm9ybS5jDQo+IGluZGV4IDNjNmNlMDlhNmRiNS4uOGE2OGU4OTc0OWQyIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MyL3BsYXRmb3JtLmMNCj4gKysrIGIvZHJpdmVy
cy91c2IvZHdjMi9wbGF0Zm9ybS5jDQo+IEBAIC0zOTIsOCArMzkyLDcgQEAgc3RhdGljIGludCBk
d2MyX2RyaXZlcl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpkZXYpDQo+ICAgCQlyZXR1
cm4gcmV0dmFsOw0KPiAgIAl9DQo+ICAgDQo+IC0JcmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNl
KGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOw0KPiAtCWhzb3RnLT5yZWdzID0gZGV2bV9pb3JlbWFw
X3Jlc291cmNlKCZkZXYtPmRldiwgcmVzKTsNCj4gKwloc290Zy0+cmVncyA9IGRldm1fcGxhdGZv
cm1fZ2V0X2FuZF9pb3JlbWFwX3Jlc291cmNlKGRldiwgMCwgJnJlcyk7DQo+ICAgCWlmIChJU19F
UlIoaHNvdGctPnJlZ3MpKQ0KPiAgIAkJcmV0dXJuIFBUUl9FUlIoaHNvdGctPnJlZ3MpOw0KPiAg
IA0KPiANCg==
