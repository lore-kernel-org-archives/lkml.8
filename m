Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87F9C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 09:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE4282073B
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 09:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgEaJPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 05:15:40 -0400
Received: from spam.zju.edu.cn ([61.164.42.155]:8724 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725813AbgEaJPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 05:15:39 -0400
Received: by ajax-webmail-mail-app4 (Coremail) ; Sun, 31 May 2020 17:15:27
 +0800 (GMT+08:00)
X-Originating-IP: [10.192.85.18]
Date:   Sun, 31 May 2020 17:15:27 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Markus Elfring" <Markus.Elfring@web.de>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Ben Skeggs" <bskeggs@redhat.com>,
        "David Airlie" <airlied@linux.ie>, "Kangjie Lu" <kjlu@umn.edu>
Subject: Re: Re: drm/nouveau/clk/gm20b: Fix memory leak in gm20b_clk_new()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190906(84e8bf8f)
 Copyright (c) 2002-2020 www.mailtech.cn zju.edu.cn
In-Reply-To: <5a073b2b-5102-adec-84dd-b62dc48c7451@web.de>
References: <dd729c13-fbc8-22e7-7d8e-e3e126f66943@web.de>
 <40d8fb01.db721.17269d3d620.Coremail.dinghao.liu@zju.edu.cn>
 <74977dc6-7ace-6ef7-4fcd-3f6c89a3eb5f@web.de>
 <286858ff.db7e3.17269ee5f3f.Coremail.dinghao.liu@zju.edu.cn>
 <5a073b2b-5102-adec-84dd-b62dc48c7451@web.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <1c5b64dc.db888.1726a03b710.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgC3WeSvddNeYbtjAA--.9579W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAggRBlZdtOY77QABsT
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJTRUUUbLIS07vEb7Iv0x
        C_Cr1lV2xY67kC6x804xWlV2xY67CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DMIAI
        bVAFxVCF77xC64kEw24lV2xY67C26IkvcIIF6IxKo4kEV4ylV2xY628lY4IE4IxF12IF4w
        CS07vE84x0c7CEj48ve4kI8wCS07vE84ACjcxK6xIIjxv20xvE14v26w1j6s0DMIAIbVA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIAIbVA2z4x0Y4vEx4A2jsIE14v26r
        xl6s0DMIAIbVA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lV2xY62AIxVAIcxkEcVAq
        07x20xvEncxIr21lV2xY6c02F40EFcxC0VAKzVAqx4xG6I80ewCS07vEYx0E2Ix0cI8IcV
        AFwI0_Jr0_Jr4lV2xY6cIj6I8E87Iv67AKxVWUJVW8JwCS07vEOx8S6xCaFVCjc4AY6r1j
        6r4UMIAIbVCjxxvEw4WlV2xY6xkI7II2jI8vz4vEwIxGrwCS07vE42xK82IY6x8ErcxFaV
        Av8VW8uw4UJr1UMIAIbVCF72vE77IF4wCS07vE4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lV2xY
        6I8I3I0E5I8CrVAFwI0_Jr0_Jr4lV2xY6I8I3I0E7480Y4vE14v26r106r1rMIAIbVC2zV
        AF1VAY17CE14v26r1q6r43MIAIbVCI42IY6xIIjxv20xvE14v26r1j6r1xMIAIbVCI42IY
        6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lV2xY6IIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WF
        yUJwCS07vEIxAIcVC2z280aVAFwI0_Jr0_Gr1lV2xY6IIF0xvEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UYxBIdaVFxhVjvjDU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IEkganVzdCBmb3VuZCB0aGF0IGNsayBpcyByZWZlcmVuY2VkIGJ5IHBjbGsgaW4gdGhpcyBm
dW5jdGlvbi4gV2hlbiBjbGsgaXMgZnJlZWQsCj4gPiBwY2xrIHdpbGwgYmUgYWxsb2NhdGVkIGlu
IGdtMjBiX2Nsa19uZXdfc3BlZWRvMCgpLiBUaHVzIHdlIHNob3VsZCBub3QgcmVsZWFzZSBjbGsK
PiA+IGluIHRoaXMgZnVuY3Rpb24gYW5kIHRoZXJlIGlzIG5vIGJ1ZyBoZXJlLgo+IAo+IENhbiB0
aGVyZSBiZSBhIG5lZWQgdG8gcmVsZWFzZSBhIGNsb2NrIG9iamVjdCBhZnRlciBhIGZhaWxlZCBn
azIwYV9jbGtfY3RvcigpIGNhbGw/Cj4gCgpJIHRoaW5rIHRoaXMgbWFpbmx5IGRlcGVuZHMgb24g
cGNsayBwb2ludGVyLiBJdCBzZWVtcyB0aGF0IHRoZSBjYWxsZXIgb2YgCmdtMjBiX2Nsa19uZXco
KSBhbHdheXMgZXhwZWN0cyBwY2xrIHRvIGJlIGFsbG9jYXRlZCB1bmxlc3MgaXQgcmV0dXJucyAt
RU5PTUVNLAp3aGljaCBtZWFucyBremFsbG9jKCkgZmFpbGVkLiBJZiBnazIwYV9jbGtfY3Rvcigp
IG5ldmVyIHJldHVybnMgc3VjaCBhbiBlcnJvciAKY29kZSwgd2UgbWF5IG5lZWQgbm90IHRvIHJl
bGVhc2UgdGhpcyBjbG9jayBvYmplY3QuCgpSZWdhcmRzLApEaW5naGFv
