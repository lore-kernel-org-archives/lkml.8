Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A41C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 06:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88BCA2078B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 06:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgHMGjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 02:39:51 -0400
Received: from spam.zju.edu.cn ([61.164.42.155]:12296 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725964AbgHMGjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 02:39:49 -0400
Received: by ajax-webmail-mail-app2 (Coremail) ; Thu, 13 Aug 2020 14:39:19
 +0800 (GMT+08:00)
X-Originating-IP: [10.192.85.18]
Date:   Thu, 13 Aug 2020 14:39:19 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Takashi Iwai" <tiwai@suse.de>
Cc:     kjlu@umn.edu, "Jaroslav Kysela" <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>,
        "Eliot Blennerhassett" <eblennerhassett@audioscience.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] ALSA: pci/asihpi: Fix memory leak in
 snd_card_asihpi_capture_open()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190906(84e8bf8f)
 Copyright (c) 2002-2020 www.mailtech.cn zju.edu.cn
In-Reply-To: <s5h5z9r6l8e.wl-tiwai@suse.de>
References: <20200810063957.13692-1-dinghao.liu@zju.edu.cn>
 <s5h5z9r6l8e.wl-tiwai@suse.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <77ed04d7.569ba.173e68b5d88.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgBnEJ4X4DRfsRnOAQ--.39889W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgMKBlZdtPhtIQADsF
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJTRUUUblIS07vEb7Iv0x
        C_JF4lV2xY67kC6x804xWlV2xY67CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DMIAI
        bVAFxVCF77xC64kEw24lV2xY67C26IkvcIIF6IxKo4kEV4ylV2xY628lY4IE4IxF12IF4w
        CS07vE84x0c7CEj48ve4kI8wCS07vE84ACjcxK6xIIjxv20xvE14v26w1j6s0DMIAIbVA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW0oVCq3wCS07vE84ACjcxK6I8E87Iv67AKxVW0oV
        Cq3wCS07vE84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DMIAIbVAS0I0E0xvYzxvE52x0
        82IY62kv0487MIAIbVAqx4xG64xvF2IEw4CE5I8CrVC2j2WlV2xY6cIj6xIIjxv20xvE14
        v26r1j6r18MIAIbVAv7VC2z280aVAFwI0_Jr0_Gr1lV2xY6cvjeVCFs4IE7xkEbVWUJVW8
        JwCS07vE7I0Y64k_MIAIbVCY0x0Ix7I2Y4AK64vIr41lV2xY6xAIw28IcVCjz48v1sIEY2
        0_GFWkJr1UJwCS07vE4x8a6x804xWlV2xY6xC20s026xCaFVCjc4AY6r1j6r4UMIAIbVC2
        0s026c02F40E14v26r1j6r18MIAIbVC20s026x8GjcxK67AKxVWUGVWUWwCS07vEx4CE17
        CEb7AF67AKxVWUtVW8ZwCS07vEIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCS07vEIxAIcVC0
        I7IYx2IY6xkF7I0E14v26r1j6r4UMIAIbVCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3w
        CS07vEIxAIcVC2z280aVAFwI0_Jr0_Gr1lV2xY6IIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_
        GrUvcSsGvfC2KfnxnUU==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBNb24sIDEwIEF1ZyAyMDIwIDA4OjM5OjU1ICswMjAwLAo+IERpbmdoYW8gTGl1IHdyb3Rl
Ogo+ID4gCj4gPiBXaGVuIHNuZF9wY21faHdfY29uc3RyYWludF9wb3cyKCkgZmFpbHMsIGRwY20g
c2hvdWxkIGJlIGZyZWVkCj4gPiBqdXN0IGxpa2Ugd2hlbiBocGlfaW5zdHJlYW1fb3BlbigpICBm
YWlscy4KPiAKPiBJdCB3aWxsIGJlIGNsZWFuZWQgdXAgdmlhIHJ1bnRpbWUtPnByaXZhdGVfZnJl
ZSBjYWxsIGluIHRoZSBjYWxsZXIKPiBzaWRlIChzbmRfcGNtX29wZW4gLT4gc25kX3BjbV9yZWxl
YXNlX3N1YnN0cmVhbSAtPgo+IHNuZF9wY21fZGV0YWNoX3N1YnN0cmVhbSksIGhlbmNlIHRoaXMg
d291bGQgcmVzdWx0IGluIGRvdWJsZS1mcmVlLgo+IAoKSXQncyBjbGVhciB0byBtZSwgdGhhbmtz
IQoKUmVnYXJkcywKRGluZ2hhbw==
