Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E1DC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 07:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 495FE2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 07:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgHaHCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 03:02:53 -0400
Received: from cnshjsmin03.alcatel-sbell.com.cn ([116.246.26.71]:35001 "EHLO
        CNSHJSMIN03.NOKIA-SBELL.COM" rhost-flags-OK-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S1725848AbgHaHCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 03:02:48 -0400
X-AuditID: ac189297-db1ff7000001b940-86-5f4ca078a3ac
Received: from CNSHPPEXCH1603.nsn-intra.net (Unknown_Domain [135.251.51.103])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by CNSHJSMIN03.NOKIA-SBELL.COM (Symantec Messaging Gateway) with SMTP id FF.21.47424.870AC4F5; Mon, 31 Aug 2020 15:02:16 +0800 (HKT)
Received: from CNSHPPEXCH1604.nsn-intra.net (135.251.51.104) by
 CNSHPPEXCH1603.nsn-intra.net (135.251.51.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Mon, 31 Aug 2020 15:02:15 +0800
Received: from CNSHPPEXCH1604.nsn-intra.net ([135.251.51.104]) by
 CNSHPPEXCH1604.nsn-intra.net ([135.251.51.104]) with mapi id 15.01.1847.007;
 Mon, 31 Aug 2020 15:02:15 +0800
From:   "Zhou, Libing (NSB - CN/Hangzhou)" <libing.zhou@nokia-sbell.com>
To:     "peterz@infradead.org" <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "bp@suse.de" <bp@suse.de>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>
Subject: RE: [PATCH v2] x86/nmi: Fix nmi_handle duration miscalculation
Thread-Topic: [PATCH v2] x86/nmi: Fix nmi_handle duration miscalculation
Thread-Index: AQHWdp2Qb6n74pS6skOCiXYyvUfNPKlR29zA
Date:   Mon, 31 Aug 2020 07:02:15 +0000
Message-ID: <db5ea22c61ad4653a9c03a042cadee89@nokia-sbell.com>
References: <20200820025641.44075-1-libing.zhou@nokia-sbell.com>
In-Reply-To: <20200820025641.44075-1-libing.zhou@nokia-sbell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [135.251.51.115]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsXS/ts4XbdigU+8wdYz3BafN/xjs5jYr2kx
        baO4xeVdc9gsLh1YwGRxvPcAk8XmTVOZLX5seMzqwOHxvbWPxWPzCi2PTas62TzenTvH7vF+
        31U2j82nqz0+b5LzONHyhTWAI4rLJiU1J7MstUjfLoEr4+TNFpaCS8IV/9/+Y2lgnCDcxcjJ
        ISFgIvGwdT1bFyMXh5DAISaJpvnL2CGcv4wSPYcvsUI4mxgl/l9pZANpYRNwk3g4HyIhIvAE
        qKpxOjNIglkgReLI7D1MILawgLvE6Qu9YLaIgIdEy7k1bBC2kcTBjUvBbBYBVYnH+06wg9i8
        AnYSuxdeB7OFBBwkzrxfANbLKeAoMb+9lRHEZhQQk/h+ag0TxC5xiVtP5jNB/CAgsWTPeWYI
        W1Ti5eN/QMdxANlKEn0boMq1JOY1/IayFSWmdD+EWisocXLmE5YJjGKzkEydhaRlFpKWWUha
        FjCyrGKUdvYL9vAK9vX0MzDW8/P39nTUDXZy9fHRc/b33cQIjN41EpOm72B8PuuD3iFGJg7G
        Q4wSHMxKIrwHdnnHC/GmJFZWpRblxxeV5qQWH2KU5mBREuedt0g+XkggPbEkNTs1tSC1CCbL
        xMEp1cCU+XbxYVP7c/esN6bfULKVnVfrXW/nd3+v0uVlOtObbwhturewQv2rAn9sGceB48bS
        An+Kps8OTJvMac/5a1eJbavRfmeT5MO2+12/Cp2eerZz18VHV5yu/fb5lGOnWLZKcXH79T9z
        KpSWuSQXqZfcZFjLZJ177ce7hzNu2b+Q4Hrcune5cbKHZr3opYX+t8tEs7yesHG0Ot7e18Vk
        VjC50cNcP+RF+erjX64EKnziSq8+/23+42dzzkXe/cTEN8Xu7GqWWOdKgUtRXTVFoQ/faL/Z
        sSm3/F3Dj0MVlu0zT/18NoeTQXv+7LkvuRSzmX/WZYmoXZ8QWnNuznz1JU/mP3vR0OSd8pzF
        6ug37TN/lViKMxINtZiLihMB0oG+Vk0DAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCkFueSBjb21tZW50IG9uIHRoaXM/DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBMaWJpbmcgWmhvdSA8bGliaW5nLnpob3VAbm9raWEtc2JlbGwuY29tPiANClNlbnQ6
IDIwMjDE6jjUwjIwyNUgMTA6NTcNClRvOiBwZXRlcnpAaW5mcmFkZWFkLm9yZzsgdGdseEBsaW51
dHJvbml4LmRlOyBtaW5nb0ByZWRoYXQuY29tOyBicEBhbGllbjguZGU7IGJwQHN1c2UuZGU7IHg4
NkBrZXJuZWwub3JnDQpDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgWmhvdSwgTGli
aW5nIChOU0IgLSBDTi9IYW5nemhvdSkgPGxpYmluZy56aG91QG5va2lhLXNiZWxsLmNvbT47IGhw
YUB6eXRvci5jb20NClN1YmplY3Q6IFtQQVRDSCB2Ml0geDg2L25taTogRml4IG5taV9oYW5kbGUg
ZHVyYXRpb24gbWlzY2FsY3VsYXRpb24NCg0KSW4gbm1pX2NoZWNrX2R1cmF0aW9uKCksIHRoZSAn
d2hvbGVfbXNlY3MnIHZhbHVlIGdldCBmcm9tICdhY3Rpb24tPm1heF9kdXJhdGlvbicgaXMgd3Jv
bmcuDQoNCkZpeGVzOiAyNDhlZDUxMDQ4YzQgKCJ4ODYvbm1pOiBSZW1vdmUgaXJxX3dvcmsgZnJv
bSB0aGUgbG9uZyBkdXJhdGlvbiBOTUkgaGFuZGxlciIpDQpTaWduZWQtb2ZmLWJ5OiBMaWJpbmcg
WmhvdSA8bGliaW5nLnpob3VAbm9raWEtc2JlbGwuY29tPg0KLS0tDQp2MjoNCkNoYW5nZSBzb2x1
dGlvbiBhcyBwZXRlcnpAaW5mcmFkZWFkLm9yZyBzdWdnZXN0ZWQuDQoNCiBhcmNoL3g4Ni9rZXJu
ZWwvbm1pLmMgfCA1ICsrLS0tDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMyBk
ZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9ubWkuYyBiL2FyY2gv
eDg2L2tlcm5lbC9ubWkuYyBpbmRleCA0ZmM5OTU0YTk1NjAuLjQ3MzgxNjY2ZDZhNSAxMDA2NDQN
Ci0tLSBhL2FyY2gveDg2L2tlcm5lbC9ubWkuYw0KKysrIGIvYXJjaC94ODYva2VybmVsL25taS5j
DQpAQCAtMTAyLDcgKzEwMiw2IEBAIGZzX2luaXRjYWxsKG5taV93YXJuaW5nX2RlYnVnZnMpOw0K
IA0KIHN0YXRpYyB2b2lkIG5taV9jaGVja19kdXJhdGlvbihzdHJ1Y3Qgbm1pYWN0aW9uICphY3Rp
b24sIHU2NCBkdXJhdGlvbikgIHsNCi0JdTY0IHdob2xlX21zZWNzID0gUkVBRF9PTkNFKGFjdGlv
bi0+bWF4X2R1cmF0aW9uKTsNCiAJaW50IHJlbWFpbmRlcl9ucywgZGVjaW1hbF9tc2VjczsNCiAN
CiAJaWYgKGR1cmF0aW9uIDwgbm1pX2xvbmdlc3RfbnMgfHwgZHVyYXRpb24gPCBhY3Rpb24tPm1h
eF9kdXJhdGlvbikgQEAgLTExMCwxMiArMTA5LDEyIEBAIHN0YXRpYyB2b2lkIG5taV9jaGVja19k
dXJhdGlvbihzdHJ1Y3Qgbm1pYWN0aW9uICphY3Rpb24sIHU2NCBkdXJhdGlvbikNCiANCiAJYWN0
aW9uLT5tYXhfZHVyYXRpb24gPSBkdXJhdGlvbjsNCiANCi0JcmVtYWluZGVyX25zID0gZG9fZGl2
KHdob2xlX21zZWNzLCAoMTAwMCAqIDEwMDApKTsNCisJcmVtYWluZGVyX25zID0gZG9fZGl2KGR1
cmF0aW9uLCAoMTAwMCAqIDEwMDApKTsNCiAJZGVjaW1hbF9tc2VjcyA9IHJlbWFpbmRlcl9ucyAv
IDEwMDA7DQogDQogCXByaW50a19yYXRlbGltaXRlZChLRVJOX0lORk8NCiAJCSJJTkZPOiBOTUkg
aGFuZGxlciAoJXBzKSB0b29rIHRvbyBsb25nIHRvIHJ1bjogJWxsZC4lMDNkIG1zZWNzXG4iLA0K
LQkJYWN0aW9uLT5oYW5kbGVyLCB3aG9sZV9tc2VjcywgZGVjaW1hbF9tc2Vjcyk7DQorCQlhY3Rp
b24tPmhhbmRsZXIsIGR1cmF0aW9uLCBkZWNpbWFsX21zZWNzKTsNCiB9DQogDQogc3RhdGljIGlu
dCBubWlfaGFuZGxlKHVuc2lnbmVkIGludCB0eXBlLCBzdHJ1Y3QgcHRfcmVncyAqcmVncykNCi0t
DQoyLjIyLjANCg0K
