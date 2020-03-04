Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC65C3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447122166E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="RP0IXVs4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388001AbgCDLG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 06:06:28 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:34119 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387871AbgCDLG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 06:06:26 -0500
X-UUID: 460880ae0256496392175c97120b7525-20200304
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=0gDwytnNc7xdLpYdN0G7nziQA18TsZeFTPgsLeoCwAM=;
        b=RP0IXVs4n9JthNcDkjCfrmoFWHFnoqnFqoFiOt7amA3cO0N9mpZ518DGhhHnRNMkKpECHrPWJgt1++b0d6BVykYHdEYibDQ+U0D155I5/EJPtzxaaBvME/Gm3oFt5N72buVQwKy3cG2mUjrT69rjkYmd2g2mHrCKiSr5OSgqL9c=;
X-UUID: 460880ae0256496392175c97120b7525-20200304
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1866659304; Wed, 04 Mar 2020 19:06:21 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 4 Mar 2020 19:05:12 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 4 Mar 2020 19:06:19 +0800
From:   Sam Shih <sam.shih@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Sam Shih <sam.shih@mediatek.com>
Subject: [v3,2/2] arm: dts: mediatek: add mt7629 pwm support
Date:   Wed, 4 Mar 2020 19:06:13 +0800
Message-ID: <1583319973-20694-3-git-send-email-sam.shih@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1583319973-20694-1-git-send-email-sam.shih@mediatek.com>
References: <1583319973-20694-1-git-send-email-sam.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBhZGRzIHB3bSBzdXBwb3J0IGZvciBNVDc2MjkuDQoNClNpZ25lZC1vZmYtYnk6IFNhbSBT
aGloIDxzYW0uc2hpaEBtZWRpYXRlay5jb20+DQotLS0NClVzZWQ6DQpodHRwczovL3BhdGNod29y
ay5rZXJuZWwub3JnL3BhdGNoLzExMTYwODUxLw0KDQpDaGFuZ2Ugc2luY2UgdjI6DQpVcGRhdGVk
IGJpbmRpbmdzIGZvciBNVDc2MjkgcHdtIGNvbnRyb2xsZXIuDQoNCi0tLQ0KIGFyY2gvYXJtL2Jv
b3QvZHRzL210NzYyOS5kdHNpIHwgMTQgKysrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwg
MTQgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvbXQ3NjI5
LmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9tdDc2MjkuZHRzaQ0KaW5kZXggODY3Yjg4MTAzYjlk
Li5hMjY1OGZiYWRlY2EgMTAwNjQ0DQotLS0gYS9hcmNoL2FybS9ib290L2R0cy9tdDc2MjkuZHRz
aQ0KKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvbXQ3NjI5LmR0c2kNCkBAIC0yNDEsNiArMjQxLDIw
IEBADQogCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCiAJCX07DQogDQorCQlwd206IHB3bUAxMTAw
NjAwMCB7DQorCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDc2MjktcHdtIjsNCisJCQlyZWcg
PSA8MHgxMTAwNjAwMCAweDEwMDA+Ow0KKwkJCSNwd20tY2VsbHMgPSA8Mj47DQorCQkJY2xvY2tz
ID0gPCZ0b3Bja2dlbiBDTEtfVE9QX1BXTV9TRUw+LA0KKwkJCQkgPCZwZXJpY2ZnIENMS19QRVJJ
X1BXTV9QRD4sDQorCQkJCSA8JnBlcmljZmcgQ0xLX1BFUklfUFdNMV9QRD47DQorCQkJY2xvY2st
bmFtZXMgPSAidG9wIiwgIm1haW4iLCAicHdtMSI7DQorCQkJYXNzaWduZWQtY2xvY2tzID0gPCZ0
b3Bja2dlbiBDTEtfVE9QX1BXTV9TRUw+Ow0KKwkJCWFzc2lnbmVkLWNsb2NrLXBhcmVudHMgPQ0K
KwkJCQkJPCZ0b3Bja2dlbiBDTEtfVE9QX1VOSVZQTEwyX0Q0PjsNCisJCQlzdGF0dXMgPSAiZGlz
YWJsZWQiOw0KKwkJfTsNCisNCiAJCWkyYzogaTJjQDExMDA3MDAwIHsNCiAJCQljb21wYXRpYmxl
ID0gIm1lZGlhdGVrLG10NzYyOS1pMmMiLA0KIAkJCQkgICAgICJtZWRpYXRlayxtdDI3MTItaTJj
IjsNCi0tIA0KMi4xNy4xDQo=

