Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4FEC38A29
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 01:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0853B20732
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 01:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="tudRCOWc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388574AbgDOBNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 21:13:35 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:8627 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388395AbgDOBNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 21:13:32 -0400
X-UUID: 70736340d81e496583dd8dbb1851b30c-20200415
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=nO2lhFsFTjN3a8s+w5ZBw2IIxzBf8mtfZDk0MhET6LE=;
        b=tudRCOWc91CaWwBzUKK/c0qOSUjruaP2pvC+O8N8SGZ4BKdT7CnbeN8d9zVIG1eJsB+IHIze101XYvwtZxpCU7sDwdLumsZ74MQnJnCjQWEQfbgeqPj9No4u+rZGyU4hRbFJZf3WWxDYXW40MrDB81mDgklafPidJJj1xWCIQxk=;
X-UUID: 70736340d81e496583dd8dbb1851b30c-20200415
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 642352115; Wed, 15 Apr 2020 09:13:24 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 15 Apr
 2020 09:13:22 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 15 Apr 2020 09:13:21 +0800
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
Subject: [PATCH v15 1/3] dt-bindings: display: mediatek: control dpi pins mode to avoid leakage
Date:   Wed, 15 Apr 2020 09:13:17 +0800
Message-ID: <20200415011319.25559-2-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.12.5
In-Reply-To: <20200415011319.25559-1-jitao.shi@mediatek.com>
References: <20200415011319.25559-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 9899C9B523F3F3B15CB65ED031246E6D74C76EFC8F4B91273DA2E99FED1ABD0D2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHByb3BlcnR5ICJwaW5jdHJsLW5hbWVzIiB0byBzd2FwIHBpbiBtb2RlIGJldHdlZW4gZ3Bp
byBhbmQgZHBpIG1vZGUuIFNldA0KdGhlIGRwaSBwaW5zIHRvIGdwaW8gbW9kZSBhbmQgb3V0cHV0
LWxvdyB0byBhdm9pZCBsZWFrYWdlIGN1cnJlbnQgd2hlbiBkcGkNCmRpc2FibGVkLg0KDQpBY2tl
ZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NClJldmlld2VkLWJ5OiBDaHVuLUt1
YW5nIEh1IDxjaHVua3VhbmcuaHVAa2VybmVsLm9yZz4NClNpZ25lZC1vZmYtYnk6IEppdGFvIFNo
aSA8aml0YW8uc2hpQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRwaS50eHQgfCA2ICsrKysrKw0K
IDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRwaS50
eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9t
ZWRpYXRlayxkcGkudHh0DQppbmRleCA1ODkxNGNmNjgxYjguLjc3ZGVmNDQ1NjcwNiAxMDA2NDQN
Ci0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVr
L21lZGlhdGVrLGRwaS50eHQNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRwaS50eHQNCkBAIC0xNyw2ICsxNyw5IEBAIFJl
cXVpcmVkIHByb3BlcnRpZXM6DQogICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
Z3JhcGgudHh0LiBUaGlzIHBvcnQgc2hvdWxkIGJlIGNvbm5lY3RlZA0KICAgdG8gdGhlIGlucHV0
IHBvcnQgb2YgYW4gYXR0YWNoZWQgSERNSSBvciBMVkRTIGVuY29kZXIgY2hpcC4NCiANCitPcHRp
b25hbCBwcm9wZXJ0aWVzOg0KKy0gcGluY3RybC1uYW1lczogQ29udGFpbiAiZGVmYXVsdCIgYW5k
ICJzbGVlcCIuDQorDQogRXhhbXBsZToNCiANCiBkcGkwOiBkcGlAMTQwMWQwMDAgew0KQEAgLTI3
LDYgKzMwLDkgQEAgZHBpMDogZHBpQDE0MDFkMDAwIHsNCiAJCSA8Jm1tc3lzIENMS19NTV9EUElf
RU5HSU5FPiwNCiAJCSA8JmFwbWl4ZWRzeXMgQ0xLX0FQTUlYRURfVFZEUExMPjsNCiAJY2xvY2st
bmFtZXMgPSAicGl4ZWwiLCAiZW5naW5lIiwgInBsbCI7DQorCXBpbmN0cmwtbmFtZXMgPSAiZGVm
YXVsdCIsICJzbGVlcCI7DQorCXBpbmN0cmwtMCA9IDwmZHBpX3Bpbl9mdW5jPjsNCisJcGluY3Ry
bC0xID0gPCZkcGlfcGluX2lkbGU+Ow0KIA0KIAlwb3J0IHsNCiAJCWRwaTBfb3V0OiBlbmRwb2lu
dCB7DQotLSANCjIuMTIuNQ0K

