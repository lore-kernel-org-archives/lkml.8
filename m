Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F69C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D45EA20709
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Fe4lJFqC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgEOKFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 06:05:35 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:25915 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728228AbgEOKFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 06:05:34 -0400
X-UUID: 7088b99243a04af7a18c84445ff11d5e-20200515
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=RQIWCw9E0EL8sgOkrQ+WbYahSgYK4T6So5anNQWya9U=;
        b=Fe4lJFqClzO20Ko9TjlAERETtS112zMCSZdhfrMU2xDSalmj6/yg4dpn80UlfdfrVAdJwmh2ciNLXqnhYyIbZFiVuHwH5PuR6CZBmE10Gq6l2fYjgk16aL3QEDKc9qcZTfhAsC9riEuDViyLL+WcwUq4fmVPj6oY4kvNQJu2JjE=;
X-UUID: 7088b99243a04af7a18c84445ff11d5e-20200515
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1026002086; Fri, 15 May 2020 18:05:31 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 15 May 2020 18:05:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 15 May 2020 18:05:26 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, <dm-devel@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>
Subject: [PATCH] dm: replace strncpy() with strscpy()
Date:   Fri, 15 May 2020 18:05:28 +0800
Message-ID: <20200515100528.14341-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 704E7B1D95B5A2015993205326258A150957E452D2B16B36C86F62849D97192C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmVwbGFjZSBzdHJuY3B5KCkgd2l0aCBzdHJzY3B5KCkgdG8gZ3VhcmFudGVlIGEgTlVMTC10ZXJt
aW5hdGVkDQpzdHJpbmcuDQoNCkRldGVjdGVkIGJ5IENvdmVyaXR5Lg0KDQpTaWduZWQtb2ZmLWJ5
OiBNaWxlcyBDaGVuIDxtaWxlcy5jaGVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvbWQv
ZG0taW9jdGwuYyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWQvZG0taW9jdGwuYyBiL2RyaXZlcnMv
bWQvZG0taW9jdGwuYw0KaW5kZXggYWM4M2Y1MDAyY2U1Li40ZGMzNjU4ZTMzNTEgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL21kL2RtLWlvY3RsLmMNCisrKyBiL2RyaXZlcnMvbWQvZG0taW9jdGwuYw0K
QEAgLTExNjcsNyArMTE2Nyw3IEBAIHN0YXRpYyB2b2lkIHJldHJpZXZlX3N0YXR1cyhzdHJ1Y3Qg
ZG1fdGFibGUgKnRhYmxlLA0KIAkJc3BlYy0+c3RhdHVzID0gMDsNCiAJCXNwZWMtPnNlY3Rvcl9z
dGFydCA9IHRpLT5iZWdpbjsNCiAJCXNwZWMtPmxlbmd0aCA9IHRpLT5sZW47DQotCQlzdHJuY3B5
KHNwZWMtPnRhcmdldF90eXBlLCB0aS0+dHlwZS0+bmFtZSwNCisJCXN0cnNjcHkoc3BlYy0+dGFy
Z2V0X3R5cGUsIHRpLT50eXBlLT5uYW1lLA0KIAkJCXNpemVvZihzcGVjLT50YXJnZXRfdHlwZSkp
Ow0KIA0KIAkJb3V0cHRyICs9IHNpemVvZihzdHJ1Y3QgZG1fdGFyZ2V0X3NwZWMpOw0KLS0gDQoy
LjE4LjANCg==

