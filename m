Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE7CC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ECBB2187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="IapFLTaG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgBNN15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 08:27:57 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52062 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729229AbgBNN1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 08:27:54 -0500
Received: by mail-wm1-f67.google.com with SMTP id t23so9958910wmi.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 05:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=kkmuJhEJOS35xHHzeJsfZBFbB6rjpScUgo1RMCIjzLg=;
        b=IapFLTaG22Z0NLaoz3u9pu9gmespLmeLh2Jv9CwSY5kLLVddirXyBG4ErrilLVjd+A
         /9lM7iXkn709iuhKnw9DFqZxmN6RbVH3Znu+RmThAXJB/KM9C4pLgADXmeODGpfH/2KO
         pbwjCxMBwGV2SsauYGOCAv4A9PEjZXKHvJStQNtGNoV11EDOUQTjb9XIvFp71h1v2nLL
         LwFRLRE0Rbc9AbejaheweG55XHZMPZ/Is6jzGp0JRdCZLegbNf8TBJrwJ+sl1hzXN4Bx
         TWPObJMKnBgmQ7k6T4k1yp6oU2eZvxWrNWyRUgWK0rzhLW9gV7khwkDagi6FeiTEb8yI
         hkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=kkmuJhEJOS35xHHzeJsfZBFbB6rjpScUgo1RMCIjzLg=;
        b=grc/NRwDknp9gs2P+srp7qrXUp0LVk2uZS5sCKHi18+D/HKU5NyYdw1/ZCVOpENVhx
         vdlCRR/COUIt0c+x4BgB5x99BydSPhNBrCxxKiGkAjRCTmiZJrg+MFF3ZcpU4tHZsDH1
         hy6pmpQTR+kCKfizJWSNmrLMHjCUP2ksQnAkWiem1ShTrMy3cWbUuBXS4gyXUs17Mvuf
         NjiYW9mQMd0qdQEf3v6HsBJ4WQ9ycMO+C/ejnYL9zB/CNUtLWi81nlEhqkJjIN0LZbBA
         DrdBQ7QPc+wW5rouh4n/kT6dcPH6i6N+4wEiW30ncVV+ypMV24vbYsZSmP/apuIxizYH
         o0rA==
X-Gm-Message-State: APjAAAWnzOWgBjYxF3iNBfyAC1S7a3MGFJjiia/4o430+TsG4/YouELU
        BPikckuaA7lVFJn9y4Pbr1rnFg==
X-Google-Smtp-Source: APXvYqwBVZd0CyFgsTF+H4YlKcVUtxX3mwLGko8oZoEyRCYR1EWSHfXPWgvEUNHLNNugO0z1VdT1iQ==
X-Received: by 2002:a1c:6755:: with SMTP id b82mr4822533wmc.126.1581686871208;
        Fri, 14 Feb 2020 05:27:51 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id q124sm19998516wme.2.2020.02.14.05.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 05:27:50 -0800 (PST)
Date:   Fri, 14 Feb 2020 14:27:48 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     u-boot@lists.denx.de, nsaenzjulienne@suse.de,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: RPI4: fail too boot with an initrd
Message-ID: <20200214132748.GA23276@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Since the inclusion of the "enable network support in RPi4 config" serie on uboot, I have started to work on adding the rpi4 in kernelCI.
But I fail to succeed in using a kernel/dtb/ramdisk downloaded via tftp.

Using booti I hit:
[    0.000000] Linux version 5.6.0-rc1-next-20200212 (clabbe@build2-bionic-1804) (gcc version 7.4.1 20181213 [linaro-7.4-2019.02 revision 56ec6f6b99cc167ff0c2f8e1a2eed33b1edc85d4] (Linaro    GCC 7.4-2019.02)) #66 SMP PREEMPT Wed Feb 12 10:14:20 UTC 2020
[    0.000000] Machine model: Raspberry Pi 4 Model B
[    0.000000] earlycon: uart0 at MMIO32 0x00000000fe215040 (options '')
[    0.000000] printk: bootconsole [uart0] enabled
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: UEFI not found.
[    0.000000] OF: reserved mem: failed to allocate memory for node 'linux,cma'
[    0.000000] cma: Failed to reserve 32 MiB
[    0.000000] Kernel panic - not syncing: Failed to allocate page table page
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.6.0-rc1-next-20200212 #66
[    0.000000] Hardware name: Raspberry Pi 4 Model B (DT)
[    0.000000] Call trace:
[    0.000000]  dump_backtrace+0x0/0x1a0
[    0.000000]  show_stack+0x14/0x20
[    0.000000]  dump_stack+0xbc/0x104
[    0.000000]  panic+0x16c/0x37c
[    0.000000]  early_pgtable_alloc+0x30/0xa0
[    0.000000]  __create_pgd_mapping+0x36c/0x588
[    0.000000]  map_kernel_segment+0x70/0xa4
[    0.000000]  paging_init+0xf4/0x528
[    0.000000]  setup_arch+0x250/0x5d8
[    0.000000]  start_kernel+0x90/0x6d8

 
Since the same kernel boot with bootefi and that bootefi lack ramdisk address, I tried to add the address in the dtb via:
fdt addr 0x02400000; fdt resize; fdt set /chosen linux,initrd-start 0x02700000; fdt set /chosen linux,initrd-end 0x10000000; bootefi 0x00080000 0x02400000
But with that, I get:
initrd not fully accessible via the linear mapping -- please check your bootloader ...

I have tried many different start/end address without any change.


My last resort was to embed the rootfs in the kernel.
But with the correct console=, the boot stop at:
[    1.373557] fe201000.serial: ttyAMA0 at MMIO 0xfe201000 (irq = 16, base_baud = 0) is a PL011 rev2
[    1.382565] printk: console [ttyAMA0] enabled
[    1.391318] printk: bootconsole [uart0] disabled

With the wrong console (ttyS0), the boot go up to start init which panic due to lack of console.

Regards
