Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E878FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C99752076C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FSH/bkb0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgHCPkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 11:40:00 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:16933 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726806AbgHCPj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 11:39:59 -0400
X-UUID: 5a8822ff7bd6444a9ec4b3b63d0407d1-20200803
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=+W1pY9M613RDdoabjfIUPYlQHHrDntAsNM3ob88BJcY=;
        b=FSH/bkb0al/Q/U1KFmTzV8wUdTYCVrIFH7gtZ7abVZnGk1OH2iU5JXPWo3D45OfR9EfJ/em7Sg+A8NrMUaYD2ifpwikz8f7hETR0acvjj5jl7gI5VolLwwugouvnTjJ5tRRelkbfOb/1P33PRPNldattyA+wX5fGhNC1TjWbOf4=;
X-UUID: 5a8822ff7bd6444a9ec4b3b63d0407d1-20200803
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 556803990; Mon, 03 Aug 2020 23:39:55 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 3 Aug 2020 23:39:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 3 Aug 2020 23:39:52 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>
Subject: [PATCH] proc: use untagged_addr() for pagemap_read addresses
Date:   Mon, 3 Aug 2020 23:39:53 +0800
Message-ID: <20200803153953.20364-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2hlbiB3ZSB0cnkgdG8gdmlzaXQgdGhlIHBhZ2VtYXAgb2YgYSB0YWdnZWQgdXNlcnNwYWNlIHBv
aW50ZXIsIHdlIGZpbmQNCnRoYXQgdGhlIHN0YXJ0X3ZhZGRyIGlzIG5vdCBjb3JyZWN0IGJlY2F1
c2Ugb2YgdGhlIHRhZy4NClRvIGZpeCBpdCwgd2Ugc2hvdWxkIHVudGFnIHRoZSB1c2VzcGFjZSBw
b2ludGVycyBpbiBwYWdlbWFwX3JlYWQoKS4NCg0KU2lnbmVkLW9mZi1ieTogTWlsZXMgQ2hlbiA8
bWlsZXMuY2hlbkBtZWRpYXRlay5jb20+DQotLS0NCiBmcy9wcm9jL3Rhc2tfbW11LmMgfCA0ICsr
LS0NCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpk
aWZmIC0tZ2l0IGEvZnMvcHJvYy90YXNrX21tdS5jIGIvZnMvcHJvYy90YXNrX21tdS5jDQppbmRl
eCBkYmRhNDQ5OWE4NTkuLmQwYzZlOGUwY2YzNyAxMDA2NDQNCi0tLSBhL2ZzL3Byb2MvdGFza19t
bXUuYw0KKysrIGIvZnMvcHJvYy90YXNrX21tdS5jDQpAQCAtMTU0MSwxMSArMTU0MSwxMSBAQCBz
dGF0aWMgc3NpemVfdCBwYWdlbWFwX3JlYWQoc3RydWN0IGZpbGUgKmZpbGUsIGNoYXIgX191c2Vy
ICpidWYsDQogDQogCXNyYyA9ICpwcG9zOw0KIAlzdnBmbiA9IHNyYyAvIFBNX0VOVFJZX0JZVEVT
Ow0KLQlzdGFydF92YWRkciA9IHN2cGZuIDw8IFBBR0VfU0hJRlQ7DQorCXN0YXJ0X3ZhZGRyID0g
dW50YWdnZWRfYWRkcihzdnBmbiA8PCBQQUdFX1NISUZUKTsNCiAJZW5kX3ZhZGRyID0gbW0tPnRh
c2tfc2l6ZTsNCiANCiAJLyogd2F0Y2ggb3V0IGZvciB3cmFwYXJvdW5kICovDQotCWlmIChzdnBm
biA+IG1tLT50YXNrX3NpemUgPj4gUEFHRV9TSElGVCkNCisJaWYgKHN0YXJ0X3ZhZGRyID4gbW0t
PnRhc2tfc2l6ZSkNCiAJCXN0YXJ0X3ZhZGRyID0gZW5kX3ZhZGRyOw0KIA0KIAkvKg0KLS0gDQoy
LjE4LjANCg==

