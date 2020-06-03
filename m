Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8672C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 02:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE098207D5
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 02:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgFCCWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 22:22:08 -0400
Received: from mail.zju.edu.cn ([61.164.42.155]:60592 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725789AbgFCCWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 22:22:07 -0400
Received: by ajax-webmail-mail-app2 (Coremail) ; Wed, 3 Jun 2020 10:21:47
 +0800 (GMT+08:00)
X-Originating-IP: [222.205.72.4]
Date:   Wed, 3 Jun 2020 10:21:47 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Dan Carpenter" <dan.carpenter@oracle.com>
Cc:     "Markus Elfring" <Markus.Elfring@web.de>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Ben Skeggs" <bskeggs@redhat.com>,
        "David Airlie" <airlied@linux.ie>, "Kangjie Lu" <kjlu@umn.edu>
Subject: Re: Re: [PATCH] drm/nouveau/clk/gm20b: Fix memory leak in
 gm20b_clk_new()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190906(84e8bf8f)
 Copyright (c) 2002-2020 www.mailtech.cn zju.edu.cn
In-Reply-To: <20200602153900.GW22511@kadam>
References: <dd729c13-fbc8-22e7-7d8e-e3e126f66943@web.de>
 <40d8fb01.db721.17269d3d620.Coremail.dinghao.liu@zju.edu.cn>
 <20200602102955.GZ30374@kadam>
 <65e3d2b7-b0ad-f387-b8fe-d83ea816a0f6@web.de>
 <20200602153900.GW22511@kadam>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <5d580094.f274c.17277fc124e.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgDnX5c8Cddeg0ppAA--.16819W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgkABlZdtOb8QgABsr
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJTRUUUbGvS07vEb7Iv0x
        C_Cr1lV2xY67kC6x804xWlV2xY67CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DMIAI
        bVAFxVCF77xC64kEw24lV2xY67C26IkvcIIF6IxKo4kEV4ylV2xY628lY4IE4IxF12IF4w
        CS07vE84x0c7CEj48ve4kI8wCS07vE84ACjcxK6xIIjxv20xvE14v26w1j6s0DMIAIbVA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW0oVCq3wCS07vE84ACjcxK6I8E87Iv67AKxVW0oV
        Cq3wCS07vE84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DMIAIbVAS0I0E0xvYzxvE52x0
        82IY62kv0487MIAIbVAqx4xG64xvF2IEw4CE5I8CrVC2j2WlV2xY6cIj6xIIjxv20xvE14
        v26r1j6r18MIAIbVAv7VC2z280aVAFwI0_Jr0_Gr1lV2xY6cvjeVCFs4IE7xkEbVWUJVW8
        JwCS07vE7I0Y64k_MIAIbVCY02Avz4vE14v_Gr1lV2xY6xkI7II2jI8vz4vEwIxGrwCS07
        vE42xK82IY6x8ErcxFaVAv8VW8uw4UJr1UMIAIbVCF72vE77IF4wCS07vE4I8I3I0E4IkC
        6x0Yz7v_Jr0_Gr1lV2xY6I8I3I0E5I8CrVAFwI0_Jr0_Jr4lV2xY6I8I3I0E7480Y4vE14
        v26r106r1rMIAIbVC2zVAF1VAY17CE14v26r1q6r43MIAIbVCI42IY6xIIjxv20xvE14v2
        6r1j6r1xMIAIbVCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lV2xY6IIF0xvE42xK8V
        AvwI8IcIk0rVWrZr1j6s0DMIAIbVCI42IY6I8E87Iv67AKxVWUJVW8JwCS07vEIxAIcVC2
        z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73U
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj4gT24gVHVlLCBKdW4gMDIsIDIwMjAgYXQgMDE6MTA6MzRQTSArMDIwMCwgTWFya3VzIEVsZnJp
bmcgd3JvdGU6Cj4gPiA+IFRoZSBvcmlnaW5hbCBwYXRjaCB3YXMgYmFzaWNhbGx5IGZpbmUuCj4g
PiAKPiA+IEkgcHJvcG9zZSB0byByZWNvbnNpZGVyIHRoZSBpbnRlcnByZXRhdGlvbiBvZiB0aGUg
c29mdHdhcmUgc2l0dWF0aW9uIG9uY2UgbW9yZS4KPiA+IAo+ID4gKiBTaG91bGQgdGhlIGFsbG9j
YXRlZCBjbG9jayBvYmplY3QgYmUga2VwdCB1c2FibGUgZXZlbiBhZnRlcgo+ID4gICBhIHN1Y2Nl
c3NmdWwgcmV0dXJuIGZyb20gdGhpcyBmdW5jdGlvbj8KPiAKPiBIZWguICBZb3UncmUgcmlnaHQu
ICBUaGUgcGF0Y2ggaXMgZnJlZWluZyAiY2xrIiBvbiB0aGUgc3VjY2VzcyBwYXRoIHNvCj4gdGhh
dCBkb2Vzbid0IHdvcmsuCj4gCgpCZW4gaGFzIGV4cGxhaW5lZCB0aGlzIHByb2JsZW06Cmh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL3BhdGNod29yay9wYXRjaC8xMjQ5NTkyLwpTaW5jZSB0aGUgY2Fs
bGVyIHdpbGwgY2hlY2sgInBjbGsiIG9uIGZhaWx1cmUsIHdlIGRvbid0IG5lZWQgdG8gZnJlZQoi
Y2xrIiBpbiBnbTIwYl9jbGtfbmV3KCkgYW5kIEkgdGhpbmsgdGhpcyBwYXRjaCBpcyBubyBsb25n
ZXIgbmVlZGVkLgoKUmVnYXJkcywKRGluZ2hhbw==
