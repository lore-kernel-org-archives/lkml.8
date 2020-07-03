Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D55FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EA91206B6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="F7VHtQgi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="LKN2/wCt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgGCHi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 03:38:28 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:53056 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725779AbgGCHi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 03:38:28 -0400
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 99401C050E;
        Fri,  3 Jul 2020 07:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1593761906; bh=XLiYaREvI3lDBozFEBAnsKfX3EfamUVss/t365tvKIY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=F7VHtQgiDy2jXYCN7USZiJzevDJ2sz3Wq2/8heIQgOXQp95MKKBlZ04vcBlM/VuyT
         kczNeyAMaU53cJoGSmye2GM+CANRgxijWL2ua4CXSBGwPZIwzEHQSrUBy/YyQg7lXn
         8JJGxuV8uxV/zj2sq9jPXVCJ+LC3EF1oqRDxBkCmDfJbpVMOwFl5ljjqchzCg/sCU3
         Tio4w0O4jFJmZYI6f4vcGSODPsW1ckd/h/6CMvg1n0SWBKnC3A9WoRhSy1V2+eW7qU
         kGs8FW5Yc2eQKnt880KGMdvKjbSXXNuo7irn+cuczuC7YKEOn1SE+QYIyKk3eg6JCn
         OqBvKkFHmJ4BA==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 9EE5AA0068;
        Fri,  3 Jul 2020 07:38:20 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 46D6A401AB;
        Fri,  3 Jul 2020 07:38:17 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="LKN2/wCt";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odzQMgKD21+Fhn1ImGlqPCOySrAv/ZN/7JfVYoZnq8VaPm2J1gPxTXAY5AoD3nLwqtilfZSXuy12T3PRWNmsUP4iK0tJ2VuCfRT6mHskfrK3ABav9M5iuA9ioRi5+tdRbl3w9ggYSwKqv2KoeYDpSRk+GulMW4m/JcA9x3J0gYhNtXb196MnPxgZXi84WgpVvc1vfms/XmULMqNSBRrnJ6WV6PWY0Xieia20BdPWaEt3ES/yxsM1dBbi36VUwNOXSlogJuS4guqeYDNuUp2rfXdEPGF+YoX9vXB5YETELSTfDQh++4xgxZCGK7RSVinbxAzFqAaapMvDbriZ+nX8wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLiYaREvI3lDBozFEBAnsKfX3EfamUVss/t365tvKIY=;
 b=cYW3dvtvQc90e+mYjBxSh582bn2kAzrpRNiLG226cHtSdBsqmE4VG6KAztcyLAiOPO0bhDs16qI5ytc1aXem10885czuQDBNf1Gm/M591T7VyDjFsyFI7rYS+bilwy/UmxznQhgWtrNrWWlU0YAohm7oCwwqaARXzIpyLgd5quke8Jj+hS7YCDGyAH38jCeEYhBr00PRiJAxwG1yqRlApLL/coEYsQ8El9mGyXNJ+PZmeP4ELW7RduZPyvifKto9UnK3Z0cXnFn6GfVkG3r4C8E3jBpD5Rx/XpyTtnPVFRx8X5sgqEZ5EBeygljaOfi6k4B2l6UQZAp7TK1MuroTsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLiYaREvI3lDBozFEBAnsKfX3EfamUVss/t365tvKIY=;
 b=LKN2/wCtrOeGxgJVwTkEJPjY79+rG+VjB2Wo8qXb/YZVxBnEnhJFquyGb/txkCxziGPlCvpbphna9w8g9h/heRp2hdQqQ3ahK3+X6SqAowJvqjOItNCaNYky5aeRGRrsDn+HPQO0PVwMSiQlmr3ZEKS9+qa2aPQSgWRBIuDF4Q8=
Received: from CY4PR12MB1432.namprd12.prod.outlook.com (2603:10b6:903:44::11)
 by CY4PR12MB1432.namprd12.prod.outlook.com (2603:10b6:903:44::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Fri, 3 Jul
 2020 07:38:16 +0000
Received: from CY4PR12MB1432.namprd12.prod.outlook.com
 ([fe80::3cb9:e2f2:a4ff:14bd]) by CY4PR12MB1432.namprd12.prod.outlook.com
 ([fe80::3cb9:e2f2:a4ff:14bd%10]) with mapi id 15.20.3153.023; Fri, 3 Jul 2020
 07:38:16 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Ben Dooks <ben@simtec.co.uk>
Subject: Re: [PATCH 11/30] usb: dwc2: gadget: Avoid pointless read of EP
 control register
Thread-Topic: [PATCH 11/30] usb: dwc2: gadget: Avoid pointless read of EP
 control register
Thread-Index: AQHWUH+fyhb4/oSmxUieC1VUnpCQeqj1dlwAgAACd4A=
Date:   Fri, 3 Jul 2020 07:38:16 +0000
Message-ID: <e88abd64-4acf-31f6-f76a-5a333df3d46a@synopsys.com>
References: <20200702144625.2533530-1-lee.jones@linaro.org>
 <20200702144625.2533530-12-lee.jones@linaro.org>
 <20200703072926.GA2322133@kroah.com>
In-Reply-To: <20200703072926.GA2322133@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [37.252.92.106]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8f91135-891e-4a87-43eb-08d81f240cb9
x-ms-traffictypediagnostic: CY4PR12MB1432:
x-microsoft-antispam-prvs: <CY4PR12MB14320C34FC162E4D99C57CADA76A0@CY4PR12MB1432.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 045315E1EE
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kskGDLzRnT1dSmc41i74hzdtUGDO5kHZRreLTtdR3z20mNAj227FLXJBNgRR4x7bBrH8UY01emmLDwoWQOPeNaS4c86GLOy1LQdLGQ+qrFsYHbOOp020v+KyqRPUa8TTQGUgv0oo34pG41cPc3LzBMjFEEvT7+l6aKtlCLZ408EixD1PBK+dbgaXY6muXiQX8zC1I7PNOKmRxV//pIUooaPA5FrB3fvKvT+PtlFmiTXFPYCvNvi5xWF7jWKjqB8+e2vcC05VCIKzZnP3aQyl0x2hEGND17OodzY8KGsJeh2Xmw7ngVnnscCMm5zzLje4hioojNxAiYRodM7rehtQdVgFyij/xMvUNYjEpNSxwefHSE+hcUIh7dTH2Z7cfde2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(346002)(136003)(376002)(39860400002)(396003)(6486002)(54906003)(5660300002)(110136005)(316002)(2906002)(66446008)(66556008)(66476007)(86362001)(6506007)(53546011)(64756008)(66946007)(76116006)(478600001)(91956017)(31686004)(71200400001)(8676002)(31696002)(36756003)(186003)(83380400001)(26005)(6512007)(4326008)(8936002)(2616005)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: O5DRw1Hm4Wm2YjMWIdlQ8MY0QljBaBOOkNqhVXEFX9fr5nP5lGsyg8lWH9RskK3MV/sTgqu3Vs4WDXrTQD+yRI0NauLxdTzx/5wlqmAmCrmvJ7x5d/7Lp0MurltmizBy/+hBZEZzS5cjd16ByjH9rcXPY3i2dNhXDktuBYM5xzj1f93Cvf8tN2mTctKdotvdKJdtViDh8jLrwze6DFF++37g3C2kf1GGNq46RkDraNXMvyXRZNvptOD//BTbC5tHsl4RUDQoFgSuuUMIeRlzx+xyl1qYPvXIf0y6ROZ0Ts7VuCKWQ7zsX/ybKH0GCTeEzo5uDDm4rXm6Hp5xPUSxJSInbY3I0RBLX7wxJL5MuqoegVj10rp5WGql3llM/517QPq+vEuthTYofjfPv1Atadq/B/+5NY4YlzcFsoPocJr6g5B0u0/ImpuxcDY7aaoirVX57yfEnHsvDS9dtDxYJbHTjZUJa8hRtKXza0uXhjA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF145144D11FC14F94CB183CA20CCD1E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f91135-891e-4a87-43eb-08d81f240cb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 07:38:16.3947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qRNrmf5KGECXCXiOkTtiI5U7uUsSABp1Vf8aQswR4rrBFxnHJDrdEgYgf6e7zjA6wKuxBNa2xDh18WUwvtuUhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1432
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIDcvMy8yMDIwIDExOjI5IEFNLCBHcmVnIEtIIHdyb3RlOg0KPiBPbiBUaHUsIEp1
bCAwMiwgMjAyMCBhdCAwMzo0NjowNlBNICswMTAwLCBMZWUgSm9uZXMgd3JvdGU6DQo+PiBDb21t
aXQgZWMxZjlkOWYwMTM4NCAoInVzYjogZHdjMjogZ2FkZ2V0OiBwYXJpdHkgZml4IGluIGlzb2No
cm9ub3VzIG1vZGUiKSBtb3ZlZA0KPj4gdGhlc2UgY2hlY2tzIHRvIGR3YzJfaHNvdGdfY2hhbmdl
X2VwX2lzb19wYXJpdHkoKSBiYWNrIGluIDIwMTUuICBUaGUgYXNzaWduZWQNCj4+IHZhbHVlIGhh
c24ndCBiZWVuIHJlYWQgYmFjayBzaW5jZS4gIExldCdzIHJlbW92ZSB0aGUgdW5uZWNlc3Nhcnkg
SC9XIHJlYWQuDQo+Pg0KPj4gRml4ZXMgdGhlIGZvbGxvd2luZyBXPTEgd2FybmluZzoNCj4+DQo+
PiAgIGRyaXZlcnMvdXNiL2R3YzIvZ2FkZ2V0LmM6IEluIGZ1bmN0aW9uIOKAmGR3YzJfaHNvdGdf
ZXBpbnTigJk6DQo+PiAgIGRyaXZlcnMvdXNiL2R3YzIvZ2FkZ2V0LmM6Mjk4MTo2OiB3YXJuaW5n
OiB2YXJpYWJsZSDigJhjdHJs4oCZIHNldCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWJ1dC1zZXQt
dmFyaWFibGVdDQo+PiAgIDI5ODEgfCB1MzIgY3RybDsNCj4+ICAgfCBefn5+DQo+Pg0KPj4gQ2M6
IE1pbmFzIEhhcnV0eXVueWFuIDxobWluYXNAc3lub3BzeXMuY29tPg0KPj4gQ2M6IEJlbiBEb29r
cyA8YmVuQHNpbXRlYy5jby51az4NCj4+IFNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpv
bmVzQGxpbmFyby5vcmc+DQo+PiAtLS0NCj4+ICAgZHJpdmVycy91c2IvZHdjMi9nYWRnZXQuYyB8
IDIgLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDIgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdXNiL2R3YzIvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MyL2dhZGdl
dC5jDQo+PiBpbmRleCAxMTZlNjE3NWM3YTQ4Li5mYTA3ZTNmY2I4ODQxIDEwMDY0NA0KPj4gLS0t
IGEvZHJpdmVycy91c2IvZHdjMi9nYWRnZXQuYw0KPj4gKysrIGIvZHJpdmVycy91c2IvZHdjMi9n
YWRnZXQuYw0KPj4gQEAgLTI5NzUsMTAgKzI5NzUsOCBAQCBzdGF0aWMgdm9pZCBkd2MyX2hzb3Rn
X2VwaW50KHN0cnVjdCBkd2MyX2hzb3RnICpoc290ZywgdW5zaWduZWQgaW50IGlkeCwNCj4+ICAg
CXUzMiBlcGN0bF9yZWcgPSBkaXJfaW4gPyBESUVQQ1RMKGlkeCkgOiBET0VQQ1RMKGlkeCk7DQo+
PiAgIAl1MzIgZXBzaXpfcmVnID0gZGlyX2luID8gRElFUFRTSVooaWR4KSA6IERPRVBUU0laKGlk
eCk7DQo+PiAgIAl1MzIgaW50czsNCj4+IC0JdTMyIGN0cmw7DQo+PiAgIA0KPj4gICAJaW50cyA9
IGR3YzJfZ2FkZ2V0X3JlYWRfZXBfaW50ZXJydXB0cyhoc290ZywgaWR4LCBkaXJfaW4pOw0KPj4g
LQljdHJsID0gZHdjMl9yZWFkbChoc290ZywgZXBjdGxfcmVnKTsNCj4gDQo+IEFzIHlvdSBrbm93
LCBsb3RzIG9mIGhhcmR3YXJlIHJlcXVpcmVzIHJlYWRzIHRvIGhhcHBlbiB0byBkbyB0aGluZ3Ms
IHNvDQo+IGFyZSB5b3Ugc3VyZSBpdCBpcyBzYWZlIHRvIHJlbW92ZSB0aGlzIHJlYWQgY2FsbD8N
Cj4gDQoNCkdyZWcsIHllcywgaXQncyBPayB0byByZW1vdmUgdGhpcyB1bm5lY2Vzc2FyeSByZWFk
IHdoaWNoIHJlbWFpbmVkIGZyb20gDQpwcmV2aW91cyBpbXBsZW1lbnRhdGlvbnMuDQoNCkxlZSwg
cGxlYXNlIGFkZCAiRml4ZXM6IiB0YWcgYW5kIHJlc3VibWl0IHYyLg0KDQpUaGFua3MsDQpNaW5h
cw0KDQoNCj4gdGhhbmtzLA0KPiANCj4gZ3JlZyBrLWgNCj4gDQo=
