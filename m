Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FF3C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6BDD2085B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="Pk8YUnCd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgBEA4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 19:56:00 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37713 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727627AbgBEA4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 19:56:00 -0500
Received: by mail-qt1-f196.google.com with SMTP id w47so278428qtk.4;
        Tue, 04 Feb 2020 16:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=yC9xIL1dNyShbeFS2/Wyo+h8MlTkNrKRjdXdXeCa2a4=;
        b=Pk8YUnCduMXLnvgA1FG4sxxGzi4T+lap2zlAsuptyOvqk+jHVAT0PFPiunxwbLAUMX
         VIvF4xJpbwiyTNBX1SThGCDGK97BR3uHAX2Ae/jqTf9+7T1QYuTkl7hmF4pRZG/p5kqL
         IIhn3SePpGLXpFQ4ZAzn6MrKuZn6E0dYI67AY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=yC9xIL1dNyShbeFS2/Wyo+h8MlTkNrKRjdXdXeCa2a4=;
        b=cn3LXX93ePM3PIC3NgCNm7eJeAyda64VrwXhyVu6+Q4xkqIcrqzyinrnkhlEum1jwF
         Lt/mcUs/4Hl1rDgs3GU04Tx89S1VV9t/aR39jWsc/7dzA2NtOhxDo223n40u6zfZckHL
         xK9c2NSyRtlDZxs2QLYTKQmP3sJ7nK1UGOnnsLUkh0e0VP/7bcsVOup8EHaGi+Z/1ogg
         jI1mW2JPce49mT7vEOeP4qcZbYXYZnls+g2+c2NewjCNaKBCRio3zszEMt6CIKizPZ9s
         K2uEpSUVLRGa5UQ1jRTx1/n4vUaGiQFMbh44kmaiLJh/TEopBsaOCarI6janRQvlOW9D
         H40Q==
X-Gm-Message-State: APjAAAX+XvukWa7DeV8QCpQEoysnfow5BG9VbnVzejUiTJ7gDIgHtGR8
        NO0r4A1Mu8Wen7ccZGiC/w7PONe24/ZhaRbSbUN/Amxc
X-Google-Smtp-Source: APXvYqwraToRypAJColuSwSVdeBtc5ThkSYjFxUK+9tSBJHfeqQDTqCSDSwoG54gwHk3fP2ja0HbEGQ3J1EHVXULTz4=
X-Received: by 2002:ac8:754e:: with SMTP id b14mr31535858qtr.220.1580864158382;
 Tue, 04 Feb 2020 16:55:58 -0800 (PST)
MIME-Version: 1.0
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 5 Feb 2020 00:55:46 +0000
Message-ID: <CACPK8XdFUWoEr6YvVHf-g28hREFOWMX0g5=Vsdxq9Asq=ftOVQ@mail.gmail.com>
Subject: TI PCIe xHCI and kexec
To:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm supporting a system that uses Linux-as-a-bootloader to load a
distro kernel via kexec, The systems have a TI TUSB73x0 PCIe
controller which goes out to lunch after a kexec. This is the distro
(post-kexec) kernel:

[    0.235411] pci 0003:01:00.0: xHCI HW did not halt within 16000
usec status = 0x0
[    1.037298] xhci_hcd 0003:01:00.0: xHCI Host Controller
[    1.037367] xhci_hcd 0003:01:00.0: new USB bus registered, assigned
bus number 1
[    1.053481] xhci_hcd 0003:01:00.0: Host halt failed, -110
[    1.053523] xhci_hcd 0003:01:00.0: can't setup: -110
[    1.053565] xhci_hcd 0003:01:00.0: USB bus 1 deregistered
[    1.053629] xhci_hcd 0003:01:00.0: init 0003:01:00.0 fail, -110
[    1.053703] xhci_hcd: probe of 0003:01:00.0 failed with error -110

There were some fixes made a few years back to improve the situation,
but we've still had to carry some form of the patch below in the
bootloader kernel. I would like to rework it so it can be merged.

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index dbac0fa9748d..eaa94456dd9d 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -789,6 +789,9 @@ void xhci_shutdown(struct usb_hcd *hcd)
     xhci_dbg_trace(xhci, trace_xhci_dbg_init,
             "xhci_shutdown completed - status = %x",
             readl(&xhci->op_regs->status));
+
+    /* TI XHCI controllers do not come back after kexec without this hack */
+    pci_reset_function_locked(to_pci_dev(hcd->self.sysdev));
 }
 EXPORT_SYMBOL_GPL(xhci_shutdown);

I would like some advice on how to implement it in a way that is
acceptable. Would a quirk on the pci id in xhci_shutdown be ok?

0003:01:00.0 USB controller: Texas Instruments TUSB73x0 SuperSpeed USB
3.0 xHCI Host Controller (rev 02)

The full debug log of the distro kernel booting is below.

Cheers,

Joel

---

[    1.037638] xhci_hcd 0003:01:00.0: xHCI Host Controller
[    1.037695] xhci_hcd 0003:01:00.0: new USB bus registered, assigned
bus number 1
[    1.037789] xhci_hcd 0003:01:00.0: xHCI capability registers at
    (ptrval):
[    1.037792] xhci_hcd 0003:01:00.0: CAPLENGTH AND HCIVERSION 0x960020:
[    1.037794] xhci_hcd 0003:01:00.0: CAPLENGTH: 0x20
[    1.037796] xhci_hcd 0003:01:00.0: HCIVERSION: 0x96
[    1.037798] xhci_hcd 0003:01:00.0: HCSPARAMS 1: 0x8000840
[    1.037800] xhci_hcd 0003:01:00.0:   Max device slots: 64
[    1.037802] xhci_hcd 0003:01:00.0:   Max interrupters: 8
[    1.037804] xhci_hcd 0003:01:00.0:   Max ports: 8
[    1.037806] xhci_hcd 0003:01:00.0: HCSPARAMS 2: 0xc0000f1
[    1.037808] xhci_hcd 0003:01:00.0:   Isoc scheduling threshold: 1
[    1.037810] xhci_hcd 0003:01:00.0:   Maximum allowed segments in
event ring: 15
[    1.037813] xhci_hcd 0003:01:00.0: HCSPARAMS 3 0x7ff000a:
[    1.037815] xhci_hcd 0003:01:00.0:   Worst case U1 device exit latency: 10
[    1.037816] xhci_hcd 0003:01:00.0:   Worst case U2 device exit latency: 2047
[    1.037819] xhci_hcd 0003:01:00.0: HCC PARAMS 0x270f06d:
[    1.037821] xhci_hcd 0003:01:00.0:   HC generates 64 bit addresses
[    1.037823] xhci_hcd 0003:01:00.0:   HC hasn't Contiguous Frame ID Capability
[    1.037825] xhci_hcd 0003:01:00.0:   HC can't generate Stopped -
Short Package event
[    1.037826] xhci_hcd 0003:01:00.0:   FIXME: more HCCPARAMS debugging
[    1.037829] xhci_hcd 0003:01:00.0: RTSOFF 0x4a0:
[    1.037831] xhci_hcd 0003:01:00.0: xHCI operational registers at
     (ptrval):
[    1.037833] xhci_hcd 0003:01:00.0: USBCMD 0x0:
[    1.037835] xhci_hcd 0003:01:00.0:   HC is being stopped
[    1.037837] xhci_hcd 0003:01:00.0:   HC has finished hard reset
[    1.037839] xhci_hcd 0003:01:00.0:   Event Interrupts disabled
[    1.037841] xhci_hcd 0003:01:00.0:   Host System Error Interrupts disabled
[    1.037843] xhci_hcd 0003:01:00.0:   HC has finished light reset
[    1.037846] xhci_hcd 0003:01:00.0: USBSTS 0x0:
[    1.037847] xhci_hcd 0003:01:00.0:   Event ring is empty
[    1.037849] xhci_hcd 0003:01:00.0:   No Host System Error
[    1.037851] xhci_hcd 0003:01:00.0:   HC is running
[    1.037854] xhci_hcd 0003:01:00.0:         (ptrval) port status reg = 0x2a0
[    1.037857] xhci_hcd 0003:01:00.0:         (ptrval) port power reg = 0x0
[    1.037860] xhci_hcd 0003:01:00.0:         (ptrval) port link reg = 0x0
[    1.037862] xhci_hcd 0003:01:00.0:         (ptrval) port reserved reg = 0x0
[    1.037865] xhci_hcd 0003:01:00.0:         (ptrval) port status reg = 0x2a0
[    1.037868] xhci_hcd 0003:01:00.0:         (ptrval) port power reg = 0x0
[    1.037870] xhci_hcd 0003:01:00.0:         (ptrval) port link reg = 0x0
[    1.037873] xhci_hcd 0003:01:00.0:         (ptrval) port reserved reg = 0x0
[    1.037876] xhci_hcd 0003:01:00.0:         (ptrval) port status reg = 0xe03
[    1.037878] xhci_hcd 0003:01:00.0:         (ptrval) port power reg = 0x0
[    1.037881] xhci_hcd 0003:01:00.0:         (ptrval) port link reg = 0x0
[    1.037884] xhci_hcd 0003:01:00.0:         (ptrval) port reserved reg = 0x0
[    1.037886] xhci_hcd 0003:01:00.0:         (ptrval) port status reg = 0xe03
[    1.037889] xhci_hcd 0003:01:00.0:         (ptrval) port power reg = 0x0
[    1.037892] xhci_hcd 0003:01:00.0:         (ptrval) port link reg = 0x0
[    1.037894] xhci_hcd 0003:01:00.0:         (ptrval) port reserved reg = 0x0
[    1.037897] xhci_hcd 0003:01:00.0:         (ptrval) port status reg = 0x2a0
[    1.037900] xhci_hcd 0003:01:00.0:         (ptrval) port power reg = 0x0
[    1.037902] xhci_hcd 0003:01:00.0:         (ptrval) port link reg = 0x0
[    1.037905] xhci_hcd 0003:01:00.0:         (ptrval) port reserved reg = 0x0
[    1.037908] xhci_hcd 0003:01:00.0:         (ptrval) port status reg = 0x2a0
[    1.037910] xhci_hcd 0003:01:00.0:         (ptrval) port power reg = 0x0
[    1.037913] xhci_hcd 0003:01:00.0:         (ptrval) port link reg = 0x0
[    1.037916] xhci_hcd 0003:01:00.0:         (ptrval) port reserved reg = 0x0
[    1.037918] xhci_hcd 0003:01:00.0:         (ptrval) port status reg = 0x2a0
[    1.037921] xhci_hcd 0003:01:00.0:         (ptrval) port power reg = 0x0
[    1.037924] xhci_hcd 0003:01:00.0:         (ptrval) port link reg = 0x0
[    1.037926] xhci_hcd 0003:01:00.0:         (ptrval) port reserved reg = 0x0
[    1.037929] xhci_hcd 0003:01:00.0:         (ptrval) port status reg = 0x2a0
[    1.037931] xhci_hcd 0003:01:00.0:         (ptrval) port power reg = 0x0
[    1.037934] xhci_hcd 0003:01:00.0:         (ptrval) port link reg = 0x0
[    1.037937] xhci_hcd 0003:01:00.0:         (ptrval) port reserved reg = 0x0
[    1.037939] xhci_hcd 0003:01:00.0: // Halt the HC
[    1.053945] xhci_hcd 0003:01:00.0: Host halt failed, -110
[    1.053987] xhci_hcd 0003:01:00.0: can't setup: -110
[    1.054032] xhci_hcd 0003:01:00.0: USB bus 1 deregistered
[    1.054099] xhci_hcd 0003:01:00.0: init 0003:01:00.0 fail, -110
[    1.054165] xhci_hcd: probe of 0003:01:00.0 failed with error -110
