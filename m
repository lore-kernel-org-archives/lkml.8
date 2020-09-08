Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB817C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C0CF2087D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="R4xIi1MC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="EHOLzukB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732067AbgIHRks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:40:48 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:48420 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732056AbgIHRk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 13:40:29 -0400
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 68AF040170;
        Tue,  8 Sep 2020 17:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1599586826; bh=9S/1xYqezK7raDc5TJBoybtcTkSPaRVjFungRzAA+rU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=R4xIi1MCXuDOiZblBvaiLpMG6Z63AY0eMYolFmj7flUGjfZ47wNy5K/I2gd+GD52l
         8vYhzqrP3g271lKvljLoJNm1PLgzYM4zKAZJTFilE/cGkLS/Cs4OtLHWL/EURNNbRS
         3UXt0j1svkmj0rsGYCDU9svxshs+mTAGlOoqTf0N0JPR1Ack+rQCpplbzSZ2IYvYEc
         j/09mZvLke7B80xj/Kb1T5XnS1Vj6Jd8yBHc3HHaogfLnhQf2JneIyC+TXziT2v+H8
         1+4OzDnSclRZo5RLq2ei0Yu+moBQ9QtE+FFByhOctiiHC3wRxkndvgSv+jfH9IkFH2
         zJTWdeLtUBOjw==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 0655FA006D;
        Tue,  8 Sep 2020 17:40:24 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2059.outbound.protection.outlook.com [104.47.36.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 550FE8023C;
        Tue,  8 Sep 2020 17:40:21 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="EHOLzukB";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SEKZ0L2OweAKeUagpsU5yEjYmRN+S3rPxvyQdBHgfFBxCz6LUD2rrZunDY5M/LZf2ks6YF+BB/WzCKlKx0f6eNvE3pTofiWwQ2pahcTDx66uZKkvaXs6T/UAmzAO0tAEfms8N2Ak1Wpfwp282Gdxc8Wo1r1ZH4P5NAqQhxv/AbQeHhqo7mvBt5jXSoIPPgNTK66XTgkGXUmqb55zMuYbxe1sAT0L9zgPFHVXSWkPegDX2Y3D0Dnl1i54oEmiDa2gYAkhz32yw6Nk210Tc6VDNbyDxUtvnuznXFNvacq1pi7x2XVu0q7Nbau+FqLSi5m8cOhU6VE91QnqDqNtNYggOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9S/1xYqezK7raDc5TJBoybtcTkSPaRVjFungRzAA+rU=;
 b=PoHGQv59ks0dUL77d14kgt4AIrb3nIgH/JuzUkNwQkIz8IbtDg5BwuRUKqSE+OB4YnaIBxeTBM5nxjAjlUAGKPdDOUjvlhHFJ8zJRBafATM4h6NSkcOxSnv7ILDXQqE9ZpTnk9EBc7kCAat9SBObEjsEDl44HaK6555Og5up7AxKxi3ebz3bpthWabpe8Ncq3n/+jZ3ySUFd+6JJ93uvCudleDzRhQWFhVFfKYMvsUj60qqeQbbu7TvUHHiOJgAlix1dmEF9jueS7R6SxkbiXx71mxoLxMlDErxzLjpYW9gKleVLshixoFIAh1NWOho1lo3i3JStbB6Qt+lCTgx5JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9S/1xYqezK7raDc5TJBoybtcTkSPaRVjFungRzAA+rU=;
 b=EHOLzukBGvIEXKlrbD6diW84p3Kw7uT9P/a+mo1honF+CE3BJs0BytKkflcBwlNUs123hnmuNmaAoJQ37S5lL1cwpdB4QGu/9UdnrlWBOGRCo6Nu6j8MfFb88wi9QT+sslicJ89dygjYZKzZkbVve+/uWzU7M7Hhqt7M39Tckng=
Received: from BYAPR12MB2917.namprd12.prod.outlook.com (2603:10b6:a03:130::14)
 by BY5PR12MB3892.namprd12.prod.outlook.com (2603:10b6:a03:1a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Tue, 8 Sep
 2020 17:40:18 +0000
Received: from BYAPR12MB2917.namprd12.prod.outlook.com
 ([fe80::c98f:a13f:fd88:c209]) by BYAPR12MB2917.namprd12.prod.outlook.com
 ([fe80::c98f:a13f:fd88:c209%7]) with mapi id 15.20.3348.019; Tue, 8 Sep 2020
 17:40:18 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Yu Chen <chenyu56@huawei.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "john.stultz@linaro.org" <john.stultz@linaro.org>,
        "suzhuangluan@hisilicon.com" <suzhuangluan@hisilicon.com>,
        "kongfei@hisilicon.com" <kongfei@hisilicon.com>,
        "liuyu712@hisilicon.com" <liuyu712@hisilicon.com>,
        "wanghu17@hisilicon.com" <wanghu17@hisilicon.com>,
        "butao@hisilicon.com" <butao@hisilicon.com>,
        "chenyao11@huawei.com" <chenyao11@huawei.com>,
        "fangshengzhou@hisilicon.com" <fangshengzhou@hisilicon.com>,
        "lipengcheng8@huawei.com" <lipengcheng8@huawei.com>,
        "songxiaowei@hisilicon.com" <songxiaowei@hisilicon.com>,
        "xuyiping@hisilicon.com" <xuyiping@hisilicon.com>,
        "xuyoujun4@huawei.com" <xuyoujun4@huawei.com>,
        "yudongbin@hisilicon.com" <yudongbin@hisilicon.com>,
        "zangleigang@hisilicon.com" <zangleigang@hisilicon.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Binghui Wang <wangbinghui@hisilicon.com>
Subject: Re: [PATCH v6 04/13] usb: dwc3: Add splitdisable quirk for Hisilicon
 Kirin Soc
Thread-Topic: [PATCH v6 04/13] usb: dwc3: Add splitdisable quirk for Hisilicon
 Kirin Soc
Thread-Index: AQHWhRflsW/2v6VeOUihVvdrflKGPqldVTkQgADt5ACAAMDsAA==
Date:   Tue, 8 Sep 2020 17:40:17 +0000
Message-ID: <d1682eb9-10d4-3089-b888-423f70a7fb55@synopsys.com>
References: <20190420064019.57522-1-chenyu56@huawei.com>
 <20190420064019.57522-5-chenyu56@huawei.com>
 <20200907150631.70e1bce0@coco.lan> <874ko9of80.fsf@kernel.org>
 <20200907165000.7c42a6da@coco.lan> <87r1rcn6j9.fsf@kernel.org>
In-Reply-To: <87r1rcn6j9.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [98.248.94.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06faa532-5dd1-4a45-ad2c-08d8541e4075
x-ms-traffictypediagnostic: BY5PR12MB3892:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB38927036A0D68FFA4ED1A248AA290@BY5PR12MB3892.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hrbr+aNVMFLOIlk5cYHARBK8n7rUyecDJrjnnyNw1ChTmVgJKEv/fcy+/J+ovXvKcNR+Jj0W1T5c9ro1anW/jeeGaOT1EnHD+XprbNl/LD8ZskODNEBZTl/dxUc0VeOiTTpXub9UDwVUcG4XDV5/l12CLXEZXjcnjD4/4kFT1NUF8WQTfrKTEEpqTUffDFvgiMxrP0RPgGyjiWGmlETrANCPLO7S6HIctoLt205y3WPQVMLpP3n2Q2Ms+RIrR7HD/Rk/cX+epyfq1tJlNSsfnCg4S8LyAL4H+Cm8bgEIwRFwfrx6c/QQXsiAedc8siZYNl5c4wpfM1iW/l/fVGlCsizylbGRRbPmjP6+QfXKQMEKVB6TPx8qpAbwJXt5hN+X
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2917.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(366004)(376002)(136003)(396003)(71200400001)(66446008)(64756008)(66556008)(66476007)(86362001)(66946007)(2906002)(54906003)(110136005)(6512007)(83380400001)(4326008)(316002)(31686004)(8676002)(76116006)(26005)(186003)(6506007)(6486002)(31696002)(5660300002)(478600001)(2616005)(36756003)(8936002)(7416002)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: fV1uAwKinEfSim3+jUZ3l+RJtAX7ZbGLSoEhBkQbNFchdK9O1h+86OJyuRpZPeFUoE/LIcIYXqfdtlKPNcgKLSVLJqkPytkBr1v/CsHAtFCFmuWSHibSei/bibYN5i9Ysd2rNgrBFn9KhZY8yF0MpetMKeiedjfuauQ4lYD0A3/Rme4SdEu0Ucc5f4PA6uHTTSsL3wicZKBWisJgXqPoeTNr2Hc+PYRcIPwafMr6w/7RPDQIe3xxUWE8ECb/+REwxAwkdzcEWVzr46ll9Gq5iBR9GanTGKST42NzKcuhxbOdvhZar9FJ7KXOZCRE+xBx8i9RJgln7FuMiwvhkA/Pb0vKNxsYb7gWXPycv2nPYk0YhBCwGCPwwfN7ARIXFFVfO29vBQPElOy+iKFtxOg64ag5twgEY1gzLtEyNeO7+jdZ/6kmYaLXdJvS+VNkSziHyby2YgVtJMaEaJ1nrjPqIuvMZqs3TR+766sVre6SiHjlHoz+15H6k1aTja8TDPYfVUHC3OJrKEWAz46QUIPxLmBUfWaaqrhJ3W8No8eXiN8pfA/Zp6dRkmLqMi/nCSgZqXbP2VuUAEsqnsjX13/ObjGPeXrGvv8kgRRkrK9yvtk/WUFfVZ0FVdq3XBL0/LNuppA2mXmTcghzjf2S1wDkKQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <179E19F54BFA1F4C86C8BD0BBF85BAF3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2917.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06faa532-5dd1-4a45-ad2c-08d8541e4075
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2020 17:40:17.6693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tPs8xOnLZETlUgLaK98M81DhmkVA0D3cDpLtxvC/Bimxq/j7wdlIn/eaznB7tudCGkTs6rcJyRavzAakHC6KGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3892
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RmVsaXBlIEJhbGJpIHdyb3RlOg0KPiBIaSwNCj4NCj4gTWF1cm8gQ2FydmFsaG8gQ2hlaGFiIDxt
Y2hlaGFiK2h1YXdlaUBrZXJuZWwub3JnPiB3cml0ZXM6DQo+Pj4+IEkgdGVzdGVkIGhlcmUsIHRv
Z2V0aGVyIHdpdGggdGhlIEhpa2V5IDk3MCBwaHkgUkZDIHBhdGNoZXMgSSBzZW50DQo+Pj4+IGxh
c3Qgd2Vlay4NCj4+Pj4NCj4+Pj4gV2l0aG91dCB0aGlzIHBhdGNoLCB0aGUgVVNCIEhJRCBkcml2
ZXIgcmVjZWl2ZXMgLUVQUk9UTyBmcm9tDQo+Pj4+IHN1Ym1pdHRlZCBVUkJzLCBjYXVzaW5nIGl0
IHRvIGVudGVyIGludG8gYW4gZW5kbGVzcyByZXNldCBjeWNsZQ0KPj4+PiBvbiBldmVyeSA1MDAg
bXMsIGF0IHRoZSBoaWRfaW9fZXJyb3IoKSBsb2dpYy4gIA0KPj4+PiBUZXN0ZWQtYnk6IE1hdXJv
IENhcnZhbGhvIENoZWhhYiA8bWNoZWhhYitodWF3ZWlAa2VybmVsLm9yZz4NCj4+Pj4NCj4+Pj4g
SWYgeW91IHByZWZlciwgSSBjYW4gcmUtc3VibWl0IHRoaXMgb25lIHdpdGggbXkgU09CLiAgDQo+
Pj4gUGxlYXNlIGRvLCBidXQgc2luY2UgeW91J3JlIGNoYW5naW5nIGRldmljZSB0cmVlLCBJIG5l
ZWQgUm9iJ3MgYWNrZWQtYnkuDQo+PiBPaywgSSdsbCBkbyB0aGF0Lg0KPiB0aGFua3MNCj4NCj4+
Pj4gRW0gU2F0LCAyMCBBcHIgMjAxOSAxNDo0MDoxMCArMDgwMA0KPj4+PiBZdSBDaGVuIDxjaGVu
eXU1NkBodWF3ZWkuY29tPiBlc2NyZXZldToNCj4+Pj4gIA0KPj4+Pj4gU1BMSVRfQk9VTkRBUllf
RElTQUJMRSBzaG91bGQgYmUgc2V0IGZvciBEZXNpZ25XYXJlIFVTQjMgRFJEIENvcmUNCj4+Pj4+
IG9mIEhpc2lsaWNvbiBLaXJpbiBTb2Mgd2hlbiBkd2MzIGNvcmUgYWN0IGFzIGhvc3QuICANCj4+
PiBpcyB0aGlzIEtpcmluLXNwZWNpZmljIG9yIGlzIHRoaXMgc29tZXRoaW5nIHRoYXQgd2Ugc2hv
dWxkIGRvIGEgcmV2aXNpb24NCj4+PiBjaGVjaz8gDQo+PiBJJ3ZlIG5vIGlkZWEuIEkgZG9uJ3Qg
aGF2ZSBhbnkgZGF0YXNoZWV0cyBmcm9tIHRoaXMgZGV2aWNlLg0KPiBJIHNlZQ0KPg0KPj4+IFdo
eSBkb2VzIGl0IGFmZmVjdCBvbmx5IEhpa2V5IGtpcmluPyANCj4+IEFzIEpvaG4gU3R1bHR6IGRp
ZG4ndCByZS1zdWJtaXQgdGhpcyBvbmUgKGFuZCBsb29raW5nIGF0IHRoZSBEVA0KPj4gYmV0d2Vl
biBLaXJpbiA5NjAgYW5kIDk3MCBmcm9tIHRoZSBvcmlnaW5hbCBLZXJuZWwgNC45IG9mZmljaWFs
DQo+PiBkcml2ZXJzKSwgSSBzdXNwZWN0IHRoYXQgb25seSBLaXJpbiA5NzAgcmVxdWlyZXMgdGhp
cyBxdWlyay4NCj4+DQo+PiBJdCBjb3VsZCB3ZWxsIGJlIGR1ZSB0byBzb21lIER3YzMgcmV2aXNp
b24sIGJ1dCBpdCBjb3VsZCBhbHNvIGJlIGR1ZQ0KPj4gdG8gc29tZSBkaWZmZXJlbmNlcyBhdCB0
aGUgVVNCIHBhcnQgb2YgdGhlIFNvQywgYXMgdGhlcmUgYXJlIGENCj4gdGhlIHJlYXNvbiBJIGFz
ayBpcyB0aGF0IGlmIGl0J3MgY2F1c2VkIGJ5IGR3YzMgcmV2aXNpb24sIHRoZW4gd2UgZG9uJ3QN
Cj4gbmVlZCB0aGUgZXh0cmEgZHQgcHJvcGVydHksIHdlIGNhbiByZWx5IG9uIGEgcmV2aXNpb24g
Y2hlY2suIElmIGl0J3MNCj4gc29tZXRoaW5nIHRoYXQgY2FuJ3QgYmUgZGV0ZWN0ZWQgaW4gcnVu
dGltZSwgdGhlbiB3ZSBuZWVkIGEgcHJvcGVydHkuDQo+DQo+PiBmZXcgb3RoZXIgdGhpbmdzIGRp
ZmZlcmVudCBiZXR3ZWVuIGhpa2V5IDk2MCBhbmQgOTcwOiBpdCBoYXMgYQ0KPj4gZGlmZmVyZW50
IFBIWSBkcml2ZXIsIGFuZCB0aGVyZSBhcmUgYWxzbyBzb21lIGRpZmZlcmVuY2VzIGF0IHRoZQ0K
Pj4gVVNCIEhVQiB3aGljaCBpcyBjb25uZWN0ZWQgaW50byBpdC4NCj4+DQo+PiBPbiBib3RoIGRl
dmljZXMsIHRoZSBVU0IgcGh5c2ljYWwgcG9ydHMgYXJlIGFjdHVhbGx5IGNvbm5lY3RlZA0KPj4g
aW50byBhIEhVQi4gSW4gdGhlIGNhc2Ugb2YgSGlrZXkgOTcwLCB0aGUgaHViIHNlZW1zIHRvIGJl
IGENCj4+IFRJIFRVU0I4MDQxIDQtUG9ydCBIdWI6DQo+PiAJDQo+PiAJJCBsc3VzYg0KPj4gCUJ1
cyAwMDIgRGV2aWNlIDAwMjogSUQgMDQ1MTo4MTQwIFRleGFzIEluc3RydW1lbnRzLCBJbmMuIFRV
U0I4MDQxIDQtUG9ydCBIdWINCj4+IAlCdXMgMDAyIERldmljZSAwMDE6IElEIDFkNmI6MDAwMyBM
aW51eCBGb3VuZGF0aW9uIDMuMCByb290IGh1Yg0KPj4gCUJ1cyAwMDEgRGV2aWNlIDAwNDogSUQg
MDkwYzoxMDAwIFNpbGljb24gTW90aW9uLCBJbmMuIC0gVGFpd2FuIChmb3JtZXJseSBGZWl5YSBU
ZWNobm9sb2d5IENvcnAuKSBGbGFzaCBEcml2ZQ0KPj4gCUJ1cyAwMDEgRGV2aWNlIDAwMzogSUQg
NDEzYzozMDFhIERlbGwgQ29tcHV0ZXIgQ29ycC4gRGVsbCBNUzExNiBPcHRpY2FsIE1vdXNlDQo+
PiAJQnVzIDAwMSBEZXZpY2UgMDAyOiBJRCAwNDUxOjgxNDIgVGV4YXMgSW5zdHJ1bWVudHMsIElu
Yy4gVFVTQjgwNDEgNC1Qb3J0IEh1Yg0KPj4gCUJ1cyAwMDEgRGV2aWNlIDAwMTogSUQgMWQ2Yjow
MDAyIExpbnV4IEZvdW5kYXRpb24gMi4wIHJvb3QgaHViDQo+Pg0KPj4+IFdoYXQncyB0aGUgZHdj
MyByZXZpc2lvbiBvbg0KPj4+IHRoYXQgU29DIChncmVwIFNOUFNJRCAvc3lzL2tlcm5lbC9kZWJ1
Z2ZzLypkd2MzL3JlZ2R1bXApPw0KPj4gCUdTTlBTSUQgPSAweDMzMzEzMTMwDQo+IFRoaXMgaXNu
J3QgZXZlbiBsaXN0ZWQgYXMgYSBrbm93biByZXZpc2lvbiBpbiBkd2MzL2NvcmUuaC4gVGhpbmgs
IGNvdWxkDQo+IHRoZSBpc3N1ZSBiZWluZyBkZXNjcmliZWQgaGVyZSBjYXVzZWQgYnkgYSBrbm93
biBFcnJhdHVtIHdpdGggdGhpcw0KPiBwYXJ0aWN1bGFyIHJldmlzaW9uPw0KDQpJZiB5b3UgaGF2
ZSBhIFNUQVIgaXNzdWUgbnVtYmVyLCB0aGVuIEkgbWF5IGJlIGFibGUgdG8gbG9vayBpdCB1cC4N
Cg0KQnR3LCBHTlNQU0lEIHJlZ2lzdGVyIGlzIHRoZSBJRCBmb3IgRFdDX3VzYjMxIElQLiBGb3Ig
RFdDX3VzYjMxIGFuZA0KRFdDX3VzYjMyLCB3ZSBuZWVkIHRvIHJlYWQgdGhlIHZlcnNpb24gbnVt
YmVyIGFuZCB2ZXJzaW9uIHR5cGUgcmVnaXN0ZXJzDQoob2Zmc2V0IDB4YzFhMCBhbmQgMHhjMWE0
IHJlc3BlY3RpdmVseSkuDQoNCldlIG5lZWQgdG8gYWRkIHRoZXNlIHJlZ2lzdGVycyB0byB0aGUg
cmVnaXN0ZXIgZHVtcC4NCg0KQlIsDQpUaGluaA0KDQo+DQo+Pj4+PiArCQlyZWcgPSBkd2MzX3Jl
YWRsKGR3Yy0+cmVncywgRFdDM19HVUNUTDMpOw0KPj4+Pj4gKwkJcmVnIHw9IERXQzNfR1VDVEwz
X1NQTElURElTQUJMRTsNCj4+Pj4+ICsJCWR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19HVUNU
TDMsIHJlZyk7DQo+Pj4+PiArCX0NCj4+Pj4+ICt9DQo+Pj4+PiArI2Vsc2UNCj4+Pj4+ICsjZGVm
aW5lIGR3YzNfY29tcGxldGUgTlVMTA0KPj4+Pj4gICNlbmRpZiAvKiBDT05GSUdfUE1fU0xFRVAg
Ki8NCj4+Pj4+ICANCj4+Pj4+ICBzdGF0aWMgY29uc3Qgc3RydWN0IGRldl9wbV9vcHMgZHdjM19k
ZXZfcG1fb3BzID0gew0KPj4+Pj4gIAlTRVRfU1lTVEVNX1NMRUVQX1BNX09QUyhkd2MzX3N1c3Bl
bmQsIGR3YzNfcmVzdW1lKQ0KPj4+Pj4gKwkuY29tcGxldGUgPSBkd2MzX2NvbXBsZXRlLCAgDQo+
Pj4gd2h5IGlzIHRoaXMgZG9uZSBvbiBjb21wbGV0ZT8gV2h5IGNhbid0IGl0IGJlIGRvbmUgYXQg
dGhlIGVuZCBvZg0KPj4+IGR3YzNfcmVzdW1lKCk/DQo+PiBBZ2Fpbiwgbm8gaWRlYS4gSSBkaWRu
J3QgYWN0dWFsbHkgdHJpZWQgdG8gc3VzcGVuZC9yZXN1bWUuDQo+Pg0KPj4gTWF5YmUgdGhlIG9y
aWdpbmFsIGF1dGhvciBjYW4gc2hlZCBhIGxpZ2h0IG9uIGl0Lg0KPiB5ZWFoLCB3b3VsZCBiZSBu
aWNlIDotKQ0KPg0KDQo=
