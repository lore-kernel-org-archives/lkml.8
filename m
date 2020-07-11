Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5B6C433F1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 06:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E80A20720
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 06:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="VxaDBwba"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbgGKGvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 02:51:55 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:36034 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727984AbgGKGvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 02:51:52 -0400
X-UUID: 9f2f9c82384d48eab65d0cdff7e8ed94-20200711
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=X9X6VUl15O0QLqjDskaPZDckZoa2Ua3bbD5IeU7Lw9k=;
        b=VxaDBwba6ry0rLEPWGVCgBQs2hX5YWuU/zE8PZeTbd20IU/9Fe+noVHlRdwYLbeXwZdzi85fdUWF7Qy41CPBleUkwM6dSPk3mYZyfSnkHkCk3is5xSOjUYNy0/j4L8/Ni5VYXgycm2yNAZRzujgh/6CKQldHSMRbXuzGEswPcYc=;
X-UUID: 9f2f9c82384d48eab65d0cdff7e8ed94-20200711
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 264599427; Sat, 11 Jul 2020 14:51:48 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 11 Jul 2020 14:51:45 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Jul 2020 14:51:44 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Will Deacon <will@kernel.org>, Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <cui.zhang@mediatek.com>,
        <chao.hao@mediatek.com>, <ming-fan.chen@mediatek.com>
Subject: [PATCH 13/21] iommu/mediatek: Make MTK_IOMMU depend on ARM64
Date:   Sat, 11 Jul 2020 14:48:38 +0800
Message-ID: <20200711064846.16007-14-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200711064846.16007-1-yong.wu@mediatek.com>
References: <20200711064846.16007-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: DC67469FEF3469DEA3B505AC9A9CDD09FA042BA3EF01BF46EF49FD74EEF01B462000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T3JpZ2luYWxseSBNVEtfSU9NTVUgY291bGQgZGVwZW5kIG9uIEFSTSB8fCBBUk02NC4NCkJvdGgg
YnVpbGQgb2suIGFjdHVhbGx5IHRoZSBzb3VyY2UgY29kZSBkb24ndCBzdXBwb3J0IEFSTS4NCnRo
aXMgcGF0Y2ggY2hhbmdlcyBpdCBvbmx5IGRlcGVuZCBvbiBBUk02NC4NCg0KVGhpcyBpcyBhIHBy
ZXBhcmluZyBwYXRjaCBmb3Igc3VwcG9ydCBtdWx0aS1kb21haW4uDQpvdGhlcndpc2UgaXQgd2ls
bCBidWlsZCB3YXJuaW5nIGluIEFSTSBjYXNlLg0KDQpUaGlzIGlzIHRoZSBidWlsZCB3YXJuaW5n
IGxvZzoNCg0KZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYzoxNjM6Mjc6IG5vdGU6IGluIGV4cGFu
c2lvbiBvZiBtYWNybyAnU1pfNEcnDQogIHsuaW92YV9iYXNlID0gMCwgLnNpemUgPSBTWl80R30s
DQppbmNsdWRlL3VhcGkvbGludXgvY29uc3QuaDoyMDoxOTogd2FybmluZzogbGFyZ2UgaW50ZWdl
ciBpbXBsaWNpdGx5IHRydW5jYXRlZA0KdG8gdW5zaWduZWQgdHlwZSBbLVdvdmVyZmxvd10NCiAj
ZGVmaW5lIF9fQUMoWCxZKSAoWCMjWSkNCiAgICAgICAgICAgICAgICAgICBeDQppbmNsdWRlL3Vh
cGkvbGludXgvY29uc3QuaDoyMToxODogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvICdfX0FD
Jw0KICNkZWZpbmUgX0FDKFgsWSkgX19BQyhYLFkpDQogICAgICAgICAgICAgICAgICBeDQppbmNs
dWRlL2xpbnV4L3NpemVzLmg6NDY6MTg6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyAnX0FD
Jw0KICNkZWZpbmUgU1pfNEcgICAgX0FDKDB4MTAwMDAwMDAwLCBVTEwpDQoNClNpZ25lZC1vZmYt
Ynk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9pb21tdS9L
Y29uZmlnIHwgMSArDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQoNCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2lvbW11L0tjb25maWcgYi9kcml2ZXJzL2lvbW11L0tjb25maWcNCmluZGV4
IGI1MTBmNjdkZmE0OS4uNmJlYmZkM2UwMDIxIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pb21tdS9L
Y29uZmlnDQorKysgYi9kcml2ZXJzL2lvbW11L0tjb25maWcNCkBAIC00NjcsNiArNDY3LDcgQEAg
Y29uZmlnIFMzOTBfQVBfSU9NTVUNCiBjb25maWcgTVRLX0lPTU1VDQogCWJvb2wgIk1USyBJT01N
VSBTdXBwb3J0Ig0KIAlkZXBlbmRzIG9uIEhBU19ETUENCisJZGVwZW5kcyBvbiBBUk02NA0KIAlk
ZXBlbmRzIG9uIEFSQ0hfTUVESUFURUsgfHwgQ09NUElMRV9URVNUDQogCXNlbGVjdCBBUk1fRE1B
X1VTRV9JT01NVQ0KIAlzZWxlY3QgSU9NTVVfQVBJDQotLSANCjIuMTguMA0K

