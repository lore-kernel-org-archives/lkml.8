Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50334C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BB17206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598261612;
	bh=f75tl17vxQarEIOmbQCAPyjN44tFzQmDBYKWO4ULK34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YfW8nFt4Kr5YjYfGPHG1e9jHWrAi1pZwuc29srEJ/f9SGwJ1Q0JvTx1iylb89jb5M
	 sYvC2+QNf/mqFL+mrDkBRKisJnkjk4gUWpxg+Sfn/h4eeDJnjnbrxKkyzM8GaCpy/M
	 ThDuDm8+k0xSmU+YaWk90f9LwCpuNcSJ9jmosKp0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbgHXJdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:33:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728661AbgHXItr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:49:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 425C02075B;
        Mon, 24 Aug 2020 08:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258986;
        bh=f75tl17vxQarEIOmbQCAPyjN44tFzQmDBYKWO4ULK34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cw6H7NrDuXldc+a4TguUiUtyEP5UBwc3MCf9gpfiikW8O/Q7PzdWb7H4V1x41ugvD
         u9z3ZaLwbwPkuB58ch/pawMYK1l2cCZ0zreqBZWr/84EPymeZmOfKO+/yvHzWDpz9O
         CpvgHXJwhaQR8JsSwsaqOUUnAin6oWUy1L7IhCjg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Sargun Dhillon <sargun@sargun.me>,
        Jakub Kicinski <kuba@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 03/33] net/compat: Add missing sock updates for SCM_RIGHTS
Date:   Mon, 24 Aug 2020 10:30:59 +0200
Message-Id: <20200824082346.694200004@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082346.498653578@linuxfoundation.org>
References: <20200824082346.498653578@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

[ Upstream commit d9539752d23283db4692384a634034f451261e29 ]

Add missed sock updates to compat path via a new helper, which will be
used more in coming patches. (The net/core/scm.c code is left as-is here
to assist with -stable backports for the compat path.)

Cc: Christoph Hellwig <hch@lst.de>
Cc: Sargun Dhillon <sargun@sargun.me>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: stable@vger.kernel.org
Fixes: 48a87cc26c13 ("net: netprio: fd passed in SCM_RIGHTS datagram not set correctly")
Fixes: d84295067fc7 ("net: net_cls: fd passed in SCM_RIGHTS datagram not set correctly")
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/sock.h |  4 ++++
 net/compat.c       |  1 +
 net/core/sock.c    | 21 +++++++++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index 426a57874964c..31198b32d9122 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -779,6 +779,8 @@ static inline int sk_memalloc_socks(void)
 {
 	return static_key_false(&memalloc_socks);
 }
+
+void __receive_sock(struct file *file);
 #else
 
 static inline int sk_memalloc_socks(void)
@@ -786,6 +788,8 @@ static inline int sk_memalloc_socks(void)
 	return 0;
 }
 
+static inline void __receive_sock(struct file *file)
+{ }
 #endif
 
 static inline gfp_t sk_gfp_atomic(const struct sock *sk, gfp_t gfp_mask)
diff --git a/net/compat.c b/net/compat.c
index d676840104556..20c5e5f215f23 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -284,6 +284,7 @@ void scm_detach_fds_compat(struct msghdr *kmsg, struct scm_cookie *scm)
 			break;
 		}
 		/* Bump the usage count and install the file. */
+		__receive_sock(fp[i]);
 		fd_install(new_fd, get_file(fp[i]));
 	}
 
diff --git a/net/core/sock.c b/net/core/sock.c
index 120d5058d81ae..82f9a7dbea6fe 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2275,6 +2275,27 @@ int sock_no_mmap(struct file *file, struct socket *sock, struct vm_area_struct *
 }
 EXPORT_SYMBOL(sock_no_mmap);
 
+/*
+ * When a file is received (via SCM_RIGHTS, etc), we must bump the
+ * various sock-based usage counts.
+ */
+void __receive_sock(struct file *file)
+{
+	struct socket *sock;
+	int error;
+
+	/*
+	 * The resulting value of "error" is ignored here since we only
+	 * need to take action when the file is a socket and testing
+	 * "sock" for NULL is sufficient.
+	 */
+	sock = sock_from_file(file, &error);
+	if (sock) {
+		sock_update_netprioidx(sock->sk);
+		sock_update_classid(sock->sk);
+	}
+}
+
 ssize_t sock_no_sendpage(struct socket *sock, struct page *page, int offset, size_t size, int flags)
 {
 	ssize_t res;
-- 
2.25.1



