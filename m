Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A96C10DCE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 01:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6313F2064A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 01:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="TYv063EY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgCIBf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 21:35:27 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:34563 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726346AbgCIBf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 21:35:27 -0400
X-UUID: 17f6d4a6cdd34624bed94824c91e9661-20200309
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=/2+LDngAwdJSa5uqOU8IW5tlL8Vd0+38SPAO9Uher5E=;
        b=TYv063EYYvqu9mR6l41nHX7r9Prrsp5our8MGMEUy+waJXHuFdCx6BcI0NMSKqa5vvIC+PK2uLK8LM2ZwQofxpql1bdFggfOD5jiAVGQWHAt4hK9vfpSZIKdyI+t7apyb4utbAO+8BuJkGjM/fQbEycSh+NgTg4ax4XxQihX68E=;
X-UUID: 17f6d4a6cdd34624bed94824c91e9661-20200309
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 775658734; Mon, 09 Mar 2020 09:35:19 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 9 Mar 2020 09:34:23 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 9 Mar 2020 09:35:35 +0800
Message-ID: <1583717717.24810.2.camel@mtksdaap41>
Subject: Re: [PATCH] MAINTAINERS: Update Chun-Kuang Hu's email address
From:   CK Hu <ck.hu@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Mon, 9 Mar 2020 09:35:17 +0800
In-Reply-To: <20200308045201.3163-1-chunkuang.hu@kernel.org>
References: <20200308045201.3163-1-chunkuang.hu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIwLTAzLTA4IGF0IDEyOjUyICswODAwLCBDaHVuLUt1YW5nIEh1IHdyb3RlOg0K
PiBVcGRhdGUgbXkgZW1haWwgYWRkcmVzcyB0byBAa2VybmVsLm9yZw0KPiANCg0KQXBwbGllZCB0
byBtZWRpYXRlay1kcm0tbmV4dC01LjcgWzFdLg0KDQpbMV0NCmh0dHBzOi8vZ2l0aHViLmNvbS9j
a2h1LW1lZGlhdGVrL2xpbnV4LmdpdC10YWdzL2NvbW1pdHMvbWVkaWF0ZWstZHJtLW5leHQtNS43
DQoNClJlZ2FyZHMsDQpDSw0KDQo+IFNpZ25lZC1vZmYtYnk6IENodW4tS3VhbmcgSHUgPGNodW5r
dWFuZy5odUBrZXJuZWwub3JnPg0KPiAtLS0NCj4gIE1BSU5UQUlORVJTIHwgMiArLQ0KPiAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUw0KPiBpbmRleCAzOGZlMmYzZjdiNmYuLmRj
ZWFlZWJjZTUyYSAxMDA2NDQNCj4gLS0tIGEvTUFJTlRBSU5FUlMNCj4gKysrIGIvTUFJTlRBSU5F
UlMNCj4gQEAgLTU2MDcsNyArNTYwNyw3IEBAIEY6CWluY2x1ZGUvdWFwaS9kcm0vbGltYV9kcm0u
aA0KPiAgVDoJZ2l0IGdpdDovL2Fub25naXQuZnJlZWRlc2t0b3Aub3JnL2RybS9kcm0tbWlzYw0K
PiAgDQo+ICBEUk0gRFJJVkVSUyBGT1IgTUVESUFURUsNCj4gLU06CUNLIEh1IDxjay5odUBtZWRp
YXRlay5jb20+DQo+ICtNOglDaHVuLUt1YW5nIEh1IDxjaHVua3VhbmcuaHVAa2VybmVsLm9yZz4N
Cj4gIE06CVBoaWxpcHAgWmFiZWwgPHAuemFiZWxAcGVuZ3V0cm9uaXguZGU+DQo+ICBMOglkcmkt
ZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+ICBTOglTdXBwb3J0ZWQNCg0K

