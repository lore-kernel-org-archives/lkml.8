Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06A4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 03:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A94242078B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 03:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="E2nJhRfm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="w9VyD+I8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgHTDB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 23:01:29 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:47650 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726697AbgHTDB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 23:01:27 -0400
Received: from mailhost.synopsys.com (sv2-mailhost1.synopsys.com [10.205.2.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B2DD9402EC;
        Thu, 20 Aug 2020 03:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1597892486; bh=/3rgfTnStRpbVULv74xvhz4Vfct0HX+jozFAIXxrs5A=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=E2nJhRfm7ENkVsX3bvF41xYtgTlG1dmVAWHAE6nxUoBJ9nzyXx2mL7uZIqUXom64F
         NfCrOir7z9KjepyPsZUAEdjjCEZjdQ6yLUjUNZauIXXRi8Xw6kV6Av0n82qtSHBlIS
         RfkBlzEDMg5DoEC546aKVrxblEzlUC0gl/R33wUoSmbb3UrgKZjap3NXKzu7+FsHB+
         mDSU36Bu1x07t8UH6MDSVzZVvf14Evas9W/xHi9ZLtLBaeAOneXA4A4M/UmRJciF38
         sen9/Ns2teKvKXEAQjMNYKveWBlnfF9jM4OuDEjNO+jo4/1WjS+q9UAqO4JowwUUSS
         jtPYeSaTGw1Ew==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 16B9BA0250;
        Thu, 20 Aug 2020 03:01:26 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5F49180FA8;
        Thu, 20 Aug 2020 03:01:25 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="w9VyD+I8";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Elc+PRsXwhWkHUWq+5Q3l5jfhdqkGq8odFfaUPvg/NLMD+FyR8y53w48UhxaL0khV+r+P74DG7T3vFf/7Tm/o7fGcwh3zzlwAg4jaO8NDud/f8z+hcf/vKi2tYTgxs9v6QPFrx8Vvoj9zCApOag8bC3CIypNJ480zBKzJeIBLTzA0YE89VHZniFqxQ1r7xUgXL7dq6t7Dh4U/QNJCFIVR+OkkGIlHvn0zYYFDgCx7tY1aboPTfa905p3gjFrRn4vmooLSyEc0+X5GTsaxLe+pn4tqN/c30fVToSL8le42Rv5ipBpzCgmjUr5x82rko6FMkxeSkDExTrQ4t2iAFdpPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3rgfTnStRpbVULv74xvhz4Vfct0HX+jozFAIXxrs5A=;
 b=ni1tScAfr4uWY/CetsTWRc446cCyr+YqCfyVPaIQvehfu6ZbMtItkpTctnZw6kwvwxnCvyvnllwFV4woQCjKigOVDTw4G3GFiaVaDs7XB0Pmf3rescjPnH0g4avWynbSWPmqn6kgm9V+cbgfUs45TTHNGPZK5ikaSy4cjshG+Gu248T/KJE20brpS7n+pjIYxI6eXUjUaix9e52i7WFt9bPu9SiIwyUuPfyjp40DfS5LbjeJH7rUHgDerQ/Z/U3SHcQNeYHSjKm/Ynl7w2yXDAfqhqlpx917vzhzJRocR5wtcvDujjFHlxxa3wYMcyxzCIMU4moOCyz01QMqm5TqXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3rgfTnStRpbVULv74xvhz4Vfct0HX+jozFAIXxrs5A=;
 b=w9VyD+I8a9iIPEZ0k1GG2UEY166lWOggKNmAdH98+aWRt8HBFb2qa5e1arqi8osryoWzhDl3293nWMuVTkgOqJ2lAG+i3dcWYuzWPEaRjTHJZUcMo8lYvcgxoCVvOPub7MBHwVFdT17e9Mrxq8RILEBZH5DRMj59kS9DQAm32X8=
Received: from BYAPR12MB2917.namprd12.prod.outlook.com (2603:10b6:a03:130::14)
 by BY5PR12MB4308.namprd12.prod.outlook.com (2603:10b6:a03:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 20 Aug
 2020 03:01:22 +0000
Received: from BYAPR12MB2917.namprd12.prod.outlook.com
 ([fe80::c98f:a13f:fd88:c209]) by BYAPR12MB2917.namprd12.prod.outlook.com
 ([fe80::c98f:a13f:fd88:c209%7]) with mapi id 15.20.3283.028; Thu, 20 Aug 2020
 03:01:22 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <wcheng@codeaurora.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "jackp@codeaurora.org" <jackp@codeaurora.org>
Subject: Re: [PATCH] usb: dwc3: Stop active transfers before halting the
 controller
Thread-Topic: [PATCH] usb: dwc3: Stop active transfers before halting the
 controller
Thread-Index: AQHWdega2upQyFI7nU28MH7ylEdDLak/94UAgABHpoCAABFhgA==
Date:   Thu, 20 Aug 2020 03:01:22 +0000
Message-ID: <913c1fb2-72e5-328a-a890-5c9ca5661134@synopsys.com>
References: <20200819051739.22123-1-wcheng@codeaurora.org>
 <3917c516-7251-5b13-2192-0820c125eced@synopsys.com>
 <65645474-c136-c226-7762-db46ddb2c67a@codeaurora.org>
In-Reply-To: <65645474-c136-c226-7762-db46ddb2c67a@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [149.117.7.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8ae5b6b-e2e3-47e1-d131-08d844b551c3
x-ms-traffictypediagnostic: BY5PR12MB4308:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB430804F5C76BD2C474C6F0E5AA5A0@BY5PR12MB4308.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tDv1R0NEVZQvzuDLzBYXGJQxa/WVHuF9D8gv73EXvhigkU4nMHzTOEEa61FfG5oT8K4mVQ5cteTil43k9J0WKavIA3g3xhuLMn+zMlI/mt0O1c6hzn4xN4NTELtxBK6JNGFxgYvJfi/HUVE3tYSu3RE11rGJRj8+le11B1Jt4K/nVYFq+JDkwTGAcOCbqVYUJFVrgmRN8lFrHbyYd3L6ZvAUjcQ/xzX6xwL3LcV7jVAjtANBxAnA/JLAH/0Hupm2SsoCiD9XoLRZpPQlwoPJmhUN1iRB2FkZx0xfyMiaz4rhxUnD2Kw1tIvvIC/mcgAnQoYSavZC45iVXMEMyQWkEBll/YyV4JM5n5mHoe6wfX1zxP9gHOh/URDqa2XHzgEv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2917.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(376002)(39860400002)(346002)(136003)(83380400001)(6486002)(71200400001)(2906002)(8676002)(5660300002)(54906003)(64756008)(36756003)(66446008)(66476007)(31686004)(66556008)(66946007)(316002)(4326008)(76116006)(6512007)(31696002)(6506007)(53546011)(8936002)(478600001)(2616005)(110136005)(186003)(26005)(86362001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: X92+pnHrYf/Wa5RkMXjaaBtnrFLj+HDrTOs1H6dbaXCJ+OKHCs0zVJaory6HbYhvBaK8/BvbN1lABnU1c4tdTtmBXJ2b8Q3BLSdY5BHdh7Au2BkLgv8Rt7AE3xgM+KiKx6HpAcW2d9sjlr4eIDXeSXhqJJEb5F8nBkxDu4IcUyuWDL7Kuyjw0Guz+eSONc9ibRSdhcWBuqUgKK1eeWg/j006H+FQfi7+QGesYTGriV4LSMVu4OwHnF7tftr3Z+bBnSphGTo0B/1Q6fgj9OyuXlGRve1HsZ+gnbi5/BzP0KZU3caQptkA8svM6zhpT3rYwqi6cR6S+gVFzkU1NIBLC0o7iWs2uCM7e9qm6+0UZvHW2lm8jrcAhWKZrZPP8ymqnE1G9j9mKy4mkt6zh8R5/VhaLK4thwwSENH7mLCA71E148Bg5LHgc2SsS25lIHwOHMYYzZ+9au8YVfwMW4VQsFxar2YgbNbbokDDCgx/89LkOLvqtwsVG0HS6pSiwLdgnrkafGpo06G4z0PjlX8H228zI9eKRG/UxxbwjLTCHmAOFrGeBuy3SmiJkFkAiVGToGhK6/kfsQviDXhp9KdgHcFAsFozjNlI1Wm62zyU3RgiiVFJ5E1nrhgOtMI6hyuCQNXYmqmGYmX7ofxxsVkMqw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <DEDED085F2E9914ABA216361CD4C257B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2917.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ae5b6b-e2e3-47e1-d131-08d844b551c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2020 03:01:22.3822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cOhZzSVR0lgOV31UA+CvVm5BEmY54LmXpJn+elLp5FVcFRjGYQbTLTOW94L7QQV4N/KB8XKX9buanExeO6hQig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4308
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2VzbGV5IENoZW5nIHdyb3RlOg0KPiBPbiA4LzE5LzIwMjAgMjo0MiBQTSwgVGhpbmggTmd1eWVu
IHdyb3RlOg0KPj4gSGksDQo+Pg0KPj4gV2VzbGV5IENoZW5nIHdyb3RlOg0KPj4+IEluIHRoZSBE
V0MzIGRhdGFib29rLCBmb3IgYSBkZXZpY2UgaW5pdGlhdGVkIGRpc2Nvbm5lY3QsIHRoZSBkcml2
ZXIgaXMNCj4+PiByZXF1aXJlZCB0byBzZW5kIGRlcGVuZHhmZXIgY29tbWFuZHMgZm9yIGFueSBw
ZW5kaW5nIHRyYW5zZmVycy4NCj4+PiBJbiBhZGRpdGlvbiwgYmVmb3JlIHRoZSBjb250cm9sbGVy
IGNhbiBtb3ZlIHRvIHRoZSBoYWx0ZWQgc3RhdGUsIHRoZSBTVw0KPj4+IG5lZWRzIHRvIGFja25v
d2xlZGdlIGFueSBwZW5kaW5nIGV2ZW50cy4gIElmIHRoZSBjb250cm9sbGVyIGlzIG5vdCBoYWx0
ZWQNCj4+PiBwcm9wZXJseSwgdGhlcmUgaXMgYSBjaGFuY2UgdGhlIGNvbnRyb2xsZXIgd2lsbCBj
b250aW51ZSBhY2Nlc3Npbmcgc3RhbGUgb3INCj4+PiBmcmVlZCBUUkJzIGFuZCBidWZmZXJzLg0K
Pj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogV2VzbGV5IENoZW5nIDx3Y2hlbmdAY29kZWF1cm9yYS5v
cmc+DQo+Pj4NCj4+PiAtLS0NCj4+PiBWZXJpZmllZCBmaXggYnkgYWRkaW5nIGEgY2hlY2sgZm9y
IEVUSU1FRE9VVCBkdXJpbmcgdGhlIHJ1biBzdG9wIGNhbGwuDQo+Pj4gU2hlbGwgc2NyaXB0IHdy
aXRpbmcgdG8gdGhlIGNvbmZpZ2ZzIFVEQyBmaWxlIHRvIHRyaWdnZXIgZGlzY29ubmVjdCBhbmQN
Cj4+PiBjb25uZWN0LiAgQmF0Y2ggc2NyaXB0IHRvIGhhdmUgUEMgZXhlY3V0ZSBkYXRhIHRyYW5z
ZmVycyBvdmVyIGFkYiAoaWUgYWRiDQo+Pj4gcHVzaCkgIEFmdGVyIGEgZmV3IGl0ZXJhdGlvbnMs
IHdlJ2QgcnVuIGludG8gYSBzY2VuYXJpbyB3aGVyZSB0aGUNCj4+PiBjb250cm9sbGVyIHdhc24n
dCBoYWx0ZWQuICBXaXRoIHRoZSBmb2xsb3dpbmcgY2hhbmdlLCBubyBmYWlsZWQgaGFsdHMgYWZ0
ZXINCj4+PiBtYW55IGl0ZXJhdGlvbnMuDQoNCkJ0dywgd2UgaGF2ZSBzb21lIHN5c2ZzIGF0dHJp
YnV0ZXMgdG8gZG8gc29mdC1jb25uZWN0L2Rpc2Nvbm5lY3QgYWxzbw0KL3N5cy9jbGFzcy91ZGMv
PFVEQz4vc29mdF9jb25uZWN0DQoNCg0KPj4+IC0tLQ0KPj4+ICBkcml2ZXJzL3VzYi9kd2MzL2Vw
MC5jICAgIHwgIDIgKy0NCj4+PiAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8IDU5ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQ0KPj4+ICAyIGZpbGVzIGNoYW5nZWQs
IDU3IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy91c2IvZHdjMy9lcDAuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZXAwLmMNCj4+PiBpbmRl
eCA1OWYyZThjMzFiZDEuLjQ1NmFhODdlODc3OCAxMDA2NDQNCj4+PiAtLS0gYS9kcml2ZXJzL3Vz
Yi9kd2MzL2VwMC5jDQo+Pj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9lcDAuYw0KPj4+IEBAIC0x
OTcsNyArMTk3LDcgQEAgaW50IGR3YzNfZ2FkZ2V0X2VwMF9xdWV1ZShzdHJ1Y3QgdXNiX2VwICpl
cCwgc3RydWN0IHVzYl9yZXF1ZXN0ICpyZXF1ZXN0LA0KPj4+ICAJaW50CQkJCXJldDsNCj4+PiAg
DQo+Pj4gIAlzcGluX2xvY2tfaXJxc2F2ZSgmZHdjLT5sb2NrLCBmbGFncyk7DQo+Pj4gLQlpZiAo
IWRlcC0+ZW5kcG9pbnQuZGVzYykgew0KPj4+ICsJaWYgKCFkZXAtPmVuZHBvaW50LmRlc2MgfHwg
IWR3Yy0+cHVsbHVwc19jb25uZWN0ZWQpIHsNCj4+PiAgCQlkZXZfZXJyKGR3Yy0+ZGV2LCAiJXM6
IGNhbid0IHF1ZXVlIHRvIGRpc2FibGVkIGVuZHBvaW50XG4iLA0KPj4+ICAJCQkJZGVwLT5uYW1l
KTsNCj4+PiAgCQlyZXQgPSAtRVNIVVRET1dOOw0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Vz
Yi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPj4+IGluZGV4IDNh
YjZmMTE4YzUwOC4uMWY5ODE5NDJkN2Y5IDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvdXNiL2R3
YzMvZ2FkZ2V0LmMNCj4+PiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+Pj4gQEAg
LTE1MTYsNyArMTUxNiw3IEBAIHN0YXRpYyBpbnQgX19kd2MzX2dhZGdldF9lcF9xdWV1ZShzdHJ1
Y3QgZHdjM19lcCAqZGVwLCBzdHJ1Y3QgZHdjM19yZXF1ZXN0ICpyZXEpDQo+Pj4gIHsNCj4+PiAg
CXN0cnVjdCBkd2MzCQkqZHdjID0gZGVwLT5kd2M7DQo+Pj4gIA0KPj4+IC0JaWYgKCFkZXAtPmVu
ZHBvaW50LmRlc2MpIHsNCj4+PiArCWlmICghZGVwLT5lbmRwb2ludC5kZXNjIHx8ICFkd2MtPnB1
bGx1cHNfY29ubmVjdGVkKSB7DQo+Pj4gIAkJZGV2X2Vycihkd2MtPmRldiwgIiVzOiBjYW4ndCBx
dWV1ZSB0byBkaXNhYmxlZCBlbmRwb2ludFxuIiwNCj4+PiAgCQkJCWRlcC0+bmFtZSk7DQo+Pj4g
IAkJcmV0dXJuIC1FU0hVVERPV047DQo+Pj4gQEAgLTE5MjYsNiArMTkyNiwyNCBAQCBzdGF0aWMg
aW50IGR3YzNfZ2FkZ2V0X3NldF9zZWxmcG93ZXJlZChzdHJ1Y3QgdXNiX2dhZGdldCAqZywNCj4+
PiAgCXJldHVybiAwOw0KPj4+ICB9DQo+Pj4gIA0KPj4+ICtzdGF0aWMgdm9pZCBkd2MzX3N0b3Bf
YWN0aXZlX3RyYW5zZmVycyhzdHJ1Y3QgZHdjMyAqZHdjKQ0KPj4+ICt7DQo+Pj4gKwl1MzIgZXBu
dW07DQo+Pj4gKw0KPj4+ICsJZm9yIChlcG51bSA9IDI7IGVwbnVtIDwgRFdDM19FTkRQT0lOVFNf
TlVNOyBlcG51bSsrKSB7DQo+Pj4gKwkJc3RydWN0IGR3YzNfZXAgKmRlcDsNCj4+PiArDQo+Pj4g
KwkJZGVwID0gZHdjLT5lcHNbZXBudW1dOw0KPj4+ICsJCWlmICghZGVwKQ0KPj4+ICsJCQljb250
aW51ZTsNCj4+PiArDQo+Pj4gKwkJaWYgKCEoZGVwLT5mbGFncyAmIERXQzNfRVBfRU5BQkxFRCkp
DQo+Pj4gKwkJCWNvbnRpbnVlOw0KPj4+ICsNCj4+PiArCQlkd2MzX3JlbW92ZV9yZXF1ZXN0cyhk
d2MsIGRlcCk7DQo+Pj4gKwl9DQo+Pj4gK30NCj4+PiArDQo+Pj4gIHN0YXRpYyBpbnQgZHdjM19n
YWRnZXRfcnVuX3N0b3Aoc3RydWN0IGR3YzMgKmR3YywgaW50IGlzX29uLCBpbnQgc3VzcGVuZCkN
Cj4+PiAgew0KPj4+ICAJdTMyCQkJcmVnOw0KPj4+IEBAIC0xOTUwLDE2ICsxOTY4LDM3IEBAIHN0
YXRpYyBpbnQgZHdjM19nYWRnZXRfcnVuX3N0b3Aoc3RydWN0IGR3YzMgKmR3YywgaW50IGlzX29u
LCBpbnQgc3VzcGVuZCkNCj4+PiAgDQo+Pj4gIAkJZHdjLT5wdWxsdXBzX2Nvbm5lY3RlZCA9IHRy
dWU7DQo+Pj4gIAl9IGVsc2Ugew0KPj4+ICsJCWR3Yy0+cHVsbHVwc19jb25uZWN0ZWQgPSBmYWxz
ZTsNCj4+PiArDQo+Pj4gKwkJX19kd2MzX2dhZGdldF9lcF9kaXNhYmxlKGR3Yy0+ZXBzWzBdKTsN
Cj4+PiArCQlfX2R3YzNfZ2FkZ2V0X2VwX2Rpc2FibGUoZHdjLT5lcHNbMV0pOw0KPj4gcnVuX3N0
b3AoKSBmdW5jdGlvbiBzaG91bGRuJ3QgYmUgZG9pbmcgdGhpcy4gVGhpcyBpcyBkb25lIGluDQo+
PiBkd2MzX2dhZGdldF9zdG9wKCkuIEFsc28sIGlmIGl0J3MgZGV2aWNlLWluaXRpYXRlZCBkaXNj
b25uZWN0LCBkcml2ZXINCj4+IG5lZWRzIHRvIHdhaXQgZm9yIGNvbnRyb2wgdHJhbnNmZXJzIHRv
IGNvbXBsZXRlLg0KPj4NCj4gSGkgVGhpbmggLA0KPg0KPiBUaGFua3MgZm9yIHRoZSBmZWVkYmFj
ay4NCg0KVGhhbmtzIGZvciB0aGUgcGF0Y2ggOikNCg0KPg0KPiBXZSBhbHJlYWR5IHdhaXQgZm9y
IHRoZSBlcDBzdGF0ZSB0byBtb3ZlIHRvIHRoZSBzZXR1cCBzdGFnZSBiZWZvcmUNCj4gcnVubmlu
ZyB0aGUgcnVuIHN0b3Agcm91dGluZSwgYnV0IGV2ZW50cyBjYW4gc3RpbGwgYmUgdHJpZ2dlcmVk
IHVudGlsDQo+IHRoZSBjb250cm9sbGVyIGlzIGhhbHRlZC4gKHdoaWNoIGlzIG5vdCBzdGFydGVk
IHVudGlsIHdlIGF0dGVtcHQgdG8NCj4gd3JpdGUgdG8gdGhlIERDVEwgcmVnaXN0ZXIpIFRoZSBy
ZWFzb25pbmcgd2lsbCBiZSB0aGUgc2FtZSBhcyB0aGUgYmVsb3cNCj4gY29tbWVudC4NCj4NCj4+
PiArDQo+Pj4gKwkJLyoNCj4+PiArCQkgKiBUaGUgZGF0YWJvb2sgZXhwbGljaXRseSBtZW50aW9u
cyBmb3IgYSBkZXZpY2UtaW5pdGlhdGVkDQo+Pj4gKwkJICogZGlzY29ubmVjdCBzZXF1ZW5jZSwg
dGhlIFNXIG5lZWRzIHRvIGVuc3VyZSB0aGF0IGl0IGVuZHMgYW55DQo+Pj4gKwkJICogYWN0aXZl
IHRyYW5zZmVycy4NCj4+PiArCQkgKi8NCj4+PiArCQlkd2MzX3N0b3BfYWN0aXZlX3RyYW5zZmVy
cyhkd2MpOw0KPj4gSXQgc2hvdWxkbid0IGJlIGRvbmUgaGVyZS4gTWF5YmUgbW92ZSB0aGlzIHRv
IHRoZSBkd2MzX2dhZGdldF9wdWxsdXAoKQ0KPj4gZnVuY3Rpb24uIFRoZSBydW5fc3RvcCgpIGZ1
bmN0aW9uIGNhbiBiZSBjYWxsZWQgZm9yIG90aGVyIGNvbnRleHQgYmVzaWRlDQo+PiB0aGlzIChl
LmcuIGhpYmVybmF0aW9uKS4NCj4+DQo+IEl0IHdhcyBwcmVmZXJyZWQgdG8gaGF2ZSBpdCBwbGFj
ZWQgYWZ0ZXIgdGhlIHB1bGx1cHNfY29ubmVjdGVkIHdhcyBzZXQNCj4gdG8gZmFsc2UsIHNvIHRo
YXQgZnVydGhlciBlcCBxdWV1ZXMgd291bGQgYmUgYmxvY2tlZCAod2l0aCB0aGUgYWRkZWQNCj4g
Y2hlY2spLCBhbmQgd2UgY2FuIGVuc3VyZSBhZnRlciB0aGUgc3RvcCBhY3RpdmUgeGZlcnMgd2Fz
IHJ1biwgbm90aGluZw0KPiBjb3VsZCBiZSBwZW5kaW5nLg0KDQpJdCBzaG91bGQgYmUgZmluZSBp
ZiB5b3UgZG8gaXQgaW5zaWRlIHRoZSBzcGluX2xvY2sgb2YgdGhlDQpkd2MzX2dhZGdldF9wdWxs
dXAoKS4gSSdtIHRyeWluZyB0byBrZWVwIHRoZSBydW5fc3RvcCgpIGZ1bmN0aW9uDQpzZXBhcmF0
ZSBmb3IgdGhlIGNvbnRleHQgb2YgaGliZXJuYXRpb24uIEZvciBoaWJlcm5hdGlvbiwgdGhlIGRy
aXZlcg0KbmVlZHMgdG8gd2FpdCBmb3IgdGhlIGVuZF90cmFuc2ZlciBjb21tYW5kcyB0byBjb21w
bGV0ZSAodG8gc2F2ZSBUUkJzDQpzdGF0ZSBhbmQgdG8gcmVzdW1lIHRyYW5zZmVyIGxhdGVyKS4g
R3JhbnRlZCB0aGF0IHdlIGNhbiBqdXN0IGFkZCBhDQpjaGVjayAiaWYgKCFoaWJlcm5hdGlvbiki
IG9yIG1vZGlmeSB0aGUgY29kZSBsYXRlciwgYnV0IEkgdGhpbmsgaXQncw0KY2xlYW5lciB0aGlz
IHdheS4NCg0KPg0KPiBBbHNvLCBmb3IgdGhlIGhpYmVybmF0aW9uIGNhc2UsIHRoZSBkYXRhYm9v
ayBtZW50aW9ucyB0aGF0IHdlIHNob3VsZA0KPiBpc3N1ZSB0aGUgZW5kIHRyYW5zZmVyIHJvdXRp
bmUgYXMgd2VsbCBmb3IgdGhlIGhpYmVybmF0aW9uIHcvIGRldmljZQ0KPiBkaXNjb25uZWN0ZWQg
c2l0dWF0aW9uLg0KDQpUaGF0J3MgdHJ1ZSwgYnV0IHNlZSBteSBjb21tZW50IGFib3ZlLg0KDQo+
ICAoSSBkb24ndCBiZWxpZXZlIHRoZSBjdXJyZW50IERXQzMgZ2FkZ2V0IGRyaXZlcg0KPiBzdXBw
b3J0cyB0aGUgaGliZXJuYXRpb24gd2hpbGUgZGV2aWNlIGNvbm5lY3RlZCBjYXNlLCB3aGljaCBo
YXMgc29tZQ0KPiBjb25zaWRlcmF0aW9ucyB3ZSB3b3VsZCBuZWVkIHRvIGFkZHJlc3MpDQoNClJp
Z2h0IG5vdywgdGhlIERXQzMgZHJpdmVyIGRvZXNuJ3QgaGFuZGxlIGhpYmVybmF0aW9uIGF0IGFs
bC4gSSd2ZSB5ZXQNCnRvIHB1c2ggdGhvc2UgY2hhbmdlcyBvdXQuDQoNCj4NCj4+PiArDQo+Pj4g
IAkJcmVnICY9IH5EV0MzX0RDVExfUlVOX1NUT1A7DQo+Pj4gIA0KPj4+ICAJCWlmIChkd2MtPmhh
c19oaWJlcm5hdGlvbiAmJiAhc3VzcGVuZCkNCj4+PiAgCQkJcmVnICY9IH5EV0MzX0RDVExfS0VF
UF9DT05ORUNUOw0KPj4+IC0NCj4+PiAtCQlkd2MtPnB1bGx1cHNfY29ubmVjdGVkID0gZmFsc2U7
DQo+Pj4gIAl9DQo+Pj4gIA0KPj4+ICAJZHdjM19nYWRnZXRfZGN0bF93cml0ZV9zYWZlKGR3Yywg
cmVnKTsNCj4+PiAgDQo+Pj4gKwkvKiBDb250cm9sbGVyIGlzIG5vdCBoYWx0ZWQgdW50aWwgcGVu
ZGluZyBldmVudHMgYXJlIGFja25vd2xlZGdlZCAqLw0KPj4+ICsJaWYgKCFpc19vbikgew0KPj4+
ICsJCXJlZyA9IGR3YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0MzX0dFVk5UQ09VTlQoMCkpOw0KPj4+
ICsJCXJlZyAmPSBEV0MzX0dFVk5UQ09VTlRfTUFTSzsNCj4+PiArCQlpZiAocmVnID4gMCkgew0K
Pj4+ICsJCQlkd2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNfR0VWTlRDT1VOVCgwKSwgcmVnKTsN
Cj4+PiArCQkJZHdjLT5ldl9idWYtPmxwb3MgPSAoZHdjLT5ldl9idWYtPmxwb3MgKyByZWcpICUN
Cj4+PiArCQkJCQkJZHdjLT5ldl9idWYtPmxlbmd0aDsNCj4+PiArCQl9DQo+Pj4gKwl9DQo+Pj4g
Kw0KPj4gRHJpdmVyIHNob3VsZCBoYW5kbGUgdGhlIGV2ZW50cyBiZWZvcmUgY2xlYXJpbmcgdGhl
IHJ1bl9zdG9wIGJpdCwgbm90DQo+PiBqdXN0IGFja25vd2xlZGdpbmcgYW5kIGlnbm9yaW5nIHRo
ZW0uDQo+Pg0KPiBEbyB5b3UgdGhpbmsgaXRzIGJldHRlciBpZiB3ZSBjYWxsIHRoZSBkd2MzX2No
ZWNrX2V2ZW50X2J1ZigpIGFuZA0KPiBkd2MzX3Byb2Nlc3NfZXZlbnRfYnVmKCkgaGVyZT8gIFRo
YXQgd2lsbCBoYW5kbGUgdGhlIGNsZWFyaW5nIG9mIHRoZQ0KPiBldmVudHMgYW5kIGFsbG93IHRo
ZW0gdG8gYmUgaGFuZGxlZC4gIFRoZXJlIGFyZSBzb21lIHNuaXBwZXRzIGluIHRoZQ0KPiBkYXRh
Ym9vaywgd2hpY2ggbWVudGlvbnMgdGhhdCB3ZSBkb24ndCBuZWVkIHRvIGhhbmRsZS9wcm9jZXNz
IHRoZQ0KPiBldmVudHMsIGFuZCBqdXN0IGFja25vd2xlZGdlIHRoZW0uIChpdCBtZW50aW9ucyB0
aGlzIGluIHRoZSBoaWJlcm5hdGlvbg0KPiBzZWN0aW9uKQ0KDQpJIHRoaW5rIHRoaXMgc2hvdWxk
IGJlIGhhbmRsZSBzZXBhcmF0ZWx5IGZyb20gdGhlIHJ1bl9zdG9wKCkgZnVuY3Rpb24uDQpNYXli
ZSBwdXQgaXQgaW4gdGhlIHB1bGx1cCgpIGZ1bmN0aW9uIGp1c3QgZm9yIGRldmljZSBpbml0aWF0
ZWQNCmRpc2Nvbm5lY3QgY2FzZSBvbmx5Lg0KDQo+DQo+Pj4gIAlkbyB7DQo+Pj4gIAkJcmVnID0g
ZHdjM19yZWFkbChkd2MtPnJlZ3MsIERXQzNfRFNUUyk7DQo+Pj4gIAkJcmVnICY9IERXQzNfRFNU
U19ERVZDVFJMSExUOw0KPj4+IEBAIC0xOTk0LDkgKzIwMzMsMTUgQEAgc3RhdGljIGludCBkd2Mz
X2dhZGdldF9wdWxsdXAoc3RydWN0IHVzYl9nYWRnZXQgKmcsIGludCBpc19vbikNCj4+PiAgCQl9
DQo+Pj4gIAl9DQo+Pj4gIA0KPj4+ICsJLyoNCj4+PiArCSAqIFN5bmNocm9uaXplIGFuZCBkaXNh
YmxlIGFueSBmdXJ0aGVyIGV2ZW50IGhhbmRsaW5nIHdoaWxlIGNvbnRyb2xsZXINCj4+PiArCSAq
IGlzIGJlaW5nIGVuYWJsZWQvZGlzYWJsZWQuDQo+Pj4gKwkgKi8NCj4+PiArCWRpc2FibGVfaXJx
KGR3Yy0+aXJxX2dhZGdldCk7DQo+Pj4gIAlzcGluX2xvY2tfaXJxc2F2ZSgmZHdjLT5sb2NrLCBm
bGFncyk7DQo+Pj4gIAlyZXQgPSBkd2MzX2dhZGdldF9ydW5fc3RvcChkd2MsIGlzX29uLCBmYWxz
ZSk7DQo+Pj4gIAlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4+
PiArCWVuYWJsZV9pcnEoZHdjLT5pcnFfZ2FkZ2V0KTsNCj4+PiAgDQo+Pj4gIAlyZXR1cm4gcmV0
Ow0KPj4+ICB9DQo+Pj4gQEAgLTM1MzUsNiArMzU4MCwxNCBAQCBzdGF0aWMgaXJxcmV0dXJuX3Qg
ZHdjM19jaGVja19ldmVudF9idWYoc3RydWN0IGR3YzNfZXZlbnRfYnVmZmVyICpldnQpDQo+Pj4g
IAlpZiAoIWNvdW50KQ0KPj4+ICAJCXJldHVybiBJUlFfTk9ORTsNCj4+PiAgDQo+Pj4gKwkvKiBD
b250cm9sbGVyIGlzIGhhbHRlZDsgaWdub3JlIG5ldy9wZW5kaW5nIGV2ZW50cyAqLw0KPj4+ICsJ
aWYgKCFkd2MtPnB1bGx1cHNfY29ubmVjdGVkKSB7DQo+Pj4gKwkJZHdjM193cml0ZWwoZHdjLT5y
ZWdzLCBEV0MzX0dFVk5UQ09VTlQoMCksIGNvdW50KTsNCj4+PiArCQlkd2MtPmV2X2J1Zi0+bHBv
cyA9IChkd2MtPmV2X2J1Zi0+bHBvcyArIGNvdW50KSAlDQo+Pj4gKwkJCQkJZHdjLT5ldl9idWYt
Pmxlbmd0aDsNCj4+PiArCQlyZXR1cm4gSVJRX0hBTkRMRUQ7DQo+Pj4gKwl9DQo+Pj4gKw0KPj4g
V2h5PyBBcmUgeW91IGdldHRpbmcgYW55IGV2ZW50IGFmdGVyIHRoZSBjb250cm9sbGVyIGlzIGhh
bHRlZD8gQWxzbywNCj4+IG1ha2Ugc3VyZSB0byB0YWtlIGFjY291bnQgb2YgaGliZXJuYXRpb24u
IFRoZSBjb250cm9sbGVyIGNhbiBnZXQgUE1VDQo+PiBldmVudCBhZnRlciBoYWx0ZWQgdG8gYnJp
bmcgaXQgb3V0IG9mIGhpYmVybmF0aW9uLg0KPj4NCj4gV2UgYXJlbid0IGdldHRpbmcgYW55IGV2
ZW50cyBhZnRlciB0aGUgY29udHJvbGxlciBpcyBoYWx0ZWQsIGJ1dCBiZWZvcmUNCj4gd2UgZ28g
YW5kIHRyeSB0byBjbGVhciB0aGUgcnVuIHN0b3AgYml0LiAgSSBhZGRlZCBhIHByaW50IGluIHRo
ZSBydW4NCj4gc3RvcCBBUEkgYWZ0ZXIgY2xlYXJpbmcgdGhlIFJTIGJpdCwgYW5kIHRoZXJlIHdl
cmUgcGVuZGluZyBldmVudHMgaW4gdGhlDQo+IGNvbnRyb2xsZXIgYXQgdGhhdCB0aW1lLiAgSXQg
bWlnaHQgYmUgcmVkdW5kYW50IHRvIGhhdmUgdGhpcyBpZiB3ZSBhcmUNCj4gZGlzYWJsaW5nIHRo
ZSBJUlEgYWxyZWFkeSBiZWZvcmUgdGhlIHJ1biBzdG9wIGNhbGwuDQo+DQo+IEkgc2VlLCBzbyBt
YXliZSB0byBlbnN1cmUgd2UgZG9uJ3QgYmxvY2sgdGhlIFBNVSBldmVudCwgd2UgY2FuIHJlbW92
ZQ0KPiB0aGlzLCBhbmQgcmVseSBvbiB0aGUgZGlzYWJsZV9pcnEoKSBhbmQgdGhlIHJ1biBzdG9w
IEFQSSB0byBlbnN1cmUgbm8NCj4gZXZlbnRzIHdpbGwgYmUgcGVuZGluZy4NCj4NCj4+PiAgCWV2
dC0+Y291bnQgPSBjb3VudDsNCj4+PiAgCWV2dC0+ZmxhZ3MgfD0gRFdDM19FVkVOVF9QRU5ESU5H
Ow0KPj4+ICANCj4+IElmIHlvdSdyZSBtYWtpbmcgdGhlc2UgZml4ZXMsIGNhbiB5b3UgYWxzbyBm
aXggaGFuZGxpbmcgcmVzZXQgaW50ZXJydXB0DQo+PiA/IEl0IGFsc28gbmVlZHMgdG8gZW5kIGFs
bCB0aGUgYWN0aXZlIHRyYW5zZmVycy4NCj4+DQo+IFN1cmUsIEkgY2FuIGNvbnNpZGVyIHRoYXQg
YXMgd2VsbC4NCj4NCg0KVGhhbmtzLA0KVGhpbmgNCg==
