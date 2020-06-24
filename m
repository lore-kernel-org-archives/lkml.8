Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F404C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E25CF20836
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="OMGl3eE3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388766AbgFXI7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 04:59:44 -0400
Received: from mail-dm6nam12on2087.outbound.protection.outlook.com ([40.107.243.87]:37344
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387491AbgFXI7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 04:59:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Chj6KYRgxiOdvkgLgmTlm+YhwkNmLJobrS9VOPh+m3qxZMnkKLfIM4/a8nMDf3ATFdSIoIFp5rq56lnEmkLHK9U8vKPQIzZ2kgCjGW55kZZbi7aAhFTutUpJf3+CMRSsSMiaNLF5/J9MEmmlo3zBQAVcL00WbQ9YhBDXVoXSAjhKm0vyI50MhPjbATWoQZRoyouO5KZI/WXXEg6oNotj4OkgGlNlr6dt1XMI//QeWfnXKGooRUaR8JrsOVDu9ixfpi3IQfWsugUQ7vXaoSXlEjxCAKmcAOmSS9UTDvcAMTTjamVY+v9zJYmpoN4L5MKk+c8RIeSKH8GlS6l+wd9kQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRxp9wK9Nl9F91Rjm5N/DQPlxWsK+Hf52pGQuA0q8bk=;
 b=PnhZYTSRCX28DqXdbrsIhBspScTz1UpklKQUMG7/snvuv7djXvkQ6LvEdVHvAaCOvLSbNINvfbPppGjc2P08DPy694Km3mOyi5PaBigz5KfW6OVeRWXmBboDV9JOn6w7EP/PKS/0J6e/nCjiOLPHjUKj1s/yGPtuagJ29ZxRVbYEUE70y/Ubokdq80+nFMOOQzDBI+Ff/9cL6US9hFmOS9+jKbc8EpdzEew5MpI4uOx1yThqFeZWzQPXkSLJHWp1fVFCzEsv9bG31xsrKw7qo/TA30YdfftLLPLuWPKfO6OOuqAOv0fke4xoJhAzosy4YbMJYLhDhnB8o+61uWE1sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRxp9wK9Nl9F91Rjm5N/DQPlxWsK+Hf52pGQuA0q8bk=;
 b=OMGl3eE3GQ5Qu+n2+Lijfye1DJK9YkofiqJJYljRIYUCF+ME8LJPiR17ugfSDO9mcPs90tJdknUISPj6I6CDLjwmNTPcDAJN7c8JZlg8GzSAWrKbi+RvuihXqSXC3cBCkvzrtCD8vL9jtfMkrHpeYqXhJJYRx3m+00aNdftaw6Y=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB3813.namprd11.prod.outlook.com (2603:10b6:a03:ff::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.24; Wed, 24 Jun
 2020 08:59:41 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::3d7d:dfc1:b35d:63d1]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::3d7d:dfc1:b35d:63d1%7]) with mapi id 15.20.3109.027; Wed, 24 Jun 2020
 08:59:41 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSB1c2I6IGdhZGdldDogZnVuY3Rpb246IHByaW50ZXI6?=
 =?gb2312?Q?_Add_gadget_dev_interface_status_judgment?=
Thread-Topic: [PATCH] usb: gadget: function: printer: Add gadget dev interface
 status judgment
Thread-Index: AQHWQviu7UnxlHpgaE2VuvYHPsK4SajnhMek
Date:   Wed, 24 Jun 2020 08:59:40 +0000
Message-ID: <BYAPR11MB26324BC70657061DA849A384FF950@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <20200615094608.26179-1-qiang.zhang@windriver.com>
In-Reply-To: <20200615094608.26179-1-qiang.zhang@windriver.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87a454d1-31c3-482c-de87-08d8181cee68
x-ms-traffictypediagnostic: BYAPR11MB3813:
x-microsoft-antispam-prvs: <BYAPR11MB3813DD20EBFA2A34F9AB5F8DFF950@BYAPR11MB3813.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dbcbuyo93hR2uOvtG1rHDFH0uukh9rJceif7AQ+BmtutlXw/ooyyNT7A2mPXZLmhA/9ppM5RvqWr4VjKXmsFjJL0cgzBwh8Q/HiZRsdI3lUVg6zVWOGntaP2z4NF5aCTnJJa88GLbmje1tp0/0AivBf8KZYxTwprGGBua9OXhtF4g5IwDsaTcNBjtI1VTo7j6faMCoWODCy/PgroZ/b3lXSAkiqU2AJDc+DSz4HMHh2ypx4Yt2k1XBcYb8zTYsOcJrDVcWwYsKVdxgP8ggba+E0WvTWZ0qcgXVSK+roFJYvzIHs/VfQe40m9gnI552R9DSBf4ngYNPIiL3e1+AYGpw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(376002)(39830400003)(136003)(396003)(346002)(186003)(4326008)(2906002)(54906003)(9686003)(71200400001)(83380400001)(8936002)(478600001)(7696005)(55016002)(6916009)(86362001)(6506007)(316002)(66946007)(26005)(33656002)(76116006)(224303003)(66476007)(66446008)(66556008)(64756008)(5660300002)(52536014)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Gl+FzeoYgSryHEBSG0d5Iu6CuTspxcucLO9PkxVVkql/tXI9Y5LlO8Sb2RMpsn1swF14CMib5hzzagSwZDl7CpHgdmpU42xlOoAPV0vsAcgiKXa1CkTcBfQVcm0V+vJBF15i6QZjQfRaMytNhCm/cpBdEkIQGW+3kNamT5RxwfUuTURznDlxRMHkVlNcLmW/S8Rn2LMqmiffYCFfXnHOCDt/d5ktserv8zU19lmdZzwYSENXCoSfIcOOoJhgmxezOFxnLJEdZKN9oOBv7lNVPR48+Wjc90f/bvZuVUBChnIKVTuszEzJrm9q50A75g2u801blAeJXlFBnY9fQsm5iXXVCvVACRtb0eUtMimTeGI0koe37PE8jhuuLLHEPuQ6ratDWDuizZbbi8N8t3OQj+xvLFETkXC4CehTX5HzVyhAehkOn6/zGu1fhGWG6r1k0grSdlrlIWRfU8t5FAqJD5iBPxrjJNPMZAJQMfTGvN0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a454d1-31c3-482c-de87-08d8181cee68
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 08:59:40.9367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E2gJnjyQJTxTLICx3zkD4FElotS4k4z2HHetm0lTvSNaI8bQk1OfClJIZ/ybNWoX43OyllF8gLBKanRRT7yyNp6rcBzihf6OCWHMQnOzF6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3813
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sIEdyZWcgS0gKUGxlYXNlIGhhdmUgeW91IHJldmlldyB0aGUgcGF0Y2g/Cgp0aGFua3MK
WnFpYW5nCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Kt6K8/sjLOiBs
aW51eC11c2Itb3duZXJAdmdlci5rZXJuZWwub3JnIDxsaW51eC11c2Itb3duZXJAdmdlci5rZXJu
ZWwub3JnPiC0+rHtIHFpYW5nLnpoYW5nQHdpbmRyaXZlci5jb20gPHFpYW5nLnpoYW5nQHdpbmRy
aXZlci5jb20+Creiy83KsbzkOiAyMDIwxOo21MIxNcjVIDE3OjQ2CsrVvP7IyzogYmFsYmlAa2Vy
bmVsLm9yZwqzrcvNOiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgbGludXgtdXNiQHZnZXIu
a2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZwrW98ziOiBbUEFUQ0hdIHVz
YjogZ2FkZ2V0OiBmdW5jdGlvbjogcHJpbnRlcjogQWRkIGdhZGdldCBkZXYgaW50ZXJmYWNlIHN0
YXR1cyBqdWRnbWVudAoKRnJvbTogWnFpYW5nIDxxaWFuZy56aGFuZ0B3aW5kcml2ZXIuY29tPgoK
QWZ0ZXIgdGhlIGludGVyZmFjZSBvZiBnYWRnZXQgcHJpbnRlciBkZXZpY2Ugd2FzIGRpc2FibGVk
LApXZSBzaG91bGQgbm90IGNvbnRpbnVlIG9wZXJhdGUgdGhlIGRldmljZS4KClNpZ25lZC1vZmYt
Ynk6IFpxaWFuZyA8cWlhbmcuemhhbmdAd2luZHJpdmVyLmNvbT4KLS0tCiBkcml2ZXJzL3VzYi9n
YWRnZXQvZnVuY3Rpb24vZl9wcmludGVyLmMgfCAzNiArKysrKysrKysrKysrKysrKysrKysrKysr
CiAxIGZpbGUgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dXNiL2dhZGdldC9mdW5jdGlvbi9mX3ByaW50ZXIuYyBiL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5j
dGlvbi9mX3ByaW50ZXIuYwppbmRleCA5YzdlZDI1MzlmZjcuLjJiNDVhNjFlNDIxMyAxMDA2NDQK
LS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfcHJpbnRlci5jCisrKyBiL2RyaXZl
cnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX3ByaW50ZXIuYwpAQCAtMzM4LDYgKzMzOCwxMSBAQCBw
cmludGVyX29wZW4oc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZkKQoKICAgICAg
ICBzcGluX2xvY2tfaXJxc2F2ZSgmZGV2LT5sb2NrLCBmbGFncyk7CgorICAgICAgIGlmIChkZXYt
PmludGVyZmFjZSA8IDApIHsKKyAgICAgICAgICAgICAgIHNwaW5fdW5sb2NrX2lycXJlc3RvcmUo
JmRldi0+bG9jaywgZmxhZ3MpOworICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9ERVY7CisgICAg
ICAgfQorCiAgICAgICAgaWYgKCFkZXYtPnByaW50ZXJfY2Rldl9vcGVuKSB7CiAgICAgICAgICAg
ICAgICBkZXYtPnByaW50ZXJfY2Rldl9vcGVuID0gMTsKICAgICAgICAgICAgICAgIGZkLT5wcml2
YXRlX2RhdGEgPSBkZXY7CkBAIC00MzAsNiArNDM1LDEyIEBAIHByaW50ZXJfcmVhZChzdHJ1Y3Qg
ZmlsZSAqZmQsIGNoYXIgX191c2VyICpidWYsIHNpemVfdCBsZW4sIGxvZmZfdCAqcHRyKQogICAg
ICAgIG11dGV4X2xvY2soJmRldi0+bG9ja19wcmludGVyX2lvKTsKICAgICAgICBzcGluX2xvY2tf
aXJxc2F2ZSgmZGV2LT5sb2NrLCBmbGFncyk7CgorICAgICAgIGlmIChkZXYtPmludGVyZmFjZSA8
IDApIHsKKyAgICAgICAgICAgICAgIHNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmRldi0+bG9jaywg
ZmxhZ3MpOworICAgICAgICAgICAgICAgbXV0ZXhfdW5sb2NrKCZkZXYtPmxvY2tfcHJpbnRlcl9p
byk7CisgICAgICAgICAgICAgICByZXR1cm4gLUVOT0RFVjsKKyAgICAgICB9CisKICAgICAgICAv
KiBXZSB3aWxsIHVzZSB0aGlzIGZsYWcgbGF0ZXIgdG8gY2hlY2sgaWYgYSBwcmludGVyIHJlc2V0
IGhhcHBlbmVkCiAgICAgICAgICogYWZ0ZXIgd2UgdHVybiBpbnRlcnJ1cHRzIGJhY2sgb24uCiAg
ICAgICAgICovCkBAIC01NjEsNiArNTcyLDEyIEBAIHByaW50ZXJfd3JpdGUoc3RydWN0IGZpbGUg
KmZkLCBjb25zdCBjaGFyIF9fdXNlciAqYnVmLCBzaXplX3QgbGVuLCBsb2ZmX3QgKnB0cikKICAg
ICAgICBtdXRleF9sb2NrKCZkZXYtPmxvY2tfcHJpbnRlcl9pbyk7CiAgICAgICAgc3Bpbl9sb2Nr
X2lycXNhdmUoJmRldi0+bG9jaywgZmxhZ3MpOwoKKyAgICAgICBpZiAoZGV2LT5pbnRlcmZhY2Ug
PCAwKSB7CisgICAgICAgICAgICAgICBzcGluX3VubG9ja19pcnFyZXN0b3JlKCZkZXYtPmxvY2ss
IGZsYWdzKTsKKyAgICAgICAgICAgICAgIG11dGV4X3VubG9jaygmZGV2LT5sb2NrX3ByaW50ZXJf
aW8pOworICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9ERVY7CisgICAgICAgfQorCiAgICAgICAg
LyogQ2hlY2sgaWYgYSBwcmludGVyIHJlc2V0IGhhcHBlbnMgd2hpbGUgd2UgaGF2ZSBpbnRlcnJ1
cHRzIG9uICovCiAgICAgICAgZGV2LT5yZXNldF9wcmludGVyID0gMDsKCkBAIC02NjcsNiArNjg0
LDEzIEBAIHByaW50ZXJfZnN5bmMoc3RydWN0IGZpbGUgKmZkLCBsb2ZmX3Qgc3RhcnQsIGxvZmZf
dCBlbmQsIGludCBkYXRhc3luYykKCiAgICAgICAgaW5vZGVfbG9jayhpbm9kZSk7CiAgICAgICAg
c3Bpbl9sb2NrX2lycXNhdmUoJmRldi0+bG9jaywgZmxhZ3MpOworCisgICAgICAgaWYgKGRldi0+
aW50ZXJmYWNlIDwgMCkgeworICAgICAgICAgICAgICAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgm
ZGV2LT5sb2NrLCBmbGFncyk7CisgICAgICAgICAgICAgICBpbm9kZV91bmxvY2soaW5vZGUpOwor
ICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9ERVY7CisgICAgICAgfQorCiAgICAgICAgdHhfbGlz
dF9lbXB0eSA9IChsaWtlbHkobGlzdF9lbXB0eSgmZGV2LT50eF9yZXFzKSkpOwogICAgICAgIHNw
aW5fdW5sb2NrX2lycXJlc3RvcmUoJmRldi0+bG9jaywgZmxhZ3MpOwoKQEAgLTY4OSw2ICs3MTMs
MTMgQEAgcHJpbnRlcl9wb2xsKHN0cnVjdCBmaWxlICpmZCwgcG9sbF90YWJsZSAqd2FpdCkKCiAg
ICAgICAgbXV0ZXhfbG9jaygmZGV2LT5sb2NrX3ByaW50ZXJfaW8pOwogICAgICAgIHNwaW5fbG9j
a19pcnFzYXZlKCZkZXYtPmxvY2ssIGZsYWdzKTsKKworICAgICAgIGlmIChkZXYtPmludGVyZmFj
ZSA8IDApIHsKKyAgICAgICAgICAgICAgIHNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmRldi0+bG9j
aywgZmxhZ3MpOworICAgICAgICAgICAgICAgbXV0ZXhfdW5sb2NrKCZkZXYtPmxvY2tfcHJpbnRl
cl9pbyk7CisgICAgICAgICAgICAgICByZXR1cm4gRVBPTExFUlIgfCBFUE9MTEhVUDsKKyAgICAg
ICB9CisKICAgICAgICBzZXR1cF9yeF9yZXFzKGRldik7CiAgICAgICAgc3Bpbl91bmxvY2tfaXJx
cmVzdG9yZSgmZGV2LT5sb2NrLCBmbGFncyk7CiAgICAgICAgbXV0ZXhfdW5sb2NrKCZkZXYtPmxv
Y2tfcHJpbnRlcl9pbyk7CkBAIC03MjIsNiArNzUzLDExIEBAIHByaW50ZXJfaW9jdGwoc3RydWN0
IGZpbGUgKmZkLCB1bnNpZ25lZCBpbnQgY29kZSwgdW5zaWduZWQgbG9uZyBhcmcpCgogICAgICAg
IHNwaW5fbG9ja19pcnFzYXZlKCZkZXYtPmxvY2ssIGZsYWdzKTsKCisgICAgICAgaWYgKGRldi0+
aW50ZXJmYWNlIDwgMCkgeworICAgICAgICAgICAgICAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgm
ZGV2LT5sb2NrLCBmbGFncyk7CisgICAgICAgICAgICAgICByZXR1cm4gLUVOT0RFVjsKKyAgICAg
ICB9CisKICAgICAgICBzd2l0Y2ggKGNvZGUpIHsKICAgICAgICBjYXNlIEdBREdFVF9HRVRfUFJJ
TlRFUl9TVEFUVVM6CiAgICAgICAgICAgICAgICBzdGF0dXMgPSAoaW50KWRldi0+cHJpbnRlcl9z
dGF0dXM7Ci0tCjIuMjQuMQoK
