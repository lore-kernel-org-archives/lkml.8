Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152AEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E95E22085B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgGBHET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 03:04:19 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2622 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726092AbgGBHET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 03:04:19 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 4564DCF9CC776307FF85;
        Thu,  2 Jul 2020 15:04:14 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Thu, 2 Jul 2020 15:04:00 +0800
Received: from dggeme759-chm.china.huawei.com (10.3.19.105) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 2 Jul 2020 15:04:00 +0800
Received: from dggeme759-chm.china.huawei.com ([10.7.64.73]) by
 dggeme759-chm.china.huawei.com ([10.7.64.73]) with mapi id 15.01.1913.007;
 Thu, 2 Jul 2020 15:04:00 +0800
From:   "tiantao (H)" <tiantao6@hisilicon.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "kraxel@redhat.com" <kraxel@redhat.com>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "xinliang.liu@linaro.org" <xinliang.liu@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Linuxarm <linuxarm@huawei.com>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIGRybS9oaXNpbGljb246IFVzZSBkcm1tX2t6YWxs?=
 =?utf-8?Q?oc()_instead_of_devm=5Fkzalloc()?=
Thread-Topic: [PATCH] drm/hisilicon: Use drmm_kzalloc() instead of
 devm_kzalloc()
Thread-Index: AQHWUDv5oF9N4eaD8EOIzTbHFGOwPKjz3NAQ
Date:   Thu, 2 Jul 2020 07:04:00 +0000
Message-ID: <8f415f3d92584498bd979787d1846e5e@hisilicon.com>
References: <1593652914-19639-1-git-send-email-tiantao6@hisilicon.com>
 <50ea833a-7d8d-a1ad-3622-3456afc87719@suse.de>
In-Reply-To: <50ea833a-7d8d-a1ad-3622-3456afc87719@suse.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.57.60.129]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGnvvJoNCg0KCVRoYW5rcyBmb3IgdGhlIGhlbHAgd2l0aCB0aGUgcmV2aWV3IGNvZGUuIEkgd2ls
bCBzZW5kIHYyIHRvIGZpeGVkIHRoaXMuDQoNCkJlc3QNCg0KLS0tLS3pgq7ku7bljp/ku7YtLS0t
LQ0K5Y+R5Lu25Lq6OiBUaG9tYXMgWmltbWVybWFubiBbbWFpbHRvOnR6aW1tZXJtYW5uQHN1c2Uu
ZGVdIA0K5Y+R6YCB5pe26Ze0OiAyMDIw5bm0N+aciDLml6UgMTQ6NDMNCuaUtuS7tuS6ujogdGlh
bnRhbyAoSCkgPHRpYW50YW82QGhpc2lsaWNvbi5jb20+OyBDaGVuZmVuZyAocHVjaykgPHB1Y2su
Y2hlbkBoaXNpbGljb24uY29tPjsgYWlybGllZEBsaW51eC5pZTsgZGFuaWVsQGZmd2xsLmNoOyBr
cmF4ZWxAcmVkaGF0LmNvbTsgYWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbTsgdGdseEBsaW51dHJv
bml4LmRlOyBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyB4aW5saWFuZy5saXVAbGlu
YXJvLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0K5oqE6YCBOiBpbnV4YXJtQGh1
YXdlaS5jb20NCuS4u+mimDogUmU6IFtQQVRDSF0gZHJtL2hpc2lsaWNvbjogVXNlIGRybW1fa3ph
bGxvYygpIGluc3RlYWQgb2YgZGV2bV9remFsbG9jKCkNCg0KSGkNCg0KQW0gMDIuMDcuMjAgdW0g
MDM6MjEgc2NocmllYiBUaWFuIFRhbzoNCj4gdXNpbmcgdGhlIG5ldyBBUEkgZHJtbV9remFsbG9j
KCkgaW5zdGVhZCBvZiBkZXZtX2t6YWxsb2MoKQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogVGlhbiBU
YW8gPHRpYW50YW82QGhpc2lsaWNvbi5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2hp
c2lsaWNvbi9oaWJtYy9oaWJtY19kcm1fZHJ2LmMgfCAzICsrLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9oaXNpbGljb24vaGlibWMvaGlibWNfZHJtX2Rydi5jIGIvZHJpdmVycy9ncHUv
ZHJtL2hpc2lsaWNvbi9oaWJtYy9oaWJtY19kcm1fZHJ2LmMNCj4gaW5kZXggYTZmZDBjMi4uMmYy
MDcwNCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2hpc2lsaWNvbi9oaWJtYy9oaWJt
Y19kcm1fZHJ2LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2hpc2lsaWNvbi9oaWJtYy9oaWJt
Y19kcm1fZHJ2LmMNCj4gQEAgLTIzLDYgKzIzLDcgQEANCj4gICNpbmNsdWRlIDxkcm0vZHJtX3By
aW50Lmg+DQo+ICAjaW5jbHVkZSA8ZHJtL2RybV9wcm9iZV9oZWxwZXIuaD4NCj4gICNpbmNsdWRl
IDxkcm0vZHJtX3ZibGFuay5oPg0KPiArI2luY2x1ZGUgPGRybS9kcm1fbWFuYWdlZC5oPg0KDQpQ
bGVhc2Uga2VlcCB0aGUgRFJNIGluY2x1ZGUgc3RhdGVtZW50cyBzb3J0ZWQgYWxwaGFiZXRpY2Fs
bHkuDQoNCldpdGggdGhpcyBmaXhlZA0KDQpSZXZpZXdlZC1ieTogVGhvbWFzIFppbW1lcm1hbm4g
PHR6aW1tZXJtYW5uQHN1c2UuZGU+DQoNCj4gIA0KPiAgI2luY2x1ZGUgImhpYm1jX2RybV9kcnYu
aCINCj4gICNpbmNsdWRlICJoaWJtY19kcm1fcmVncy5oIg0KPiBAQCAtMjY3LDcgKzI2OCw3IEBA
IHN0YXRpYyBpbnQgaGlibWNfbG9hZChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2KQ0KPiAgCXN0cnVj
dCBoaWJtY19kcm1fcHJpdmF0ZSAqcHJpdjsNCj4gIAlpbnQgcmV0Ow0KPiAgDQo+IC0JcHJpdiA9
IGRldm1fa3phbGxvYyhkZXYtPmRldiwgc2l6ZW9mKCpwcml2KSwgR0ZQX0tFUk5FTCk7DQo+ICsJ
cHJpdiA9IGRybW1fa3phbGxvYyhkZXYsIHNpemVvZigqcHJpdiksIEdGUF9LRVJORUwpOw0KPiAg
CWlmICghcHJpdikgew0KPiAgCQlEUk1fRVJST1IoIm5vIG1lbW9yeSB0byBhbGxvY2F0ZSBmb3Ig
aGlibWNfZHJtX3ByaXZhdGVcbiIpOw0KPiAgCQlyZXR1cm4gLUVOT01FTTsNCj4gDQoNCi0tIA0K
VGhvbWFzIFppbW1lcm1hbm4NCkdyYXBoaWNzIERyaXZlciBEZXZlbG9wZXINClNVU0UgU29mdHdh
cmUgU29sdXRpb25zIEdlcm1hbnkgR21iSA0KTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJn
LCBHZXJtYW55DQooSFJCIDM2ODA5LCBBRyBOw7xybmJlcmcpDQpHZXNjaMOkZnRzZsO8aHJlcjog
RmVsaXggSW1lbmTDtnJmZmVyDQoNCg==
