Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E644C10DCE
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 00:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11A1A206D7
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 00:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="J41KuqeB";
	dkim=temperror (0-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="n0p5D++x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgCGAMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 19:12:54 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:53262 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726300AbgCGAMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 19:12:53 -0500
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C121240363;
        Sat,  7 Mar 2020 00:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1583539972; bh=K4DjTge5fKCxSjOxFd3X4QASyztdWM8e67ep58p2s4s=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=J41KuqeBS/4v3uPQ/lq3GNQbgkbfF+32ysGOYcQALRjg+oiWWqsunbSFpllKFVhSu
         IOLY+R4S6fpV4GGuXWaRE/fyxNF2upVSVTEdX+RzxZfXKb9sULJMnl0ru+0Cd2Ey8b
         JcWD+bHa7oRwbKTEOypHDZJK7b12Egv/p4QDZWEL7XLoy6B2bFBwcmXW+5TnVmTlIh
         zRYw92HIdVTA7aMr13cq4RY1zw4RotsJN/vEozoHYlVkY95gRUNLlEtXDqTRzqCPJ1
         HBZiAaY7XcEBzVbLMIfmrIU4z91Bsm9y6wPmJWZoeCGCyJuQv+1VmQZbK7fv6v7wu8
         u1KCSpI1SfWOQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 7B46EA0069;
        Sat,  7 Mar 2020 00:12:52 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 6 Mar 2020 16:12:36 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 6 Mar 2020 16:12:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1JbrxIJx/iVniy+3G7usCPmIMbMggnp0J3r53523MIS7bMaaA/7Onju+tSc06FK655LK7UZ1aUdzaTRQL+3jrHXF4t9bQtMRO15GZNzybJ4tEGbTmR5mmjT6Ae67kLMUj84CNyRpcHfc0WLSk+L0T1UBob4ONsxHaoDZH/PKc7YWB9CfDnNqCi3NPJsw6YNMIZZmYh2vAK6mFAdpxtMjqWmiEO6pj81yqaWBIycHk7ErjU3oNMhAKZqcf2ikuWQ73K7MWDibGYPBSow1rmTOLJ2TM4YNapM4ARIm1jKuuQGacaZTWLRkOMbHLHhscfS2TTAO4dpB+TDRZJgmu/CCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4DjTge5fKCxSjOxFd3X4QASyztdWM8e67ep58p2s4s=;
 b=aykENi3XS6OQUcLTIdJgygtTjaO9iuS1MPD2rcTGU9/wBhvj7kuvAb2MMw46P3eL9cO+X40bbJsHfjjfZAK3WQAoZLa5d0Zb7f6UE1G7/2KF0VCPskkpIYaMmufYf42V4zcV3rWT7YOf0z6o/41Cr4V6HpAVETKJUWK5uXj/hWi2OQP5GsA2VlQnabtR6dkNYDhCzYC9nzUM9gW6hkCCLEQiUpzPzrVwN1pNNA1ZIO1uVlftnXVa/1+0ReezUg5dixue5lrrPLp6hVLIeqq/E3RfIp+Z/Xtuo1Yt9Wu8OzQzcqtwIrACDXMEs3FcJ3LGszkzDy3bF7hQ/3twlGIfsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4DjTge5fKCxSjOxFd3X4QASyztdWM8e67ep58p2s4s=;
 b=n0p5D++xNXmtGTbOJrSzJH4M8uhGg+OBJpE7CJCnywHtIyrEKZiyHC9PoYiZymO9KpN2/uv4+nHxq2uwFydTY1dFbtRRK2V5SUtmkPIeLHsIC/o96j/CwFBPdhBLTqm+Chi8A7q2fx15S+YP2Beu8h/hup8xo0OjR0p4q1jH1RM=
Received: from BYAPR12MB3592.namprd12.prod.outlook.com (2603:10b6:a03:db::25)
 by BYAPR12MB3029.namprd12.prod.outlook.com (2603:10b6:a03:ab::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Sat, 7 Mar
 2020 00:12:35 +0000
Received: from BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::a45a:6a41:3fe5:2eb7]) by BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::a45a:6a41:3fe5:2eb7%7]) with mapi id 15.20.2793.013; Sat, 7 Mar 2020
 00:12:35 +0000
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] ARC: handle DSP presence in HW
Thread-Topic: [PATCH v2 2/4] ARC: handle DSP presence in HW
Thread-Index: AQHV8yku7EOtW/wWqUKB6P65LyNDjag8Q9+A
Date:   Sat, 7 Mar 2020 00:12:35 +0000
Message-ID: <2d11b6d9-a37a-8cc3-1feb-a9dbc345de12@synopsys.com>
References: <20200305200252.14278-1-Eugeniy.Paltsev@synopsys.com>
 <20200305200252.14278-3-Eugeniy.Paltsev@synopsys.com>
In-Reply-To: <20200305200252.14278-3-Eugeniy.Paltsev@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vgupta@synopsys.com; 
x-originating-ip: [149.117.75.13]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5892b2d6-efc4-494d-20f5-08d7c22c3d0c
x-ms-traffictypediagnostic: BYAPR12MB3029:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB30294B12F6E5782F4F7BAAE8B6E00@BYAPR12MB3029.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 03355EE97E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(346002)(366004)(136003)(396003)(199004)(189003)(6506007)(53546011)(86362001)(8936002)(81166006)(81156014)(8676002)(66556008)(66946007)(66476007)(31696002)(76116006)(2616005)(64756008)(66446008)(26005)(186003)(6486002)(5660300002)(6512007)(4326008)(2906002)(31686004)(54906003)(478600001)(36756003)(316002)(71200400001)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR12MB3029;H:BYAPR12MB3592.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oMXLEFkedWIOjclkss9PqMOghuCtVKsnOsy+9p2d5XDkEAeJ1Oaga6OQ9d0ZIbN+MgG1nlLoMC+B6h0jPgttLdyhpSvFx/i5yxG/mKEy9AzbrJioxDbxzvRblLnWTd3G4XyXWZuoZkRXku7dwqRyKmGlQ1+VxreJWkrCUAgqS63Op4KTuy7Ukv4irtxbbQo7+1pey8fgSt6dI+uJUW7FV2wUXDR1r2it95uZJ53SVPn+CIoS3qT/m7cbPAaRlBxm9AiwQspeUh2tv33QxthcYfw2UmVDB0WchUr6xwkf4rrpAG2G9VpXiIc/lGdmcbEVHUFHdMEKoks2moD1Y1YSv9TAI2MDxdeu/UE98pCzF9d1fVf3tN1LcwAVNB/F8ZmN7pQSYyN0woato50PKLzyfS1n20FVnEU2EgbnRIbE1RBNekoSiuNDy6LLpEGLOF9x
x-ms-exchange-antispam-messagedata: 41P5w+HE/q7Wd8HSlqTThGeLu8SARcrv4pvs8J6uGehAsr58ZRIKmsbbHCSyl+GQH7bzPuk6L76oWnZBLD3J6Lh1qtuMxNWOH5BGld+2d23ca99q/D0lLlFQIT46Tz90s4Axdc7tF9j0/LpwUDitYg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9A7859ED4C2534C882847321EC6AE35@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5892b2d6-efc4-494d-20f5-08d7c22c3d0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2020 00:12:35.3030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XhX7cCGaTYO8C1NOa+eFNdDiGCen2SzLfCtaDAEqt0+l2W4TuUAa2hRzL8ahufw29f5htDFJeCgqQH2fnU2wzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3029
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy81LzIwIDEyOjAyIFBNLCBFdWdlbml5IFBhbHRzZXYgd3JvdGU6DQo+IEluIGNhc2Ugb2Yg
RFNQIGV4dGVuc2lvbiBwcmVzZW5jZSBpbiBIVyBzb21lIGluc3RydWN0aW9ucw0KPiAocmVsYXRl
ZCB0byBpbnRlZ2VyIG11bHRpcGx5LCBtdWx0aXBseS1hY2N1bXVsYXRlLCBhbmQgZGl2aWRlDQo+
IG9wZXJhdGlvbikgZXhlY3V0ZXMgb24gdGhpcyBEU1AgZXhlY3V0aW9uIHVuaXQuIFNvIHRoZWly
DQo+IGV4ZWN1dGlvbiB3aWxsIGRlcGVuZCBvbiBkc3AgY29uZmlndXJhdGlvbiByZWdpc3RlciAo
RFNQX0NUUkwpDQo+IA0KPiBBcyB3ZSB3YW50IHRoZXNlIGluc3RydWN0aW9ucyB0byBleGVjdXRl
IHRoZSBzYW1lIHdheSByZWdhcmRsZXNzDQo+IG9mIERTUCBwcmVzZW5jZSB3ZSBuZWVkIHRvIHNl
dCBEU1BfQ1RSTCBwcm9wZXJseS4gSG93ZXZlciB0aGlzDQo+IHJlZ2lzdGVyIGNhbiBiZSBtb2Rp
ZmllZCBidSBhbnkgdXNlcnNhY2UgYXBwIHRoZXJlZm9yZSBhbnkNCj4gdXNlcnNhY2UgbWF5IGJy
ZWFrIGtlcm5lbCBleGVjdXRpb24uDQo+IA0KPiBGaXggdGhhdCBieSBjb25maWd1cmUgRFNQX0NU
UkwgaW4gQ1BVIGVhcmx5IGNvZGUgYW5kIGluIElSUXMNCj4gZW50cmllcy4NCg0KSG93IGFib3V0
IGJlbG93IC4uLi4NCg0KIldoZW4gRFNQIGV4dGVuc2lvbnMgYXJlIHByZXNlbnQsIHNvbWUgb2Yg
dGhlIHJlZ3VsYXIgaW50ZWdlciBpbnN0cnVjdGlvbnMgc3VjaCBhcw0KRElWLCBNQUNEIGV0YyBh
cmUgZXhlY3V0ZWQgaW4gdGhlIERTUCB1bml0IHdpdGggc2VtYW50aWNzIGFsdGVyYWJsZSBieSBm
bGFncyBpbg0KRFNQX0NUUkwgYXV4IHJlZ2lzdGVyLiBUaGlzIHJlZ2lzdGVyIGlzIHdyaXRhYmxl
IGJ5IHVzZXJzcGFjZSBhbmQgdGh1cyBjYW4NCnBvdGVudGlhbGx5IGFmZmVjdCBjb3JyZXNwb25k
aW5nIGluc3RydWN0aW9ucyBpbiBrZXJuZWwgY29kZSwgaW50ZW50aW9uYWxseSBvcg0Kb3RoZXJ3
aXNlLiBTbyBzYWZlZ2F1cmQga2VybmVsIGJ5IGVmZmVjdGl2ZWx5IGRpc2FibGluZyBEU1BfQ1RS
TCB1cG9uIGJvb3R1cCBhbmQNCmV2ZXJ5IGVudHJ5IHRvIGtlcm5lbC4NCg0KRG8gbm90ZSB0aGF0
IGZvciB0aGlzIGNvbmZpZyB3ZSBzaW1wbHkgemVybyBvdXQgdGhlIERTUF9DVFJMIHJlZyBhc3N1
bWluZw0KdXNlcnNwYWNlIGRvZXNuJ3QgcmVhbGx5IGNhcmUgYWJvdXQgRFNQLiBUaGUgbmV4dCBw
YXRjaCBjYXRlcnMgdG8gdGhlIERTUCBhd2FyZQ0KdXNlcnNwYWNlIHdoaWNoIHRoaXMgYWN0dWFs
bHkgc2F2ZWQvcmVzdG9yZWQgdXBvbiBrZXJuZWwgZW50cnkuIg0KDQoNCg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogRXVnZW5peSBQYWx0c2V2IDxFdWdlbml5LlBhbHRzZXZAc3lub3BzeXMuY29tPg0K
PiAtLS0NCj4gIGFyY2gvYXJjL0tjb25maWcgICAgICAgICAgICAgICAgICAgfCAyOSArKysrKysr
KysrKysrKystDQo+ICBhcmNoL2FyYy9pbmNsdWRlL2FzbS9hcmNyZWdzLmggICAgIHwgMTIgKysr
KysrKw0KPiAgYXJjaC9hcmMvaW5jbHVkZS9hc20vZHNwLWltcGwuaCAgICB8IDU0ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKw0KPiAgYXJjaC9hcmMvaW5jbHVkZS9hc20vZW50cnktYXJj
djIuaCB8ICAzICsrDQo+ICBhcmNoL2FyYy9rZXJuZWwvaGVhZC5TICAgICAgICAgICAgIHwgIDQg
KysrDQo+ICBhcmNoL2FyYy9rZXJuZWwvc2V0dXAuYyAgICAgICAgICAgIHwgIDMgKysNCj4gIDYg
ZmlsZXMgY2hhbmdlZCwgMTA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gIGNyZWF0
ZSBtb2RlIDEwMDY0NCBhcmNoL2FyYy9pbmNsdWRlL2FzbS9kc3AtaW1wbC5oDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvYXJjaC9hcmMvS2NvbmZpZyBiL2FyY2gvYXJjL0tjb25maWcNCj4gaW5kZXggNzEy
NGFiODJkZmEzLi41NTQzMmE4ZmMyMGQgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJjL0tjb25maWcN
Cj4gKysrIGIvYXJjaC9hcmMvS2NvbmZpZw0KPiBAQCAtNDAxLDEzICs0MDEsNDAgQEAgY29uZmln
IEFSQ19IQVNfRElWX1JFTQ0KPiAgCWRlZmF1bHQgeQ0KPiAgDQo+ICBjb25maWcgQVJDX0hBU19B
Q0NMX1JFR1MNCj4gLQlib29sICJSZWcgUGFpciBBQ0NMOkFDQ0ggKEZQVSBhbmQvb3IgTVBZID4g
NikiDQo+ICsJYm9vbCAiUmVnIFBhaXIgQUNDTDpBQ0NIIChGUFUgYW5kL29yIE1QWSA+IDYgYW5k
L29yIERTUCkiDQo+ICAJZGVmYXVsdCB5DQo+ICAJaGVscA0KPiAgCSAgRGVwZW5kaW5nIG9uIHRo
ZSBjb25maWd1cmF0aW9uLCBDUFUgY2FuIGNvbnRhaW4gYWNjdW11bGF0b3IgcmVnLXBhaXINCj4g
IAkgIChhbHNvIHJlZmVycmVkIHRvIGFzIHI1ODpyNTkpLiBUaGVzZSBjYW4gYWxzbyBiZSB1c2Vk
IGJ5IGdjYyBhcyBHUFIgc28NCj4gIAkgIGtlcm5lbCBuZWVkcyB0byBzYXZlL3Jlc3RvcmUgcGVy
IHByb2Nlc3MNCj4gIA0KPiArY29uZmlnIEFSQ19EU1BfSEFORExFRA0KPiArCWRlZl9ib29sIG4N
Cj4gKw0KPiArY2hvaWNlDQo+ICsJcHJvbXB0ICJEU1Agc3VwcG9ydCINCj4gKwlkZWZhdWx0IEFS
Q19EU1BfTk9ORQ0KPiArCWhlbHANCj4gKwkgIERlcGVuZGluZyBvbiB0aGUgY29uZmlndXJhdGlv
biwgQ1BVIGNhbiBjb250YWluIERTUCByZWdpc3RlcnMNCj4gKwkgIChBQ0MwX0dMTywgQUNDMF9H
SEksIERTUF9CRkxZMCwgRFNQX0NUUkwsIERTUF9GRlRfQ1RSTCkuDQo+ICsJICBCZWxsb3cgaXMg
b3B0aW9ucyBkZXNjcmliaW5nIGhvdyB0byBoYW5kbGUgdGhlc2UgcmVnaXN0ZXJzIGluDQoNCnR5
cG86IEJlbG93DQoNCkxvb2tzIGdvb2Qgb3RoZXJ3aXNlLiBObyBuZWVkIHRvIHJlc3BpbiBqdXN0
IGZvciB0aGlzLg0KDQpSZXZpZXdlZC1ieTogVmluZWV0IEd1cHRhIDx2Z3VwdGFAc3lub3BzeXMu
Y29tPg0K
