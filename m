Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C426C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 06:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F0AA20724
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 06:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgHVGAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 02:00:44 -0400
Received: from spam.zju.edu.cn ([61.164.42.155]:21268 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725863AbgHVGAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 02:00:44 -0400
Received: by ajax-webmail-mail-app4 (Coremail) ; Sat, 22 Aug 2020 14:00:12
 +0800 (GMT+08:00)
X-Originating-IP: [10.192.85.18]
Date:   Sat, 22 Aug 2020 14:00:12 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Tomi Valkeinen" <tomi.valkeinen@ti.com>
Cc:     kjlu@umn.edu, "David Airlie" <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>,
        "Sebastian Reichel" <sebastian.reichel@collabora.com>,
        "Tony Lindgren" <tony@atomide.com>,
        zhengbin <zhengbin13@huawei.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] drm/omap: Fix runtime PM imbalance in
 dsi_runtime_get
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.12 build 20200616(0f5d8152)
 Copyright (c) 2002-2020 www.mailtech.cn zju.edu.cn
In-Reply-To: <5123d7ae-f491-d2d2-788d-b5250ae9e31d@ti.com>
References: <20200821074506.32359-1-dinghao.liu@zju.edu.cn>
 <5123d7ae-f491-d2d2-788d-b5250ae9e31d@ti.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <41f64836.7f.17414c0c8e5.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgBn6PxstEBfuXMzAQ--.39573W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgoSBlZdtPnBhAAtsy
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJTRUUUbA0S07vEb7Iv0x
        C_Cr1lV2xY67kC6x804xWlV2xY67CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DMIAI
        bVAFxVCF77xC64kEw24lV2xY67C26IkvcIIF6IxKo4kEV4ylV2xY628lY4IE4IxF12IF4w
        CS07vE84x0c7CEj48ve4kI8wCS07vE84ACjcxK6xIIjxv20xvE14v26w1j6s0DMIAIbVA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIAIbVA2z4x0Y4vEx4A2jsIE14v26r
        xl6s0DMIAIbVA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lV2xY62AIxVAIcxkEcVAq
        07x20xvEncxIr21lV2xY6c02F40EFcxC0VAKzVAqx4xG6I80ewCS07vEYx0E2Ix0cI8IcV
        AFwI0_JrI_JrylV2xY6cIj6I8E87Iv67AKxVWUJVW8JwCS07vEOx8S6xCaFVCjc4AY6r1j
        6r4UMIAIbVACI402YVCY1x02628vn2kIc2xKxwCS07vE7I0Y64k_MIAIbVCY0x0Ix7I2Y4
        AK64vIr41lV2xY6xAIw28IcVCjz48v1sIEY20_GFWkJr1UJwCS07vE4x8a6x804xWlV2xY
        6xC20s026xCaFVCjc4AY6r1j6r4UMIAIbVC20s026c02F40E14v26r1j6r18MIAIbVC20s
        026x8GjcxK67AKxVWUGVWUWwCS07vEx4CE17CEb7AF67AKxVWUtVW8ZwCS07vEIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCS07vEIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIAIbV
        CI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIAIbVCI42IY6I8E87Iv67AKxVWUJVW8JwCS
        07vEIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUU==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBIaSwKPiAKPiBPbiAyMS8wOC8yMDIwIDEwOjQ1LCBEaW5naGFvIExpdSB3cm90ZToKPiA+IHBt
X3J1bnRpbWVfZ2V0X3N5bmMoKSBpbmNyZW1lbnRzIHRoZSBydW50aW1lIFBNIHVzYWdlIGNvdW50
ZXIKPiA+IGV2ZW4gd2hlbiBpdCByZXR1cm5zIGFuIGVycm9yIGNvZGUuIEhvd2V2ZXIsIHVzZXJz
IG9mCj4gPiBkc2lfcnVudGltZV9nZXQoKSwgYSBkaXJlY3Qgd3JhcHBlciBvZiBwbV9ydW50aW1l
X2dldF9zeW5jKCksCj4gPiBhc3N1bWUgdGhhdCBQTSB1c2FnZSBjb3VudGVyIHdpbGwgbm90IGNo
YW5nZSBvbiBlcnJvci4gVGh1cyBhCj4gPiBwYWlyaW5nIGRlY3JlbWVudCBpcyBuZWVkZWQgb24g
dGhlIGVycm9yIGhhbmRsaW5nIHBhdGggdG8ga2VlcAo+ID4gdGhlIGNvdW50ZXIgYmFsYW5jZWQu
Cj4gPiAKPiA+IEZpeGVzOiA0ZmJhZmFmMzcxYmU3ICgiT01BUDogRFNTMjogVXNlIFBNIHJ1bnRp
bWUgJiBIV01PRCBzdXBwb3J0IikKPiA+IFNpZ25lZC1vZmYtYnk6IERpbmdoYW8gTGl1IDxkaW5n
aGFvLmxpdUB6anUuZWR1LmNuPgo+ID4gLS0tCj4gPiAgZHJpdmVycy9ncHUvZHJtL29tYXBkcm0v
ZHNzL2RzaS5jIHwgNyArKysrKy0tCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9v
bWFwZHJtL2Rzcy9kc2kuYyBiL2RyaXZlcnMvZ3B1L2RybS9vbWFwZHJtL2Rzcy9kc2kuYwo+ID4g
aW5kZXggZWVjY2Y0MGJhZTQxLi45NzNiZmExNGExMDQgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vb21hcGRybS9kc3MvZHNpLmMKPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9vbWFw
ZHJtL2Rzcy9kc2kuYwo+ID4gQEAgLTExMTIsOCArMTExMiwxMSBAQCBzdGF0aWMgaW50IGRzaV9y
dW50aW1lX2dldChzdHJ1Y3QgZHNpX2RhdGEgKmRzaSkKPiA+ICAJRFNTREJHKCJkc2lfcnVudGlt
ZV9nZXRcbiIpOwo+ID4gIAo+ID4gIAlyID0gcG1fcnVudGltZV9nZXRfc3luYyhkc2ktPmRldik7
Cj4gPiAtCVdBUk5fT04ociA8IDApOwo+ID4gLQlyZXR1cm4gciA8IDAgPyByIDogMDsKPiA+ICsJ
aWYgKFdBUk5fT04ociA8IDApKSB7Cj4gPiArCQlwbV9ydW50aW1lX3B1dF9ub2lkbGUoZHNpLT5k
ZXYpOwo+ID4gKwkJcmV0dXJuIHI7Cj4gPiArCX0KPiA+ICsJcmV0dXJuIDA7Cj4gPiAgfQo+IAo+
IFRoYW5rcyEgR29vZCBjYXRjaC4gSSB0aGluayB0aGlzIGlzIGJyb2tlbiBpbiBhbGwgdGhlIG90
aGVyIG1vZHVsZXMgaW4gb21hcGRybSB0b28gKGUuZy4gZGlzcGMuYywKPiB2ZW5jLmMsIGV0Yyku
Cj4gCj4gV291bGQgeW91IGxpa2UgdG8gdXBkYXRlIHRoZSBwYXRjaCB0byBjb3ZlciB0aGUgd2hv
bGUgb21hcGRybT8KPiAKClN1cmUuIEkgd2lsbCBmaXggdGhpcyBzb29uLgoKUmVnYXJkcywKRGlu
Z2hhbwo=
