Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61081C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 02:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D77B20738
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 02:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Q4GitK75";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="jgnccO/C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgHDC7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 22:59:41 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:26660 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725840AbgHDC7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 22:59:40 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0742wXQG032388;
        Mon, 3 Aug 2020 19:58:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=ISdX9Fp+SUwXnbsK1ROFP+JofIkCJmHLxPAYvqtQZXw=;
 b=Q4GitK75LhzDs6dz7WMcDEHb50qVhf2ZrGNy+dEwwIsL2IbaFwU/qHVTwvz8nyGZucrL
 DyqItmI3zfDiVM89OGDPaybDtCKDjFeZCTdudxxX2Qquh+GYUPD4HvkY4sxx7irWdz+y
 ybwylb/xyJHgsdfZuUvEwxdRPGPqvKy9zWA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 32n80tacc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 03 Aug 2020 19:58:33 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 3 Aug 2020 19:57:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCx5IVL9dZ1emysopOHJq47f5cx3QAlzsOb6EnBCyMvMxIx0lRenBzlzne8eRZ2QUPEZ+6ktTl7deXfO8wOd44m9ntGWeEkDfS2JGOfMk+t0XjxCJKjxfXxRPpOG6VqFyuCP1B8q2ESA8BJjr6WR9bLwLEc0xDeeJ21JPtdJu+m9y4HlIS/qXEWLmpdEKnYw5cxbX3jBns/cSf7/gNZM3JaDjbMGT5FlX65ZcKL1E6rh6p1FapOxW8M4POxtLJIQUApMIMTM9W6XtDmqrD6uMDvX1fiYWxAOW20DPbNh79FvGKGOMKhDKh2e56/qLD1hC4Y+uOdna3gCACtN2Un/gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISdX9Fp+SUwXnbsK1ROFP+JofIkCJmHLxPAYvqtQZXw=;
 b=avWwu2Qx3QS8c5gWReh/yW1zvjgSd6uN1P4pILbpNXTyT5rwTg6Lz5Ih1QmF2MwQqt2hsv6JP/CogCrAYArfQApY0MbzLTLsTdLCHLoQCGVxuwCnu7VHz++GkSegbfGCHrDwjy02O5eP+FWqRNWKjBFmlPtm5yLtNbj/3KqsSsfHZgPhE9ZSz1HhpWWdYVcVHfFMW8c2MF+BQh0k6wOZ2DnFgFXisR4BsGCWIKv54zp1sbfw0MYDs2dQE6Zqjr0nC661F3lMIPFk4nan6YSGWW39vhPwOzVhiIBFUrHKQa+L06vF8gJbz5W89f5ttzBZUJNkfwg53WnfzhZrZDbaiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISdX9Fp+SUwXnbsK1ROFP+JofIkCJmHLxPAYvqtQZXw=;
 b=jgnccO/CLwYMladmbQtPsEV0GkFJiK0RhWaqZJFgsKYRp/PfSV89UF9HU/hPhAIQNpry9SxwK9tJmWByGfE+s2yhUMLUMvSiTDHTLCQJhNr928q4GWOHZR4NUN6CCi/0p2t/zMelC/rqEKyS32zDv2MRKBS5yMk2c0Y2OOvkQqQ=
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by BYAPR15MB3365.namprd15.prod.outlook.com (2603:10b6:a03:111::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Tue, 4 Aug
 2020 02:57:50 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::f4b9:8011:9aaa:e4ea]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::f4b9:8011:9aaa:e4ea%3]) with mapi id 15.20.3239.021; Tue, 4 Aug 2020
 02:57:50 +0000
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
Thread-Index: AQHWac5eBX2DbmatdkS0UNeom8wg5qkm7qKAgAAP/ACAADLTAIAAEQWA
Date:   Tue, 4 Aug 2020 02:57:50 +0000
Message-ID: <0C67BA74-E014-449B-9E22-E0B1DDB930BF@fb.com>
References: <20200803194022.2966806-1-nickrterrell@gmail.com>
 <20200803215747.GA1644409@rani.riverdale.lan>
 <3961E1BD-8F58-4240-A3B3-B7032A405B42@fb.com>
 <20200804015654.GA1943218@rani.riverdale.lan>
In-Reply-To: <20200804015654.GA1943218@rani.riverdale.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: alum.mit.edu; dkim=none (message not signed)
 header.d=none;alum.mit.edu; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:9999]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eeee8898-1c45-4cc2-29d3-08d838222cc9
x-ms-traffictypediagnostic: BYAPR15MB3365:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB3365E000F06AA0D7085269FCAB4A0@BYAPR15MB3365.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 25FL8Dvx5wKKJALhN5N5fcH/9SuxXtehDBh2RpuxECpkxkLyWdixf7vnmjUKu+LFLC3JmkIMpgnA+V18qwh53s//eLxvt6PuBEBpp0gVBHWriMcJkEMJyTlJbY/CxX82Ph2cjorZs5SZu+/fEcHTdUh/OH5JQYdTd5MLxsFtPfJ7tiJORCTdebFKCwKcIMfrsY02xbh9qURfTYhz8uOOatsb0BosBL/iL2EghzMlNpWnM1F22KpqZw9LYUK8EN7ZJ5IZLX/P/ptdSf07OIpc7xPPB4WKPglr0M48RE8SiLDLy/w1tuTh98OazIW48CsVt/r2DvtSStAaZoVs3Ev1bd2wVIT5SmHPH38bbc+Fc2/x4z5VbmZWB8K3F4+U2Oyqm4+IEayebaxYyzKF9hxdVw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39860400002)(346002)(136003)(366004)(376002)(478600001)(86362001)(71200400001)(316002)(6916009)(6512007)(8676002)(76116006)(66556008)(7416002)(66446008)(2906002)(186003)(5660300002)(66946007)(66476007)(64756008)(53546011)(2616005)(6486002)(6506007)(36756003)(54906003)(4326008)(966005)(33656002)(8936002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: XhXy6IF/PJXKMNAPXyC59WjZ2d/vN+fpYs3dbGsg6tLlzejFCU0loRl7GnUXWWt87CDqTnUYCv1XfpS4n1fV/4jOHngJaWFy2AOqTYC+Q/8uuLCDC+PhByvpECx9coPsmC1eje3+a1DZ1FLLkY/b/Wrv3W1BDUUMseCCduscv+jdYVobX4+wXf0Fg4afSyiZwepGqQtPsjUXvGFi5kT7Am6OvtpskLIh1p6fqJQYmFO4mOrkAWAAXYAq4TL1VeFMS8u95+ZTEwVa4GE3Upclk+KG5+NofrDVphKw3/MoXiEogwpsFdpHZhdhM2NuJ4waJLnDW/N0dr0kmy+ARQ9q+Vrpeg3q+iUb3ppvcF9KSk2fnZY2h2/wY+mrI40SLVr0VlsxPXXsSGxgF5bWCFpI5+Oi5lsytGp+D/16xDI78zUCpkCaQvCKSFcAF02lJhSDcImUrl3XMYpvn8+OduLV2MbkUYJWVXjHP/kASJY9BWXwvlD4WmMlQ+28a0BilosEojKavNpvQm3BPTE8UzHLO/MKKKy/iID/+GYNKjN5pzVyqIgVbvkGW8E2VAQ1axoOPSlnZIUaK7WbJuEaUgLDzbCOTl+fa+mhocd/g98fehhoe2tPA+5lXoMBzRxt/BHL+SQjfqEN86eppOpWSOB4NgtqeLGN8lpo7LRRPLwMV8XkQlfwkYJx+1qZPJZ41NwL
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A63232A6B8E9943819A79DEE15AE2DB@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeee8898-1c45-4cc2-29d3-08d838222cc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2020 02:57:50.3200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sv+if+tX4lvXSDPIwdAu8jgFSZ/JL7VC2cGjWRw1eOV4EBUTsrExpy6ELjLR1evj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3365
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-03_15:2020-08-03,2020-08-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 suspectscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008040022
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gQXVnIDMsIDIwMjAsIGF0IDY6NTYgUE0sIEFydmluZCBTYW5rYXIgPG5pdmVkaXRh
QGFsdW0ubWl0LmVkdT4gd3JvdGU6DQo+IA0KPiBPbiBNb24sIEF1ZyAwMywgMjAyMCBhdCAxMDo1
NTowMVBNICswMDAwLCBOaWNrIFRlcnJlbGwgd3JvdGU6DQo+PiANCj4+IA0KPj4+IE9uIEF1ZyAz
LCAyMDIwLCBhdCAyOjU3IFBNLCBBcnZpbmQgU2Fua2FyIDxuaXZlZGl0YUBhbHVtLm1pdC5lZHU+
IHdyb3RlOg0KPj4+IA0KPj4+IE9uIE1vbiwgQXVnIDAzLCAyMDIwIGF0IDEyOjQwOjIyUE0gLTA3
MDAsIE5pY2sgVGVycmVsbCB3cm90ZToNCj4+Pj4gRnJvbTogTmljayBUZXJyZWxsIDx0ZXJyZWxs
bkBmYi5jb20+DQo+Pj4+IA0KPj4+PiBUaGlzIHBhdGNoIHJlcGxhY2VzIGFsbCBtZW1jcHkoKSBj
YWxscyB3aXRoIExaNF9tZW1jcHkoKSB3aGljaCBjYWxscw0KPj4+PiBfX2J1aWx0aW5fbWVtY3B5
KCkgc28gdGhlIGNvbXBpbGVyIGNhbiBpbmxpbmUgaXQuDQo+Pj4+IA0KPj4+PiBMWjQgcmVsaWVz
IGhlYXZpbHkgb24gbWVtY3B5KCkgd2l0aCBhIGNvbnN0YW50IHNpemUgYmVpbmcgaW5saW5lZC4g
SW4NCj4+Pj4geDg2IGFuZCBpMzg2IHByZS1ib290IGVudmlyb25tZW50cyBtZW1jcHkoKSBjYW5u
b3QgYmUgaW5saW5lZCBiZWNhdXNlDQo+Pj4+IG1lbWNweSgpIGRvZXNuJ3QgZ2V0IGRlZmluZWQg
YXMgX19idWlsdGluX21lbWNweSgpLg0KPj4+PiANCj4+Pj4gQW4gZXF1aXZhbGVudCBwYXRjaCBo
YXMgYmVlbiBhcHBsaWVkIHVwc3RyZWFtIHNvIHRoYXQgdGhlIG5leHQgaW1wb3J0DQo+Pj4+IHdv
bid0IGxvc2UgdGhpcyBjaGFuZ2UgWzFdLg0KPj4+PiANCj4+Pj4gSSd2ZSBtZWFzdXJlZCB0aGUg
a2VybmVsIGRlY29tcHJlc3Npb24gc3BlZWQgdXNpbmcgUUVNVSBiZWZvcmUgYW5kIGFmdGVyDQo+
Pj4+IHRoaXMgcGF0Y2ggZm9yIHRoZSB4ODZfNjQgYW5kIGkzODYgYXJjaGl0ZWN0dXJlcy4gVGhl
IHNwZWVkLXVwIGlzIGFib3V0DQo+Pj4+IDEweCBhcyBzaG93biBiZWxvdy4NCj4+Pj4gDQo+Pj4+
IENvZGUJQXJjaAlLZXJuZWwgU2l6ZQlUaW1lCVNwZWVkDQo+Pj4+IHY1LjgJeDg2XzY0CTExNTA0
ODMyIEIJMTQ4IG1zCSA3OSBNQi9zDQo+Pj4+IHBhdGNoCXg4Nl82NAkxMTUwMzg3MiBCCSAxMyBt
cwk4ODUgTUIvcw0KPj4+PiB2NS44CWkzODYJIDk2MjEyMTYgQgkgOTEgbXMJMTA2IE1CL3MNCj4+
Pj4gcGF0Y2gJaTM4NgkgOTYyMDIyNCBCCSAxMCBtcwk5NjIgTUIvcw0KPj4+PiANCj4+Pj4gSSBh
bHNvIG1lYXN1cmVkIHRoZSB0aW1lIHRvIGRlY29tcHJlc3MgdGhlIGluaXRyYW1mcyBvbiB4ODZf
NjQsIGkzODYsDQo+Pj4+IGFuZCBhcm0uIEFsbCB0aHJlZSBzaG93IHRoZSBzYW1lIGRlY29tcHJl
c3Npb24gc3BlZWQgYmVmb3JlIGFuZCBhZnRlciwNCj4+Pj4gYXMgZXhwZWN0ZWQuDQo+Pj4+IA0K
Pj4+PiBbMV0gaHR0cHM6Ly9naXRodWIuY29tL2x6NC9sejQvcHVsbC84OTANCj4+Pj4gDQo+Pj4g
DQo+Pj4gSGkgTmljaywgd291bGQgeW91IGJlIGFibGUgdG8gdGVzdCB0aGUgYmVsb3cgcGF0Y2gn
cyBwZXJmb3JtYW5jZSB0bw0KPj4+IHZlcmlmeSBpdCBnaXZlcyB0aGUgc2FtZSBzcGVlZHVwPyBJ
dCByZW1vdmVzIHRoZSAjdW5kZWYgaW4gbWlzYy5jIHdoaWNoDQo+Pj4gY2F1c2VzIHRoZSBkZWNv
bXByZXNzb3JzIHRvIG5vdCB1c2UgdGhlIGJ1aWx0aW4gdmVyc2lvbi4gSXQgc2hvdWxkIGJlDQo+
Pj4gZXF1aXZhbGVudCB0byB5b3VycyBleGNlcHQgZm9yIGFwcGx5aW5nIGl0IHRvIGFsbCB0aGUg
ZGVjb21wcmVzc29ycy4NCj4+PiANCj4+PiBUaGFua3MuDQo+PiANCj4+IEkgd2lsbCBtZWFzdXJl
IGl0LiBJIHdvdWxkIGV4cGVjdCBpdCB0byBwcm92aWRlIHRoZSBzYW1lIHNwZWVkIHVwLiBJdCB3
b3VsZCBiZSBncmVhdCB0byBmaXgNCj4+IHRoZSBwcm9ibGVtIGZvciB4ODYvaTM4NiBpbiBnZW5l
cmFsLg0KPiANCj4gVGhhbmtzLiBJIHRyaWVkIHVzaW5nIFJEVFNDIHRvIGdldCBzb21lIHRpbWlu
Z3MgdW5kZXIgUUVNVSwgYW5kIEkgZ2V0DQo+IHNpbWlsYXIgc3BlZWR1cCBhcyB5b3UgaGF2ZSBm
b3IgTFo0LCBhbmQgYXJvdW5kIDE1LTIwJSBvciBzbyBmb3IgWlNURA0KPiAob24gNjQtYml0KQ0K
DQpCeSB0aGUgd2F5LCBJIHdhcyB1c2luZyB0aGlzIHNjcmlwdCBmb3IgcGVyZm9ybWFuY2UgdGVz
dGluZyBbMF0uDQoNCj4gLS0gSSBzZWUgdGhhdCBaU1REX2NvcHk4IGlzIGFscmVhZHkgdXNpbmcg
X19idWlsdGluX21lbWNweSwNCj4gYnV0IHRoZXJlIG11c3QgYmUgbW9yZSB0aGF0IGNhbiBiZSBv
cHRpbWl6ZWQ/IFRoZXJlJ3MgYSBjb3VwbGUgMS8yLWJ5dGUNCj4gc2l6ZWQgY29waWVzIGluIGh1
Zl9kZWNvbXByZXNzLmMuDQoNCk9oIHdvdywgSSB0b3RhbGx5IG1pc3NlZCB0aGF0LCBJIGd1ZXNz
IEkgc3RvcHBlZCBsb29raW5nIG9uY2UgcGVyZm9ybWFuY2UNCndhcyBhYm91dCB3aGF0IEkgZXhw
ZWN0ZWQsIG5pY2UgZmluZCENCg0KSSBzdXNwZWN0IGl0IGlzIG1vc3RseSB0aGUgbWVtY3B5IGlu
c2lkZSBvZiBIVUZfZGVjb2RlU3ltYm9sWDQoKSwgc2luY2UNCnRoYXQgc2hvdWxkIGJlIHRoZSBv
bmx5IGhvdCBvbmUgWzFdLg0KDQpEbyB5b3Ugd2FudCB0byBwdXQgdXAgdGhlIHBhdGNoIHRvIGZp
eCB0aGUgbWVtY3B54oCZcyBpbiB6c3RkIEh1ZmZtYW4sIG9yIHNob3VsZCBJPw0KDQpJIHdpbGwg
YmUgc3VibWl0dGluZyBhIHBhdGNoIHVwc3RyZWFtIHRvIG1pZ3JhdGUgYWxsIG9mIHpzdGTigJlz
IG1lbWNweSgpIGNhbGxzIHRvDQp1c2UgX19idWlsdGluX21lbWNweSgpLCBzaW5jZSBJIHBsYW4g
b24gdXBkYXRpbmcgdGhlIHZlcnNpb24gaW4gdGhlIGtlcm5lbCB0bw0KdXBzdHJlYW0genN0ZCBp
biB0aGUgbmV4dCBmZXcgbW9udGhzLiBJIHdhcyB3YWl0aW5nIHVudGlsIHRoZSBjb21wcmVzc2Vk
IGtlcm5lbA0KcGF0Y2ggc2V0IGxhbmRlZCwgc28gSSBkaWRuJ3QgZGlzdHJhY3QgZnJvbSBpdC4N
Cg0KWzBdIGh0dHBzOi8vZ2lzdC5naXRodWIuY29tL3RlcnJlbGxuLzliZDUzMzIxYTY2OWY2MjY4
M2M2MDhhZjg5NDRmYmMyDQpbMV0gaHR0cHM6Ly9naXRodWIuY29tL3RvcnZhbGRzL2xpbnV4L2Js
b2IvbWFzdGVyL2xpYi96c3RkL2h1Zl9kZWNvbXByZXNzLmMjTDU5OA0KDQpCZXN0LA0KTmljaw0K
DQo=
