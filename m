Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CDCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E45EC21655
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="WWXXNE3l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389609AbgE1MEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 08:04:41 -0400
Received: from mail-eopbgr80091.outbound.protection.outlook.com ([40.107.8.91]:39982
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389600AbgE1MEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 08:04:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OywMn7no3ei3ZGvcyEnf8YyG0XDw2oHr8q3e6wIQ+GB6IikX1xN2Tc3pKeInpwswt5gsbGu3/1LUtcI2AQeBT0QJlV6XplCIbPB+uGnWTgrKzDu9hZ540x7SUBhF+gyaibKFyQ3SArqsDIdAnXbphvSPJxBVpPXTerxpwY17Kqk1rIEc6X3S+IWSgSYaDN56IJPBua3JlnM9EEJbBRodOLFiwzeglW9YFqZsHznwRdrVJ5dQFTVdIucT0/dvEns2HMlTdXvxINOv8qLNz2/KOkt52V7cnT+EQ8oacOx8SHd+AyBLjWbkxNpwhdnFU0GSAT2siYgCIylzXb3vK5ajkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qyp80nWGNhTxdOV9Ra19mezZ3fzPGpoOoTrkT5bdT0o=;
 b=VUwmRyIVdODGnRDB7aPcSjjRJa9CLQNcmNhdh3oY2jTa3xreK+mS+4PwAJvf9Dxbrv1w4OvD9KtAhd6xRRVmz8diMAtDZspDBiX0oMoa7j1F0cFrztKArdXVEKMaUo5bOyqlI2RaicTRRGC9+nLstUPqPCrlo6NOvhQcXoP2kJJEUQlPm3l62X7E6R6kyrwYEJWOalnjgURfkGqWNFIuAvFFeKnqHPo2H5wKIUPOQRbGw9b0LGBSvGlWpUt9qn5OMpbgydm0SMJJ9O8wyyc4EStCqdMTy46BBeye5frZ7EFl5p6ilteOZwN5n749QzOhUXep9mCtjbg/+dkA63DVaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qyp80nWGNhTxdOV9Ra19mezZ3fzPGpoOoTrkT5bdT0o=;
 b=WWXXNE3lRxk6pu77uCRXN7+steuJldvQ+tno8ubye0glae9zFuBldlHbiMvc1C1o6rmdAowectoZjtFCuLpFBKKSjHdDVmiFU3w+Jhg379KK+TIHwYtTwIF3BMRPx43tFmP5vLGz/mX/aSGG2hCgsettJJBdF8BWSSfNAqqcVL4=
Received: from AM0P193MB0596.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:169::22)
 by AM0P193MB0627.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:168::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Thu, 28 May
 2020 12:04:32 +0000
Received: from AM0P193MB0596.EURP193.PROD.OUTLOOK.COM
 ([fe80::49f2:e189:1b3a:85c8]) by AM0P193MB0596.EURP193.PROD.OUTLOOK.COM
 ([fe80::49f2:e189:1b3a:85c8%3]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 12:04:32 +0000
From:   "Enderborg, Peter" <Peter.Enderborg@sony.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] debugfs: Add mount restriction option
Thread-Topic: [PATCH] debugfs: Add mount restriction option
Thread-Index: AQHWNMYbZWEseia5ik2nhGfub1cbHai9KjaAgAADHYCAAA2ggIAAK7sA
Date:   Thu, 28 May 2020 12:04:32 +0000
Message-ID: <1611bed3-8c55-3ba0-af59-c75ad8eeedcc@sony.com>
References: <20200528080031.24149-1-peter.enderborg@sony.com>
 <20200528082753.GA2920930@kroah.com>
 <3e1be4dc-01d4-7fc5-1c82-1c792d3fbc11@sony.com>
 <20200528092747.GA3007208@kroah.com>
In-Reply-To: <20200528092747.GA3007208@kroah.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=sony.com;
x-originating-ip: [37.139.156.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 26c9d5db-f332-406c-5eec-08d802ff4855
x-ms-traffictypediagnostic: AM0P193MB0627:
x-microsoft-antispam-prvs: <AM0P193MB06273619012A937E37467B4C868E0@AM0P193MB0627.EURP193.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0417A3FFD2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YWIwpwyeIPzFXiJfEJXXZNteaWD5pV1k/Wm52H6ECqJxsyTCoHNp3rGGS/impxZAYiuwIapXPp8xApYJZvNG2EgoW7zqO2ZamKD/24dIvJ/ffG/WHd1zAEU+/Y3TAM0/R6qlrhXQa8y0yPPB4Cpxm93tndAzkeUgeAtA7ynuu2h8NcOIPsQWOIHe5zYEkN/kslfMkbeh12Vy9iNgRDTTz3pV2qJMdihzDSyTzDz0ZwpWi/tPCL92vNmzkckc/ikSCviDHuKlscEm1DnvAaFwb7VAPDcywDAuM5FXFnxa9ciKTXDVs+eOsQakR7ijY5OLYA0MuKDTDXMJzs8yMBC/H3ydDZ2Uq0qNc/pQHm7SH8dnK4NuHbPoCfqOCNv3o1AG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P193MB0596.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(76116006)(66946007)(66556008)(316002)(66476007)(8936002)(71200400001)(54906003)(4326008)(2616005)(6916009)(6512007)(83380400001)(2906002)(31686004)(6486002)(26005)(8676002)(5660300002)(36756003)(186003)(86362001)(31696002)(66446008)(64756008)(478600001)(53546011)(6506007)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: hU8yHLtqTRRCn4g9nQ3VNvfUVf/qCeVltaPzvNEQu1iggz0P2IXzFgvnYpsrTv/fV9gM24uNYENqyYCoauS21KKYmfwJlFVMGMevQhSMcWaY/zF8FLHUWmmAjlwb+81yoRXv61bc6arcN1hvDY5u8EbUj93qQMragaSKenpXAIvxxmueUcvhpPcfKMy5EvTopIU9p2vS6MSG3yT7fuRYIxSyuXwdbwZrqfYPxzHa3llvHBRnE134v9usDCu7oZlqxSsg/QuR/xdOYQYrg7i9bqlkKTb0KzjCC8eTbHDtRDs6ZN2y9StJIsJYRUTxlh86vbFgZEUQoY4eKABhs7tGooWRUha01Turnstth2rMLSEDavUuCuxvTRQtOG1ycUlE4WXuzKmHMEb4tw8HLjc8hhxqlyjKdkPkgQdvKsxn9q7ot6pfv4Bcn9AQ7Vgxkd/na5IUM6EBv0ZZDekhJ9wJw/8CdO8L/7ygW/GdoB0LS78=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0CDDDC3B66FCBD4ABF4306ACE0544965@EURP193.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26c9d5db-f332-406c-5eec-08d802ff4855
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2020 12:04:32.5997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wVyOUCRczxF8tp4uPpeQHTLKvW2AFcAzY/J0A7q8NjUqr1or5sIXry8pNHV/zHU3Q5bK/+eabcibyTDYEogbOli2TigCd+3PjsS8SJaupXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P193MB0627
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8yOC8yMCAxMToyNyBBTSwgR3JlZyBLcm9haC1IYXJ0bWFuIHdyb3RlOg0KPiBPbiBUaHUs
IE1heSAyOCwgMjAyMCBhdCAwODozOTowMkFNICswMDAwLCBFbmRlcmJvcmcsIFBldGVyIHdyb3Rl
Og0KPj4gT24gNS8yOC8yMCAxMDoyNyBBTSwgR3JlZyBLcm9haC1IYXJ0bWFuIHdyb3RlOg0KPj4+
IE9uIFRodSwgTWF5IDI4LCAyMDIwIGF0IDEwOjAwOjMxQU0gKzAyMDAsIFBldGVyIEVuZGVyYm9y
ZyB3cm90ZToNCj4+Pj4gU2luY2UgZGVidWdmcyBpbmNsdWRlIHNlbnNpdGl2ZSBpbmZvcm1hdGlv
biBpdCBuZWVkIHRvIGJlIHRyZWF0ZWQNCj4+Pj4gY2FyZWZ1bGx5LiBCdXQgaXQgYWxzbyBoYXMg
bWFueSB2ZXJ5IHVzZWZ1bCBkZWJ1ZyBmdW5jdGlvbnMgZm9yIHVzZXJzcGFjZS4NCj4+Pj4gV2l0
aCB0aGlzIG9wdGlvbiB3ZSBjYW4gaGF2ZSBzYW1lIGNvbmZpZ3VyYXRpb24gZm9yIHN5c3RlbSB3
aXRoDQo+Pj4+IG5lZWQgb2YgZGVidWdmcyBhbmQgYSB3YXkgdG8gdHVybiBpdCBvZmYuIEl0IGlz
IG5lZWRlZCBuZXcNCj4+Pj4ga2VybmVsIGNvbW1hbmQgbGluZSBwYXJhbWV0ZXIgdG8gYmUgYWN0
aXZhdGVkLg0KPj4+IEJ5ICJjb25maWd1cmF0aW9uIiBkbyB5b3UgbWVhbiAia2VybmVsIGNvbmZp
Z3VyYXRpb24iPyAgV2hhdCBpcyB3cm9uZw0KPj4+IHdpdGggcmVseWluZyBvbiB0aGUgYnVpbGQg
b3B0aW9uIGxpa2Ugd2UgZG8gdG9kYXk/DQo+Pj4NCj4+PiBZb3UgbWlnaHQgd2FudCB0byByZXdv
cmQgYWxsIG9mIHRoaXMgdG8gbWFrZSBtb3JlIHNlbnNlIGFib3V0IHRoZQ0KPj4+ICJwcm9ibGVt
IiB5b3UgYXJlIHRyeWluZyB0byBzb2x2ZSBoZXJlLCBhcyBJIGRvbid0IHJlYWxseSB1bmRlcnN0
YW5kIGl0LA0KPj4+IHNvcnJ5Lg0KPj4+DQo+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogUGV0ZXIg
RW5kZXJib3JnIDxwZXRlci5lbmRlcmJvcmdAc29ueS5jb20+DQo+Pj4+IC0tLQ0KPj4+PiAgZnMv
ZGVidWdmcy9pbm9kZS5jIHwgMTcgKysrKysrKysrKysrKysrKy0NCj4+Pj4gIGxpYi9LY29uZmln
LmRlYnVnICB8IDEwICsrKysrKysrKysNCj4+Pj4gIDIgZmlsZXMgY2hhbmdlZCwgMjYgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4+IE5vIGRvY3VtZW50YXRpb24gdXBkYXRlPyAgVGhh
dCdzIG5vdCBnb29kIDooDQo+Pj4NCj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvZnMvZGVidWdmcy9p
bm9kZS5jIGIvZnMvZGVidWdmcy9pbm9kZS5jDQo+Pj4+IGluZGV4IGI3ZjJlOTcxZWNiYy4uYmRl
MzdkYWI3N2UwIDEwMDY0NA0KPj4+PiAtLS0gYS9mcy9kZWJ1Z2ZzL2lub2RlLmMNCj4+Pj4gKysr
IGIvZnMvZGVidWdmcy9pbm9kZS5jDQo+Pj4+IEBAIC03ODYsMTAgKzc4NiwyNSBAQCBib29sIGRl
YnVnZnNfaW5pdGlhbGl6ZWQodm9pZCkNCj4+Pj4gIH0NCj4+Pj4gIEVYUE9SVF9TWU1CT0xfR1BM
KGRlYnVnZnNfaW5pdGlhbGl6ZWQpOw0KPj4+PiAgDQo+Pj4+ICtzdGF0aWMgaW50IGFsbG93X2Rl
YnVnZnM7DQo+Pj4+ICsNCj4+Pj4gK3N0YXRpYyBpbnQgX19pbml0IGRlYnVnZnNfa2VybmVsKGNo
YXIgKnN0cikNCj4+Pj4gK3sNCj4+Pj4gKwlpZiAoc3RyICYmICFzdHJjbXAoc3RyLCAidHJ1ZSIp
KQ0KPj4+PiArCQlhbGxvd19kZWJ1Z2ZzID0gdHJ1ZTsNCj4+Pj4gKw0KPj4+PiArCXJldHVybiAw
Ow0KPj4+PiArDQo+Pj4+ICt9DQo+Pj4+ICtlYXJseV9wYXJhbSgiZGVidWdmcyIsIGRlYnVnZnNf
a2VybmVsKTsNCj4+Pj4gKw0KPj4+PiAgc3RhdGljIGludCBfX2luaXQgZGVidWdmc19pbml0KHZv
aWQpDQo+Pj4+ICB7DQo+Pj4+ICAJaW50IHJldHZhbDsNCj4+Pj4gLQ0KPj4+PiArI2lmZGVmIENP
TkZJR19ERUJVR19GU19NT1VOVF9SRVNUUklDVEVEDQo+Pj4+ICsJaWYgKCFhbGxvd19kZWJ1Z2Zz
KQ0KPj4+PiArCQlyZXR1cm4gLUVQRVJNOw0KPj4+PiArI2VuZGlmDQo+Pj4gQnV0IHlvdSBhcmUg
bm90IHJlc3RyaWN0aW5nIHRoZSBhYmlsaXR5IHRvIG1vdW50IGl0IGhlcmUsIHlvdSBhcmUNCj4+
PiByZW1vdmluZyB0aGUgYWJpbGl0eSBmb3IgaXQgdG8gZXZlbiBzdGFydCB1cCBhdCBhbGwuICBX
aGF0IGRvZXMgdGhpcw0KPj4+IGJyZWFrIGZvciBjb2RlIHRoYXQgdGhpbmtzIHRoZSBmaWxlc3lz
dGVtIGlzIHJlZ2lzdGVyZWQgKGkuZS4gdGhlIGNhbGwNCj4+PiB0byBzaW1wbGVfcGluX2ZzKCkg
aW4gc3RhcnRfY3JlYXRpbmcoKSBpbiBmcy9kZWJ1Z2ZzL2lub2RlLmM/DQo+Pj4NCj4+IElmIGl0
IGRvZXMsIHRoZSBsaW5lcyBiZWxvdyBpcyBhbHNvIGNhdXNlIHRoZSBzYW1lIHByb2JsZW0uDQo+
IEluIGEgd29ya2luZyBzeXN0ZW0sIGVycm9ycyBpbiB0aGUgbGluZXMgYmVsb3cgd2lsbCBuZXZl
ciBoYXBwZW4gOikNCg0KSSB0aGluayBpdCBpcyBub3QgdW5yZWFzb25hYmxlIHRvIGV4cGVjdCB0
aGF0IGRlYnVnIGZ1bmN0aW9uYWxpdHkgYXJlIHJvYnVzdCBlbm91Z2ggdG8gaGFuZGxlDQpzeXN0
ZW0gd2hlcmUgbm90IGV2ZXJ5dGhpbmcgaXMgd29ya2luZyBzbW9vdGhseS4NCg0KDQo+IHRoYW5r
cywNCj4NCj4gZ3JlZyBrLWgNCg0K
