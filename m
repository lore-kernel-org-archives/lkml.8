Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72762C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 03:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EF8E21D40
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 03:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="ePU1Stb7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgIKDNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 23:13:54 -0400
Received: from mail-eopbgr1410139.outbound.protection.outlook.com ([40.107.141.139]:10144
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725300AbgIKDNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 23:13:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kG6qI43TioB9Tbu+ozM/X8qGQkHC79zfvnDCQGBAQeA9D/uX4QOjOaORA3lbnzE3+Iqqd+V0bJizVRj2Wuh439YejPwWIXh0Z8+wJfFG5RM93NXDaKb/Cs9lTiqX6noBe1QHCOti/gm3IpRx1S9JA30YXwVBhtENERcQobv+j9UjNwHy+aupya8P2T/1r1/MgjRDdWwFZQdTEHH3pdKh40x2mIuqob7VVreWu+0nq7tXunS1071olPJmGXmqYWaccONedwW1utxGabV3O05yHO62VaZFMdQX68JacO2//WqC0S4rU18enmuZZhBsIFpBmL4jQJD/yTmfo0/mGZtigg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pB7BHy/1mgzliqHgPP5zdDFZyAxEvfnPkk+1iMJYVD0=;
 b=W6RPcsnyCc/MJOEM5gtNtqnUp+QD731tSyCw4/qX/KveqU7OZHDwAzN+VMQE+DJNKotWtoYtnKMkyRUm9jYaGMWWyYSDCyITEkJij27tQkv91Db7szHxZsTlv4bzANMJCBeren2nQOQpWP+p+G2escc9eD3W8xpn1lIyDYRWCcJV3S8f8m7VM4TWWTu9Y4Kn/OKn1wWC4waTC9DnU3FT/+65aP9xZ3xTFH0gbTCEnep/+aW56CAXkkX71Tq1Tb1ch+glOKUszJOMGUS+eLcu85A51BD7WxHewhMTPnKactLR5vqVkZiHhqaIfoQwMSRpkaJ10z1dMpEZqFDuPBPwnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pB7BHy/1mgzliqHgPP5zdDFZyAxEvfnPkk+1iMJYVD0=;
 b=ePU1Stb7CoT6mNp8pXrC1EyvLpVtyaX7iA+MnR75ZOT5Aj1A0j5Npr2FFgDOt6TIYvc4to8pWwDasVMV/jJ/HShYtw9BctwQxMe6kQGLreB77tlqJlQUITchFi46lK//VKzVde9bIQONGaHJHhvKv8TDQYsWjjwNPqUXwMMiRqM=
Received: from OSAPR01MB3683.jpnprd01.prod.outlook.com (2603:1096:604:33::12)
 by OSBPR01MB3909.jpnprd01.prod.outlook.com (2603:1096:604:43::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 03:13:46 +0000
Received: from OSAPR01MB3683.jpnprd01.prod.outlook.com
 ([fe80::1d16:3e99:8fb2:84e1]) by OSAPR01MB3683.jpnprd01.prod.outlook.com
 ([fe80::1d16:3e99:8fb2:84e1%7]) with mapi id 15.20.3370.016; Fri, 11 Sep 2020
 03:13:46 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Jason Yan <yanaijie@huawei.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: RE: [PATCH RESEND v3 04/11] usb: xhci-rcar: convert to
 readl_poll_timeout_atomic()
Thread-Topic: [PATCH RESEND v3 04/11] usb: xhci-rcar: convert to
 readl_poll_timeout_atomic()
Thread-Index: AQHWh0vD+aj1y+DFoU+XUmXRM8L6jalh2WYAgADf1oCAAAetsA==
Date:   Fri, 11 Sep 2020 03:13:45 +0000
Message-ID: <OSAPR01MB3683CA015AB25BC00D8459EBD8240@OSAPR01MB3683.jpnprd01.prod.outlook.com>
References: <1599726112-4439-1-git-send-email-chunfeng.yun@mediatek.com>
         <1599726112-4439-4-git-send-email-chunfeng.yun@mediatek.com>
         <20200910131212.wm7zskxvcesl652c@holly.lan>
 <1599791601.24609.5.camel@mhfsdcap03>
In-Reply-To: <1599791601.24609.5.camel@mhfsdcap03>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mediatek.com; dkim=none (message not signed)
 header.d=none;mediatek.com; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [240f:60:5f3e:1:64a2:c8a4:9548:6c30]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b5c3bec9-d82f-4e06-ee6e-08d85600b213
x-ms-traffictypediagnostic: OSBPR01MB3909:
x-microsoft-antispam-prvs: <OSBPR01MB3909BDAA0AF263E1C257D523D8240@OSBPR01MB3909.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iQmtPB4MpgdIuPTj644/T5Aa8n9RqGWthUO+egrWMDqFyPEYdjDIzXJ5CmnFzIXnqDIehSVmcwHwnZ/UJnOOUaYhcsC1Zoh3OYwl7BZxvljLi2azABqZFIR+wf471ix7QwluDEa2yw7AvzhHCdF8ZJrhmlem2fUwr2l7Ng4IAfTaoVcMDFsO6E2Xtk5A/gZLLO+qM7WAAEWSHlPfFDU4ce0nNA7n422/8ZmTW6Xh9qLKvSUfu5IWF1IyRZM/4hbbUJ7I3+UmDBiVre5I3bvHo+eXMa/urtE+PhVW+FaSYG27Vnlujjje7dlzxhWeMR8A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB3683.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(83380400001)(33656002)(55016002)(7416002)(66476007)(66946007)(66556008)(9686003)(66446008)(76116006)(2906002)(52536014)(110136005)(5660300002)(64756008)(186003)(8936002)(478600001)(7696005)(54906003)(71200400001)(316002)(6506007)(86362001)(8676002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: pqO1nR90lakh8RPa4QNTRUt9e4uMdRw1dAxBhc3ETQSadNGPrpRUA9sJwgjqaBWXQOUYUpgdDFxwlGaCH4pLPSc1DRgI33TGAY0Ep6hCUqzzfG/IZkiHWNmMabIeIxWPYree8NK9mI/CmNHV8awCGmkLdue5MBLh2OImeqbMLAqOxnmi+6PnkvMpfAo84iXEgyzENTzHKISAya7j7MvJ/sv1qlHnAr1V1iPrJuzq++lnOR/2cgGleCBwVplP0OJs/tawE/8Ihj1scQ1vkbKA3ZWb9AoRt6JpxynspnhjHfzoVKOzk6MeShVhSw53rmmXNceKB7XLGxC6imBFb8vdTL4o571/4A8N3DwhPXGcx3zgpzszNxnEVwH52O2u8HG2vNZi/UO4L8PeToY2KCxmlYFM/RJky3fV1hDs/THBHBoflE4yxUh0Ro/tLDKI55J2O8yKpCnxCUTAA2Fmnyye66j1GuKrYdWqDooNwqpyUsn+HcwC7HlRRvDgMnHxX+7Ur3uZwIpQ8jfQe41TAOZCRM+/Pm0y2iq1aPr+hkq5hC2tp0e3I++d3mj26uzrRL4+ve4Ibms/ZDGVhiEfxrf6AEV9wYmMYtKgMV5D6Bg8ur6bgILxsLox8lny4g70M8/klPCOF5GJ4mBCBhg7O3dL03U0fhjShu9QhvqrqKBFgnIPeiaqn6hKXDE/1d11JqyLw9BONnv9ztDzd11GiczCUA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB3683.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c3bec9-d82f-4e06-ee6e-08d85600b213
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2020 03:13:45.8765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kE6QozU8ALAbpJc0k13TgQ90iqcDyssW8SKmuRtCcYhbAs3c0VqAni3BY0I+Osz96WceEho26kKlZ54ZUnvrGSsl7n813aZA3GAnYgGHJO580dAU37HFm/xmrt+z4Hec
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3909
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGFuaWVsLCBDaHVuZmVuZywNCg0KPiBGcm9tOiBDaHVuZmVuZyBZdW4sIFNlbnQ6IEZyaWRh
eSwgU2VwdGVtYmVyIDExLCAyMDIwIDExOjMzIEFNDQo+IA0KPiBPbiBUaHUsIDIwMjAtMDktMTAg
YXQgMTQ6MTIgKzAxMDAsIERhbmllbCBUaG9tcHNvbiB3cm90ZToNCj4gPiBPbiBUaHUsIFNlcCAx
MCwgMjAyMCBhdCAwNDoyMTo0NVBNICswODAwLCBDaHVuZmVuZyBZdW4gd3JvdGU6DQo+ID4gPiBV
c2UgcmVhZGxfcG9sbF90aW1lb3V0X2F0b21pYygpIHRvIHNpbXBsaWZ5IGNvZGUNCj4gPiA+DQo+
ID4gPiBDYzogTWF0aGlhcyBOeW1hbiA8bWF0aGlhcy5ueW1hbkBsaW51eC5pbnRlbC5jb20+DQo+
ID4gPiBDYzogWW9zaGloaXJvIFNoaW1vZGEgPHlvc2hpaGlyby5zaGltb2RhLnVoQHJlbmVzYXMu
Y29tPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVk
aWF0ZWsuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiB2Mn52Mzogbm8gY2hhbmdlcw0KPiA+ID4gLS0t
DQo+ID4gPiAgZHJpdmVycy91c2IvaG9zdC94aGNpLXJjYXIuYyB8IDQzICsrKysrKysrKysrKy0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTIg
aW5zZXJ0aW9ucygrKSwgMzEgZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdXNiL2hvc3QveGhjaS1yY2FyLmMgYi9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktcmNh
ci5jDQo+ID4gPiBpbmRleCBjMTAyNWQzLi43NGY4MzZmIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJp
dmVycy91c2IvaG9zdC94aGNpLXJjYXIuYw0KPiA+ID4gKysrIGIvZHJpdmVycy91c2IvaG9zdC94
aGNpLXJjYXIuYw0KPiA+ID4gQEAgLTYsNiArNiw3IEBADQo+ID4gPiAgICovDQo+ID4gPg0KPiA+
ID4gICNpbmNsdWRlIDxsaW51eC9maXJtd2FyZS5oPg0KPiA+ID4gKyNpbmNsdWRlIDxsaW51eC9p
b3BvbGwuaD4NCj4gPiA+ICAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+ID4gPiAgI2luY2x1
ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KPiA+ID4gICNpbmNsdWRlIDxsaW51eC9vZi5o
Pg0KPiA+ID4gQEAgLTEyNyw4ICsxMjgsNyBAQCBzdGF0aWMgaW50IHhoY2lfcmNhcl9kb3dubG9h
ZF9maXJtd2FyZShzdHJ1Y3QgdXNiX2hjZCAqaGNkKQ0KPiA+ID4gIAl2b2lkIF9faW9tZW0gKnJl
Z3MgPSBoY2QtPnJlZ3M7DQo+ID4gPiAgCXN0cnVjdCB4aGNpX3BsYXRfcHJpdiAqcHJpdiA9IGhj
ZF90b194aGNpX3ByaXYoaGNkKTsNCj4gPiA+ICAJY29uc3Qgc3RydWN0IGZpcm13YXJlICpmdzsN
Cj4gPiA+IC0JaW50IHJldHZhbCwgaW5kZXgsIGosIHRpbWU7DQo+ID4gPiAtCWludCB0aW1lb3V0
ID0gMTAwMDA7DQo+ID4gPiArCWludCByZXR2YWwsIGluZGV4LCBqOw0KPiA+ID4gIAl1MzIgZGF0
YSwgdmFsLCB0ZW1wOw0KPiA+ID4gIAl1MzIgcXVpcmtzID0gMDsNCj4gPiA+ICAJY29uc3Qgc3Ry
dWN0IHNvY19kZXZpY2VfYXR0cmlidXRlICphdHRyOw0KPiA+ID4gQEAgLTE2NiwzMiArMTY2LDE5
IEBAIHN0YXRpYyBpbnQgeGhjaV9yY2FyX2Rvd25sb2FkX2Zpcm13YXJlKHN0cnVjdCB1c2JfaGNk
ICpoY2QpDQo+ID4gPiAgCQl0ZW1wIHw9IFJDQVJfVVNCM19ETF9DVFJMX0ZXX1NFVF9EQVRBMDsN
Cj4gPiA+ICAJCXdyaXRlbCh0ZW1wLCByZWdzICsgUkNBUl9VU0IzX0RMX0NUUkwpOw0KPiA+ID4N
Cj4gPiA+IC0JCWZvciAodGltZSA9IDA7IHRpbWUgPCB0aW1lb3V0OyB0aW1lKyspIHsNCj4gPiA+
IC0JCQl2YWwgPSByZWFkbChyZWdzICsgUkNBUl9VU0IzX0RMX0NUUkwpOw0KPiA+ID4gLQkJCWlm
ICgodmFsICYgUkNBUl9VU0IzX0RMX0NUUkxfRldfU0VUX0RBVEEwKSA9PSAwKQ0KPiA+ID4gLQkJ
CQlicmVhazsNCj4gPiA+IC0JCQl1ZGVsYXkoMSk7DQo+ID4gPiAtCQl9DQo+ID4gPiAtCQlpZiAo
dGltZSA9PSB0aW1lb3V0KSB7DQo+ID4gPiAtCQkJcmV0dmFsID0gLUVUSU1FRE9VVDsNCj4gPiA+
ICsJCXJldHZhbCA9IHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMocmVncyArIFJDQVJfVVNCM19E
TF9DVFJMLA0KPiA+ID4gKwkJCQl2YWwsICEodmFsICYgUkNBUl9VU0IzX0RMX0NUUkxfRldfU0VU
X0RBVEEwKSwNCj4gPiA+ICsJCQkJMSwgMTAwMDApOw0KPiA+ID4gKwkJaWYgKHJldHZhbCA8IDAp
DQo+ID4gPiAgCQkJYnJlYWs7DQo+ID4gPiAtCQl9DQo+ID4gPiAgCX0NCj4gPiA+DQo+ID4gPiAg
CXRlbXAgPSByZWFkbChyZWdzICsgUkNBUl9VU0IzX0RMX0NUUkwpOw0KPiA+ID4gIAl0ZW1wICY9
IH5SQ0FSX1VTQjNfRExfQ1RSTF9FTkFCTEU7DQo+ID4gPiAgCXdyaXRlbCh0ZW1wLCByZWdzICsg
UkNBUl9VU0IzX0RMX0NUUkwpOw0KPiA+ID4NCj4gPiA+IC0JZm9yICh0aW1lID0gMDsgdGltZSA8
IHRpbWVvdXQ7IHRpbWUrKykgew0KPiA+ID4gLQkJdmFsID0gcmVhZGwocmVncyArIFJDQVJfVVNC
M19ETF9DVFJMKTsNCj4gPiA+IC0JCWlmICh2YWwgJiBSQ0FSX1VTQjNfRExfQ1RSTF9GV19TVUND
RVNTKSB7DQo+ID4gPiAtCQkJcmV0dmFsID0gMDsNCj4gPiA+IC0JCQlicmVhazsNCj4gPiA+IC0J
CX0NCj4gPiA+IC0JCXVkZWxheSgxKTsNCj4gPiA+IC0JfQ0KPiA+ID4gLQlpZiAodGltZSA9PSB0
aW1lb3V0KQ0KPiA+ID4gLQkJcmV0dmFsID0gLUVUSU1FRE9VVDsNCj4gPiA+ICsJcmV0dmFsID0g
cmVhZGxfcG9sbF90aW1lb3V0X2F0b21pYygocmVncyArIFJDQVJfVVNCM19ETF9DVFJMKSwNCj4g
PiA+ICsJCQl2YWwsICh2YWwgJiBSQ0FSX1VTQjNfRExfQ1RSTF9GV19TVUNDRVNTKSwgMSwgMTAw
MDApOw0KPiA+DQo+ID4gRGlyZWN0bHkgYXNzaWduaW5nIHRvIHJldHZhbCBhdCB0aGlzIHBvaW50
IHdpbGwgY2xvYmJlciBhIHByZXZpb3VzDQo+ID4gLUVUSU1FRE9VVCBlcnJvci4NCj4gPg0KPiA+
IEluIG90aGVyIHdvcmRzIGlmIHRoZXJlIGlzIGEgdGltZW91dCB3YWl0aW5nIGZvciBGV19TRVRf
REFUQTAsIGJ1dCBub3QgZm9yDQo+ID4gRFdfU1VDQ0VTUywgdGhlbiB3ZSB3aWxsIHJldHVybiB0
aGUgd3JvbmcgcmV0dXJuIHZhbHVlLg0KDQpUaGFuayB5b3UgZm9yIHlvdXIgY29tbWVudCEgSSBk
aWRuJ3QgcmVhbGl6ZWQgdGhpcy4NCg0KPiBZZXMsIGFncmVlIHdpdGggeW91LCBidXQgc2VlbXMg
SSBrZWVwIGl0cyBvcmlnaW5hbCBsb2dpYyB1bmNoYW5nZWQuDQo+IEhpIFlvc2hpaGlybywNCj4g
DQo+ICAgV2hhdCBkbyB0aGluayBhYm91dCBEYW5pZWwncyBzdWdnZXN0aW9uPyBzaG91bGQgSSBm
aXggaXQgdXA/DQoNCkkgdGhpbmsgeW91IHNob3VsZCBmaXggaXQgdXAgbGlrZSBiZWxvdzoNCg0K
aWYgKHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMocmVncyArIFJDQVJfVVNCM19ETF9DVFJMLA0K
CQl2YWwsIHZhbCAmIFJDQVJfVVNCM19ETF9DVFJMX0ZXX1NVQ0NFU1MsIDEsIDEwMDAwKSA8IDAp
DQoJcmV0dmFsID0gLUVUSU1FT1VUOwkvKiBPdmVyd3JpdGUgcmV0dmFsIGlmIHRpbWVvdXQgb2Nj
dXJyZWQgKi8NCg0KT3RoZXJ3aXNlLCB0aGUgeGhjaV9yY2FyX2Rvd25sb2FkX2Zpcm13YXJlKCkg
Y2Fubm90IHJldHVybiAtRVRJTUVET1VUIGlmDQp0aW1lb3V0IGhhcHBlbmVkIG9uIHRoZSBwcmV2
aW91cyBwb2xsIFsxXS4NCg0KWzFdDQorCQlyZXR2YWwgPSByZWFkbF9wb2xsX3RpbWVvdXRfYXRv
bWljKHJlZ3MgKyBSQ0FSX1VTQjNfRExfQ1RSTCwNCisJCQkJdmFsLCAhKHZhbCAmIFJDQVJfVVNC
M19ETF9DVFJMX0ZXX1NFVF9EQVRBMCksDQorCQkJCTEsIDEwMDAwKTsNCg0KQmVzdCByZWdhcmRz
LA0KWW9zaGloaXJvIFNoaW1vZGENCg0K
