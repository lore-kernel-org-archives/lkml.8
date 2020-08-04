Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BE4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 17:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94A5A20722
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 17:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="lroah/XM";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="NpI90acl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbgHDRUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 13:20:12 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:9440 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729472AbgHDRUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 13:20:10 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 074HH3Jc021493;
        Tue, 4 Aug 2020 10:19:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=7ivx91Alg3iV+dCqP7SNYKiZA9m9jw6WSoIjVNLUxzI=;
 b=lroah/XMhH+0DjQaWMzkUf0ZNKBTpTB8anS0XtKj+WKtY+qHvHdPV69bgld9yrMjs/LZ
 1HGh/EjU8xVSpJQcteoQmgrPpE98zMKGD7qfKaIMaTJmZeWQLPpBi66Uwa9B9+2q4qVh
 8fnN6nP0Gj5kWkAxZ8Rxd34+gO6PDbxYKM0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32nr3c3913-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 04 Aug 2020 10:19:14 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 4 Aug 2020 10:18:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTiOvMzqr8thmt8vCiPj1u543F8dHRw7e9pUz/tbOWHEDfoBxOtbGrnl2b3szdcMHiEAZ0YLLB1LKhqIYGXIdg0AgbFdzw+8uiJpp4NEwO9op8hcuzs5XoNwK1gwxA25pi1b2x0vQyLMdYgNXKv+hYBU/Y/yapWAwL65834umda/qybAzycrRKCs2TRdCjIa0LnNvCAhta1/Ful+oDaVM/upqC7vUWrxYsdbbMuBaIv3UrdaHIcWjIhpdIosR/WDFLnVsM2xZ/dbyNLcjPh5ilOz9CpGN2PIRK4q4Dj8G5I6OtEwhARcDG+/kotRrxHruICBqEV37t/HIT7EZIyjmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ivx91Alg3iV+dCqP7SNYKiZA9m9jw6WSoIjVNLUxzI=;
 b=iRy9mTzCE7u5UegFTeKSPM51AsqYbHnoPG113xQ0SMe4nR5iUrvfb43RE3SXac++yBdjt/xMvm+L4AwGHeeFyrSS0CC9xdNpusjOOt4SHaBc92U4obwwg8Z3+s8JXlM7ttlgIiw7cp8mXWTEG8c1gxtv34ftdRG4HnJM17RVb6doWvC5H7tp9X/jIjuoQcwVIbxaBca1W6LqVFpcqhEzZ6yDtSIafIti5TY6iY6iVORSpJiyUzQtZkY5NNaTanODs5XAHeE9goAYxUFRLDQu8yvWTbZO+xtz1CICGdzkDUF5M1DjvCXFjIYHTsubz4/Yf+zoaFlF7eGGY8jGgorkMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ivx91Alg3iV+dCqP7SNYKiZA9m9jw6WSoIjVNLUxzI=;
 b=NpI90acl+4fc53CymViRr3WvdOttK6ocKmvUOH4erqA6dOQNtg9T2A6bVhqLzkG68sLZ9hVJh96rN0eWUwd6AC0/wE8zRDSvoRXAkXaIJV3XTGRv9aMPQOo7hZGW3JhBLC6mIlT328/cUkS8fZnMwtdlIw/BkQW74TN4ADQyqP8=
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by BYAPR15MB3094.namprd15.prod.outlook.com (2603:10b6:a03:ff::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Tue, 4 Aug
 2020 17:18:55 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::f4b9:8011:9aaa:e4ea]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::f4b9:8011:9aaa:e4ea%3]) with mapi id 15.20.3239.022; Tue, 4 Aug 2020
 17:18:55 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
CC:     Pavel Machek <pavel@denx.de>,
        Nick Terrell <nickrterrell@gmail.com>,
        "Ingo Molnar" <mingo@kernel.org>,
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
Thread-Index: AQHWac5eBX2DbmatdkS0UNeom8wg5qkm7qKAgAAP/ACAAKFhAIAAcPYAgAAiF4A=
Date:   Tue, 4 Aug 2020 17:18:55 +0000
Message-ID: <BA4151A3-83AB-4481-8A89-D9B645578995@fb.com>
References: <20200803194022.2966806-1-nickrterrell@gmail.com>
 <20200803215747.GA1644409@rani.riverdale.lan>
 <3961E1BD-8F58-4240-A3B3-B7032A405B42@fb.com>
 <20200804083236.zjkmfer37z5rn3r4@duo.ucw.cz>
 <20200804151654.GA2326348@rani.riverdale.lan>
In-Reply-To: <20200804151654.GA2326348@rani.riverdale.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: alum.mit.edu; dkim=none (message not signed)
 header.d=none;alum.mit.edu; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:9999]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28d0cdea-31a3-4d2e-2e58-08d8389a77d7
x-ms-traffictypediagnostic: BYAPR15MB3094:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB3094765F2F33BB423AF04C1BAB4A0@BYAPR15MB3094.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NTep1UYMdaxl+oozkszYRQDPL0P5faSOyXfSn9i17CC3FS5ShE/J8gp86t8/CJo1zw4hN8+bDXnqjOdLflYEjyyJ1B4ck57W+EkGTf7fTryd2e7mrDCkownQigvRal56nWJJmimKgMSxdSV3cWd6VHGIU2pVuBh3EJoYfhcd/ae33Z1/dawv+2RH+bOUWcTzZXalXBJS/LwgbmQ3kdOLineng/diYz3hWSKrplyqWKFbsJYjg5mQsv0YNF/+fnUIQrfow/inDDEczjOVAghs+DZDVMJthtp+pG0orNN7//+4Ir8qKSFHUJ5bzy8/N5iOSpBNSYQZMTclEHA/j6bNwX1BUW5vf8WYEW4mo/Z3a5s1FZI8yOw6lBi4leuJ8wHmo2ihfCD+ioSdID6JZPvOtQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(396003)(346002)(376002)(39860400002)(136003)(6486002)(2616005)(6916009)(4326008)(36756003)(33656002)(6506007)(2906002)(86362001)(53546011)(71200400001)(966005)(6512007)(76116006)(83380400001)(5660300002)(8676002)(66556008)(66476007)(64756008)(316002)(66946007)(54906003)(8936002)(478600001)(7416002)(66446008)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: fcNqZHXiSezrNr7yKcyEJxYohMUSE1YMKpITyOw5vQ6didnBXoybkzJteMKoPyhiCDu0jbDoy+xnBPEVcy/AlyK6xNWOvfuXmxRY9DO1P0sxFzkpyV67oPup/q9m0roJ5Fpfqc8c5jXV1XX/fdSFLJT4YB1KaZ1/XlbVGqT0Qg0J+W5cZqyUMgJqYWXpXFRGKkOmYddo1ft/WHQ9rUFrPVx9OJr0tTF3EKtPazvYaRhPdo7DRjRSIVGzNnWOBRvuH0wVV14NTIV/GFanRyFdb1LlS/UkbyxIRd49zGEY21stWxKwfn3i1wzigQ97VJjY1jZ6YJjYneI3saWnweQNlqkEEpySMVLAxrthGwrJ+5pGHE4oaDFzYgxIm4NM5B5PZwm9EcoQj08sccpwe57kDdEAYVxj7t3eJ9g97Iz04S4ucM0Tbss0NbYDBlrmYgjZbNbW6lI8hmhD3+3M/lLVQ7dnFcS0ddWVWbOe/sNRiPp8Uwsw4bGou55XmQc4tOUV/JTMTF2UFX6WUsDlLQVUSL0mMps1HAOP234BqJyy0Kl3ke76cj0J/gsnfHGTFR8RgGmNYXv7rcIM/UIlgPdH0cy16P/sCnyJd/Uwed5VWey1peCZjJt9+/dLP+qBJVfG0fIwCkt9u5JVIIurOXAgj7r2XH4byIHR1sHgZYzI3mBJoUkS46K9ou6pIKHTWEEt
Content-Type: text/plain; charset="utf-8"
Content-ID: <D33A248AA609874398D1A96E992F6896@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d0cdea-31a3-4d2e-2e58-08d8389a77d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2020 17:18:55.9115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KQqcd94emfFrOR+17gqz+E/gOX3hJsbjvmvkCVe6Vyf/kSV4Mk5XIFy8wCLsW5bH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3094
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-04_04:2020-08-03,2020-08-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 suspectscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1011 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008040128
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gQXVnIDQsIDIwMjAsIGF0IDg6MTYgQU0sIEFydmluZCBTYW5rYXIgPG5pdmVkaXRh
QGFsdW0ubWl0LmVkdT4gd3JvdGU6DQo+IA0KPiBPbiBUdWUsIEF1ZyAwNCwgMjAyMCBhdCAxMDoz
MjozNkFNICswMjAwLCBQYXZlbCBNYWNoZWsgd3JvdGU6DQo+PiBIaSENCj4+IA0KPj4+Pj4gSSd2
ZSBtZWFzdXJlZCB0aGUga2VybmVsIGRlY29tcHJlc3Npb24gc3BlZWQgdXNpbmcgUUVNVSBiZWZv
cmUgYW5kIGFmdGVyDQo+Pj4+PiB0aGlzIHBhdGNoIGZvciB0aGUgeDg2XzY0IGFuZCBpMzg2IGFy
Y2hpdGVjdHVyZXMuIFRoZSBzcGVlZC11cCBpcyBhYm91dA0KPj4+Pj4gMTB4IGFzIHNob3duIGJl
bG93Lg0KPj4+Pj4gDQo+Pj4+PiBDb2RlCUFyY2gJS2VybmVsIFNpemUJVGltZQlTcGVlZA0KPj4+
Pj4gdjUuOAl4ODZfNjQJMTE1MDQ4MzIgQgkxNDggbXMJIDc5IE1CL3MNCj4+Pj4+IHBhdGNoCXg4
Nl82NAkxMTUwMzg3MiBCCSAxMyBtcwk4ODUgTUIvcw0KPj4+Pj4gdjUuOAlpMzg2CSA5NjIxMjE2
IEIJIDkxIG1zCTEwNiBNQi9zDQo+Pj4+PiBwYXRjaAlpMzg2CSA5NjIwMjI0IEIJIDEwIG1zCTk2
MiBNQi9zDQo+Pj4+PiANCj4+Pj4+IEkgYWxzbyBtZWFzdXJlZCB0aGUgdGltZSB0byBkZWNvbXBy
ZXNzIHRoZSBpbml0cmFtZnMgb24geDg2XzY0LCBpMzg2LA0KPj4+Pj4gYW5kIGFybS4gQWxsIHRo
cmVlIHNob3cgdGhlIHNhbWUgZGVjb21wcmVzc2lvbiBzcGVlZCBiZWZvcmUgYW5kIGFmdGVyLA0K
Pj4+Pj4gYXMgZXhwZWN0ZWQuDQo+Pj4+PiANCj4+Pj4+IFsxXSBodHRwczovL2dpdGh1Yi5jb20v
bHo0L2x6NC9wdWxsLzg5MA0KPj4+Pj4gDQo+Pj4+IA0KPj4+PiBIaSBOaWNrLCB3b3VsZCB5b3Ug
YmUgYWJsZSB0byB0ZXN0IHRoZSBiZWxvdyBwYXRjaCdzIHBlcmZvcm1hbmNlIHRvDQo+Pj4+IHZl
cmlmeSBpdCBnaXZlcyB0aGUgc2FtZSBzcGVlZHVwPyBJdCByZW1vdmVzIHRoZSAjdW5kZWYgaW4g
bWlzYy5jIHdoaWNoDQo+Pj4+IGNhdXNlcyB0aGUgZGVjb21wcmVzc29ycyB0byBub3QgdXNlIHRo
ZSBidWlsdGluIHZlcnNpb24uIEl0IHNob3VsZCBiZQ0KPj4+PiBlcXVpdmFsZW50IHRvIHlvdXJz
IGV4Y2VwdCBmb3IgYXBwbHlpbmcgaXQgdG8gYWxsIHRoZSBkZWNvbXByZXNzb3JzLg0KPj4+PiAN
Cj4+Pj4gVGhhbmtzLg0KPj4+IA0KPj4+IEkgd2lsbCBtZWFzdXJlIGl0LiBJIHdvdWxkIGV4cGVj
dCBpdCB0byBwcm92aWRlIHRoZSBzYW1lIHNwZWVkIHVwLiBJdCB3b3VsZCBiZSBncmVhdCB0byBm
aXgNCj4+PiB0aGUgcHJvYmxlbSBmb3IgeDg2L2kzODYgaW4gZ2VuZXJhbC4NCj4+PiANCj4+PiBC
dXQsIEkgYmVsaWV2ZSB0aGF0IHRoaXMgaXMgYWxzbyBhIHByb2JsZW0gZm9yIEFSTSwgdGhvdWdo
IEkgaGF2ZSBhIGhhcmQgdGltZSBtZWFzdXJpbmcNCj4+PiBiZWNhdXNlIEkgY2Fu4oCZdCBnZXQg
cHJlLWJvb3QgcHJpbnQgc3RhdGVtZW50cyBpbiBRRU1VLiBJIHdpbGwgYXR0ZW1wdCB0byB0YWtl
IGEgbG9vayBhdCB0aGUNCj4+PiBhc3NlbWJseSwgYmVjYXVzZSBJ4oCZbSBmYWlybHkgY2VydGFp
biB0aGF0IG1lbWNweSgpIGlzbuKAmXQgaW5saW5lZCBpbiBtYXN0ZXIuDQo+Pj4gDQo+Pj4gRXZl
biBpZiB3ZSBmaXggYWxsIHRoZSBhcmNoaXRlY3R1cmVzLCBJIHdvdWxkIHN0aWxsIGxpa2UgdG8g
bWVyZ2UgdGhlIExaNCBwYXRjaC4gSXQgc2VlbXMgbGlrZSBpdA0KPj4+IGlzIHByZXR0eSBlYXN5
IHRvIG1lcmdlIGEgcGF0Y2ggdGhhdCBpcyBhIGJvb3Qgc3BlZWQgcmVncmVzc2lvbiwgYmVjYXVz
ZSBwZW9wbGUgYXJlbuKAmXQNCj4+PiBhY3RpdmVseSBtZWFzdXJpbmcgaXQuIFNvIEkgcHJlZmVy
IGEgbGF5ZXJlZCBkZWZlbnNlLg0KPj4gDQo+PiANCj4+IExheWVyZWQgZGVmZW5zZSBhZ2FpbnN0
IHBlcmZvcm1hbmNlLW9ubHkgcHJvYmxlbSwgaGFwcGVuaW5nIG9uDQo+PiBlbXVsYXRpb24tb25s
eT8NCj4+IA0KPj4gSU1PIHRoYXQncyBhIGJpdCBvZiBvdmVya2lsbC4NCj4gDQo+IFdoeSB3b3Vs
ZCBpdCBiZSBlbXVsYXRpb24tb25seT8gUUVNVSBpcyBqdXN0IGJlaW5nIHVzZWQgZm9yIGVhc2Ug
b2YNCj4gdGVzdGluZywgYnV0IHRoZSBwZXJmb3JtYW5jZSBpbXBhY3Qgc2hvdWxkIGJlIHNpbWls
YXIgb24gYmFyZSBtZXRhbC4NCg0KSW4gYWRkaXRpb24sIEkgd2FudCB0aGUgZGVjb21wcmVzc29y
cyB0byBiZSBmYXN0IGluIHRoZSBwcmUtYm9vdCBmb3IgYWxsDQphcmNoaXRlY3R1cmVzLiBOb3Qg
ZXZlcnlvbmUgaXMgZ29pbmcgdG8ga25vdyB0aGF0IHpzdGQgYW5kIGx6NCByZXF1aXJlDQptZW1j
cHkgdG8gYmUgaW5saW5lZCBvciB0aGV5IGFyZSAxMHggc2xvd2VyLCB0aGF0IGlzIGFuIGltcGxl
bWVudGF0aW9uDQpkZXRhaWwgb2YgdGhlIGxpYnJhcnkuIEl0IGlzIGEgcGVyZm9ybWFuY2UgZ290
Y2hhIHRoYXQgSeKAmWQgcmF0aGVyIG5vdCBoYXZlLg0KDQo=
