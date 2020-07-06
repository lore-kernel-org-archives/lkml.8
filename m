Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9ACCC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 05:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E83A20715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 05:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="okzpwyK1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbgGFFQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 01:16:35 -0400
Received: from mail-dm6nam12on2088.outbound.protection.outlook.com ([40.107.243.88]:13728
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726918AbgGFFQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 01:16:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPmCNp23ooY21YRtgLAovh5JxmKlvbeh1dLiwOgOu2eXOcswLtd+gXne9gaHm5NN2xKge2IVz5NoYXQSNJIvOgP8ZIyynGnuCV/umk3uQH40mjZc7N66pVBXS+cPqwGt91Bd+3juQEBLwckpzdUwhT2gToTO9hOOrpLrQogcuZGo9zOYIzIuzc2KQWAKDcErn0ghMiBossqggkXptlT8+vmXLJq4CYm+mIPOjDvw6HQSTy5mxJ/cW6FEguV6DHASd0q5Ya+vj3i9BQxGU2oQiW9EutPE6Hc5SU1/PP4MSF3tkULsW2OdU0zlVZGOCGYL1MBeHC2II6yYZiBgVhgWVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eureZzNnSiBRd4JN949d2O25IJHJQawciHKGebfXHSw=;
 b=JSYgUWdlrG1qP5R7Aluu0zjaLJLZKU1SelGbR6qsRm6vqweuAFy61a2il3JkWbXkzWAnlx6y2oVkMiPky9rAF7DSYJF3wD8iTZRDmI90WQKxXaMnCtdOquop+15VcvsVj8dEyFDONHAjYy42Gx+Q3KXRNQdrmlKy3czLnyImycADkxos+EDeZnoeo/jK8eR0NnbcSKPosXktEMzBmAZNMSzLSGnHFelZi+ghJVGDCwB5GvOwCrHytMzGJxfUJom0Pl8npm6jPPMcxhRIIWC04Ys3hfo4wkI4vAuIw02h25eU2YuegV2CeF+Hd5v70w4OEfRl0VDimKpvmK/ioYMBZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eureZzNnSiBRd4JN949d2O25IJHJQawciHKGebfXHSw=;
 b=okzpwyK1Rw9tLSvFvgy3UMGeO/E7vpbkcIi9eS7/TZru3F0reSF8fIVT6RGT750tujGxs9VfVtK03h5wNjeEqkI4QdzEwelvbKnqHD7HbnXmshcY3g1YOinffBhUP79pX5mVrifzlDD6tjmusAcCbKLNDIgKnr0L9YvxJZY8DH4=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB2918.namprd11.prod.outlook.com (2603:10b6:a03:92::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Mon, 6 Jul
 2020 05:16:31 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::3d7d:dfc1:b35d:63d1]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::3d7d:dfc1:b35d:63d1%7]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 05:16:31 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     "balbi@kernel.org" <balbi@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ruslan.bilovol@gmail.com" <ruslan.bilovol@gmail.com>,
        "cooloney@kernel.org" <cooloney@kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSB1c2I6IGdhZGdldDogZnVuY3Rpb246IGZpeCBtaXNz?=
 =?gb2312?B?aW5nIHNwaW5sb2NrIGluIGZfdWFjMV9sZWdhY3k=?=
Thread-Topic: [PATCH] usb: gadget: function: fix missing spinlock in
 f_uac1_legacy
Thread-Index: AQHWU0garYTc8CykzUCzjiGJP5dO1aj6AeVe
Date:   Mon, 6 Jul 2020 05:16:30 +0000
Message-ID: <BYAPR11MB26320D89506AFF3949602C94FF690@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <20200705015941.40485-1-qiang.zhang@windriver.com>
In-Reply-To: <20200705015941.40485-1-qiang.zhang@windriver.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 100b8114-51dc-4c55-a565-08d8216bbe54
x-ms-traffictypediagnostic: BYAPR11MB2918:
x-microsoft-antispam-prvs: <BYAPR11MB2918CC58F5352A3E675593C7FF690@BYAPR11MB2918.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 04569283F9
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kKAtt7Inua4CDwEsx80paE0MtOHtRTgVXMEYmbkzwu+EAVMFWDeduvkYbaIuoqDIj1xkLKHxdj3b1J9YaL+9nQ0q6xXWlQHs6xrwhDUBFtXBkTEGrmQHx/PJI/XVfETg8lU9kAZ47yVav2fNO3oQO8XkpDQAjrLTi5yuUzWRE2JE177tieCQEOK8e27GbQl8gh8VSH4AwI17gDqPgdaw3wGQeb6OCQtV1nlKtURIacrhRWvLar1EnIRBg6qqVVLSjTFVLS8w9wq2fB08I8wHKRoCu1U/DMpp9dRqTA2KB/dX5bUreD+nYny223lws7LY5jjNSPLxJo8dIgs2qfoJdw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(136003)(396003)(366004)(376002)(39840400004)(86362001)(76116006)(91956017)(8936002)(4326008)(7696005)(26005)(66446008)(64756008)(66946007)(52536014)(6506007)(5660300002)(66476007)(66556008)(71200400001)(2906002)(316002)(186003)(33656002)(6916009)(224303003)(55016002)(83380400001)(9686003)(478600001)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: cJk/1jnNMNtIu4nR1kMcZWs0kqoc3VUz5D7FVc088400PQgfLN1ATV/CAgobnTfDfWUlEWgJL4hNnvWHznoE10JC/Rj90mmS5J3Odilv06uZ28MKJVJGp1dlapQd/itU7CykqaE3rYQ8s4f2CkSZ+KSB1knEqnYI/genFCb4FytjJ/FcoHBjuJV0JS32bKo+z+K88IZJ4Brnzuoo+nSfdKFB5vxCwASUWgeSGBXxospMKuvRpeoTy+9SDA13YezPaPKX6jCYz+2qxv6K+d+0Ncm66VQRAMntpGx7epdycM1WdZnr+7bpiOXGsebJWgcSaoHdCA+6RWZO/k94dGhrhDDPlId/ir/mcd8mlRHGQfbDFuqatwi2DZ9cKRpcdvVajTKx7TSG7Ln2yyS66XmkaYdoflvfcnjHlSj9CDsDaTv+dpeF2ZT6sgy2Pi2DVrnc41+cHD5+cgEAoyiSue5De5hxaNXEFb1/ujPfddCuiVo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 100b8114-51dc-4c55-a565-08d8216bbe54
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2020 05:16:30.9172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mq4bCFxdPxaAlDvJKkbc48vagGCKHrhOc5r55BgoUNFoPN3+HFRPDTO0pP/+8m5qvB6U23FftK9kbnArnRw+jQmOG8nMG+v7UKVIixIZhLg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2918
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQq3orz+yMs6IGxpbnV4
LWtlcm5lbC1vd25lckB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWtlcm5lbC1vd25lckB2Z2VyLmtl
cm5lbC5vcmc+ILT6se0gcWlhbmcuemhhbmdAd2luZHJpdmVyLmNvbSA8cWlhbmcuemhhbmdAd2lu
ZHJpdmVyLmNvbT4NCreiy83KsbzkOiAyMDIwxOo31MI1yNUgOTo1OQ0KytW8/sjLOiBiYWxiaUBr
ZXJuZWwub3JnDQqzrcvNOiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgY29saW4ua2luZ0Bj
YW5vbmljYWwuY29tOyBsaW51eC11c2JAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnDQrW98ziOiBbUEFUQ0hdIHVzYjogZ2FkZ2V0OiBmdW5jdGlvbjogZml4IG1p
c3Npbmcgc3BpbmxvY2sgaW4gZl91YWMxX2xlZ2FjeQ0KDQpGcm9tOiBaaGFuZyBRaWFuZyA8cWlh
bmcuemhhbmdAd2luZHJpdmVyLmNvbT4NCg0KU2lnbmVkLW9mZi1ieTogWmhhbmcgUWlhbmcgPHFp
YW5nLnpoYW5nQHdpbmRyaXZlci5jb20+DQotLS0NCiBkcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rp
b24vZl91YWMxX2xlZ2FjeS5jIHwgMiArKw0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX3VhYzFfbGVn
YWN5LmMgYi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl91YWMxX2xlZ2FjeS5jDQppbmRl
eCAzNDlkZWFlN2NhYmQuLmUyZDdmNjkxMjhhMCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL2dh
ZGdldC9mdW5jdGlvbi9mX3VhYzFfbGVnYWN5LmMNCisrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC9m
dW5jdGlvbi9mX3VhYzFfbGVnYWN5LmMNCkBAIC0zMzYsNyArMzM2LDkgQEAgc3RhdGljIGludCBm
X2F1ZGlvX291dF9lcF9jb21wbGV0ZShzdHJ1Y3QgdXNiX2VwICplcCwgc3RydWN0IHVzYl9yZXF1
ZXN0ICpyZXEpDQoNCiAgICAgICAgLyogQ29weSBidWZmZXIgaXMgZnVsbCwgYWRkIGl0IHRvIHRo
ZSBwbGF5X3F1ZXVlICovDQogICAgICAgIGlmIChhdWRpb19idWZfc2l6ZSAtIGNvcHlfYnVmLT5h
Y3R1YWwgPCByZXEtPmFjdHVhbCkgew0KKyAgICAgICAgICAgICAgIHNwaW5fbG9ja19pcnEoJmF1
ZGlvLT5sb2NrKTsNCiAgICAgICAgICAgICAgICBsaXN0X2FkZF90YWlsKCZjb3B5X2J1Zi0+bGlz
dCwgJmF1ZGlvLT5wbGF5X3F1ZXVlKTsNCisgICAgICAgICAgICAgICBzcGluX3VubG9ja19pcnEo
JmF1ZGlvLT5sb2NrKTsNCiAgICAgICAgICAgICAgICBzY2hlZHVsZV93b3JrKCZhdWRpby0+cGxh
eWJhY2tfd29yayk7DQogICAgICAgICAgICAgICAgY29weV9idWYgPSBmX2F1ZGlvX2J1ZmZlcl9h
bGxvYyhhdWRpb19idWZfc2l6ZSk7DQogICAgICAgICAgICAgICAgaWYgKElTX0VSUihjb3B5X2J1
ZikpDQotLQ0KMi4yNC4xDQoNCg==
