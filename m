Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DE4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 06:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A49E72077D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 06:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="Hx7glFFa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgGJGeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 02:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727871AbgGJGd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 02:33:59 -0400
Received: from vultr.net.flygoat.com (vultr.net.flygoat.com [IPv6:2001:19f0:6001:3633:5400:2ff:fe8c:553])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C08C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 23:33:59 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2001:da8:20f:4430:250:56ff:fe9a:7470])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id EED5E1FF18;
        Fri, 10 Jul 2020 06:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1594362838; bh=k4tTRKe0YcW9MuCAbiRePPA3r0/yfJjA+o3AHhYVve0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hx7glFFaP226ppsZTavLI+KYfcucuncxjrYH3DHF6fg+JZspH/AV0K4mDoLoCjyii
         pX89roUu8CB8UCCSo1Rs37Xf6qbIHfodqpNoUkGM5tRKoOUUi/mX/ZjRO/yn7mTPaE
         zP/FY3rqQ5qREF31tnubfVBnD32BvOWBecQkYytS5wQLrqBQgPkPOSDrQ+2O+2toyI
         /h6S/l9a/PQCTk5g6htWa5h/h+n2di1BG4VsvZf7OCIgI7l8iScduZ2ESr61OyFsso
         21/QFSwehpOrkBxXlARXmtNzTRaJmAWYizJhrMqQQyhc2ghKSMXYcP3hcACvnzjIEz
         YMKwj/+L0D1Vw==
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Paul Burton <paulburton@kernel.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: [RFC PATCH 3/3] MIPS: KVM: Remove outdated README
Date:   Fri, 10 Jul 2020 14:30:18 +0800
Message-Id: <20200710063047.154611-4-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710063047.154611-1-jiaxun.yang@flygoat.com>
References: <20200710063047.154611-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file was created long ago and information inside is
obviously outdated.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/kvm/00README.txt | 31 -------------------------------
 1 file changed, 31 deletions(-)
 delete mode 100644 arch/mips/kvm/00README.txt

diff --git a/arch/mips/kvm/00README.txt b/arch/mips/kvm/00README.txt
deleted file mode 100644
index 51617e481aa3..000000000000
--- a/arch/mips/kvm/00README.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-KVM/MIPS Trap & Emulate Release Notes
-=====================================
-
-(1) KVM/MIPS should support MIPS32R2 and beyond. It has been tested on the following platforms:
-    Malta Board with FPGA based 34K
-    Sigma Designs TangoX board with a 24K based 8654 SoC.
-    Malta Board with 74K @ 1GHz
-
-(2) Both Guest kernel and Guest Userspace execute in UM.
-    Guest User address space:   0x00000000 -> 0x40000000
-    Guest Kernel Unmapped:      0x40000000 -> 0x60000000
-    Guest Kernel Mapped:        0x60000000 -> 0x80000000
-
-    Guest Usermode virtual memory is limited to 1GB.
-
-(2) 16K Page Sizes: Both Host Kernel and Guest Kernel should have the same page size, currently at least 16K.
-    Note that due to cache aliasing issues, 4K page sizes are NOT supported.
-
-(3) No HugeTLB Support
-    Both the host kernel and Guest kernel should have the page size set to 16K.
-    This will be implemented in a future release.
-
-(4) KVM/MIPS does not have support for SMP Guests
-    Linux-3.7-rc2 based SMP guest hangs due to the following code sequence in the generated TLB handlers:
-	LL/TLBP/SC.  Since the TLBP instruction causes a trap the reservation gets cleared
-	when we ERET back to the guest. This causes the guest to hang in an infinite loop.
-	This will be fixed in a future release.
-
-(5) Use Host FPU
-    Currently KVM/MIPS emulates a 24K CPU without a FPU.
-    This will be fixed in a future release
-- 
2.27.0

