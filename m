Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3796BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CADE2073E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="BSvN9t0a";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="CAISoCBr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbgHCW4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 18:56:04 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:23068 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726770AbgHCW4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 18:56:03 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 073Mo8tb029864;
        Mon, 3 Aug 2020 15:55:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=ddOG+VqigjchI8qOhYGObX/QEmaStuRydcY5wH/Bavg=;
 b=BSvN9t0afcg2zQcEDxGXVJi4GB+q/Zsyx9WMOhA6mszWqcwC5UHo/DqfVNDOaVQolppx
 sUyagSKTyq4TEERyGwvyK6BDRRaRLystd3OvsNMOhorC/tpzlZIBUDPl7/OgZIjGLx0R
 P0LSGTCLOetqeSQb2og7EdKoVL2zWeKVVYM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32nr82f3je-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 03 Aug 2020 15:55:03 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 3 Aug 2020 15:55:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RhMEsSQmYJ7OSVcy6djdpfE06FzU2k2h9CacnQdlL8h+5DoNlsA1dXco/slaWknMeRedUCthGvO6ulESnX7pMOilJrHtdSySGUek4Pp+FsdX5xZBvhT33Wz3GYUCP5hKNw3RisF4uEGm3RuNTp15JLcteIx9Q1t2HwnemxdDxUK0s6aaDK6Fs8PQ9FaarCBzp6B6cvK8E33j+0wsHWqIZv3ab9hPQYv4/sElkVCYN0A+JuKjHgxl2exo1FWaV7oqHw/6euTD2xx5DKqGEjyk0xGDc6Fm99Qd874DkFX+JY9pA4cAN2Hj49osAeSwpFHARzuCsIi9JOfd3ni4Qnio2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddOG+VqigjchI8qOhYGObX/QEmaStuRydcY5wH/Bavg=;
 b=aJexJ+j2qCJMRF04XbC8t1RCcFBP2bnKfr5UgrsMoBDVNsHaTedd+AvQ8G/ItD48oEYCMii75Sy2j/Da+klbaaVsWoMNrRq8o1HvzJZj5yXGJ4xMYNKB8x77dnRUCTb3nmivuiSj7snA97/Scrb9ceb13y9sfv0oTFPT4SeNGIPnr7hfE6E3Y+bUanOeZ+hScazOkfCGRwtp7C7iMYxVvwh2oYcVEMXo+7ZiJ9L0mo5AZO5pp9rVgZ2YtYXyoW9bzWlTEpjNzjQ0X0VWPBgGD6EAD3AawbrCAcM4XK0wmQ3VglEqnQMWT3dLFL1dKV2xiidp+WHVe0FHI3L+KqtLow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddOG+VqigjchI8qOhYGObX/QEmaStuRydcY5wH/Bavg=;
 b=CAISoCBruzn38O79+U8aJHFWRHXyiZQYcKPAbeeoJc0r2+3YYGQ89cwnMF0U6/4k4+2NiZzFUSr/8inj1lEh4JCcZp/oFIYNfHO+T73v2rwgAGhoD8OdLdUjlsgBc3eD3L5tmQbqm99LgKC+RjQR6HJVovDNizXJYrToillREdU=
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by BYAPR15MB2694.namprd15.prod.outlook.com (2603:10b6:a03:158::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.21; Mon, 3 Aug
 2020 22:55:01 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::f4b9:8011:9aaa:e4ea]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::f4b9:8011:9aaa:e4ea%3]) with mapi id 15.20.3239.021; Mon, 3 Aug 2020
 22:55:01 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
CC:     Nick Terrell <nickrterrell@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Kernel Team <Kernel-team@fb.com>,
        Yann Collet <yann.collet.73@gmail.com>,
        Gao Xiang <gaoxiang25@huawei.com>,
        Sven Schmidt <4sschmid@informatik.uni-hamburg.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] lz4: Fix kernel decompression speed
Thread-Topic: [PATCH] lz4: Fix kernel decompression speed
Thread-Index: AQHWac5eBX2DbmatdkS0UNeom8wg5qkm7qKAgAAP/AA=
Date:   Mon, 3 Aug 2020 22:55:01 +0000
Message-ID: <3961E1BD-8F58-4240-A3B3-B7032A405B42@fb.com>
References: <20200803194022.2966806-1-nickrterrell@gmail.com>
 <20200803215747.GA1644409@rani.riverdale.lan>
In-Reply-To: <20200803215747.GA1644409@rani.riverdale.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: alum.mit.edu; dkim=none (message not signed)
 header.d=none;alum.mit.edu; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:9999]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4c1dd59-ab53-41bb-671b-08d838004125
x-ms-traffictypediagnostic: BYAPR15MB2694:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB26941E07363AE0D9040A9EBEAB4D0@BYAPR15MB2694.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r7fZ7tu4XBD0Qid4/WlmxmW3QS5ub1NsPQHJOf6Kk4MH4ApwuuHZ0yiQ+wYijQ5nQwQmr3vRG23fGN+zy9lAEXP7H4/NmmuD4e3oMNzlQgD3DdVpYKb9RZq+wpZWneHVjYoZlWdVShdmjfh0kC5aRuO3RBRdInt8XjRK2E2CDMm2PSw+XebTggV982hNb+51A4nqBT2HZPZZTn80UBg+Dp4Y2FdZq7XnabHgX9irZVlZOToCOnJPfYYAMBy9E86mcNrRbVk6N42fbOhpSwV8sxg95SCv5mMm6JfAaxFp6Ix3sUMOYmMfITVBNIbTYgyBwkFb+iv3Rn3ZshfOobPiMs1bVnXhdE7QKTs2fRLSclQMBCExjjM9qBavdGz0YtyD7CxCd+ctj8JpV7arEMG2Xw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(346002)(366004)(136003)(376002)(396003)(66446008)(66946007)(76116006)(7416002)(64756008)(66556008)(6916009)(53546011)(8936002)(36756003)(86362001)(2616005)(4326008)(66476007)(6506007)(316002)(6486002)(2906002)(186003)(478600001)(966005)(71200400001)(6512007)(8676002)(54906003)(33656002)(83380400001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: M10hSTj49gmiprHO5/sb3fSsGtrCO8rvFdYrOGp1LuFrxIxxtlshjtwe0mp11722xTKk1hdm+qPGLvWT2ldddNT+Ez7kjzpLKzm7S+fUh4Mi3GCHZeiarXm3tuGo/2oyzrw4gJDg8MONBBWNxbFSreaf3U926oK0jj4sITv+b58RgOXsMMf3nT1aBzTzKDghBSla6PibXiEJN8b0WJjZFDKzKXfT6yqvamsMyafsLSVxTGri0Jpkw9k9NfbsWSAROBCwLbGfBpwjTz45YmGg5nR2dLyM+oQs/tC90NNbTMSnrkpAbbF1W8/4HQXDqIkGsWIpE7zfsLgNomOnr6RQIm6NzhQ21Y/7tOulr/8fXuOy8G4+PyKzg2qQvnHMsFQhQcGBvzr41bN53I15cbXC8ZSwtTcbcgt2xugphgmpokn4jgXDnJ8VmSj/5jOQvSOZZGZurgzwWUU8yczKbcFwcKPLbo6M4rsA6j/XyBirpCUPmyOvbG+yRqq/WK7B1rZWqKO5D/HsNYCGhKXe+mDGDLXMK8CdmFuz7swCb+ou36HkyFhYxf0L3tdeQDm5dFLbxo+M/kN/gRz93r46c6d2rY45kUKWFRRyXI3cs3B5EZ4l55UAA7JML/FGP9GnaoF66exG4LK4D/dhA+Mxiqr/qoc5SH+JgFYnqc9ITIru5bk9jEBpB5njiHxiCx5cB82j
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BB4D893CFEE7148BDBB1C2A29062F51@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c1dd59-ab53-41bb-671b-08d838004125
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2020 22:55:01.5171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T9dfml2NnJ0Rk/I8/4zRvm00nt7jNFchUNyqGFcGCyaZMS0r6GZFsbQgcT+Jcjro
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2694
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-03_15:2020-08-03,2020-08-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 impostorscore=0 spamscore=0 clxscore=1011 lowpriorityscore=0
 malwarescore=0 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008030158
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gQXVnIDMsIDIwMjAsIGF0IDI6NTcgUE0sIEFydmluZCBTYW5rYXIgPG5pdmVkaXRh
QGFsdW0ubWl0LmVkdT4gd3JvdGU6DQo+IA0KPiBPbiBNb24sIEF1ZyAwMywgMjAyMCBhdCAxMjo0
MDoyMlBNIC0wNzAwLCBOaWNrIFRlcnJlbGwgd3JvdGU6DQo+PiBGcm9tOiBOaWNrIFRlcnJlbGwg
PHRlcnJlbGxuQGZiLmNvbT4NCj4+IA0KPj4gVGhpcyBwYXRjaCByZXBsYWNlcyBhbGwgbWVtY3B5
KCkgY2FsbHMgd2l0aCBMWjRfbWVtY3B5KCkgd2hpY2ggY2FsbHMNCj4+IF9fYnVpbHRpbl9tZW1j
cHkoKSBzbyB0aGUgY29tcGlsZXIgY2FuIGlubGluZSBpdC4NCj4+IA0KPj4gTFo0IHJlbGllcyBo
ZWF2aWx5IG9uIG1lbWNweSgpIHdpdGggYSBjb25zdGFudCBzaXplIGJlaW5nIGlubGluZWQuIElu
DQo+PiB4ODYgYW5kIGkzODYgcHJlLWJvb3QgZW52aXJvbm1lbnRzIG1lbWNweSgpIGNhbm5vdCBi
ZSBpbmxpbmVkIGJlY2F1c2UNCj4+IG1lbWNweSgpIGRvZXNuJ3QgZ2V0IGRlZmluZWQgYXMgX19i
dWlsdGluX21lbWNweSgpLg0KPj4gDQo+PiBBbiBlcXVpdmFsZW50IHBhdGNoIGhhcyBiZWVuIGFw
cGxpZWQgdXBzdHJlYW0gc28gdGhhdCB0aGUgbmV4dCBpbXBvcnQNCj4+IHdvbid0IGxvc2UgdGhp
cyBjaGFuZ2UgWzFdLg0KPj4gDQo+PiBJJ3ZlIG1lYXN1cmVkIHRoZSBrZXJuZWwgZGVjb21wcmVz
c2lvbiBzcGVlZCB1c2luZyBRRU1VIGJlZm9yZSBhbmQgYWZ0ZXINCj4+IHRoaXMgcGF0Y2ggZm9y
IHRoZSB4ODZfNjQgYW5kIGkzODYgYXJjaGl0ZWN0dXJlcy4gVGhlIHNwZWVkLXVwIGlzIGFib3V0
DQo+PiAxMHggYXMgc2hvd24gYmVsb3cuDQo+PiANCj4+IENvZGUJQXJjaAlLZXJuZWwgU2l6ZQlU
aW1lCVNwZWVkDQo+PiB2NS44CXg4Nl82NAkxMTUwNDgzMiBCCTE0OCBtcwkgNzkgTUIvcw0KPj4g
cGF0Y2gJeDg2XzY0CTExNTAzODcyIEIJIDEzIG1zCTg4NSBNQi9zDQo+PiB2NS44CWkzODYJIDk2
MjEyMTYgQgkgOTEgbXMJMTA2IE1CL3MNCj4+IHBhdGNoCWkzODYJIDk2MjAyMjQgQgkgMTAgbXMJ
OTYyIE1CL3MNCj4+IA0KPj4gSSBhbHNvIG1lYXN1cmVkIHRoZSB0aW1lIHRvIGRlY29tcHJlc3Mg
dGhlIGluaXRyYW1mcyBvbiB4ODZfNjQsIGkzODYsDQo+PiBhbmQgYXJtLiBBbGwgdGhyZWUgc2hv
dyB0aGUgc2FtZSBkZWNvbXByZXNzaW9uIHNwZWVkIGJlZm9yZSBhbmQgYWZ0ZXIsDQo+PiBhcyBl
eHBlY3RlZC4NCj4+IA0KPj4gWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS9sejQvbHo0L3B1bGwvODkw
DQo+PiANCj4gDQo+IEhpIE5pY2ssIHdvdWxkIHlvdSBiZSBhYmxlIHRvIHRlc3QgdGhlIGJlbG93
IHBhdGNoJ3MgcGVyZm9ybWFuY2UgdG8NCj4gdmVyaWZ5IGl0IGdpdmVzIHRoZSBzYW1lIHNwZWVk
dXA/IEl0IHJlbW92ZXMgdGhlICN1bmRlZiBpbiBtaXNjLmMgd2hpY2gNCj4gY2F1c2VzIHRoZSBk
ZWNvbXByZXNzb3JzIHRvIG5vdCB1c2UgdGhlIGJ1aWx0aW4gdmVyc2lvbi4gSXQgc2hvdWxkIGJl
DQo+IGVxdWl2YWxlbnQgdG8geW91cnMgZXhjZXB0IGZvciBhcHBseWluZyBpdCB0byBhbGwgdGhl
IGRlY29tcHJlc3NvcnMuDQo+IA0KPiBUaGFua3MuDQoNCkkgd2lsbCBtZWFzdXJlIGl0LiBJIHdv
dWxkIGV4cGVjdCBpdCB0byBwcm92aWRlIHRoZSBzYW1lIHNwZWVkIHVwLiBJdCB3b3VsZCBiZSBn
cmVhdCB0byBmaXgNCnRoZSBwcm9ibGVtIGZvciB4ODYvaTM4NiBpbiBnZW5lcmFsLg0KDQpCdXQs
IEkgYmVsaWV2ZSB0aGF0IHRoaXMgaXMgYWxzbyBhIHByb2JsZW0gZm9yIEFSTSwgdGhvdWdoIEkg
aGF2ZSBhIGhhcmQgdGltZSBtZWFzdXJpbmcNCmJlY2F1c2UgSSBjYW7igJl0IGdldCBwcmUtYm9v
dCBwcmludCBzdGF0ZW1lbnRzIGluIFFFTVUuIEkgd2lsbCBhdHRlbXB0IHRvIHRha2UgYSBsb29r
IGF0IHRoZQ0KYXNzZW1ibHksIGJlY2F1c2UgSeKAmW0gZmFpcmx5IGNlcnRhaW4gdGhhdCBtZW1j
cHkoKSBpc27igJl0IGlubGluZWQgaW4gbWFzdGVyLg0KDQpFdmVuIGlmIHdlIGZpeCBhbGwgdGhl
IGFyY2hpdGVjdHVyZXMsIEkgd291bGQgc3RpbGwgbGlrZSB0byBtZXJnZSB0aGUgTFo0IHBhdGNo
LiBJdCBzZWVtcyBsaWtlIGl0DQppcyBwcmV0dHkgZWFzeSB0byBtZXJnZSBhIHBhdGNoIHRoYXQg
aXMgYSBib290IHNwZWVkIHJlZ3Jlc3Npb24sIGJlY2F1c2UgcGVvcGxlIGFyZW7igJl0DQphY3Rp
dmVseSBtZWFzdXJpbmcgaXQuIFNvIEkgcHJlZmVyIGEgbGF5ZXJlZCBkZWZlbnNlLg0KDQpBZGRp
dGlvbmFsbHksIHRoaXMgaXMgZm9sbG93aW5nIHVwc3RyZWFtLiBBdCBzb21lIHBvaW50IExaNCB3
aWxsIGJlIGltcG9ydGVkIGZyb20gdXBzdHJlYW0NCmFuZCBnZXQgYW4gZXF1aXZhbGVudCBvZiB0
aGlzIHBhdGNoIGh0dHBzOi8vZ2l0aHViLmNvbS9sejQvbHo0L3B1bGwvODkwLg0KDQpCZXN0LA0K
Tmljaw==
