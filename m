Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D14C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47DFE20767
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="tZaIzuZ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730372AbgFVS3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 14:29:01 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:33799 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730334AbgFVS25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 14:28:57 -0400
X-UUID: b8b21b0e9efc41acbc1390e5b8dda512-20200623
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=u/qeHnCERVP0p9pL86EEBwI8mw2KPf3U4AMqX+NMYcw=;
        b=tZaIzuZ/SoS0WKQHCYMB1oF8rCrWjQNeB1q7fygQhum5MeFYzYI+6qELXjf/fvWuQfp8TGXjEekhmjn3+BRKz6+cjuWF9UVpaqUOANzqt0jXDH50AFhQYKgaOpbH0g3lvSPsXAsbi03fT6GyEaZAjbqzeZYBX6t/b0eWdfQL+Wk=;
X-UUID: b8b21b0e9efc41acbc1390e5b8dda512-20200623
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 971567261; Tue, 23 Jun 2020 02:28:52 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 23 Jun 2020 02:28:44 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 23 Jun 2020 02:28:44 +0800
From:   <sean.wang@mediatek.com>
To:     <marcel@holtmann.org>
CC:     <johan.hedberg@gmail.com>, <Sean.Wang@mediatek.com>,
        <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Mark-YW.Chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH v2 1/2] Bluetooth: btusb: fix up firmware download sequence
Date:   Tue, 23 Jun 2020 02:28:47 +0800
Message-ID: <1592850527-20931-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <5F6C2EB2-B0DF-4534-A123-4E6969A98410@holtmann.org>
References: <5F6C2EB2-B0DF-4534-A123-4E6969A98410@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 47883B77D10E9BF77439FF001409115AD257F525EF5B0F5B41C0F4D3651852DD2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogU2VhbiBXYW5nIDxzZWFuLndhbmdAbWVkaWF0ZWsuY29tPg0KDQo+SGkgU2VhbiwNCj4N
Cj4+IEZyb206IFNlYW4gV2FuZyA8c2Vhbi53YW5nQG1lZGlhdGVrLmNvbT4NCj4+DQo+PiBEYXRh
IFJBTSBvbiB0aGUgZGV2aWNlIGhhdmUgdG8gYmUgcG93ZXJlZCBvbiBiZWZvcmUgc3RhcnRpbmcg
dG8NCj4+IGRvd25sb2FkIHRoZSBmaXJtd2FyZS4NCj4+DQo+PiB2MS0+djI6DQo+PglyZWJhc2Vk
IHRvIGJsdWV0b290aC1uZXh0DQo+Pg0KPj4gRml4ZXM6IGExYzQ5YzQzNGUxNSAoIkJsdWV0b290
aDogYnR1c2I6IEFkZCBwcm90b2NvbCBzdXBwb3J0IGZvcg0KPj4gTWVkaWFUZWsgTVQ3NjY4VSBV
U0IgZGV2aWNlcyIpDQo+PiBDby1kZXZlbG9wZWQtYnk6IE1hcmsgQ2hlbiA8TWFyay1ZVy5DaGVu
QG1lZGlhdGVrLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IE1hcmsgQ2hlbiA8TWFyay1ZVy5DaGVu
QG1lZGlhdGVrLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFNlYW4gV2FuZyA8c2Vhbi53YW5nQG1l
ZGlhdGVrLmNvbT4NCj4+IC0tLQ0KPj4gZHJpdmVycy9ibHVldG9vdGgvYnR1c2IuYyB8IDE2ICsr
KysrKysrKysrKysrKy0NCj4+IDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQo+DQo+c29tZXRoaW5nIGlzIGZpc2h5IGhlcmUuIGdpdCBhbSBzdGlsbCBmYWls
cy4NCj4NCg0KYSBsaXR0bGUgd2VpcmQuIEkgd2lsbCB0cnkgdG8gZ2l0IGZvcm1hdC1wYXRjaCBh
bmQgc2VuZCB0aGUgcGF0Y2ggYWdhaW4gd2l0aCBhbm90aGVyIG1hY2hpbmUgdG8geW91Lg0KDQo+
UmVnYXJkcw0KPg0KPk1hcmNlbA==

