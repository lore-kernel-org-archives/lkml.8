Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41342C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 15:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E8AA207DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 15:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=infinera.com header.i=@infinera.com header.b="LvJl3xPo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgGIP2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 11:28:43 -0400
Received: from mail-eopbgr770073.outbound.protection.outlook.com ([40.107.77.73]:45155
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726410AbgGIP2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 11:28:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FL8hzGrhUXQ5297AG2ciJqviYnLm8Wjn/fglcYqXbDPIL4VUJq+zmyMQfaC2KGfl96v7V9t+LLKmhhPb+uED/GFmctSsAsW1jO96lnXPCb02O7LXNx7v/k18F6oaDiCJ0BZ7Z9MWqQovOVEQNAUOTn/C6wD27c3g7j1jLJ+OwHtNk9SHN3rQiIqdvYcLWGJd7CEUnwVdzYvEm4kZsyZD5mpmItvIQru0AVka6ovJ0ZjJZBCoj9Z50o63B8qs5RFF72teWEQ+HJyj4p/TMN6opRuh6c0EZy0T2yISRJHuIbjpx3XInzmbkrgIFHRrsyETZl9CHcYC/EW4NTS0bdmc1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yajIr5CaCUuaCP7meqfkYUekX2ELDt7dw+/4AjTu1Fk=;
 b=UzCmZ8hkRTOum2+UDzm2jWjUrn/hL+NhEbEpMezONLOLD2AAaudjyaneUUssKPthl9O+CyCq5jVP2z/VPnjPMgctXnXyhnu0vALzbQOTtps/+HbpmaeDz/nWnJiBLOW7z9K1UCfz9/Qn6frNoVyl33S4rau0PzldptCy1ftpfGuaLUcUHHZ5Ni1n7IlAO/mWrSMiZW+H8pKl6yl5yv4MrIh887sh5VvTLRwwYxc+rfiHCGhhzy3PUpRTJkfEN6Q61l1jrbCp9yMH73baBALw9R6LdoEUksMskBJCrxXfNsNGw/n1zt/qQTtdB6mal6CuBvdgNpz60B84GfskLwPbnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yajIr5CaCUuaCP7meqfkYUekX2ELDt7dw+/4AjTu1Fk=;
 b=LvJl3xPoObHM7OVEZ73WUz/x+U7pE2BPBa9ApHL2ktxI9C+auaMDKpWuwPk1zgIopFkg6aipHDl+CZEqqYbgDN8t7AOvI6wH5tr4sN/zl/hvrPAbUljWuvbyILIjKUoJe9JlN+q/SG7Oh6r4APswAtjJfYXLq6a7N1BSg8p+mww=
Received: from MWHPR1001MB2190.namprd10.prod.outlook.com
 (2603:10b6:301:2e::20) by MWHPR1001MB2269.namprd10.prod.outlook.com
 (2603:10b6:301:2d::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Thu, 9 Jul
 2020 15:28:41 +0000
Received: from MWHPR1001MB2190.namprd10.prod.outlook.com
 ([fe80::b439:ba0:98d6:c2d1]) by MWHPR1001MB2190.namprd10.prod.outlook.com
 ([fe80::b439:ba0:98d6:c2d1%5]) with mapi id 15.20.3174.021; Thu, 9 Jul 2020
 15:28:41 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>,
        "schwab@linux-m68k.org" <schwab@linux-m68k.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: printk of non NULL terminated strings ?
Thread-Topic: printk of non NULL terminated strings ?
Thread-Index: AQHWVezV9c8qp7AVfk6iUQJ/gxZBLaj/NP1GgAAIToCAAAEegIAAIPsA
Date:   Thu, 9 Jul 2020 15:28:41 +0000
Message-ID: <450b6c9326cf28c9377b2b2be125e1d93be0fb31.camel@infinera.com>
References: <4436dd281299b46f431ad1707c5de42af45ea4f7.camel@infinera.com>
         <87h7ugu9rk.fsf@igel.home>
         <0a4fb48c210c867139f4b171384b8d53a420ff7d.camel@infinera.com>
         <4d081ee7-5527-f821-5e9e-87ff053f7d2d@prevas.dk>
In-Reply-To: <4d081ee7-5527-f821-5e9e-87ff053f7d2d@prevas.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.37.3 
authentication-results: prevas.dk; dkim=none (message not signed)
 header.d=none;prevas.dk; dmarc=none action=none header.from=infinera.com;
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99cd7245-2ffd-470e-a3b6-08d8241cc267
x-ms-traffictypediagnostic: MWHPR1001MB2269:
x-microsoft-antispam-prvs: <MWHPR1001MB2269291C5FD88437D0371138F4640@MWHPR1001MB2269.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hw/V0nQg1zBd/CiAjfszevDioS+/sRUwsXAqkMoDKcLlvATnHWeW5pqrkAaFGZ6ErQ3BZOri9DKeWN68mdUC9Wle1WJ7bBB9kj7AM2aqxrHd1KLSWmSze46wExktD66QqB1NpRTB86ZmUI9a6gVC70FJR0xukerfWUg2nzHF/UgdjCaI6FOuT8+u/E90vniY7cU1WMLv+IKVD4tn28mDy1p6o/9NRZlcRbVFHTG2CfpslHG155/oD9RQ6G7rPkAXwXIR5I8Hy3cOb6kTucTvI06H6b95C7F5H5xa0ogbQERhWaFSrN5WO08Bauv+KKjWjMUC/Nm3U3b3VQlIT3HsKQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2190.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(6506007)(6486002)(66556008)(2616005)(6512007)(91956017)(76116006)(5660300002)(26005)(4326008)(186003)(66946007)(64756008)(36756003)(66446008)(71200400001)(4744005)(2906002)(110136005)(478600001)(8936002)(316002)(8676002)(86362001)(83380400001)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: z1yYJOjQ7HZxisrhdQc3lXWvPOapYi8SeGdW8t82OVHxPnHoH+DCY43g3aUkXAgm9N1XSz5xn3diWfEfmh0U7LEhMy0tWAwUhnmZFhB62wf4wqo3sreSJa/E9l8epDfjpaOvTaXJREikvH8OeNscStCBOJDIVENn5e62HQ/JB9nEOZzACP9KRbttsAuRUlwByErydon/YqCEugbM2RJd46NMlU8g3mXnc4LY28lktwGd+qxINIkW7ve04w2y6SqJFrhkMCpn6t/xN4e3/V5X8EHPw8/B5mTonVWwGnjSbDiSb8j1H6sIGPif2xfoDv6m9yniHL6SnkU8dpzGj1ZM55RjitBX1FYs6FTRIlJXLTs7DYh3z7NFUJzlGpFxsUgsFD6eLbfdW2IxUmORFT2VRMIw0GOj4VcsR34k2bvOa5sQuH4p/HeQLraiR2k9Z2uxljJB/hGSkZooq5DaXq8i+pyKI6Cd2PMQI6fSNo6KECg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <87BD8591B71FC34D9C93B5BF52271F9A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2190.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99cd7245-2ffd-470e-a3b6-08d8241cc267
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2020 15:28:41.0522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Jw8RlZ+Wz+WFh2rNx0t/gnlGntm99Obc7/k7etffGsKNa30Iz6V0cMa9hREa0OgBgo5Ikl0kX1K30wD3lQUxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2269
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTA3LTA5IGF0IDE1OjMwICswMjAwLCBSYXNtdXMgVmlsbGVtb2VzIHdyb3Rl
Og0KPiBPbiAwOS8wNy8yMDIwIDE1LjI2LCBKb2FraW0gVGplcm5sdW5kIHdyb3RlOg0KPiA+IE9u
IFRodSwgMjAyMC0wNy0wOSBhdCAxNDo1NiArMDIwMCwgQW5kcmVhcyBTY2h3YWIgd3JvdGU6DQo+
ID4gPiBDQVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBv
cmdhbml6YXRpb24uIERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVz
cyB5b3UgcmVjb2duaXplIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4N
Cj4gPiA+IA0KPiA+ID4gDQo+ID4gPiBPbiBKdWwgMDkgMjAyMCwgSm9ha2ltIFRqZXJubHVuZCB3
cm90ZToNCj4gPiA+IA0KPiA+ID4gPiBJcyB0aGVyZSBhIGZvcm1hdCAob3Igb3RoZXIgZnVuY3Rp
b24pIHRoYXQgbGV0cyBtZQ0KPiA+ID4gPiBwcmludCBzdHJpbmdzIHdpdGhvdXQgYW4gXDAgdGVy
bWluYXRvciB1c2luZyBhbiBleHBsaWNpdCBsZW5ndGggYXJnIGluc3RlYWQ/DQo+ID4gPiANCj4g
PiA+IFVzZSB0aGUgcHJlY2lzaW9uLg0KPiA+IA0KPiA+IExvb2tpbmcgYXQgdGhhdCBub3cgYnV0
IGhhdmUgYSBoYXJkIHRpbWUgZmlndXJpbmcgaG93IHRvIHVzZSBpdCwgY2FuIHlvdSBnaXZlIG1l
IGFuIGV4YW1wbGU/DQo+IA0KPiBFeGFjdGx5IGFzIHlvdSdkIGRvIGluIHVzZXJzcGFjZToNCj4g
DQo+IMKgwqBwcmludGYoIiUuKnNcbiIsIGxlbiwgYnVmKQ0KPiANCj4gT2YgY291cnNlLCB2c25w
cmludGYoKSB3aWxsIHN0aWxsIHN0b3AgaWYgaXQgZW5jb3VudGVycyBhIG51bCBieXRlDQo+IHdp
dGhpbiB0aG9zZSBmaXJzdCBsZW4gYnl0ZXMgaW4gYnVmLiBBbmQgeW91IG5lZWQgbGVuIHRvIGhh
dmUgdHlwZSBpbnQsDQo+IHNvIHlvdSBtYXkgbmVlZCBhIGNhc3QgaWYgeW91IGhhdmUgYSBzaXpl
X3Qgb3Igc3NpemVfdCBvciB3aGF0bm90Lg0KDQpUaGFua3MsIHRoaXMgZGlkIHRoZSB0cmljayA6
KQ0K
