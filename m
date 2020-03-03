Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597FFC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 05:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2725C22522
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 05:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="iL3BjG2o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgCCFiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 00:38:12 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:25290 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725440AbgCCFiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 00:38:12 -0500
X-UUID: 79395d35588c4f32a77a5ebe27a7c98e-20200303
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=m2CcW1V41TM32eWWCi7FfNQYoqIdQyWhSRyF/aJpfA4=;
        b=iL3BjG2oQ8RUXRl87N0Vi5mLolv6LduKYM7IbOQySXyoQWyFcH6xTlgXinBf6VC3N9grg/JyI2iyH4Hqje0GzFxLo70whh1V3birAfHBKMxI0jCpIJignZBXaDhKndSSrAi2ZXh18y2frHWWN1TqOtO2377RF2GwMzQg0McODFw=;
X-UUID: 79395d35588c4f32a77a5ebe27a7c98e-20200303
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 216576827; Tue, 03 Mar 2020 13:28:03 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 3 Mar
 2020 13:28:21 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Tue, 3 Mar 2020 13:28:22 +0800
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
Subject: [PATCH v12 4/6] dt-bindings: display: mediatek: convert the document format from txt to yaml
Date:   Tue, 3 Mar 2020 13:27:20 +0800
Message-ID: <20200303052722.94795-5-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200303052722.94795-1-jitao.shi@mediatek.com>
References: <20200303052722.94795-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 4EE687C2724234A765D419272ADE765BFF1D0D518E863FE5D1C5D83969F78B132000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U2lnbmVkLW9mZi1ieTogSml0YW8gU2hpIDxqaXRhby5zaGlAbWVkaWF0ZWsuY29tPg0KLS0tDQog
Li4uL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHBpLnR4dCAgICAgICAgIHwgNDUgLS0tLS0t
LS0tDQogLi4uL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHBpLnlhbWwgICAgICAgIHwgOTIg
KysrKysrKysrKysrKysrKysrKw0KIDIgZmlsZXMgY2hhbmdlZCwgOTIgaW5zZXJ0aW9ucygrKSwg
NDUgZGVsZXRpb25zKC0pDQogZGVsZXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRwaS50eHQNCiBjcmVhdGUg
bW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVk
aWF0ZWsvbWVkaWF0ZWssZHBpLnlhbWwNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRwaS50eHQgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxk
cGkudHh0DQpkZWxldGVkIGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4IDRlZWVhZDFkMzlkYi4uMDAw
MDAwMDAwMDAwDQotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxh
eS9tZWRpYXRlay9tZWRpYXRlayxkcGkudHh0DQorKysgL2Rldi9udWxsDQpAQCAtMSw0NSArMCww
IEBADQotTWVkaWF0ZWsgRFBJIERldmljZQ0KLT09PT09PT09PT09PT09PT09PT0NCi0NCi1UaGUg
TWVkaWF0ZWsgRFBJIGZ1bmN0aW9uIGJsb2NrIGlzIGEgc2luayBvZiB0aGUgZGlzcGxheSBzdWJz
eXN0ZW0gYW5kDQotcHJvdmlkZXMgOC1iaXQgUkdCL1lVVjQ0NCBvciA4LzEwLzEwLWJpdCBZVVY0
MjIgcGl4ZWwgZGF0YSBvbiBhIHBhcmFsbGVsDQotb3V0cHV0IGJ1cy4NCi0NCi1SZXF1aXJlZCBw
cm9wZXJ0aWVzOg0KLS0gY29tcGF0aWJsZTogIm1lZGlhdGVrLDxjaGlwPi1kcGkiDQotICB0aGUg
c3VwcG9ydGVkIGNoaXBzIGFyZSBtdDI3MDEgLCBtdDgxNzMgYW5kIG10ODE4My4NCi0tIHJlZzog
UGh5c2ljYWwgYmFzZSBhZGRyZXNzIGFuZCBsZW5ndGggb2YgdGhlIGNvbnRyb2xsZXIncyByZWdp
c3RlcnMNCi0tIGludGVycnVwdHM6IFRoZSBpbnRlcnJ1cHQgc2lnbmFsIGZyb20gdGhlIGZ1bmN0
aW9uIGJsb2NrLg0KLS0gY2xvY2tzOiBkZXZpY2UgY2xvY2tzDQotICBTZWUgRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL2Nsb2NrLWJpbmRpbmdzLnR4dCBmb3IgZGV0YWls
cy4NCi0tIGNsb2NrLW5hbWVzOiBtdXN0IGNvbnRhaW4gInBpeGVsIiwgImVuZ2luZSIsIGFuZCAi
cGxsIg0KLS0gcG9ydDogT3V0cHV0IHBvcnQgbm9kZSB3aXRoIGVuZHBvaW50IGRlZmluaXRpb25z
IGFzIGRlc2NyaWJlZCBpbg0KLSAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2dy
YXBoLnR4dC4gVGhpcyBwb3J0IHNob3VsZCBiZSBjb25uZWN0ZWQNCi0gIHRvIHRoZSBpbnB1dCBw
b3J0IG9mIGFuIGF0dGFjaGVkIEhETUkgb3IgTFZEUyBlbmNvZGVyIGNoaXAuDQotDQotT3B0aW9u
YWwgcHJvcGVydGllczoNCi0tIHBpbmN0cmwtbmFtZXM6IENvbnRhaW4gImdwaW9tb2RlIiBhbmQg
ImRwaW1vZGUiLg0KLSAgcGluY3RybC1uYW1lcyBzZWUgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3BpbmN0cmwvcGluY3RybC1iaW5kaW5ncy50eHQNCi0tIHBjbGstc2FtcGxlOiBy
ZWZlciBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVkaWEvdmlkZW8taW50ZXJm
YWNlcy50eHQuDQotDQotRXhhbXBsZToNCi0NCi1kcGkwOiBkcGlAMTQwMWQwMDAgew0KLQljb21w
YXRpYmxlID0gIm1lZGlhdGVrLG10ODE3My1kcGkiOw0KLQlyZWcgPSA8MCAweDE0MDFkMDAwIDAg
MHgxMDAwPjsNCi0JaW50ZXJydXB0cyA9IDxHSUNfU1BJIDE5NCBJUlFfVFlQRV9MRVZFTF9MT1c+
Ow0KLQljbG9ja3MgPSA8Jm1tc3lzIENMS19NTV9EUElfUElYRUw+LA0KLQkJIDwmbW1zeXMgQ0xL
X01NX0RQSV9FTkdJTkU+LA0KLQkJIDwmYXBtaXhlZHN5cyBDTEtfQVBNSVhFRF9UVkRQTEw+Ow0K
LQljbG9jay1uYW1lcyA9ICJwaXhlbCIsICJlbmdpbmUiLCAicGxsIjsNCi0JcGluY3RybC1uYW1l
cyA9ICJhY3RpdmUiLCAiaWRsZSI7DQotCXBpbmN0cmwtMCA9IDwmZHBpX3Bpbl9mdW5jPjsNCi0J
cGluY3RybC0xID0gPCZkcGlfcGluX2lkbGU+Ow0KLQ0KLQlwb3J0IHsNCi0JCWRwaTBfb3V0OiBl
bmRwb2ludCB7DQotCQkJcGNsay1zYW1wbGUgPSA8MD47DQotCQkJcmVtb3RlLWVuZHBvaW50ID0g
PCZoZG1pMF9pbj47DQotCQl9Ow0KLQl9Ow0KLX07DQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHBpLnlhbWwg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRp
YXRlayxkcGkueWFtbA0KbmV3IGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4IDAwMDAwMDAwMDAwMC4u
ZWIyYjBjYjVlYjVhDQotLS0gL2Rldi9udWxsDQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkcGkueWFtbA0KQEAgLTAsMCAr
MSw5MiBAQA0KKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCislWUFNTCAxLjIN
CistLS0NCiskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2Rpc3BsYXkvbWVkaWF0
ZWssZHBpLnlhbWwjDQorJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1h
cy9jb3JlLnlhbWwjDQorDQordGl0bGU6IG1lZGlhdGVrIERQSSBDb250cm9sbGVyIERldmljZSBU
cmVlIEJpbmRpbmdzDQorDQorbWFpbnRhaW5lcnM6DQorICAtIENLIEh1IDxjay5odUBtZWRpYXRl
ay5jb20+DQorICAtIEppdGFvIHNoaSA8aml0YW8uc2hpQG1lZGlhdGVrLmNvbT4NCisNCitkZXNj
cmlwdGlvbjogfA0KKyAgVGhlIE1lZGlhdGVrIERQSSBmdW5jdGlvbiBibG9jayBpcyBhIHNpbmsg
b2YgdGhlIGRpc3BsYXkgc3Vic3lzdGVtIGFuZA0KKyAgcHJvdmlkZXMgOC1iaXQgUkdCL1lVVjQ0
NCBvciA4LzEwLzEwLWJpdCBZVVY0MjIgcGl4ZWwgZGF0YSBvbiBhIHBhcmFsbGVsDQorICBvdXRw
dXQgYnVzLg0KKw0KK3Byb3BlcnRpZXM6DQorICBjb21wYXRpYmxlOg0KKyAgICBlbnVtOg0KKyAg
ICAgIC0gbWVkaWF0ZWssbXQyNzAxLWRwaQ0KKyAgICAgIC0gbWVkaWF0ZWssbXQ4MTczLWRwaQ0K
KyAgICAgIC0gbWVkaWF0ZWssbXQ4MTgzLWRwaQ0KKw0KKyAgcmVnOg0KKyAgICBtYXhJdGVtczog
MQ0KKw0KKyAgaW50ZXJydXB0czoNCisgICAgbWF4SXRlbXM6IDENCisNCisgIGNsb2NrczoNCisg
ICAgaXRlbXM6DQorICAgICAgLSBkZXNjcmlwdGlvbjogUGl4ZWwgQ2xvY2sNCisgICAgICAtIGRl
c2NyaXB0aW9uOiBFbmdpbmUgQ2xvY2sNCisgICAgICAtIGRlc2NyaXB0aW9uOiBEUEkgUExMDQor
DQorICBjbG9jay1uYW1lczoNCisgICAgaXRlbXM6DQorICAgICAgLSBjb25zdDogcGl4ZWwNCisg
ICAgICAtIGNvbnN0OiBlbmdpbmUNCisgICAgICAtIGNvbnN0OiBwbGwNCisNCisgIHBpbmN0cmwt
bmFtZXM6DQorICAgIGl0ZW1zOg0KKyAgICAgIC0gY29uc3Q6IGRlZmF1bHQNCisgICAgICAtIGNv
bnN0OiBzbGVlcA0KKw0KKyAgcG9ydDoNCisgICAgdHlwZTogb2JqZWN0DQorICAgIGRlc2NyaXB0
aW9uOg0KKyAgICAgIE91dHB1dCBwb3J0IG5vZGUgd2l0aCBlbmRwb2ludCBkZWZpbml0aW9ucyBh
cyBkZXNjcmliZWQgaW4NCisgICAgICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
Z3JhcGgudHh0LiBUaGlzIHBvcnQgc2hvdWxkIGJlIGNvbm5lY3RlZA0KKyAgICAgIHRvIHRoZSBp
bnB1dCBwb3J0IG9mIGFuIGF0dGFjaGVkIEhETUkgb3IgTFZEUyBlbmNvZGVyIGNoaXAuDQorDQor
ICAgIHByb3BlcnRpZXM6DQorICAgICAgcGNsay1zYW1wbGU6DQorICAgICAgZGVzY3JpcHRpb246
IHJlZmVyIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS92aWRlby1pbnRl
cmZhY2VzLnR4dC4NCisNCityZXF1aXJlZDoNCisgIC0gY29tcGF0aWJsZQ0KKyAgLSByZWcNCisg
IC0gaW50ZXJydXB0cw0KKyAgLSBjbG9ja3MNCisgIC0gY2xvY2stbmFtZXMNCisgIC0gcG9ydA0K
Kw0KK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KKw0KK2V4YW1wbGVzOg0KKyAgLSB8DQor
ICAgIGRwaTA6IGRwaUAxNDAxZDAwMCB7DQorICAgICAgICBjb21wYXRpYmxlID0gIm1lZGlhdGVr
LG10ODE3My1kcGkiOw0KKyAgICAgICAgcmVnID0gPDAgMHgxNDAxZDAwMCAwIDB4MTAwMD47DQor
ICAgICAgICBpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMTk0IElSUV9UWVBFX0xFVkVMX0xPVz47DQor
ICAgICAgICBjbG9ja3MgPSA8Jm1tc3lzIENMS19NTV9EUElfUElYRUw+LA0KKyAgICAgICAgICAg
ICA8Jm1tc3lzIENMS19NTV9EUElfRU5HSU5FPiwNCisgICAgICAgICAgICAgPCZhcG1peGVkc3lz
IENMS19BUE1JWEVEX1RWRFBMTD47DQorICAgICAgICBjbG9jay1uYW1lcyA9ICJwaXhlbCIsICJl
bmdpbmUiLCAicGxsIjsNCisgICAgICAgIHBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCIsICJzbGVl
cCI7DQorICAgICAgICBwaW5jdHJsLTAgPSA8JmRwaV9waW5fZnVuYz47DQorICAgICAgICBwaW5j
dHJsLTEgPSA8JmRwaV9waW5faWRsZT47DQorDQorICAgICAgICBwb3J0IHsNCisgICAgICAgICAg
ICByZWcgPSA8MD47DQorICAgICAgICAgICAgZHBpMF9vdXQ6IGVuZHBvaW50IHsNCisgICAgICAg
ICAgICAgICAgcGNsay1zYW1wbGUgPSA8MD47DQorICAgICAgICAgICAgICAgIHJlbW90ZS1lbmRw
b2ludCA9IDwmaGRtaTBfaW4+Ow0KKyAgICAgICAgICAgIH07DQorICAgICAgICB9Ow0KKyAgICB9
Ow0KKw0KKy4uLg0KLS0gDQoyLjIxLjANCg==

