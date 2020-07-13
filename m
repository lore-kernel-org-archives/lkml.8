Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53FEC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 01:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B986E206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 01:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbgGMBoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 21:44:03 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:52540 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726262AbgGMBoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 21:44:03 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1167423|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0681111-0.00041438-0.931475;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03273;MF=frank@allwinnertech.com;NM=1;PH=DW;RN=9;RT=9;SR=0;TI=W4_5899425_DEFAULT_0A9326FC_1594604587689_o7001c2454m;
Received: from WS-web (frank@allwinnertech.com[W4_5899425_DEFAULT_0A9326FC_1594604587689_o7001c2454m]) by e01l07394.eu6 at Mon, 13 Jul 2020 09:43:59 +0800
Date:   Mon, 13 Jul 2020 09:43:59 +0800
From:   "=?UTF-8?B?5p2O5oms6Z+s?=" <frank@allwinnertech.com>
To:     "Maxime Ripard" <maxime@cerno.tech>
Cc:     "robh+dt" <robh+dt@kernel.org>, "wens" <wens@csie.org>,
        "tiny.windzz" <tiny.windzz@gmail.com>,
        "devicetree" <devicetree@vger.kernel.org>,
        "linux-arm-kernel" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "=?UTF-8?B?6buE54OB55Sf?=" <huangshuosheng@allwinnertech.com>,
        "=?UTF-8?B?5p2O5YuH?=" <liyong@allwinnertech.com>
Reply-To: "=?UTF-8?B?5p2O5oms6Z+s?=" <frank@allwinnertech.com>
Message-ID: <687f6b72-d5c6-4ea4-81d9-e91612cd75d5.frank@allwinnertech.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MyAxNC8xNl0gYXJtNjQ6IGFsbHdpbm5lcjogQTEwMDogYWRkIHRoZSBi?=
  =?UTF-8?B?YXNpY2FsIEFsbHdpbm5lciBBMTAwIERUU0kgZmlsZQ==?=
X-Mailer: [Alimail-Mailagent][W4_5899425][DEFAULT][Chrome]
MIME-Version: 1.0
References: <20200708082505.28910-1-frank@allwinnertech.com>,<20200710123306.wlqadpz4tuy2r3jc@gilmour.lan>
In-Reply-To: <20200710123306.wlqadpz4tuy2r3jc@gilmour.lan>
x-aliyun-mail-creator: W4_5899425_DEFAULT_LjMTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzU2LjAuMjkyNC44NyBTYWZhcmkvNTM3LjM2TM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PkhpLAo+Cj5UaGFua3MgZm9yIHNlbmRpbmcgYSBuZXcgc2VyaWVzCj4KPk9uIFdlZCwgSnVsIDA4
LCAyMDIwIGF0IDA0OjI1OjA1UE0gKzA4MDAsIEZyYW5rIExlZSB3cm90ZToKPj4gKyB0aGVybWFs
LXpvbmVzIHsKPj4gKyAgY3B1X3RoZXJtYWxfem9uZSB7Cj4+ICsgICBwb2xsaW5nLWRlbGF5LXBh
c3NpdmUgPSA8MD47Cj4+ICsgICBwb2xsaW5nLWRlbGF5ID0gPDA+Owo+PiArICAgdGhlcm1hbC1z
ZW5zb3JzID0gPCZ0aHMgMD47Cj4+ICsgIH07Cj4+ICsKPj4gKyAgZ3B1X3RoZXJtYWxfem9uZSB7
Cj4+ICsgICBwb2xsaW5nLWRlbGF5LXBhc3NpdmUgPSA8MD47Cj4+ICsgICBwb2xsaW5nLWRlbGF5
ID0gPDA+Owo+PiArICAgdGhlcm1hbC1zZW5zb3JzID0gPCZ0aHMgMT47Cj4+ICsgIH07Cj4+ICsK
Pj4gKyAgZGRyX3RoZXJtYWxfem9uZSB7Cj4+ICsgICBwb2xsaW5nLWRlbGF5LXBhc3NpdmUgPSA8
MD47Cj4+ICsgICBwb2xsaW5nLWRlbGF5ID0gPDA+Owo+PiArICAgdGhlcm1hbC1zZW5zb3JzID0g
PCZ0aHMgMj47Cj4+ICsgIH07Cj4+ICsgfTsKPj4gK307Cj4KPlRoZSBub2RlIG5hbWVzIHNob3Vs
ZG4ndCBoYXZlIGFueSB1bmRlcnNjb3JlLCBvdGhlcndpc2UgaXQgd2lsbCBnZW5lcmF0ZSBhIERU
QyB3YXJuaW5nLgoKWWVhaCwgSSBpZ25vcmVkIHRoaXMuCgpZYW5ndGFv
