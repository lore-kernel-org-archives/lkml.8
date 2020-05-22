Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F26EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 01:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40E11207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 01:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgEVBXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 21:23:10 -0400
Received: from mail.zju.edu.cn ([61.164.42.155]:56050 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726335AbgEVBXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 21:23:10 -0400
Received: by ajax-webmail-mail-app4 (Coremail) ; Fri, 22 May 2020 09:23:01
 +0800 (GMT+08:00)
X-Originating-IP: [222.205.77.158]
Date:   Fri, 22 May 2020 09:23:01 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Bin Liu" <b-liu@ti.com>
Cc:     kjlu@umn.edu, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] usb: musb: Fix runtime PM imbalance on error
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190906(84e8bf8f)
 Copyright (c) 2002-2020 www.mailtech.cn zju.edu.cn
In-Reply-To: <20200521203728.GB25575@iaqt7>
References: <20200521073547.18828-1-dinghao.liu@zju.edu.cn>
 <20200521203728.GB25575@iaqt7>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <52fdeb8d.bcf65.17239f9f3a8.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgCXPxx1Kcde2n_4AQ--.31233W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAg0IBlZdtOP4JAABsA
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJTRUUUbX0S07vEb7Iv0x
        C_Cr1lV2xY67kC6x804xWlV2xY67CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DMIAI
        bVAFxVCF77xC64kEw24lV2xY67C26IkvcIIF6IxKo4kEV4ylV2xY628lY4IE4IxF12IF4w
        CS07vE84x0c7CEj48ve4kI8wCS07vE84ACjcxK6xIIjxv20xvE14v26w1j6s0DMIAIbVA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWlV2xY628EF7xvwVC2z280aVAFwI0_Gc
        CE3s1lV2xY628EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wCS07vEe2I262IYc4CY6c8I
        j28IcVAaY2xG8wCS07vE5I8CrVACY4xI64kE6c02F40Ex7xfMIAIbVAv7VC0I7IYx2IY67
        AKxVWUGVWUXwCS07vEYx0Ex4A2jsIE14v26r1j6r4UMIAIbVAm72CE4IkC6x0Yz7v_Jr0_
        Gr1lV2xY6x02cVAKzwCS07vEc2xSY4AK67AK6w4lV2xY6xkI7II2jI8vz4vEwIxGrwCS07
        vE42xK82IY6x8ErcxFaVAv8VW8uw4UJr1UMIAIbVCF72vE77IF4wCS07vE4I8I3I0E4IkC
        6x0Yz7v_Jr0_Gr1lV2xY6I8I3I0E5I8CrVAFwI0_Jr0_Jr4lV2xY6I8I3I0E7480Y4vE14
        v26r106r1rMIAIbVC2zVAF1VAY17CE14v26r126r1DMIAIbVCI42IY6xIIjxv20xvE14v2
        6r1j6r1xMIAIbVCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lV2xY6IIF0xvE42xK8V
        AvwI8IcIk0rVWrJr0_WFyUJwCS07vEIxAIcVC2z280aVAFwI0_Jr0_Gr1lV2xY6IIF0xvE
        x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U3VyZS4KClJlZ2FyZHMsCkRpbmdoYW8KCj4gSGksCj4gCj4gT24gVGh1LCBNYXkgMjEsIDIwMjAg
YXQgMDM6MzU6NDdQTSArMDgwMCwgRGluZ2hhbyBMaXUgd3JvdGU6Cj4gPiBXaGVuIGNvcHlfZnJv
bV91c2VyKCkgcmV0dXJucyBhbiBlcnJvciBjb2RlLCBhIHBhaXJpbmcKPiA+IHJ1bnRpbWUgUE0g
dXNhZ2UgY291bnRlciBkZWNyZW1lbnQgaXMgbmVlZGVkIHRvIGtlZXAKPiA+IHRoZSBjb3VudGVy
IGJhbGFuY2VkLgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBEaW5naGFvIExpdSA8ZGluZ2hhby5s
aXVAemp1LmVkdS5jbj4KPiA+IC0tLQo+ID4gIGRyaXZlcnMvdXNiL211c2IvbXVzYl9kZWJ1Z2Zz
LmMgfCA1ICsrKystCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvbXVzYi9tdXNiX2RlYnVn
ZnMuYyBiL2RyaXZlcnMvdXNiL211c2IvbXVzYl9kZWJ1Z2ZzLmMKPiA+IGluZGV4IDdiNjI4MWFi
NjJlZC4uODM3YzM4YTVlNGVmIDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy91c2IvbXVzYi9tdXNi
X2RlYnVnZnMuYwo+ID4gKysrIGIvZHJpdmVycy91c2IvbXVzYi9tdXNiX2RlYnVnZnMuYwo+ID4g
QEAgLTE3OCw4ICsxNzgsMTEgQEAgc3RhdGljIHNzaXplX3QgbXVzYl90ZXN0X21vZGVfd3JpdGUo
c3RydWN0IGZpbGUgKmZpbGUsCj4gPiAgCj4gPiAgCW1lbXNldChidWYsIDB4MDAsIHNpemVvZihi
dWYpKTsKPiA+ICAKPiA+IC0JaWYgKGNvcHlfZnJvbV91c2VyKGJ1ZiwgdWJ1ZiwgbWluX3Qoc2l6
ZV90LCBzaXplb2YoYnVmKSAtIDEsIGNvdW50KSkpCj4gPiArCWlmIChjb3B5X2Zyb21fdXNlcihi
dWYsIHVidWYsIG1pbl90KHNpemVfdCwgc2l6ZW9mKGJ1ZikgLSAxLCBjb3VudCkpKSB7Cj4gPiAr
CQlwbV9ydW50aW1lX21hcmtfbGFzdF9idXN5KG11c2ItPmNvbnRyb2xsZXIpOwo+ID4gKwkJcG1f
cnVudGltZV9wdXRfYXV0b3N1c3BlbmQobXVzYi0+Y29udHJvbGxlcik7Cj4gPiAgCQlyZXR1cm4g
LUVGQVVMVDsKPiA+ICsJfQo+IAo+IFRoYW5rcyBmb3IgY2F0Y2hpbmcgdGhlIGJ1Zy4gQ2FuIHlv
dSBwbGVhc2UgaW5zdGVhZCBtb3ZlIHRoZXNlIGxpbmVzIHRvCj4gdGhlIGJlZ2lubmluZyBvZiB0
aGlzIGZ1bmN0aW9uIHNvIHRoYXQgcG1fcnVudGltZV9nZXRfc3luYygpIGlzIG5vdAo+IGNhbGxl
ZCBpZiBjb3B5X2Zyb21fdXNlcigpIGZhaWxlZD8KPiAKPiAtQmluLgo=
