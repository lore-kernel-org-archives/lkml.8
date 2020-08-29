Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7846C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 21:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74B2420774
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 21:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="H4SkDsH/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="rTGgHAW7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbgH2Vf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 17:35:29 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:41854 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726748AbgH2Vf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 17:35:26 -0400
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6C2E44035B;
        Sat, 29 Aug 2020 21:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1598736925; bh=FH0Eyd4F3ZbIVfUoHKAW0yhbuiFz448ohF0qS3xzIMA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=H4SkDsH/DM5pyWj3F50R3q+BcI06fbsRLneIvDeE4WUJYzdzwEiBmjfLpc6u4+MS7
         lNux2y+hdmngPSalvzUrv9XU63m5tS0jxRZKdk4KGVhigznLfhHZQBjP0fZYCk8yKZ
         vvEH2v5Pv510ettjOIKMqLcHhPIyKa9B9dywMkPjeyoDsZ+ZsIspiRmPvyYiFWMspg
         ZTp4KEdnHDIZ7zUGz4kkine0bXTNAb1ikrWiTq2CbmdzOWXVADrEGdXI6k6AX8oKWs
         JEG/u74jcKH252/W/6/s1Srp0DWZd0LOG2Ckv3Tls/QBKP0neoJOZcMJuglFdSdWMb
         30xlBXazWbmLw==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id B3F45A0060;
        Sat, 29 Aug 2020 21:35:24 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 1872240046;
        Sat, 29 Aug 2020 21:35:23 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="rTGgHAW7";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RV5PgGHdp8YOAgZ1NdZZeitjKxklN9eriPUPNr9KTDiNmv8m2hVUp0rPIT/sTj5PmOG4cY6rZCWG0XkUrSvZwWuJ6RVJT+hFTar8BcMOXeBIqxrcI2++LxcIuSUVupn0tOoeAPw3n4h3OU8Vc8wPON3UjuEwGsBrn6E/jN4HmCnmUMe+pDY+u5S4J5QjWDRdpzfUtIf/SexDJNsZCM4e56bfEFN4nuS+blMcwiWOMDM06K/JFmYDEEEogvmsLfEfUi052Ijs/vNy1QgyLd8Ag98Sp6A9IppImKbmu/zy2D6PeSig/lLbNYdj2y+lZ7Vgwcq7tQiukwMd5lILjTd3Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FH0Eyd4F3ZbIVfUoHKAW0yhbuiFz448ohF0qS3xzIMA=;
 b=io312ZNbQt9EQp03ZtzaGNA306ww+JD5jTu+EDi57BuLIAxCAWmF2qlKL3vRSw1NBUaYjxWPBkIXsELX0jn0Npyt9T/TNmGlsUzYOZqsv0TjYHpYLPl3zXLO2Nc0g5dfIK+t0Dpc4V63666e7qkB0roU5YWvevgckrMJcoihv6Oq3hB9JM+yM36eKVXp8C7qjiTlhsdU6LzcYJOypDhO5W+7O7ABi7ZCKxdz4QTkNa1LXfCDDzzJo1imhZ8u0uqcVHSY1XId1H6zUbUzNEPdnWcDMAz0eizUeXCkvKeyzRbnwouC504j5jbNqp++xcxSa2PRVhDyBK7/mKR68n8YEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FH0Eyd4F3ZbIVfUoHKAW0yhbuiFz448ohF0qS3xzIMA=;
 b=rTGgHAW7YpTVC0gHW89HWecHYuHJXnSNyNSygu9oJ/Zn94gj9M4gPsX7zM2UfbVK+HJysIOuPXKSA16pmLaOAuS9DqiLQDl7OiGZsWJSUViNA+4JWSiw8AgyU2FkVXy3ObgjvcLit5jbjrMvHObpOaY3YBhPtei9BlALjSKmA/4=
Received: from BYAPR12MB2917.namprd12.prod.outlook.com (20.179.91.142) by
 BY5PR12MB4306.namprd12.prod.outlook.com (52.135.53.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19; Sat, 29 Aug 2020 21:35:22 +0000
Received: from BYAPR12MB2917.namprd12.prod.outlook.com
 ([fe80::c98f:a13f:fd88:c209]) by BYAPR12MB2917.namprd12.prod.outlook.com
 ([fe80::c98f:a13f:fd88:c209%7]) with mapi id 15.20.3326.025; Sat, 29 Aug 2020
 21:35:22 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <wcheng@codeaurora.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "jackp@codeaurora.org" <jackp@codeaurora.org>
Subject: Re: [PATCH v2] usb: dwc3: Stop active transfers before halting the
 controller
Thread-Topic: [PATCH v2] usb: dwc3: Stop active transfers before halting the
 controller
Thread-Index: AQHWfYzfOHRuk9qxlUy/aHCACERYqalPnX6A
Date:   Sat, 29 Aug 2020 21:35:22 +0000
Message-ID: <e7e0cac8-b0f1-3173-a54a-ccf061807c0c@synopsys.com>
References: <20200828224440.22091-1-wcheng@codeaurora.org>
In-Reply-To: <20200828224440.22091-1-wcheng@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [98.248.94.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94618727-3139-4b24-6b23-08d84c636f17
x-ms-traffictypediagnostic: BY5PR12MB4306:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4306D78CE48E86E8C9F6A798AA530@BY5PR12MB4306.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1013;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uVKJxwF6iqYOTtJVqT56bKpeVnKR1LejPvBSuY0DeC+yP0IR8oxjUsJQaD4VBJaAzxDYWWtT9CK+2Mxi2Z1mGlmqWVkGvq0hAyzx46eU6bBuH5BW4ih+0IF/HNirhET8P7LozH3A3TTEy1yNG8hRNFthfM25TM9NLubh1rTQVpm3ankB9ZKH7/cW4U/l+dPrhVJ/A24tJwlEC9iU2B69iMm0P/l5m53slzYSVelqw8PAfyprZsr3Cz+X5n7lQyR3HObWZMDLJZX1VVHCyesS4lULS8Y2K4PtAhvN3VDqLfy/ScQOgDglnACjbZ7erMBYk7HrWBKujzwdCICqsevXxl3pDRfLTXH04mWhacmo9jDtCgPOMAmT650AdADHAis8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2917.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(39850400004)(136003)(396003)(376002)(8936002)(31696002)(26005)(54906003)(83380400001)(76116006)(110136005)(6506007)(5660300002)(2906002)(36756003)(71200400001)(2616005)(66946007)(478600001)(186003)(66476007)(66556008)(6486002)(64756008)(6512007)(31686004)(316002)(66446008)(8676002)(86362001)(4326008)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: DVbkPcbUvE5Y0iYBY2EIgsILjsWzHaLld6mZ5BvJq7IdpmfR990/vnKQp+QpLslWxdA+GLuPt92mUcco3V4GlWp90VMexb5yWyUKZEt9HpGiXIRcZs5eHiCYqz6dmhGgK4dxMYnl3kQgnrFbMaDZthK1f7+drwaVGNzRuVktGSZMEQb8O+WYBh0vtiyBBgpjL1n1mSUcPCisfb8hAY1he2/k0tY+c5Wn0+pjEjvsjYZxmNkTVqZotuUZvlP34JjqQnZawNTyeJO/wWNoCm86tacy+fwUfx4AG3jn+6nyhZhzerKttBPOGrcRx9ec+n6kdPm6lRM1odPDdmhxyG+LiPlZI5wiGFEi6oL4s75T9puitnHrlvzzPNy71LlXQORCmKAZaUBUDOkhZKzT4cghIanz9DbPryMlPIIlNIdAuxyl8GrS1roMsaL77cZuEuMIdjH82V/dlUpo8Km7WtNHVHuks6Wau2qdsOkTTDiGEx6gJWEAP672T4j/lhg0WxIZO0v9qtxhs+v2QVuepfEN/OSB84B3TaAB+0nFGMyr8PFkqPpcG2Q7VYf0ln0yVyxjltyhiVmD9skEIsoh4exwIcO2k3rcdhhvR6bGn2YYflBMKFp35ykTRQxSEKbCj8JptalfnsqN5os6isY0M3hvbQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <3CEE11B536700440B5469B6838E374F6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2917.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94618727-3139-4b24-6b23-08d84c636f17
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2020 21:35:22.1354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DqfV/EJpj4ZSSK+tUtCif8bre1HC4Irf7rQOJ+Rya8GE6/ijnxHETt60kr4Xyq/rMeb04vE6hqVJZ3/BVAcFFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4306
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2VzbGV5IENoZW5nIHdyb3RlOg0KPiBJbiB0aGUgRFdDMyBkYXRhYm9vaywgZm9yIGEgZGV2aWNl
IGluaXRpYXRlZCBkaXNjb25uZWN0IG9yIGJ1cyByZXNldCwgdGhlDQo+IGRyaXZlciBpcyByZXF1
aXJlZCB0byBzZW5kIGRlcGVuZHhmZXIgY29tbWFuZHMgZm9yIGFueSBwZW5kaW5nIHRyYW5zZmVy
cy4NCj4gSW4gYWRkaXRpb24sIGJlZm9yZSB0aGUgY29udHJvbGxlciBjYW4gbW92ZSB0byB0aGUg
aGFsdGVkIHN0YXRlLCB0aGUgU1cNCj4gbmVlZHMgdG8gYWNrbm93bGVkZ2UgYW55IHBlbmRpbmcg
ZXZlbnRzLiAgSWYgdGhlIGNvbnRyb2xsZXIgaXMgbm90IGhhbHRlZA0KPiBwcm9wZXJseSwgdGhl
cmUgaXMgYSBjaGFuY2UgdGhlIGNvbnRyb2xsZXIgd2lsbCBjb250aW51ZSBhY2Nlc3Npbmcgc3Rh
bGUgb3INCj4gZnJlZWQgVFJCcyBhbmQgYnVmZmVycy4NCj4NCj4gU2lnbmVkLW9mZi1ieTogV2Vz
bGV5IENoZW5nIDx3Y2hlbmdAY29kZWF1cm9yYS5vcmc+DQo+DQo+IC0tLQ0KPiBDaGFuZ2VzIGlu
IHYyOg0KPiAgLSBNb3ZlZCBjbGVhbnVwIGNvZGUgdG8gdGhlIHB1bGx1cCgpIEFQSSB0byBkaWZm
ZXJlbnRpYXRlIGJldHdlZW4gZGV2aWNlDQo+ICAgIGRpc2Nvbm5lY3QgYW5kIGhpYmVybmF0aW9u
Lg0KPiAgLSBBZGRlZCBjbGVhbnVwIGNvZGUgdG8gdGhlIGJ1cyByZXNldCBjYXNlIGFzIHdlbGwu
DQo+ICAtIFZlcmlmaWVkIHRoZSBtb3ZlIHRvIHB1bGx1cCgpIGRpZCBub3QgcmVwcm9kdWNlIHRo
ZSBwcm9ibGVuIHVzaW5nIHRoZQ0KPiAgICBzYW1lIHRlc3Qgc2VxdWVuY2UuDQo+DQo+IFZlcmlm
aWVkIGZpeCBieSBhZGRpbmcgYSBjaGVjayBmb3IgRVRJTUVET1VUIGR1cmluZyB0aGUgcnVuIHN0
b3AgY2FsbC4NCj4gU2hlbGwgc2NyaXB0IHdyaXRpbmcgdG8gdGhlIGNvbmZpZ2ZzIFVEQyBmaWxl
IHRvIHRyaWdnZXIgZGlzY29ubmVjdCBhbmQNCj4gY29ubmVjdC4gIEJhdGNoIHNjcmlwdCB0byBo
YXZlIFBDIGV4ZWN1dGUgZGF0YSB0cmFuc2ZlcnMgb3ZlciBhZGIgKGllIGFkYg0KPiBwdXNoKSAg
QWZ0ZXIgYSBmZXcgaXRlcmF0aW9ucywgd2UnZCBydW4gaW50byBhIHNjZW5hcmlvIHdoZXJlIHRo
ZQ0KPiBjb250cm9sbGVyIHdhc24ndCBoYWx0ZWQuICBXaXRoIHRoZSBmb2xsb3dpbmcgY2hhbmdl
LCBubyBmYWlsZWQgaGFsdHMgYWZ0ZXINCj4gbWFueSBpdGVyYXRpb25zLg0KPiAtLS0NCj4gIGRy
aXZlcnMvdXNiL2R3YzMvZXAwLmMgICAgfCAgMiArLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9nYWRn
ZXQuYyB8IDUyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiAgMiBm
aWxlcyBjaGFuZ2VkLCA1MiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9lcDAuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZXAwLmMN
Cj4gaW5kZXggNTlmMmU4YzMxYmQxLi40NTZhYTg3ZTg3NzggMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvdXNiL2R3YzMvZXAwLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9lcDAuYw0KPiBAQCAt
MTk3LDcgKzE5Nyw3IEBAIGludCBkd2MzX2dhZGdldF9lcDBfcXVldWUoc3RydWN0IHVzYl9lcCAq
ZXAsIHN0cnVjdCB1c2JfcmVxdWVzdCAqcmVxdWVzdCwNCj4gIAlpbnQJCQkJcmV0Ow0KPiAgDQo+
ICAJc3Bpbl9sb2NrX2lycXNhdmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0KPiAtCWlmICghZGVwLT5l
bmRwb2ludC5kZXNjKSB7DQo+ICsJaWYgKCFkZXAtPmVuZHBvaW50LmRlc2MgfHwgIWR3Yy0+cHVs
bHVwc19jb25uZWN0ZWQpIHsNCj4gIAkJZGV2X2Vycihkd2MtPmRldiwgIiVzOiBjYW4ndCBxdWV1
ZSB0byBkaXNhYmxlZCBlbmRwb2ludFxuIiwNCj4gIAkJCQlkZXAtPm5hbWUpOw0KPiAgCQlyZXQg
PSAtRVNIVVRET1dOOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBi
L2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gaW5kZXggM2FiNmYxMThjNTA4Li5kZjhkODlk
NmJkYzkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gKysrIGIv
ZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiBAQCAtMTUxNiw3ICsxNTE2LDcgQEAgc3RhdGlj
IGludCBfX2R3YzNfZ2FkZ2V0X2VwX3F1ZXVlKHN0cnVjdCBkd2MzX2VwICpkZXAsIHN0cnVjdCBk
d2MzX3JlcXVlc3QgKnJlcSkNCj4gIHsNCj4gIAlzdHJ1Y3QgZHdjMwkJKmR3YyA9IGRlcC0+ZHdj
Ow0KPiAgDQo+IC0JaWYgKCFkZXAtPmVuZHBvaW50LmRlc2MpIHsNCj4gKwlpZiAoIWRlcC0+ZW5k
cG9pbnQuZGVzYyB8fCAhZHdjLT5wdWxsdXBzX2Nvbm5lY3RlZCkgew0KPiAgCQlkZXZfZXJyKGR3
Yy0+ZGV2LCAiJXM6IGNhbid0IHF1ZXVlIHRvIGRpc2FibGVkIGVuZHBvaW50XG4iLA0KPiAgCQkJ
CWRlcC0+bmFtZSk7DQo+ICAJCXJldHVybiAtRVNIVVRET1dOOw0KPiBAQCAtMTkyNiw2ICsxOTI2
LDI0IEBAIHN0YXRpYyBpbnQgZHdjM19nYWRnZXRfc2V0X3NlbGZwb3dlcmVkKHN0cnVjdCB1c2Jf
Z2FkZ2V0ICpnLA0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMgdm9pZCBkd2Mz
X3N0b3BfYWN0aXZlX3RyYW5zZmVycyhzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiArew0KPiArCXUzMiBl
cG51bTsNCj4gKw0KPiArCWZvciAoZXBudW0gPSAyOyBlcG51bSA8IERXQzNfRU5EUE9JTlRTX05V
TTsgZXBudW0rKykgew0KPiArCQlzdHJ1Y3QgZHdjM19lcCAqZGVwOw0KPiArDQo+ICsJCWRlcCA9
IGR3Yy0+ZXBzW2VwbnVtXTsNCj4gKwkJaWYgKCFkZXApDQo+ICsJCQljb250aW51ZTsNCj4gKw0K
PiArCQlpZiAoIShkZXAtPmZsYWdzICYgRFdDM19FUF9FTkFCTEVEKSkNCj4gKwkJCWNvbnRpbnVl
Ow0KDQpEb24ndCBkbyB0aGUgZW5hYmxlZCBjaGVjayBoZXJlLiBMZXQgdGhlIGR3YzNfc3RvcF9h
Y3RpdmVfdHJhbnNmZXIoKSBkbw0KdGhhdCBjaGVja2luZy4NCg0KPiArDQo+ICsJCWR3YzNfcmVt
b3ZlX3JlcXVlc3RzKGR3YywgZGVwKTsNCj4gKwl9DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBpbnQg
ZHdjM19nYWRnZXRfcnVuX3N0b3Aoc3RydWN0IGR3YzMgKmR3YywgaW50IGlzX29uLCBpbnQgc3Vz
cGVuZCkNCj4gIHsNCj4gIAl1MzIJCQlyZWc7DQo+IEBAIC0xOTk0LDkgKzIwMTIsMzkgQEAgc3Rh
dGljIGludCBkd2MzX2dhZGdldF9wdWxsdXAoc3RydWN0IHVzYl9nYWRnZXQgKmcsIGludCBpc19v
bikNCj4gIAkJfQ0KPiAgCX0NCj4gIA0KPiArCS8qDQo+ICsJICogU3luY2hyb25pemUgYW5kIGRp
c2FibGUgYW55IGZ1cnRoZXIgZXZlbnQgaGFuZGxpbmcgd2hpbGUgY29udHJvbGxlcg0KPiArCSAq
IGlzIGJlaW5nIGVuYWJsZWQvZGlzYWJsZWQuDQo+ICsJICovDQo+ICsJZGlzYWJsZV9pcnEoZHdj
LT5pcnFfZ2FkZ2V0KTsNCg0KSSB0aGluayBpdCdzIGJldHRlciB0byBkbyBkd2MzX2dhZGdldF9k
aXNhYmxlX2lycSgpLiBUaGlzIG9ubHkgc3RvcHMNCmhhbmRsaW5nIGV2ZW50cy4gQWx0aG91Z2gg
aXQncyB1bmxpa2VseSwgdGhlIGNvbnRyb2xsZXIgbWF5IHN0aWxsDQpnZW5lcmF0ZSBldmVudHMg
YmVmb3JlIGl0J3MgaGFsdGVkLg0KDQo+ICAJc3Bpbl9sb2NrX2lycXNhdmUoJmR3Yy0+bG9jaywg
ZmxhZ3MpOw0KPiArDQo+ICsJLyogQ29udHJvbGxlciBpcyBub3QgaGFsdGVkIHVudGlsIHBlbmRp
bmcgZXZlbnRzIGFyZSBhY2tub3dsZWRnZWQgKi8NCj4gKwlpZiAoIWlzX29uKSB7DQo+ICsJCXUz
MiByZWc7DQo+ICsNCj4gKwkJX19kd2MzX2dhZGdldF9lcF9kaXNhYmxlKGR3Yy0+ZXBzWzBdKTsN
Cj4gKwkJX19kd2MzX2dhZGdldF9lcF9kaXNhYmxlKGR3Yy0+ZXBzWzFdKTsNCg0KWW91IGNhbiBq
dXN0IGRvIF9fZHdjM19nYWRnZXRfc3RvcCgpLCBhbmQgZG8gdGhhdCBhZnRlcg0KZHdjM19zdG9w
X2FjdGl2ZV90cmFuc2ZlcnMoKS4NCg0KPiArDQo+ICsJCS8qDQo+ICsJCSAqIFRoZSBkYXRhYm9v
ayBleHBsaWNpdGx5IG1lbnRpb25zIGZvciBhIGRldmljZS1pbml0aWF0ZWQNCj4gKwkJICogZGlz
Y29ubmVjdCBzZXF1ZW5jZSwgdGhlIFNXIG5lZWRzIHRvIGVuc3VyZSB0aGF0IGl0IGVuZHMgYW55
DQo+ICsJCSAqIGFjdGl2ZSB0cmFuc2ZlcnMuDQo+ICsJCSAqLw0KPiArCQlkd2MzX3N0b3BfYWN0
aXZlX3RyYW5zZmVycyhkd2MpOw0KPiArDQo+ICsJCXJlZyA9IGR3YzNfcmVhZGwoZHdjLT5yZWdz
LCBEV0MzX0dFVk5UQ09VTlQoMCkpOw0KPiArCQlyZWcgJj0gRFdDM19HRVZOVENPVU5UX01BU0s7
DQoNCkNhbiB3ZSB1c2UgYW5vdGhlciB2YXJpYWJsZSAiY291bnQiIGluc3RlYWQgb2YgcmV1c2lu
ZyByZWcgdG8gbWFrZSBpdCBhDQpsaXR0bGUgY2xlYXJlcj8NCg0KPiArCQlpZiAocmVnID4gMCkg
ew0KPiArCQkJZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dFVk5UQ09VTlQoMCksIHJlZyk7
DQo+ICsJCQlkd2MtPmV2X2J1Zi0+bHBvcyA9IChkd2MtPmV2X2J1Zi0+bHBvcyArIHJlZykgJQ0K
PiArCQkJCQkJZHdjLT5ldl9idWYtPmxlbmd0aDsNCj4gKwkJfQ0KPiArCX0NCj4gKw0KPiAgCXJl
dCA9IGR3YzNfZ2FkZ2V0X3J1bl9zdG9wKGR3YywgaXNfb24sIGZhbHNlKTsNCj4gIAlzcGluX3Vu
bG9ja19pcnFyZXN0b3JlKCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4gKwllbmFibGVfaXJxKGR3Yy0+
aXJxX2dhZGdldCk7DQo+ICANCj4gIAlyZXR1cm4gcmV0Ow0KPiAgfQ0KPiBAQCAtMzEwMCw2ICsz
MTQ4LDggQEAgc3RhdGljIHZvaWQgZHdjM19nYWRnZXRfcmVzZXRfaW50ZXJydXB0KHN0cnVjdCBk
d2MzICpkd2MpDQo+ICAJfQ0KPiAgDQo+ICAJZHdjM19yZXNldF9nYWRnZXQoZHdjKTsNCj4gKwkv
KiBTdG9wIGFueSBhY3RpdmUvcGVuZGluZyB0cmFuc2ZlcnMgd2hlbiByZWNlaXZpbmcgYnVzIHJl
c2V0ICovDQo+ICsJZHdjM19zdG9wX2FjdGl2ZV90cmFuc2ZlcnMoZHdjKTsNCj4gIA0KPiAgCXJl
ZyA9IGR3YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0MzX0RDVEwpOw0KPiAgCXJlZyAmPSB+RFdDM19E
Q1RMX1RTVENUUkxfTUFTSzsNCg0KTG9va3MgZ29vZCB0byBtZS4NCg0KVGhhbmtzLA0KVGhpbmgN
Cg==
