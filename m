Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740B4C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 22:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3176C2080C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 22:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="RmY9zmWl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="a5oMsq71"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgH1WRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 18:17:37 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:46158 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726524AbgH1WRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 18:17:35 -0400
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id EF6C4401D7;
        Fri, 28 Aug 2020 22:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1598653055; bh=LCsQ+cgOqQF2vrVYBMcE1VFefOeGtdtIXi5tHCc2btE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=RmY9zmWl06p3C3pPlV22xmXDhvzeaIlMfcWGq0is0vH/erv2hGdcv8YHACml6nykp
         fuIFI9X1zyPIbiIfw3mWO2bsqbpMGh0086vHhSohRKujA/EX+RRpIP3fexkILT5o2C
         qeglvFS2R/VXv57TBguyDLAXvWe91h6wb0OCQHbI9DiXsubSgGyLVcCNrRwodZlQ5p
         VXseqOWYeUlc36nnfjDQSEXy026sYDIrNrpnKZbuvuVVGGS9SeId9kq7w5c/BVDYG3
         mkLNezLZajjZFub05OmSEqWtOOYL1Sqb1sWy6Q6eGvEpkStvNfA6Dncd8bv/EPTxkd
         2rSNuV8coytrA==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 7BDC2A006D;
        Fri, 28 Aug 2020 22:17:32 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2059.outbound.protection.outlook.com [104.47.36.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 897D440143;
        Fri, 28 Aug 2020 22:17:31 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="a5oMsq71";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UO9CPODYATcRwuQRAjbDxNSLQQrMKrgv8VwqLpJ4b9ofL4rhdHqlegdKdwyvkP8PWOJuZs57GPn6ccjkkvIOweG8+CvC5JQWvn+DABlhtUGcNvfgL4a5I8VvJBkfEfS+LKd+uQvIhry7xBFsVFnpkEXhAt0S7YddM4ULss+0aNB4t6zHbQfY0iAX3QewjhMhybC2nLkRBIT2ZLMgrbMGJOaflvzwpXW4bp2vRjFY1yoGVjFUzYKQoucbw0yAhiIkQEDzY0pdkUqRlMw1l3dmXypCEz/UpeNxpEk1c7BH7Oqd1w1FfmnDC3PGYZo5awBfRrRIpa1kwAhNeFDcphgvjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCsQ+cgOqQF2vrVYBMcE1VFefOeGtdtIXi5tHCc2btE=;
 b=Oy85uiy+WjqQsJlDzUEZpaiGEcTlvl58GYApxVwLYS8Ahha2CR7A5tQxvFnStecnrhHwxWcxC++bQhha3ak02efgO5dc5RnTcr5T6eVkHFJtgaL3ve3y6RntawdW1ceNgAzeT9y94oOhO004LWRaKaXOXYb1bj2VzQWlHaheHPhohodyLY9GYT/Lsl9acOF0l9fYysFUfN06d2fqUFs4uIoQ3AOqWittWGTCh8cVat0QKJc9lAvTcpyIX6I4ZzB5pcZ+YeDAbpqSC8hBFtMg/E5PolJTxn4dZ2Bs6G1Dst5IZr5ZZE7LBinvJmFbr1V/KUX134SUz2hBoYSK3Pz5oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCsQ+cgOqQF2vrVYBMcE1VFefOeGtdtIXi5tHCc2btE=;
 b=a5oMsq71RjopLZ6qEmZUO5nioocS8KCr+FEiNzlhXlalo68j/7fyvx0Ny79fb0D5tGzrg1zCL8npT6qrq9kL4NOaQM4nkVewYBUhWnEBM17FM446/Tyx7LSNW770O6nGX8KSY5eu40Ctw6TfhR9b8V7N5po82PD988iVnTZXtJg=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BY5PR12MB3940.namprd12.prod.outlook.com (2603:10b6:a03:1a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Fri, 28 Aug
 2020 22:17:29 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::19e1:33b2:5f25:5c5e]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::19e1:33b2:5f25:5c5e%5]) with mapi id 15.20.3326.023; Fri, 28 Aug 2020
 22:17:29 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Mike Rapoport <rppt@kernel.org>
CC:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH] arc: fix memory initialization for systems with two
 memory banks
Thread-Topic: [PATCH] arc: fix memory initialization for systems with two
 memory banks
Thread-Index: AQHWfVnE+wbCaXrx00eW6yr2ORpnhKlOF1MA
Date:   Fri, 28 Aug 2020 22:17:28 +0000
Message-ID: <5595f585-810d-c84d-3562-34398eccce10@synopsys.com>
References: <20200828163902.4548-1-rppt@kernel.org>
In-Reply-To: <20200828163902.4548-1-rppt@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [2601:641:c100:b9:9593:5cb1:ebc3:8ee9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d838a046-2059-4d62-f296-08d84ba026d6
x-ms-traffictypediagnostic: BY5PR12MB3940:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB3940F2DFC865C22E9024C187B6520@BY5PR12MB3940.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rs72KclaFB4eGQTA7LGVpiIlh4gOhSCh7fhmUOn7s6W/FNKhG+gLJhe41vItTHGwmCPHPullYjtV1OjiVlOAa3RfvXjtXTkahZ+zT85czc8paqeZWXYy7Rt5We1+qoW0V/fOf/I4NuM1DzHWshj2h46+hkOKU9KmCGdYgArTRO6ySQhPUKHi5ng07qgn0Zn167GK+FTibGN0Geot80NVdiCWESJS82RHks/l+QXfXGOO2VcX0pp8MPYlSkgVb7zD1Nhssxt2uLIhyCN7rUeL436iAsBeHqzUhozFsM1lOTKXTIosLiEi/O8RFGnX/JLSgDcdp4bmJ0VJGZ+ao2at0Cj9zog8aTTWImXlWfuSa4R8jJiv7xXyMaFXpkR5Nl4X
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(366004)(376002)(39860400002)(396003)(36756003)(83380400001)(5660300002)(15650500001)(6916009)(71200400001)(6512007)(8676002)(31686004)(316002)(6486002)(8936002)(478600001)(2906002)(86362001)(66556008)(76116006)(66446008)(64756008)(66946007)(66476007)(186003)(31696002)(54906003)(2616005)(6506007)(53546011)(4326008)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 0SiKctH65gFlLzmw1zm5n5MRhq9Fj5j+EX+w0q8pZmEbdpayzl3zHxRamUkdX4ltfxlsFchYbQjNtmpdmTN85TPduzINFmIratzFniJniXC5w0xNbA2ad4uq97Rtp6p3F3QnS0deXuCuqEz/06SqziUgqxIO+J0P6sFhkv8c8iiYnvMGtJNfcGm4OzlZr31PxcSEsBc9HiXu6oGuXFWCQyjZL00eXlS6h8ISGGRqpUD6i/RCYZM3SjS2cM+nRBZvDuSr65M/eRV3gThsYDWIRe61YW74Gc4XTl++dRJVBCN+a5EVxTpDDQjoqnfYQo0HCYXGcBcV04QMJE1A2Ba03ZlYmc5ypngNuYrBYUEfK6yUMa/shsfCbnhbHC+WuxyC2ifPU0TdW0InYZqcb9LJPhQqrR2eUPBsAi2K2NRtDVTZ+kow8mEyI+FZxc4lDTK/4EqTTkzgqhKBtES3uo2Do9PI5rj0qiY8vwP6FpRT+IQJ540QzTb0uE9hzaM4m6WysXG8NTcAxJ46vGFZA0StnMOliP2oOJnz+aft+moex0ml/iCXMM5zzy4dIVX10JMFhDh5HujEF+5VgxugeoGKVovsTle6AxvIhcsTs0YVnvZIEu/WnmNXgxtSqD51CvrxWbxWw6SGTqMYxb/JQY/VxcaaCx2Q3+TJTNg/Y/fB09uYRv1wjbcMEy5d27atlAsadLCgW9vw47c2JyvwicPLrg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <62E9BC9972BBE94BBD94FAB87C167958@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d838a046-2059-4d62-f296-08d84ba026d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2020 22:17:28.9727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GSd5Rr3CbZ/SA6Utcc0bPLf6EbcHKk7t2Hela8jQqWlPd+q7yG8kqbrKQGFDjiaV7Z8aYSDJAoklFc+1QfoxBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3940
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWlrZSwNCg0KT24gOC8yOC8yMCA5OjM5IEFNLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0KPiBG
cm9tOiBNaWtlIFJhcG9wb3J0IDxycHB0QGxpbnV4LmlibS5jb20+DQo+DQo+IFJld29yayBpZiBt
ZW1vcnkgbWFwIGluaXRpYWxpemF0aW9uIGJyb2tlIGluaXRpYWxpemF0aW9uIG9mIEFSQyBzeXN0
ZW1zDQo+IHdpdGggdHdvIG1lbW9yeSBiYW5rcy4gQmVmb3JlIHRoZXNlIGNoYW5nZXMsIG1lbWJs
b2NrIHdhcyBub3QgYXdhcmUgb2YNCj4gbm9kZXMgY29uZmlndXJhdGlvbiBhbmQgdGhlIG1lbW9y
eSBtYXAgd2FzIGFsd2F5cyBhbGxvY2F0ZWQgZnJvbSB0aGUNCj4gImxvd21lbSIgYmFuay4gQWZ0
ZXIgdGhlIGFkZGl0aW9uIG9mIG5vZGUgaW5mb3JtYXRpb24gdG8gbWVtYmxvY2ssIHRoZSBjb3Jl
DQo+IG1tIGF0dGVtcHRzIHRvIGFsbG9jYXRlIHRoZSBtZW1vcnkgbWFwIGZvciB0aGUgImhpZ2ht
ZW0iIGJhbmsgZnJvbSBpdHMNCj4gbm9kZS4gVGhlIGFjY2VzcyB0byB0aGlzIG1lbW9yeSB1c2lu
ZyBfX3ZhKCkgZmFpbHMgYmVjYXVzZSBpdCBjYW4gYmUgb25seQ0KPiBhY2Nlc3NlZCB1c2luZyBr
bWFwLg0KPg0KPiBBbnRoZXIgcHJvYmxlbSB0aGF0IHdhcyB1bmNvdmVyZWQgaXMgdGhhdCB7bWlu
LG1heH1faGlnaF9wZm4gYXJlIGNhbGN1bGF0ZWQNCj4gZnJvbSB1NjQgaGlnaF9tZW1fc3RhcnQg
dmFyaWFibGUgd2hpY2ggcHJldmVudHMgdHJ1bmNhdGlvbiB0byAzMi1iaXQNCj4gcGh5c2ljYWwg
YWRkcmVzcyBhbmQgdGhlIFBGTiB2YWx1ZXMgYXJlIGFib3ZlIHRoZSBub2RlIGFuZCB6b25lIGJv
dW5kYXJpZXMuDQoNCk5vdCBzdXJlIGlmIEkgcXVpdGUgZm9sbG93IHRoaXMgcGFydC4gV2Ugc2hv
dWxkIG5vdCBiZSByZWx5aW5nIG9uIHRydW5jYXRpb246IHRoZQ0KcGZuIHNob3VsZCBiZSBkZXJp
dmVkIG9mZiBvZiB6b25lIGFkZHJlc3NlcyA/DQoNCj4gVXNlIHBoeXNfYWRkcl90IHR5cGUgZm9y
IGhpZ2hfbWVtX3N0YXJ0IGFuZCBoaWdoX21lbV9zaXplIHRvIGVuc3VyZQ0KPiBjb3JyZXNwb25k
ZW5jZSBiZXR3ZWVuIFBGTnMgYW5kIGhpZ2htZW0gem9uZSBib3VuZGFyaWVzIGFuZCByZXNlcnZl
IHRoZQ0KPiBlbnRpcmUgaGlnaG1lbSBiYW5rIHVudGlsIG1lbV9pbml0KCkgdG8gYXZvaWQgYWNj
ZXNzZXMgdG8gaXQgYmVmb3JlIGhpZ2htZW0NCj4gaXMgZW5hYmxlZC4NCj4NCj4gRml4ZXM6IDUx
OTMwZGY1ODAxZSAoIm1tOiBmcmVlX2FyZWFfaW5pdDogYWxsb3cgZGVmaW5pbmcgbWF4X3pvbmVf
cGZuIGluIGRlc2NlbmQgaW5nIG9yZGVyIikNCj4gU2lnbmVkLW9mZi1ieTogTWlrZSBSYXBvcG9y
dCA8cnBwdEBsaW51eC5pYm0uY29tPg0KDQpUaHggZm9yIHRoZSBmaXguIEkgdmVyaWZpZWQgdGhh
dCBhIDIgbWVtIGJhbmsgc3lzdGVtIHdpdGggSElHSE1FTSBlbmFibGVkIG5vdw0Kd29ya3MgYWdh
aW4uDQpBbmQgSSd2ZSBhbHNvIGFkZGVkIGEgY291cGxlIG9mIGxpbmVzIHRvIGNoYW5nZWxvZyB0
byBkZXNjcmliZSBob3cgdG8gdGVzdCBzdWNoIGENCmNvbmZpZy4NCg0KfMKgwqDCoCBUbyB0ZXN0
IHRoaXM6DQp8wqDCoMKgIDEuIEVuYWJsZSBISUdITUVNIGluIEFSQyBjb25maWcNCnzCoMKgwqAg
Mi4gRW5hYmxlIDIgbWVtb3J5IGJhbmtzIGluIGhhcHNfaHMuZHRzICh1bmNvbW1lbnQgdGhlIDJu
ZCBiYW5rKQ0KDQoNCj4gLS0tDQo+ICBhcmNoL2FyYy9tbS9pbml0LmMgfCAyNyArKysrKysrKysr
KysrKysrLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAx
MSBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJjL21tL2luaXQuYyBiL2Fy
Y2gvYXJjL21tL2luaXQuYw0KPiBpbmRleCBmODg2YWM2OWQ4YWQuLjNhMzViODJhNzE4ZSAxMDA2
NDQNCj4gLS0tIGEvYXJjaC9hcmMvbW0vaW5pdC5jDQo+ICsrKyBiL2FyY2gvYXJjL21tL2luaXQu
Yw0KPiBAQCAtMjYsOCArMjYsOCBAQCBzdGF0aWMgdW5zaWduZWQgbG9uZyBsb3dfbWVtX3N6Ow0K
PiAgDQo+ICAjaWZkZWYgQ09ORklHX0hJR0hNRU0NCj4gIHN0YXRpYyB1bnNpZ25lZCBsb25nIG1p
bl9oaWdoX3BmbiwgbWF4X2hpZ2hfcGZuOw0KPiAtc3RhdGljIHU2NCBoaWdoX21lbV9zdGFydDsN
Cj4gLXN0YXRpYyB1NjQgaGlnaF9tZW1fc3o7DQo+ICtzdGF0aWMgcGh5c19hZGRyX3QgaGlnaF9t
ZW1fc3RhcnQ7DQo+ICtzdGF0aWMgcGh5c19hZGRyX3QgaGlnaF9tZW1fc3o7DQo+ICAjZW5kaWYN
Cj4gIA0KPiAgI2lmZGVmIENPTkZJR19ESVNDT05USUdNRU0NCj4gQEAgLTY5LDYgKzY5LDcgQEAg
dm9pZCBfX2luaXQgZWFybHlfaW5pdF9kdF9hZGRfbWVtb3J5X2FyY2godTY0IGJhc2UsIHU2NCBz
aXplKQ0KPiAgCQloaWdoX21lbV9zeiA9IHNpemU7DQo+ICAJCWluX3VzZSA9IDE7DQo+ICAJCW1l
bWJsb2NrX2FkZF9ub2RlKGJhc2UsIHNpemUsIDEpOw0KPiArCQltZW1ibG9ja19yZXNlcnZlKGJh
c2UsIHNpemUpOw0KPiAgI2VuZGlmDQo+ICAJfQ0KPiAgDQo+IEBAIC0xNTcsNyArMTU4LDcgQEAg
dm9pZCBfX2luaXQgc2V0dXBfYXJjaF9tZW1vcnkodm9pZCkNCj4gIAltaW5faGlnaF9wZm4gPSBQ
Rk5fRE9XTihoaWdoX21lbV9zdGFydCk7DQo+ICAJbWF4X2hpZ2hfcGZuID0gUEZOX0RPV04oaGln
aF9tZW1fc3RhcnQgKyBoaWdoX21lbV9zeik7DQo+ICANCj4gLQltYXhfem9uZV9wZm5bWk9ORV9I
SUdITUVNXSA9IG1heF9oaWdoX3BmbjsNCj4gKwltYXhfem9uZV9wZm5bWk9ORV9ISUdITUVNXSA9
IG1pbl9sb3dfcGZuOw0KPiAgDQo+ICAJaGlnaF9tZW1vcnkgPSAodm9pZCAqKShtaW5faGlnaF9w
Zm4gPDwgUEFHRV9TSElGVCk7DQo+ICAJa21hcF9pbml0KCk7DQo+IEBAIC0xNjYsMjIgKzE2Nywy
NiBAQCB2b2lkIF9faW5pdCBzZXR1cF9hcmNoX21lbW9yeSh2b2lkKQ0KPiAgCWZyZWVfYXJlYV9p
bml0KG1heF96b25lX3Bmbik7DQo+ICB9DQo+ICANCj4gLS8qDQo+IC0gKiBtZW1faW5pdCAtIGlu
aXRpYWxpemVzIG1lbW9yeQ0KPiAtICoNCj4gLSAqIEZyZWVzIHVwIGJvb3RtZW0NCj4gLSAqIENh
bGN1bGF0ZXMgYW5kIGRpc3BsYXlzIG1lbW9yeSBhdmFpbGFibGUvdXNlZA0KPiAtICovDQo+IC12
b2lkIF9faW5pdCBtZW1faW5pdCh2b2lkKQ0KPiArc3RhdGljIHZvaWQgX19pbml0IGhpZ2htZW1f
aW5pdCh2b2lkKQ0KPiAgew0KPiAgI2lmZGVmIENPTkZJR19ISUdITUVNDQo+ICAJdW5zaWduZWQg
bG9uZyB0bXA7DQo+ICANCj4gLQlyZXNldF9hbGxfem9uZXNfbWFuYWdlZF9wYWdlcygpOw0KPiAr
CW1lbWJsb2NrX2ZyZWUoaGlnaF9tZW1fc3RhcnQsIGhpZ2hfbWVtX3N6KTsNCj4gIAlmb3IgKHRt
cCA9IG1pbl9oaWdoX3BmbjsgdG1wIDwgbWF4X2hpZ2hfcGZuOyB0bXArKykNCj4gIAkJZnJlZV9o
aWdobWVtX3BhZ2UocGZuX3RvX3BhZ2UodG1wKSk7DQo+ICAjZW5kaWYNCj4gK30NCj4gIA0KPiAr
LyoNCj4gKyAqIG1lbV9pbml0IC0gaW5pdGlhbGl6ZXMgbWVtb3J5DQo+ICsgKg0KPiArICogRnJl
ZXMgdXAgYm9vdG1lbQ0KPiArICogQ2FsY3VsYXRlcyBhbmQgZGlzcGxheXMgbWVtb3J5IGF2YWls
YWJsZS91c2VkDQo+ICsgKi8NCj4gK3ZvaWQgX19pbml0IG1lbV9pbml0KHZvaWQpDQo+ICt7DQo+
ICAJbWVtYmxvY2tfZnJlZV9hbGwoKTsNCj4gKwloaWdobWVtX2luaXQoKTsNCj4gIAltZW1faW5p
dF9wcmludF9pbmZvKE5VTEwpOw0KPiAgfQ0KDQo=
