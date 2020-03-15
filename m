Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01E8C4CECE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 15:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79CA420663
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 15:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OFxgpzsL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbgCOPIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 11:08:18 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:62992 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728223AbgCOPIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 11:08:18 -0400
X-UUID: 76f36b23b4154017ba3abadc0af0d807-20200315
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=+CvUngamV2VX3eNG/af1GoftRg2IFOk1is4zBfIJFy0=;
        b=OFxgpzsLsAqSkkntwnUnK5cn2Dm+E94AGIngfCe1rhb/jsDWDFJLJSUIuWCABYlx0Xv9w9GugAcghFBuClwhXGV1GIN4WYtPlWYKNMBx/UTTwGc2URnwGeN7uVbc4+rwzA7hreuLC2/FnnoAoWHlYwle7QuNe9T69/IKRjkS9Ck=;
X-UUID: 76f36b23b4154017ba3abadc0af0d807-20200315
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <hanks.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 564303256; Sun, 15 Mar 2020 23:08:09 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 15 Mar 2020 23:07:33 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 15 Mar 2020 23:07:31 +0800
From:   Hanks Chen <hanks.chen@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, Hanks Chen <hanks.chen@mediatek.com>
Subject: [PATCH 1/1] dt-bindings: cpu: Add a support cpu type for cortex-a75
Date:   Sun, 15 Mar 2020 23:08:05 +0800
Message-ID: <1584284885-20836-1-git-send-email-hanks.chen@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 860C1638F459CC376E4B34BE0F369F4CB84B24E6D4543CE68454EA5693FFD5262000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0RldGFpbF0NCkFkZCBhcm0gY3B1IHR5cGUgY29ydGV4LWE3NS4NCg0KQ2hhbmdlLUlkOiBJMmIw
NTk0ODkxNWFjZmE2YTA0YTBiOGZhODg2ODRhMTJiNmQ1YzJjYQ0KU2lnbmVkLW9mZi1ieTogSGFu
a3MgQ2hlbiA8aGFua3MuY2hlbkBtZWRpYXRlay5jb20+DQotLS0NCiBEb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvYXJtL2NwdXMueWFtbCB8ICAgIDEgKw0KIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2FybS9jcHVzLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvYXJtL2NwdXMueWFtbA0KaW5kZXggYzIzYzI0Zi4uNTFiNzVmNyAxMDA2NDQNCi0tLSBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vY3B1cy55YW1sDQorKysgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2NwdXMueWFtbA0KQEAgLTEyOCw2ICsx
MjgsNyBAQCBwcm9wZXJ0aWVzOg0KICAgICAgIC0gYXJtLGNvcnRleC1hNTcNCiAgICAgICAtIGFy
bSxjb3J0ZXgtYTcyDQogICAgICAgLSBhcm0sY29ydGV4LWE3Mw0KKyAgICAgIC0gYXJtLGNvcnRl
eC1hNzUNCiAgICAgICAtIGFybSxjb3J0ZXgtbTANCiAgICAgICAtIGFybSxjb3J0ZXgtbTArDQog
ICAgICAgLSBhcm0sY29ydGV4LW0xDQotLSANCjEuNy45LjUNCg==

