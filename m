Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9034EC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 07:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6617E24656
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 07:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbgAVHuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 02:50:23 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:60629 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgAVHuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 02:50:23 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 00M7oJeR005548, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (smtpsrv.realtek.com[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 00M7oJeR005548
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jan 2020 15:50:19 +0800
Received: from RTEXMB05.realtek.com.tw (172.21.6.98) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 22 Jan 2020 15:50:19 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 22 Jan 2020 15:50:18 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::d9c5:a079:495e:b999]) by
 RTEXMB04.realtek.com.tw ([fe80::d9c5:a079:495e:b999%6]) with mapi id
 15.01.1779.005; Wed, 22 Jan 2020 15:50:18 +0800
From:   Hayes Wang <hayeswang@realtek.com>
To:     Grant Grundler <grundler@chromium.org>
CC:     netdev <netdev@vger.kernel.org>, nic_swsd <nic_swsd@realtek.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Prashant Malani <pmalani@chromium.org>
Subject: RE: [PATCH net 9/9] r8152: disable DelayPhyPwrChg
Thread-Topic: [PATCH net 9/9] r8152: disable DelayPhyPwrChg
Thread-Index: AQHV0FhSIZuQmjh3PESNf3BKmFZCOqf1vQeAgACPtwA=
Date:   Wed, 22 Jan 2020 07:50:18 +0000
Message-ID: <fdd1b5e0538347698f0ca88aaef26617@realtek.com>
References: <1394712342-15778-338-Taiwan-albertk@realtek.com>
 <1394712342-15778-347-Taiwan-albertk@realtek.com>
 <CANEJEGs+K9rFqzFG_4cPaQvi9FV3L5jMdCi4KYtcfpg1x+nwjw@mail.gmail.com>
In-Reply-To: <CANEJEGs+K9rFqzFG_4cPaQvi9FV3L5jMdCi4KYtcfpg1x+nwjw@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.177.214]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R3JhbnQgR3J1bmRsZXIgW21haWx0bzpncnVuZGxlckBjaHJvbWl1bS5vcmddDQo+IFNlbnQ6IFdl
ZG5lc2RheSwgSmFudWFyeSAyMiwgMjAyMCAzOjAzIFBNDQpbLi4uXQ0KPiBEaWQgeW91IG1lYW4g
ImRvbid0IGFsbG93IHRoZSBwaHkgdG8gZW50ZXIgUDMgcG93ZXIgc2F2aW5nIG1vZGUiPw0KPiBJ
ZiBQMyBwb3dlciBzYXZpbmcgbW9kZSBpcyBicm9rZW4sIHdoYXQgaXMgdGhlIHN5bXB0b20/DQoN
Clllcy4NCkl0IGluY3JlYXNlcyBwb3dlciBjb25zdW1wdGlvbi4NCg0KUFMuIHRoZSAicGh5IiBp
cyBmb3IgVVNCLCBub3QgZm9yIEV0aGVybmV0Lg0KDQo+IEhvdyBsb25nIGlzIHRoZSBkZWxheSB3
aGVuIHRoaXMgaXMgc3RpbGwgZW5hYmxlZD8gKHRvIGhlbHAgaWRlbnRpZnkNCj4gZmFpbHVyZXMg
d2hlbiB0aGlzIGlzIHN0aWxsIGVuYWJsZWQpDQoNCldoZW4gdGhpcyBpcyBlbmFibGUsIHRoZSBk
ZXZpY2Ugd291bGQgd2FpdCBhbiBpbnRlcm5hbCBzaWduYWwgd2hpY2gNCndvdWxkbid0IGJlIHRy
aWdnZXJlZC4gVGhlbiwgdGhlIGRldmljZSBjb3VsZG4ndCBlbnRlciBQMyBtb2RlLCBzbyB0aGUN
CnBvd2VyIGNvbnN1bXB0aW9uIGlzIGluY3JlYXNlZC4NCg0KQmVzdCBSZWdhcmRzLA0KSGF5ZXMN
Cg==
