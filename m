Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7ABCC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 21:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 452E120659
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 21:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="nGTeU8vU";
	dkim=pass (1024-bit key) header.d=cisco.onmicrosoft.com header.i=@cisco.onmicrosoft.com header.b="s0b2I4dv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbgIHVFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 17:05:06 -0400
Received: from alln-iport-5.cisco.com ([173.37.142.92]:33321 "EHLO
        alln-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbgIHVFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 17:05:04 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Sep 2020 17:05:02 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3438; q=dns/txt; s=iport;
  t=1599599102; x=1600808702;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hyYeOhUcYtCiC0YLjSnXva8LgNxVVh+qih8vdIF8Na8=;
  b=nGTeU8vUhSqpvIdF+KuoPcuzLpzHpeYhjGNzU3kHgtsYG8DnNAa0LbvH
   fpsKLBJKjNCzmVlK5G/TXBXxvJswOVFjHkZyUPWzmwgYATVD95dlI8NIC
   ZwGUyQozqblY7/QyI/bvS7PhuAdsgsJtwqD+RN+0Ykoo0wHf1RCuVcxi3
   4=;
IronPort-PHdr: =?us-ascii?q?9a23=3AC58PYBYJuasymgfXSLZUAHv/LSx94ef9IxIV55?=
 =?us-ascii?q?w7irlHbqWk+dH4MVfC4el21QaVD4re4vNAzeHRtvOoVW8B5MOHt3YPONxJWg?=
 =?us-ascii?q?QegMob1wonHIaeCEL9IfKrCk5yHMlLWFJ/uX3uN09TFZXxYlTTpju56jtBUh?=
 =?us-ascii?q?n6PBB+c+LyHIOahs+r1ue0rpvUZQgAhDe0bb5oahusqgCEvcgNiowkIaE0mR?=
 =?us-ascii?q?Y=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0DPBQD77ldf/4wNJK1fHAEBAQEBAQc?=
 =?us-ascii?q?BARIBAQQEAQFAgU+BUlEHgUkvLIQ4g0YDjXGYcYJTA1ULAQEBDAEBLQIEAQG?=
 =?us-ascii?q?ESwIXgXoCJDgTAgMBAQsBAQUBAQECAQYEbYVcAQuFcwEBAQMSEREMAQE3AQ8?=
 =?us-ascii?q?CAQgYAgImAgICMBUQAgQOBSKFUAMuAad3AoE5iGF2gTKDAQEBBYUNGIIQCRR?=
 =?us-ascii?q?6KoJxg2iGURuBQT+EIT6EPBiDAIJgj3OCawE8igyZRwqCZZoyIaBWklGfVwI?=
 =?us-ascii?q?EAgQFAg4BAQWBayOBV3AVgyRQFwINV41ICRqDTopWdDcCBgoBAQMJfI1wAQE?=
X-IronPort-AV: E=Sophos;i="5.76,407,1592870400"; 
   d="scan'208";a="551317579"
Received: from alln-core-7.cisco.com ([173.36.13.140])
  by alln-iport-5.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 08 Sep 2020 20:57:53 +0000
Received: from XCH-RCD-004.cisco.com (xch-rcd-004.cisco.com [173.37.102.14])
        by alln-core-7.cisco.com (8.15.2/8.15.2) with ESMTPS id 088Kvr8n031641
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 8 Sep 2020 20:57:53 GMT
Received: from xhs-rcd-003.cisco.com (173.37.227.248) by XCH-RCD-004.cisco.com
 (173.37.102.14) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 8 Sep
 2020 15:57:53 -0500
Received: from xhs-aln-002.cisco.com (173.37.135.119) by xhs-rcd-003.cisco.com
 (173.37.227.248) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 8 Sep
 2020 15:57:52 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (173.37.151.57)
 by xhs-aln-002.cisco.com (173.37.135.119) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 8 Sep 2020 15:57:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcyrJztjv5jry4eSWFESTKqjkq+mhUuTIAOxPNrnoCHjCHxceMJtUZVPb3i8BVJaqStdtO7CvN+3lCfyeFaHD5FUGPTNV/dxB3JrRrlSxCu7IWZINClKhgIwtmHW27rTI0taByjsIY5Cq5SVtmctio18FIferZZlZYnN6E839tCDfbXARxyxAU0SNp90GKLO0WhoYB1G47oDT4b/MeEH1GdOjkp3nt6UKudl7v/lUldtDl5qU9UrczwGCMi+aBGLVZvJw+V5jzb3jDSgbX5i5LXfX/Ji0RSqAEJ1sriNSD/Jx6BPqkmd86jGeQkWLYLISaInpHBQeyVmdnKFZeazQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyYeOhUcYtCiC0YLjSnXva8LgNxVVh+qih8vdIF8Na8=;
 b=d6jNzoUH1zGpLjovsVXpD5oH+EUtJhu9mELwIpbRgGbwJ0gJDj12aKJqECLyTbmaGz0qc05XukcunWuc2otCGWdkVXGpJYuDW3i8FT/OMtXgECIYcMH39RiSlx1wxZ0McmAERMtBmbhbt1bPII7IuCfMiu+Z8rM98OnDWNuc4fnNBXYjphdEeNw1ojdcWKtCHjmIKGvEgg4Gmv1F56bRf/1Uth6pImkn9QoRCS6eClscAVmygFR/d95OCnc9OMWM6ETN9xypbGvnyi6JvSSq2V8udX+TgSaUHtXnDC+1nGG0w+5b9XmZrPBq3POyOnhBcW9VyKHZ+/7/L9wn9oeXbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyYeOhUcYtCiC0YLjSnXva8LgNxVVh+qih8vdIF8Na8=;
 b=s0b2I4dvYk227heMeEt4h7Zo/uL1uo3qSHJSeM1dExOB/Y8f8d0auSBlw5vhIIssbQE3QaeTMllez6ziPw1iUu3HHZugo0zswqT2Ryw3+McG+q9QtEXAJHu2ZZQryOSZnfVFBnAQDAosx6Ffc/uZQ8eQXU6H/7euXojEQjdpQ6k=
Received: from BY5PR11MB4182.namprd11.prod.outlook.com (2603:10b6:a03:183::10)
 by BYAPR11MB3622.namprd11.prod.outlook.com (2603:10b6:a03:fe::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 8 Sep
 2020 20:57:50 +0000
Received: from BY5PR11MB4182.namprd11.prod.outlook.com
 ([fe80::1d4e:2269:63d7:f2d6]) by BY5PR11MB4182.namprd11.prod.outlook.com
 ([fe80::1d4e:2269:63d7:f2d6%6]) with mapi id 15.20.3348.019; Tue, 8 Sep 2020
 20:57:50 +0000
From:   "Julius Hemanth Pitti (jpitti)" <jpitti@cisco.com>
To:     "shy828301@gmail.com" <shy828301@gmail.com>
CC:     "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "guro@fb.com" <guro@fb.com>
Subject: Re: [PATCH v2] mm: memcg: yield cpu when we fail to charge pages
Thread-Topic: [PATCH v2] mm: memcg: yield cpu when we fail to charge pages
Thread-Index: AQHWhhywUt5QbtgHCkqfPwmM+yALvalfMfCAgAAHQoA=
Date:   Tue, 8 Sep 2020 20:57:50 +0000
Message-ID: <fb708efd83bb77fd80bc34bb29b6a886f1ed63a5.camel@cisco.com>
References: <20200908201426.14837-1-jpitti@cisco.com>
         <CAHbLzkqYrkA6=RSBpwEQJ5WaLUWwdP=05BPE2F4pRgk98NuVTg@mail.gmail.com>
In-Reply-To: <CAHbLzkqYrkA6=RSBpwEQJ5WaLUWwdP=05BPE2F4pRgk98NuVTg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=cisco.com;
x-originating-ip: [2001:420:c0c8:1005::83d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8debd1fb-f100-4d2f-eed7-08d85439d907
x-ms-traffictypediagnostic: BYAPR11MB3622:
x-ld-processed: 5ae1af62-9505-4097-a69a-c1553ef7840e,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB36221E71A0500BB3A188F32ADA290@BYAPR11MB3622.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vh3b2rU1zz/c9P/eIDefMJDOw8GZl1+vWRF77aeDK5OLK63h1+zz4TBn9A7Miuhzgw3d5jwTczWM8PhUyRcT+cTLJvx4oH9kWISdG6PfHy+AYty+yzp1YiqinMzMnNUFnYaAGAKDis0Cdl3D0MDWNfSaCPjzLNkpJNHxnuJmSg/CNJXJ5SVQ1GSR7bpJaCw12K9X3L1B9A+iZkZId60Y73x0fHz01NGdQqVtFobRtTu537XJ8tYmGhEofScDwDJjtO3aH0TZJrWxpJ1d8fbzuEkTsDDHFr9gjTyIhdwUcXYVuCxG/h8ceclxUj/SBkNrnRmFH2d4K8TyPKtfscY6dqnmnjIlmtdtrKQLIdgN8K4vrRYYn/NudQOb71XrKD5Y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4182.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(396003)(136003)(366004)(6512007)(316002)(8676002)(54906003)(6916009)(71200400001)(5660300002)(36756003)(76116006)(2616005)(86362001)(83380400001)(53546011)(6486002)(6506007)(4326008)(8936002)(2906002)(478600001)(64756008)(66446008)(186003)(66946007)(66476007)(66556008)(99106002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ykq3RJ3NB9Y7IZpRNtQfabc251Fopjnq+6HfDnaWqapVKOnVINMVhD0sNsd+wEK1VS/HDT/XAizG88OgpZmVoMrrK5uZiy6lFRAJDxEl+f6ZGF29GGwJcx412XIvd51K/EF/TjdaQlatN26MNwkwjZGL7/CWiocL6YN/HIBwrB0HhUZMyO2JzEvADpIgGJDwGvtYYWa1f8JYlSUlF7CLTxqrRuK+40hk8eUGtktqG0c1W6jHwM+iX2ZmqPXvvV7krmWpjv2GzPAsux2kehsvt5c1uOqtl6Ko+naDv72b6Fncp+vQjH9TyIf2FSH/nvYiJ4/OO29RyjTh4bLARpCz87ayfYaSaVzSlkwbIbq0eBgOoGkKAwq8ShzsLGZI69MennRGrcy8JvWE4yp7RDZ4TnPngaSJOLD/T9u26uOkrz8AIwj4VFrj4TsoAlFytxAgfBD+5jJJaxHJNJjP3asz5Nv7TVnkzJPEj3183FGZIvF6bpIw11F5CiDz+9oEOEvzYscgkdPXwBFquIliKTpF/e1wpYqBXI72Dka/GzzsScQ0bJobgeXJpS2gwwCd6ThOLuhwxZMG8p0KFlwDw/GT5xijLE8oxNPAeVRR12+TK05KucQzGG9HIDVuEzUhxP7Qw1OtrU6O97orJM39xSPy5SdBvx5EsGPzzKkxiTugDbo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <750A9BAED03FFF41B0A5F03DD198FCD6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4182.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8debd1fb-f100-4d2f-eed7-08d85439d907
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2020 20:57:50.2370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uU3cHb8L/wyuMTl8mPNLGPC6SVK3bjJpIw+jLySLxmG6NUPBqtXqfvHep9DNVomlojQ8Z+DiIgGEadARC35uJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3622
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.37.102.14, xch-rcd-004.cisco.com
X-Outbound-Node: alln-core-7.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTA5LTA4IGF0IDEzOjMxIC0wNzAwLCBZYW5nIFNoaSB3cm90ZToNCj4gT24g
VHVlLCBTZXAgOCwgMjAyMCBhdCAxOjE0IFBNIEp1bGl1cyBIZW1hbnRoIFBpdHRpIDxqcGl0dGlA
Y2lzY28uY29tDQo+ID4gd3JvdGU6DQo+ID4gDQo+ID4gRm9yIG5vbiByb290IENHLCBpbiB0cnlf
Y2hhcmdlKCksIHdlIGtlZXAgdHJ5aW5nDQo+ID4gdG8gY2hhcmdlIHVudGlsIHdlIHN1Y2NlZWQu
IE9uIG5vbi1wcmVlbXB0aXZlDQo+ID4ga2VybmVsLCB3aGVuIHdlIGFyZSBPT00sIHRoaXMgcmVz
dWx0cyBpbiBob2xkaW5nDQo+ID4gQ1BVIGZvcmV2ZXIuDQo+ID4gDQo+ID4gT24gU01QIHN5c3Rl
bXMsIHRoaXMgZG9lc24ndCBjcmVhdGUgYSBiaWcgcHJvYmxlbQ0KPiA+IGJlY2F1c2Ugb29tX3Jl
YXBlciBnZXQgYSBjaGFuZ2UgdG8ga2lsbCB2aWN0aW0NCj4gPiBhbmQgbWFrZSBzb21lIGZyZWUg
cGFnZXMuIEhvd2V2ZXIgb24gYSBzaW5nbGUtY29yZQ0KPiA+IENQVSAob3IgY2FzZXMgd2hlcmUg
b29tX3JlYXBlciBwaW5uZWQgdG8gc2FtZSBDUFUNCj4gPiB3aGVyZSB0cnlfY2hhcmdlIGlzIGV4
ZWN1dGluZyksIG9vbV9yZWFwZXIgc2hhbGwNCj4gPiBuZXZlciBnZXQgc2NoZWR1bGVkIGFuZCB3
ZSBzdGF5IGluIHRyeV9jaGFyZ2UgZm9yZXZlci4NCj4gPiANCj4gPiBTdGVwcyB0byByZXBvIHRo
aXMgb24gbm9uLXNtcDoNCj4gPiAxLiBtb3VudCAtdCB0bXBmcyBub25lIC9zeXMvZnMvY2dyb3Vw
DQo+ID4gMi4gbWtkaXIgL3N5cy9mcy9jZ3JvdXAvbWVtb3J5DQo+ID4gMy4gbW91bnQgLXQgY2dy
b3VwIG5vbmUgL3N5cy9mcy9jZ3JvdXAvbWVtb3J5IC1vIG1lbW9yeQ0KPiA+IDQuIG1rZGlyIC9z
eXMvZnMvY2dyb3VwL21lbW9yeS8wDQo+ID4gNS4gZWNobyA0ME0gPiAvc3lzL2ZzL2Nncm91cC9t
ZW1vcnkvMC9tZW1vcnkubGltaXRfaW5fYnl0ZXMNCj4gPiA2LiBlY2hvICQkID4gL3N5cy9mcy9j
Z3JvdXAvbWVtb3J5LzAvdGFza3MNCj4gPiA3LiBzdHJlc3MgLW0gNSAtLXZtLWJ5dGVzIDEwTSAt
LXZtLWhhbmcgMA0KPiANCj4gSXNuJ3QgaXQgdGhlIHNhbWUgcHJvYmxlbSBzb2x2ZWQgYnkgZTMz
MzZjYWIyNTc5ICgibW06IG1lbWNnOiBmaXgNCj4gbWVtY2cgcmVjbGFpbSBzb2Z0IGxvY2t1cCIp
PyBJdCBoYXMgYmVlbiBpbiBMaW51cydzIHRyZWUuDQoNClllcywgaW5kZWVkLg0KSSBqdXN0IHRl
c3RlZCB3aXRoIGUzMzM2Y2FiMjU3OSwgYW5kIGl0IHNvbHZlZCB0aGlzIHByb2JsZW0uDQpUaGFu
a3MgZm9yIHBvaW50aW5nIGl0IG91dC4NCg0KPiANCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBK
dWxpdXMgSGVtYW50aCBQaXR0aSA8anBpdHRpQGNpc2NvLmNvbT4NCj4gPiBBY2tlZC1ieTogUm9t
YW4gR3VzaGNoaW4gPGd1cm9AZmIuY29tPg0KPiA+IC0tLQ0KPiA+IA0KPiA+IENoYW5nZXMgaW4g
djI6DQo+ID4gIC0gQWRkZWQgY29tbWVudHMuDQo+ID4gIC0gQWRkZWQgIkFja2VkLWJ5OiBSb21h
biBHdXNoY2hpbiA8Z3Vyb0BmYi5jb20+Ii4NCj4gPiAtLS0NCj4gPiAgbW0vbWVtY29udHJvbC5j
IHwgOSArKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKQ0KPiA+
IA0KPiA+IGRpZmYgLS1naXQgYS9tbS9tZW1jb250cm9sLmMgYi9tbS9tZW1jb250cm9sLmMNCj4g
PiBpbmRleCBjZmE2Y2JhZDIxZDUuLjRmMjkzYmY4YzdlZCAxMDA2NDQNCj4gPiAtLS0gYS9tbS9t
ZW1jb250cm9sLmMNCj4gPiArKysgYi9tbS9tZW1jb250cm9sLmMNCj4gPiBAQCAtMjc0NSw2ICsy
NzQ1LDE1IEBAIHN0YXRpYyBpbnQgdHJ5X2NoYXJnZShzdHJ1Y3QgbWVtX2Nncm91cA0KPiA+ICpt
ZW1jZywgZ2ZwX3QgZ2ZwX21hc2ssDQo+ID4gICAgICAgICBpZiAoZmF0YWxfc2lnbmFsX3BlbmRp
bmcoY3VycmVudCkpDQo+ID4gICAgICAgICAgICAgICAgIGdvdG8gZm9yY2U7DQo+ID4gDQo+ID4g
KyAgICAgICAvKg0KPiA+ICsgICAgICAgICogV2UgZmFpbGVkIHRvIGNoYXJnZSBldmVuIGFmdGVy
IHJldHJpZXMsIGdpdmUgb29tX3JlYXBlcg0KPiA+IG9yDQo+ID4gKyAgICAgICAgKiBvdGhlciBw
cm9jZXNzIGEgY2hhbmdlIHRvIG1ha2Ugc29tZSBmcmVlIHBhZ2VzLg0KPiA+ICsgICAgICAgICoN
Cj4gPiArICAgICAgICAqIE9uIG5vbi1wcmVlbXB0aXZlLCBOb24tU01QIHN5c3RlbSwgdGhpcyBp
cyBjcml0aWNhbCwNCj4gPiBlbHNlDQo+ID4gKyAgICAgICAgKiB3ZSBrZWVwIHJldHJ5aW5nIHdp
dGggbm8gc3VjY2VzcywgZm9yZXZlci4NCj4gPiArICAgICAgICAqLw0KPiA+ICsgICAgICAgY29u
ZF9yZXNjaGVkKCk7DQo+ID4gKw0KPiA+ICAgICAgICAgLyoNCj4gPiAgICAgICAgICAqIGtlZXAg
cmV0cnlpbmcgYXMgbG9uZyBhcyB0aGUgbWVtY2cgb29tIGtpbGxlciBpcyBhYmxlIHRvDQo+ID4g
bWFrZQ0KPiA+ICAgICAgICAgICogYSBmb3J3YXJkIHByb2dyZXNzIG9yIGJ5cGFzcyB0aGUgY2hh
cmdlIGlmIHRoZSBvb20NCj4gPiBraWxsZXINCj4gPiAtLQ0KPiA+IDIuMTcuMQ0KPiA+IA0KPiA+
IA0K
