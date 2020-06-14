Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3EAC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 07:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B6832074D
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 07:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GlnnGfUC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgFNHaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 03:30:52 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:64557 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725379AbgFNHav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 03:30:51 -0400
X-UUID: d588951af6f54a8d941ead60415d06e3-20200614
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=e/fnKiWEhhBmP/WoWCXqaRZNRzty2IMoerF/NXm8x7s=;
        b=GlnnGfUCnRShor8PUtWiV3Ocr39MUh+aO348c9psrGJmHQTKx4YI4yHqB6A9b0pxvb8dC1tjS5vCfDnWqCy4ZRs/NZEZL4b3jHel4kYPYQ/CZzL/h6VpOFEwIXLYV7I4FeObKx/wl9uNON0OVYkAB+gshlTqXWRsHMDposjritE=;
X-UUID: d588951af6f54a8d941ead60415d06e3-20200614
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 708602347; Sun, 14 Jun 2020 15:30:41 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 14 Jun
 2020 15:30:39 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Sun, 14 Jun 2020 15:30:37 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <ck.hu@mediatek.com>,
        <stonea168@163.com>, <huijuan.xie@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v16 1/1] dt-bindings: display: mediatek: convert the dpi bindings to yaml
Date:   Sun, 14 Jun 2020 15:30:36 +0800
Message-ID: <20200614073036.63969-2-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200614073036.63969-1-jitao.shi@mediatek.com>
References: <20200614073036.63969-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: AA96696364F2BE81C37DAD2F204532E661983BE1432B46C4D2579589E3E271E82000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q29udmVydCBkaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRwaS50eHQgdG8gZGlzcGxheS9tZWRp
YXRlay9tZWRpYXRlayxkcGkueWFtbA0KYW5kIHJlbW92ZSB0aGUgb2xkIHRleHQgYmluZGluZ3Mu
DQoNClNpZ25lZC1vZmYtYnk6IEppdGFvIFNoaSA8aml0YW8uc2hpQG1lZGlhdGVrLmNvbT4NCi0t
LQ0KIC4uLi9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRwaS50eHQgICAgICAgICB8IDQyIC0t
LS0tLS0tDQogLi4uL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHBpLnlhbWwgICAgICAgIHwg
OTcgKysrKysrKysrKysrKysrKysrKw0KIDIgZmlsZXMgY2hhbmdlZCwgOTcgaW5zZXJ0aW9ucygr
KSwgNDIgZGVsZXRpb25zKC0pDQogZGVsZXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRwaS50eHQNCiBjcmVh
dGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkv
bWVkaWF0ZWsvbWVkaWF0ZWssZHBpLnlhbWwNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRwaS50eHQgYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRl
ayxkcGkudHh0DQpkZWxldGVkIGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4IDc3ZGVmNDQ1NjcwNi4u
MDAwMDAwMDAwMDAwDQotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlz
cGxheS9tZWRpYXRlay9tZWRpYXRlayxkcGkudHh0DQorKysgL2Rldi9udWxsDQpAQCAtMSw0MiAr
MCwwIEBADQotTWVkaWF0ZWsgRFBJIERldmljZQ0KLT09PT09PT09PT09PT09PT09PT0NCi0NCi1U
aGUgTWVkaWF0ZWsgRFBJIGZ1bmN0aW9uIGJsb2NrIGlzIGEgc2luayBvZiB0aGUgZGlzcGxheSBz
dWJzeXN0ZW0gYW5kDQotcHJvdmlkZXMgOC1iaXQgUkdCL1lVVjQ0NCBvciA4LzEwLzEwLWJpdCBZ
VVY0MjIgcGl4ZWwgZGF0YSBvbiBhIHBhcmFsbGVsDQotb3V0cHV0IGJ1cy4NCi0NCi1SZXF1aXJl
ZCBwcm9wZXJ0aWVzOg0KLS0gY29tcGF0aWJsZTogIm1lZGlhdGVrLDxjaGlwPi1kcGkiDQotICB0
aGUgc3VwcG9ydGVkIGNoaXBzIGFyZSBtdDI3MDEgLCBtdDgxNzMgYW5kIG10ODE4My4NCi0tIHJl
ZzogUGh5c2ljYWwgYmFzZSBhZGRyZXNzIGFuZCBsZW5ndGggb2YgdGhlIGNvbnRyb2xsZXIncyBy
ZWdpc3RlcnMNCi0tIGludGVycnVwdHM6IFRoZSBpbnRlcnJ1cHQgc2lnbmFsIGZyb20gdGhlIGZ1
bmN0aW9uIGJsb2NrLg0KLS0gY2xvY2tzOiBkZXZpY2UgY2xvY2tzDQotICBTZWUgRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL2Nsb2NrLWJpbmRpbmdzLnR4dCBmb3IgZGV0
YWlscy4NCi0tIGNsb2NrLW5hbWVzOiBtdXN0IGNvbnRhaW4gInBpeGVsIiwgImVuZ2luZSIsIGFu
ZCAicGxsIg0KLS0gcG9ydDogT3V0cHV0IHBvcnQgbm9kZSB3aXRoIGVuZHBvaW50IGRlZmluaXRp
b25zIGFzIGRlc2NyaWJlZCBpbg0KLSAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2dyYXBoLnR4dC4gVGhpcyBwb3J0IHNob3VsZCBiZSBjb25uZWN0ZWQNCi0gIHRvIHRoZSBpbnB1
dCBwb3J0IG9mIGFuIGF0dGFjaGVkIEhETUkgb3IgTFZEUyBlbmNvZGVyIGNoaXAuDQotDQotT3B0
aW9uYWwgcHJvcGVydGllczoNCi0tIHBpbmN0cmwtbmFtZXM6IENvbnRhaW4gImRlZmF1bHQiIGFu
ZCAic2xlZXAiLg0KLQ0KLUV4YW1wbGU6DQotDQotZHBpMDogZHBpQDE0MDFkMDAwIHsNCi0JY29t
cGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxNzMtZHBpIjsNCi0JcmVnID0gPDAgMHgxNDAxZDAwMCAw
IDB4MTAwMD47DQotCWludGVycnVwdHMgPSA8R0lDX1NQSSAxOTQgSVJRX1RZUEVfTEVWRUxfTE9X
PjsNCi0JY2xvY2tzID0gPCZtbXN5cyBDTEtfTU1fRFBJX1BJWEVMPiwNCi0JCSA8Jm1tc3lzIENM
S19NTV9EUElfRU5HSU5FPiwNCi0JCSA8JmFwbWl4ZWRzeXMgQ0xLX0FQTUlYRURfVFZEUExMPjsN
Ci0JY2xvY2stbmFtZXMgPSAicGl4ZWwiLCAiZW5naW5lIiwgInBsbCI7DQotCXBpbmN0cmwtbmFt
ZXMgPSAiZGVmYXVsdCIsICJzbGVlcCI7DQotCXBpbmN0cmwtMCA9IDwmZHBpX3Bpbl9mdW5jPjsN
Ci0JcGluY3RybC0xID0gPCZkcGlfcGluX2lkbGU+Ow0KLQ0KLQlwb3J0IHsNCi0JCWRwaTBfb3V0
OiBlbmRwb2ludCB7DQotCQkJcmVtb3RlLWVuZHBvaW50ID0gPCZoZG1pMF9pbj47DQotCQl9Ow0K
LQl9Ow0KLX07DQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHBpLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkcGkueWFtbA0KbmV3IGZp
bGUgbW9kZSAxMDA2NDQNCmluZGV4IDAwMDAwMDAwMDAwMC4uODYwYjcxOWI1ZGM5DQotLS0gL2Rl
di9udWxsDQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9t
ZWRpYXRlay9tZWRpYXRlayxkcGkueWFtbA0KQEAgLTAsMCArMSw5NyBAQA0KKyMgU1BEWC1MaWNl
bnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KKyVZQU1MIDEu
Mg0KKy0tLQ0KKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvZGlzcGxheS9tZWRp
YXRlay9tZWRpYXRlayxkcGkueWFtbCMNCiskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcv
bWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCisNCit0aXRsZTogbWVkaWF0ZWsgRFBJIENvbnRyb2xs
ZXIgRGV2aWNlIFRyZWUgQmluZGluZ3MNCisNCittYWludGFpbmVyczoNCisgIC0gQ0sgSHUgPGNr
Lmh1QG1lZGlhdGVrLmNvbT4NCisgIC0gSml0YW8gc2hpIDxqaXRhby5zaGlAbWVkaWF0ZWsuY29t
Pg0KKw0KK2Rlc2NyaXB0aW9uOiB8DQorICBUaGUgTWVkaWF0ZWsgRFBJIGZ1bmN0aW9uIGJsb2Nr
IGlzIGEgc2luayBvZiB0aGUgZGlzcGxheSBzdWJzeXN0ZW0gYW5kDQorICBwcm92aWRlcyA4LWJp
dCBSR0IvWVVWNDQ0IG9yIDgvMTAvMTAtYml0IFlVVjQyMiBwaXhlbCBkYXRhIG9uIGEgcGFyYWxs
ZWwNCisgIG91dHB1dCBidXMuDQorDQorcHJvcGVydGllczoNCisgIGNvbXBhdGlibGU6DQorICAg
IGVudW06DQorICAgICAgLSBtZWRpYXRlayxtdDI3MDEtZHBpDQorICAgICAgLSBtZWRpYXRlayxt
dDgxNzMtZHBpDQorICAgICAgLSBtZWRpYXRlayxtdDgxODMtZHBpDQorDQorICByZWc6DQorICAg
IG1heEl0ZW1zOiAxDQorDQorICBpbnRlcnJ1cHRzOg0KKyAgICBtYXhJdGVtczogMQ0KKw0KKyAg
Y2xvY2tzOg0KKyAgICBpdGVtczoNCisgICAgICAtIGRlc2NyaXB0aW9uOiBQaXhlbCBDbG9jaw0K
KyAgICAgIC0gZGVzY3JpcHRpb246IEVuZ2luZSBDbG9jaw0KKyAgICAgIC0gZGVzY3JpcHRpb246
IERQSSBQTEwNCisNCisgIGNsb2NrLW5hbWVzOg0KKyAgICBpdGVtczoNCisgICAgICAtIGNvbnN0
OiBwaXhlbA0KKyAgICAgIC0gY29uc3Q6IGVuZ2luZQ0KKyAgICAgIC0gY29uc3Q6IHBsbA0KKw0K
KyAgcGluY3RybC0wOiB0cnVlDQorICBwaW5jdHJsLTE6IHRydWUNCisNCisgIHBpbmN0cmwtbmFt
ZXM6DQorICAgIGl0ZW1zOg0KKyAgICAgIC0gY29uc3Q6IGRlZmF1bHQNCisgICAgICAtIGNvbnN0
OiBzbGVlcA0KKw0KKyAgcG9ydDoNCisgICAgdHlwZTogb2JqZWN0DQorICAgIGRlc2NyaXB0aW9u
Og0KKyAgICAgIE91dHB1dCBwb3J0IG5vZGUgd2l0aCBlbmRwb2ludCBkZWZpbml0aW9ucyBhcyBk
ZXNjcmliZWQgaW4NCisgICAgICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZ3Jh
cGgudHh0LiBUaGlzIHBvcnQgc2hvdWxkIGJlIGNvbm5lY3RlZA0KKyAgICAgIHRvIHRoZSBpbnB1
dCBwb3J0IG9mIGFuIGF0dGFjaGVkIEhETUkgb3IgTFZEUyBlbmNvZGVyIGNoaXAuDQorDQorICAg
IHByb3BlcnRpZXM6DQorICAgICAgZW5kcG9pbnQ6DQorICAgICAgICB0eXBlOiBvYmplY3QNCisN
CityZXF1aXJlZDoNCisgIC0gY29tcGF0aWJsZQ0KKyAgLSByZWcNCisgIC0gaW50ZXJydXB0cw0K
KyAgLSBjbG9ja3MNCisgIC0gY2xvY2stbmFtZXMNCisgIC0gcG9ydA0KKw0KK2FkZGl0aW9uYWxQ
cm9wZXJ0aWVzOiBmYWxzZQ0KKw0KK2V4YW1wbGVzOg0KKyAgLSB8DQorICAgICNpbmNsdWRlIDxk
dC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+DQorICAgICNpbmNsdWRl
IDxkdC1iaW5kaW5ncy9jbG9jay9tdDgxNzMtY2xrLmg+DQorICAgICNpbmNsdWRlIDxkdC1iaW5k
aW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+DQorICAgICNpbmNsdWRlIDxkdC1i
aW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9pcnEuaD4NCisgICAgZHBpMDogZHBpQDE0MDFk
MDAwIHsNCisgICAgICAgIGNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTczLWRwaSI7DQorICAg
ICAgICByZWcgPSA8MCAweDE0MDFkMDAwIDAgMHgxMDAwPjsNCisgICAgICAgIGludGVycnVwdHMg
PSA8R0lDX1NQSSAxOTQgSVJRX1RZUEVfTEVWRUxfTE9XPjsNCisgICAgICAgIGNsb2NrcyA9IDwm
bW1zeXMgQ0xLX01NX0RQSV9QSVhFTD4sDQorICAgICAgICAgICAgIDwmbW1zeXMgQ0xLX01NX0RQ
SV9FTkdJTkU+LA0KKyAgICAgICAgICAgICA8JmFwbWl4ZWRzeXMgQ0xLX0FQTUlYRURfVFZEUExM
PjsNCisgICAgICAgIGNsb2NrLW5hbWVzID0gInBpeGVsIiwgImVuZ2luZSIsICJwbGwiOw0KKyAg
ICAgICAgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IiwgInNsZWVwIjsNCisgICAgICAgIHBpbmN0
cmwtMCA9IDwmZHBpX3Bpbl9mdW5jPjsNCisgICAgICAgIHBpbmN0cmwtMSA9IDwmZHBpX3Bpbl9p
ZGxlPjsNCisNCisgICAgICAgIHBvcnQgew0KKyAgICAgICAgICAgIGRwaTBfb3V0OiBlbmRwb2lu
dCB7DQorICAgICAgICAgICAgICAgIHJlbW90ZS1lbmRwb2ludCA9IDwmaGRtaTBfaW4+Ow0KKyAg
ICAgICAgICAgIH07DQorICAgICAgICB9Ow0KKyAgICB9Ow0KKw0KKy4uLg0KLS0gDQoyLjI1LjEN
Cg==

