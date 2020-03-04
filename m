Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CFCC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7972166E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MSAPAEiK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387920AbgCDLGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 06:06:22 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:19938 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387871AbgCDLGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 06:06:22 -0500
X-UUID: ff6718c8643e4bd1ad392ce35c9c04b3-20200304
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=nhDnAMp3JyFWVGxZ+DNYbbAhHqqAmkOtX8S24odlEGU=;
        b=MSAPAEiKErVIpUtxYI2GKOq1x0IwTNphq3vX8IEU9MP67CK1gi2E+J/jQwyt9hZTph2ZGjdrtTXjqfwacGlwRiGVltzokZAejPb6G2z9FvzBaBxO5PK4y9xcLdwHF1H2E5B7QcuzUcKfrqimXTrVyZpXFAljJmZLysddMkLnz1Q=;
X-UUID: ff6718c8643e4bd1ad392ce35c9c04b3-20200304
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 756947947; Wed, 04 Mar 2020 19:06:18 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 4 Mar 2020 19:05:08 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 4 Mar 2020 19:06:15 +0800
From:   Sam Shih <sam.shih@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Sam Shih <sam.shih@mediatek.com>
Subject: [v3,0/2] Add mt7629 pwm support
Date:   Wed, 4 Mar 2020 19:06:11 +0800
Message-ID: <1583319973-20694-1-git-send-email-sam.shih@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBhZGRzIHB3bSBzdXBwb3J0IGZvciBNVDc2MjkNCg0KU2FtIFNoaWggKDIpOg0KICBkdC1i
aW5kaW5nczogcHdtOiBVcGRhdGUgYmluZGluZ3MgZm9yIE1UNzYyOSBTb0MNCiAgYXJtOiBkdHM6
IG1lZGlhdGVrOiBhZGQgbXQ3NjI5IHB3bSBzdXBwb3J0DQoNCiAuLi4vZGV2aWNldHJlZS9iaW5k
aW5ncy9wd20vcHdtLW1lZGlhdGVrLnR4dCAgICAgICB8ICA1ICsrKysrDQogYXJjaC9hcm0vYm9v
dC9kdHMvbXQ3NjI5LmR0c2kgICAgICAgICAgICAgICAgICAgICAgfCAxNCArKysrKysrKysrKysr
Kw0KIDIgZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKQ0KDQotLSANCjIuMTcuMQ0K

