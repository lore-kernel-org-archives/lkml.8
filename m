Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04094C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 08:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2A312068E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 08:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GPJfAKXO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nSdjmLzD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgHNIII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 04:08:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35266 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgHNIII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 04:08:08 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597392486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=iLojK6gsLxVcdJp08bjGqtZhGNvA7TdhRv7LWBJosOc=;
        b=GPJfAKXO+ec4mMS2F49vOIqUxnjghiTLW5RthnxDEMw00o1etYSSD6jdjogutjWCSNfoGB
        dYYlN4WlohKm6eYIz1BI3p53mXF8XAvR5DDR9X1pnNXmls/5P+KdwlTdyoftdFejLO8Au1
        IULflMM8xhYAVphJaMc+R0Dz+ugdYSkvSSljV5xMDd/hzxkxK47VZwA/Ug9lkvVWZ87npP
        l6ZDzhASndETeT8issq5TYcRmQC5OnGktl7THLMxsNsQ3a6Q7xFXm9ru7KoFIqi9WNb1Lv
        QL/hUazp5AHFpyEKRu56dzgHjGrq4FQJNEe2jh/QV9ILTt9G/RH6Is7BbkXWIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597392486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=iLojK6gsLxVcdJp08bjGqtZhGNvA7TdhRv7LWBJosOc=;
        b=nSdjmLzDOtLwfkKNi5x1s6MMySPnWvucOkuHsMOEZcsDtqLY82J3gTvEg4/JGi+OPZ7owf
        YO7WTfhI18qi27Bg==
To:     linux-kernel@vger.kernel.org
Cc:     Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [BUG] drm/ttm: Warning during suspend/freeze
Date:   Fri, 14 Aug 2020 10:08:05 +0200
Message-ID: <87zh6x3b16.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suspending or freezing a KVM guest triggers the following warning
reliably on current mainline:

[56691.550343] printk: Suspending console(s) (use no_console_suspend to debug)
[56691.578735] WARNING: CPU: 37 PID: 462 at drivers/gpu/drm/ttm/ttm_tt.c:51 ttm_tt_create+0xb6/0xe0 [ttm]
[56692.795234] Modules linked in: snd_hda_codec_generic(E) qxl(E) drm_ttm_helper(E) ttm(E) snd_hda_intel(E) snd_intel_dspcfg(E) snd_hda_codec(E) drm_kms_helper(E) snd_hwdep(E) snd_hda_core(E) cec(E) snd_pcm(E) snd_timer(E) drm(E) joydev
(E) snd(E) pcspkr(E) sg(E) evdev(E) virtio_balloon(E) serio_raw(E) virtio_console(E) soundcore(E) button(E) virtio_rng(E) rng_core(E) ip_tables(E) x_tables(E) autofs4(E) ext4(E) crc32c_generic(E) crc16(E) mbcache(E) jbd2(E) hid_generic(E) usbhid(E) hid(E) virtio_net(E) net_failover(E) failover(E) uhci_hcd(E) virtio_blk(E) sr_mod(E) cdrom(E) ata_generic(E) ehci_pci(E) ata_piix(E) ehci_hcd(E) libata(E) virtio_pci(E) usbcore(E) psmouse(E) virtio_ring(E) scsi_mod(E) i2c_piix4(E) virtio(E) floppy(E)
[56691.578781] CPU: 37 PID: 462 Comm: kworker/37:1 Tainted: G            E     5.8.0+ #8217
[56691.578784] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[56692.795348] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
[56691.578872] RIP: 0010:ttm_tt_create+0xb6/0xe0 [ttm]
[56691.578903] Call Trace:
[56691.578912]  ttm_bo_kmap+0x13c/0x260 [ttm]
[56691.578942]  qxl_bo_kmap+0x40/0x70 [qxl]
[56691.578947]  qxl_gem_prime_vmap+0x21/0x50 [qxl]
[56691.579060]  drm_gem_vmap+0x1f/0x50 [drm]
[56691.579073]  drm_client_buffer_vmap+0x1c/0x30 [drm]
[56691.579083]  drm_fb_helper_dirty_work+0xb2/0x1c0 [drm_kms_helper]
[56691.579091]  process_one_work+0x246/0x580
[56691.579099]  ? process_one_work+0x580/0x580
[56691.579101]  worker_thread+0x30/0x370
[56691.579104]  ? process_one_work+0x580/0x580
[56691.579107]  kthread+0x12a/0x140
[56691.579110]  ? kthread_park+0x80/0x80
[56691.579118]  ret_from_fork+0x22/0x30

Have not had time to figure out whether this is a regression or an older
issue. If you need further info please let me know.

Thanks,

        tglx
