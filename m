Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6EEC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 02:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04C912068F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 02:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgGMCac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 22:30:32 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:44233 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726534AbgGMCab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 22:30:31 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1725605|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0492821-0.000422833-0.950295;FP=0|0|0|0|0|-1|-1|-1;HT=e01l07440;MF=frank@allwinnertech.com;NM=1;PH=DW;RN=9;RT=9;SR=0;TI=W4_5899425_DEFAULT_0AC26699_1594607350236_o7001c824s;
Received: from WS-web (frank@allwinnertech.com[W4_5899425_DEFAULT_0AC26699_1594607350236_o7001c824s]) by e02c03303.eu6 at Mon, 13 Jul 2020 10:30:27 +0800
Date:   Mon, 13 Jul 2020 10:30:27 +0800
From:   "=?UTF-8?B?5p2O5oms6Z+s?=" <frank@allwinnertech.com>
To:     "Maxime Ripard" <maxime@cerno.tech>
Cc:     "wens" <wens@csie.org>, "robh+dt" <robh+dt@kernel.org>,
        "tiny.windzz" <tiny.windzz@gmail.com>,
        "linux-arm-kernel" <linux-arm-kernel@lists.infradead.org>,
        "devicetree" <devicetree@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "=?UTF-8?B?6buE54OB55Sf?=" <huangshuosheng@allwinnertech.com>,
        "=?UTF-8?B?5p2O5YuH?=" <liyong@allwinnertech.com>
Reply-To: "=?UTF-8?B?5p2O5oms6Z+s?=" <frank@allwinnertech.com>
Message-ID: <2aa29f79-c105-4dc7-ac71-91a8e1225833.frank@allwinnertech.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MyAxNi8xNl0gYXJtNjQ6IGFsbHdpbm5lcjogQTEwMDogYWRkIHN1cHBv?=
  =?UTF-8?B?cnQgZm9yIEFsbHdpbm5lciBQZXJmMSBib2FyZA==?=
X-Mailer: [Alimail-Mailagent][W4_5899425][DEFAULT][Chrome]
MIME-Version: 1.0
References: <20200708082821.13188-1-frank@allwinnertech.com>,<20200710123617.ebd2ljn7okdrx4ph@gilmour.lan>
x-aliyun-mail-creator: W4_5899425_DEFAULT_LjMTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzU2LjAuMjkyNC44NyBTYWZhcmkvNTM3LjM2TM
In-Reply-To: <20200710123617.ebd2ljn7okdrx4ph@gilmour.lan>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gKyZwaW8gewo+PiArIHZjYy1wYi1zdXBwbHkgPSA8JnJlZ19kY2RjMT47Cj4+ICsgdmNjLXBj
LXN1cHBseSA9IDwmcmVnX2VsZG8xPjsKPj4gKyB2Y2MtcGQtc3VwcGx5ID0gPCZyZWdfZGNkYzE+
Owo+PiArIHZjYy1wZS1zdXBwbHkgPSA8JnJlZ19kbGRvMj47Cj4+ICsgdmNjLXBmLXN1cHBseSA9
IDwmcmVnX2RjZGMxPjsKPj4gKyB2Y2MtcGctc3VwcGx5ID0gPCZyZWdfZGxkbzE+Owo+PiArIHZj
Yy1waC1zdXBwbHkgPSA8JnJlZ19kY2RjMT47Cj4+ICt9OwoKPlRoZXJlJ3Mgc29tZXRoaW5nIG9m
ZiBoZXJlLiBUaGUgUEMgc3VwcGx5IGlzIHNldCB0byBlbGRvMSwgYnV0Cgo+PiArJnJlZ19kY2Rj
MSB7Cj4+ICsgcmVndWxhdG9yLWFsd2F5cy1vbjsKPj4gKyByZWd1bGF0b3ItbWluLW1pY3Jvdm9s
dCA9IDwzMzAwMDAwPjsKPj4gKyByZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwzMzAwMDAwPjsK
Pj4gKyByZWd1bGF0b3ItbmFtZSA9ICJ2Y2MtcGMtaW8tdXNiLXBkLWVtbWMtbmFuZC1jYXJkIjsK
Pj4gK307Cgo+QnV0IGhlcmUgeW91IHNheSBpbiB0aGUgbmFtZSB0aGF0IGRsZG8xIGlzIGEgUEMg
c3VwcGx5IHRvbz8KClRoZXJlIGlzIHNvbWUgbWlzbGVhZGluZyBvbiB0aGUgc2NoZW1hdGljLCBp
biBmYWN0IHRoZXJlIGlzIG5vCmNvbm5lY3Rpb24gYmV0d2VlbiBkY2RjMSBhbmQgcGMsIEkgd2ls
bCBmaXggdGhpcy4KClRoeCwKWWFuZ3Rhbw==
