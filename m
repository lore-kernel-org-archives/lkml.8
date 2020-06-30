Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD08C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 01:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1729E20780
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 01:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="pTxMyJPd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgF3BTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 21:19:36 -0400
Received: from mail-bn8nam11on2051.outbound.protection.outlook.com ([40.107.236.51]:26438
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726436AbgF3BTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 21:19:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfdq/wKBl/ZZuIOO2odQ0BOycGr1QVOXP8LuhV8dwo7x/JmYzqirR9hfEd2JamDceT1zrVtcHLu2IoFw/x4ct/1HiywrVfJBJer2OP9HlDhCfB7fBUs5Gy29gCrOeNE5QUzNwQ8i/eY50NksTaLU+cWAd61oeyOuI2AHsttItx/zvyV57gJ7/mOYjU5LrSWktxFi1XALYS9IPjBi6blkwsxrxGNyBQaL1Yfjb3j5obwMMmq1nM5/pr4zjlGpXYt3KCJ+00tDKfUTM++HvHD2ZvvqsBLRQXBx4d5XnLfCLxmV46w9bSpvF5AOOfGgGPnKNompXB1CaMgMw5BTrGynWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyZHVaOHgdyT9xunGQ0c3lauNf0VHuCVzT6JwK1gXHc=;
 b=Y+qzC6NbO0Yi1uFtt4bGoB8IpOnkiRyF5DlivZJxtuHpeELabtcvSOIt6q4iOGXQTcAUankrfKDa3Vo8B6+/DXL7eibZueMg5IRJB4Vku1GuC00HxWE8KJfY0bxZooif+K5JcGWtso7Xq/Q3KUAjf+WhsRsYRI4SUp2gLyA6ZaJkmx8sE3z914mYkP76RjFjYwq8x/kQHqr+zj+1sPqXrxKN0nEpi0CNqI/D+barfxCPxUgdYxbmLll+8gx4uebFYuRsPQAYkJV/5dbHCon5JfyR/HTaJWk6fmr9MTE8NN8I1gg7iT5vAOL9TNt6AV1iJLpakc4vppK41nV9qPaoWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyZHVaOHgdyT9xunGQ0c3lauNf0VHuCVzT6JwK1gXHc=;
 b=pTxMyJPdocSRNEIAiN+t48EAxWlHy9LwbLM6XSihJocUQwXs1MqWobtPbsI2xN9FPs4rFknS/bH6ZhC2gwDAfc+0ku+UCLX4nGk4BdVBvoj8DoFLwWTrMJCcZN8pRQKw2VqrxYuEmtuZVZfL+3ubcX15Ry8302gVxqvIkm6xsn0=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB3446.namprd11.prod.outlook.com (2603:10b6:a03:1a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Tue, 30 Jun
 2020 01:19:30 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::3d7d:dfc1:b35d:63d1]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::3d7d:dfc1:b35d:63d1%7]) with mapi id 15.20.3131.027; Tue, 30 Jun 2020
 01:19:30 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     "balbi@kernel.org" <balbi@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSB1c2I6IGdhZGdldDogZnVuY3Rpb246IHByaW50ZXI6?=
 =?gb2312?B?IFRoZSBkZXZpY2UgaW50ZXJmYWNlIGlzIHJlc2V0IGFuZCBzaG91bGQgcmV0?=
 =?gb2312?Q?urn_error_code?=
Thread-Topic: [PATCH] usb: gadget: function: printer: The device interface is
 reset and should return error code
Thread-Index: AQHWTO4m/7Kq2lPOa0yJ5PnFdxMxZ6jwXoAy
Date:   Tue, 30 Jun 2020 01:19:30 +0000
Message-ID: <BYAPR11MB26324061D80BDE1CCCD2B409FF6F0@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <20200628015731.16566-1-qiang.zhang@windriver.com>
In-Reply-To: <20200628015731.16566-1-qiang.zhang@windriver.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7caaadca-7ed0-481a-6969-08d81c93a3b8
x-ms-traffictypediagnostic: BYAPR11MB3446:
x-microsoft-antispam-prvs: <BYAPR11MB3446A9F5FD12CA7542A335C8FF6F0@BYAPR11MB3446.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q8l8IVAyrD/8cXyFJbCwdgMX/reEjML2ku+IhUEN20cGWnKXEMPAxQVqLVG6PBrB+H1T3kdwxaTchyiO0dImAw5Fi1XgQfXHAHsjHdnznrmU9YmlZOhkJXA32TgGZsjVNAhhKlKO+1yOPLt/drEFgmWpAE6E+kVkjtzQdqLscCu/+7H6yvD6gX1O2UViHBB1jif5fBLXD4R+dgVvv3tAuP8FGrlFlkTQye1H8+xe/+ZOyQImWfB7ZbZasLLbX+cEeSez8e5Q2gwuTtmiGKNZ5e777IhhpjdoP0obw1Hz6e6mrQWwUT1KFF8zlArKlPPvKPVtPq7mKTEdh6xCfsAawg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39850400004)(346002)(376002)(136003)(396003)(366004)(9686003)(55016002)(86362001)(52536014)(66446008)(64756008)(66946007)(76116006)(91956017)(66556008)(66476007)(71200400001)(5660300002)(6916009)(224303003)(83380400001)(6506007)(8936002)(7696005)(186003)(4326008)(478600001)(26005)(316002)(2906002)(33656002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: D7tDNaKAPGBUkNPP6C7zkliDzK7gfvupN5d5zl+51iOYlg4kKR4WNFep69A5faObPzmh+o4EI1g0rBwv5y1EYlSLJvXHRYvYsJBHKLdjOEPQDYtQQrjJo8RevQqhyiiqvD5+A+LEC4kjONwz9FF2oDHSVbp6jRiXNN1LMDlg9jSOru9kvzyVtGhx8eo5I1RQBsZ+WJgiL6VoT/cJqLXn9zD6jhdTK65vmBUnrjfsP4t3LR613ppsN050msxcCgnuwS6o3wPwMwoNo+j9AcjPPPYRJNt8pIq1F+86nf1GKMEEnywiC7YlY5e7cqiIUAU9PXswnwGQnjWE+I62Um1EkGdhEetQ4Yu4yTqIaDzAG7fjj2xQGE6uiVFyCL7XPwgappmCC5CVsnGKM2vJtpYxdGgaL4ZMpxeCfA9OHTc5Cy2+YiQpc9kWdQ5WncS8x8f1WkdKmp2oKob5mUteHPqRALj3Mz+F320HKevTVlDT/Zo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7caaadca-7ed0-481a-6969-08d81c93a3b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 01:19:30.3748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bdFI9eh7CO2U8aMXFZNA1zP6ULF07B2/GMju69PTYU4pQoBMNb5bE7EffiABZ2fvL4knzvMHtYvtIOBfQQ7fDpUnN5mD/E2XCi5irC6emxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3446
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRmVsaXBlLAoKUGxlYXNlIGNoZWNrIHRoaXMgcGF0Y2ggYW5kIG1ha2Ugc3VnZ2VzdGlvbnMg
LgoKVGhhbmtzClpxaWFuZwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwq3orz+yMs6IGxpbnV4LXVzYi1vd25lckB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LXVzYi1vd25l
ckB2Z2VyLmtlcm5lbC5vcmc+ILT6se0gcWlhbmcuemhhbmdAd2luZHJpdmVyLmNvbSA8cWlhbmcu
emhhbmdAd2luZHJpdmVyLmNvbT4Kt6LLzcqxvOQ6IDIwMjDE6jbUwjI4yNUgOTo1NwrK1bz+yMs6
IGZlbGlwZS5iYWxiaUBsaW51eC5pbnRlbC5jb20Ks63LzTogZ3JlZ2toQGxpbnV4Zm91bmRhdGlv
bi5vcmc7IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmcK1vfM4jogW1BBVENIXSB1c2I6IGdhZGdldDogZnVuY3Rpb246IHByaW50ZXI6IFRoZSBk
ZXZpY2UgaW50ZXJmYWNlIGlzIHJlc2V0IGFuZCBzaG91bGQgcmV0dXJuIGVycm9yIGNvZGUKCkZy
b206IFpxaWFuZyA8cWlhbmcuemhhbmdAd2luZHJpdmVyLmNvbT4KCkFmdGVyIHRoZSBkZXZpY2Ug
aXMgZGlzY29ubmVjdGVkIGZyb20gdGhlIGhvc3Qgc2lkZSwgdGhlIGludGVyZmFjZSBvZgp0aGUg
ZGV2aWNlIGlzIHJlc2V0LiBJZiB0aGUgdXNlcnNwYWNlIG9wZXJhdGVzIHRoZSBkZXZpY2UgYWdh
aW4sCmFuIGVycm9yIGNvZGUgc2hvdWxkIGJlIHJldHVybmVkLgoKU2lnbmVkLW9mZi1ieTogWnFp
YW5nIDxxaWFuZy56aGFuZ0B3aW5kcml2ZXIuY29tPgotLS0KIGRyaXZlcnMvdXNiL2dhZGdldC9m
dW5jdGlvbi9mX3ByaW50ZXIuYyB8IDM2ICsrKysrKysrKysrKysrKysrKysrKysrKysKIDEgZmls
ZSBjaGFuZ2VkLCAzNiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2Fk
Z2V0L2Z1bmN0aW9uL2ZfcHJpbnRlci5jIGIvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2Zf
cHJpbnRlci5jCmluZGV4IDljN2VkMjUzOWZmNy4uMmI0NWE2MWU0MjEzIDEwMDY0NAotLS0gYS9k
cml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl9wcmludGVyLmMKKysrIGIvZHJpdmVycy91c2Iv
Z2FkZ2V0L2Z1bmN0aW9uL2ZfcHJpbnRlci5jCkBAIC0zMzgsNiArMzM4LDExIEBAIHByaW50ZXJf
b3BlbihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmlsZSAqZmQpCgogICAgICAgIHNwaW5f
bG9ja19pcnFzYXZlKCZkZXYtPmxvY2ssIGZsYWdzKTsKCisgICAgICAgaWYgKGRldi0+aW50ZXJm
YWNlIDwgMCkgeworICAgICAgICAgICAgICAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZGV2LT5s
b2NrLCBmbGFncyk7CisgICAgICAgICAgICAgICByZXR1cm4gLUVOT0RFVjsKKyAgICAgICB9CisK
ICAgICAgICBpZiAoIWRldi0+cHJpbnRlcl9jZGV2X29wZW4pIHsKICAgICAgICAgICAgICAgIGRl
di0+cHJpbnRlcl9jZGV2X29wZW4gPSAxOwogICAgICAgICAgICAgICAgZmQtPnByaXZhdGVfZGF0
YSA9IGRldjsKQEAgLTQzMCw2ICs0MzUsMTIgQEAgcHJpbnRlcl9yZWFkKHN0cnVjdCBmaWxlICpm
ZCwgY2hhciBfX3VzZXIgKmJ1Ziwgc2l6ZV90IGxlbiwgbG9mZl90ICpwdHIpCiAgICAgICAgbXV0
ZXhfbG9jaygmZGV2LT5sb2NrX3ByaW50ZXJfaW8pOwogICAgICAgIHNwaW5fbG9ja19pcnFzYXZl
KCZkZXYtPmxvY2ssIGZsYWdzKTsKCisgICAgICAgaWYgKGRldi0+aW50ZXJmYWNlIDwgMCkgewor
ICAgICAgICAgICAgICAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZGV2LT5sb2NrLCBmbGFncyk7
CisgICAgICAgICAgICAgICBtdXRleF91bmxvY2soJmRldi0+bG9ja19wcmludGVyX2lvKTsKKyAg
ICAgICAgICAgICAgIHJldHVybiAtRU5PREVWOworICAgICAgIH0KKwogICAgICAgIC8qIFdlIHdp
bGwgdXNlIHRoaXMgZmxhZyBsYXRlciB0byBjaGVjayBpZiBhIHByaW50ZXIgcmVzZXQgaGFwcGVu
ZWQKICAgICAgICAgKiBhZnRlciB3ZSB0dXJuIGludGVycnVwdHMgYmFjayBvbi4KICAgICAgICAg
Ki8KQEAgLTU2MSw2ICs1NzIsMTIgQEAgcHJpbnRlcl93cml0ZShzdHJ1Y3QgZmlsZSAqZmQsIGNv
bnN0IGNoYXIgX191c2VyICpidWYsIHNpemVfdCBsZW4sIGxvZmZfdCAqcHRyKQogICAgICAgIG11
dGV4X2xvY2soJmRldi0+bG9ja19wcmludGVyX2lvKTsKICAgICAgICBzcGluX2xvY2tfaXJxc2F2
ZSgmZGV2LT5sb2NrLCBmbGFncyk7CgorICAgICAgIGlmIChkZXYtPmludGVyZmFjZSA8IDApIHsK
KyAgICAgICAgICAgICAgIHNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmRldi0+bG9jaywgZmxhZ3Mp
OworICAgICAgICAgICAgICAgbXV0ZXhfdW5sb2NrKCZkZXYtPmxvY2tfcHJpbnRlcl9pbyk7Cisg
ICAgICAgICAgICAgICByZXR1cm4gLUVOT0RFVjsKKyAgICAgICB9CisKICAgICAgICAvKiBDaGVj
ayBpZiBhIHByaW50ZXIgcmVzZXQgaGFwcGVucyB3aGlsZSB3ZSBoYXZlIGludGVycnVwdHMgb24g
Ki8KICAgICAgICBkZXYtPnJlc2V0X3ByaW50ZXIgPSAwOwoKQEAgLTY2Nyw2ICs2ODQsMTMgQEAg
cHJpbnRlcl9mc3luYyhzdHJ1Y3QgZmlsZSAqZmQsIGxvZmZfdCBzdGFydCwgbG9mZl90IGVuZCwg
aW50IGRhdGFzeW5jKQoKICAgICAgICBpbm9kZV9sb2NrKGlub2RlKTsKICAgICAgICBzcGluX2xv
Y2tfaXJxc2F2ZSgmZGV2LT5sb2NrLCBmbGFncyk7CisKKyAgICAgICBpZiAoZGV2LT5pbnRlcmZh
Y2UgPCAwKSB7CisgICAgICAgICAgICAgICBzcGluX3VubG9ja19pcnFyZXN0b3JlKCZkZXYtPmxv
Y2ssIGZsYWdzKTsKKyAgICAgICAgICAgICAgIGlub2RlX3VubG9jayhpbm9kZSk7CisgICAgICAg
ICAgICAgICByZXR1cm4gLUVOT0RFVjsKKyAgICAgICB9CisKICAgICAgICB0eF9saXN0X2VtcHR5
ID0gKGxpa2VseShsaXN0X2VtcHR5KCZkZXYtPnR4X3JlcXMpKSk7CiAgICAgICAgc3Bpbl91bmxv
Y2tfaXJxcmVzdG9yZSgmZGV2LT5sb2NrLCBmbGFncyk7CgpAQCAtNjg5LDYgKzcxMywxMyBAQCBw
cmludGVyX3BvbGwoc3RydWN0IGZpbGUgKmZkLCBwb2xsX3RhYmxlICp3YWl0KQoKICAgICAgICBt
dXRleF9sb2NrKCZkZXYtPmxvY2tfcHJpbnRlcl9pbyk7CiAgICAgICAgc3Bpbl9sb2NrX2lycXNh
dmUoJmRldi0+bG9jaywgZmxhZ3MpOworCisgICAgICAgaWYgKGRldi0+aW50ZXJmYWNlIDwgMCkg
eworICAgICAgICAgICAgICAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZGV2LT5sb2NrLCBmbGFn
cyk7CisgICAgICAgICAgICAgICBtdXRleF91bmxvY2soJmRldi0+bG9ja19wcmludGVyX2lvKTsK
KyAgICAgICAgICAgICAgIHJldHVybiBFUE9MTEVSUiB8IEVQT0xMSFVQOworICAgICAgIH0KKwog
ICAgICAgIHNldHVwX3J4X3JlcXMoZGV2KTsKICAgICAgICBzcGluX3VubG9ja19pcnFyZXN0b3Jl
KCZkZXYtPmxvY2ssIGZsYWdzKTsKICAgICAgICBtdXRleF91bmxvY2soJmRldi0+bG9ja19wcmlu
dGVyX2lvKTsKQEAgLTcyMiw2ICs3NTMsMTEgQEAgcHJpbnRlcl9pb2N0bChzdHJ1Y3QgZmlsZSAq
ZmQsIHVuc2lnbmVkIGludCBjb2RlLCB1bnNpZ25lZCBsb25nIGFyZykKCiAgICAgICAgc3Bpbl9s
b2NrX2lycXNhdmUoJmRldi0+bG9jaywgZmxhZ3MpOwoKKyAgICAgICBpZiAoZGV2LT5pbnRlcmZh
Y2UgPCAwKSB7CisgICAgICAgICAgICAgICBzcGluX3VubG9ja19pcnFyZXN0b3JlKCZkZXYtPmxv
Y2ssIGZsYWdzKTsKKyAgICAgICAgICAgICAgIHJldHVybiAtRU5PREVWOworICAgICAgIH0KKwog
ICAgICAgIHN3aXRjaCAoY29kZSkgewogICAgICAgIGNhc2UgR0FER0VUX0dFVF9QUklOVEVSX1NU
QVRVUzoKICAgICAgICAgICAgICAgIHN0YXR1cyA9IChpbnQpZGV2LT5wcmludGVyX3N0YXR1czsK
LS0KMi4yNC4xCgo=
