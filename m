Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FB3C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8621A24677
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DV6ztj33"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbgANKL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:11:26 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:36809 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732452AbgANKLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:11:23 -0500
X-UUID: f58a85bdee834a2784233f50c7a2359e-20200114
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=qoaZJusf4At6LIpWx4whGG9gLSgykifupaNe4/abaOs=;
        b=DV6ztj33KRVRzI88b2CxDhD8rEy5gaUf3Yejw7kSIjzMovSxT8dlZBtUPW0RDrN67GnXLcN3M9U1fuU3zMJfdbpjjG6tQXfUzj8v7DLxGo6EMQV5GuhOvCphPAYdlLgoQKIbsNtV7IwRJY0ceEYzhjxkE/c6rML00UCdDPQJmcY=;
X-UUID: f58a85bdee834a2784233f50c7a2359e-20200114
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <jamesjj.liao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2077133290; Tue, 14 Jan 2020 18:11:17 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 14 Jan 2020 18:10:19 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 14 Jan 2020 18:12:00 +0800
From:   James Liao <jamesjj.liao@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        James Liao <jamesjj.liao@mediatek.com>
Subject: [PATCH v2] arm64: dts: mt8183: Enable CPU idle-states
Date:   Tue, 14 Jan 2020 18:11:13 +0800
Message-ID: <1578996673-8140-1-git-send-email-jamesjj.liao@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 1B578A9546F8FDF9209DBB42AA7F3474A4986FEA89B320FDFD34373CBA93BD7F2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RW5hYmxlIG1jZGktY3B1IGFuZCBtY2RpLWNsdXN0ZXIgb24gTVQ4MTgzIENQVXMuDQoNClNpZ25l
ZC1vZmYtYnk6IEphbWVzIExpYW8gPGphbWVzamoubGlhb0BtZWRpYXRlay5jb20+DQotLS0NClRo
aXMgcGF0Y2ggYmFzZXMgb24gdjUuNS1yYzYsIGFkZHMgaWRsZS1zdGF0ZXMgZm9yIE1UODE4MyBD
UFVzLg0KDQogYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaSB8IDMwICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCAzMCBpbnNlcnRp
b25zKCspDQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4
My5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaQ0KaW5kZXgg
MTBiMzI0Ny4uYTAyMjMyNSAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0
ZWsvbXQ4MTgzLmR0c2kNCisrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgz
LmR0c2kNCkBAIC03Myw2ICs3Myw3IEBADQogCQkJcmVnID0gPDB4MDAwPjsNCiAJCQllbmFibGUt
bWV0aG9kID0gInBzY2kiOw0KIAkJCWNhcGFjaXR5LWRtaXBzLW1oeiA9IDw3NDE+Ow0KKwkJCWNw
dS1pZGxlLXN0YXRlcyA9IDwmTUNESV9DUFUgJk1DRElfQ0xVU1RFUj47DQogCQl9Ow0KIA0KIAkJ
Y3B1MTogY3B1QDEgew0KQEAgLTgxLDYgKzgyLDcgQEANCiAJCQlyZWcgPSA8MHgwMDE+Ow0KIAkJ
CWVuYWJsZS1tZXRob2QgPSAicHNjaSI7DQogCQkJY2FwYWNpdHktZG1pcHMtbWh6ID0gPDc0MT47
DQorCQkJY3B1LWlkbGUtc3RhdGVzID0gPCZNQ0RJX0NQVSAmTUNESV9DTFVTVEVSPjsNCiAJCX07
DQogDQogCQljcHUyOiBjcHVAMiB7DQpAQCAtODksNiArOTEsNyBAQA0KIAkJCXJlZyA9IDwweDAw
Mj47DQogCQkJZW5hYmxlLW1ldGhvZCA9ICJwc2NpIjsNCiAJCQljYXBhY2l0eS1kbWlwcy1taHog
PSA8NzQxPjsNCisJCQljcHUtaWRsZS1zdGF0ZXMgPSA8Jk1DRElfQ1BVICZNQ0RJX0NMVVNURVI+
Ow0KIAkJfTsNCiANCiAJCWNwdTM6IGNwdUAzIHsNCkBAIC05Nyw2ICsxMDAsNyBAQA0KIAkJCXJl
ZyA9IDwweDAwMz47DQogCQkJZW5hYmxlLW1ldGhvZCA9ICJwc2NpIjsNCiAJCQljYXBhY2l0eS1k
bWlwcy1taHogPSA8NzQxPjsNCisJCQljcHUtaWRsZS1zdGF0ZXMgPSA8Jk1DRElfQ1BVICZNQ0RJ
X0NMVVNURVI+Ow0KIAkJfTsNCiANCiAJCWNwdTQ6IGNwdUAxMDAgew0KQEAgLTEwNSw2ICsxMDks
NyBAQA0KIAkJCXJlZyA9IDwweDEwMD47DQogCQkJZW5hYmxlLW1ldGhvZCA9ICJwc2NpIjsNCiAJ
CQljYXBhY2l0eS1kbWlwcy1taHogPSA8MTAyND47DQorCQkJY3B1LWlkbGUtc3RhdGVzID0gPCZN
Q0RJX0NQVSAmTUNESV9DTFVTVEVSPjsNCiAJCX07DQogDQogCQljcHU1OiBjcHVAMTAxIHsNCkBA
IC0xMTMsNiArMTE4LDcgQEANCiAJCQlyZWcgPSA8MHgxMDE+Ow0KIAkJCWVuYWJsZS1tZXRob2Qg
PSAicHNjaSI7DQogCQkJY2FwYWNpdHktZG1pcHMtbWh6ID0gPDEwMjQ+Ow0KKwkJCWNwdS1pZGxl
LXN0YXRlcyA9IDwmTUNESV9DUFUgJk1DRElfQ0xVU1RFUj47DQogCQl9Ow0KIA0KIAkJY3B1Njog
Y3B1QDEwMiB7DQpAQCAtMTIxLDYgKzEyNyw3IEBADQogCQkJcmVnID0gPDB4MTAyPjsNCiAJCQll
bmFibGUtbWV0aG9kID0gInBzY2kiOw0KIAkJCWNhcGFjaXR5LWRtaXBzLW1oeiA9IDwxMDI0PjsN
CisJCQljcHUtaWRsZS1zdGF0ZXMgPSA8Jk1DRElfQ1BVICZNQ0RJX0NMVVNURVI+Ow0KIAkJfTsN
CiANCiAJCWNwdTc6IGNwdUAxMDMgew0KQEAgLTEyOSw2ICsxMzYsMjkgQEANCiAJCQlyZWcgPSA8
MHgxMDM+Ow0KIAkJCWVuYWJsZS1tZXRob2QgPSAicHNjaSI7DQogCQkJY2FwYWNpdHktZG1pcHMt
bWh6ID0gPDEwMjQ+Ow0KKwkJCWNwdS1pZGxlLXN0YXRlcyA9IDwmTUNESV9DUFUgJk1DRElfQ0xV
U1RFUj47DQorCQl9Ow0KKw0KKwkJaWRsZS1zdGF0ZXMgew0KKwkJCWVudHJ5LW1ldGhvZCA9ICJh
cm0scHNjaSI7DQorDQorCQkJTUNESV9DUFU6IG1jZGktY3B1IHsNCisJCQkJY29tcGF0aWJsZSA9
ICJhcm0saWRsZS1zdGF0ZSI7DQorCQkJCWxvY2FsLXRpbWVyLXN0b3A7DQorCQkJCWFybSxwc2Np
LXN1c3BlbmQtcGFyYW0gPSA8MHgwMDAxMDAwMT47DQorCQkJCWVudHJ5LWxhdGVuY3ktdXMgPSA8
MjAwPjsNCisJCQkJZXhpdC1sYXRlbmN5LXVzID0gPDIwMD47DQorCQkJCW1pbi1yZXNpZGVuY3kt
dXMgPSA8ODAwPjsNCisJCQl9Ow0KKw0KKwkJCU1DRElfQ0xVU1RFUjogbWNkaS1jbHVzdGVyIHsN
CisJCQkJY29tcGF0aWJsZSA9ICJhcm0saWRsZS1zdGF0ZSI7DQorCQkJCWxvY2FsLXRpbWVyLXN0
b3A7DQorCQkJCWFybSxwc2NpLXN1c3BlbmQtcGFyYW0gPSA8MHgwMTAxMDAwMT47DQorCQkJCWVu
dHJ5LWxhdGVuY3ktdXMgPSA8MjUwPjsNCisJCQkJZXhpdC1sYXRlbmN5LXVzID0gPDQwMD47DQor
CQkJCW1pbi1yZXNpZGVuY3ktdXMgPSA8MTMwMD47DQorCQkJfTsNCiAJCX07DQogCX07DQogDQot
LSANCjEuOS4xDQo=

