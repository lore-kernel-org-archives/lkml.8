Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC70EC2BA15
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 08:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F8D206F8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 08:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FAxAeBIN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390459AbgDCIFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 04:05:00 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:14867 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390431AbgDCIE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 04:04:59 -0400
X-UUID: e759dedfbcbf4cfb8c4fb1d72de4eab1-20200403
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=bYMc9OznLPrGLr6gJF9UOCWwJMxzT0GifD+9RfEVLu4=;
        b=FAxAeBINdzhMA9BzMWX8Chf2H1i6XTbRt7WdO6zql7Q4y1J5cF35JslS+p7BGPKQTSl2FJUjCc4jPGfjMg1fBQod4PzxYOOR9nbKsolzsLm8us1vtNWOb7S7AscTv2vcn84iEzVCVzTiP53Oj0InxxlYBMyNQ3cplua8yUyqqsg=;
X-UUID: e759dedfbcbf4cfb8c4fb1d72de4eab1-20200403
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 641879745; Fri, 03 Apr 2020 16:03:59 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 3 Apr
 2020 16:03:58 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Fri, 3 Apr 2020 16:03:55 +0800
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
Subject: [PATCH v14 2/3] dt-bindings: display: mediatek: convert the document format from txt to yaml
Date:   Fri, 3 Apr 2020 16:03:49 +0800
Message-ID: <20200403080350.95826-3-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200403080350.95826-1-jitao.shi@mediatek.com>
References: <20200403080350.95826-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: A5FFD7C2E38A0D8BED24F226F9270500E1172E398269E27C6C5B807142774C3C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U2lnbmVkLW9mZi1ieTogSml0YW8gU2hpIDxqaXRhby5zaGlAbWVkaWF0ZWsuY29tPg0KLS0tDQog
Li4uL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHBpLnR4dCAgICAgICAgIHwgNDIgLS0tLS0t
LS0NCiAuLi4vZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkcGkueWFtbCAgICAgICAgfCA5NyAr
KysrKysrKysrKysrKysrKysrDQogMiBmaWxlcyBjaGFuZ2VkLCA5NyBpbnNlcnRpb25zKCspLCA0
MiBkZWxldGlvbnMoLSkNCiBkZWxldGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHBpLnR4dA0KIGNyZWF0ZSBt
b2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRp
YXRlay9tZWRpYXRlayxkcGkueWFtbA0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHBpLnR4dCBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRw
aS50eHQNCmRlbGV0ZWQgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggNzdkZWY0NDU2NzA2Li4wMDAw
MDAwMDAwMDANCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5
L21lZGlhdGVrL21lZGlhdGVrLGRwaS50eHQNCisrKyAvZGV2L251bGwNCkBAIC0xLDQyICswLDAg
QEANCi1NZWRpYXRlayBEUEkgRGV2aWNlDQotPT09PT09PT09PT09PT09PT09PQ0KLQ0KLVRoZSBN
ZWRpYXRlayBEUEkgZnVuY3Rpb24gYmxvY2sgaXMgYSBzaW5rIG9mIHRoZSBkaXNwbGF5IHN1YnN5
c3RlbSBhbmQNCi1wcm92aWRlcyA4LWJpdCBSR0IvWVVWNDQ0IG9yIDgvMTAvMTAtYml0IFlVVjQy
MiBwaXhlbCBkYXRhIG9uIGEgcGFyYWxsZWwNCi1vdXRwdXQgYnVzLg0KLQ0KLVJlcXVpcmVkIHBy
b3BlcnRpZXM6DQotLSBjb21wYXRpYmxlOiAibWVkaWF0ZWssPGNoaXA+LWRwaSINCi0gIHRoZSBz
dXBwb3J0ZWQgY2hpcHMgYXJlIG10MjcwMSAsIG10ODE3MyBhbmQgbXQ4MTgzLg0KLS0gcmVnOiBQ
aHlzaWNhbCBiYXNlIGFkZHJlc3MgYW5kIGxlbmd0aCBvZiB0aGUgY29udHJvbGxlcidzIHJlZ2lz
dGVycw0KLS0gaW50ZXJydXB0czogVGhlIGludGVycnVwdCBzaWduYWwgZnJvbSB0aGUgZnVuY3Rp
b24gYmxvY2suDQotLSBjbG9ja3M6IGRldmljZSBjbG9ja3MNCi0gIFNlZSBEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvY2xvY2svY2xvY2stYmluZGluZ3MudHh0IGZvciBkZXRhaWxz
Lg0KLS0gY2xvY2stbmFtZXM6IG11c3QgY29udGFpbiAicGl4ZWwiLCAiZW5naW5lIiwgYW5kICJw
bGwiDQotLSBwb3J0OiBPdXRwdXQgcG9ydCBub2RlIHdpdGggZW5kcG9pbnQgZGVmaW5pdGlvbnMg
YXMgZGVzY3JpYmVkIGluDQotICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZ3Jh
cGgudHh0LiBUaGlzIHBvcnQgc2hvdWxkIGJlIGNvbm5lY3RlZA0KLSAgdG8gdGhlIGlucHV0IHBv
cnQgb2YgYW4gYXR0YWNoZWQgSERNSSBvciBMVkRTIGVuY29kZXIgY2hpcC4NCi0NCi1PcHRpb25h
bCBwcm9wZXJ0aWVzOg0KLS0gcGluY3RybC1uYW1lczogQ29udGFpbiAiZGVmYXVsdCIgYW5kICJz
bGVlcCIuDQotDQotRXhhbXBsZToNCi0NCi1kcGkwOiBkcGlAMTQwMWQwMDAgew0KLQljb21wYXRp
YmxlID0gIm1lZGlhdGVrLG10ODE3My1kcGkiOw0KLQlyZWcgPSA8MCAweDE0MDFkMDAwIDAgMHgx
MDAwPjsNCi0JaW50ZXJydXB0cyA9IDxHSUNfU1BJIDE5NCBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0K
LQljbG9ja3MgPSA8Jm1tc3lzIENMS19NTV9EUElfUElYRUw+LA0KLQkJIDwmbW1zeXMgQ0xLX01N
X0RQSV9FTkdJTkU+LA0KLQkJIDwmYXBtaXhlZHN5cyBDTEtfQVBNSVhFRF9UVkRQTEw+Ow0KLQlj
bG9jay1uYW1lcyA9ICJwaXhlbCIsICJlbmdpbmUiLCAicGxsIjsNCi0JcGluY3RybC1uYW1lcyA9
ICJkZWZhdWx0IiwgInNsZWVwIjsNCi0JcGluY3RybC0wID0gPCZkcGlfcGluX2Z1bmM+Ow0KLQlw
aW5jdHJsLTEgPSA8JmRwaV9waW5faWRsZT47DQotDQotCXBvcnQgew0KLQkJZHBpMF9vdXQ6IGVu
ZHBvaW50IHsNCi0JCQlyZW1vdGUtZW5kcG9pbnQgPSA8JmhkbWkwX2luPjsNCi0JCX07DQotCX07
DQotfTsNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlz
cGxheS9tZWRpYXRlay9tZWRpYXRlayxkcGkueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRwaS55YW1sDQpuZXcgZmlsZSBt
b2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMDAwMDAwLi5lZmZkYWE5NmFlYzMNCi0tLSAvZGV2L251
bGwNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlh
dGVrL21lZGlhdGVrLGRwaS55YW1sDQpAQCAtMCwwICsxLDk3IEBADQorIyBTUERYLUxpY2Vuc2Ut
SWRlbnRpZmllcjogR1BMLTIuMA0KKyVZQU1MIDEuMg0KKy0tLQ0KKyRpZDogaHR0cDovL2Rldmlj
ZXRyZWUub3JnL3NjaGVtYXMvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkcGkueWFtbCMNCisk
c2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCisN
Cit0aXRsZTogbWVkaWF0ZWsgRFBJIENvbnRyb2xsZXIgRGV2aWNlIFRyZWUgQmluZGluZ3MNCisN
CittYWludGFpbmVyczoNCisgIC0gQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCisgIC0gSml0
YW8gc2hpIDxqaXRhby5zaGlAbWVkaWF0ZWsuY29tPg0KKw0KK2Rlc2NyaXB0aW9uOiB8DQorICBU
aGUgTWVkaWF0ZWsgRFBJIGZ1bmN0aW9uIGJsb2NrIGlzIGEgc2luayBvZiB0aGUgZGlzcGxheSBz
dWJzeXN0ZW0gYW5kDQorICBwcm92aWRlcyA4LWJpdCBSR0IvWVVWNDQ0IG9yIDgvMTAvMTAtYml0
IFlVVjQyMiBwaXhlbCBkYXRhIG9uIGEgcGFyYWxsZWwNCisgIG91dHB1dCBidXMuDQorDQorcHJv
cGVydGllczoNCisgIGNvbXBhdGlibGU6DQorICAgIGVudW06DQorICAgICAgLSBtZWRpYXRlayxt
dDI3MDEtZHBpDQorICAgICAgLSBtZWRpYXRlayxtdDgxNzMtZHBpDQorICAgICAgLSBtZWRpYXRl
ayxtdDgxODMtZHBpDQorDQorICByZWc6DQorICAgIG1heEl0ZW1zOiAxDQorDQorICBpbnRlcnJ1
cHRzOg0KKyAgICBtYXhJdGVtczogMQ0KKw0KKyAgY2xvY2tzOg0KKyAgICBpdGVtczoNCisgICAg
ICAtIGRlc2NyaXB0aW9uOiBQaXhlbCBDbG9jaw0KKyAgICAgIC0gZGVzY3JpcHRpb246IEVuZ2lu
ZSBDbG9jaw0KKyAgICAgIC0gZGVzY3JpcHRpb246IERQSSBQTEwNCisNCisgIGNsb2NrLW5hbWVz
Og0KKyAgICBpdGVtczoNCisgICAgICAtIGNvbnN0OiBwaXhlbA0KKyAgICAgIC0gY29uc3Q6IGVu
Z2luZQ0KKyAgICAgIC0gY29uc3Q6IHBsbA0KKw0KKyAgcGluY3RybC0wOiB0cnVlDQorICBwaW5j
dHJsLTE6IHRydWUNCisNCisgIHBpbmN0cmwtbmFtZXM6DQorICAgIGl0ZW1zOg0KKyAgICAgIC0g
Y29uc3Q6IGRlZmF1bHQNCisgICAgICAtIGNvbnN0OiBzbGVlcA0KKw0KKyAgcG9ydEAwOg0KKyAg
ICB0eXBlOiBvYmplY3QNCisgICAgZGVzY3JpcHRpb246DQorICAgICAgT3V0cHV0IHBvcnQgbm9k
ZSB3aXRoIGVuZHBvaW50IGRlZmluaXRpb25zIGFzIGRlc2NyaWJlZCBpbg0KKyAgICAgIERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ncmFwaC50eHQuIFRoaXMgcG9ydCBzaG91bGQg
YmUgY29ubmVjdGVkDQorICAgICAgdG8gdGhlIGlucHV0IHBvcnQgb2YgYW4gYXR0YWNoZWQgSERN
SSBvciBMVkRTIGVuY29kZXIgY2hpcC4NCisNCisgICAgcHJvcGVydGllczoNCisgICAgICBlbmRw
b2ludDoNCisgICAgICAgIHR5cGU6IG9iamVjdA0KKw0KK3JlcXVpcmVkOg0KKyAgLSBjb21wYXRp
YmxlDQorICAtIHJlZw0KKyAgLSBpbnRlcnJ1cHRzDQorICAtIGNsb2Nrcw0KKyAgLSBjbG9jay1u
YW1lcw0KKyAgLSBwb3J0QDANCisNCithZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UNCisNCitl
eGFtcGxlczoNCisgIC0gfA0KKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNv
bnRyb2xsZXIvYXJtLWdpYy5oPg0KKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvY2xvY2svbXQ4
MTczLWNsay5oPg0KKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xs
ZXIvYXJtLWdpYy5oPg0KKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNvbnRy
b2xsZXIvaXJxLmg+DQorICAgIGRwaTA6IGRwaUAxNDAxZDAwMCB7DQorICAgICAgICBjb21wYXRp
YmxlID0gIm1lZGlhdGVrLG10ODE3My1kcGkiOw0KKyAgICAgICAgcmVnID0gPDAgMHgxNDAxZDAw
MCAwIDB4MTAwMD47DQorICAgICAgICBpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMTk0IElSUV9UWVBF
X0xFVkVMX0xPVz47DQorICAgICAgICBjbG9ja3MgPSA8Jm1tc3lzIENMS19NTV9EUElfUElYRUw+
LA0KKyAgICAgICAgICAgICA8Jm1tc3lzIENMS19NTV9EUElfRU5HSU5FPiwNCisgICAgICAgICAg
ICAgPCZhcG1peGVkc3lzIENMS19BUE1JWEVEX1RWRFBMTD47DQorICAgICAgICBjbG9jay1uYW1l
cyA9ICJwaXhlbCIsICJlbmdpbmUiLCAicGxsIjsNCisgICAgICAgIHBpbmN0cmwtbmFtZXMgPSAi
ZGVmYXVsdCIsICJzbGVlcCI7DQorICAgICAgICBwaW5jdHJsLTAgPSA8JmRwaV9waW5fZnVuYz47
DQorICAgICAgICBwaW5jdHJsLTEgPSA8JmRwaV9waW5faWRsZT47DQorDQorICAgICAgICBwb3J0
QDAgew0KKyAgICAgICAgICAgIGRwaTBfb3V0OiBlbmRwb2ludCB7DQorICAgICAgICAgICAgICAg
IHJlbW90ZS1lbmRwb2ludCA9IDwmaGRtaTBfaW4+Ow0KKyAgICAgICAgICAgIH07DQorICAgICAg
ICB9Ow0KKyAgICB9Ow0KKw0KKy4uLg0KLS0gDQoyLjIxLjANCg==

