Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FD6C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 08:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F20D2074A
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 08:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgEaIwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 04:52:19 -0400
Received: from spam.zju.edu.cn ([61.164.42.155]:7340 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726803AbgEaIwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 04:52:18 -0400
Received: by ajax-webmail-mail-app4 (Coremail) ; Sun, 31 May 2020 16:52:09
 +0800 (GMT+08:00)
X-Originating-IP: [10.192.85.18]
Date:   Sun, 31 May 2020 16:52:09 +0800 (GMT+08:00)
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
In-Reply-To: <74977dc6-7ace-6ef7-4fcd-3f6c89a3eb5f@web.de>
References: <dd729c13-fbc8-22e7-7d8e-e3e126f66943@web.de>
 <40d8fb01.db721.17269d3d620.Coremail.dinghao.liu@zju.edu.cn>
 <74977dc6-7ace-6ef7-4fcd-3f6c89a3eb5f@web.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <286858ff.db7e3.17269ee5f3f.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgC3WeQ5cNNecIxjAA--.9546W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgsRBlZdtOY6yQAAs0
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJTRUUUbL0S07vEb7Iv0x
        C_Cr1lV2xY67kC6x804xWlV2xY67CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DMIAI
        bVAFxVCF77xC64kEw24lV2xY67C26IkvcIIF6IxKo4kEV4ylV2xY628lY4IE4IxF12IF4w
        CS07vE84x0c7CEj48ve4kI8wCS07vE84ACjcxK6xIIjxv20xvE14v26w1j6s0DMIAIbVA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWlV2xY628EF7xvwVC2z280aVAFwI0_Gc
        CE3s1lV2xY628EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wCS07vEe2I262IYc4CY6c8I
        j28IcVAaY2xG8wCS07vE5I8CrVACY4xI64kE6c02F40Ex7xfMIAIbVAv7VC0I7IYx2IY67
        AKxVWUJVWUGwCS07vEYx0Ex4A2jsIE14v26r1j6r4UMIAIbVAm72CE4IkC6x0Yz7v_Jr0_
        Gr1lV2xY6x02cVAKzwCS07vEc2IjII80xcxEwVAKI48JMIAIbVCF04k20xvE74AGY7Cv6c
        x26r4fKr1UJr1lV2xY6xCjnVCjjxCrMIAIbVCFx2IqxVCFs4IE7xkEbVWUJVW8JwCS07vE
        x2IqxVAqx4xG67AKxVWUJVWUGwCS07vEx2IqxVCjr7xvwVAFwI0_JrI_JrWlV2xY6I8E67
        AF67kF1VAFwI0_Jw0_GFylV2xY6IIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lV2xY6IIF0xvE
        2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCS07vEIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr
        1UMIAIbVCI42IY6I8E87Iv67AKxVWUJVW8JwCS07vEIxAIcVC2z280aVCY1x0267AKxVW8
        JVW8JrUvcSsGvfC2KfnxnUU==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAKPiA+IEZvciBzZWN1cml0eSwgSSB3aWxsIHJlbGVhc2UgdGhpcyBwb2ludGVyIG9ubHkgb24g
ZXJyb3IgcGF0aHMgaW4gdGhpcyBmdW5jdGlvbi4KPiAKPiBEbyB5b3UgdGVuZCB0byByZWxlYXNl
IG9iamVjdHMgKHdoaWNoIGFyZSByZWZlcmVuY2VkIGJ5IHBvaW50ZXJzKT8KPiAKCkkganVzdCBm
b3VuZCB0aGF0IGNsayBpcyByZWZlcmVuY2VkIGJ5IHBjbGsgaW4gdGhpcyBmdW5jdGlvbi4gV2hl
biBjbGsgaXMgZnJlZWQsIApwY2xrIHdpbGwgYmUgYWxsb2NhdGVkIGluIGdtMjBiX2Nsa19uZXdf
c3BlZWRvMCgpLiBUaHVzIHdlIHNob3VsZCBub3QgcmVsZWFzZSBjbGsKaW4gdGhpcyBmdW5jdGlv
biBhbmQgdGhlcmUgaXMgbm8gYnVnIGhlcmUuIFRoYW5rIHlvdSBmb3IgcmVtaW5kaW5nIG1lIQoK
UmVnYXJkcywKRGluZ2hhbw==
