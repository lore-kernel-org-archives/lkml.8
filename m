Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32B2C3F2C6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 03:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1952072D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 03:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgCFD65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 22:58:57 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:3034 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726251AbgCFD65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 22:58:57 -0500
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id A2F262437629F8AAB41B;
        Fri,  6 Mar 2020 11:58:53 +0800 (CST)
Received: from dggeme711-chm.china.huawei.com (10.1.199.107) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 6 Mar 2020 11:58:53 +0800
Received: from dggeme759-chm.china.huawei.com (10.3.19.105) by
 dggeme711-chm.china.huawei.com (10.1.199.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Fri, 6 Mar 2020 11:58:53 +0800
Received: from dggeme759-chm.china.huawei.com ([10.7.64.73]) by
 dggeme759-chm.china.huawei.com ([10.7.64.73]) with mapi id 15.01.1713.004;
 Fri, 6 Mar 2020 11:58:53 +0800
From:   "tiantao (H)" <tiantao6@hisilicon.com>
To:     "tiantao (H)" <tiantao6@hisilicon.com>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "kraxel@redhat.com" <kraxel@redhat.com>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "xinliang.liu@linaro.org" <xinliang.liu@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Linuxarm <linuxarm@huawei.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBkcm0vaGlzaWxpY29uOiBBZGQgdGhlIHNodXRkb3du?=
 =?gb2312?B?IGZvciBoaWJtY19wY2lfZHJpdmVy?=
Thread-Topic: [PATCH] drm/hisilicon: Add the shutdown for hibmc_pci_driver
Thread-Index: AQHV82lxn9gkibbLOEaVBpUdO8J6s6g6796g
Date:   Fri, 6 Mar 2020 03:58:53 +0000
Message-ID: <063d5262b6f7401bb9a0bb2a52a123b2@hisilicon.com>
References: <1583466184-7060-1-git-send-email-tiantao6@hisilicon.com>
 <1583466184-7060-2-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1583466184-7060-2-git-send-email-tiantao6@hisilicon.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.57.60.129]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxso7oNCg0KCVNvcnJ5o6xwbGVhc2UgIGlnbm9yZSB0aGlzIHBhdGNoLg0KDQpCZXN0DQoN
Ci0tLS0t08q8/tStvP4tLS0tLQ0Kt6K8/sjLOiBMaW51eGFybSBbbWFpbHRvOmxpbnV4YXJtLWJv
dW5jZXNAaHVhd2VpLmNvbV0gtPqx7SBUaWFuIFRhbw0Kt6LLzcqxvOQ6IDIwMjDE6jPUwjbI1SAx
MTo0Mw0KytW8/sjLOiBDaGVuZmVuZyAocHVjaykgPHB1Y2suY2hlbkBoaXNpbGljb24uY29tPjsg
YWlybGllZEBsaW51eC5pZTsgZGFuaWVsQGZmd2xsLmNoOyB0emltbWVybWFubkBzdXNlLmRlOyBr
cmF4ZWxAcmVkaGF0LmNvbTsgYWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbTsgdGdseEBsaW51dHJv
bml4LmRlOyBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyB4aW5saWFuZy5saXVAbGlu
YXJvLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0Ks63LzTogTGludXhhcm0gPGxp
bnV4YXJtQGh1YXdlaS5jb20+DQrW98ziOiBbUEFUQ0hdIGRybS9oaXNpbGljb246IEFkZCB0aGUg
c2h1dGRvd24gZm9yIGhpYm1jX3BjaV9kcml2ZXINCg0KYWRkIHRoZSBzaHV0ZG93biBmdW5jdGlv
biB0byByZWxlYXNlIHRoZSByZXNvdXJjZS4NCg0KU2lnbmVkLW9mZi1ieTogVGlhbiBUYW8gPHRp
YW50YW82QGhpc2lsaWNvbi5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vaGlzaWxpY29uL2hp
Ym1jL2hpYm1jX2RybV9kcnYuYyB8IDEwICsrKysrKysrLS0NCiAxIGZpbGUgY2hhbmdlZCwgOCBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2hpc2lsaWNvbi9oaWJtYy9oaWJtY19kcm1fZHJ2LmMgYi9kcml2ZXJzL2dwdS9kcm0vaGlz
aWxpY29uL2hpYm1jL2hpYm1jX2RybV9kcnYuYw0KaW5kZXggNTFmMWM3MC4uMGU1ODQ1NWQgMTAw
NjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vaGlzaWxpY29uL2hpYm1jL2hpYm1jX2RybV9kcnYu
Yw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2hpc2lsaWNvbi9oaWJtYy9oaWJtY19kcm1fZHJ2LmMN
CkBAIC0zNTcsOSArMzU3LDE0IEBAIHN0YXRpYyB2b2lkIGhpYm1jX3BjaV9yZW1vdmUoc3RydWN0
IHBjaV9kZXYgKnBkZXYpICB7DQogCXN0cnVjdCBkcm1fZGV2aWNlICpkZXYgPSBwY2lfZ2V0X2Ry
dmRhdGEocGRldik7DQogDQotCWRybV9kZXZfdW5yZWdpc3RlcihkZXYpOw0KLQloaWJtY191bmxv
YWQoZGV2KTsNCiAJZHJtX2Rldl9wdXQoZGV2KTsNCisJcGNpX2Rpc2FibGVfZGV2aWNlKHBkZXYp
Ow0KKw0KK30NCisNCitzdGF0aWMgdm9pZCBoaWJtY19wY2lfc2h1dGRvd24oc3RydWN0IHBjaV9k
ZXYgKnBkZXYpIHsNCisJaGlibWNfcGNpX3JlbW92ZShwZGV2KTsNCiB9DQogDQogc3RhdGljIHN0
cnVjdCBwY2lfZGV2aWNlX2lkIGhpYm1jX3BjaV90YWJsZVtdID0geyBAQCAtMzcyLDYgKzM3Nyw3
IEBAIHN0YXRpYyBzdHJ1Y3QgcGNpX2RyaXZlciBoaWJtY19wY2lfZHJpdmVyID0gew0KIAkuaWRf
dGFibGUgPQloaWJtY19wY2lfdGFibGUsDQogCS5wcm9iZSA9CWhpYm1jX3BjaV9wcm9iZSwNCiAJ
LnJlbW92ZSA9CWhpYm1jX3BjaV9yZW1vdmUsDQorCS5zaHV0ZG93biA9IGhpYm1jX3BjaV9zaHV0
ZG93biwNCiAJLmRyaXZlci5wbSA9ICAgICZoaWJtY19wbV9vcHMsDQogfTsNCiANCi0tDQoyLjcu
NA0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KTGlu
dXhhcm0gbWFpbGluZyBsaXN0DQpMaW51eGFybUBodWF3ZWkuY29tDQpodHRwOi8vaHVsay5odWF3
ZWkuY29tL21haWxtYW4vbGlzdGluZm8vbGludXhhcm0NCg==
