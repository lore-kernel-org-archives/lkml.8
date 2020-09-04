Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BD5C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 08:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26662206CA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 08:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="A+7qeGDq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbgIDIRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 04:17:46 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:21220 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729712AbgIDIRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 04:17:43 -0400
X-UUID: c9c37224a3c74c5fa55a815fe3b77ea8-20200904
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Y+yfzUHM3WBN1/Q1KbrA31DhHvsy0q918JMGinDio0s=;
        b=A+7qeGDqIN5GyOHZAVhe1s4/42dNEZSuLdxjLUvi2ESnKrqXsYTvXddU9OY6uxS5Uphn3gU6OAjx0KwZZpKIx4t9zKzQdMJN+iz/EYWoWK/YbPXJDpcwX8mKbvCjMxXffumb0g8WmlorEm4b1eDemi20XfY1x0DK9mbk/5WAhtI=;
X-UUID: c9c37224a3c74c5fa55a815fe3b77ea8-20200904
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1606731689; Fri, 04 Sep 2020 16:17:34 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 4 Sep 2020 16:17:32 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 4 Sep 2020 16:17:31 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Zhanyong Wang <zhanyong.wang@mediatek.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: [RFC PATCH v2 4/4] arm64: dts: mt8192: add SSUSB related nodes
Date:   Fri, 4 Sep 2020 16:15:40 +0800
Message-ID: <1599207340-4673-4-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1599207340-4673-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1599207340-4673-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 223E06BEB888DD36613237D2F408F71218ED8C29FF85451AE2F36DD3DC965EF12000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogWmhhbnlvbmcgV2FuZyA8emhhbnlvbmcud2FuZ0BtZWRpYXRlay5jb20+DQoNCkFkZCBT
U1VTQiByZWxhdGVkIG5vZGVzIGZvciBtdDgxOTINCg0KU2lnbmVkLW9mZi1ieTogWmhhbnlvbmcg
V2FuZyA8emhhbnlvbmcud2FuZ0BtZWRpYXRlay5jb20+DQpTaWduZWQtb2ZmLWJ5OiBDaHVuZmVu
ZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQotLS0NCnYyOiBpbmNsdWRlIHBoeS5o
IGZpbGUNCg0KRGVwZW5kcyBvbjoNCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gv
MTE3MTM1NTkvDQpbdjQsMS8zXSBhcm02NDogZHRzOiBBZGQgTWVkaWF0ZWsgU29DIE1UODE5MiBh
bmQgZXZhbHVhdGlvbiBib2FyZCBkdHMgYW5kIE1ha2VmaWxlDQotLS0NCiBhcmNoL2FybTY0L2Jv
b3QvZHRzL21lZGlhdGVrL210ODE5Mi5kdHNpIHwgNDkgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNDkgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0
IGEvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxOTIuZHRzaSBiL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTkyLmR0c2kNCmluZGV4IDg4NzFjMmYuLjIwYjk5ZTAgMTAw
NjQ0DQotLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5Mi5kdHNpDQorKysg
Yi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5Mi5kdHNpDQpAQCAtOSw2ICs5LDcg
QEANCiAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvYXJtLWdpYy5o
Pg0KICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9pcnEuaD4NCiAj
aW5jbHVkZSA8ZHQtYmluZGluZ3MvcGluY3RybC9tdDgxOTItcGluZnVuYy5oPg0KKyNpbmNsdWRl
IDxkdC1iaW5kaW5ncy9waHkvcGh5Lmg+DQogDQogLyB7DQogCWNvbXBhdGlibGUgPSAibWVkaWF0
ZWssbXQ4MTkyIjsNCkBAIC00MzQsNiArNDM1LDU0IEBADQogCQkJc3RhdHVzID0gImRpc2FibGVk
IjsNCiAJCX07DQogDQorCQl4aGNpOiB4aGNpQDExMjAwMDAwIHsNCisJCQljb21wYXRpYmxlID0g
Im1lZGlhdGVrLG10ODE5Mi14aGNpIiwNCisJCQkJICAgICAibWVkaWF0ZWssbXRrLXhoY2kiOw0K
KwkJCXJlZyA9IDwwIDB4MTEyMDAwMDAgMCAweDEwMDA+LA0KKwkJCSAgICAgIDwwIDB4MTEyMDNl
MDAgMCAweDAxMDA+Ow0KKwkJCXJlZy1uYW1lcyA9ICJtYWMiLCAiaXBwYyI7DQorCQkJaW50ZXJy
dXB0cy1leHRlbmRlZCA9IDwmZ2ljIEdJQ19TUEkgOTcgSVJRX1RZUEVfTEVWRUxfSElHSCAwPiwN
CisJCQkJCSAgICAgIDwmcGlvIDIxMSBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0KKwkJCXBoeXMgPSA8
JnUycG9ydDAgUEhZX1RZUEVfVVNCMj4sDQorCQkJICAgICAgIDwmdTNwb3J0MCBQSFlfVFlQRV9V
U0IzPjsNCisJCQlhc3NpZ25lZC1jbG9ja3MgPSA8JnRvcGNrZ2VuIENMS19UT1BfVVNCX1RPUF9T
RUw+LA0KKwkJCQkJICA8JnRvcGNrZ2VuIENMS19UT1BfU1NVU0JfWEhDSV9TRUw+Ow0KKwkJCWFz
c2lnbmVkLWNsb2NrLXBhcmVudHMgPSA8JnRvcGNrZ2VuIENMS19UT1BfVU5JVlBMTF9ENV9END4s
DQorCQkJCQkJIDwmdG9wY2tnZW4gQ0xLX1RPUF9VTklWUExMX0Q1X0Q0PjsNCisJCQljbG9ja3Mg
PSA8JmluZnJhY2ZnIENMS19JTkZSQV9TU1VTQj4sDQorCQkJCSA8JmluZnJhY2ZnIENMS19JTkZS
QV9TU1VTQl9YSENJPiwNCisJCQkJIDwmYXBtaXhlZHN5cyBDTEtfQVBNSVhFRF9VU0JQTEw+Ow0K
KwkJCWNsb2NrLW5hbWVzID0gInN5c19jayIsICJ4aGNpX2NrIiwgInJlZl9jayI7DQorCQkJbWVk
aWF0ZWssc3lzY29uLXdha2V1cCA9IDwmcGVyaWNmZyAweDQyMCAzPjsNCisJCQkjYWRkcmVzcy1j
ZWxscyA9IDwyPjsNCisJCQkjc2l6ZS1jZWxscyA9IDwyPjsNCisJCX07DQorDQorCQl1M3BoeTA6
IHVzYi1waHlAMTFlNDAwMDAgew0KKwkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTkyLXRw
aHkiLA0KKwkJCQkgICAgICJtZWRpYXRlayxnZW5lcmljLXRwaHktdjIiOw0KKwkJCSNhZGRyZXNz
LWNlbGxzID0gPDI+Ow0KKwkJCSNzaXplLWNlbGxzID0gPDI+Ow0KKwkJCXJhbmdlczsNCisJCQlz
dGF0dXMgPSAib2theSI7DQorDQorCQkJdTJwb3J0MDogdXNiLXBoeUAxMWU0MDAwMCB7DQorCQkJ
CXJlZyA9IDwwIDB4MTFlNDAwMDAgMCAweDcwMD47DQorCQkJCWNsb2NrcyA9IDwmY2xrMjZtPjsN
CisJCQkJY2xvY2stbmFtZXMgPSAicmVmIjsNCisJCQkJI3BoeS1jZWxscyA9IDwxPjsNCisJCQkJ
c3RhdHVzID0gIm9rYXkiOw0KKwkJCX07DQorDQorCQkJdTNwb3J0MDogdXNiLXBoeUAxMWU0MDcw
MCB7DQorCQkJCXJlZyA9IDwwIDB4MTFlNDA3MDAgMCAweDkwMD47DQorCQkJCWNsb2NrcyA9IDwm
Y2xrMjZtPjsNCisJCQkJY2xvY2stbmFtZXMgPSAicmVmIjsNCisJCQkJI3BoeS1jZWxscyA9IDwx
PjsNCisJCQkJc3RhdHVzID0gIm9rYXkiOw0KKwkJCX07DQorCQl9Ow0KKw0KIAkJYXVkc3lzOiBz
eXNjb25AMTEyMTAwMDAgew0KIAkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTkyLWF1ZHN5
cyIsICJzeXNjb24iOw0KIAkJCXJlZyA9IDwwIDB4MTEyMTAwMDAgMCAweDEwMDA+Ow0KLS0gDQox
LjkuMQ0K

