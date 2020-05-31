Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD776C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 10:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A75662074A
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 10:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgEaKnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 06:43:12 -0400
Received: from spam.zju.edu.cn ([61.164.42.155]:13692 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725813AbgEaKnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 06:43:11 -0400
Received: by ajax-webmail-mail-app4 (Coremail) ; Sun, 31 May 2020 18:42:59
 +0800 (GMT+08:00)
X-Originating-IP: [10.192.85.18]
Date:   Sun, 31 May 2020 18:42:59 +0800 (GMT+08:00)
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
In-Reply-To: <d05224e4-d682-de3e-928f-5af7b8597a8d@web.de>
References: <dd729c13-fbc8-22e7-7d8e-e3e126f66943@web.de>
 <40d8fb01.db721.17269d3d620.Coremail.dinghao.liu@zju.edu.cn>
 <74977dc6-7ace-6ef7-4fcd-3f6c89a3eb5f@web.de>
 <286858ff.db7e3.17269ee5f3f.Coremail.dinghao.liu@zju.edu.cn>
 <5a073b2b-5102-adec-84dd-b62dc48c7451@web.de>
 <1c5b64dc.db888.1726a03b710.Coremail.dinghao.liu@zju.edu.cn>
 <d05224e4-d682-de3e-928f-5af7b8597a8d@web.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <599cd7d4.dbaba.1726a53da96.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgDn7wczitNeallkAA--.10192W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAg4RBlZdtOY+wQABs8
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJTRUUUbL0S07vEb7Iv0x
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
        6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lV2xY6IIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s
        0DMIAIbVCI42IY6I8E87Iv67AKxVWUJVW8JwCS07vEIxAIcVC2z280aVCY1x0267AKxVW8
        JVW8JrUvcSsGvfC2KfnxnUU==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IElmIGdrMjBhX2Nsa19jdG9yKCkgbmV2ZXIgcmV0dXJucyBzdWNoIGFuIGVycm9yIGNvZGUs
Cj4gPiB3ZSBtYXkgbmVlZCBub3QgdG8gcmVsZWFzZSB0aGlzIGNsb2NrIG9iamVjdC4KPiAKPiBX
b3VsZCB5b3UgbGlrZSB0byBhY2hpZXZlIGNvbXBsZXRlIGV4Y2VwdGlvbiBoYW5kbGluZwo+IGFs
c28gZm9yIHRoaXMgZnVuY3Rpb24gaW1wbGVtZW50YXRpb24/Cj4gCgpJdCBzZWVtcyB0aGF0IGl0
J3MgcG9zc2libGUgdG8gZ2V0IC1FTk9NRU0gZnJvbSBnazIwYV9jbGtfY3RvcigpLgpUaGUgY2Fs
bCBjaGFpbiBpcyBhcyBmb2xsb3dzOgpnazIwYV9jbGtfY3RvcigpIDwtIG52a21fY2xrX2N0b3Io
KSA8LSBudmttX25vdGlmeV9pbml0KCkKCldoZW4gbnZrbV9ub3RpZnlfaW5pdCgpIHJldHVybnMg
LUVOT01FTSwgYWxsIG9mIGl0cyBjYWxsZXJzIChhbmQgCmNhbGxlcnMgb2YgY2FsbGVycykgd2ls
bCBiZSBpbmZsdWVuY2VkIGlmIHRoZXJlIGlzIGEgZmFpbGVkCmt6YWxsb2MgaW5zaWRlIHdoaWNo
LiAKCkluIHRoaXMgY2FzZSwgbWF5YmUgd2Ugc2hvdWxkIGNoZWNrIHRoZSByZXR1cm4gdmFsdWUg
b2YgCmdrMjBhX2Nsa19jdG9yKCkgYW5kIHJlbGVhc2UgY2xrIGlmIGl0IHJldHVybnMgLUVOT01F
TS4gCkFuZCBtYW55IG90aGVyIGZ1bmN0aW9ucyBhbHNvIGhhdmUgdGhlIHNhbWUgaXNzdWUgKGUu
Zy4sCmdtMjBiX2Nsa19uZXdfc3BlZWRvMCkuIERvIHlvdSBoYXZlIGFueSBpZGVhIGFib3V0IHRo
aXMgCnByb2JsZW0/CgpSZWdhcmRzLApEaW5naGFv
