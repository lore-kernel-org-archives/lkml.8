Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F18C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 03:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7751F2078B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 03:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgHTDvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 23:51:01 -0400
Received: from mail.zju.edu.cn ([61.164.42.155]:30040 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726435AbgHTDvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 23:51:00 -0400
Received: by ajax-webmail-mail-app3 (Coremail) ; Thu, 20 Aug 2020 11:50:39
 +0800 (GMT+08:00)
X-Originating-IP: [10.192.85.18]
Date:   Thu, 20 Aug 2020 11:50:39 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Lee Jones" <lee.jones@linaro.org>
Cc:     "Markus Elfring" <Markus.Elfring@web.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        "Bartlomiej Zolnierkiewicz" <b.zolnierkie@samsung.com>,
        "Bryan Wu" <cooloney@gmail.com>,
        "Daniel Thompson" <daniel.thompson@linaro.org>,
        "Gyungoh Yoo" <jack.yoo@skyworksinc.com>,
        "Jingoo Han" <jingoohan1@gmail.com>, "Kangjie Lu" <kjlu@umn.edu>
Subject: Re: Re: [PATCH] video: backlight: sky81452-backlight: Fix reference
 count imbalance on error
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.12 build 20200616(0f5d8152)
 Copyright (c) 2002-2020 www.mailtech.cn zju.edu.cn
In-Reply-To: <20200819165702.GC3248864@dell>
References: <321fb03d-2307-7f60-f437-cfb99184dfd6@web.de>
 <20200819165702.GC3248864@dell>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <217e3c0c.b58c.17409fd7496.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cC_KCgA3Ut4P8z1fu2TsAg--.44262W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgoSBlZdtPnBhAAAsf
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJTRUUUbAIS07vEb7Iv0x
        C_Cr1lV2xY67kC6x804xWlV2xY67CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DMIAI
        bVAFxVCF77xC64kEw24lV2xY67C26IkvcIIF6IxKo4kEV4ylV2xY628lY4IE4IxF12IF4w
        CS07vE84x0c7CEj48ve4kI8wCS07vE84ACjcxK6xIIjxv20xvE14v26w1j6s0DMIAIbVA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIAIbVA2z4x0Y4vEx4A2jsIE14v26r
        xl6s0DMIAIbVA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lV2xY62AIxVAIcxkEcVAq
        07x20xvEncxIr21lV2xY6c02F40EFcxC0VAKzVAqx4xG6I80ewCS07vEYx0E2Ix0cI8IcV
        AFwI0_Jr0_Jr4lV2xY6cIj6I8E87Iv67AKxVWUJVW8JwCS07vEOx8S6xCaFVCjc4AY6r1j
        6r4UMIAIbVACI402YVCY1x02628vn2kIc2xKxwCS07vE7I0Y64k_MIAIbVCY0x0Ix7I2Y4
        AK64vIr41lV2xY6xAIw28IcVCjz48v1sIEY20_GFWkJr1UJwCS07vE4x8a6x804xWlV2xY
        6xC20s026xCaFVCjc4AY6r1j6r4UMIAIbVC20s026c02F40E14v26r1j6r18MIAIbVC20s
        026x8GjcxK67AKxVWUGVWUWwCS07vEx4CE17CEb7AF67AKxVWUtVW8ZwCS07vEIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCS07vEIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIAIbV
        CI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCS07vEIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        V2xY6IIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBXZWQsIDE5IEF1ZyAyMDIwLCBNYXJrdXMgRWxmcmluZyB3cm90ZToKPiAKPiA+ID4gV2hl
biBvZl9wcm9wZXJ0eV9yZWFkX3UzMl9hcnJheSgpIHJldHVybnMgYW4gZXJyb3IgY29kZSwKPiA+
ID4gYSBwYWlyaW5nIHJlZmNvdW50IGRlY3JlbWVudCBpcyBuZWVkZWQgdG8ga2VlcCBucCdzIHJl
ZmNvdW50IGJhbGFuY2VkLgo+ID4gCj4gPiBDYW4gYW5vdGhlciBpbXBlcmF0aXZlIHdvcmRpbmcg
YmUgaGVscGZ1bCBmb3IgdGhlIGNoYW5nZSBkZXNjcmlwdGlvbj8KPiA+IGh0dHBzOi8vZ2l0Lmtl
cm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVl
L0RvY3VtZW50YXRpb24vcHJvY2Vzcy9zdWJtaXR0aW5nLXBhdGNoZXMucnN0P2lkPTE4NDQ1YmY0
MDVjYjMzMTExN2JjOTg0MjdiMWJhNmYxMjQxOGFkMTcjbjE1MQo+ID4gCj4gPiBXb3VsZCBhbiBv
dGhlciBjb21taXQgbWVzc2FnZSBiZSBhIGJpdCBuaWNlcj8KPiA+IAo+ID4gCj4gPiDigKYKPiA+
ID4gKysrIGIvZHJpdmVycy92aWRlby9iYWNrbGlnaHQvc2t5ODE0NTItYmFja2xpZ2h0LmMKPiA+
ID4gQEAgLTIxNyw2ICsyMTcsNyBAQCBzdGF0aWMgc3RydWN0IHNreTgxNDUyX2JsX3BsYXRmb3Jt
X2RhdGEgKnNreTgxNDUyX2JsX3BhcnNlX2R0KAo+ID4gPiAgCQkJCQludW1fZW50cnkpOwo+ID4g
PiAgCQlpZiAocmV0IDwgMCkgewo+ID4gPiAgCQkJZGV2X2VycihkZXYsICJsZWQtc291cmNlcyBu
b2RlIGlzIGludmFsaWQuXG4iKTsKPiA+ID4gKwkJCW9mX25vZGVfcHV0KG5wKTsKPiA+ID4gIAkJ
CXJldHVybiBFUlJfUFRSKC1FSU5WQUwpOwo+ID4gPiAgCQl9Cj4gPiAKPiA+IEkgcHJvcG9zZSB0
byBhZGQgdGhlIGp1bXAgdGFyZ2V0IOKAnHB1dF9ub2Rl4oCdIHNvIHRoYXQgYSBiaXQgb2YgY29t
bW9uIGV4Y2VwdGlvbgo+ID4gaGFuZGxpbmcgY29kZSBjYW4gYmUgYmV0dGVyIHJldXNlZCBhdCB0
aGUgZW5kIG9mIHRoaXMgZnVuY3Rpb24gaW1wbGVtZW50YXRpb24uCj4gPiAKPiA+IFJlZ2FyZHMs
Cj4gPiBNYXJrdXMKPiAKPiBZb3UgY2FuIHNhZmVseSBpZ25vcmUgYW55IHJldmlldyBjb21tZW50
cyBmcm9tIE1hcmt1cyEKPiAKPiBIb3dldmVyLCB0aGlzIHBhdGNoIGRvZXNuJ3QgYXBwZWFyIHRv
IGJlIGluIG15IGluYm94Lgo+IAo+IEFueSBpZGVhcyBhcyB0byB3aHk/Cj4gCj4gLS0gCj4gTGVl
IEpvbmVzIFvmnY7nkLzmlq9dCj4gU2VuaW9yIFRlY2huaWNhbCBMZWFkIC0gRGV2ZWxvcGVyIFNl
cnZpY2VzCj4gTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFybSBTb0Nz
Cj4gRm9sbG93IExpbmFybzogRmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxvZwoKVGhhbmsgeW91IGZv
ciB5b3VyIGFkdmljZS4gTXkgb3V0Ym94IHNob3dzIHRoYXQgdGhpcyBwYXRjaApoYXMgcmVhY2hl
ZCB5b3VyIGVtYWlsIHNlcnZlciBzdWNjZXNzZnVsbHkuIE1heWJlIHRoaXMKZW5kZWQgdXAgaW4g
eW91ciBqdW5rIG1haWwgZmlsZT8KClJlZ2FyZHMsCkRpbmdoYW8=
