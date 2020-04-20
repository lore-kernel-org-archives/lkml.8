Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41E5C38A29
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 00:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A28B220882
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 00:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgDTA7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 20:59:05 -0400
Received: from mail-m127108.qiye.163.com ([115.236.127.108]:1589 "EHLO
        mail-m127108.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgDTA7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 20:59:05 -0400
X-Greylist: delayed 394 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Apr 2020 20:59:03 EDT
Received: from vivo.com (wm-13.qy.internal [127.0.0.1])
        by mail-m127108.qiye.163.com (Hmail) with ESMTP id 8C1C0842195;
        Mon, 20 Apr 2020 08:51:54 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AJ6AmADaCLivAKtTLreYUqof.3.1587343914555.Hmail.bernard@vivo.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        =?UTF-8?Q?Felix_K=C3=BChling?= <Felix.Kuehling@amd.com>,
        kernel@vivo.com, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogUmVkdWNlIGEgbG9jayBzY29wZSBpbiBhbWRncHVfYW1ka2ZkX2dwdXZtX2ZyZWVfbWVtb3J5X29mX2dwdSgp?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 157.0.31.122
MIME-Version: 1.0
Received: from bernard@vivo.com( [157.0.31.122) ] by ajax-webmail ( [127.0.0.1] ) ; Mon, 20 Apr 2020 08:51:54 +0800 (GMT+08:00)
From:   =?UTF-8?B?6LW15Yab5aWO?= <bernard@vivo.com>
Date:   Mon, 20 Apr 2020 08:51:54 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSFVNQk9LS0tJT09KT0tNSVlXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kJHlYWEh9ZQUhMSEtJTUlOTEJLN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6MU06Fjo*Gjg3Eg06MA8vNwkeIi4KFB1VSFVKTkNMSE9IQkpPTUNMVTMWGhIXVRkeCRUaCR87
        DRINFFUYFBZFWVdZEgtZQVlKTkxVS1VISlVKSUlZV1kIAVlBSE5MSTcG
X-HM-Tid: 0a719511f656986ckuuu8c1c0842195
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpGcm9tOiBNYXJrdXMgRWxmcmluZyA8TWFya3VzLkVsZnJpbmdAd2ViLmRlPgpEYXRlOiAyMDIw
LTA0LTE5IDE3OjA1OjA3ClRvOiAgQmVybmFyZCBaaGFvIDxiZXJuYXJkQHZpdm8uY29tPixhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZyxkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
LEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4sIkNocmlzdGlhbiBLw7Zu
aWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+LENodW5taW5nIFpob3UgPERhdmlkMS5aaG91
QGFtZC5jb20+LCJGZWxpeCBLw7xobGluZyIgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+CkNjOiAg
a2VybmVsQHZpdm8uY29tLGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcsRGFuaWVsIFZldHRl
ciA8ZGFuaWVsQGZmd2xsLmNoPixEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+ClN1Ympl
Y3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IFJlZHVjZSBhIGxvY2sgc2NvcGUgaW4gYW1kZ3B1
X2FtZGtmZF9ncHV2bV9mcmVlX21lbW9yeV9vZl9ncHUoKT4+IE1heWJlIHdlIGNvdWxkIHJlZHVj
ZSB0aGUgbXV0ZXhfbG9jaygmbWVtLT5sb2NrKWBzIHByb3RlY3RlZCBjb2RlIGFyZWEsCj4+IGFu
ZCBub25lZWQgdG8gcHJvdGVjdCBwcl9kZWJ1Zy4KPgo+SSBzdWdnZXN0IHRvIGltcHJvdmUgdGhl
IGNvbW1pdCBtZXNzYWdlLgo+V291bGQgeW91IGxpa2UgdG8gYWRqdXN0IHRoZSBwYXRjaCBzdWJq
ZWN0Pwo+Cj5EbyB5b3UgaW1hZ2luZSB0aGF0IGRhdGEgc3luY2hyb25pc2F0aW9uIHNob3VsZCBl
dm9sdmUgaW4gb3RoZXIgd2F5cz8KPgo+UmVnYXJkcywKPk1hcmt1cwoKU3VyZSwgSSB3aWxsIG1v
ZGlmeSB0aGUgY29kZSBhbmQgYWRqdXN0IHRoaXMgcGF0Y2ggc3ViamVjdC4gSSB3aWxsIHN1Ym1p
dCBpdCBhZ2Fpbi4KCg0KDQo=
