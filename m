Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MIME_BASE64_TEXT,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D38C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F5C2084D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JRCIOum/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgANJSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 04:18:52 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:39622 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725842AbgANJSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 04:18:51 -0500
X-UUID: 5cc7864344b14b72b049ac72aefbd1f0-20200114
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=aZyDNFPXw+JIpXqug8qSOA95bzg2wpu/wWgcIqMi9CQ=;
        b=JRCIOum/INy0KlezabCQ4qiH7qs0Cr2mcz05aReSC62XIX2ke7c86eN4w6U3bSMNndqLq1/aMnB/9FODm+/A2Ioe/rypBloYr4avaiLHfjNckQUFHqaocscp73ynzyBFnrOYTjpoH1XFGCVFLxq5xz3Uo3L1KSgN0KHD7e8veMg=;
X-UUID: 5cc7864344b14b72b049ac72aefbd1f0-20200114
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <gtk_ruiwang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1718208132; Tue, 14 Jan 2020 17:18:45 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 14 Jan 2020 17:17:41 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 14 Jan 2020 17:18:54 +0800
From:   <gtk_ruiwang@mediatek.com>
To:     <linux-firmware@kernel.org>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        <PoChun.Lin@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        <gtk_ruiwang@mediatek.com>
Subject: pull request: linux-firmware: Update Mediatek MT8173 VPU firmware
Date:   Tue, 14 Jan 2020 17:18:35 +0800
Message-ID: <20200114091836.19403-1-gtk_ruiwang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgbGludXgtZmlybXdhcmUgbWFpbnRhaW5lcnMsDQogDQpUaGUgZm9sbG93aW5nIGNoYW5nZXMg
c2luY2UgY29tbWl0IDY3ZDRmZjU5YmYzMzM0ODk1NjI2Y2YxNjVlNTA4ZTllYjE4NDZlMjQ6DQoN
CiAgTWVsbGFub3g6IEFkZCBuZXcgbWx4c3dfc3BlY3RydW0gZmlybXdhcmUgeHguMjAwMC4yNzE0
ICgyMDIwLTAxLTA3IDA5OjA4OjI1IC0wNTAwKQ0KDQphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQg
cmVwb3NpdG9yeSBhdDoNCg0KICBodHRwczovL2dpdGh1Yi5jb20vcnVpd2FuZy1tdGsvbGludXhf
ZndfdnB1X3YxLjEuMy5naXQNCg0KZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIDdmMzE3
N2QyMjRlZTdhZmRkNmUzNmVkMDFhMTNmNDk5ZDY3MWUxNjc6DQoNCiAgbWVkaWF0ZWs6IHVwZGF0
ZSBNVDgxNzMgVlBVIGZpcm13YXJlIHRvIHYxLjEuMyAoMjAyMC0wMS0xNCAxNTozMzoxOSArMDgw
MCkNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KZ3RrX3J1aXdhbmcgKDEpOg0KICAgICAgbWVkaWF0ZWs6IHVwZGF0ZSBN
VDgxNzMgVlBVIGZpcm13YXJlIHRvIHYxLjEuMw0KDQogdnB1X2QuYmluIHwgQmluIDI5NzcwMDgg
LT4gMjk3NzEzNiBieXRlcw0KIHZwdV9wLmJpbiB8IEJpbiAxMzExODAgLT4gMTMxMTgwIGJ5dGVz
DQogMiBmaWxlcyBjaGFuZ2VkLCAwIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pDQoNCg==

