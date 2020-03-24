Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE2BC41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2708C20714
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=jiaxun.yang@flygoat.com header.b="SgUP4D36"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgCXPlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:41:06 -0400
Received: from sender3-op-o12.zoho.com.cn ([124.251.121.243]:17804 "EHLO
        sender3-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727724AbgCXPlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1585064385;
        s=mail; d=flygoat.com; i=jiaxun.yang@flygoat.com;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=9Rcu36G6rAVdZubjv9nlWJ08myU9AyosJCykkETK6LQ=;
        b=SgUP4D369C7SKyMXxahyltWu5BVmrAk2rj7jc//i9zPZLh4IHz4Z5KHrNhvFzwPf
        oaaTjwURl/0hiUzf7p+8VqUsHPbI5SnBJj/1sZw4xU0bVfplETP3vHBaIZIkaLzvCrY
        oueWeGjdZUoj2xxZz4LQj7WhZjm5C2wgFIRgcSt0=
Received: from localhost.localdomain (39.155.141.144 [39.155.141.144]) by mx.zoho.com.cn
        with SMTPS id 15850643829481008.2720751464285; Tue, 24 Mar 2020 23:39:42 +0800 (CST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Message-ID: <20200324153624.23109-12-jiaxun.yang@flygoat.com>
Subject: [PATCH v6 11/11] MIPS: Loongson64: Move MIPS_CPU_IRQ_BASE
Date:   Tue, 24 Mar 2020 23:36:08 +0800
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200324153624.23109-1-jiaxun.yang@flygoat.com>
References: <20200324153624.23109-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prevent CPU IRQ collide with PCH IRQ, we move down
CPU IRQ BASE to 16.

Co-developed-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/mach-loongson64/irq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/mach-loongson64/irq.h b/arch/mips/includ=
e/asm/mach-loongson64/irq.h
index d41dc4a76e6d..0041bd490ab8 100644
--- a/arch/mips/include/asm/mach-loongson64/irq.h
+++ b/arch/mips/include/asm/mach-loongson64/irq.h
@@ -5,7 +5,7 @@
 #include <boot_param.h>
=20
 /* cpu core interrupt numbers */
-#define MIPS_CPU_IRQ_BASE 56
+#define MIPS_CPU_IRQ_BASE 16
=20
 #include <asm/mach-generic/irq.h>
=20
--=20
2.26.0.rc2


