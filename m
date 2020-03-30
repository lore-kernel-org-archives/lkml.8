Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48096C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 12:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A2FA20578
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 12:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5v7lEOo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbgC3M3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 08:29:17 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:36042 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729848AbgC3M3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 08:29:16 -0400
Received: by mail-pj1-f68.google.com with SMTP id nu11so7253465pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 05:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=hAiEGZFAPR7yY7HqmNob4q5rIrKXb8NQdzjtqRsLNn0=;
        b=I5v7lEOoUQ9CrYhc5oRSWY2AaHTdVvtimdMMcoyzhQiy2xPizH2hDUeUZrdLcHzUTm
         SgAd2NV3k8fsMa9o0UA1c7mOlqqjP75ZWzEWaGcj7u8GJrMf1kBUTwY1SIB3jypN2IOM
         VcSP5DG+ImvuVFgA/p7hK9v+y0uGJnb7LA86lKTwHPxsk4bstU3QnJNALy0MCUgncS5/
         BAr65nrPBwhOvcgBF3JVE5hS1LdwabyojZAddrOZjV93WGcv9nyXXCQGjxqdQkLLXAq9
         Abtn7bfD09cfeO8x5Em0WU1osXYpQTxJ5MkKkonXeFh24gNPIlcROCT0bAd3hln7ZgFS
         MxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hAiEGZFAPR7yY7HqmNob4q5rIrKXb8NQdzjtqRsLNn0=;
        b=CRJOkdr2h8/i/9ZpuCExPiJfl26fQZRENTqFlIFT84ViFaBRw8iXc6K69gTDGir9jf
         6/GWeTUgacJ18UGTsuUGGfwByFQ7jymk8mYMF5nFu3wecK7wl6vBbD27qOA7/t2Ir94x
         L1IIiiFhzzzDgaYfrm7LmqoGHfJTu2TRvicMvULih3MOXUxmimmpasa/c95bLp0Q6WIm
         3gBCOWT/xxmDjDfa8Bbq5DpnusFzKEzxYEbg7VLkjWUKC8xERVszFqt5QG6u4VYX7gbu
         anSFIj8GYrptuJ6tVFIHwWYTNnC6bI4qY2t83wBBmAxs0N7EPx7vW6n7RJWGOcP7863W
         1LzQ==
X-Gm-Message-State: ANhLgQ3p+8+LAL0tS5vLqqnhAA6mziwLgaoch9I0ZcwnIJBqVl3pw/ev
        tqQZAUwUd705MA20jwUvbg0=
X-Google-Smtp-Source: ADFU+vsFVmSAL/TTDVfATJufFaby/BbS34cF5UpxX38Hc3k3yrQwURLYOsQ+szUTmmgPlUBTT3QYww==
X-Received: by 2002:a17:90a:9408:: with SMTP id r8mr16084801pjo.15.1585571355502;
        Mon, 30 Mar 2020 05:29:15 -0700 (PDT)
Received: from cosmos ([122.172.172.253])
        by smtp.gmail.com with ESMTPSA id x4sm9025275pga.54.2020.03.30.05.29.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Mar 2020 05:29:15 -0700 (PDT)
Date:   Mon, 30 Mar 2020 17:59:10 +0530
From:   Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] x86: fix build warning int-to-pointer-cast
Message-ID: <20200330122906.GA2274@cosmos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed build warning int-to-pointer-cast arising from
x86/boot/compressed/acpi.c while casting return value of
get_cmdline_acpi_rsdp(). Culprit line -
rsdp = (struct acpi_table_rsdp *)get_cmdline_acpi_rsdp();

Signed-off-by: Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
---
 arch/x86/boot/compressed/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 7619742..216a7c2 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -88,6 +88,7 @@ ifdef CONFIG_X86_64
 	vmlinux-objs-y += $(obj)/pgtable_64.o
 endif
 
+CFLAGS_acpi.o := -Wno-int-to-pointer-cast
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
 
 vmlinux-objs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
-- 
2.7.4

