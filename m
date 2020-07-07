Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16662C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E91072065D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Sp9Nq6UA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbgGGPqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:46:55 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:59707 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729055AbgGGPqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:46:36 -0400
X-UUID: f83b2b00b9224e82a090c1aa6d2915d5-20200707
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=0QW/Y65kX+qJtvLrwd+2vrHj2NORCkDYnjrB6/h++Kg=;
        b=Sp9Nq6UA7eV4sD8Gdu6UF/IOYWebhYc/zuXbAqLz6RJKi7JL2KtkD8tom2TB0CcFU4aQyq47/LYqDvtqFhsxWVd8pcM2dCfjrmhXm2IT9hL09mxBye8EXdTbXXd6U15f0pf4Gl/9o2xBnomGPZhDbRMGiaB+d3lqbHL3HRRCSC0=;
X-UUID: f83b2b00b9224e82a090c1aa6d2915d5-20200707
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 15148973; Tue, 07 Jul 2020 23:46:29 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 7 Jul 2020 23:46:24 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 7 Jul 2020 23:46:25 +0800
From:   Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        HS Liao <hs.liao@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Subject: [PATCH v3 9/9] drm/mediatek: reduce clear event
Date:   Tue, 7 Jul 2020 23:45:14 +0800
Message-ID: <1594136714-11650-10-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1594136714-11650-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1594136714-11650-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tm8gbmVlZCB0byBjbGVhciBldmVudCBhZ2FpbiBzaW5jZSBldmVudCBhbHdheXMgY2xlYXIgYmVm
b3JlIHdhaXQuDQpUaGlzIGZpeCBkZXBlbmQgb24gcGF0Y2g6DQogICJzb2M6IG1lZGlhdGVrOiBj
bWRxOiBhZGQgY2xlYXIgb3B0aW9uIGluIGNtZHFfcGt0X3dmZSBhcGkiDQoNCkZpeGVzOiAyZjk2
NWJlN2Y5MDA4ICgiZHJtL21lZGlhdGVrOiBhcHBseSBDTURRIGNvbnRyb2wgZmxvdyIpDQpTaWdu
ZWQtb2ZmLWJ5OiBEZW5uaXMgWUMgSHNpZWggPGRlbm5pcy15Yy5oc2llaEBtZWRpYXRlay5jb20+
DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMgfCAgICAyICst
DQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMgYi9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCmluZGV4IGM4NGU3YTE0ZDRhOC4uYmE2
Y2Y5NTZiMjM5IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
Y3J0Yy5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCkBA
IC00OTAsNyArNDkwLDcgQEAgc3RhdGljIHZvaWQgbXRrX2RybV9jcnRjX2h3X2NvbmZpZyhzdHJ1
Y3QgbXRrX2RybV9jcnRjICptdGtfY3J0YykNCiAJCW1ib3hfZmx1c2gobXRrX2NydGMtPmNtZHFf
Y2xpZW50LT5jaGFuLCAyMDAwKTsNCiAJCWNtZHFfaGFuZGxlID0gY21kcV9wa3RfY3JlYXRlKG10
a19jcnRjLT5jbWRxX2NsaWVudCwgUEFHRV9TSVpFKTsNCiAJCWNtZHFfcGt0X2NsZWFyX2V2ZW50
KGNtZHFfaGFuZGxlLCBtdGtfY3J0Yy0+Y21kcV9ldmVudCk7DQotCQljbWRxX3BrdF93ZmUoY21k
cV9oYW5kbGUsIG10a19jcnRjLT5jbWRxX2V2ZW50LCB0cnVlKTsNCisJCWNtZHFfcGt0X3dmZShj
bWRxX2hhbmRsZSwgbXRrX2NydGMtPmNtZHFfZXZlbnQsIGZhbHNlKTsNCiAJCW10a19jcnRjX2Rk
cF9jb25maWcoY3J0YywgY21kcV9oYW5kbGUpOw0KIAkJY21kcV9wa3RfZmluYWxpemUoY21kcV9o
YW5kbGUpOw0KIAkJY21kcV9wa3RfZmx1c2hfYXN5bmMoY21kcV9oYW5kbGUsIGRkcF9jbWRxX2Ni
LCBjbWRxX2hhbmRsZSk7DQotLSANCjEuNy45LjUNCg==

