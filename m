Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1F5C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 04:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE5220684
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 04:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s08gSl21"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbgATErj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 23:47:39 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35658 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729043AbgATErj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 23:47:39 -0500
Received: by mail-pf1-f194.google.com with SMTP id i23so15196085pfo.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 20:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ti8+hB0utpLZr3O4fYMQ5nwM3OICAeQdhYguP4pp9Gw=;
        b=s08gSl21xfXw+lzR6rvvCCbZu5eiTr0vPpRL+4Ig80BO2Mwo6MwF9Zu0d7wvsBGBps
         7NGR8uyTmaJppNfQ7XEx6J6yIOtL3s8do+X/rC9enda0tAfnpnDeWOsNb3Bp03+r1bTk
         wGQlVd0o33KXbLJBFjStqFPPEID6NXcUwkwKt+ZmFzV0vkBwfTjIzQuTYpUX9XbrkAO3
         wYjGRyOr1g1R8E5hFZ6g7y9Bje1SV3lX/GcJnMHkWaG3/Hat2+WhmyqQQrskNaGB6dG3
         o+Rrx/QzfcQ62gfgLMdmeeDaW6zwMjYkimNx7RJ9dLViClQ8hoUXjk8srlQCdGAzEMCn
         ytWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ti8+hB0utpLZr3O4fYMQ5nwM3OICAeQdhYguP4pp9Gw=;
        b=A373/YkPY1Z8P5GpZEOlN7+jrnYu0OWpNxUxBs4aNNx+zDlkIO7pixv4ZHtWr0Itpg
         AnMlHFpi0N3DA8FFY15FdK8SO5jRzSivS0vYYaOdCcpqShj1wSienpRH1REWXs+eY9PN
         yX7t/z+60RGCFsRbu+sQx95yfnGRzUTMZK/Ow04IMUAiC5JhlzqwJGGFEJHhLaW2mqL2
         ccpQ/uE5zoKWPtDaNOtrjK9fWasWiYHK6aW01EwDhHtwz5zeXt1La/JP2rqVUm3etXEe
         tyzVBjLWLyIVswxBrd+qxYmY7U0euQo6iauRvw4abPq+hrIH5sxNmeooUQna0YUocYIe
         azPw==
X-Gm-Message-State: APjAAAUumR9x9L1DaqhBtxgtY45u3+iAVbwmOunNSdJx97ljliD0RyDF
        A8cPbpZvb1eWMqYhTD2LKK35uKYp/bU=
X-Google-Smtp-Source: APXvYqz18kh5Is5mWKOoszjfsXjhDjcW1TWkbN/4SMW60NJaSH1jBWkgUNLbPZ70Pd6LLSVdYNBu8g==
X-Received: by 2002:aa7:8098:: with SMTP id v24mr15666527pff.33.1579495658415;
        Sun, 19 Jan 2020 20:47:38 -0800 (PST)
Received: from pek-lpggp6.wrs.com (unknown-105-123.windriver.com. [147.11.105.123])
        by smtp.gmail.com with ESMTPSA id h3sm15791836pjs.0.2020.01.19.20.47.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Jan 2020 20:47:38 -0800 (PST)
From:   Kevin Hao <haokexin@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH] irqdomain: Fix a memory leak in irq_domain_push_irq()
Date:   Mon, 20 Jan 2020 12:35:47 +0800
Message-Id: <20200120043547.22271-1-haokexin@gmail.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a memory leak reported by kmemleak:
unreferenced object 0xffff000bc6f50e80 (size 128):
  comm "kworker/23:2", pid 201, jiffies 4294894947 (age 942.132s)
  hex dump (first 32 bytes):
    00 00 00 00 41 00 00 00 86 c0 03 00 00 00 00 00  ....A...........
    00 a0 b2 c6 0b 00 ff ff 40 51 fd 10 00 80 ff ff  ........@Q......
  backtrace:
    [<00000000e62d2240>] kmem_cache_alloc_trace+0x1a4/0x320
    [<00000000279143c9>] irq_domain_push_irq+0x7c/0x188
    [<00000000d9f4c154>] thunderx_gpio_probe+0x3ac/0x438
    [<00000000fd09ec22>] pci_device_probe+0xe4/0x198
    [<00000000d43eca75>] really_probe+0xdc/0x320
    [<00000000d3ebab09>] driver_probe_device+0x5c/0xf0
    [<000000005b3ecaa0>] __device_attach_driver+0x88/0xc0
    [<000000004e5915f5>] bus_for_each_drv+0x7c/0xc8
    [<0000000079d4db41>] __device_attach+0xe4/0x140
    [<00000000883bbda9>] device_initial_probe+0x18/0x20
    [<000000003be59ef6>] bus_probe_device+0x98/0xa0
    [<0000000039b03d3f>] deferred_probe_work_func+0x74/0xa8
    [<00000000870934ce>] process_one_work+0x1c8/0x470
    [<00000000e3cce570>] worker_thread+0x1f8/0x428
    [<000000005d64975e>] kthread+0xfc/0x128
    [<00000000f0eaa764>] ret_from_fork+0x10/0x18

Fixes: 495c38d3001f ("irqdomain: Add irq_domain_{push,pop}_irq() functions")
Cc: stable@vger.kernel.org
Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 kernel/irq/irqdomain.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index dd822fd8a7d5..480df3659720 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1459,6 +1459,7 @@ int irq_domain_push_irq(struct irq_domain *domain, int virq, void *arg)
 	if (rv) {
 		/* Restore the original irq_data. */
 		*root_irq_data = *child_irq_data;
+		kfree(child_irq_data);
 		goto error;
 	}
 
-- 
2.14.4

