Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B63C38A29
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 01:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7840C20732
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 01:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MFg9ZJT5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388776AbgDOBNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 21:13:46 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:10163 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388413AbgDOBNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 21:13:36 -0400
X-UUID: 1a62970a25f54caf91d28c4de27047a8-20200415
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=sbmwqRaPnFNnVMN+0QzsLnHsob5l0i9xYF51mT12EvM=;
        b=MFg9ZJT5Rj0MX8VczA9Exs8st5V6Y5SnSHfrwnQpXE+OEHGiDW09sT4UClhxqxxcLkzMfdWVxRwU9Y36TkpgG/PoxMPQZq8lnwlVDIIR8r5mx10cpJnV4covtbXj53FCYEJcn13jvZxidQfzhpQO8jTiTKQPCq+jss4eS58V+uU=;
X-UUID: 1a62970a25f54caf91d28c4de27047a8-20200415
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2060372180; Wed, 15 Apr 2020 09:13:26 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 15 Apr
 2020 09:13:25 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 15 Apr 2020 09:13:22 +0800
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
Subject: [PATCH v15 2/3] dt-bindings: display: mediatek: convert the document format from txt to yaml
Date:   Wed, 15 Apr 2020 09:13:18 +0800
Message-ID: <20200415011319.25559-3-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.12.5
In-Reply-To: <20200415011319.25559-1-jitao.shi@mediatek.com>
References: <20200415011319.25559-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 054F3D6F7D350A99C00CE8F24EED9ECEABC3F08F71BCF1A53B28F1ECF983E8D82000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U2lnbmVkLW9mZi1ieTogSml0YW8gU2hpIDxqaXRhby5zaGlAbWVkaWF0ZWsuY29tPg0KLS0tDQog
Li4uL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHBpLnR4dCAgICAgfCA0MiAt
LS0tLS0tLS0tDQogLi4uL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHBpLnlh
bWwgICAgfCA5NyArKysrKysrKysrKysrKysrKysrKysrDQogMiBmaWxlcyBjaGFuZ2VkLCA5NyBp
bnNlcnRpb25zKCspLCA0MiBkZWxldGlvbnMoLSkNCiBkZWxldGUgbW9kZSAxMDA2NDQgRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHBp
LnR4dA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkcGkueWFtbA0KDQpkaWZmIC0tZ2l0IGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWss
ZHBpLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlh
dGVrL21lZGlhdGVrLGRwaS50eHQNCmRlbGV0ZWQgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggNzdk
ZWY0NDU2NzA2Li4wMDAwMDAwMDAwMDANCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRwaS50eHQNCisrKyAvZGV2L251bGwN
CkBAIC0xLDQyICswLDAgQEANCi1NZWRpYXRlayBEUEkgRGV2aWNlDQotPT09PT09PT09PT09PT09
PT09PQ0KLQ0KLVRoZSBNZWRpYXRlayBEUEkgZnVuY3Rpb24gYmxvY2sgaXMgYSBzaW5rIG9mIHRo
ZSBkaXNwbGF5IHN1YnN5c3RlbSBhbmQNCi1wcm92aWRlcyA4LWJpdCBSR0IvWVVWNDQ0IG9yIDgv
MTAvMTAtYml0IFlVVjQyMiBwaXhlbCBkYXRhIG9uIGEgcGFyYWxsZWwNCi1vdXRwdXQgYnVzLg0K
LQ0KLVJlcXVpcmVkIHByb3BlcnRpZXM6DQotLSBjb21wYXRpYmxlOiAibWVkaWF0ZWssPGNoaXA+
LWRwaSINCi0gIHRoZSBzdXBwb3J0ZWQgY2hpcHMgYXJlIG10MjcwMSAsIG10ODE3MyBhbmQgbXQ4
MTgzLg0KLS0gcmVnOiBQaHlzaWNhbCBiYXNlIGFkZHJlc3MgYW5kIGxlbmd0aCBvZiB0aGUgY29u
dHJvbGxlcidzIHJlZ2lzdGVycw0KLS0gaW50ZXJydXB0czogVGhlIGludGVycnVwdCBzaWduYWwg
ZnJvbSB0aGUgZnVuY3Rpb24gYmxvY2suDQotLSBjbG9ja3M6IGRldmljZSBjbG9ja3MNCi0gIFNl
ZSBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY2xvY2svY2xvY2stYmluZGluZ3Mu
dHh0IGZvciBkZXRhaWxzLg0KLS0gY2xvY2stbmFtZXM6IG11c3QgY29udGFpbiAicGl4ZWwiLCAi
ZW5naW5lIiwgYW5kICJwbGwiDQotLSBwb3J0OiBPdXRwdXQgcG9ydCBub2RlIHdpdGggZW5kcG9p
bnQgZGVmaW5pdGlvbnMgYXMgZGVzY3JpYmVkIGluDQotICBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvZ3JhcGgudHh0LiBUaGlzIHBvcnQgc2hvdWxkIGJlIGNvbm5lY3RlZA0KLSAg
dG8gdGhlIGlucHV0IHBvcnQgb2YgYW4gYXR0YWNoZWQgSERNSSBvciBMVkRTIGVuY29kZXIgY2hp
cC4NCi0NCi1PcHRpb25hbCBwcm9wZXJ0aWVzOg0KLS0gcGluY3RybC1uYW1lczogQ29udGFpbiAi
ZGVmYXVsdCIgYW5kICJzbGVlcCIuDQotDQotRXhhbXBsZToNCi0NCi1kcGkwOiBkcGlAMTQwMWQw
MDAgew0KLQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE3My1kcGkiOw0KLQlyZWcgPSA8MCAw
eDE0MDFkMDAwIDAgMHgxMDAwPjsNCi0JaW50ZXJydXB0cyA9IDxHSUNfU1BJIDE5NCBJUlFfVFlQ
RV9MRVZFTF9MT1c+Ow0KLQljbG9ja3MgPSA8Jm1tc3lzIENMS19NTV9EUElfUElYRUw+LA0KLQkJ
IDwmbW1zeXMgQ0xLX01NX0RQSV9FTkdJTkU+LA0KLQkJIDwmYXBtaXhlZHN5cyBDTEtfQVBNSVhF
RF9UVkRQTEw+Ow0KLQljbG9jay1uYW1lcyA9ICJwaXhlbCIsICJlbmdpbmUiLCAicGxsIjsNCi0J
cGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IiwgInNsZWVwIjsNCi0JcGluY3RybC0wID0gPCZkcGlf
cGluX2Z1bmM+Ow0KLQlwaW5jdHJsLTEgPSA8JmRwaV9waW5faWRsZT47DQotDQotCXBvcnQgew0K
LQkJZHBpMF9vdXQ6IGVuZHBvaW50IHsNCi0JCQlyZW1vdGUtZW5kcG9pbnQgPSA8JmhkbWkwX2lu
PjsNCi0JCX07DQotCX07DQotfTsNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkcGkueWFtbCBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRwaS55
YW1sDQpuZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMDAwMDAwLi4yYzJkNmE3MWNi
OGINCi0tLSAvZGV2L251bGwNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRwaS55YW1sDQpAQCAtMCwwICsxLDk3IEBADQor
IyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KKyVZQU1MIDEuMg0KKy0tLQ0KKyRp
ZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRl
ayxkcGkueWFtbCMNCiskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFz
L2NvcmUueWFtbCMNCisNCit0aXRsZTogbWVkaWF0ZWsgRFBJIENvbnRyb2xsZXIgRGV2aWNlIFRy
ZWUgQmluZGluZ3MNCisNCittYWludGFpbmVyczoNCisgIC0gQ0sgSHUgPGNrLmh1QG1lZGlhdGVr
LmNvbT4NCisgIC0gSml0YW8gc2hpIDxqaXRhby5zaGlAbWVkaWF0ZWsuY29tPg0KKw0KK2Rlc2Ny
aXB0aW9uOiB8DQorICBUaGUgTWVkaWF0ZWsgRFBJIGZ1bmN0aW9uIGJsb2NrIGlzIGEgc2luayBv
ZiB0aGUgZGlzcGxheSBzdWJzeXN0ZW0gYW5kDQorICBwcm92aWRlcyA4LWJpdCBSR0IvWVVWNDQ0
IG9yIDgvMTAvMTAtYml0IFlVVjQyMiBwaXhlbCBkYXRhIG9uIGEgcGFyYWxsZWwNCisgIG91dHB1
dCBidXMuDQorDQorcHJvcGVydGllczoNCisgIGNvbXBhdGlibGU6DQorICAgIGVudW06DQorICAg
ICAgLSBtZWRpYXRlayxtdDI3MDEtZHBpDQorICAgICAgLSBtZWRpYXRlayxtdDgxNzMtZHBpDQor
ICAgICAgLSBtZWRpYXRlayxtdDgxODMtZHBpDQorDQorICByZWc6DQorICAgIG1heEl0ZW1zOiAx
DQorDQorICBpbnRlcnJ1cHRzOg0KKyAgICBtYXhJdGVtczogMQ0KKw0KKyAgY2xvY2tzOg0KKyAg
ICBpdGVtczoNCisgICAgICAtIGRlc2NyaXB0aW9uOiBQaXhlbCBDbG9jaw0KKyAgICAgIC0gZGVz
Y3JpcHRpb246IEVuZ2luZSBDbG9jaw0KKyAgICAgIC0gZGVzY3JpcHRpb246IERQSSBQTEwNCisN
CisgIGNsb2NrLW5hbWVzOg0KKyAgICBpdGVtczoNCisgICAgICAtIGNvbnN0OiBwaXhlbA0KKyAg
ICAgIC0gY29uc3Q6IGVuZ2luZQ0KKyAgICAgIC0gY29uc3Q6IHBsbA0KKw0KKyAgcGluY3RybC0w
OiB0cnVlDQorICBwaW5jdHJsLTE6IHRydWUNCisNCisgIHBpbmN0cmwtbmFtZXM6DQorICAgIGl0
ZW1zOg0KKyAgICAgIC0gY29uc3Q6IGRlZmF1bHQNCisgICAgICAtIGNvbnN0OiBzbGVlcA0KKw0K
KyAgcG9ydDoNCisgICAgdHlwZTogb2JqZWN0DQorICAgIGRlc2NyaXB0aW9uOg0KKyAgICAgIE91
dHB1dCBwb3J0IG5vZGUgd2l0aCBlbmRwb2ludCBkZWZpbml0aW9ucyBhcyBkZXNjcmliZWQgaW4N
CisgICAgICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZ3JhcGgudHh0LiBUaGlz
IHBvcnQgc2hvdWxkIGJlIGNvbm5lY3RlZA0KKyAgICAgIHRvIHRoZSBpbnB1dCBwb3J0IG9mIGFu
IGF0dGFjaGVkIEhETUkgb3IgTFZEUyBlbmNvZGVyIGNoaXAuDQorDQorICAgIHByb3BlcnRpZXM6
DQorICAgICAgZW5kcG9pbnQ6DQorICAgICAgICB0eXBlOiBvYmplY3QNCisNCityZXF1aXJlZDoN
CisgIC0gY29tcGF0aWJsZQ0KKyAgLSByZWcNCisgIC0gaW50ZXJydXB0cw0KKyAgLSBjbG9ja3MN
CisgIC0gY2xvY2stbmFtZXMNCisgIC0gcG9ydA0KKw0KK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBm
YWxzZQ0KKw0KK2V4YW1wbGVzOg0KKyAgLSB8DQorICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9p
bnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+DQorICAgICNpbmNsdWRlIDxkdC1iaW5kaW5n
cy9jbG9jay9tdDgxNzMtY2xrLmg+DQorICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1
cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+DQorICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRl
cnJ1cHQtY29udHJvbGxlci9pcnEuaD4NCisgICAgZHBpMDogZHBpQDE0MDFkMDAwIHsNCisgICAg
ICAgIGNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTczLWRwaSI7DQorICAgICAgICByZWcgPSA8
MCAweDE0MDFkMDAwIDAgMHgxMDAwPjsNCisgICAgICAgIGludGVycnVwdHMgPSA8R0lDX1NQSSAx
OTQgSVJRX1RZUEVfTEVWRUxfTE9XPjsNCisgICAgICAgIGNsb2NrcyA9IDwmbW1zeXMgQ0xLX01N
X0RQSV9QSVhFTD4sDQorICAgICAgICAgICAgIDwmbW1zeXMgQ0xLX01NX0RQSV9FTkdJTkU+LA0K
KyAgICAgICAgICAgICA8JmFwbWl4ZWRzeXMgQ0xLX0FQTUlYRURfVFZEUExMPjsNCisgICAgICAg
IGNsb2NrLW5hbWVzID0gInBpeGVsIiwgImVuZ2luZSIsICJwbGwiOw0KKyAgICAgICAgcGluY3Ry
bC1uYW1lcyA9ICJkZWZhdWx0IiwgInNsZWVwIjsNCisgICAgICAgIHBpbmN0cmwtMCA9IDwmZHBp
X3Bpbl9mdW5jPjsNCisgICAgICAgIHBpbmN0cmwtMSA9IDwmZHBpX3Bpbl9pZGxlPjsNCisNCisg
ICAgICAgIHBvcnQgew0KKyAgICAgICAgICAgIGRwaTBfb3V0OiBlbmRwb2ludCB7DQorICAgICAg
ICAgICAgICAgIHJlbW90ZS1lbmRwb2ludCA9IDwmaGRtaTBfaW4+Ow0KKyAgICAgICAgICAgIH07
DQorICAgICAgICB9Ow0KKyAgICB9Ow0KKw0KKy4uLg0KLS0gDQoyLjEyLjUNCg==

