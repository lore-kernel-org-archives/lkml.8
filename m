Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB878C43463
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 03:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98A9C207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 03:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="shMPoiy9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387874AbgGWDGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 23:06:52 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:27553 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387844AbgGWDGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 23:06:45 -0400
X-UUID: 8b4354a3001d4126a3a128c136f3bf28-20200723
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=+qGpUoiGKZLF+nB5b8VhVUABEj5+eZ7x/jkHixmWgAw=;
        b=shMPoiy9m3Al9dITMNPa8xPwuxhpDyytvXtba1diyUR9+KrRp0O30KU841NnxBKyVi2L221Gh//QZZtm/EvZ6OQuLSOeVkZ3Gin7mIDpTv9vnh5vBL9tks3QrvLI/JXYxLnWFpFrac/E+GiNZA7S/UXBlGFdABg3qbcfzzc8Vzs=;
X-UUID: 8b4354a3001d4126a3a128c136f3bf28-20200723
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <xia.jiang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1840404565; Thu, 23 Jul 2020 11:06:41 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Jul 2020 11:06:39 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 23 Jul 2020 11:06:35 +0800
From:   Xia Jiang <xia.jiang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rick Chang <rick.chang@mediatek.com>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomasz Figa <tfiga@chromium.org>,
        <srv_heupstream@mediatek.com>, <senozhatsky@chromium.org>,
        <mojahsu@chromium.org>, <drinkcat@chromium.org>,
        <maoguang.meng@mediatek.com>, Xia Jiang <xia.jiang@mediatek.com>
Subject: [PATCH v10 24/28] arm: dts: mt2701: Add jpeg enc device tree node
Date:   Thu, 23 Jul 2020 11:04:47 +0800
Message-ID: <20200723030451.5616-25-xia.jiang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200723030451.5616-1-xia.jiang@mediatek.com>
References: <20200723030451.5616-1-xia.jiang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGpwZWcgZW5jIGRldmljZSB0cmVlIG5vZGUuDQoNClNpZ25lZC1vZmYtYnk6IFhpYSBKaWFu
ZyA8eGlhLmppYW5nQG1lZGlhdGVrLmNvbT4NCi0tLQ0KdjEwOiBubyBjaGFuZ2VzDQotLS0NCiBh
cmNoL2FybS9ib290L2R0cy9tdDI3MDEuZHRzaSB8IDEzICsrKysrKysrKysrKysNCiAxIGZpbGUg
Y2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9k
dHMvbXQyNzAxLmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9tdDI3MDEuZHRzaQ0KaW5kZXggOGQ0
M2E1MDJhYWRhLi4xYzFjMjEzMjIzNGYgMTAwNjQ0DQotLS0gYS9hcmNoL2FybS9ib290L2R0cy9t
dDI3MDEuZHRzaQ0KKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvbXQyNzAxLmR0c2kNCkBAIC01Njgs
NiArNTY4LDE5IEBADQogCQkJIDwmaW9tbXUgTVQyNzAxX000VV9QT1JUX0pQR0RFQ19CU0RNQT47
DQogCX07DQogDQorCWpwZWdlbmM6IGpwZWdlbmNAMTUwMGEwMDAgew0KKwkJY29tcGF0aWJsZSA9
ICJtZWRpYXRlayxtdDI3MDEtanBnZW5jIiwNCisJCQkgICAgICJtZWRpYXRlayxtdGstanBnZW5j
IjsNCisJCXJlZyA9IDwwIDB4MTUwMGEwMDAgMCAweDEwMDA+Ow0KKwkJaW50ZXJydXB0cyA9IDxH
SUNfU1BJIDE0MSBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0KKwkJY2xvY2tzID0gIDwmaW1nc3lzIENM
S19JTUdfVkVOQz47DQorCQljbG9jay1uYW1lcyA9ICJqcGdlbmMiOw0KKwkJcG93ZXItZG9tYWlu
cyA9IDwmc2Nwc3lzIE1UMjcwMV9QT1dFUl9ET01BSU5fSVNQPjsNCisJCW1lZGlhdGVrLGxhcmIg
PSA8JmxhcmIyPjsNCisJCWlvbW11cyA9IDwmaW9tbXUgTVQyNzAxX000VV9QT1JUX0pQR0VOQ19S
RE1BPiwNCisJCQkgPCZpb21tdSBNVDI3MDFfTTRVX1BPUlRfSlBHRU5DX0JTRE1BPjsNCisJfTsN
CisNCiAJdmRlY3N5czogc3lzY29uQDE2MDAwMDAwIHsNCiAJCWNvbXBhdGlibGUgPSAibWVkaWF0
ZWssbXQyNzAxLXZkZWNzeXMiLCAic3lzY29uIjsNCiAJCXJlZyA9IDwwIDB4MTYwMDAwMDAgMCAw
eDEwMDA+Ow0KLS0gDQoyLjE4LjANCg==

