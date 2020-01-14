Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11D7C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEFA424676
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578996368;
	bh=LmySiv9v38Hu478RVBjfEARaYj4GudwdzSzApzt0T2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vFXfFTGsDvs5KEXkTJve2SF3MF76UgTcjXRCsQiHEhquE2LPPUZit6Vm/hc29rmFQ
	 NmvVKkKOaKs0uSb/U5vEuNPhnE5FFhPktbM7EG4aBNiKDlWksclnZui2HJAGfI0lKp
	 /qfxDT1f+DITA6exJn/cLR95y/A4BPhqDMHS+fTc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbgANKGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:06:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:34830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730291AbgANKGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:06:05 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F22224680;
        Tue, 14 Jan 2020 10:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996364;
        bh=LmySiv9v38Hu478RVBjfEARaYj4GudwdzSzApzt0T2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FQeaCtiRJuc8Fbgc1u+H808++Cr47X2jxy2yylvNdkgR2WkBiXJjL/9Jny3PKxK0e
         3HRvX//DEPcH5l714PSMw1P0TglRKH2tcqaQRxFxzsfxyOEyHKWAUwn0Xhd8QCub02
         wJ0yLzrxLSvpnHk062F1L5MPAY5c8gRHJlr7sibM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amanieu dAntras <amanieu@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 5.4 63/78] clone3: ensure copy_thread_tls is implemented
Date:   Tue, 14 Jan 2020 11:01:37 +0100
Message-Id: <20200114094401.878025357@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094352.428808181@linuxfoundation.org>
References: <20200114094352.428808181@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amanieu d'Antras <amanieu@gmail.com>

commit dd499f7a7e34270208350a849ef103c0b3ae477f upstream.

copy_thread implementations handle CLONE_SETTLS by reading the TLS
value from the registers containing the syscall arguments for
clone. This doesn't work with clone3 since the TLS value is passed
in clone_args instead.

Signed-off-by: Amanieu d'Antras <amanieu@gmail.com>
Cc: <stable@vger.kernel.org> # 5.3.x
Link: https://lore.kernel.org/r/20200102172413.654385-8-amanieu@gmail.com
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/fork.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2513,6 +2513,16 @@ SYSCALL_DEFINE5(clone, unsigned long, cl
 #endif
 
 #ifdef __ARCH_WANT_SYS_CLONE3
+
+/*
+ * copy_thread implementations handle CLONE_SETTLS by reading the TLS value from
+ * the registers containing the syscall arguments for clone. This doesn't work
+ * with clone3 since the TLS value is passed in clone_args instead.
+ */
+#ifndef CONFIG_HAVE_COPY_THREAD_TLS
+#error clone3 requires copy_thread_tls support in arch
+#endif
+
 noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
 					      struct clone_args __user *uargs,
 					      size_t usize)


