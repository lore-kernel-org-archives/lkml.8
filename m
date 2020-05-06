Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0DEC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 04:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44BE520757
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 04:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXoaYs/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgEFEHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 00:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgEFEHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 00:07:06 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F2FC061A0F;
        Tue,  5 May 2020 21:07:06 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id h4so808870ljg.12;
        Tue, 05 May 2020 21:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=RwqvFGjpditomC+TnBCLC3tVMfPIfZUsMLws5KYjVr8=;
        b=eXoaYs/ewR+tu42SzN3Wiqxotl0AEKGNg3CZ5Vngi4ugW/NTFVYMS7ofAUcU1JTYV9
         AYkc7VEfEbiFVt5Vfw4n17LuNChHjkxwGlQP2TS5pzGINuYp94lConXpGa1n6LS0Fd7J
         UK+DhTOgC2AE9r8nuB3ytXLPY/rTEiPUxv+OLip4sauHUubHdOaCv1rcBFVJmaD9EZvX
         mq06JqUM0JAkKUKWV/LxhPX9vM7/jMIArQC6Plst6jzpGqfWeSrh373ZoctK7xcZhcRL
         XWLLJc5e+0Gb+mm9HSC0YXuBe8zz9hl4P46qvuTNM+6ElbP46REH7TLghI+537RLEElQ
         XKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=RwqvFGjpditomC+TnBCLC3tVMfPIfZUsMLws5KYjVr8=;
        b=MNydWYbY3Ri+DnvaM6bP993fEKMzyg4nzPrtoNvIjGkV3zzr5kOuHvy0uoD3mIy/i0
         ZjP6wStdy/qIwQx+aOVeIBAeHL+US2JpqebAf/AHAIoFkJJyFzCcMvgydVb+a2PUbvM1
         ef55rmXgTsKyHl5nAPpF5dWpHmG25qm1O5CZYytGyGe7/8BNENFD7sc8HBZyeICJYbVZ
         sRUthIxFz4XfEQ7b7E4NFHpgmxaSg+dNynn0+ky+L6jXtyCQXSG8/1q3KXpVULJgHFXf
         aHZ6WbzfxCeyIDJZEKmKnarxRsRs9qAxqs+y5esW7Oy4jfu3f89wNXjNTl5j1mtN0dwi
         ODGA==
X-Gm-Message-State: AGi0Pua+OWdZ7p9Hb+dAvZ1mw6KPYX9cL3JwvBfOFcN3Fj6cHcd5DNGM
        Ynj3ay+b3Jq90huPk6ck9bkb323w7Ysp3xGadi0=
X-Google-Smtp-Source: APiQypI9XqAbSifbtRR7qyVZlhKXpefV9FJquksUvwvbewS7ua1Q7v77XF17JTGS1mG4nyrN4LDNi+IyESXQ/Izme3k=
X-Received: by 2002:a2e:b5d2:: with SMTP id g18mr3631647ljn.51.1588738025010;
 Tue, 05 May 2020 21:07:05 -0700 (PDT)
MIME-Version: 1.0
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Wed, 6 May 2020 00:06:53 -0400
Message-ID: <CAEAjamuZR-amiVWK4BMWReq7=1Vus+bXsB-97t3hhsYHLfUstQ@mail.gmail.com>
Subject: [PATCH] USB: gadget: fix illegal array access in binding with UDC
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     balbi@kernel.org, syzkaller <syzkaller@googlegroups.com>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Tian <dave.jing.tian@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FuzzUSB (a variant of syzkaller) found an illegal array access
using an incorrect index while binding a gadget with UDC.

Reference: https://www.spinics.net/lists/linux-usb/msg194331.html

This bug occurs when a size variable used for a buffer
is misused to access its strcpy-ed buffer.
Given a buffer along with its size variable (taken from user input),
from which, a new buffer is created using kstrdup().
Due to the original buffer containing 0 value in the middle,
the size of the kstrdup-ed buffer becomes smaller than that of the original.
So accessing the kstrdup-ed buffer with the same size variable
triggers memory access violation.

The fix makes sure no zero value in the buffer,
by comparing the strlen() of the orignal buffer with the size variable,
so that the access to the kstrdup-ed buffer is safe.


BUG: KASAN: slab-out-of-bounds in gadget_dev_desc_UDC_store+0x1ba/0x200
drivers/usb/gadget/configfs.c:266
Read of size 1 at addr ffff88806a55dd7e by task syz-executor.0/17208

CPU: 2 PID: 17208 Comm: syz-executor.0 Not tainted 5.6.8 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xce/0x128 lib/dump_stack.c:118
 print_address_description.constprop.4+0x21/0x3c0 mm/kasan/report.c:374
 __kasan_report+0x131/0x1b0 mm/kasan/report.c:506
 kasan_report+0x12/0x20 mm/kasan/common.c:641
 __asan_report_load1_noabort+0x14/0x20 mm/kasan/generic_report.c:132
 gadget_dev_desc_UDC_store+0x1ba/0x200 drivers/usb/gadget/configfs.c:266
 flush_write_buffer fs/configfs/file.c:251 [inline]
 configfs_write_file+0x2f1/0x4c0 fs/configfs/file.c:283
 __vfs_write+0x85/0x110 fs/read_write.c:494
 vfs_write+0x1cd/0x510 fs/read_write.c:558
 ksys_write+0x18a/0x220 fs/read_write.c:611
 __do_sys_write fs/read_write.c:623 [inline]
 __se_sys_write fs/read_write.c:620 [inline]
 __x64_sys_write+0x73/0xb0 fs/read_write.c:620
 do_syscall_64+0x9e/0x510 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe


Signed-off-by: Kyungtae Kim <kt0755@gmail.com>
Reported-and-tested-by: Kyungtae Kim <kt0755@gmail.com>

---
 drivers/usb/gadget/configfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index 32b637e3e1fa..6a9aa4413d64 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -260,6 +260,9 @@ static ssize_t gadget_dev_desc_UDC_store(struct
config_item *item,
        char *name;
        int ret;

+       if (strlen(page) < len)
+               return -EOVERFLOW;
+
        name = kstrdup(page, GFP_KERNEL);
        if (!name)
                return -ENOMEM;
--
2.17.1
