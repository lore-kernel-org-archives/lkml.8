Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A4EC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FEF7214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587051795;
	bh=f5G/PgNlQLorwMRYwCChGgzk+9oz/wHoIFMd326/k2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JZHVK9biR0nCmPoVNipdEt01u9P8cM4ePY0LZf9ab5o1pvGIPT4j6H48zrortg8q6
	 h1X9r29vx36WZ1r2oZp9IkbM7Tkhp7dTGPzmJYquVwYz4EjWzv//rqzvthaYYs47qA
	 F/2p4F0gwFKXlNs7rVMHNFMkQh0j0spczg3O22FQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395554AbgDPPnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:43:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895932AbgDPNgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:36:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8007A21BE5;
        Thu, 16 Apr 2020 13:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044161;
        bh=f5G/PgNlQLorwMRYwCChGgzk+9oz/wHoIFMd326/k2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=js2SSNIV20iKLaH6M9eTzDrBCPIcJZwNZLHqRwTj/sYWgUFH9T0W+STZtk5e4lZ74
         Sjc1v6OTGH68ipjnaD3c1P1jvCzbkJ1TaGuUF6aZ4NnsZhg4ubo6Y0ZcllgNEvLNa7
         1l81gdj0zQ1L+el4wTkdy+OYkvfZYfUeihuSyIy8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 5.5 104/257] seccomp: Add missing compat_ioctl for notify
Date:   Thu, 16 Apr 2020 15:22:35 +0200
Message-Id: <20200416131339.134491351@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.891903893@linuxfoundation.org>
References: <20200416131325.891903893@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Schnelle <svens@linux.ibm.com>

commit 3db81afd99494a33f1c3839103f0429c8f30cb9d upstream.

Executing the seccomp_bpf testsuite under a 64-bit kernel with 32-bit
userland (both s390 and x86) doesn't work because there's no compat_ioctl
handler defined. Add the handler.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Fixes: 6a21cc50f0c7 ("seccomp: add a return code to trap to userspace")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20200310123332.42255-1-svens@linux.ibm.com
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/seccomp.c |    1 +
 1 file changed, 1 insertion(+)

--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1221,6 +1221,7 @@ static const struct file_operations secc
 	.poll = seccomp_notify_poll,
 	.release = seccomp_notify_release,
 	.unlocked_ioctl = seccomp_notify_ioctl,
+	.compat_ioctl = seccomp_notify_ioctl,
 };
 
 static struct file *init_listener(struct seccomp_filter *filter)


