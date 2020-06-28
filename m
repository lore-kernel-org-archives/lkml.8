Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DA6C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 01:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B6572081A
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 01:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="nY6DGvTP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgF1BOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 21:14:48 -0400
Received: from mail-eopbgr750051.outbound.protection.outlook.com ([40.107.75.51]:51567
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726378AbgF1BOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 21:14:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQvckncxK/yfQTQvBPPYHfNUTZoOZnS/gdxdXhAH0me3SlmOv66hteGclnBxgi78bqLgu+oXYJmExenWIXw73DkWzKmx1xG+rjWsjhQq+y42v5M+vciCw1LCDmIhtve1Ch+f/zFakKugEQaUPN4PiBPJsk1l9GOplrzFqo5Cf4xY5wiEt/LwPQl/H4koi6lMxeRIJGj6QQl4xhpCJoqIi559fsP00y4Yh0PPjfzU02VAcK+4h3cpTkZQ3/Oo7Orbwg8InjA3x6F6/R1jH8o5pBYRCHlgSHbpqTAy1qkXa0CtR7rcHiFnlLO2C/J3HDAxYP2b5dVJJAb7hC0jEdAqtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOU1rFwb6+wypV9rPQSji24NFpeO7zZlatj4qajH1vI=;
 b=Zjd1eoHJNNdoogFt7hZRn53vTSbVqKahabkEponYhLwJQAhwT3+Wll3OL+QL4E2K8LBKIK+pxFVt9Bm9BMJCT+UMxcjY1Z3YWHIopL+4JSlevs31s/oN0d6Mrt5pH9XYQyGwX+GN88LTds/vKsYED+YT9tTewGpko3NkpykB4qZYfmbu28qmsIggb2DpNJD4Ce1PzotoMB+beAvSk6h8Yq4izL5rXgg7p/hIxR6WnFxKmCvhP1AOqg0+oixTWzvWkFFhtEsyBECdp15YEZUKemy+lOcr+cFdmhfwFUo4YLRt6VN3hKzeCFlRhb1Byt+/MCP3KNXhlcJo0JM9h0ACTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOU1rFwb6+wypV9rPQSji24NFpeO7zZlatj4qajH1vI=;
 b=nY6DGvTPax4+66AjybZ7moVmWfNwEB6SqV/FVNW01+0+8s5Z6ZTSpqoZ/V4ptjWPnkhqpKnKwIwcNHQ5CMh0vPlhWvCo+FHSwobIkmuhkLk24iWvi1IpfDFuA3etCvM2BBpyOKgak3mMONhGKnbE9MvzuQIbSeR4WbJERz+HIvU=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BY5PR11MB4008.namprd11.prod.outlook.com (2603:10b6:a03:186::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Sun, 28 Jun
 2020 01:14:43 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::3d7d:dfc1:b35d:63d1]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::3d7d:dfc1:b35d:63d1%7]) with mapi id 15.20.3131.026; Sun, 28 Jun 2020
 01:14:42 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     "balbi@kernel.org" <balbi@kernel.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSB1c2I6IGdhZGdldDogZnVuY3Rpb246IHByaW50ZXI6?=
 =?gb2312?Q?_Add_gadget_dev_interface_status_judgment?=
Thread-Topic: [PATCH] usb: gadget: function: printer: Add gadget dev interface
 status judgment
Thread-Index: AQHWQviu7UnxlHpgaE2VuvYHPsK4SajtTPLn
Date:   Sun, 28 Jun 2020 01:14:42 +0000
Message-ID: <BYAPR11MB2632EA8B20AE37583B252FD6FF910@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <20200615094608.26179-1-qiang.zhang@windriver.com>
In-Reply-To: <20200615094608.26179-1-qiang.zhang@windriver.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b7a9660-0855-4f5e-78b6-08d81b00a36a
x-ms-traffictypediagnostic: BY5PR11MB4008:
x-microsoft-antispam-prvs: <BY5PR11MB4008366459239A140B690B44FF910@BY5PR11MB4008.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-forefront-prvs: 0448A97BF2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bt3tzURCQhOp6cHjufQry3PmVzoo5H+7R7DHhXF0bs/6tCpakcQ0Osd/LI+Sw5vFFiqa8XWdy9qk6jwOveu0VI6ugMzeoB5+8Aq6MeGtIyzOccd2uv+fI52OqYiFBdkmFyh5rTJaUhgw/48witdZikvcUeFF6IN9XmkT99w+uvEZoJ43N/7gbth6CwQL9/HddZBpdgBev/3WhoD+b/1kFJXN00MJuKUNrAhnRSW94XCveaG81cJyZsfnpLo0d40CYcTF5AjwL94pEVodWlO99JKF0ixu0AzuNxEkRV9mwt5A2qWsPO0e9UDRyf334zpmbsNIbzZOMC3CENC220sWTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(376002)(396003)(346002)(39830400003)(136003)(2906002)(52536014)(8936002)(316002)(5660300002)(33656002)(83380400001)(4326008)(91956017)(71200400001)(66476007)(66556008)(186003)(64756008)(110136005)(86362001)(224303003)(55016002)(9686003)(66946007)(66446008)(26005)(76116006)(7696005)(478600001)(54906003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 5lTRiVt0ZzVppjikJ2TfMyVo74bAerArlnrhlcAHDtDzaFXbsq9hIpAlOSAryScQHEWLGQtgKn+yOGUktYwPYAo/lISO/S7GtanXDg+HDu2SDlyFwZycKZ2CYSNPSKJrvZ4V/by1SRt7sjuk2aJjK7tOD34epYd0QXgDwr8vGH+qwbmf6+ockiuuk5MMwG/RdbwPJItvggOO+OrA78bXkGw3WvEWWveMoXhYtduQHQx/gXpVBRf25syTJdNEz53sxomh6+2eioBZqL0y5LRwio9HAOZzx0oL7UoSjTnVrCi/rjcpF+EYmspz0cbXgQ7taSZnRnzRsI5OCTurX6qfe7rsxriXQIJq1c3I2Xrcn7zz3IVIxB8vm8tN3L+TXpQQPKCahfgzwvE9b6tIYXJq8TD+L7RgdZFePdayddRcVCtJWn/S+6TcqSWQ2TfHH067VVbQeD9daauKLt75rvZ1BhxSDgxFCp+S1pDgFLf48EY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b7a9660-0855-4f5e-78b6-08d81b00a36a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2020 01:14:42.5580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5UmPkKSJg5HVcAsZbO/j9bMirtIivgxY0tpx+62LhyWRWb/exiEtB/E8h9g0LuhP44zHraj3O4hLa4mcqldXR/lSRKUFnxuNq1S4/FuHz/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4008
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCreivP7IyzogbGludXgt
dXNiLW93bmVyQHZnZXIua2VybmVsLm9yZyA8bGludXgtdXNiLW93bmVyQHZnZXIua2VybmVsLm9y
Zz4gtPqx7SBxaWFuZy56aGFuZ0B3aW5kcml2ZXIuY29tIDxxaWFuZy56aGFuZ0B3aW5kcml2ZXIu
Y29tPgq3osvNyrG85DogMjAyMMTqNtTCMTXI1SAxNzo0NgrK1bz+yMs6IGJhbGJpQGtlcm5lbC5v
cmcKs63LzTogZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IGxpbnV4LXVzYkB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcK1vfM4jogW1BBVENIXSB1c2I6IGdh
ZGdldDogZnVuY3Rpb246IHByaW50ZXI6IEFkZCBnYWRnZXQgZGV2IGludGVyZmFjZSBzdGF0dXMg
anVkZ21lbnQKCkZyb206IFpxaWFuZyA8cWlhbmcuemhhbmdAd2luZHJpdmVyLmNvbT4KCkFmdGVy
IHRoZSBpbnRlcmZhY2Ugb2YgZ2FkZ2V0IHByaW50ZXIgZGV2aWNlIHdhcyBkaXNhYmxlZCwKV2Ug
c2hvdWxkIG5vdCBjb250aW51ZSBvcGVyYXRlIHRoZSBkZXZpY2UuCgpTaWduZWQtb2ZmLWJ5OiBa
cWlhbmcgPHFpYW5nLnpoYW5nQHdpbmRyaXZlci5jb20+Ci0tLQogZHJpdmVycy91c2IvZ2FkZ2V0
L2Z1bmN0aW9uL2ZfcHJpbnRlci5jIHwgMzYgKysrKysrKysrKysrKysrKysrKysrKysrKwogMSBm
aWxlIGNoYW5nZWQsIDM2IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9n
YWRnZXQvZnVuY3Rpb24vZl9wcmludGVyLmMgYi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24v
Zl9wcmludGVyLmMKaW5kZXggOWM3ZWQyNTM5ZmY3Li4yYjQ1YTYxZTQyMTMgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX3ByaW50ZXIuYworKysgYi9kcml2ZXJzL3Vz
Yi9nYWRnZXQvZnVuY3Rpb24vZl9wcmludGVyLmMKQEAgLTMzOCw2ICszMzgsMTEgQEAgcHJpbnRl
cl9vcGVuKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmZCkKCiAgICAgICAgc3Bp
bl9sb2NrX2lycXNhdmUoJmRldi0+bG9jaywgZmxhZ3MpOwoKKyAgICAgICBpZiAoZGV2LT5pbnRl
cmZhY2UgPCAwKSB7CisgICAgICAgICAgICAgICBzcGluX3VubG9ja19pcnFyZXN0b3JlKCZkZXYt
PmxvY2ssIGZsYWdzKTsKKyAgICAgICAgICAgICAgIHJldHVybiAtRU5PREVWOworICAgICAgIH0K
KwogICAgICAgIGlmICghZGV2LT5wcmludGVyX2NkZXZfb3BlbikgewogICAgICAgICAgICAgICAg
ZGV2LT5wcmludGVyX2NkZXZfb3BlbiA9IDE7CiAgICAgICAgICAgICAgICBmZC0+cHJpdmF0ZV9k
YXRhID0gZGV2OwpAQCAtNDMwLDYgKzQzNSwxMiBAQCBwcmludGVyX3JlYWQoc3RydWN0IGZpbGUg
KmZkLCBjaGFyIF9fdXNlciAqYnVmLCBzaXplX3QgbGVuLCBsb2ZmX3QgKnB0cikKICAgICAgICBt
dXRleF9sb2NrKCZkZXYtPmxvY2tfcHJpbnRlcl9pbyk7CiAgICAgICAgc3Bpbl9sb2NrX2lycXNh
dmUoJmRldi0+bG9jaywgZmxhZ3MpOwoKKyAgICAgICBpZiAoZGV2LT5pbnRlcmZhY2UgPCAwKSB7
CisgICAgICAgICAgICAgICBzcGluX3VubG9ja19pcnFyZXN0b3JlKCZkZXYtPmxvY2ssIGZsYWdz
KTsKKyAgICAgICAgICAgICAgIG11dGV4X3VubG9jaygmZGV2LT5sb2NrX3ByaW50ZXJfaW8pOwor
ICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9ERVY7CisgICAgICAgfQorCiAgICAgICAgLyogV2Ug
d2lsbCB1c2UgdGhpcyBmbGFnIGxhdGVyIHRvIGNoZWNrIGlmIGEgcHJpbnRlciByZXNldCBoYXBw
ZW5lZAogICAgICAgICAqIGFmdGVyIHdlIHR1cm4gaW50ZXJydXB0cyBiYWNrIG9uLgogICAgICAg
ICAqLwpAQCAtNTYxLDYgKzU3MiwxMiBAQCBwcmludGVyX3dyaXRlKHN0cnVjdCBmaWxlICpmZCwg
Y29uc3QgY2hhciBfX3VzZXIgKmJ1Ziwgc2l6ZV90IGxlbiwgbG9mZl90ICpwdHIpCiAgICAgICAg
bXV0ZXhfbG9jaygmZGV2LT5sb2NrX3ByaW50ZXJfaW8pOwogICAgICAgIHNwaW5fbG9ja19pcnFz
YXZlKCZkZXYtPmxvY2ssIGZsYWdzKTsKCisgICAgICAgaWYgKGRldi0+aW50ZXJmYWNlIDwgMCkg
eworICAgICAgICAgICAgICAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZGV2LT5sb2NrLCBmbGFn
cyk7CisgICAgICAgICAgICAgICBtdXRleF91bmxvY2soJmRldi0+bG9ja19wcmludGVyX2lvKTsK
KyAgICAgICAgICAgICAgIHJldHVybiAtRU5PREVWOworICAgICAgIH0KKwogICAgICAgIC8qIENo
ZWNrIGlmIGEgcHJpbnRlciByZXNldCBoYXBwZW5zIHdoaWxlIHdlIGhhdmUgaW50ZXJydXB0cyBv
biAqLwogICAgICAgIGRldi0+cmVzZXRfcHJpbnRlciA9IDA7CgpAQCAtNjY3LDYgKzY4NCwxMyBA
QCBwcmludGVyX2ZzeW5jKHN0cnVjdCBmaWxlICpmZCwgbG9mZl90IHN0YXJ0LCBsb2ZmX3QgZW5k
LCBpbnQgZGF0YXN5bmMpCgogICAgICAgIGlub2RlX2xvY2soaW5vZGUpOwogICAgICAgIHNwaW5f
bG9ja19pcnFzYXZlKCZkZXYtPmxvY2ssIGZsYWdzKTsKKworICAgICAgIGlmIChkZXYtPmludGVy
ZmFjZSA8IDApIHsKKyAgICAgICAgICAgICAgIHNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmRldi0+
bG9jaywgZmxhZ3MpOworICAgICAgICAgICAgICAgaW5vZGVfdW5sb2NrKGlub2RlKTsKKyAgICAg
ICAgICAgICAgIHJldHVybiAtRU5PREVWOworICAgICAgIH0KKwogICAgICAgIHR4X2xpc3RfZW1w
dHkgPSAobGlrZWx5KGxpc3RfZW1wdHkoJmRldi0+dHhfcmVxcykpKTsKICAgICAgICBzcGluX3Vu
bG9ja19pcnFyZXN0b3JlKCZkZXYtPmxvY2ssIGZsYWdzKTsKCkBAIC02ODksNiArNzEzLDEzIEBA
IHByaW50ZXJfcG9sbChzdHJ1Y3QgZmlsZSAqZmQsIHBvbGxfdGFibGUgKndhaXQpCgogICAgICAg
IG11dGV4X2xvY2soJmRldi0+bG9ja19wcmludGVyX2lvKTsKICAgICAgICBzcGluX2xvY2tfaXJx
c2F2ZSgmZGV2LT5sb2NrLCBmbGFncyk7CisKKyAgICAgICBpZiAoZGV2LT5pbnRlcmZhY2UgPCAw
KSB7CisgICAgICAgICAgICAgICBzcGluX3VubG9ja19pcnFyZXN0b3JlKCZkZXYtPmxvY2ssIGZs
YWdzKTsKKyAgICAgICAgICAgICAgIG11dGV4X3VubG9jaygmZGV2LT5sb2NrX3ByaW50ZXJfaW8p
OworICAgICAgICAgICAgICAgcmV0dXJuIEVQT0xMRVJSIHwgRVBPTExIVVA7CisgICAgICAgfQor
CiAgICAgICAgc2V0dXBfcnhfcmVxcyhkZXYpOwogICAgICAgIHNwaW5fdW5sb2NrX2lycXJlc3Rv
cmUoJmRldi0+bG9jaywgZmxhZ3MpOwogICAgICAgIG11dGV4X3VubG9jaygmZGV2LT5sb2NrX3By
aW50ZXJfaW8pOwpAQCAtNzIyLDYgKzc1MywxMSBAQCBwcmludGVyX2lvY3RsKHN0cnVjdCBmaWxl
ICpmZCwgdW5zaWduZWQgaW50IGNvZGUsIHVuc2lnbmVkIGxvbmcgYXJnKQoKICAgICAgICBzcGlu
X2xvY2tfaXJxc2F2ZSgmZGV2LT5sb2NrLCBmbGFncyk7CgorICAgICAgIGlmIChkZXYtPmludGVy
ZmFjZSA8IDApIHsKKyAgICAgICAgICAgICAgIHNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmRldi0+
bG9jaywgZmxhZ3MpOworICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9ERVY7CisgICAgICAgfQor
CiAgICAgICAgc3dpdGNoIChjb2RlKSB7CiAgICAgICAgY2FzZSBHQURHRVRfR0VUX1BSSU5URVJf
U1RBVFVTOgogICAgICAgICAgICAgICAgc3RhdHVzID0gKGludClkZXYtPnByaW50ZXJfc3RhdHVz
OwotLQoyLjI0LjEKCg==
