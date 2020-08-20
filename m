Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42626C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 02:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F3582078D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 02:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgHTCq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 22:46:57 -0400
Received: from cnshjsmin05.nokia-sbell.com ([116.246.26.45]:50224 "EHLO
        CNSHJSMIN05.NOKIA-SBELL.COM" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726362AbgHTCq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 22:46:56 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Aug 2020 22:46:53 EDT
X-AuditID: ac18929d-5fdff70000017e37-36-5f3de09151c9
Received: from CNSHPPEXCH1603.nsn-intra.net (Unknown_Domain [135.251.51.103])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by CNSHJSMIN05.NOKIA-SBELL.COM (Symantec Messaging Gateway) with SMTP id 6C.68.32311.190ED3F5; Thu, 20 Aug 2020 10:31:45 +0800 (HKT)
Received: from CNSHPPEXCH1604.nsn-intra.net (135.251.51.104) by
 CNSHPPEXCH1603.nsn-intra.net (135.251.51.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 20 Aug 2020 10:31:45 +0800
Received: from CNSHPPEXCH1604.nsn-intra.net ([135.251.51.104]) by
 CNSHPPEXCH1604.nsn-intra.net ([135.251.51.104]) with mapi id 15.01.1847.007;
 Thu, 20 Aug 2020 10:31:45 +0800
From:   "Zhou, Libing (NSB - CN/Hangzhou)" <libing.zhou@nokia-sbell.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "bp@suse.de" <bp@suse.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>
Subject: RE: [PATCH] x86/nmi: Fix nmi_handle duration miscalculation
Thread-Topic: [PATCH] x86/nmi: Fix nmi_handle duration miscalculation
Thread-Index: AQHWdHV7gKGoaCX/hkiiTjZTrUPMfak+kFSAgAG6l/A=
Date:   Thu, 20 Aug 2020 02:31:45 +0000
Message-ID: <c3a422ace0724f1f986b4fc033fa065f@nokia-sbell.com>
References: <20200817090441.44501-1-libing.zhou@nokia-sbell.com>
 <20200819080645.GX2674@hirez.programming.kicks-ass.net>
In-Reply-To: <20200819080645.GX2674@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [135.251.51.115]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsXS/ts4XXfiA9t4g6/XDS0+b/jHZjGxX9Ni
        2kZxi8u75rBZXDqwgMnieO8BJovNm6YyW/zY8JjVgcPje2sfi8fmFVoem1Z1snm8O3eO3eP9
        vqtsHptPV3t83iTncaLlC2sARxSXTUpqTmZZapG+XQJXxsO7N5gLFkhVbOzZwdjAeEKyi5GT
        Q0LARGLS9Z/MXYxcHEICh5gkjn6Yygrh/GWUaL95nw3C2cQo8en7ASaQFjYBN4mH8y+xgtgi
        AoYS0+cdYQEpYhaYziTx5tcmsCJhAReJ5ht3mSGKXCVeTOtgh7CtJJZPOwg0lYODRUBVYvXy
        UBCTV8BO4t9CNZAKIYEqiVeL7oNVcwJNOb32H9hERgExie+n1oDZzALiEreezGeC+EBAYsme
        88wQtqjEy8f/WEFGSggoSfRtgCrXkpjX8BvKVpSY0v0QbDyvgKDEyZlPWCYwis1CMnUWkpZZ
        SFpmIWlZwMiyilHa2S/YwyvY19PPwFTPz9/b01E32MnVx0fP2d93EyMwctdITJq7g7Fp5ge9
        Q4xMHIyHGCU4mJVEeHv3WscL8aYkVlalFuXHF5XmpBYfYpTmYFES5523SD5eSCA9sSQ1OzW1
        ILUIJsvEwSnVwLRr5pHY40I6/u8UA8v0kr1fbzGb6l9x/+tB5o+8gb3TH6ty/TrhzHDi95zY
        pF3b9vm4FB/0/Pr544L7HvrSeafvv1Jds692ksNm42d2h/bZ9h/rFu3ibxCSEfnzRPIq147j
        e8sP7QrT3B4Unl52vjhVd0Lgksdi6/cfF3X6lr14a/QEqVSF7EUVs6acqapepbziiqeH1Kov
        l3lMo7xr5/45ZJm5lq1yrfzHiwenX3K37jB8rHU62aqww7RAwesW3/zlJmHLDwv3sR77sUVE
        /N2PRTrsEysEg1hOFxTzKBw6nT/Zdf++xRYe1aLX3CR/ec07UdB9KHUb3+aea9EZLg0T9n4+
        1Ptfpf9EzLGlPGVKLMUZiYZazEXFiQDhdhs0SwMAAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLCBJIHdpbGwgcmVjb21taXQgcGF0Y2ggc29vbi4NCg0K
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IHBldGVyekBpbmZyYWRlYWQub3JnIDxw
ZXRlcnpAaW5mcmFkZWFkLm9yZz4gDQpTZW50OiAyMDIwxOo41MIxOcjVIDE2OjA3DQpUbzogWmhv
dSwgTGliaW5nIChOU0IgLSBDTi9IYW5nemhvdSkgPGxpYmluZy56aG91QG5va2lhLXNiZWxsLmNv
bT4NCkNjOiB0Z2x4QGxpbnV0cm9uaXguZGU7IG1pbmdvQHJlZGhhdC5jb207IGJwQGFsaWVuOC5k
ZTsgYnBAc3VzZS5kZTsgeDg2QGtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IGhwYUB6eXRvci5jb20NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIHg4Ni9ubWk6IEZpeCBubWlf
aGFuZGxlIGR1cmF0aW9uIG1pc2NhbGN1bGF0aW9uDQoNCk9uIE1vbiwgQXVnIDE3LCAyMDIwIGF0
IDA1OjA0OjQxUE0gKzA4MDAsIExpYmluZyBaaG91IHdyb3RlOg0KPiBJbiBubWlfY2hlY2tfZHVy
YXRpb24oKSwgdGhlICd3aG9sZV9tc2VjcycgdmFsdWUgc2hvdWxkIGdldCBmcm9tIA0KPiAnZHVy
YXRpb24nIHRvIHJlZmxlY3QgYWN0dWFsIHRpbWUgZHVyYXRpb24sIGJ1dCBub3QgDQo+ICdhY3Rp
b24tPm1heF9kdXJhdGlvbicuDQoNCkZpeGVzOiAyNDhlZDUxMDQ4YzQgKCJ4ODYvbm1pOiBSZW1v
dmUgaXJxX3dvcmsgZnJvbSB0aGUgbG9uZyBkdXJhdGlvbiBOTUkgaGFuZGxlciIpDQoNCj4gU2ln
bmVkLW9mZi1ieTogTGliaW5nIFpob3UgPGxpYmluZy56aG91QG5va2lhLXNiZWxsLmNvbT4NCj4g
LS0tDQo+ICBhcmNoL3g4Ni9rZXJuZWwvbm1pLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4
Ni9rZXJuZWwvbm1pLmMgYi9hcmNoL3g4Ni9rZXJuZWwvbm1pLmMgaW5kZXggDQo+IDRmYzk5NTRh
OTU2MC4uYzUxZWU2NTllNTIwIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvbm1pLmMN
Cj4gKysrIGIvYXJjaC94ODYva2VybmVsL25taS5jDQo+IEBAIC0xMDIsNyArMTAyLDcgQEAgZnNf
aW5pdGNhbGwobm1pX3dhcm5pbmdfZGVidWdmcyk7DQo+ICANCj4gIHN0YXRpYyB2b2lkIG5taV9j
aGVja19kdXJhdGlvbihzdHJ1Y3Qgbm1pYWN0aW9uICphY3Rpb24sIHU2NCANCj4gZHVyYXRpb24p
ICB7DQo+IC0JdTY0IHdob2xlX21zZWNzID0gUkVBRF9PTkNFKGFjdGlvbi0+bWF4X2R1cmF0aW9u
KTsNCj4gKwl1NjQgd2hvbGVfbXNlY3MgPSBkdXJhdGlvbjsNCj4gIAlpbnQgcmVtYWluZGVyX25z
LCBkZWNpbWFsX21zZWNzOw0KPiAgDQo+ICAJaWYgKGR1cmF0aW9uIDwgbm1pX2xvbmdlc3RfbnMg
fHwgZHVyYXRpb24gPCBhY3Rpb24tPm1heF9kdXJhdGlvbikNCg0KVGhlLCBJTU8sIHNhbmVyIHNv
bHV0aW9uIGlzOg0KDQotLS0NCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvbm1pLmMgYi9h
cmNoL3g4Ni9rZXJuZWwvbm1pLmMgaW5kZXggNGZjOTk1NGE5NTYwLi40NzM4MTY2NmQ2YTUgMTAw
NjQ0DQotLS0gYS9hcmNoL3g4Ni9rZXJuZWwvbm1pLmMNCisrKyBiL2FyY2gveDg2L2tlcm5lbC9u
bWkuYw0KQEAgLTEwMiw3ICsxMDIsNiBAQCBmc19pbml0Y2FsbChubWlfd2FybmluZ19kZWJ1Z2Zz
KTsNCiANCiBzdGF0aWMgdm9pZCBubWlfY2hlY2tfZHVyYXRpb24oc3RydWN0IG5taWFjdGlvbiAq
YWN0aW9uLCB1NjQgZHVyYXRpb24pICB7DQotCXU2NCB3aG9sZV9tc2VjcyA9IFJFQURfT05DRShh
Y3Rpb24tPm1heF9kdXJhdGlvbik7DQogCWludCByZW1haW5kZXJfbnMsIGRlY2ltYWxfbXNlY3M7
DQogDQogCWlmIChkdXJhdGlvbiA8IG5taV9sb25nZXN0X25zIHx8IGR1cmF0aW9uIDwgYWN0aW9u
LT5tYXhfZHVyYXRpb24pIEBAIC0xMTAsMTIgKzEwOSwxMiBAQCBzdGF0aWMgdm9pZCBubWlfY2hl
Y2tfZHVyYXRpb24oc3RydWN0IG5taWFjdGlvbiAqYWN0aW9uLCB1NjQgZHVyYXRpb24pDQogDQog
CWFjdGlvbi0+bWF4X2R1cmF0aW9uID0gZHVyYXRpb247DQogDQotCXJlbWFpbmRlcl9ucyA9IGRv
X2Rpdih3aG9sZV9tc2VjcywgKDEwMDAgKiAxMDAwKSk7DQorCXJlbWFpbmRlcl9ucyA9IGRvX2Rp
dihkdXJhdGlvbiwgKDEwMDAgKiAxMDAwKSk7DQogCWRlY2ltYWxfbXNlY3MgPSByZW1haW5kZXJf
bnMgLyAxMDAwOw0KIA0KIAlwcmludGtfcmF0ZWxpbWl0ZWQoS0VSTl9JTkZPDQogCQkiSU5GTzog
Tk1JIGhhbmRsZXIgKCVwcykgdG9vayB0b28gbG9uZyB0byBydW46ICVsbGQuJTAzZCBtc2Vjc1xu
IiwNCi0JCWFjdGlvbi0+aGFuZGxlciwgd2hvbGVfbXNlY3MsIGRlY2ltYWxfbXNlY3MpOw0KKwkJ
YWN0aW9uLT5oYW5kbGVyLCBkdXJhdGlvbiwgZGVjaW1hbF9tc2Vjcyk7DQogfQ0KIA0KIHN0YXRp
YyBpbnQgbm1pX2hhbmRsZSh1bnNpZ25lZCBpbnQgdHlwZSwgc3RydWN0IHB0X3JlZ3MgKnJlZ3Mp
DQo=
