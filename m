Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2E4C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AE92208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=trendmicro.com header.i=@trendmicro.com header.b="iw+c4pu/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730290AbgHZNgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:36:35 -0400
Received: from sjdcvmout02.udc.trendmicro.com ([66.180.82.11]:34316 "EHLO
        sjdcvmout02.udc.trendmicro.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730217AbgHZNge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 09:36:34 -0400
Received: from sjdcvmout02.udc.trendmicro.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A807264142;
        Wed, 26 Aug 2020 06:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=trendmicro.com;
        s=tmoutbound; t=1598448992;
        bh=iYIjbYEYGA3B8E0jHN+Y9hP2pOhtMVuT4KRsfVpsWtM=; h=From:To:Date;
        b=iw+c4pu/8HC6zlKcotKp7oqdvd1aZdrsTIEtH8M9xtlo1NtDn7N2NYRru5P83IVi0
         PWm/YUTcFHJBWkTiMbAnuPgYS3yuYTjLryVWoTms8J2cjlzcHeNGY1bl4pd54cnD5G
         ahWMofyDYd9jK/SPldIM+r1kilc+9dQDdXxFgz+c=
Received: from sjdcvmout02.udc.trendmicro.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A6D5640F7;
        Wed, 26 Aug 2020 06:36:32 -0700 (PDT)
Received: from SJDC-EXNABU01.us.trendnet.org (unknown [10.45.175.97])
        by sjdcvmout02.udc.trendmicro.com (Postfix) with ESMTPS;
        Wed, 26 Aug 2020 06:36:32 -0700 (PDT)
Received: from ADC-EXAPAC12.tw.trendnet.org (10.28.2.229) by
 SJDC-EXNABU01.us.trendnet.org (10.45.175.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1979.3; Wed, 26 Aug 2020 06:36:28 -0700
Received: from ADC-EXAPAC11.tw.trendnet.org (10.28.2.228) by
 ADC-EXAPAC12.tw.trendnet.org (10.28.2.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1979.3; Wed, 26 Aug 2020 13:36:15 +0000
Received: from ADC-EXAPAC11.tw.trendnet.org ([fe80::e9de:ebb1:bcf0:5913]) by
 ADC-EXAPAC11.tw.trendnet.org ([fe80::e9de:ebb1:bcf0:5913%18]) with mapi id
 15.01.1979.003; Wed, 26 Aug 2020 13:36:15 +0000
From:   "Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: x86/kprobes: kretprobe fails to triggered if kprobe at function
 entry is not optimized (trigger by int3 breakpoint)
Thread-Topic: x86/kprobes: kretprobe fails to triggered if kprobe at function
 entry is not optimized (trigger by int3 breakpoint)
Thread-Index: AdZ5/y9ucVi7Kf0NSwa8vnc6Q/ol0wAL6hEAAAENaQAAHQZRAAAMWPyAACXNoJAABJOdgAABikmAAAHiM4AAAOAdgAACKGhg
Date:   Wed, 26 Aug 2020 13:36:15 +0000
Message-ID: <42c65d9e434945c183ead8bef3d89de2@trendmicro.com>
References: <8816bdbbc55c4d2397e0b02aad2825d3@trendmicro.com>
 <20200825005426.f592075d13be740cb3c9aa77@kernel.org>
 <7396e7b2079644a6aafd9670a111232b@trendmicro.com>
 <20200825151538.f856d701a34f4e0561a64932@kernel.org>
 <20200825120911.GX1362448@hirez.programming.kicks-ass.net>
 <d3027772a6834f89a1ddc07c0fefaa0a@trendmicro.com>
 <20200826172239.ff175be78ee5f3a4380579c3@kernel.org>
 <20200826180645.9b609fc05df2a149564df1b8@kernel.org>
 <20200826190041.2d0ff0fbe154ba62163b0c00@kernel.org>
 <20200826102545.GF1362448@hirez.programming.kicks-ass.net>
In-Reply-To: <20200826102545.GF1362448@hirez.programming.kicks-ass.net>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.28.4.6]
X-TM-AS-Product-Ver: IMSVA-9.1.0.1960-8.6.0.1013-25626.007
X-TM-AS-Result: No--29.835-5.0-31-10
X-TMASE-MatchedRID: Nu4omozL6aLUL3YCMmnG4vHkpkyUphL9Ud7Bjfo+5jRd964B0EJ1lSio
        vVyGVXbFKmeI7ghTOjcXjjynQV89QI3sS3MVuiP/X1J8nCIowYDdXhRKGhNdp+jnKWtZ9LTLoML
        A09Q7YQVlfORP6fQwh1E3gGKuv1qSGcUcwv8O6FRFM72aEhcbjUzzNX6FuGYD5wA4LRxAiq/v8k
        ZFnw+AJ30h0t4LRJU4RwWmLxdIcSgXgBGQGIGL/vRUId35VCIeB5sxzt03wPgUZ5IS2TgivZlZS
        zHeHjGRunnGSiVNIJ9aHQACyuJADmNz5op/462xlxI7MMLiequsxB8h8Z7XRha1b8SJLTWfqCgi
        pHiRLo7ejnZr6Lh3iyGqq99jJVWlQo+W44QpPf83X0+M8lqGUmru/VhgywnpDO+DX+rUwfZYerV
        ulKHl4guUBPzAgA1JZwwPubhdqok4LhgP3hW5wO9VsdrlGzy3mHAp2UJ8+TybKItl61J/yfmS+a
        Pr0Ve8WhMF7hZwoTHkwjHXXC/4I+JGF26G8SWy5yM0c1ktj9M=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--29.835300-10.000000
X-TMASE-Version: IMSVA-9.1.0.1960-8.6.1013-25626.007
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-SNTS-SMTP: B3A37DDF16EDA88C1F8E1A494924CC34B1826E36B5548708DA01140964237D092000:8
X-TM-AS-GCONF: 00
X-imss-scan-details: No--29.835-5.0-31-10
X-TMASE-SNAP-Result: 1.821001.0001-0-1-12:0,22:0,33:0,34:0-0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogcGV0ZXJ6QGluZnJhZGVh
ZC5vcmcgPHBldGVyekBpbmZyYWRlYWQub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIEF1Z3VzdCAy
NiwgMjAyMCA2OjI2IFBNDQo+IFRvOiBNYXNhbWkgSGlyYW1hdHN1IDxtaGlyYW1hdEBrZXJuZWwu
b3JnPg0KPiBDYzogRWRkeSBXdSAoUkQtVFcpIDxFZGR5X1d1QHRyZW5kbWljcm8uY29tPjsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgeDg2QGtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6
IHg4Ni9rcHJvYmVzOiBrcmV0cHJvYmUgZmFpbHMgdG8gdHJpZ2dlcmVkIGlmIGtwcm9iZSBhdCBm
dW5jdGlvbiBlbnRyeSBpcyBub3Qgb3B0aW1pemVkICh0cmlnZ2VyIGJ5IGludDMgYnJlYWtwb2lu
dCkNCj4NCj4gT24gV2VkLCBBdWcgMjYsIDIwMjAgYXQgMDc6MDA6NDFQTSArMDkwMCwgTWFzYW1p
IEhpcmFtYXRzdSB3cm90ZToNCj4gPiBPZiBjb3Vyc2UsIHRoaXMgZG9lc24ndCBzb2x2ZSB0aGUg
bGxpc3RfZGVsX2ZpcnN0KCkgY29udGVudGlvbiBpbiB0aGUNCj4gPiBwcmVfa3JldHByb2JlX2hh
bmRsZXIoKS4gU28gYW55d2F5IHdlIG5lZWQgYSBsb2NrIGZvciBwZXItcHJvYmUgbGxpc3QNCj4g
PiAoaWYgSSB1bmRlcnN0YW5kIGxsaXN0LmggY29tbWVudCBjb3JyZWN0bHkuKQ0KPg0KPiBCYWgs
IGxlbW1lIHRoaW5rIGFib3V0IHRoYXQuIEtwcm9iZXMgcmVhbGx5IHNob3VsZG4ndCBiZSB1c2lu
ZyBsb2NrcyA6Lw0KDQpNYXliZSB3ZSBjYW4gaGF2ZSBwZXItY3B1IGZyZWUgbGlzdCBmb3IgcmV0
cHJvYmVfaW5zdGFuY2U/DQpUaGlzIGVuc3VyZSB3ZSBvbmx5IGhhdmUgb25lIHVzZXIgcmVxdWVz
dGluZyBmcmVlIGluc3RhbmNlIGF0IGEgdGltZSwgZ2l2ZW4gdGhhdCBwcmVfa3JldHByb2JlX2hh
bmRsZXIoKSB3b250IHJlY3Vyc2l2ZS4NCg0KV2UgbWF5IGJlIHdhc3RpbmcgbWVtb3J5IGlmIHRh
cmdldCBmdW5jdGlvbiBwZXJmZXIgc29tZSBjcHUgdGhvdWdoLg0KDQoNClRSRU5EIE1JQ1JPIEVN
QUlMIE5PVElDRQ0KDQpUaGUgaW5mb3JtYXRpb24gY29udGFpbmVkIGluIHRoaXMgZW1haWwgYW5k
IGFueSBhdHRhY2htZW50cyBpcyBjb25maWRlbnRpYWwgYW5kIG1heSBiZSBzdWJqZWN0IHRvIGNv
cHlyaWdodCBvciBvdGhlciBpbnRlbGxlY3R1YWwgcHJvcGVydHkgcHJvdGVjdGlvbi4gSWYgeW91
IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgeW91IGFyZSBub3QgYXV0aG9yaXplZCB0
byB1c2Ugb3IgZGlzY2xvc2UgdGhpcyBpbmZvcm1hdGlvbiwgYW5kIHdlIHJlcXVlc3QgdGhhdCB5
b3Ugbm90aWZ5IHVzIGJ5IHJlcGx5IG1haWwgb3IgdGVsZXBob25lIGFuZCBkZWxldGUgdGhlIG9y
aWdpbmFsIG1lc3NhZ2UgZnJvbSB5b3VyIG1haWwgc3lzdGVtLg0KDQpGb3IgZGV0YWlscyBhYm91
dCB3aGF0IHBlcnNvbmFsIGluZm9ybWF0aW9uIHdlIGNvbGxlY3QgYW5kIHdoeSwgcGxlYXNlIHNl
ZSBvdXIgUHJpdmFjeSBOb3RpY2Ugb24gb3VyIHdlYnNpdGUgYXQ6IFJlYWQgcHJpdmFjeSBwb2xp
Y3k8aHR0cDovL3d3dy50cmVuZG1pY3JvLmNvbS9wcml2YWN5Pg0K
