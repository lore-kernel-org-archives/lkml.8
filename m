Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C65DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 321D120786
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgHTGgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 02:36:52 -0400
Received: from mail.zju.edu.cn ([61.164.42.155]:41552 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725778AbgHTGgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 02:36:52 -0400
Received: by ajax-webmail-mail-app3 (Coremail) ; Thu, 20 Aug 2020 14:36:35
 +0800 (GMT+08:00)
X-Originating-IP: [10.192.85.18]
Date:   Thu, 20 Aug 2020 14:36:35 +0800 (GMT+08:00)
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
Subject: Re: Re: Re: [PATCH] video: backlight: sky81452-backlight: Fix
 reference count imbalance on error
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.12 build 20200616(0f5d8152)
 Copyright (c) 2002-2020 www.mailtech.cn zju.edu.cn
In-Reply-To: <20200820062301.GD3248864@dell>
References: <321fb03d-2307-7f60-f437-cfb99184dfd6@web.de>
 <20200819165702.GC3248864@dell>
 <217e3c0c.b58c.17409fd7496.Coremail.dinghao.liu@zju.edu.cn>
 <20200820062301.GD3248864@dell>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <3f9fbdb1.bc96.1740a9560d5.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cC_KCgA3Ut7zGT5fQkbuAg--.44418W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgoSBlZdtPnBhAAUsL
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJTRUUUbAvS07vEb7Iv0x
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
        CI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lV2xY6IIF0xvEx4A2jsIE14v26r1j6r4U
        MIAIbVCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73U
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBUaHUsIDIwIEF1ZyAyMDIwLCBkaW5naGFvLmxpdUB6anUuZWR1LmNuIHdyb3RlOgo+IAo+
ID4gPiBPbiBXZWQsIDE5IEF1ZyAyMDIwLCBNYXJrdXMgRWxmcmluZyB3cm90ZToKPiA+ID4gCj4g
PiA+ID4gPiBXaGVuIG9mX3Byb3BlcnR5X3JlYWRfdTMyX2FycmF5KCkgcmV0dXJucyBhbiBlcnJv
ciBjb2RlLAo+ID4gPiA+ID4gYSBwYWlyaW5nIHJlZmNvdW50IGRlY3JlbWVudCBpcyBuZWVkZWQg
dG8ga2VlcCBucCdzIHJlZmNvdW50IGJhbGFuY2VkLgo+ID4gPiA+IAo+ID4gPiA+IENhbiBhbm90
aGVyIGltcGVyYXRpdmUgd29yZGluZyBiZSBoZWxwZnVsIGZvciB0aGUgY2hhbmdlIGRlc2NyaXB0
aW9uPwo+ID4gPiA+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwv
Z2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL0RvY3VtZW50YXRpb24vcHJvY2Vzcy9zdWJtaXR0
aW5nLXBhdGNoZXMucnN0P2lkPTE4NDQ1YmY0MDVjYjMzMTExN2JjOTg0MjdiMWJhNmYxMjQxOGFk
MTcjbjE1MQo+ID4gPiA+IAo+ID4gPiA+IFdvdWxkIGFuIG90aGVyIGNvbW1pdCBtZXNzYWdlIGJl
IGEgYml0IG5pY2VyPwo+ID4gPiA+IAo+ID4gPiA+IAo+ID4gPiA+IOKApgo+ID4gPiA+ID4gKysr
IGIvZHJpdmVycy92aWRlby9iYWNrbGlnaHQvc2t5ODE0NTItYmFja2xpZ2h0LmMKPiA+ID4gPiA+
IEBAIC0yMTcsNiArMjE3LDcgQEAgc3RhdGljIHN0cnVjdCBza3k4MTQ1Ml9ibF9wbGF0Zm9ybV9k
YXRhICpza3k4MTQ1Ml9ibF9wYXJzZV9kdCgKPiA+ID4gPiA+ICAJCQkJCW51bV9lbnRyeSk7Cj4g
PiA+ID4gPiAgCQlpZiAocmV0IDwgMCkgewo+ID4gPiA+ID4gIAkJCWRldl9lcnIoZGV2LCAibGVk
LXNvdXJjZXMgbm9kZSBpcyBpbnZhbGlkLlxuIik7Cj4gPiA+ID4gPiArCQkJb2Zfbm9kZV9wdXQo
bnApOwo+ID4gPiA+ID4gIAkJCXJldHVybiBFUlJfUFRSKC1FSU5WQUwpOwo+ID4gPiA+ID4gIAkJ
fQo+ID4gPiA+IAo+ID4gPiA+IEkgcHJvcG9zZSB0byBhZGQgdGhlIGp1bXAgdGFyZ2V0IOKAnHB1
dF9ub2Rl4oCdIHNvIHRoYXQgYSBiaXQgb2YgY29tbW9uIGV4Y2VwdGlvbgo+ID4gPiA+IGhhbmRs
aW5nIGNvZGUgY2FuIGJlIGJldHRlciByZXVzZWQgYXQgdGhlIGVuZCBvZiB0aGlzIGZ1bmN0aW9u
IGltcGxlbWVudGF0aW9uLgo+ID4gPiA+IAo+ID4gPiA+IFJlZ2FyZHMsCj4gPiA+ID4gTWFya3Vz
Cj4gPiA+IAo+ID4gPiBZb3UgY2FuIHNhZmVseSBpZ25vcmUgYW55IHJldmlldyBjb21tZW50cyBm
cm9tIE1hcmt1cyEKPiA+ID4gCj4gPiA+IEhvd2V2ZXIsIHRoaXMgcGF0Y2ggZG9lc24ndCBhcHBl
YXIgdG8gYmUgaW4gbXkgaW5ib3guCj4gPiA+IAo+ID4gPiBBbnkgaWRlYXMgYXMgdG8gd2h5Pwo+
ID4gPiAKPiA+IAo+ID4gVGhhbmsgeW91IGZvciB5b3VyIGFkdmljZS4gTXkgb3V0Ym94IHNob3dz
IHRoYXQgdGhpcyBwYXRjaAo+ID4gaGFzIHJlYWNoZWQgeW91ciBlbWFpbCBzZXJ2ZXIgc3VjY2Vz
c2Z1bGx5LiBNYXliZSB0aGlzCj4gPiBlbmRlZCB1cCBpbiB5b3VyIGp1bmsgbWFpbCBmaWxlPwo+
IAo+IFRoaXMgaGFzIGhhcHBlbmVkIHJlY2VudGx5LCBzbyBJIHdhcyBzdXJlIHRvIGNoZWNrLgo+
IAo+IE5vdCB0aGVyZSBlaXRoZXIgdW5mb3J0dW5hdGVseS4KPiAKPiBXb3VsZCB5b3UgYmUga2lu
ZCBlbm91Z2ggdG8gYm91bmNlL3Jlc2VuZCBwbGVhc2U/Cj4gCgpTdXJlLgo=
