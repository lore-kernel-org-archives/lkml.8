Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA90C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 10:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9709A20838
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 10:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hR3zl9d1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgCHKxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 06:53:22 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:20447 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726336AbgCHKxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 06:53:15 -0400
X-UUID: 6d853efe04c9441198c4075b06576b7a-20200308
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=pe1RjNwVh3cpWJgfVmTBNSS/ftJHIqyrJTiVenXPQC0=;
        b=hR3zl9d169NvKIw7e9Q0eYf8ZfaBO5zCdUsqLuno4LNhvi95V7vob95figr470GLKVvvF9GTR3DnnvJ7o1Gqk3jj27KYSbe+mu/h4jjJURQE/LuhV1hWD8KKkvUpwrtogUIkvtksgM/vhGVqNPTo1w0trGMXr9HDO+r42V5yi34=;
X-UUID: 6d853efe04c9441198c4075b06576b7a-20200308
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1989260626; Sun, 08 Mar 2020 18:53:06 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 8 Mar 2020 18:51:40 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 8 Mar 2020 18:52:58 +0800
From:   Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <dri-devel@lists.freedesktop.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        HS Liao <hs.liao@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Subject: [PATCH v5 03/13] mailbox: cmdq: support mt6779 gce platform definition
Date:   Sun, 8 Mar 2020 18:52:45 +0800
Message-ID: <1583664775-19382-4-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1583664775-19382-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1583664775-19382-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 72CC23C5DDCF1EFAC333C9E350B80303941A194F22E3062F365A62E1BA448CBB2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGdjZSB2NCBoYXJkd2FyZSBzdXBwb3J0IHdpdGggZGlmZmVyZW50IHRocmVhZCBudW1iZXIg
YW5kIHNoaWZ0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgWUMgSHNpZWggPGRlbm5pcy15Yy5o
c2llaEBtZWRpYXRlay5jb20+DQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNv
bT4NCi0tLQ0KIGRyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMgfCAyICsrDQogMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tYWls
Ym94L210ay1jbWRxLW1haWxib3guYyBiL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94
LmMNCmluZGV4IDRkYmVlOTI1ODEyNy4uOTk5NGFjOTQyNmQ2IDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0KKysrIGIvZHJpdmVycy9tYWlsYm94L210ay1j
bWRxLW1haWxib3guYw0KQEAgLTU3MiwxMCArNTcyLDEyIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
ZGV2X3BtX29wcyBjbWRxX3BtX29wcyA9IHsNCiANCiBzdGF0aWMgY29uc3Qgc3RydWN0IGdjZV9w
bGF0IGdjZV9wbGF0X3YyID0gey50aHJlYWRfbnIgPSAxNn07DQogc3RhdGljIGNvbnN0IHN0cnVj
dCBnY2VfcGxhdCBnY2VfcGxhdF92MyA9IHsudGhyZWFkX25yID0gMjR9Ow0KK3N0YXRpYyBjb25z
dCBzdHJ1Y3QgZ2NlX3BsYXQgZ2NlX3BsYXRfdjQgPSB7LnRocmVhZF9uciA9IDI0LCAuc2hpZnQg
PSAzfTsNCiANCiBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBjbWRxX29mX2lkc1td
ID0gew0KIAl7LmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTczLWdjZSIsIC5kYXRhID0gKHZv
aWQgKikmZ2NlX3BsYXRfdjJ9LA0KIAl7LmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTgzLWdj
ZSIsIC5kYXRhID0gKHZvaWQgKikmZ2NlX3BsYXRfdjN9LA0KKwl7LmNvbXBhdGlibGUgPSAibWVk
aWF0ZWssbXQ2Nzc5LWdjZSIsIC5kYXRhID0gKHZvaWQgKikmZ2NlX3BsYXRfdjR9LA0KIAl7fQ0K
IH07DQogDQotLSANCjIuMTguMA0K

