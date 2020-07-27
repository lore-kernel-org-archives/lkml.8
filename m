Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCD9C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51B2620719
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbgG0OqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:46:06 -0400
Received: from mail.zju.edu.cn ([61.164.42.155]:16454 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728536AbgG0OqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:46:05 -0400
Received: by ajax-webmail-mail-app4 (Coremail) ; Mon, 27 Jul 2020 22:45:24
 +0800 (GMT+08:00)
X-Originating-IP: [210.32.144.186]
Date:   Mon, 27 Jul 2020 22:45:24 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Dan Carpenter" <dan.carpenter@oracle.com>
Cc:     devel@driverdev.osuosl.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, kjlu@umn.edu,
        linux-kernel@vger.kernel.org,
        "Julia Lawall" <julia.lawall@inria.fr>,
        "Stefano Brivio" <sbrivio@redhat.com>,
        "Shreeya Patel" <shreeya.patel23498@gmail.com>,
        "Larry Finger" <Larry.Finger@lwfinger.net>
Subject: Re: Re: [PATCH] Staging: rtl8188eu: rtw_mlme: Fix uninitialized
 variable authmode
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190906(84e8bf8f)
 Copyright (c) 2002-2020 www.mailtech.cn zju.edu.cn
In-Reply-To: <20200727132351.GF1913@kadam>
References: <20200724122957.30411-1-dinghao.liu@zju.edu.cn>
 <20200727114451.GA1913@kadam> <20200727132351.GF1913@kadam>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <37fe50b0.13978.17390bc440f.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgD3__+E6B5fh0ZfAA--.11823W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAggHBlZdtPRcawAjsU
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJTRUUUbGCS07vEb7Iv0x
        C_Cr1lV2xY67kC6x804xWlV2xY67CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DMIAI
        bVAFxVCF77xC64kEw24lV2xY67C26IkvcIIF6IxKo4kEV4ylV2xY628lY4IE4IxF12IF4w
        CS07vE84x0c7CEj48ve4kI8wCS07vE84ACjcxK6xIIjxv20xvE14v26w1j6s0DMIAIbVA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW0oVCq3wCS07vE84ACjcxK6I8E87Iv67AKxVW0oV
        Cq3wCS07vE84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DMIAIbVAS0I0E0xvYzxvE52x0
        82IY62kv0487MIAIbVAqx4xG64xvF2IEw4CE5I8CrVC2j2WlV2xY6cIj6xIIjxv20xvE14
        v26r1j6r18MIAIbVAv7VC2z280aVAFwI0_Jr0_Gr1lV2xY6cvjeVCFs4IE7xkEbVWUJVW8
        JwCS07vE7I0Y64k_MIAIbVCY02Avz4vE14v_XrylV2xY6xkI7II2jI8vz4vEwIxGrwCS07
        vE42xK82IY6x8ErcxFaVAv8VW8uw4UJr1UMIAIbVCF72vE77IF4wCS07vE4I8I3I0E4IkC
        6x0Yz7v_Jr0_Gr1lV2xY6I8I3I0E5I8CrVAFwI0_Jr0_Jr4lV2xY6I8I3I0E7480Y4vE14
        v26r106r1rMIAIbVC2zVAF1VAY17CE14v26r1q6r43MIAIbVCI42IY6xIIjxv20xvE14v2
        6r1j6r1xMIAIbVCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lV2xY6IIF0xvE42xK8V
        AvwI8IcIk0rVWrZr1j6s0DMIAIbVCI42IY6I8E87Iv67AKxVWUJVW8JwCS07vEIxAIcVC2
        z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUU==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBJIHJldmlldyB0aGluZ3MgaW4gdGhlIG9yZGVyIHRoYXQgdGhleSBhcHBlYXIgaW4gbXkgaW5i
b3ggc28gSSBoYWRuJ3QKPiBzZWVuIEdyZWcgYW5kIExhcnJ5J3MgY29tbWVudHMuICBZb3UndmUg
bm93IHN0dW1ibGVkIGludG8gYW4gYXJlYSBvZgo+IHBvbGl0aWNzIHdoZXJlIHlvdSBoYXZlIGNv
bmZsaWN0aW5nIHJldmlld3MuLi4gIDpQICBGb3J0dW5hdGVseSwgd2UncmUKPiBhbGwgb2YgdXMg
cmVhc29uYWJsZSBwZW9wbGUuCj4gCj4gSSB0aGluayB5b3VyIHBhdGNoIGlzIGNvcnJlY3QgaW4g
dGhhdCBpdCBpcyB3aGF0IHRoZSBvcmlnaW5hbCBjb2Rlcgo+IGludGVuZGVkLiAgWW91IGp1c3Qg
bmVlZCB0byBzZWxsIHRoZSBwYXRjaCBjb3JyZWN0bHkgaW4gdGhlIGNvbW1pdAo+IG1lc3NhZ2Uu
ICBUaGUgcmVhbCBkYW5nZXIgb2YgdGhlIG9yaWdpbmFsIGNvZGUgd291bGQgYmUgaWYgImF1dGht
b2RlIiBpcwo+IGFjY2lkZW50YWxseSAweDMwIG9yIDB4ZGQganVzdCBiZWNhdXNlIGl0IHdhcyB1
bmluaXRpYWxpemVkLiAgU2V0dGluZyBpdAo+IHRvIHplcm8gZW5zdXJlcyB0aGF0IGl0IGlzIG5v
dCBhbmQgaXQgYWxzbyBtYXRjaGVzIGhvdyB0aGlzIGlzIGhhbmRsZWQKPiBpbiB0aGUgcnRsODcy
M2JzIGRyaXZlci4gIFRoaXMgbWF0Y2hlcyB0aGUgb3JpZ2luYWwgYXV0aG9yJ3MgaW50ZW50aW9u
Lgo+IAo+IFNvOgo+IAo+IDEpIFJlLXdyaXRlIHRoZSBjb21taXQgbWVzc2FnZS4KPiAKPiAgICAg
VGhlIHZhcmlhYmxlIGF1dGhtb2RlIGNhbiBiZSB1bmluaXRpYWxpemVkLiAgVGhlIGRhbmdlciB3
b3VsZCBiZQo+ICAgICBpZiBpdCBlcXVhbHMgX1dQQV9JRV9JRF8gKDB4ZGQpIG9yIF9XUEEyX0lF
X0lEXyAoMHgzMykuICBXZSBjYW4KPiAgICAgYXZvaWQgdGhpcyBieSBzZXR0aW5nIGl0IHRvIHpl
cm8gaW5zdGVhZC4gIFRoaXMgaXMgdGhlIGFwcHJvYWNoIHRoYXQKPiAgICAgd2FzIHVzZWQgaW4g
dGhlIHJ0bDg3MjNicyBkcml2ZXIuCj4gCj4gMikgQWRkIGEgZml4ZXMgdGFnLgo+ICAgIEZpeGVz
OiA3YjQ2NGM5ZmE1Y2MgKCJzdGFnaW5nOiByODE4OGV1OiBBZGQgZmlsZXMgZm9yIG5ldyBkcml2
ZXIgLSBwYXJ0IDQiKQo+IAo+IDMpIENoYW5nZSB0aGUgY29tbWl0IHRvIExhcnJ5J3Mgc3R5bGUg
d2l0aCB0aGUgImVsc2UgaWYiIGFuZCAiZWxzZSIuCj4gICAgU29tZXRpbWVzIHBlb3BsZSBqdXN0
IGRpc2FncmVlIGFib3V0IHN0eWxlIHNvIGl0J3MgZWFzaWVzdCB0byBnbyB3aXRoCj4gICAgd2hh
dGV2ZXIgdGhlIG1haW50YWluZXIgKExhcnJ5KSB3YW50cy4gIEl0J3Mgbm90IHdvcnRoIGRlYmF0
aW5nIG9uZQo+ICAgIHdheSBvciB0aGUgb3RoZXIgc28ganVzdCByZWRvIGl0Lgo+IAo+IFRoZW4g
cmVzZW5kLiAgR29vZ2xlIGZvciAiaG93IHRvIHNlbmQgYSB2MiBwYXRjaCIgdG8gZ2V0IHRoZSBy
aWdodAo+IGZvcm1hdC4KPiAKPiByZWdhcmRzLAo+IGRhbiBjYXJwZW50ZXIKPiAKCllvdXIgYWR2
aWNlIGlzIHZlcnkgaGVscGZ1bCB0byBtZSwgdGhhbmtzISBJIHdpbGwgcHJlcGFyZSB2MiBwYXRj
aCBhbmQKcmVzZW5kIGl0IHNvb24uCgpSZWdhcmRzLApEaW5naGFvCgo=
