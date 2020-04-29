Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B882C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 08:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3975206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 08:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CIaWL4vQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgD2IW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 04:22:57 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:27468 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726430AbgD2IW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 04:22:56 -0400
X-UUID: 31ddaf0115284431b141fdb40d541229-20200429
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=fyGie+/OjAbHlI/7XZtnPpamWLLZ9oCp6eKZxelllDc=;
        b=CIaWL4vQ2I1iGf+SfB24qJVU6Xuq1jnlcLtKx092g/WgLUZUKlBX6s6JZEU9veRAZWsv019zLf1sUbmHWCuAS+VuCrM+TmQ2gqE1fL/kOv2coptbrLokEhYlqxx9wmTkZEYqrrbaCkC/DnBGzZnXQ1cswk1jGN4D8zwXJYddfuM=;
X-UUID: 31ddaf0115284431b141fdb40d541229-20200429
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <xing.zhang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 610312970; Wed, 29 Apr 2020 16:22:42 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS32DR.mediatek.inc (172.27.6.104) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 29 Apr 2020 16:22:41 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 29 Apr 2020 16:22:39 +0800
From:   Xing Zhang <Xing.Zhang@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        Xing Zhang <xing.zhang@mediatek.com>
Subject: [PATCH v1 2/3] arm64: mediatek: Add regulator vibrator support
Date:   Wed, 29 Apr 2020 16:18:01 +0800
Message-ID: <20200429081759.26964-3-Xing.Zhang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200429081759.26964-1-Xing.Zhang@mediatek.com>
References: <20200429081759.26964-1-Xing.Zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 38C62FF845592F563F9EA9D9E592780B9FBC921BD881E32504B772285F81C5B72000:8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogWGluZyBaaGFuZyA8eGluZy56aGFuZ0BtZWRpYXRlay5jb20+DQoNCkFkZCBDT05GSUdf
TEVEU19SRUdVTEFUT1JfVklCUkFUT1I9eSBpbiBkZWZjb25maWcNCg0KU2lnbmVkLW9mZi1ieTog
WGluZyBaaGFuZyA8eGluZy56aGFuZ0BtZWRpYXRlay5jb20+DQotLS0NCiBhcmNoL2FybTY0L2Nv
bmZpZ3MvZGVmY29uZmlnIHwgMSArDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQoN
CmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnIGIvYXJjaC9hcm02NC9j
b25maWdzL2RlZmNvbmZpZw0KaW5kZXggMjRlNTM0ZDg1MDQ1Li4yOTI4N2U1MjViNDYgMTAwNjQ0
DQotLS0gYS9hcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnDQorKysgYi9hcmNoL2FybTY0L2Nv
bmZpZ3MvZGVmY29uZmlnDQpAQCAtNzIzLDYgKzcyMyw3IEBAIENPTkZJR19MRURTX0NMQVNTPXkN
CiBDT05GSUdfTEVEU19HUElPPXkNCiBDT05GSUdfTEVEU19QV009eQ0KIENPTkZJR19MRURTX1NZ
U0NPTj15DQorQ09ORklHX0xFRFNfUkVHVUxBVE9SX1ZJQlJBVE9SPXkNCiBDT05GSUdfTEVEU19U
UklHR0VSX0RJU0s9eQ0KIENPTkZJR19MRURTX1RSSUdHRVJfSEVBUlRCRUFUPXkNCiBDT05GSUdf
TEVEU19UUklHR0VSX0NQVT15DQotLSANCjIuMTguMA0K

