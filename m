Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06101C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 08:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9E0820707
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 08:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="g7eRtMGT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgHZIfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 04:35:00 -0400
Received: from mail-bn8nam12on2081.outbound.protection.outlook.com ([40.107.237.81]:32736
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727000AbgHZIe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 04:34:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oaVatF7+3bCX5I5h3OdyWdd8pfhoTkmFIpwPqhIIqnTq3bsrDQ+tXzoTOxNjybU9JEND6mfBGA+VhyKygo/E06aqjR5EWMwLbXdFzu1RvdbRu1g56G6s9cO8/BPrIUxk20GEs3BopTbBLQL3WdUIL9NwG/8yh3iwyC4gj3CqKKaIShkUTFH8NZGHoR7xGt+FIKKqXn7fbDnWaqDzWLOprczaeR7SssT5YX1z/SSvkJBqC8NZJ8q/vorhwFM0WJqcrocvdj4Di7H4yQ+DJXeR6dkaxeo6i+03ZhvqjjG5YTlzUtS/vYwJS9+GR2enTdbCzKCLfmw5PUEXoCImqDpung==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShqKvVbb7zTzhDwFO0DTLzvEcRJSvM1l7NpvZqOQEHk=;
 b=KNtKU3r1zgAKQavy12hRCXhRP5Cyumr+u8cfj9VDjX+3u1YbgU//q8yCAgr3pFoCr2Ssf1nXETCrJdsFXTj4fxe9dgdcHKFa74WKRMnX13u1B9wS0D2Dj3/xeLN3hJdVIKa1lVoQvOEsNaVWYdM1Natzeqfkfr5alIQ2rxsmSDkh7bLIdFbC5qZ4q4Xgwv6cMNLiWWKHGwXL9DnjH9KvY7OmzRUf7/wTGkbtH9hRVxEL2X7whWXFRSaUhD3SV4g9rMj6p9rcUOQ5ZltPt/a90zbV45r00IJ+TrCrJO35tqnCVow6qoQ/w3xwxiVk8Etf0JE5ruoeg/Xd0wu7yEgCag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShqKvVbb7zTzhDwFO0DTLzvEcRJSvM1l7NpvZqOQEHk=;
 b=g7eRtMGTLyNtzKNthmiGZH5/yp2oMgZeJvaMNsEJu6nYA5e65jUZ5a870GOE2kPDqJjE3rrL8D9Esj4IyWDVTvhVq9t+LlcIMtopyCzZqONjbo5AysBqD9+ztVduwKBvhlJUW33twhfIYTaH4lXjbgfJ3EtP17gRxiuSiXYs4b4=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB2533.namprd11.prod.outlook.com (2603:10b6:a02:c8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Wed, 26 Aug
 2020 08:34:52 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::d87a:b368:655c:e12b]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::d87a:b368:655c:e12b%7]) with mapi id 15.20.3305.032; Wed, 26 Aug 2020
 08:34:51 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        "elver@google.com" <elver@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: =?gb2312?B?u9i4tDogu9i4tDogW1BBVENIXSBkZWJ1Z29iamVjdHM6IGluc3RhbGwgY3B1?=
 =?gb2312?Q?_hotplug_callback?=
Thread-Topic: =?gb2312?B?u9i4tDogW1BBVENIXSBkZWJ1Z29iamVjdHM6IGluc3RhbGwgY3B1IGhvdHBs?=
 =?gb2312?Q?ug_callback?=
Thread-Index: AQHWdqGQIvF/RGEPjEiN5JxhAX5OO6lISeXKgAEmZYCAABgygIAAjcfc
Date:   Wed, 26 Aug 2020 08:34:51 +0000
Message-ID: <BYAPR11MB2632ABDD5A8334F74B4F539AFF540@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <20200820032453.5222-1-qiang.zhang@windriver.com>
 <BYAPR11MB263237C2A74C32CC14DD0F2EFF570@BYAPR11MB2632.namprd11.prod.outlook.com>
 <e75c1601-b466-8476-f75b-514b1c21646e@redhat.com>,<87pn7ewae6.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87pn7ewae6.fsf@nanos.tec.linutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14ff5f31-815f-4027-b2e2-08d8499ae6ce
x-ms-traffictypediagnostic: BYAPR11MB2533:
x-microsoft-antispam-prvs: <BYAPR11MB2533CBB6F90B0B6949EC92BBFF540@BYAPR11MB2533.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2u1LSq9F7kwwYMjCWJxLzBO605nLneUT8zKfa8seAwA+JBLNX9Y+qk6Izn8Ty/Wazc+zKZ0ZWe8NNJ6EvUkEN+hY/a4NbLDMpvgpxaH4EvbjGURvi+Bgji15NRIlT41lFASwQp66NA4lGkUIqBfXUUPph9J/6xbkMbQeD/hE2/Ap1YUF5fxfdPsLXRKa0NzaMlWX9cTXMibW+Iy7bugk8z82FeciBRLFgyDVvnn6GonywHY1tZyAX8epJpkcJJrTW45F9LdFPeeEug8Z+4ZaRCG/eci69twJPx/LuwfRZhX32VA+9W1voby1uAicpvDmPSS8WDBfpmzFcwepBsNl4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(346002)(366004)(396003)(136003)(376002)(52536014)(224303003)(110136005)(54906003)(33656002)(91956017)(71200400001)(76116006)(5660300002)(316002)(86362001)(66446008)(8936002)(83380400001)(66946007)(66476007)(66556008)(64756008)(55016002)(9686003)(478600001)(4326008)(2906002)(6506007)(26005)(53546011)(186003)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ymS/Uaaaptq1+nrNOHlZnujmXhnP7G7pr//C7I42CX6M6QE9ORH9AmRfuXGzQjME3V/sYbE2iqoX4P3GuzpiSQsqj7gf/IS3eMOAIIHf5A8Awuc+vNOy3FHlEM/1mH4Mq5M2z/s4uEp5faSWlrwBx7SKS2ZIBTuPoHM2IgAq1UkkOo0w5YJ5otJz0JiBfLi0wxaO7Yh+6Vj4B2uNJyENEOYFlrLxy5c1XH5et07cpRHpAhIByNeIgHat3IIqOAJaKIo7aA77IdbGrhgJv9kC4ohjbhlj6ZmyKwcFzhS/Yq6pPnqoXEJzGmKYVv7NNvnTHRaHoartMR2m/DCFhjMIDSfvn8TWkKbHnlwLPCyqIxIKqHIy3EGxMwN8BCbtAFdmzrpklyqzs7cH8eZOPYMxi+YLMJswMizPlQGQ0zdIXTuAFRyyCSdhUmhO823tf4LBtWyGl7nQgUqcc6eZr7S/hBk0Z2VFOzDdyEkFo0OaaLYR4edpHE1shraM30Klv7Gx4nBNXROpDs6ijQ/MFPCH6HW7ZO4Q4hA1WnXmnp1lCTpM1kAhoNZ7XNRYIoKTmjjCziQGKBQ75xt9UCGzK6LlqaNZeQMdbWrUM7KwAezebTcms21MdSp0bc0NloWdZdKanFlMA1SBrd6D0ZFOnyoF2A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ff5f31-815f-4027-b2e2-08d8499ae6ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2020 08:34:51.7413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FdqHlXs6KvJjwaTwkfDN/mDQxFRsFojInc0djN0ya8gLwLKA3IlOQAqlnmkB3qYttxlBREK1KGIGXe8ZNbGktU7AR52slKQlDWoijSoMteM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2533
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCreivP7IyzogbGludXgt
a2VybmVsLW93bmVyQHZnZXIua2VybmVsLm9yZyA8bGludXgta2VybmVsLW93bmVyQHZnZXIua2Vy
bmVsLm9yZz4gtPqx7SBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4Kt6LLzcqx
vOQ6IDIwMjDE6jjUwjI2yNUgNzo1MwrK1bz+yMs6IFdhaW1hbiBMb25nOyBaaGFuZywgUWlhbmc7
IGVsdmVyQGdvb2dsZS5jb20Ks63LzTogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgYWtw
bUBsaW51eC1mb3VuZGF0aW9uLm9yZwrW98ziOiBSZTogu9i4tDogW1BBVENIXSBkZWJ1Z29iamVj
dHM6IGluc3RhbGwgY3B1IGhvdHBsdWcgY2FsbGJhY2sKCk9uIFR1ZSwgQXVnIDI1IDIwMjAgYXQg
MTg6MjYsIFdhaW1hbiBMb25nIHdyb3RlOgo+IE9uIDgvMjUvMjAgMTI6NTMgQU0sIFpoYW5nLCBR
aWFuZyB3cm90ZToKPj4KPj4gV2hlbiBhIGNwdSBnb2luZyBvZmZsaW5lLCB3ZSBzaG91bGQgZnJl
ZSBvYmplY3RzIGluICJwZXJjcHVfb2JqX3Bvb2wiCj4+IGZyZWVfb2JqcyBsaXN0IHdoaWNoIGNv
cnJlc3BvbmRpbmcgdG8gdGhpcyBjcHUuCj4KPiBUaGUgcGVyY3B1IGZyZWUgb2JqZWN0IHBvb2wg
aXMgc3VwcG9zZWQgdG8gYmUgYWNjZXNzZWQgb25seSBieSB0aGF0Cj4gcGFydGljdWxhciBjcHUg
d2l0aG91dCBhbnkgbG9jay4gVHJ5aW5nIHRvIGFjY2VzcyBpdCBmcm9tIGFub3RoZXIgY3B1Cj4g
Y2FuIGNhdXNlIGEgcmFjZSBjb25kaXRpb24gdW5sZXNzIG9uZSBjYW4gbWFrZSBzdXJlIHRoYXQg
dGhlIG9mZmxpbmUgY3B1Cj4gd29uJ3QgYmVjb21lIG9ubGluZSBpbiB0aGUgbWVhbiB0aW1lLgoK
Pkl0IGlzIGFjdHVhbGx5IHNhZmUgYmVjYXVzZSBDUFUgaG90cGx1ZyBpcyBnbG9iYWxseSBzZXJp
YWxpemVkIGFuZCB0aGVyZQo+aXMgbm8gd2F5IHRoYXQgYW4gb2ZmbGluZSBDUFUgd2lsbCBjb21l
IGJhY2sgZnJvbSBkZWF0aCB2YWxsZXkKPm1hZ2ljYWxseS4gSWYgc3VjaCBhIHpvbWJpZSBldmVy
IHN1cmZhY2VzIHRoZW4gd2UgaGF2ZSBzdXJlbHkgbW9yZQo+c2VyaW91cyBwcm9ibGVtcyB0aGFu
IGFjY2Vzc2luZyB0aGF0IHBvb2wgOikKCj4gVGhlcmUgc2hvdWxkbid0IGJlIHRvbyBtYW55IGZy
ZWUgb2JqZWN0cyBpbiB0aGUgcGVyY3B1IHBvb2wuIElzIGl0Cj4gd29ydGggdGhlIGVmZm9ydCB0
byBmcmVlIHRoZW0/Cgo+VGhhdCdzIGEgcmVhbGx5IGdvb2QgcXVlc3Rpb24gbmV2ZXJ0aGVsZXNz
LiBUaGUgb25seSBjYXNlIHdoZXJlIHRoaXMKPmV2ZXIgbWF0dGVycyBpcyBwaHlzaWNhbCBob3Rw
bHVnLiBBbGwgb3RoZXIgQ1BVIGhvdHBsdWcgc3R1ZmYgaXMKPnRlbXBvcmFyaWx5IG9yIGluIGNh
c2Ugb2YgYSBsYXRlIChwb3N0IGJvb3R0aW1lKSBTTVQgZGlzYWJsZSBpdCdzIGdvaW5nCj50byBi
ZSBhIGhhbmRmdWwgb2YgZnJlZSBvYmplY3RzIG9uIHRoYXQgcG9vbC4gQXMgZGVidWdvYmplY3Rz
IGlzIGFzIHRoZQo+bmFtZSBzYXlzIGEgZGVidWcgZmFjaWxpdHkgdGhlIGJlbmVmaXQgaXMgcXVl
c3Rpb25hYmxlIHVubGVzcyB0aGVyZSBpcyBhCj5nb29kIHJlYXNvbiB0byBkbyBzby4KCiBJIGRv
bid0IGtub3cgIHRoZXJlIG1heSBub3QgYmUgdG9vIG1hbnkgb2JqZWN0cyAgaW4gdGhlIHBlcmNw
dSBwb29sLAogYnV0IHRoYXQgZG9lc24ndCBtZWFuIHRoZXkgbm8gbmVlZCB0byBiZSBmcmVlLCBh
IENQVSBtYXkgbmV2ZXIgYmUgb25saW5lIGFmdGVyIGl0IGlzIG9mZmxpbmUuIHNvbWUgb2JqZWN0
cyBpbiBwZXJjcHUgcG9vbCBpcyBuZXZlciBmcmVlLgoKCgo+VGhhbmtzLAoKICA+ICAgICAgdGds
eAoKCg==
