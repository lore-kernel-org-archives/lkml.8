Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE2CC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE082073C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581609707;
	bh=IhO7+4+gxU3KVcljasvSNdPaZ+h364bd1dgtWTohQgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1/ASAL1nWpz8CBj/+8qbUNLDzvso2rjMeaZRZ4pV+px+6Qhb07AL/AnTKoCLRJ66J
	 V00FVC+oSY92sHdrNXBvzzq/YmIEiVBWDMMI+5LtuVEU1bg/+0vreOHg+szjMT6w6C
	 vxrNJqWvLIBgxq0AFkrH6EQsn5yICZBidlEpg9h0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbgBMQBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:01:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:38534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728742AbgBMPYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:24:37 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F3A02469A;
        Thu, 13 Feb 2020 15:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607474;
        bh=IhO7+4+gxU3KVcljasvSNdPaZ+h364bd1dgtWTohQgo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vquVU+SFQ/x3SEfBoUw1czvL0BsRsBBq7pvLrD+X+Wgp6MqRPSJnn2NO0VaE/Ruuh
         SbbHFFKjCromq5xBiAHDq9xIEQ6+HBR9EfTQhEybyrW82NgRUg/c3sf+5A9XhriHvk
         BwEKmgJpvJgRqp/w+L+uTxPyhP439bxt3qbzRem0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Rich Felker <dalias@libc.org>, libc-alpha@sourceware.org,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 005/173] sparc32: fix struct ipc64_perm type definition
Date:   Thu, 13 Feb 2020 07:18:28 -0800
Message-Id: <20200213151933.560566397@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151931.677980430@linuxfoundation.org>
References: <20200213151931.677980430@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 34ca70ef7d3a9fa7e89151597db5e37ae1d429b4 ]

As discussed in the strace issue tracker, it appears that the sparc32
sysvipc support has been broken for the past 11 years. It was however
working in compat mode, which is how it must have escaped most of the
regular testing.

The problem is that a cleanup patch inadvertently changed the uid/gid
fields in struct ipc64_perm from 32-bit types to 16-bit types in uapi
headers.

Both glibc and uclibc-ng still use the original types, so they should
work fine with compat mode, but not natively.  Change the definitions
to use __kernel_uid32_t and __kernel_gid32_t again.

Fixes: 83c86984bff2 ("sparc: unify ipcbuf.h")
Link: https://github.com/strace/strace/issues/116
Cc: <stable@vger.kernel.org> # v2.6.29
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: "Dmitry V . Levin" <ldv@altlinux.org>
Cc: Rich Felker <dalias@libc.org>
Cc: libc-alpha@sourceware.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sparc/include/uapi/asm/ipcbuf.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/sparc/include/uapi/asm/ipcbuf.h b/arch/sparc/include/uapi/asm/ipcbuf.h
index 9d0d125500e24..084b8949ddff6 100644
--- a/arch/sparc/include/uapi/asm/ipcbuf.h
+++ b/arch/sparc/include/uapi/asm/ipcbuf.h
@@ -15,19 +15,19 @@
 
 struct ipc64_perm
 {
-	__kernel_key_t	key;
-	__kernel_uid_t	uid;
-	__kernel_gid_t	gid;
-	__kernel_uid_t	cuid;
-	__kernel_gid_t	cgid;
+	__kernel_key_t		key;
+	__kernel_uid32_t	uid;
+	__kernel_gid32_t	gid;
+	__kernel_uid32_t	cuid;
+	__kernel_gid32_t	cgid;
 #ifndef __arch64__
-	unsigned short	__pad0;
+	unsigned short		__pad0;
 #endif
-	__kernel_mode_t	mode;
-	unsigned short	__pad1;
-	unsigned short	seq;
-	unsigned long long __unused1;
-	unsigned long long __unused2;
+	__kernel_mode_t		mode;
+	unsigned short		__pad1;
+	unsigned short		seq;
+	unsigned long long	__unused1;
+	unsigned long long	__unused2;
 };
 
 #endif /* __SPARC_IPCBUF_H */
-- 
2.20.1



