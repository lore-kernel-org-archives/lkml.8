Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5532C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88B272078E
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgIBOss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 10:48:48 -0400
Received: from m176150.mail.qiye.163.com ([59.111.176.150]:22147 "EHLO
        m176150.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbgIBOK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:10:56 -0400
Received: from vivo.com (wm-10.qy.internal [127.0.0.1])
        by m176150.mail.qiye.163.com (Hmail) with ESMTP id 6F7961A3510;
        Wed,  2 Sep 2020 21:15:46 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AAcACwD5DZmWG17*Ufm844pi.1.1599052546447.Hmail.bernard@vivo.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Bernard Zhao <bernard@vivo.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: =?UTF-8?B?W3JlLXNlbmRdW1BBVENIXSBkcm0vdmlhOiByZWR1Y2Ugbm8gbmVlZCBtdXRleF9sb2NrIGFyZWE=?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 157.0.31.124
MIME-Version: 1.0
Received: from bernard@vivo.com( [157.0.31.124) ] by ajax-webmail ( [127.0.0.1] ) ; Wed, 2 Sep 2020 21:15:46 +0800 (GMT+08:00)
From:   Bernard <bernard@vivo.com>
Date:   Wed, 2 Sep 2020 21:15:46 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZHhpOSkJPTB1LH01CVkpOQkJLTklOT01OSklVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VKS0tZBg++
X-HM-Sender-Digest: e1kMHhlZQQ8JDh5XWRIfHhUPWUFZRzo6GDo4DD9OPyEWLDxKTFEuHRZD
        T08LElVKVUpOQkJLTklOT01CS0NVMxYaEhdVGR4JFRoJHzsNEg0UVRgUFkVZV1kSC1lBWUpOTFVL
        VUhKVUpJT1lXWQgBWUFJTE1JNwY+
X-HM-Tid: 0a744ef5819c93b4kuws6f7961a3510
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW4gZnVuY3Rpb24gdmlhX21lbV9hbGxvY2BzIGVycm9yIGJyYW5jaCwgRFJNX0VSUk9SIGlzIHBy
b3RlY3RlZAppbiB0aGUgbXV0ZXhfbG9jaygmZGV2LT5zdHJ1Y3RfbXV0ZXgpIGFyZWEuCkZyb20g
dGhlIGNvZGUsIHdlIHNlZSB0aGF0IERSTV9FUlJPUiBpcyBqdXN0IGFuIGVycm9yIGxvZyBwcmlu
dAp3aXRob3V0IGFueSBzdHJ1Y3QgZWxlbWVudCwgdGhlcmUgaXMgbm8gbmVlZCB0byBwcm90ZWN0
IHRoaXMuCgpTaWduZWQtb2ZmLWJ5OiBCZXJuYXJkIFpoYW8gPGJlcm5hcmRAdml2by5jb20+Ci0t
LQogZHJpdmVycy9ncHUvZHJtL3ZpYS92aWFfbW0uYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS92aWEvdmlhX21tLmMgYi9kcml2ZXJzL2dwdS9kcm0vdmlhL3ZpYV9tbS5jCmluZGV4IDQ1Y2M5
ZTkwMDI2MC4uZGFlMWJhY2Q4NmMxIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vdmlhL3Zp
YV9tbS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS92aWEvdmlhX21tLmMKQEAgLTEyOSw5ICsxMjks
OSBAQCBpbnQgdmlhX21lbV9hbGxvYyhzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCB2b2lkICpkYXRh
LAogCW11dGV4X2xvY2soJmRldi0+c3RydWN0X211dGV4KTsKIAlpZiAoMCA9PSAoKG1lbS0+dHlw
ZSA9PSBWSUFfTUVNX1ZJREVPKSA/IGRldl9wcml2LT52cmFtX2luaXRpYWxpemVkIDoKIAkJICAg
ICAgZGV2X3ByaXYtPmFncF9pbml0aWFsaXplZCkpIHsKKwkJbXV0ZXhfdW5sb2NrKCZkZXYtPnN0
cnVjdF9tdXRleCk7CiAJCURSTV9FUlJPUgogCQkgICAgKCJBdHRlbXB0IHRvIGFsbG9jYXRlIGZy
b20gdW5pbml0aWFsaXplZCBtZW1vcnkgbWFuYWdlci5cbiIpOwotCQltdXRleF91bmxvY2soJmRl
di0+c3RydWN0X211dGV4KTsKIAkJcmV0dXJuIC1FSU5WQUw7CiAJfQogCi0tIAoyLjI2LjIKCg0K
DQo=
