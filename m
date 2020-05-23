Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EA9C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 02:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E411C206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 02:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387554AbgEWCvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 22:51:14 -0400
Received: from spam.zju.edu.cn ([61.164.42.155]:53244 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387490AbgEWCvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 22:51:12 -0400
Received: by ajax-webmail-mail-app4 (Coremail) ; Sat, 23 May 2020 10:51:04
 +0800 (GMT+08:00)
X-Originating-IP: [222.205.77.158]
Date:   Sat, 23 May 2020 10:51:04 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Charles Keepax" <ckeepax@opensource.cirrus.com>
Cc:     kjlu@umn.edu, "MyungJoo Ham" <myungjoo.ham@samsung.com>,
        "Chanwoo Choi" <cw00.choi@samsung.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] extcon: arizona: Fix runtime PM imbalance on error
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190906(84e8bf8f)
 Copyright (c) 2002-2020 www.mailtech.cn zju.edu.cn
In-Reply-To: <20200522165530.GH71940@ediswmail.ad.cirrus.com>
References: <20200522110732.874-1-dinghao.liu@zju.edu.cn>
 <20200522165530.GH71940@ediswmail.ad.cirrus.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <3215e62.c14f3.1723f70eade.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgCnjwqYj8helF4NAg--.41746W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAg4IBlZdtOQvSwALs2
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJTRUUUbX0S07vEb7Iv0x
        C_Cr1lV2xY67kC6x804xWlV2xY67CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DMIAI
        bVAFxVCF77xC64kEw24lV2xY67C26IkvcIIF6IxKo4kEV4ylV2xY628lY4IE4IxF12IF4w
        CS07vE84x0c7CEj48ve4kI8wCS07vE84ACjcxK6xIIjxv20xvE14v26w1j6s0DMIAIbVA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIAIbVA2z4x0Y4vEx4A2jsIE14v26r
        xl6s0DMIAIbVA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lV2xY62AIxVAIcxkEcVAq
        07x20xvEncxIr21lV2xY6c02F40EFcxC0VAKzVAqx4xG6I80ewCS07vEYx0E2Ix0cI8IcV
        AFwI0_Jr0_Jr4lV2xY6cIj6I8E87Iv67AKxVWUJVW8JwCS07vEOx8S6xCaFVCjc4AY6r1j
        6r4UMIAIbVCjxxvEw4WlV2xY6xkIecxEwVAFwVW8JwCS07vEc2IjII80xcxEwVAKI48JMI
        AIbVCF04k20xvE74AGY7Cv6cx26r4fKr1UJr1lV2xY6xCjnVCjjxCrMIAIbVCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwCS07vEx2IqxVAqx4xG67AKxVWUJVWUGwCS07vEx2IqxVCjr7xvwV
        AFwI0_JrI_JrWlV2xY6I8E67AF67kF1VAFwI0_JF0_Jw1lV2xY6IIF0xvE2Ix0cI8IcVAF
        wI0_Jr0_JF4lV2xY6IIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCS07vEIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lV2xY6IIF0xvEx4A2jsIE14v26r1j6r4UMIAIbVCI42IY
        6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBGcmksIE1heSAyMiwgMjAyMCBhdCAwNzowNzozMVBNICswODAwLCBEaW5naGFvIExpdSB3
cm90ZToKPiA+IFdoZW4gYXJpem9uYV9yZXF1ZXN0X2lycSgpIHJldHVybnMgYW4gZXJyb3IgY29k
ZSwgYQo+ID4gcGFpcmluZyBydW50aW1lIFBNIHVzYWdlIGNvdW50ZXIgZGVjcmVtZW50IGlzIG5l
ZWRlZAo+ID4gdG8ga2VlcCB0aGUgY291bnRlciBiYWxhbmNlZC4gRm9yIGVycm9yIHBhdGhzIGFm
dGVyCj4gPiB0aGlzIGZ1bmN0aW9uLCB0aGluZ3MgYXJlIHRoZSBzYW1lLgo+ID4gCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBEaW5naGFvIExpdSA8ZGluZ2hhby5saXVAemp1LmVkdS5jbj4KPiA+IC0tLQo+
IAo+IEdvb2Qgc3BvdCBvbiB0aGUgYnVnIHRoYW5rIHlvdS4KPiAKPiA+ICBkcml2ZXJzL2V4dGNv
bi9leHRjb24tYXJpem9uYS5jIHwgMSArCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2V4dGNvbi9leHRjb24tYXJpem9uYS5j
IGIvZHJpdmVycy9leHRjb24vZXh0Y29uLWFyaXpvbmEuYwo+ID4gaW5kZXggNzQwMTczM2RiMDhi
Li40NzBiYmM4ZTUwODkgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2V4dGNvbi9leHRjb24tYXJp
em9uYS5jCj4gPiArKysgYi9kcml2ZXJzL2V4dGNvbi9leHRjb24tYXJpem9uYS5jCj4gPiBAQCAt
MTc0NCw2ICsxNzQ0LDcgQEAgc3RhdGljIGludCBhcml6b25hX2V4dGNvbl9wcm9iZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQo+ID4gIGVycl9yaXNlOgo+ID4gIAlhcml6b25hX2ZyZWVf
aXJxKGFyaXpvbmEsIGphY2tfaXJxX3Jpc2UsIGluZm8pOwo+ID4gIGVycl9ncGlvOgo+ID4gKwlw
bV9ydW50aW1lX3B1dCgmcGRldi0+ZGV2KTsKPiAKPiBIb3dldmVyLCBJIGRvbid0IHRoaW5rIHRo
aXMgd29ya3MgYXMgYSBmaXguIEZpcnN0bHksIHRoZSBlcnJfZ3Bpbwo+IGxhYmVsIGlzIHVzZWQg
YmVmb3JlIHRoZSBjYWxsIHRvIHBtX3J1bnRpbWVfZ2V0X3N5bmMsIHRoaXMgbWlnaHQKPiBiZSBv
ayBzaW5jZSBwbV9ydW50aW1lX2VuYWJsZSBoYXNuJ3QgYmVlbiBjYWxsZWQgeWV0IGJ1dCBwcm9i
YWJseQo+IGJldHRlciB0byBhZGQgYSBuZXcgbGFiZWwgZm9yIGl0Lgo+IAoKWW91IGFyZSByaWdo
dCwgdGhhbmsgeW91IGZvciB5b3VyIGNvcnJlY3Rpb24hIAoKPiBTZWNvbmRseSwgZm9sbG93aW5n
IHRoZSBlcnJfaHBkZXQgZXJyb3IgcGF0aCB3aWxsIGFsc28gcmVzdWx0IGluCj4gYSBkb3VibGUg
cHV0LiBJbiB0aGF0IGNhc2UgSSBkb24ndCB0aGluayB0aGVyZSBpcyBhbnkgcmVhc29uIHdoeQo+
IHdlIG5lZWQgdG8gcHV0IGJlZm9yZSBjYWxsaW5nIGlucHV0X2RldmljZV9yZWdpc3RlciBzbyBp
dCBtaWdodAo+IGp1c3QgYmUgc2ltcGxlc3QgdG8gbW92ZSB0aGF0IHB1dCB1bnRpbCBhZnRlciBy
ZWdpc3RlcmluZyB0aGUKPiBpbnB1dCBkZXZpY2UuCj4gCgpBZ3JlZS4gSSB3aWxsIGZpeCB0aGlz
IGluIHRoZSBuZXh0IGVkaXRpb24gb2YgcGF0Y2guCgpSZWdhcmRzLApEaW5naGFvCgo+IFRoYW5r
cywKPiBDaGFybGVzCj4gCj4gPiAgCWdwaW9kX3B1dChpbmZvLT5taWNkX3BvbF9ncGlvKTsKPiA+
ICBlcnJfcmVnaXN0ZXI6Cj4gPiAgCXBtX3J1bnRpbWVfZGlzYWJsZSgmcGRldi0+ZGV2KTsKPiA+
IC0tIAo+ID4gMi4xNy4xCj4gPiAK
