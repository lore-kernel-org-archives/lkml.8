Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EF1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 08:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8C64207ED
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 08:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="hErCw1Pc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="sU+NI+OQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgFIIf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 04:35:57 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:36152 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726463AbgFIIf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 04:35:56 -0400
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 01F3A4024E;
        Tue,  9 Jun 2020 08:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1591691756; bh=K/jKswHy6VZfLoO+gw0gmIMhVgQSp/gKXnfsMHJjfX0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=hErCw1PcGgJjHm5YIHOPtbPyNsLtYQp1pJy2WsWUZJzEW/+hKzkkbpMDU8k78ovXW
         C2ruHQ6YeiphdDtSfuuyPREFNTdpv8EbyEscsJruaquBBnUn/0OraI55vADKjarNm/
         5yyd+sGVslidrXo2dlbmTGKdrTKgy7Mk5Ce7/Q7iftwcSHyIHDmQLm1ePKrV6Y2q5r
         qEU5aqFvkndcsRKTmTILPGouewh8Qt2lFVMfEs5pXE8pgOJPNWm5oO2sGV7xN7E7I7
         8YE25MrKWeiF4EAT7OQsJMLw7fhLXwvsRnycXibiVjq6jtmQHgfS9tc1hPUdfdqYJG
         sLtqtxsoNAqHQ==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 372A0A0080;
        Tue,  9 Jun 2020 08:35:53 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; spf=pass (mailfrom) smtp.mailfrom=synopsys.com (client-ip=104.47.58.108; helo=nam10-dm6-obe.outbound.protection.outlook.com; envelope-from=hminas@synopsys.com; receiver=<UNKNOWN>)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="sU+NI+OQ";
        dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 33EF4800D1;
        Tue,  9 Jun 2020 08:35:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwjOPKV4zDChNfvlpzPiploNeM1YdbvH4aoMPO8vYz1sOu4+/8/Hi2xneXB102CjreeIDNEhTK/z75695/6FQ7ST99tNp7+urFZsDxfZPoyVMP00nXtbZcA7daI7cWzgFHRpfqEHVnTtHmcrz6RZV/S5X+3PSrQqZS+edI7tuzOH8IspxXoDy4kUM00vh3gvjEn84qyFKChAtoxXM98jTVsFly4KIYbBjk4tPmLU3SerRXJT+/9rfh71yoYmHXy9V0ddZM+7FN7haTsy23vdNfp88CL5MOM1ce+MsbRw+8DdVo/W08XGKmHSFsCTY1qkHraZbS+itOtxm/nWOaa9EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/jKswHy6VZfLoO+gw0gmIMhVgQSp/gKXnfsMHJjfX0=;
 b=TiVmEydgBOnBSpxk810Btx1UTRdGTWkH42sQPRHPXYShd0OV0c0P6o4aIdpVnqiiC4QmyL/pT+t/NKwzz/hZ++nuNrsX/VeYL/zucFYhbUmRJWblyeK7MU/c92pQWHoMbo6rVivT2WkZtbbls+DGzfhUusdZi2H2jhMHg43bOVGPdNNTLZuEdub8K5XQ4P8Uz3bZI27Ux1sbO0CtiIR38lj4yQfpHza0fQqlXA38efoATxIwoPVliVusOjr5ybTV1tHOfhEsmxlkpnxbjuwpAjA2O1JW5o1kFCSLVfLFeYDgu2UJpkXN1NyHVBWDvwiP9dmtU9HArXYBJ6U68N+h+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/jKswHy6VZfLoO+gw0gmIMhVgQSp/gKXnfsMHJjfX0=;
 b=sU+NI+OQPKSC7vFJgsifzNWWvkNYqeP/AHEkELIoXuTNj0xBFggyJDRhySTLGXXTgTsPr7nE5H8j+zJnGGl57pXW90gMlD/ahKAOg2r2nELsnO4x2/k99Ub/Dk8u3pjbg1LK83zyGeqCoFeg5olmDlZSU5EFZ3akRkVGIP4Gb6I=
Received: from SN1PR12MB2557.namprd12.prod.outlook.com (2603:10b6:802:22::15)
 by SN1PR12MB2575.namprd12.prod.outlook.com (2603:10b6:802:25::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Tue, 9 Jun
 2020 08:35:50 +0000
Received: from SN1PR12MB2557.namprd12.prod.outlook.com
 ([fe80::78a8:d153:7e1c:57a5]) by SN1PR12MB2557.namprd12.prod.outlook.com
 ([fe80::78a8:d153:7e1c:57a5%7]) with mapi id 15.20.3066.023; Tue, 9 Jun 2020
 08:35:50 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Pavel Machek <pavel@denx.de>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "trivial@kernel.org" <trivial@kernel.org>
Subject: Re: [PATCH] sr: dwc2/gadget: remove unneccessary if
Thread-Topic: [PATCH] sr: dwc2/gadget: remove unneccessary if
Thread-Index: AQHWPBhw3SL7LTHMVUK+qAoLyD/PXKjLur6AgAA32YCABAcrAA==
Date:   Tue, 9 Jun 2020 08:35:50 +0000
Message-ID: <3ccc1177-9e4c-130b-ab9a-f02169164ac4@synopsys.com>
References: <20200606153703.GA18931@amd>
 <4057a9d1-2cf4-78a1-9f29-587a87b523b4@synopsys.com>
 <20200606190507.GA13421@amd>
In-Reply-To: <20200606190507.GA13421@amd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
authentication-results: denx.de; dkim=none (message not signed)
 header.d=none;denx.de; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [198.182.37.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78cb0992-dff3-4cc2-5964-08d80c501d93
x-ms-traffictypediagnostic: SN1PR12MB2575:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN1PR12MB2575F46A4B8DB310F14EB700A7820@SN1PR12MB2575.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 042957ACD7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Kdeg0T8gqsqAheibK7TiSazVFDWgPNW7TyZXGnZ60kQENXc6gULTGH0IiwXGlOXww+MGUc8gfGuUuMrO3EA60EdHAJUwpdnsWsFFCBDbR0n83hXwrKgv7mnOGQ3NXUotlJhty3km/53KBJ/01AdmzqYtq8kcUcw/FfgEMl4da35TDM2AYHjTWCu/rZjp5gNZuxWuSeP38pd4s3MPJiFP0udGN/l7/ZcHn/aj2bE2OBkFcG78YXbyxnqHYXzhhFgD3390Naqz7+dqz0wsvxsZ4umnyhKfgQOngT1LeizSzwpwDUtkfaHOgss5Xu57KdWYBYwzUacUZ27LtzOPmDRZmlSlUZNkUMDM5VMCp7bXLzz5Srrem+DkVoE5XamiZiXu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(376002)(346002)(136003)(396003)(366004)(66946007)(6512007)(26005)(31696002)(316002)(54906003)(2906002)(110136005)(66556008)(64756008)(66476007)(8936002)(31686004)(76116006)(6506007)(478600001)(53546011)(4326008)(91956017)(83380400001)(2616005)(6486002)(66446008)(86362001)(36756003)(8676002)(5660300002)(186003)(71200400001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: GcDE5w9keWXhbvc61t29pLWJVWmIl1qOlhdQO9X9Aw0FFGFYzuREuwRNYKL8pH2CRFvnk3635fpQqpRwsejvwrkSzVosU/Jow6DvpAwiNWYxtyjuBWUAIlcQlx4Qm0Y3r/qr22EFuXSswmHda6UhlXQhw4qRilWKIE7s5jxyoXxulgAkax8Gb/ZGEizSAAFxUe+ulpGxQ+BaiKvQmW5TE9DHV7MIFZawrLu7E2BCaLUL0etymE86LqE8/cXniexTj7AuUdngzt/f/eIMJ/moL296cnWsnhn/k93lXJoIOhdWbbaol9IH5HzN7f4/7NkxhwQCB5lbP4YyfjBimoDpVpPpyj0viZPM5FE0uxLKA1vLk74OwRXk3n4itRJ2mywiEJXlJ3F3SQHiYxxYkFi2rFzQEKwd13jFOyGUTCxR8vymTdogSV4OECC8ZVDoUzpvMDI3/0g98PkFk4NY5J5WfClZGFRpT1Nz/piAR53I6WdXOBRzkOjVnzlOIwf6XMRo
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D3422BAAA17314381136FBC7E2558BE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78cb0992-dff3-4cc2-5964-08d80c501d93
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2020 08:35:50.4518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oU9VD1afRk+fveBqXXr+h7iPkw7sigLZIAQDCW5AiUAP/a8b4Z3csWDM9j9oxXucEm8+CDYN7WJkHvF4AnQ51g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2575
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIDYvNi8yMDIwIDExOjA1IFBNLCBQYXZlbCBNYWNoZWsgd3JvdGU6DQo+IEhpIQ0K
PiANCj4+PiBXZSBkb24ndCByZWFsbHkgbmVlZCBpZi9lbHNlIHRvIHNldCB2YXJpYWJsZSB0byAx
LzAuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBQYXZlbCBNYWNoZWsgKENJUCkgPHBhdmVsQGRl
bnguZGU+DQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMi9nYWRnZXQuYyBi
L2RyaXZlcnMvdXNiL2R3YzIvZ2FkZ2V0LmMNCj4+PiBpbmRleCAxMmI5OGI0NjYyODcuLmY5ZjZm
ZDQ3MGM4MSAxMDA2NDQNCj4+PiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MyL2dhZGdldC5jDQo+Pj4g
KysrIGIvZHJpdmVycy91c2IvZHdjMi9nYWRnZXQuYw0KPj4+IEBAIC0xNzYxLDEwICsxNzYxLDcg
QEAgc3RhdGljIGludCBkd2MyX2hzb3RnX3Byb2Nlc3NfcmVxX2ZlYXR1cmUoc3RydWN0IGR3YzJf
aHNvdGcgKmhzb3RnLA0KPj4+ICAgIAljYXNlIFVTQl9SRUNJUF9ERVZJQ0U6DQo+Pj4gICAgCQlz
d2l0Y2ggKHdWYWx1ZSkgew0KPj4+ICAgIAkJY2FzZSBVU0JfREVWSUNFX1JFTU9URV9XQUtFVVA6
DQo+Pj4gLQkJCWlmIChzZXQpDQo+Pj4gLQkJCQloc290Zy0+cmVtb3RlX3dha2V1cF9hbGxvd2Vk
ID0gMTsNCj4+PiAtCQkJZWxzZQ0KPj4+IC0JCQkJaHNvdGctPnJlbW90ZV93YWtldXBfYWxsb3dl
ZCA9IDA7DQo+Pj4gKwkJCWhzb3RnLT5yZW1vdGVfd2FrZXVwX2FsbG93ZWQgPSBzZXQ7DQo+Pj4g
ICAgCQkJYnJlYWs7DQo+Pj4gICAgDQo+Pj4gICAgCQljYXNlIFVTQl9ERVZJQ0VfVEVTVF9NT0RF
Og0KPj4+DQo+Pg0KPj4gSXQncyBnb29kIGNhdGNoLCBidXQgJ3NldCcgZGVjbGFyZWQgYXMgJ2Jv
b2wnIHdoaWxlDQo+PiAncmVtb3RlX3dha2V1cF9hbGxvd2VkJyBpcyAndW5zaWduZWQgaW50Jy4g
TWF5YmUgdXBkYXRlICdzZXQnIHR5cGUgdG8gc2FtZS4NCj4gDQo+IEkga25vdyBzZXQgaXMgYm9v
bC4gQnV0IHRoYXQgc2hvdWxkIG5vdCBtYXR0ZXIsIGNvZGUgaXMgb2theSBhbmQNCj4gY29tcGls
ZXIgd2lsbCBkbyB0aGUgcmlnaHQgdGhpbmc6DQo+IA0KPiBwYXZlbEBhbWQ6L3RtcCQgY2F0IGRl
bG1lLmMNCj4gI2luY2x1ZGUgPHN0ZGJvb2wuaD4NCj4gDQo+IHZvaWQgbWFpbih2b2lkKQ0KPiB7
DQo+ICAgIGJvb2wgYSA9IGZhbHNlOw0KPiAgICAgIGludCBiID0gYTsNCj4gICB9DQo+ICAgcGF2
ZWxAYW1kOi90bXAkIGdjYyAtc3RkPWM5OSAtV2FsbCBkZWxtZS5jDQo+ICAgICAgZGVsbWUuYzoz
OjY6IHdhcm5pbmc6IHJldHVybiB0eXBlIG9mIOKAmG1haW7igJkgaXMgbm90IOKAmGludOKAmSBb
LVdtYWluXQ0KPiAgICAgICB2b2lkIG1haW4odm9pZCkNCj4gICAgICAgICAgICAgXg0KPiAJICAg
ZGVsbWUuYzogSW4gZnVuY3Rpb24g4oCYbWFpbuKAmToNCj4gICBkZWxtZS5jOjY6Nzogd2Fybmlu
ZzogdW51c2VkIHZhcmlhYmxlIOKAmGLigJkNCj4gICBbLVd1bnVzZWQtdmFyaWFibGVdDQo+IAkg
ICAgICBpbnQgYiA9IGE7DQo+IAkgICAgICAgICAgICAgXg0KPiANCj4gQmVzdCByZWdhcmRzLA0K
PiAJCQkJCQkJCVBhdmVsDQo+IA0KDQpUbyBhdm9pZCBhbnkgcG9zc2libGUgY2hlY2sgcGF0Y2gg
aXNzdWVzIHVwZGF0ZSB0eXBlIG9mICJzZXQiIGZyb20gYm9vbCANCnRvIHNhbWUgYXMgInJlbW90
ZV93YWtldXBfYWxsb3dlZCIuDQpQbGVhc2UgdXBkYXRlIHlvdXIgcGF0Y2ggdG9waWMgdG8gInVz
YjogZHdjMjogZ2FkZ2V0OiByZW1vdmUgdW5uZWNlc3NhcnkgDQppZiIgYW5kIHJlc3VibWl0Lg0K
DQpUaGFua3MsDQpNaW5hcw0KDQo=
