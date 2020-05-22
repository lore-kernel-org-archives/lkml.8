Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1835C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 05:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2FDA206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 05:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgEVFWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 01:22:34 -0400
Received: from mail.zju.edu.cn ([61.164.42.155]:23092 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725894AbgEVFWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 01:22:34 -0400
Received: by ajax-webmail-mail-app4 (Coremail) ; Fri, 22 May 2020 13:22:24
 +0800 (GMT+08:00)
X-Originating-IP: [222.205.77.158]
Date:   Fri, 22 May 2020 13:22:24 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     kjlu@umn.edu, "Bin Liu" <b-liu@ti.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] [v2] usb: musb: Fix runtime PM imbalance on error
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190906(84e8bf8f)
 Copyright (c) 2002-2020 www.mailtech.cn zju.edu.cn
In-Reply-To: <20200522051222.GA523130@kroah.com>
References: <20200522025902.11516-1-dinghao.liu@zju.edu.cn>
 <20200522051222.GA523130@kroah.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <2ca9a5fc.be29f.1723ad51c1d.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgBHf3iQYcde6ev7AQ--.39091W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgoIBlZdtOQLzwAAsZ
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJTRUUUbXvS07vEb7Iv0x
        C_Xr1lV2xY67kC6x804xWlV2xY67CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DMIAI
        bVAFxVCF77xC64kEw24lV2xY67C26IkvcIIF6IxKo4kEV4ylV2xY628lY4IE4IxF12IF4w
        CS07vE84x0c7CEj48ve4kI8wCS07vE84ACjcxK6xIIjxv20xvE14v26w1j6s0DMIAIbVA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIAIbVA2z4x0Y4vEx4A2jsIE14v26r
        xl6s0DMIAIbVA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lV2xY62AIxVAIcxkEcVAq
        07x20xvEncxIr21lV2xY6c02F40EFcxC0VAKzVAqx4xG6I80ewCS07vEYx0E2Ix0cI8IcV
        AFwI0_JF0_Jw1lV2xY6cIj6I8E87Iv67AKxVW8JVWxJwCS07vEOx8S6xCaFVCjc4AY6r1j
        6r4UMIAIbVCjxxvEw4WlV2xY6xkIecxEwVAFwVW8WwCS07vEc2IjII80xcxEwVAKI48JMI
        AIbVCF04k20xvE74AGY7Cv6cx26r4fKr1UJr1lV2xY6xCjnVCjjxCrMIAIbVCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwCS07vEx2IqxVAqx4xG67AKxVWUJVWUGwCS07vEx2IqxVCjr7xvwV
        AFwI0_JrI_JrWlV2xY6I8E67AF67kF1VAFwI0_JF0_Jw1lV2xY6IIF0xvE2Ix0cI8IcVAF
        wI0_Jr0_JF4lV2xY6IIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCS07vEIxAIcVCF04
        k26cxKx2IYs7xG6rWUJVWrZr1UMIAIbVCI42IY6I8E87Iv67AKxVWUJVW8JwCS07vEIxAI
        cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUU==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29ycnksIGl0J3MgbXkgY2FyZWxlc3NuZXNzLiBJbiB2MSBJIGFkZGVkIHBtX3J1bnRpbWVfcHV0
X2F1dG9zdXNwZW5kKCkKYWZ0ZXIgY29weV9mcm9tX3VzZXIoKSB0byBmaXggdGhpcyBwcm9ibGVt
LiBTaW5jZSBjb3B5X2Zyb21fdXNlcigpIGlzCm1vdmVkIHRvIHRoZSBiZWdpbm5pbmcgbm93LCB3
ZSBuZWVkIG5vdCB0byBhZGQgUE0gZGVjcmVtZW50LiAKClJlZ2FyZHMsCkRpbmdoYW8KCj4gT24g
RnJpLCBNYXkgMjIsIDIwMjAgYXQgMTA6NTk6MDJBTSArMDgwMCwgRGluZ2hhbyBMaXUgd3JvdGU6
Cj4gPiBXaGVuIGNvcHlfZnJvbV91c2VyKCkgcmV0dXJucyBhbiBlcnJvciBjb2RlLCB0aGVyZQo+
ID4gaXMgYSBydW50aW1lIFBNIHVzYWdlIGNvdW50ZXIgaW1iYWxhbmNlLgo+ID4gCj4gPiBGaXgg
dGhpcyBieSBtb3ZpbmcgY29weV9mcm9tX3VzZXIoKSB0byB0aGUgYmVnaW5uaW5nCj4gPiBvZiB0
aGlzIGZ1bmN0aW9uLgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBEaW5naGFvIExpdSA8ZGluZ2hh
by5saXVAemp1LmVkdS5jbj4KPiA+IC0tLQo+ID4gIGRyaXZlcnMvdXNiL211c2IvbXVzYl9kZWJ1
Z2ZzLmMgfCAxMCArKysrKy0tLS0tCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygr
KSwgNSBkZWxldGlvbnMoLSkKPiAKPiBXaGF0IGNoYW5nZWQgZnJvbSB2MT8gIEFsd2F5cyBzaG93
IHRoYXQgYmVsb3cgdGhlIC0tLSBsaW5lIGFzIHRoZQo+IGRvY3VtZW50YXRpb24gc2F5cyB0by4K
PiAKPiB0aGFua3MsCj4gCj4gZ3JlZyBrLWgK
