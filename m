Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2245DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 06:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0862D2078B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 06:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgHMGpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 02:45:01 -0400
Received: from mail.zju.edu.cn ([61.164.42.155]:12876 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725960AbgHMGpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 02:45:00 -0400
Received: by ajax-webmail-mail-app2 (Coremail) ; Thu, 13 Aug 2020 14:44:05
 +0800 (GMT+08:00)
X-Originating-IP: [10.192.85.18]
Date:   Thu, 13 Aug 2020 14:44:05 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Takashi Iwai" <tiwai@suse.de>
Cc:     kjlu@umn.edu, "Jaroslav Kysela" <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>, "Mark Hills" <mark@xwax.org>,
        "Dan Carpenter" <dan.carpenter@oracle.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>,
        "Takashi Sakamoto" <o-takashi@sakamocchi.jp>,
        "Giuliano Pochini" <pochini@shiny.it>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] ALSA: echoaudio: Fix memory leak in
 snd_echo_resume()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190906(84e8bf8f)
 Copyright (c) 2002-2020 www.mailtech.cn zju.edu.cn
In-Reply-To: <s5h7du76lew.wl-tiwai@suse.de>
References: <20200810061500.9329-1-dinghao.liu@zju.edu.cn>
 <s5h7du76lew.wl-tiwai@suse.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <cdb962d.569f9.173e68fb9e9.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgAn0J014TRfJyDOAQ--.37912W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgULBlZdtPicfgABsu
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJTRUUUbWvS07vEb7Iv0x
        C_Cr1lV2xY67kC6x804xWlV2xY67CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DMIAI
        bVAFxVCF77xC64kEw24lV2xY67C26IkvcIIF6IxKo4kEV4ylV2xY628lY4IE4IxF12IF4w
        CS07vE84x0c7CEj48ve4kI8wCS07vE84ACjcxK6xIIjxv20xvE14v26w1j6s0DMIAIbVA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW0oVCq3wCS07vE84ACjcxK6I8E87Iv67AKxVW0oV
        Cq3wCS07vE84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DMIAIbVAS0I0E0xvYzxvE52x0
        82IY62kv0487MIAIbVAqx4xG64xvF2IEw4CE5I8CrVC2j2WlV2xY6cIj6xIIjxv20xvE14
        v26r106r15MIAIbVAv7VC2z280aVAFwI0_Jr0_Gr1lV2xY6cvjeVCFs4IE7xkEbVWUJVW8
        JwCS07vEFIxGxcIEc7CjxVA2Y2ka0xkIwI1lV2xY6x02cVAKzwCS07vEc2IjII80xcxEwV
        AKI48JMIAIbVCF04k20xvE74AGY7Cv6cx26r4fKr1UJr1lV2xY6xCjnVCjjxCrMIAIbVCF
        x2IqxVCFs4IE7xkEbVWUJVW8JwCS07vEx2IqxVAqx4xG67AKxVWUJVWUGwCS07vEx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlV2xY6I8E67AF67kF1VAFwI0_Jw0_GFylV2xY6IIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lV2xY6IIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCS07vEIx
        AIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCS07vEIxAIcVC2z280aVAFwI0_Jr0_Gr1lV2xY
        6IIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj4gT24gTW9uLCAxMCBBdWcgMjAyMCAwODoxNDo1OCArMDIwMCwKPiBEaW5naGFvIExpdSB3cm90
ZToKPiA+IAo+ID4gV2hlbiByZXN0b3JlX2RzcF9yZXR0aW5ncygpIGZhaWxzLCBjaGlwIHNob3Vs
ZCBiZSBmcmVlZAo+ID4ganVzdCBsaWtlIHdoZW4gaW5pdF9odygpIGFuZCByZXF1ZXN0X2lycSgp
IGZhaWxzLgo+ID4gCj4gPiBGaXhlczogNDdiNWQwMjhmZGNlOCAoIkFMU0E6IEVjaG9hdWRpbyAt
IEFkZCBzdXNwZW5kIHN1cHBvcnQgIzIiKQo+ID4gU2lnbmVkLW9mZi1ieTogRGluZ2hhbyBMaXUg
PGRpbmdoYW8ubGl1QHpqdS5lZHUuY24+Cj4gCj4gQWN0dWFsbHkgaXQncyByYXRoZXIgd3Jvbmcg
dG8gY2FsbCBzbmRfZWNob19mcmVlKCkgaW4gdGhlIHJlc3VtZSBlcnJvcgo+IHBhdGguICBUaGlz
IG1heSBsZWFkIHRvIGFuIE9vcHMgYXQgdGhlIG5leHQgdGltZSB0aGUgc3lzdGVtIGdvZXMgdG8K
PiByZXN1bWUuICBUaGF0IHNhaWQsIHdlIHNob3VsZCBkcm9wIHNuZF9lY2hvX2ZyZWUoKSBjYWxs
cyBpbiBvdGhlcgo+IGVycm9yIHBhdGhzIGluIHNuZF9lY2hvX3Jlc3VtZSgpIGluc3RlYWQuCj4g
CgpUaGFuayB5b3UgZm9yIHlvdXIgYWR2aWNlISBJIHdpbGwgc2VuZCBhIG5ldyBwYXRjaCB0byBm
aXggdGhpcyBzb29uLgoKUmVnYXJkcywKRGluZ2hhbw==
