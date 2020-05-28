Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DD1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E0E9207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="eE3eoVa+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405511AbgE1RHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 13:07:01 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:54841 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2405370AbgE1RFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 13:05:21 -0400
X-UUID: 21cd28bc08e94f828604d341d1fd8597-20200529
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=rIPq/TQMxIdoMnoMPlQi3c8FcKYOGsapwaO1S3xYcgE=;
        b=eE3eoVa+AN3mHaklgWmRtF/l4eieYvHCflSeNJQEj2GTpacZiPTFJApTqaJB9lvNSjhg/woAssfA5SbCvOCDV1cJlX6qEOzC5B380NS+OInt6VomLnsSFjLu2/4EqVSO2bUDPXL7hJ0GWLpLh9+rl5EQckeNX+hRPs4R/saXyqE=;
X-UUID: 21cd28bc08e94f828604d341d1fd8597-20200529
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 549696073; Fri, 29 May 2020 01:05:11 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 29 May 2020 01:05:08 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 29 May 2020 01:05:07 +0800
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
Subject: [PATCH v6 03/16] mailbox: cmdq: support mt6779 gce platform definition
Date:   Fri, 29 May 2020 01:04:39 +0800
Message-ID: <1590685491-17107-5-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1590685491-17107-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1590685491-17107-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGdjZSB2NCBoYXJkd2FyZSBzdXBwb3J0IHdpdGggZGlmZmVyZW50IHRocmVhZCBudW1iZXIg
YW5kIHNoaWZ0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgWUMgSHNpZWggPGRlbm5pcy15Yy5o
c2llaEBtZWRpYXRlay5jb20+DQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNv
bT4NClJldmlld2VkLWJ5OiBNYXR0aGlhcyBCcnVnZ2VyIDxtYXR0aGlhcy5iZ2dAZ21haWwuY29t
Pg0KLS0tDQogZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYyB8IDIgKysNCiAxIGZp
bGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL21haWxi
b3gvbXRrLWNtZHEtbWFpbGJveC5jIGIvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3gu
Yw0KaW5kZXggNGRiZWU5MjU4MTI3Li45OTk0YWM5NDI2ZDYgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQorKysgYi9kcml2ZXJzL21haWxib3gvbXRrLWNt
ZHEtbWFpbGJveC5jDQpAQCAtNTcyLDEwICs1NzIsMTIgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBk
ZXZfcG1fb3BzIGNtZHFfcG1fb3BzID0gew0KIA0KIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZ2NlX3Bs
YXQgZ2NlX3BsYXRfdjIgPSB7LnRocmVhZF9uciA9IDE2fTsNCiBzdGF0aWMgY29uc3Qgc3RydWN0
IGdjZV9wbGF0IGdjZV9wbGF0X3YzID0gey50aHJlYWRfbnIgPSAyNH07DQorc3RhdGljIGNvbnN0
IHN0cnVjdCBnY2VfcGxhdCBnY2VfcGxhdF92NCA9IHsudGhyZWFkX25yID0gMjQsIC5zaGlmdCA9
IDN9Ow0KIA0KIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGNtZHFfb2ZfaWRzW10g
PSB7DQogCXsuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxNzMtZ2NlIiwgLmRhdGEgPSAodm9p
ZCAqKSZnY2VfcGxhdF92Mn0sDQogCXsuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtZ2Nl
IiwgLmRhdGEgPSAodm9pZCAqKSZnY2VfcGxhdF92M30sDQorCXsuY29tcGF0aWJsZSA9ICJtZWRp
YXRlayxtdDY3NzktZ2NlIiwgLmRhdGEgPSAodm9pZCAqKSZnY2VfcGxhdF92NH0sDQogCXt9DQog
fTsNCiANCi0tIA0KMi4xOC4wDQo=

