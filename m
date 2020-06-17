Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD7FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AF5420888
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="oKbf7a3J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgFQO4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 10:56:35 -0400
Received: from mx07-001d1705.pphosted.com ([185.132.183.11]:33282 "EHLO
        mx07-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726494AbgFQO4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 10:56:35 -0400
X-Greylist: delayed 1022 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jun 2020 10:56:32 EDT
Received: from pps.filterd (m0209324.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05HEdCie003040;
        Wed, 17 Jun 2020 14:39:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=S1;
 bh=PxJJajgoXn0P+kchLYilHeLMbdFtdeErsLJ1+Q/LNw4=;
 b=oKbf7a3J/WwEiaFfs7j5tFpx0j7911gE4hcRMIPXTGaumzlPdxmp+3/4a5numWXOFJNO
 8l7UMsxCIESnvRqh9cRIj6I9+ivcFIq3qJHpnhpf5wg6L36P9dLeGIdVbp7dRcixZCf/
 zHltXElB/CEBS58ydNxNw5GSsFFFlI+/Rz4gF5PlPNuaMjrB3X5ICnsoH0E4OiXfBq16
 ++sYyUXy2FzoE4sd5JpBe63v+oeQp7twxxkLy/fuf5deRXvE7Tp8Ptu4ZS6TYTGkhpzp
 wf7MAXA1OumNA4eoTn6rWLWlFYEmQs33ptv2lVHYiPN4dCLg+89TitquitSBaagepJ5T ug== 
Received: from eur05-am6-obe.outbound.protection.outlook.com (mail-am6eur05lp2104.outbound.protection.outlook.com [104.47.18.104])
        by mx08-001d1705.pphosted.com with ESMTP id 31q66kg9p8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jun 2020 14:39:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTTDDeH3/LjGpdD2ylVNLIluM51JsbL8ndNygh6RNuSIk+Uc7gRbBPj8HVmT2jS4sxwn8kCt9kcRkxiL0PCs3FwIdNndpLKpNVtC1dRqA5SIXQo0DqGsQGbvk2kDcw2AUcVBxxRco887QHV4AeYO3VQPjP81na5ADoC3rztoJdkZan3d7WwUN5iIG0JXnuucXgcG/FRbvOq/9SpZyJsgdd5V6c8/zV8n605k/dBcHAzTd1BShfy2oNiH65PjL66leOaf0thXFYyxdrvulb6xuRlRIJqRvcwhOHqiWlEDcoHflCP2se4Axrw6li1RVoNY2Io7PWH2XCrTEJdRDJ3C5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxJJajgoXn0P+kchLYilHeLMbdFtdeErsLJ1+Q/LNw4=;
 b=aT71wes3gO6MzreO0pizEtQrcV6DDDcvJPLdP0skm0jws/I0mxNzWi2B9jZbhCefSX5nmbtCZIDqqFzOjWPBY97qflKb2HHitugLVUvOwh9VLVbeK+3j3SYwjI2arrU7PLyiAgXUfV2/B/MBNtchJdlHVZuS6y9rURUeytG7W44s4TgKSj6tVTsKSWonkDLZHpZv4j3K1w/woTsM9i3wkcA78j4EMxs5dTgOaT0WGkso7GkLRosLLmoE8yI/LnLKrctWgau4/0MCgUuABK0HaaUIAjLvFHmbZOvH9neMqpDFd5Q1s7jI83kWUAXPOgpPIA0iuesGDRYrJ9dexUOxow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from AM0P193MB0596.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:169::22)
 by AM0P193MB0612.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:163::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 17 Jun
 2020 14:39:10 +0000
Received: from AM0P193MB0596.EURP193.PROD.OUTLOOK.COM
 ([fe80::49f2:e189:1b3a:85c8]) by AM0P193MB0596.EURP193.PROD.OUTLOOK.COM
 ([fe80::49f2:e189:1b3a:85c8%3]) with mapi id 15.20.3109.021; Wed, 17 Jun 2020
 14:39:10 +0000
From:   "Enderborg, Peter" <Peter.Enderborg@sony.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3] debugfs: Add access restriction option
Thread-Topic: [PATCH v3] debugfs: Add access restriction option
Thread-Index: AQHWRKyK6HxAz8cqQkq3RCGlC643eajc2i+AgAAGloA=
Date:   Wed, 17 Jun 2020 14:39:09 +0000
Message-ID: <ea5ec140-e431-80ec-e237-801813df4a32@sony.com>
References: <20200617133738.6631-1-peter.enderborg@sony.com>
 <20200617141535.GA2624659@kroah.com>
In-Reply-To: <20200617141535.GA2624659@kroah.com>
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
x-ms-office365-filtering-correlation-id: c08c7b32-d275-4435-b688-08d812cc325d
x-ms-traffictypediagnostic: AM0P193MB0612:
x-microsoft-antispam-prvs: <AM0P193MB061224B21A53268BC8378E60869A0@AM0P193MB0612.EURP193.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 04371797A5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DIC//KyH9+Jriv8rE7u3OQjKf2Mr0f5Axw6OfXBIz9FP5ReGjZqNhgyaia+wyp/TILCq5e7C2avr3ruePd83aQeaGboEB7hAIwuvbH2xLirp+xJ4x0tR533UphjQ12Wys0627Xw1VbOVYokVxkaXLrn4SkdrcUySdyIgFMtfyzbsnBIAKBpQB5MFHO/vKXkxbf+tTh9QXIjg02Le2b2GAF+jMjeEKEt0J17I6D3yuKV7lxCY/nzaIkRY9AflXYAYBXLHf2e9WBxJky67AVYGsVpbI5vXUH48x0NLzoGUsIvinkPrkzEFjHJgx6D0kxGCBenzKclGN2AL8SLZUMZq1dv+P9IDXNIYWQ6kC8LHQy8Nt3bBwe51ASNhQlkKthIw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P193MB0596.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(8676002)(6486002)(5660300002)(36756003)(2906002)(478600001)(71200400001)(8936002)(6916009)(6512007)(4326008)(54906003)(83380400001)(2616005)(186003)(66946007)(66476007)(66446008)(66556008)(64756008)(91956017)(76116006)(26005)(53546011)(31686004)(6506007)(86362001)(31696002)(316002)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 25hI0ZYk2VgoOAxTFCu2CLID8BCTrfyJSKMMxS2LK4YB+jfyswJCHcX02sQVcrZOFeG6NyKEMuciq9+haL5hKObGPIGIUvAGuELQPZDGz6a87NO3aybUq1wyxIzKfx+tIcFBfQ4S49pXeIUzhfxo0mv4+KMsohCmJXBrdW9qqE9fpUFLRu5nxNaaCfrteqVHEas0rMCSWwSw2ROzUhiL/p6nLpCEybLYk9s6SnY95KGQaK+37p+xlc5zkrplaWUD+7bocpGl3vp9WutM3gniL3VbvaaE8A/axrZEac72o99jjpVAW4DY8uAsAq8jQa8jE16n7P394zFehpdxB/KQpTz2mvOkWY566EP3deRoO7mKULuEKgxCnetDc0N0OgC9EyL9onVtpNl4n/oXvnG5Cs1t+AKsSNX2OOQQ/J1f0XId8wVd9kQWOTHYiQ2HyWGH/1f6gnVhurT5sx1pY65yYkwSHnR52aQ488WHSlyI6+M=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D231BC3ACFD60843AAD7EF4C0AE9E686@EURP193.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c08c7b32-d275-4435-b688-08d812cc325d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2020 14:39:09.9470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yH2OfjPLnMNuaO1lw2pIy7Wdxzcck4CLKyRNqb0bQW8IAeMXKc45iNKEaQInk+4eI2hVe2kJPQmkOdtymWDte+VFIzmeUJ9tmu0x0nV7FN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P193MB0612
X-Sony-Outbound-GUID: sl-AripFBjymHNSQ2AQSraK9LzDTEMij
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-17_04:2020-06-17,2020-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 clxscore=1011 impostorscore=0
 cotscore=-2147483648 spamscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006170115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8xNy8yMCA0OjE1IFBNLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3JvdGU6DQo+IE9uIFdlZCwg
SnVuIDE3LCAyMDIwIGF0IDAzOjM3OjM4UE0gKzAyMDAsIFBldGVyIEVuZGVyYm9yZyB3cm90ZToN
Cj4+IFNpbmNlIGRlYnVnZnMgaW5jbHVkZSBzZW5zaXRpdmUgaW5mb3JtYXRpb24gaXQgbmVlZCB0
byBiZSB0cmVhdGVkDQo+PiBjYXJlZnVsbHkuIEJ1dCBpdCBhbHNvIGhhcyBtYW55IHZlcnkgdXNl
ZnVsIGRlYnVnIGZ1bmN0aW9ucyBmb3IgdXNlcnNwYWNlLg0KPj4gV2l0aCB0aGlzIG9wdGlvbiB3
ZSBjYW4gaGF2ZSBzYW1lIGNvbmZpZ3VyYXRpb24gZm9yIHN5c3RlbSB3aXRoDQo+PiBuZWVkIG9m
IGRlYnVnZnMgYW5kIGEgd2F5IHRvIHR1cm4gaXQgb2ZmLiBUaGlzIGdpdmVzIGEgZXh0cmEgcHJv
dGVjdGlvbg0KPj4gZm9yIGV4cG9zdXJlIG9uIHN5c3RlbXMgd2hlcmUgdXNlci1zcGFjZSBzZXJ2
aWNlcyB3aXRoIHN5c3RlbQ0KPj4gYWNjZXNzIGFyZSBhdHRhY2tlZC4NCj4+DQo+PiBXaGVuIGVu
YWJsZWQgaXQgaXMgbmVlZGVkIGEga2VybmVsIGNvbW1hbmQgbGluZSBwYXJhbWV0ZXIgdG8gYmUg
YWN0aXZhdGVkLg0KPj4NCj4+IEl0IGNhbiBiZSBvbiBvciBvZmYsIGJ1dCBhbHNvIGludGVybmFs
bHkgb24gYnV0IG5vdCBzZWVuIGZyb20gdXNlci1zcGFjZS4NCj4+IFRoaXMgbm8tZnMgbW9kZSBk
byBub3QgcmVnaXN0ZXIgYSBkZWJ1Z2ZzIGFzIGZpbGVzeXN0ZW0sIGJ1dCBjbGllbnQgY2FuDQo+
PiByZWdpc3RlciB0aGVpciBwYXJ0cyBpbiB0aGUgaW50ZXJuYWwgc3RydWN0dXJlcy4gVGhpcyBk
YXRhIGNhbiBiZSByZWFkZWQNCj4+IHdpdGggYSBkZWJ1Z2dlciBvciBzYXZlZCB3aXRoIGEgY3Jh
c2hrZXJuZWwuIFdoZW4gaXQgaXMgb2ZmIGNsaWVudHMNCj4+IGdldCBFUEVSTSBlcnJvciB3aGVu
IGFjY2Vzc2luZyB0aGUgZnVuY3Rpb25zIGZvciByZWdpc3RlcmluZyB0aGVpcg0KPj4gY29tcG9u
ZW50cy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBQZXRlciBFbmRlcmJvcmcgPHBldGVyLmVuZGVy
Ym9yZ0Bzb255LmNvbT4NCj4+IC0tLQ0KPj4gdjIuIFJlbW92ZWQgTU9VTlQgYXMgcGFydCBvZiBy
ZXN0cmljdGlvbnMuIEFkZGVkIEFQSSdzIHJlc3RyaWN0aW9ucyBhcw0KPj4gICAgIHNlcGFyYXRl
IHJlc3RyaWN0aW9uLg0KPj4gdjMgIFVwZGF0ZWQgRG9jdW1lbnRhdGlvbiBhZnRlciBSYW5keSBE
dW5sYXAgcmV2aWV3cyBhbmQgc3VnZ2VzdGlvbnMuDQo+Pg0KPj4gIC4uLi9hZG1pbi1ndWlkZS9r
ZXJuZWwtcGFyYW1ldGVycy50eHQgICAgICAgICB8IDExICsrKysrDQo+PiAgZnMvZGVidWdmcy9p
bm9kZS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgNDcgKysrKysrKysrKysrKysrKysr
Kw0KPj4gIGxpYi9LY29uZmlnLmRlYnVnICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDEw
ICsrKysNCj4+ICAzIGZpbGVzIGNoYW5nZWQsIDY4IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZm
IC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQg
Yi9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dA0KPj4gaW5k
ZXggZmI5NWZhZDgxYzc5Li4yNDljODZlNTNiYjcgMTAwNjQ0DQo+PiAtLS0gYS9Eb2N1bWVudGF0
aW9uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dA0KPj4gKysrIGIvRG9jdW1lbnRh
dGlvbi9hZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQNCj4+IEBAIC04MjcsNiArODI3
LDE3IEBADQo+PiAgCQkJdXNlZnVsIHRvIGFsc28gZW5hYmxlIHRoZSBwYWdlX293bmVyIGZ1bmN0
aW9uYWxpdHkuDQo+PiAgCQkJb246IGVuYWJsZSB0aGUgZmVhdHVyZQ0KPj4gIA0KPj4gKwlkZWJ1
Z2ZzPSAgICAJW0tOTF0gV2hlbiBDT05GSUdfREVCVUdfRlNfUkVTVFJJQ1RFRCBpcyBzZXQsIHRo
aXMgcGFyYW1ldGVyDQo+PiArCQkJZW5hYmxlcyB3aGF0IGlzIGV4cG9zZWQgdG8gdXNlcnNwYWNl
Lg0KPj4gKwkJCUZvcm1hdDogeyBvbiwgbm9fZnMsIG9mZiB9DQo+PiArCQkJb246IAlBbGwgZnVu
Y3Rpb25zIGFyZSBlbmFibGVkLg0KPj4gKwkJCW5vX2ZzOiAJRmlsZXN5c3RlbSBpcyBub3QgcmVn
aXN0ZXJlZCBidXQga2VybmVsIGNsaWVudHMgY2FuDQo+PiArCQkJICAgICAgICBhY2Nlc3MgQVBJ
cyBhbmQgYSBjcmFzaGtlcm5lbCBjYW4gYmUgdXNlZCB0byByZWFkDQo+PiArCQkJCWl0J3MgY29u
dGVudC4gVGhlcmUgaXRzIG5vdGhpbmcgdG8gbW91bnQuDQo+PiArCQkJb2ZmOiAJKGRlZmF1bHQp
IEZpbGVzeXN0ZW0gaXMgbm90IHJlZ2lzdGVyZWQgYW5kIGNsaWVudHMNCj4+ICsJCQkgICAgICAg
IGdldCBhIC1FUEVSTSBhcyByZXN1bHQgd2hlbiB0cnlpbmcgdG8gcmVnaXN0ZXIgZmlsZXMNCj4+
ICsJCQkJb3IgZGlyZWN0b3JpZXMgd2l0aGluIGRlYnVnZnMuDQo+PiArDQo+PiAgCWRlYnVncGF0
CVtYODZdIEVuYWJsZSBQQVQgZGVidWdnaW5nDQo+PiAgDQo+PiAgCWRlY25ldC5hZGRyPQlbSFcs
TkVUXQ0KPj4gZGlmZiAtLWdpdCBhL2ZzL2RlYnVnZnMvaW5vZGUuYyBiL2ZzL2RlYnVnZnMvaW5v
ZGUuYw0KPj4gaW5kZXggYjdmMmU5NzFlY2JjLi4yYmQ4MGE5MzJhZTEgMTAwNjQ0DQo+PiAtLS0g
YS9mcy9kZWJ1Z2ZzL2lub2RlLmMNCj4+ICsrKyBiL2ZzL2RlYnVnZnMvaW5vZGUuYw0KPj4gQEAg
LTMxLDEwICszMSwxNyBAQA0KPj4gICNpbmNsdWRlICJpbnRlcm5hbC5oIg0KPj4gIA0KPj4gICNk
ZWZpbmUgREVCVUdGU19ERUZBVUxUX01PREUJMDcwMA0KPj4gKyNpZmRlZiBDT05GSUdfREVCVUdf
RlNfUkVTVFJJQ1RFRA0KPj4gKyNkZWZpbmUgREVCVUdGU19BTExPV19BUEkgMHgyDQo+PiArI2Rl
ZmluZSBERUJVR0ZTX0FMTE9XX0ZTIDB4MQ0KPiBCSVQoKT8NCj4NCj4gQW5kIGEgdGFiPw0KPg0K
PiBBbmQgd2h5IGEgI2lmZGVmPw0KVG8gZ2V0IGl0IGFzIGxlYXN0IGludHJ1c2l2ZSBhcyBwb3Nz
aWJsZS4gQSBzb2xpZCBPcHQtSW4uDQo+DQo+PiArI2VuZGlmDQo+PiAgDQo+PiAgc3RhdGljIHN0
cnVjdCB2ZnNtb3VudCAqZGVidWdmc19tb3VudDsNCj4+ICBzdGF0aWMgaW50IGRlYnVnZnNfbW91
bnRfY291bnQ7DQo+PiAgc3RhdGljIGJvb2wgZGVidWdmc19yZWdpc3RlcmVkOw0KPj4gKyNpZmRl
ZiBDT05GSUdfREVCVUdfRlNfUkVTVFJJQ1RFRA0KPj4gK3N0YXRpYyB1bnNpZ25lZCBpbnQgZGVi
dWdmc19hbGxvdzsNCj4+ICsjZW5kaWYNCj4gV2h5ICNpZmRlZj8NCj4NCj4+ICANCj4+ICAvKg0K
Pj4gICAqIERvbid0IGFsbG93IGFjY2VzcyBhdHRyaWJ1dGVzIHRvIGJlIGNoYW5nZWQgd2hpbHN0
IHRoZSBrZXJuZWwgaXMgbG9ja2VkIGRvd24NCj4+IEBAIC0yNjYsNiArMjczLDEwIEBAIHN0YXRp
YyBzdHJ1Y3QgZGVudHJ5ICpkZWJ1Z19tb3VudChzdHJ1Y3QgZmlsZV9zeXN0ZW1fdHlwZSAqZnNf
dHlwZSwNCj4+ICAJCQlpbnQgZmxhZ3MsIGNvbnN0IGNoYXIgKmRldl9uYW1lLA0KPj4gIAkJCXZv
aWQgKmRhdGEpDQo+PiAgew0KPj4gKyNpZmRlZiBDT05GSUdfREVCVUdfRlNfUkVTVFJJQ1RFRA0K
Pj4gKwlpZiAoIShkZWJ1Z2ZzX2FsbG93ICYgREVCVUdGU19BTExPV19BUEkpKQ0KPj4gKwkJcmV0
dXJuIEVSUl9QVFIoLUVQRVJNKTsNCj4+ICsjZW5kaWYNCj4gSWNrLCBhbGwgb2YgdGhpcyAjaWZk
ZWYgaXMgYSBtZXNzLCBhbmQgY2FuIGJlIHRvdGFsbHkgYXZvaWRlZCBpZiB5b3UgZG8NCj4gdGhl
IGxvZ2ljIHJpZ2h0IGhlcmUuICBQbGVhc2UgbWFrZSBpdCBzbyB0aGF0IHRoZSBmdW5jdGlvbnMg
YW5kIGFsbW9zdA0KPiBhbGwgb2YgdGhlIC5jIGNvZGUgZG9lcyBub3QgaGF2ZSAjaWZkZWYgQ09O
RklHX0RFQlVHX0ZTX1JFU1RSSUNURUQgYXQNCj4gYWxsLg0KPg0KSXMgaXQgb2sgdG8gcmVtb3Zl
IHRoZSAjaWZkZWZzIGFuZCBsZXQgY29kZSBhbHdheXMgYmUgdGhlcmUgYW5kIGxldCB0aGUgY29u
ZmlnIHNldCB0aGUgZGVmYXVsdCB2YWx1ZT8NCg0KDQo+PiAgCXJldHVybiBtb3VudF9zaW5nbGUo
ZnNfdHlwZSwgZmxhZ3MsIGRhdGEsIGRlYnVnX2ZpbGxfc3VwZXIpOw0KPj4gIH0NCj4+ICANCj4+
IEBAIC0zODUsNiArMzk2LDEyIEBAIHN0YXRpYyBzdHJ1Y3QgZGVudHJ5ICpfX2RlYnVnZnNfY3Jl
YXRlX2ZpbGUoY29uc3QgY2hhciAqbmFtZSwgdW1vZGVfdCBtb2RlLA0KPj4gIAlpZiAoSVNfRVJS
KGRlbnRyeSkpDQo+PiAgCQlyZXR1cm4gZGVudHJ5Ow0KPj4gIA0KPj4gKyNpZmRlZiBDT05GSUdf
REVCVUdfRlNfUkVTVFJJQ1RFRA0KPj4gKwlpZiAoIShkZWJ1Z2ZzX2FsbG93ICYgREVCVUdGU19B
TExPV19BUEkpKSB7DQo+PiArCQlmYWlsZWRfY3JlYXRpbmcoZGVudHJ5KTsNCj4+ICsJCXJldHVy
biBFUlJfUFRSKC1FUEVSTSk7DQo+PiArCX0NCj4+ICsjZW5kaWYNCj4+ICAJaW5vZGUgPSBkZWJ1
Z2ZzX2dldF9pbm9kZShkZW50cnktPmRfc2IpOw0KPj4gIAlpZiAodW5saWtlbHkoIWlub2RlKSkg
ew0KPj4gIAkJcHJfZXJyKCJvdXQgb2YgZnJlZSBkZW50cmllcywgY2FuIG5vdCBjcmVhdGUgZmls
ZSAnJXMnXG4iLA0KPj4gQEAgLTU0MSw2ICs1NTgsMTIgQEAgc3RydWN0IGRlbnRyeSAqZGVidWdm
c19jcmVhdGVfZGlyKGNvbnN0IGNoYXIgKm5hbWUsIHN0cnVjdCBkZW50cnkgKnBhcmVudCkNCj4+
ICAJaWYgKElTX0VSUihkZW50cnkpKQ0KPj4gIAkJcmV0dXJuIGRlbnRyeTsNCj4+ICANCj4+ICsj
aWZkZWYgQ09ORklHX0RFQlVHX0ZTX1JFU1RSSUNURUQNCj4+ICsJaWYgKCEoZGVidWdmc19hbGxv
dyAmIERFQlVHRlNfQUxMT1dfQVBJKSkgew0KPj4gKwkJZmFpbGVkX2NyZWF0aW5nKGRlbnRyeSk7
DQo+PiArCQlyZXR1cm4gRVJSX1BUUigtRVBFUk0pOw0KPj4gKwl9DQo+PiArI2VuZGlmDQo+PiAg
CWlub2RlID0gZGVidWdmc19nZXRfaW5vZGUoZGVudHJ5LT5kX3NiKTsNCj4+ICAJaWYgKHVubGlr
ZWx5KCFpbm9kZSkpIHsNCj4+ICAJCXByX2Vycigib3V0IG9mIGZyZWUgZGVudHJpZXMsIGNhbiBu
b3QgY3JlYXRlIGRpcmVjdG9yeSAnJXMnXG4iLA0KPj4gQEAgLTU4Myw2ICs2MDYsMTIgQEAgc3Ry
dWN0IGRlbnRyeSAqZGVidWdmc19jcmVhdGVfYXV0b21vdW50KGNvbnN0IGNoYXIgKm5hbWUsDQo+
PiAgCWlmIChJU19FUlIoZGVudHJ5KSkNCj4+ICAJCXJldHVybiBkZW50cnk7DQo+PiAgDQo+PiAr
I2lmZGVmIENPTkZJR19ERUJVR19GU19SRVNUUklDVEVEDQo+PiArCWlmICghKGRlYnVnZnNfYWxs
b3cgJiBERUJVR0ZTX0FMTE9XX0FQSSkpIHsNCj4+ICsJCWZhaWxlZF9jcmVhdGluZyhkZW50cnkp
Ow0KPj4gKwkJcmV0dXJuIEVSUl9QVFIoLUVQRVJNKTsNCj4+ICsJfQ0KPj4gKyNlbmRpZg0KPj4g
IAlpbm9kZSA9IGRlYnVnZnNfZ2V0X2lub2RlKGRlbnRyeS0+ZF9zYik7DQo+PiAgCWlmICh1bmxp
a2VseSghaW5vZGUpKSB7DQo+PiAgCQlwcl9lcnIoIm91dCBvZiBmcmVlIGRlbnRyaWVzLCBjYW4g
bm90IGNyZWF0ZSBhdXRvbW91bnQgJyVzJ1xuIiwNCj4+IEBAIC03ODYsMTAgKzgxNSwyOCBAQCBi
b29sIGRlYnVnZnNfaW5pdGlhbGl6ZWQodm9pZCkNCj4+ICB9DQo+PiAgRVhQT1JUX1NZTUJPTF9H
UEwoZGVidWdmc19pbml0aWFsaXplZCk7DQo+PiAgDQo+PiArc3RhdGljIGludCBfX2luaXQgZGVi
dWdmc19rZXJuZWwoY2hhciAqc3RyKQ0KPj4gK3sNCj4+ICsjaWZkZWYgQ09ORklHX0RFQlVHX0ZT
X1JFU1RSSUNURUQNCj4+ICsJaWYgKHN0ciAmJiAhc3RyY21wKHN0ciwgIm9uIikpDQo+PiArCQlk
ZWJ1Z2ZzX2FsbG93ID0gREVCVUdGU19BTExPV19BUEkgfCBERUJVR0ZTX0FMTE9XX0ZTOw0KPj4g
KwlpZiAoc3RyICYmICFzdHJjbXAoc3RyLCAibm8tZnMiKSkNCj4+ICsJCWRlYnVnZnNfYWxsb3cg
fD0gREVCVUdGU19BTExPV19BUEk7DQo+PiArCWlmIChzdHIgJiYgIXN0cmNtcChzdHIsICJvZmYi
KSkNCj4+ICsJCWRlYnVnZnNfYWxsb3cgPSAwOw0KPiBJdCdzIHNldCB0byAwIGJ5IGRlZmF1bHQs
IG5vIG5lZWQgdG8gc2V0IGl0IGFnYWluLCByaWdodD8NCkkgdGhpbmsgdGhlcmUgaGF2ZSBiZWVu
IHNvbWUgaXNzdWVzIHdpdGggdGhlIHNhbWUgcGFyYW1ldGVyIG1vcmUgdGhhbiBvbmNlLg0KPg0K
Pj4gKyNlbmRpZg0KPj4gKwlyZXR1cm4gMDsNCj4+ICsNCj4+ICt9DQo+PiArZWFybHlfcGFyYW0o
ImRlYnVnZnMiLCBkZWJ1Z2ZzX2tlcm5lbCk7DQo+IFdoeSBpcyB0aGlzIGEgdmFsaWQgcGFybSBl
dmVuIGlmIHRoZSBvcHRpb24gaXMgbm90IGVuYWJsZWQ/ICBEbyB5b3UgbWVhbg0KPiB0byBkbyB0
aGF0PyAgV2h5Pw0KDQpJIGRpZCBub3QgZmluZCBhbnkgZ29vZCB1c2FnZSB3aGVyZSBpdCB3YXMg
Y29uZmlnIGRlcGVuZGVudCwgd2hlbiBpdCBpcyB0aGVyZTsgaXQgaXPCoCAicmVzZXJ2ZSIgdGhl
IG5hbWUuDQoNCkl0IHdpbGwgYWx3YXlzIGJlIHRoZXJlIGlmIHdlIHJlbW92ZSB0aGUgI2lmZGVm
cy4NCg0KPiB0aGFua3MsDQo+DQo+IGdyZWcgay1oDQoNCg==
