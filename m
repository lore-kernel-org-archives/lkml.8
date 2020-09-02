Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365FEC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 10:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06DD62071B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 10:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgIBKFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 06:05:33 -0400
Received: from smtp.h3c.com ([60.191.123.56]:62512 "EHLO h3cspam01-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgIBKFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 06:05:32 -0400
Received: from h3cspam01-ex.h3c.com (localhost [127.0.0.2] (may be forged))
        by h3cspam01-ex.h3c.com with ESMTP id 0828ZYeh038511;
        Wed, 2 Sep 2020 16:35:34 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX01-BASE.srv.huawei-3com.com ([10.8.0.64])
        by h3cspam01-ex.h3c.com with ESMTPS id 0828Ym6u036647
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Sep 2020 16:34:48 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX01-BASE.srv.huawei-3com.com (10.8.0.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 2 Sep 2020 16:34:50 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%7]) with
 mapi id 15.01.1713.004; Wed, 2 Sep 2020 16:34:50 +0800
From:   Tianxianting <tian.xianting@h3c.com>
To:     Markus Elfring <Markus.Elfring@web.de>,
        "uclinux-h8-devel@lists.sourceforge.jp" 
        <uclinux-h8-devel@lists.sourceforge.jp>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: RE: [PATCH] clocksource: Return negative error code in
 h8300_8timer_init()
Thread-Topic: [PATCH] clocksource: Return negative error code in
 h8300_8timer_init()
Thread-Index: AQHWgG6WjpLZUStyU0iJLmFjcyZbn6lVBaXQ
Date:   Wed, 2 Sep 2020 08:34:50 +0000
Message-ID: <bf571d3088a4419dac147729e4206574@h3c.com>
References: <7356d489-2320-2a75-0999-0b3f0f8ac373@web.de>
In-Reply-To: <7356d489-2320-2a75-0999-0b3f0f8ac373@web.de>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.141.128]
x-sender-location: DAG2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com 0828Ym6u036647
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFya3VzLA0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLg0KTm8gcmVhbCBmaXgsIGFzIG5v
cm1hbGx5ICwgd2Ugc2hvdWxkIHJldHVybiBhIG5lZ2F0aXZlIGNvZGUsDQpJbiBmdW5jdGlvbiBo
ODMwMF84dGltZXJfaW5pdCgpLCAgaXQgc2V0ICcgcmV0ID0gLUVJTlZBTCAnLCAnIHJldCA9IEVO
WElPJyAsIGl0IHNob3VsZCBiZSBhbGlnbiB3aXRoIGEgbmVnYXRpdmUgY29kZQ0KDQpzdGF0aWMg
aW50IF9faW5pdCBoODMwMF84dGltZXJfaW5pdChzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUpDQp7
DQoNCiAgICAgICAgcmV0ID0gRU5YSU87ICA8PDwNCiAgICAgICAgYmFzZSA9IG9mX2lvbWFwKG5v
ZGUsIDApOw0KICAgICAgICBpZiAoIWJhc2UpIHsNCiAgICAgICAgICAgICAgICBwcl9lcnIoImZh
aWxlZCB0byBtYXAgcmVnaXN0ZXJzIGZvciBjbG9ja2V2ZW50XG4iKTsNCiAgICAgICAgICAgICAg
ICBnb3RvIGZyZWVfY2xrOw0KICAgICAgICB9DQoNCiAgICAgICAgcmV0ID0gLUVJTlZBTDsgIDw8
PCAgDQogICAgICAgIGlycSA9IGlycV9vZl9wYXJzZV9hbmRfbWFwKG5vZGUsIDApOw0KICAgICAg
ICBpZiAoIWlycSkgew0KICAgICAgICAgICAgICAgIHByX2VycigiZmFpbGVkIHRvIGdldCBpcnEg
Zm9yIGNsb2NrZXZlbnRcbiIpOw0KICAgICAgICAgICAgICAgIGdvdG8gdW5tYXBfcmVnOw0KICAg
ICAgICB9DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBNYXJrdXMgRWxmcmlu
ZyBbbWFpbHRvOk1hcmt1cy5FbGZyaW5nQHdlYi5kZV0gDQpTZW50OiBUdWVzZGF5LCBTZXB0ZW1i
ZXIgMDEsIDIwMjAgMTA6NDYgUE0NClRvOiB0aWFueGlhbnRpbmcgKFJEKSA8dGlhbi54aWFudGlu
Z0BoM2MuY29tPjsgdWNsaW51eC1oOC1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5qcA0KQ2M6IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGtlcm5lbC1qYW5pdG9yc0B2Z2VyLmtlcm5lbC5v
cmc7IERhbmllbCBMZXpjYW5vIDxkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnPjsgVGhvbWFzIEds
ZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+OyBZb3NoaW5vcmkgU2F0byA8eXNhdG9AdXNlcnMu
c291cmNlZm9yZ2UuanA+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBjbG9ja3NvdXJjZTogUmV0dXJu
IG5lZ2F0aXZlIGVycm9yIGNvZGUgaW4gaDgzMDBfOHRpbWVyX2luaXQoKQ0KDQo+IEEgbmVnYXRp
dmUgZXJyb3IgY29kZSBzaG91bGQgYmUgcmV0dXJuZWQNCg0KKiBDYW4gYW4gb3RoZXIgaW1wZXJh
dGl2ZSB3b3JkaW5nIGJlY29tZSBoZWxwZnVsIGZvciB0aGUgY2hhbmdlIGRlc2NyaXB0aW9uPw0K
DQoqIFdvdWxkIHlvdSBsaWtlIHRvIGFkZCB0aGUgdGFnIOKAnEZpeGVz4oCdIHRvIHRoZSBjb21t
aXQgbWVzc2FnZT8NCg0KUmVnYXJkcywNCk1hcmt1cw0K
