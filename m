Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C238C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AD6A20771
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbgGWPMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 11:12:07 -0400
Received: from mx-relay97-hz2.antispameurope.com ([94.100.136.197]:43429 "EHLO
        mx-relay97-hz2.antispameurope.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728282AbgGWPMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 11:12:06 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Jul 2020 11:12:04 EDT
Received: from mail-vi1eur04lp2055.outbound.protection.outlook.com ([104.47.14.55]) by mx-relay97-hz2.antispameurope.com;
 Thu, 23 Jul 2020 17:06:57 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcx7y92FAVKzJU3ckr/byhF2s8LKtlutRWbRCaC75B4MCCekHxMyoH9jBvB6Sgn93w6nwFFFYbZBri0VTD6VW9jrt3QN3WWo+TFt33k9bhZf6UuUiUyq8IN7Xs/j8xV6OZhaUfgI/+ilt2bwW2ELT8jj8VyKCLgK4sH5S/TKACN59FjSFK5e2K0WW7YTnDABXvScJxbM0/e17IHtHXCR86GvRroMg2ylieQegVui3kUwxQ+aawdFRC15UorFWfDveLbMamKcUFvwNHEQf6lKmCNDRO1K8YnYOaXzWeKmQ0g6GurAYfChGP3JEVH9eMOAAcmyxFG1IGp1HeXEtihXBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RP0wNtVqe/lS3agvayp6JMWc6MQ+Ldr8bwtpbRkgXyc=;
 b=etxlEQ7TAXfZESXxkqW5P2g2pR53BBzGF30gkKvyHu4Rk5sw/acqYhhO9DbRWQjt8Y2HGrHZgD0nTPKxMfNExe+dj8SZw+tXkynCOZdpYDqVWz0Ois7UTlFMqgXeikNdCPtzJU90V58SVeprizBSO7rhJ2O6JzmzeiW+WsEERwHyRl69DuEQErPm7l1zaLQX/LN+S4FPOpgkEY2C+EGjLBm3yy3jAjUwN/q6duhuIpjJMP8402RmiE2FOzp6wNO2f4cVd9XiyIp0q7eoGvGpboD4VdP5AvgSYzHtAi1ncFD7fCPh2crQpVsCt9IEnSiWyxWez+UHkpE+6ZLFA8b3mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=connectingmedia.de; dmarc=pass action=none
 header.from=connectingmedia.de; dkim=pass header.d=connectingmedia.de;
 arc=none
Received: from AM4PR0301MB2228.eurprd03.prod.outlook.com (2603:10a6:200:4f::8)
 by AM0PR03MB4002.eurprd03.prod.outlook.com (2603:10a6:208:6c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Thu, 23 Jul
 2020 15:06:51 +0000
Received: from AM4PR0301MB2228.eurprd03.prod.outlook.com
 ([fe80::fd64:b0cc:4337:1b79]) by AM4PR0301MB2228.eurprd03.prod.outlook.com
 ([fe80::fd64:b0cc:4337:1b79%4]) with mapi id 15.20.3216.024; Thu, 23 Jul 2020
 15:06:51 +0000
From:   Yannick Schinko <y.schinko@connectingmedia.de>
To:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Interact with a serial device over USB
Thread-Topic: Interact with a serial device over USB
Thread-Index: AdZg/rxY+g8s1FoAQeiSevPRXCKJqA==
Date:   Thu, 23 Jul 2020 15:06:51 +0000
Message-ID: <AM4PR0301MB22282740FE8D06D8BB573F0583760@AM4PR0301MB2228.eurprd03.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=connectingmedia.de;
x-originating-ip: [130.180.64.186]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 290387d1-436c-4e58-caf9-08d82f1a0774
x-ms-traffictypediagnostic: AM0PR03MB4002:
x-microsoft-antispam-prvs: <AM0PR03MB4002CEE69248D1DC01F4B45283760@AM0PR03MB4002.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KjS41DoWv7FbFZBlx5hRJqtbzixYsrvEPLJLGN3tDnKNAcV04iCaR2vnTothERYC1enX7wwjAdGJPoUKboklX2NyiAplR4u3i+6IqeYa4WVctXcCfdnAGSxdDcnQnjyJrCrAhU7CWxpNCQtI6BQ5JlkN7F1MQWnn4qAobh8v4E+lWZdHbOrWPt+hHTB/td3JtVqnwrtRl2tt20vn4EdcSvwQxf0WlrZlWyEaXHeSveHcW2z1xiTvBJMx87PK1axlyAnMk7qtF/FEjOOSuJKcdknia4py74fSsDqsCHbLWnS9O9AKXW9qLFZUMxpk5NzH33GB6WOQeKijckqk5CcMNNWukAc8EbMLmpqLuiFuNvA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0301MB2228.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(366004)(376002)(396003)(136003)(39830400003)(33656002)(66476007)(8936002)(8676002)(76116006)(64756008)(66556008)(83380400001)(66946007)(66446008)(966005)(71200400001)(6506007)(55016002)(9686003)(450100002)(110136005)(2906002)(7696005)(26005)(508600001)(86362001)(316002)(5660300002)(52536014)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: bRFe2oHErJMNNcl6Wx3+7e4reQ+Bq5Vfhvtv2vsCcuGQI9mXm2q6UPT9xJI5PsK9MQhefqjKomT2Lii0MENhq61ZQCH3suXofo4cPNVmfJO2psxaHx3E3LcvWjIvRifeHlEteMeN5HCnfof4hhVmQaA+rarZe/fwyj5G8nC8qHdPEiYXXT429ZTJL0xK0fzwMpbVWJxU6H7cq0vQ9x8JDPxAmHBg1pKb3SZhcb/hT51GlPMVbg+OR4yN5Jmc9OORpnwwn6g6sgddQm70r7v8y0Pl/OWksDWGKLu5e6bpH6ygOrvhD/HWxT13laDZ35yOnbOE2+pEW+T6kxcm5d0Xv4r/JfufgIFnXnvfgZXHpZCEegbsgLO+agB0WkVLaj2xktKhpExWlpSm8av6RGUDkj4fWlBb6WLVoLYWMS5be7Ur0r9it5pyin11ihlWtP8RYwx6w14K+yqSYgd5gtzmIkj4duc2zcB74rhzd4JhzjMOpI7qqLmzieyBHdKIqeiY
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: connectingmedia.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0301MB2228.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 290387d1-436c-4e58-caf9-08d82f1a0774
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2020 15:06:51.1745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a41db76b-c317-4724-9806-58cf40fa1583
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qYNrV7yUOuqGcuWPZmTdmcE0pywPe8QvlQwxyVJJ8g+ex3hGgi8AGPlpG/FEgElVoHxyTIL2pNy3W4Jo0aj3AjWqsf4x42ElWlXK847nyWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB4002
X-cloud-security-sender: y.schinko@connectingmedia.de
X-cloud-security-recipient: linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: y.schinko@connectingmedia.de
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay97-hz2.antispameurope.com with 53C13CCB334
X-cloud-security-connect: mail-vi1eur04lp2055.outbound.protection.outlook.com[104.47.14.55], TLS=1, IP=104.47.14.55
X-cloud-security: scantime:.6013
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNCnNvIGJlZm9yZSBJIGdldCBpbnRvIGFueSBkZXRhaWwgSSdkIGxpa2UgdG8gbWFr
ZSBjbGVhciB0aGF0IEkgYW0gbm90IGF0IGFsbCBmYW1pbGlhciB3aXRoIHRoZSBMaW51eCBrZXJu
ZWwgaXRzZWxmLiBIb3dldmVyIEknbSBub3QgYW4gaW5leHBlcmllbmNlZCBwcm9ncmFtbWVyLg0K
QWRkaXRpb25hbGx5IHRoZSBkcml2ZXIgSSdtIGRlc2NyaWJpbmcgaGVyZSAoYW5kIHRoYXQgSSB1
bHRpbWF0ZWx5IHBsYW4gdG8gY3JlYXRlKSBpcyBub3QgaW50ZW5kZWQgdG8gbWVyZ2VkIGludG8g
dGhlIGtlcm5lbCBpdHNlbGYuIEl0J3MgbWFkZSBmb3IgYSBzcGVjaWZpYyBwaWVjZSBvZiBoYXJk
d2FyZSB0aGF0IHdpbGwgb25seSBiZSBwcm9kdWNlZCBpbiBtaW5pc2N1bGUgbnVtYmVycy4gSW4g
dHVybiB0aGF0IG1lYW5zIHJlbW92aW5nIGV4aXN0aW5nIG1vZHVsZXMgdG8gcmVwbGFjZSB0aGVt
IHdpdGggbXkgb3duIGlzIGEgcG9zc2liaWxpdHkuDQoNCk5vdywgd2h5IEkgYW0gd3JpdGluZyBo
ZXJlIGluIHRoZSBmaXJzdCBwbGFjZToNCkN1cnJlbnRseSB0aGUgY29tcGFueSBJIHdvcmsgZm9y
IGlzIGRlc2lnbmluZyBhbiBpbmxpbmUgVVBTIGZvciBhIHZlcnkgc3BlY2lmaWMgYm9hcmQgKHRo
ZSBBUFUyIHNlcmllcyBmcm9tIFBDIGVuZ2luZXMpLiBPbiB0aGF0IFVQUyB0aGVyZSdzIGEgbWlj
cm9jb250cm9sbGVyIHRoYXQgY29tbXVuaWNhdGVzIG92ZXIgVVNCIHdpdGggdGhlIGhlbHAgb2Yg
YSBDSDM0MSBjaGlwLg0KSSBoYXZlIGFscmVhZHkgc3VjY2Vzc2Z1bGx5IGltcGxlbWVudGVkIGFu
IHVzZXJsYW5kIHByb2dyYW0gdGhhdCBjb21tdW5pY2F0ZXMgd2l0aCB0aGUgbWljcm9jb250cm9s
bGVyLiBUaGlzIHdvcmtzIGdyZWF0ISBIb3dldmVyIHRoZXJlJ3MgdHdvIGlzc3VlcyB0aGF0IGxl
ZCBtZSB0byB0aGUgY29uY2x1c2lvbiB0aGF0IEkgbmVlZCB0byBpbXBsZW1lbnQgdGhpcyBhcyBh
IGtlcm5lbCBtb2R1bGU6DQotIFN0YXJ0dXAgYW5kIHNodXRkb3duIHRpbWVzL3RpbWluZ3M6IEkg
bm90aWNlZCBlYXJseSBvbiB0aGF0IHRoZSBwcm9ncmFtIHN0YXJ0cyB0b28gbGF0ZSBvbiBib290
IGFuZCBzdG9wcyB0b28gZWFybHkgb24gc2h1dGRvd24sIG5vIG1hdHRlciB3aGF0IEkgZGlkIChl
eGNsdWRpbmcgdmVyeSB2ZXJ5IGRpcnR5IGFuZCBpbXByYWN0aWNhbCBzb2x1dGlvbnMgdGhhdCBz
aG91bGQgbmV2ZXIgYmUgdXNlZCBpbiBhbnkga2luZCBvZiBwcm9kdWN0aW9uIG1hY2hpbmUpIEkg
Y291bGQgbm90IGdldCBpdCB0byBzdGFydCBlYXJseSBlbm91Z2ggYW5kIHN1cnZpdmUgdGhlIHNo
dXQgZG93biBzZXF1ZW5jZSBsb25nIGVub3VnaC4gVGhlIG9ubHkgd2F5IEkgY2FuIHRoaW5rIG9m
IHRvIGNpcmN1bXZlbnQgdGhpcyBpcyBieSB0dXJuaW5nIHRoZSBwcm9ncmFtIGludG8gYSBrZXJu
ZWwgbW9kdWxlIGFzIHRoYXQgd2lsbCBhbGxvdyBpdCB0byBzdGFydCBiZWZvcmUgdGhlIE9TIGFu
ZCB0byBzaHV0ZG93biBhZnRlciB0aGUgT1MsIHdoaWNoIHdvdWxkIGJlIGFjY2VwdGFibGUuDQot
IFByb3ZpZGluZyBzZW5zb3IgZGF0YTogVGhlIG1pY3JvY29udHJvbGxlciBoYXMgdm9sdGFnZSBz
ZW5zb3JzIGFuZCB0ZW1wZXJhdHVyZSBzZW5zb3JzIHRoYXQgSSB3b3VsZCBsaWtlIHRvIG1ha2Ug
YXZhaWxhYmxlIHRvIHVzZXJzcGFjZSB0aHJvdWdoIHRoZSBub3JtYWwgaHdtb24gaW50ZXJmYWNl
cy4gQWNjb3JkaW5nIHRvIG15IHJlc2VhcmNoIHRoYXQgaXMgb25seSBwb3NzaWJsZSB1c2luZyBh
IGtlcm5lbCBtb2R1bGUuIEZ1bm5pbHkgZW5vdWdoIHRoYXQgcGFydCBpcyBhbHJlYWR5IGltcGxl
bWVudGVkIGFuZCB3b3JrcyBwcm92aWRlZCBJIGZlZWQgaXQgbW9ja2VkIGRhdGEuDQoNCkluIGNv
bnNlcXVlbmNlIEkgbmVlZCB0byBjcmVhdGUgYSBrZXJuZWwgbW9kdWxlIChvciBhdCBsZWFzdCBJ
IHRoaW5rIHNvKSB0aGF0IGxpc3RlbnMgdG8gZGF0YSBzZW50IGJ5IHRoZSBtaWNyb2NvbnRyb2xs
ZXIgb3ZlciBVU0IgYW5kIHRoZW4gc2VuZHMgYmFjayBzb21lIG90aGVyIGluZm9ybWF0aW9uIGlu
IHJlc3BvbnNlLg0KQXMgYSBzZWNvbmRhcnkgZnVuY3Rpb25hbGl0eSBpdCB3b3VsZCBiZSBhbWF6
aW5nIGlmIEkgc29tZWhvdyBjb3VsZCBzdGlsbCBmb3J3YXJkIHRoYXQgZGV2aWNlIGFzIGEgdHR5
IChhcyBpdCBjdXJyZW50bHkgaXMpIHNvIEkgY2FuIGZsYXNoIGZpcm13YXJlIHVzaW5nIGF2cmR1
ZGUuIEkgd2FzIHRoaW5raW5nIHRoYXQgYXMgbG9uZyBhcyBub3RoaW5nIGlzIHVzaW5nIHRoYXQg
dHR5IGluIHVzZXJzcGFjZSwgdGhlIGtlcm5lbCBtb2R1bGUgbGlzdGVucyB0byB0aGUgZGV2aWNl
IGFuZCBzZW5kcyByZXNwb25zZXMgYnV0IHN0b3BzIGRvaW5nIHRoYXQgYXMgc29vbiBhcyB0aGUg
dHR5IGlzIGluIHVzZSBhbmQgYWxzbyBjb250aW51ZXMgbGlzdGVuaW5nIGFnYWluIGFzIHNvb24g
YXMgaXQncyBubyBsb25nZXIgaW4gdXNlLiBXaGlsZSB0aGlzIHdvdWxkIGJlIGFtYXppbmcgdG8g
aGF2ZSBpdCdzIG5vdCByZXF1aXJlZCBmb3Igb3VyIHVzZSBjYXNlLg0KDQpJIGhhdmUgbG9va2Vk
IGludG8gdGhlIHNvdXJjZSBjb2RlIGZvciB0aGUgQ0gzNDEgZHJpdmVyIGFuZCBoYXZlIGFsc28g
Y29tZSBhY3Jvc3Mgc2VyZGV2LiBTbyBJJ20gdGhpbmtpbmcgb2YgZXNzZW50aWFsbHkgbW9kaWZ5
aW5nIHRoZSBDSDM0MSBkcml2ZXIgZm9yIG15IHB1cnBvc2VzIG9yIHVzaW5nIHNlcmRldiB0byBh
dHRhY2ggdG8gdGhlIHR0eSB0aGF0J3MgY3JlYXRlZCBieSB0aGUgQ0gzNDEgZHJpdmVyIGl0c2Vs
Zi4NCkhvd2V2ZXIgYm90aCBhcmUgY3VycmVudGx5IGEgZmFpciBiaXQgYmV5b25kIG15IHVuZGVy
c3RhbmRpbmcgYW5kIGZyYW5rbHkgSSBoYXZlIG5vIGlkZWEgaG93IHRvIHByb2NlZWQuDQoNClNv
IGFueW9uZSB3aWxsaW5nIHRvIGhlbHAgbWUgb3V0IGluIHRoaXMgZW5kZWF2b3Igd291bGQgYmUg
Z3JlYXRseSBhcHByZWNpYXRlZCENCg0KTm93IHRoZSBtb2R1bGUgaXMgbGljZW5zZWQgdW5kZXIg
R1BMdjMgKGZyb20gbXkgdW5kZXJzdGFuZGluZyBJJ20gYWxsb3dlZCB0byBkbyB0aGF0IGlmIEkn
bSBtb2RpZnlpbmcgY29kZSBsaWNlbnNlZCB1bmRlciBHUEx2Mi4gSWYgbm90LCBwbGVhc2UgbGV0
IG1lIGtub3cgYW5kIEkgd2lsbCBjaGFuZ2UgaXQgQVNBUCkgYW5kIHRoZSBzb3VyY2UgaXMgYXZh
aWxhYmxlIGF0IGh0dHBzOi8vZ2l0bGFiLmNvbm5lY3RpbmdtZWRpYS5kZS9TZXJ2aWNlQ29ja3Bp
dC9BUFUtVVBTLU1pY3JvQ29udHJvbGxlci8tL3RyZWUvbWFzdGVyL2FwdXN2X3NlbnNvciBpZiB5
b3UgYXJlIGludGVyZXN0ZWQgaW4gaXQuDQoNClNob3VsZCBJIGhhdmUgZm9yZ290dGVuIGFueSBp
bXBvcnRhbnQgZGV0YWlscywgZG9uJ3QgaGVzaXRhdGUgdG8gYXNrLg0KDQpLaW5kIHJlZ2FyZHMs
DQpZYW5uaWNrIFNjaGlua28NCg==
