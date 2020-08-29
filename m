Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C7BC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 17:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEDE420757
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 17:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dragonslave.de header.i=@dragonslave.de header.b="jebkj6Oj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgH2RGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 13:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbgH2RGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 13:06:04 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DA8C061236
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 10:06:03 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id a12so1816972eds.13
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 10:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dragonslave.de; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=93hc6t4Y6G90m1ZesLWcVER7mN+uG6xnyIGSdNtbUmQ=;
        b=jebkj6Ojdzc0T0Yuk1PoGa+xRIq1S6ETokUllqY+QfQVU/RRxZAodSgYOKNuq6iwfE
         zZ6NEtra7Pr2ZARjUAcOAfbkBUOCpJAlO52lMznvnOamLmekajJY7XCELiWcoaWpkEPQ
         X/n0JHoiVlmcfdFZr7kDzKo4fQBI/a99kNkkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=93hc6t4Y6G90m1ZesLWcVER7mN+uG6xnyIGSdNtbUmQ=;
        b=smrKFoxaaaP9vv1RUmiyy/GLZ36UCK+9Rgg9dLzDR80ffqgb/S2ajpea+bZkIX+HEx
         pPSGnIC5XA4qwLMu0Jbs4/TRgDFIFh2xoQF8guMv05G954wgv/9IUDgzZ1vdWRGlYufL
         Gdm5RT1VB1tNpRsb9CN/fywGkTt3wS5vWIvcSNEYu9gM3/zeFIP8LjmWg68WQ5xS2k9r
         ku92qfQwIUJa4L1jpMOQKL8jnGbMQynk/LG9WkqNWj3FBGbO3RleE7vUah44gWzw7yu/
         AmrRAckentnY14XyGJ2mce5aQyvrSTZkNSMlhyZlTTcixEwleXTFcSuMUnBCORDTQ7m5
         Z9xw==
X-Gm-Message-State: AOAM532eh7WFgUYfuyRsOzEQdVrP+sEslWoIqZwMlEDpiftvFyG3vJg6
        OBb/6L55nFfPajaM0/H1V00BoFoK65ptTM7I
X-Google-Smtp-Source: ABdhPJw9wBM8QrRkhy2Ye/tQz17QnIS8P+xlBE5Jm0q9Q9zmV6uRrbVyop1w8FexBe5eEDWQtB2Vhw==
X-Received: by 2002:a50:ee07:: with SMTP id g7mr4145111eds.184.1598720762070;
        Sat, 29 Aug 2020 10:06:02 -0700 (PDT)
Received: from [192.168.25.146] (ip92340232.dynamic.kabel-deutschland.de. [146.52.2.50])
        by smtp.googlemail.com with ESMTPSA id cz21sm2559776edb.45.2020.08.29.10.06.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Aug 2020 10:06:01 -0700 (PDT)
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Exner <dex@dragonslave.de>, crazy@frugalware.org,
        torvalds@linux-foundation.org
From:   Daniel Exner <dex@dragonslave.de>
Subject: Kernel 5.9-rc Regression: Boot failure with nvme
Message-ID: <f7328aad-ce1d-dd3f-577b-20b3d2efbabc@dragonslave.de>
Date:   Sat, 29 Aug 2020 19:05:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

(please keep me in the loop, as I'm currently not suscribed)

both 5.9-rc1 and -rc2 fail to boot with my TOSHIBA-RD400 NVME:

[    1.015590] ------------[ cut here ]------------
[    1.015594] WARNING: CPU: 7 PID: 99 at mm/page_alloc.c:4864 
__alloc_pages_nodemask+0x299/0x330
[    1.015594] Modules linked in: syscopyarea xhci_pci(+) 
xhci_pci_renesas sysfillrect xhci_hcd nvme aesni_intel(+) crypto_simd 
sysimgblt fb_sys_fops cryptd nvme_core t10_pi glue_helper drm hwmon 
scsi_mod agpgart i2c_core usbcore video wmi button dm_mirror 
dm_region_hash dm_log dm_mod unix ipv6 autofs4
[    1.015602] CPU: 7 PID: 99 Comm: kworker/u16:1 Not tainted 
5.9.0-rc2-dirty #12
[    1.015603] Hardware name: To Be Filled By O.E.M. To Be Filled By 
O.E.M./Z170 Gaming K6, BIOS P7.50 10/18/2018
[    1.015607] Workqueue: nvme-reset-wq nvme_reset_work [nvme]
[    1.015608] RIP: 0010:__alloc_pages_nodemask+0x299/0x330
[    1.015609] Code: 66 0f 85 46 ff ff ff e8 24 46 dd ff e9 3c ff ff ff 
e8 4b 4f fc ff 48 89 c7 e9 ad fe ff ff 81 e5 00 20 00 00 0f 85 7b ff ff 
ff <0f> 0b e9 74 ff ff ff 31 c0 e9 1b fe ff ff 65 48 8b 04 25 00 6d 01
[    1.015610] RSP: 0000:ffffb3ed002abcb8 EFLAGS: 00010246
[    1.015611] RAX: 0000000000000000 RBX: ffff9c8e827c4118 RCX: 
0000000000000000
[    1.015611] RDX: 0000000000000000 RSI: 0000000000000034 RDI: 
0000000000000cc0
[    1.015612] RBP: 0000000000000000 R08: 0000000000000000 R09: 
ffffffffffffffff
[    1.015612] R10: 0000000000000006 R11: ffffb3ee002abb97 R12: 
0000000000000000
[    1.015613] R13: 0000000000000000 R14: ffff9c8e921060b0 R15: 
0000000000000cc0
[    1.015614] FS:  0000000000000000(0000) GS:ffff9c8e96bc0000(0000) 
knlGS:0000000000000000
[    1.015615] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.015615] CR2: 0000559988e2f4d8 CR3: 00000008433e4004 CR4: 
00000000003706e0
[    1.015616] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[    1.015617] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[    1.015617] Call Trace:
[    1.015621]  dma_direct_alloc_pages+0x1e9/0x2c0
[    1.015623]  ? pci_alloc_irq_vectors_affinity+0xa5/0x100
[    1.015626]  nvme_alloc_queue+0x10a/0x170 [nvme]
[    1.015629]  nvme_reset_work+0x70b/0x12b0 [nvme]
[    1.015631]  ? nvme_irq_check+0x30/0x30 [nvme]
[    1.015634]  process_one_work+0x1da/0x3d0
[    1.015636]  worker_thread+0x4a/0x3c0
[    1.015637]  ? process_one_work+0x3d0/0x3d0
[    1.015638]  kthread+0x114/0x160
[    1.015640]  ? kthread_park+0x90/0x90
[    1.015641]  ret_from_fork+0x22/0x30
[    1.015643] ---[ end trace 268d4f4db1ef121e ]---


Resulting in:
[    1.015644] nvme nvme0: Removing after probe failure status: -12

If you need more infos I can try to provide them.

Greetings
Daniel



