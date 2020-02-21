Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255C1C35647
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEDCF24650
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ovexBTzC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgBUL2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 06:28:50 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:44963 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727827AbgBUL2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 06:28:49 -0500
X-UUID: a8dc2fe4bf9842d09d12808d4b6a7848-20200221
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=zFZhXk7fCqXKk9Mb/Rx6jZKFuJRDTSRGsr1lm/b+5DU=;
        b=ovexBTzC48RueZbJWZ+GrTK/Hn7xV7SIeRvMI8QvWXNouMt+mRI45xOOZMYQ56YgnItVtHVPx1zQqPqEX1FFtOoCoPOg33SJiApGb4RuZWKPH2JfBYn4NurRWrdJ9285hC2nn+3Utvb/YNqgZ/b69tpbPMRtvVBZTv8zN/Ik6Go=;
X-UUID: a8dc2fe4bf9842d09d12808d4b6a7848-20200221
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1467076355; Fri, 21 Feb 2020 19:28:39 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 21 Feb
 2020 19:23:59 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Fri, 21 Feb 2020 19:27:34 +0800
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
Subject: [PATCH v6 1/4] dt-bindings: display: mediatek: update dpi supported chips
Date:   Fri, 21 Feb 2020 19:28:25 +0800
Message-ID: <20200221112828.55837-2-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200221112828.55837-1-jitao.shi@mediatek.com>
References: <20200221112828.55837-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 45350EF9107AC20D662E832B95D598681BBB945A8E95C707967860581846053F2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGRlY3JpcHRpb25zIGFib3V0IHN1cHBvcnRlZCBjaGlwcywgaW5jbHVkaW5nIE1UMjcwMSAm
IE1UODE3MyAmDQptdDgxODMNCg0KMS4gQWRkIG1vcmUgY2hpcHMgc3VwcG9ydC4gZXguIE1UMjcw
MSAmIE1UODE3MyAmIE1UODE4Mw0KMi4gQWRkIHByb3BlcnR5ICJkcGlfcGluX21vZGVfc3dhcCIg
YW5kICJwaW5jdHJsLW5hbWVzIiBncGlvIG1vZGUgZHBpIG1vZGUgYW5kDQogICBncGlvIG91cHB1
dC1sb3cgdG8gYXZvaWQgbGVha2FnZSBjdXJyZW50Lg0KMy4gQWRkIHByb3BlcnR5ICJkcGlfZHVh
bF9lZGdlIiB0byBjb25maWcgdGhlIGRwaSBwaW4gb3V0cHV0IG1vZGUgZHVhbCBlZGdlIG9yDQog
ICBzaW5nbGUgZWRnZSBzYW1wbGUgZGF0YS4NCg0KU2lnbmVkLW9mZi1ieTogSml0YW8gU2hpIDxq
aXRhby5zaGlAbWVkaWF0ZWsuY29tPg0KLS0tDQogLi4uL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0
ZWsvbWVkaWF0ZWssZHBpLnR4dCAgICAgICAgfCAxMSArKysrKysrKysrKw0KIDEgZmlsZSBjaGFu
Z2VkLCAxMSBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkcGkudHh0IGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHBp
LnR4dA0KaW5kZXggYjZhN2U3Mzk3YjhiLi5jZDZhMTQ2OWM4YjcgMTAwNjQ0DQotLS0gYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxk
cGkudHh0DQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9t
ZWRpYXRlay9tZWRpYXRlayxkcGkudHh0DQpAQCAtNyw2ICs3LDcgQEAgb3V0cHV0IGJ1cy4NCiAN
CiBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KIC0gY29tcGF0aWJsZTogIm1lZGlhdGVrLDxjaGlwPi1k
cGkiDQorICB0aGUgc3VwcG9ydGVkIGNoaXBzIGFyZSBtdDI3MDEgLCBtdDgxNzMgYW5kIG10ODE4
My4NCiAtIHJlZzogUGh5c2ljYWwgYmFzZSBhZGRyZXNzIGFuZCBsZW5ndGggb2YgdGhlIGNvbnRy
b2xsZXIncyByZWdpc3RlcnMNCiAtIGludGVycnVwdHM6IFRoZSBpbnRlcnJ1cHQgc2lnbmFsIGZy
b20gdGhlIGZ1bmN0aW9uIGJsb2NrLg0KIC0gY2xvY2tzOiBkZXZpY2UgY2xvY2tzDQpAQCAtMTYs
NiArMTcsMTEgQEAgUmVxdWlyZWQgcHJvcGVydGllczoNCiAgIERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9ncmFwaC50eHQuIFRoaXMgcG9ydCBzaG91bGQgYmUgY29ubmVjdGVkDQog
ICB0byB0aGUgaW5wdXQgcG9ydCBvZiBhbiBhdHRhY2hlZCBIRE1JIG9yIExWRFMgZW5jb2RlciBj
aGlwLg0KIA0KK09wdGlvbmFsIHByb3BlcnRpZXM6DQorLSBkcGlfcGluX21vZGVfc3dhcDogU3dh
cCB0aGUgcGluIG1vZGUgYmV0d2VlbiBkcGkgbW9kZSBhbmQgZ3BpbyBtb2RlLg0KKy0gcGluY3Ry
bC1uYW1lczogQ29udGFpbiAiZ3Bpb21vZGUiIGFuZCAiZHBpbW9kZSIuDQorLSBkcGlfZHVhbF9l
ZGdlOiBDb250cm9sIHRoZSBSR0IgMjRiaXQgZGF0YSBvbiAxMiBwaW5zIG9yIDI0IHBpbnMuDQor
DQogRXhhbXBsZToNCiANCiBkcGkwOiBkcGlAMTQwMWQwMDAgew0KQEAgLTI2LDYgKzMyLDExIEBA
IGRwaTA6IGRwaUAxNDAxZDAwMCB7DQogCQkgPCZtbXN5cyBDTEtfTU1fRFBJX0VOR0lORT4sDQog
CQkgPCZhcG1peGVkc3lzIENMS19BUE1JWEVEX1RWRFBMTD47DQogCWNsb2NrLW5hbWVzID0gInBp
eGVsIiwgImVuZ2luZSIsICJwbGwiOw0KKwlkcGlfZHVhbF9lZGdlOw0KKwlkcGlfcGluX21vZGVf
c3dhcDsNCisJcGluY3RybC1uYW1lcyA9ICJncGlvbW9kZSIsICJkcGltb2RlIjsNCisJcGluY3Ry
bC0wID0gPCZkcGlfcGluX2dwaW8+Ow0KKwlwaW5jdHJsLTEgPSA8JmRwaV9waW5fZnVuYz47DQog
DQogCXBvcnQgew0KIAkJZHBpMF9vdXQ6IGVuZHBvaW50IHsNCi0tIA0KMi4yMS4wDQo=

