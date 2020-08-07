Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEBFC433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F6EA2177B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgHGJut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 05:50:49 -0400
Received: from mail.zju.edu.cn ([61.164.42.155]:57918 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727820AbgHGJup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 05:50:45 -0400
Received: by ajax-webmail-mail-app3 (Coremail) ; Fri, 7 Aug 2020 17:50:13
 +0800 (GMT+08:00)
X-Originating-IP: [210.32.144.186]
Date:   Fri, 7 Aug 2020 17:50:13 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Takashi Iwai" <tiwai@suse.de>
Cc:     kjlu@umn.edu, "Jaroslav Kysela" <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>, "Geoffrey D. Bennett" <g@b4.vu>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] ALSA: usb-audio: Fix memleak in
 scarlett2_add_new_ctl
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190906(84e8bf8f)
 Copyright (c) 2002-2020 www.mailtech.cn zju.edu.cn
In-Reply-To: <s5htuxeanl2.wl-tiwai@suse.de>
References: <20200807071229.9533-1-dinghao.liu@zju.edu.cn>
 <s5htuxeanl2.wl-tiwai@suse.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <2632689f.4acd5.173c853f824.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cC_KCgAH0t7VIy1fY10wAg--.31871W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgECBlZdtPbBHgAHsW
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJTRUUUbXIS07vEb7Iv0x
        C_JF4lV2xY67kC6x804xWlV2xY67CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DMIAI
        bVAFxVCF77xC64kEw24lV2xY67C26IkvcIIF6IxKo4kEV4ylV2xY628lY4IE4IxF12IF4w
        CS07vE84x0c7CEj48ve4kI8wCS07vE84ACjcxK6xIIjxv20xvE14v26w1j6s0DMIAIbVA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIAIbVA2z4x0Y4vEx4A2jsIE14v26r
        xl6s0DMIAIbVA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lV2xY62AIxVAIcxkEcVAq
        07x20xvEncxIr21lV2xY6c02F40EFcxC0VAKzVAqx4xG6I80ewCS07vEYx0E2Ix0cI8IcV
        AFwI0_Jr0_Jr4lV2xY6cIj6I8E87Iv67AKxVWUJVW8JwCS07vEOx8S6xCaFVCjc4AY6r1j
        6r4UMIAIbVCjxxvEw4WlV2xY6xkIecxEwVAFwVW8uwCS07vEc2IjII80xcxEwVAKI48JMI
        AIbVCF04k20xvE74AGY7Cv6cx26r4fKr1UJr1lV2xY6xCjnVCjjxCrMIAIbVCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwCS07vEx2IqxVAqx4xG67AKxVWUJVWUGwCS07vEx2IqxVCjr7xvwV
        AFwI0_JrI_JrWlV2xY6I8E67AF67kF1VAFwI0_JF0_Jw1lV2xY6IIF0xvE2Ix0cI8IcVAF
        wI0_Jr0_JF4lV2xY6IIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCS07vEIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lV2xY6IIF0xvEx4A2jsIE14v26r1j6r4UMIAIbVCI42IY
        6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73U
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgomcXVvdDtUYWthc2hpIEl3YWkmcXVvdDsgJmx0O3Rpd2FpQHN1c2UuZGUmZ3Q75YaZ6YGT77ya
Cj4gT24gRnJpLCAwNyBBdWcgMjAyMCAwOToxMjoyNyArMDIwMCwKPiBEaW5naGFvIExpdSB3cm90
ZToKPiA+IAo+ID4gV2hlbiBzbmRfdXNiX21peGVyX2FkZF9jb250cm9sKCkgZmFpbHMsIGVsZW0g
bmVlZHMgdG8gYmUKPiA+IGZyZWVkIGp1c3QgbGlrZSB3aGVuIHNuZF9jdGxfbmV3MSgpIGZhaWxz
LiBIb3dldmVyLCBjdXJyZW50Cj4gPiBjb2RlIGlzIHJldHVybmluZyBkaXJlY3RseSBhbmQgZW5k
cyB1cCBsZWFraW5nIG1lbW9yeS4KPiAKPiBObywgdGhpcyB3b3VsZCBsZWFkIHRvIGRvdWJsZS1m
cmVlLiAgc25kX2N0bF9hZGQoKSBzaG93cyBhIGtpbmQgb2YKPiBzcGVjaWFsIGJlaGF2aW9yLCBp
dCBhbHJlYWR5IHJlbGVhc2VzIHRoZSBvYmplY3QgYXQgaXRzIGVycm9yIHBhdGguCj4gCgpJdCdz
IGNsZWFyIHRvIG1lLCB0aGFua3MhCgpSZWdhcmRzLApEaW5naGFvCg==
