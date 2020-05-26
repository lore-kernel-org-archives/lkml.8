Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB68C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AFCC20776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590521340;
	bh=vD3ADbr1Zccmx5ykNzvoraO+GxJdQixrS8frIfvHzRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RZBbSnYp+zzM6vzKW/mCouyi0fGgXYjFBYKmjO8mB5u7PPaWHCnSLNlnZZeIYjORj
	 MuS2Hjbi1LBpJt6Y6NsKCiR+GCko3qmQmfZM/ypP5mers945ZbpV52PefKzNVcXSP7
	 Qn67gk2BU6u2mS3jNV+ZTaQ477r/kS4IdpflBGFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392563AbgEZT26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:28:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:57046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390433AbgEZTCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:02:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB75520873;
        Tue, 26 May 2020 19:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519739;
        bh=vD3ADbr1Zccmx5ykNzvoraO+GxJdQixrS8frIfvHzRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D3o6r4UcgQwkBzPnRielqR7X/2kN/OrTd2vejfJwLk7D+2ltxuKZwOaD2RlwdPyHD
         ejOk2dBpDR77cp9tzhwOIalWQDomyO/IaHkoytsowJ7Fsk2i/E6jvD7DRTRUYWncN6
         i2EIbbaHlza39X4YNvbPnQuaiLGIWrI2Mmm2+oao=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 30/59] arm64: fix the flush_icache_range arguments in machine_kexec
Date:   Tue, 26 May 2020 20:53:15 +0200
Message-Id: <20200526183917.984927337@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183907.123822792@linuxfoundation.org>
References: <20200526183907.123822792@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

Commit d51c214541c5154dda3037289ee895ea3ded5ebd upstream.

The second argument is the end "pointer", not the length.

Fixes: d28f6df1305a ("arm64/kexec: Add core kexec support")
Cc: <stable@vger.kernel.org> # 4.8.x-
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/machine_kexec.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -184,7 +184,8 @@ void machine_kexec(struct kimage *kimage
 	/* Flush the reboot_code_buffer in preparation for its execution. */
 	__flush_dcache_area(reboot_code_buffer, arm64_relocate_new_kernel_size);
 	flush_icache_range((uintptr_t)reboot_code_buffer,
-		arm64_relocate_new_kernel_size);
+			   (uintptr_t)reboot_code_buffer +
+			   arm64_relocate_new_kernel_size);
 
 	/* Flush the kimage list and its buffers. */
 	kexec_list_flush(kimage);


