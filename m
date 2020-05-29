Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352EFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 06:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F10852072D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 06:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=necglobal.onmicrosoft.com header.i=@necglobal.onmicrosoft.com header.b="jgzTfJ7x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbgE2Gn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 02:43:59 -0400
Received: from mail-eopbgr1320059.outbound.protection.outlook.com ([40.107.132.59]:60000
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725308AbgE2Gn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 02:43:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPzn7ZWDSttxXNXr9KNK76n3EzTJZ+BXrdkXwcv3dGsm4sy2WRy/EeAzwbUbgcFMz7IrQLvt1139NAteTbRgIkoqoQZZFEX19wVpJpUzVKp9+n3rNdm1PYWw5RN1WXPvHV+uZjdC89DeQqDICmInYJ1R+vM2dAbFr2QNaq01AboYmJLLAlwKAbXBQ/NPdOOLT6r3dLWVqv8LN025LO/7sNvxLNT+Rb8kR10mAf0t+uAVQZEH1ESicgh31zILDB3EhnLiL59vL7WVqZmTPTOfzgjfybyz8RaQwPJ67Jq3up9g2c1Z2UpdqlSel/pW9/u6UIYpsrm2Qs0//Qe8HVOCDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9DL+dpkb5LvRT2Fh+9/RE0wLEb+tXLV1f0k4VwcvF4=;
 b=GGdf3407pw9GHjFRESAP3B6cNuXnit0c4D+tx7BFdBijd0axNZV0brfTZgq7oF9/pIWz3FPz6+fUNGOiAHNWb4At6V468VGtmKSfEJVidPzywhYCx8FN0f3AM7dffoqG2iXbZiirOrCHyhfjNQl6EyBB6dOS1siKvllDzajIKGoP0Sax/yWvAxzLEyZUC6wFVmsOV7MrTlp167l8pdt33Szn8YN3BDHULR7sMDN4d8kN4nfZt8vcymEbKMrY9q+170dsqQeFWUlpp78qMWiiRYynQZLaj8VCg9YCoSMe08vq/z6NZNNeSsGh8WQv9h2kpk7m+HJrJ1xsfeTdlIn3cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9DL+dpkb5LvRT2Fh+9/RE0wLEb+tXLV1f0k4VwcvF4=;
 b=jgzTfJ7xlQXTck4cywLXoupxkxuKTPuGLSxOagjMwlvA0omrOkdcar49jViN7dQqqH1LEm2Nmsj4Jo5vEhUQ/Lla5Ig+Xxfv/8LDpi/qrLNe5t9hF+VRjjGtUAxJnIcv8rcJO3qfgHBuwM/cwn/f27z6lY2EPjjxYEre54T8kYk=
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com (2603:1096:404:74::14)
 by TY2PR01MB2364.jpnprd01.prod.outlook.com (2603:1096:404:76::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Fri, 29 May
 2020 06:43:54 +0000
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::3841:ec9f:5cdf:f58]) by TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::3841:ec9f:5cdf:f58%5]) with mapi id 15.20.3021.030; Fri, 29 May 2020
 06:43:54 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     wetp <wetp.zy@linux.alibaba.com>
CC:     "n-horiguchi@ah.jp.nec.com" <n-horiguchi@ah.jp.nec.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm, memory_failure: only send BUS_MCEERR_AO to early-kill
 process
Thread-Topic: [PATCH] mm, memory_failure: only send BUS_MCEERR_AO to
 early-kill process
Thread-Index: AQHWMyxBK5FsG+fd5ka/mAnJKqbKvKi8x2GAgABKu4CAAUS6AIAAPpeAgAANQ4A=
Date:   Fri, 29 May 2020 06:43:53 +0000
Message-ID: <20200529064353.GA14362@hori.linux.bs1.fc.nec.co.jp>
References: <1590476801-19882-1-git-send-email-wetp.zy@linux.alibaba.com>
 <20200528022241.GA1401@hori.linux.bs1.fc.nec.co.jp>
 <881b990a-2198-8e80-036e-bfa6f88070ff@linux.alibaba.com>
 <20200529021224.GA345@hori.linux.bs1.fc.nec.co.jp>
 <e4da056c-8d6c-9687-0785-b1900cb7c3e2@linux.alibaba.com>
In-Reply-To: <e4da056c-8d6c-9687-0785-b1900cb7c3e2@linux.alibaba.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 160b8d05-2b22-4f12-e585-08d8039ba7a0
x-ms-traffictypediagnostic: TY2PR01MB2364:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB23649AB1766A4503A1358DFDE78F0@TY2PR01MB2364.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04180B6720
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vWFHZQd/0zw9dpuhJaYqwA//+ZmQvYQdYDez/P63yyIBOsoO9yI7R1rifb3oif7c35IOk8rg4ZQ3Xl+Z3dEoBbbQoG6pwHefEayUrdTzAl4RCgvuHehakXgZyJ297RFuZTDCDSQR0k3yNnZfj+vFqoRQBJscGzdxEuvYO2RG/h1w6HlIIk6weVHdzl7GGbPkHBjGKmMd5oZAdu6omvwX9bYsAgubTZMuLQ8UFwrfZR+qFs1bQEOVxKrY5E3J5eJiHN/Fu4YVrpGk79lMAND3hAWXWhh+TVDlg0vFa65VILOIy3VydqdiK5IKXljZH40xBU+mmaxf5sI4lNO2jL+oGA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3210.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(76116006)(33656002)(6916009)(66946007)(64756008)(66556008)(86362001)(54906003)(66446008)(66476007)(71200400001)(4326008)(5660300002)(55236004)(1076003)(6512007)(6506007)(9686003)(26005)(478600001)(8936002)(85182001)(316002)(83380400001)(2906002)(6486002)(186003)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 91bdlD9s/qhyUajLX+Z8//+xDSk5i4PkXOf+CxmrwgIQ89PLHen7AzmPM2NNUaRkBaVIbD3iZNeO9iSDb477Ji8nkvLrymDL1EhebWviO4Lu6T5dHaP4v844UCLMI6kRHlR9DdbVwFeCypH2CxmUfkAH44ACBzV6PrHWwjqUzacmPFazZmCu6rI7ieg7bopojAMXWuMds2h91duzDmzFVTzTcNqFKm85ksAf9oREqyEITZlE1VQoLOHRIPY9hoLtti6XaipOo8PVbpM3ZqItbX1vsWQ7F/5Q4v26/TCb2pI/z42Zfwi1Vm2jZ1xZnT+6JUIJp2LAh6qdV07qHz87guajPXO+FlugdTmHFjWu8iYJmq9dia+lMq4BhnCgbDyXL58oNMowk0L6XYujutSS2zz11PKiLhfPZeGwoGsPWoiSfIEFvq/v5D9L5de50zekeGGdKUe/KZMIC1ixp8+Hnvng36sUEDODjFXYvNRRofI/Z+WWl45fNieucaBmNbT7
Content-Type: text/plain; charset="utf-8"
Content-ID: <96C40F5D595F3D49A9A36B0F1512D16E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 160b8d05-2b22-4f12-e585-08d8039ba7a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2020 06:43:53.9489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7pIHj/2JseWwGd+bmO1CuOoEVf3xqNMEjlFtYi3p/92zHKHwXzS+EnfcIii9BKc1bWucsBz5TfnxXtg6Vvn3zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2364
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBNYXkgMjksIDIwMjAgYXQgMDE6NTY6MjVQTSArMDgwMCwgd2V0cCB3cm90ZToNCj4g
T24gMjAyMC81LzI5IOS4iuWNiDEwOjEyLCBIT1JJR1VDSEkgTkFPWUEo5aCA5Y+jIOebtOS5nykg
d3JvdGU6DQouLi4NCj4gPiA+ID4gPiBAQCAtMjI1LDggKzIyNSw5IEBAIHN0YXRpYyBpbnQga2ls
bF9wcm9jKHN0cnVjdCB0b19raWxsICp0aywgdW5zaWduZWQgbG9uZyBwZm4sIGludCBmbGFncykN
Cj4gPiA+ID4gPiAgICAJCSAqIFRoaXMgY291bGQgY2F1c2UgYSBsb29wIHdoZW4gdGhlIHVzZXIg
c2V0cyBTSUdCVVMNCj4gPiA+ID4gPiAgICAJCSAqIHRvIFNJR19JR04sIGJ1dCBob3BlZnVsbHkg
bm8gb25lIHdpbGwgZG8gdGhhdD8NCj4gPiA+ID4gPiAgICAJCSAqLw0KPiA+ID4gPiA+IC0JCXJl
dCA9IHNlbmRfc2lnX21jZWVycihCVVNfTUNFRVJSX0FPLCAodm9pZCBfX3VzZXIgKil0ay0+YWRk
ciwNCj4gPiA+ID4gPiAtCQkJCSAgICAgIGFkZHJfbHNiLCB0KTsgIC8qIHN5bmNocm9ub3VzPyAq
Lw0KPiA+ID4gPiA+ICsJCWlmICgodC0+ZmxhZ3MgJiBQRl9NQ0VfUFJPQ0VTUykgJiYgKHQtPmZs
YWdzICYgUEZfTUNFX0VBUkxZKSkNCj4gPiA+ID4gPiArCQkJcmV0ID0gc2VuZF9zaWdfbWNlZXJy
KEJVU19NQ0VFUlJfQU8sDQo+ID4gPiA+ID4gKwkJCQkodm9pZCBfX3VzZXIgKil0ay0+YWRkciwg
YWRkcl9sc2IsIHQpOw0KPiA+ID4gPiBraWxsX3Byb2MoKSBjb3VsZCBiZSBjYWxsZWQgb25seSBm
b3IgcHJvY2Vzc2VzIHRoYXQgYXJlIHNlbGVjdGVkIGJ5DQo+ID4gPiA+IGNvbGxlY3RfcHJvY3Mo
KSB3aXRoIHRhc2tfZWFybHlfa2lsbCgpLiAgU28gSSB0aGluayB0aGF0IHdlIHNob3VsZCBmaXgN
Cj4gPiA+ID4gdGFza19lYXJseV9raWxsKCksIG1heWJlIGJ5IHJlb3JkZXJpbmcgc3lzY3RsX21l
bW9yeV9mYWlsdXJlX2Vhcmx5X2tpbGwNCj4gPiA+ID4gY2hlY2sgYW5kIGZpbmRfZWFybHlfa2ls
bF90aHJlYWQoKSBjaGVjay4NCj4gPiA+ID4gDQo+ID4gPiA+ICAgICAgIHN0YXRpYyBzdHJ1Y3Qg
dGFza19zdHJ1Y3QgKnRhc2tfZWFybHlfa2lsbChzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRzaywNCj4g
PiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlu
dCBmb3JjZV9lYXJseSkNCj4gPiA+ID4gICAgICAgew0KPiA+ID4gPiAgICAgICAgICAgICAgIHN0
cnVjdCB0YXNrX3N0cnVjdCAqdDsNCj4gPiA+ID4gICAgICAgICAgICAgICBpZiAoIXRzay0+bW0p
DQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gTlVMTDsNCj4gPiA+ID4gICAg
ICAgICAgICAgICBpZiAoZm9yY2VfZWFybHkpDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAg
ICByZXR1cm4gdHNrOw0KPiA+ID4gVGhlIGZvcmNlX2Vhcmx5IGlzIHJlbHkgdGhlIGZsYWcgTUZf
QUNUSU9OX1JFUVVJUkVELCBzbyBpdCBpcyBhbHdheXMgdHJ1ZQ0KPiA+ID4gd2hlbiBNQ0Ugb2Nj
dXJzLg0KPiA+ID4gDQo+ID4gPiBUaGlzIGxlYWRzIGFsd2F5cyBzZW5kaW5nIFNJR0JVUyB0byBw
cm9jZXNzZXMgZXZlbiBpZiB0aG9zZSBhcmUgbm90IGN1cnJlbnQNCj4gPiA+IG9yIG5vIGZsYWcg
c2V0dGluZy4NCj4gPiA+IA0KPiA+ID4gIMKgSSB0aGluayBpdCBjb3VsZCBrZWVwIHRoZSBub24t
Y3VycmVudCBwcm9jZXNzZXMgd2hpY2ggaGFzIG5vIGZsYWcgc2V0dGluZw0KPiA+ID4gcnVubmlu
Zy4NCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiBCZXNpZGVzLCBiYXNlIG9uIHlvdXIgcmVjb21tZW5k
YXRpb24gSSByZW9yZGVyIHRoZSBmb3JjZV9lYXJseSBjaGVjayBhbmQNCj4gPiA+IGZpbmRfZWFy
bHlfa2lsbF90aHJlYWQoKQ0KPiA+ID4gDQo+ID4gPiBjaGVjaywgdG8gc2VuZCB0aGUgc2lnbmFs
IHRvIHRoZSByaWdodCB0aHJlYWQuDQo+ID4gU29ycnksIG15IHByZXZpb3VzIGNvbW1lbnQgYXJv
dW5kIHRhc2tfZWFybHlfa2lsbCgpIGlzIGZvciBhIHNlcGFyYXRlIHByb2JsZW0sDQo+ID4gc28g
SSdsbCB0cnkgc29tZSBmaXggb24gdGhpcyBsYXRlci4NCj4gVGhhbmtzLg0KPiANCj4gU2hvdWxk
IG1lIHNlbmQgdGhlIHBhdGNoIFYyIGZvciBteSBwcm9ibGVtIGFsb25lP8KgIE9yIHlvdSB3aWxs
IGZpeCBpdCB3aXRoDQo+IHRhc2tfZWFybHlfa2lsbCgpIHRvZ2V0aGVyIO+8nw0KDQpZb3UgY2Fu
IHNlbmQgdjIgaWYgeW91IGxpa2UuIFBsZWFzZSBub3RlIHRoYXQgcGF0Y2ggZGVzY3JpcHRpb24g
c2hvdWxkIGJlDQpkZXNjcmlwdGl2ZSBlbm91Z2ggZm9yIGZ1dHVyZSByZWZlcmVuY2UuDQpJJ20g
d29ya2luZyBvbiByZWxhdGVkIHRlc3Rpbmcgbm93LiAgSSBndWVzcyB0aGF0IGFjdGlvbiBvcHRp
b25hbCBjYXNlcyBhcmUNCm5vdCB0ZXN0ZWQgd2VsbCBlbm91Z2ggZnJvbSBjdXJyZW50IHByb2Nl
c3MgY29udGV4dCBiZWNhdXNlIHRoZXJlJ3Mgbm8gdXNlZnVsDQppbmplY3Rvci4NCg0KVGhhbmtz
LA0KTmFveWEgSG9yaWd1Y2hp
