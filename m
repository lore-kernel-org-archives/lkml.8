Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF26AC33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCD8720704
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686810;
	bh=Q5653fpa3ijpZTYcOhg1IEB8ey1XF1cto6FMBRl6nvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YPkepcXu4CnXI6jN4Zl45Fd8RZc7G9SVAfSx3/4dpCGaQ+f4LUfAs+HVl3NFNR9mQ
	 mxt1r1H32I+Z7qi7Nh7mA0K9wHASOoL9uCvJCPWuduXqaeUSBN+/Le7tUxe3SywamY
	 sRW4Ne5NE2oLpN5LIi9gOl3Ca2iDuQJHaIL4Qgrk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730656AbgAVJfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:35:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:50078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731123AbgAVJfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:35:10 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 077C32071E;
        Wed, 22 Jan 2020 09:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685709;
        bh=Q5653fpa3ijpZTYcOhg1IEB8ey1XF1cto6FMBRl6nvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H/fTuUWyy64Y/0xUb3mYdpHc+JPfPM8NTVb9YAysBY3HTMzNSSKuOO7tcZ3K1gVXv
         66hhLmd5MD3VApw3579ohGiQkPPiqUOfMSd03Op8mnvdb3grINZUWgS/xhdaNtJh4E
         6xe31hGN9/0CNs2oXPd3K1vUEH8PnkTVMgE/hI2M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jouni Hogander <jouni.hogander@unikie.com>,
        Paul Burton <paulburton@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-mips@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 46/97] MIPS: Prevent link failure with kcov instrumentation
Date:   Wed, 22 Jan 2020 10:28:50 +0100
Message-Id: <20200122092803.929005812@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092755.678349497@linuxfoundation.org>
References: <20200122092755.678349497@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jouni Hogander <jouni.hogander@unikie.com>

[ Upstream commit a4a3893114a41e365274d5fab5d9ff5acc235ff0 ]

__sanitizer_cov_trace_pc() is not linked in and causing link
failure if KCOV_INSTRUMENT is enabled. Fix this by disabling
instrumentation for compressed image.

Signed-off-by: Jouni Hogander <jouni.hogander@unikie.com>
Signed-off-by: Paul Burton <paulburton@kernel.org>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: linux-mips@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/boot/compressed/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index ad31c76c7a29..2f77e250b91d 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -29,6 +29,9 @@ KBUILD_AFLAGS := $(LINUXINCLUDE) $(KBUILD_AFLAGS) -D__ASSEMBLY__ \
 	-DBOOT_HEAP_SIZE=$(BOOT_HEAP_SIZE) \
 	-DKERNEL_ENTRY=$(VMLINUX_ENTRY_ADDRESS)
 
+# Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
+KCOV_INSTRUMENT		:= n
+
 # decompressor objects (linked with vmlinuz)
 vmlinuzobjs-y := $(obj)/head.o $(obj)/decompress.o $(obj)/string.o
 
-- 
2.20.1



