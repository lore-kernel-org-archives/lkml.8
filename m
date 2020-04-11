Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E8DC2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 07:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E556920732
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 07:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="aTWcMRDE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgDKHoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 03:44:39 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:18933 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725869AbgDKHoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 03:44:38 -0400
X-UUID: 8012daefe6f54475897fea8dd23fac51-20200411
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=iR0rPL64FU19qOW727A31bTZVI8PeoEj1NeCit81CAU=;
        b=aTWcMRDEIRZna0iyeIExAWCtVXvaqrohBn2YLIQy9YhruxZfuaDIEJs7odWP189P9Q0OhoaVMdkkQts4XM+HrdotIN4GTw+xF9I6/kP78IbHesNjejx4aQoYauPHKNF53IZEmCDaoUsPOM1e5RkbQqNvvgKDOcdAgEC8Zui1Sls=;
X-UUID: 8012daefe6f54475897fea8dd23fac51-20200411
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 882147795; Sat, 11 Apr 2020 15:44:29 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 11 Apr
 2020 15:44:26 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Sat, 11 Apr 2020 15:44:24 +0800
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
        Jitao Shi <jitao.shi@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 2/4] dt-bindings: display: mediatek: get mipitx calibration data from nvmem
Date:   Sat, 11 Apr 2020 15:44:06 +0800
Message-ID: <20200411074408.38090-3-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200411074408.38090-1-jitao.shi@mediatek.com>
References: <20200411074408.38090-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 3F5C87B68CD97C73DA1F90AAF118FD8FA8B79DD9371F8F179B5BB437835841A32000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHByb3BlcnRpZXMgdG8gZ2V0IGdldCBtaXBpdHggY2FsaWJyYXRpb24gZGF0YS4NCg0KUmV2
aWV3ZWQtYnk6IENodW4tS3VhbmcgSHUgPGNodW5rdWFuZy5odUBrZXJuZWwub3JnPg0KUmV2aWV3
ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQpTaWduZWQtb2ZmLWJ5OiBKaXRh
byBTaGkgPGppdGFvLnNoaUBtZWRpYXRlay5jb20+DQotLS0NCiAuLi4vZGV2aWNldHJlZS9iaW5k
aW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRzaS50eHQgICAgfCA1ICsrKysrDQogMSBm
aWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHNpLnR4dCBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlh
dGVrLGRzaS50eHQNCmluZGV4IGQ3OGI2ZDZkOGZhYi4uOGU0NzI5ZGU4Yzg1IDEwMDY0NA0KLS0t
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVk
aWF0ZWssZHNpLnR4dA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rp
c3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHNpLnR4dA0KQEAgLTM2LDYgKzM2LDkgQEAgUmVxdWly
ZWQgcHJvcGVydGllczoNCiBPcHRpb25hbCBwcm9wZXJ0aWVzOg0KIC0gZHJpdmUtc3RyZW5ndGgt
bWljcm9hbXA6IGFkanVzdCBkcml2aW5nIGN1cnJlbnQsIHNob3VsZCBiZSAzMDAwIH4gNjAwMC4g
QW5kDQogCQkJCQkJICAgdGhlIHN0ZXAgaXMgMjAwLg0KKy0gbnZtZW0tY2VsbHM6IEEgcGhhbmRs
ZSB0byB0aGUgY2FsaWJyYXRpb24gZGF0YSBwcm92aWRlZCBieSBhIG52bWVtIGRldmljZS4gSWYN
CisgICAgICAgICAgICAgICB1bnNwZWNpZmllZCBkZWZhdWx0IHZhbHVlcyBzaGFsbCBiZSB1c2Vk
Lg0KKy0gbnZtZW0tY2VsbC1uYW1lczogU2hvdWxkIGJlICJjYWxpYnJhdGlvbi1kYXRhIg0KIA0K
IEV4YW1wbGU6DQogDQpAQCAtNDcsNiArNTAsOCBAQCBtaXBpX3R4MDogbWlwaS1kcGh5QDEwMjE1
MDAwIHsNCiAJI2Nsb2NrLWNlbGxzID0gPDA+Ow0KIAkjcGh5LWNlbGxzID0gPDA+Ow0KIAlkcml2
ZS1zdHJlbmd0aC1taWNyb2FtcCA9IDw0NjAwPjsNCisJbnZtZW0tY2VsbHM9IDwmbWlwaV90eF9j
YWxpYnJhdGlvbj47DQorCW52bWVtLWNlbGwtbmFtZXMgPSAiY2FsaWJyYXRpb24tZGF0YSI7DQog
fTsNCiANCiBkc2kwOiBkc2lAMTQwMWIwMDAgew0KLS0gDQoyLjIxLjANCg==

