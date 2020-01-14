Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DFFC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 815DC2467E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578996332;
	bh=0cdLB7wehuBT3ubfoI3yEb17IXH1TWYAp5f76Ckw7m4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zAv7nKFuuG6lqhgEeTuFyyy4Sb+BRKHnOR/MtDcoZ/w/tPRAWg7wM8ay1MFdt244/
	 1qamV36j2P5AYGG5lgndY5XPIJ8BHio4IxbSV4QzZZTDriBaGhVdZ+r52pPu1BAc3L
	 5mb8eCpaWXDDPlgOFMboBA+jWY0kl5bkqQk0t/lI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730138AbgANKFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:05:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:33524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729359AbgANKF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:05:27 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33E0B2467E;
        Tue, 14 Jan 2020 10:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996326;
        bh=0cdLB7wehuBT3ubfoI3yEb17IXH1TWYAp5f76Ckw7m4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=apxZPinOJ4E9dFBnHe/qYu71RzNQ7p9rZY1sOx2plVDx7nh5Dx8TgE9sqtu5cv3ju
         vIriXsc/+RwVHJDfCjCthAaQ0H7G+2AMkNNl1tf+C/dBTj8NIvrR3LM6JhekCbVqK8
         BnMtUQ853VF1TAQ1jrGjsQgkVTzhJcCeJLkGzjIo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amanieu dAntras <amanieu@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 5.4 57/78] arm64: Move __ARCH_WANT_SYS_CLONE3 definition to uapi headers
Date:   Tue, 14 Jan 2020 11:01:31 +0100
Message-Id: <20200114094401.111792585@linuxfoundation.org>
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

commit 3e3c8ca5a351350031f0f3d5ecedf7048b1b9008 upstream.

Previously this was only defined in the internal headers which
resulted in __NR_clone3 not being defined in the user headers.

Signed-off-by: Amanieu d'Antras <amanieu@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: <stable@vger.kernel.org> # 5.3.x
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20200102172413.654385-2-amanieu@gmail.com
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/include/asm/unistd.h      |    1 -
 arch/arm64/include/uapi/asm/unistd.h |    1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -42,7 +42,6 @@
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
-#define __ARCH_WANT_SYS_CLONE3
 
 #ifndef __COMPAT_SYSCALL_NR
 #include <uapi/asm/unistd.h>
--- a/arch/arm64/include/uapi/asm/unistd.h
+++ b/arch/arm64/include/uapi/asm/unistd.h
@@ -19,5 +19,6 @@
 #define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_SET_GET_RLIMIT
 #define __ARCH_WANT_TIME32_SYSCALLS
+#define __ARCH_WANT_SYS_CLONE3
 
 #include <asm-generic/unistd.h>


