Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2277EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB6B3207DA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DNDleAo0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgGIS1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 14:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbgGIS0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 14:26:51 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E877C08E886
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 11:26:51 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k5so1153722plk.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 11:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JDLlch6jQ6b/Ci4KTwYO3yaCS+hjAOCVDzfUIy5QEwQ=;
        b=DNDleAo0uMHf7/DTXLL/i2S24PvXDPvlQ14Ivr2titwFCsKNgi+Kv/vKbnaXprb6f1
         chcoIAKkLN9//ppx4zyPvXEqToxeppaTc44FyNcsYcs2zXewo1+29WB3m2ouuFmQ3vud
         vI+jn29PW0Sf+mrlVCIaa3TsiU1811viEuh3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JDLlch6jQ6b/Ci4KTwYO3yaCS+hjAOCVDzfUIy5QEwQ=;
        b=gbQ23ZFEbb5Ifzrcr8GGyd4Zj7EdxuZGEnqNmWrKw0aFcIJpCFXsCABig+bP+Fapgu
         jM0dIqrBOofFNlUhdUJ9p5sksfNDMXi2hTirTP7FSo0/IrCOnOCsAdkjy2h2dxPK4FMg
         u6E3RoAKyHzQw5BSWiW/SAznoXmUigb6BcPpQtbT6k/7kFnXxDWO0/EMXS2AeB7myMaa
         58T00JR+bX/lA9yDTQ84nD6jq4/QnPkamXhi9eH0Re3vr3rv/6Wdx1MtiWtLlQ+5G0VO
         qnSwr7yQmeQ5cAZyIv8l0KR10to6qRI9RdHdevDwGA9oqszct1gSnDa13p6OEKXCZcEc
         R7CA==
X-Gm-Message-State: AOAM533tpv3AP7Fb3+r44TpsZvv7W/HgqPfJQK3ubpi0i9HO3HE8POej
        pxaWOsUAEAXGVLfuxGpCibEFAQ==
X-Google-Smtp-Source: ABdhPJyA+Ic2E+z6uMO1UTG3SkSJOCj/9RBjg+eRJHv5onUU1yxGvD5dA+aRgVJ0h36ibNdtF7idTw==
X-Received: by 2002:a17:90a:f206:: with SMTP id bs6mr1490003pjb.48.1594319210806;
        Thu, 09 Jul 2020 11:26:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z1sm3429471pgk.89.2020.07.09.11.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 11:26:47 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Laight <David.Laight@ACULAB.COM>,
        Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Matt Denton <mpdenton@google.com>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Robert Sesek <rsesek@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v7 1/9] net/compat: Add missing sock updates for SCM_RIGHTS
Date:   Thu,  9 Jul 2020 11:26:34 -0700
Message-Id: <20200709182642.1773477-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200709182642.1773477-1-keescook@chromium.org>
References: <20200709182642.1773477-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missed sock updates to compat path via a new helper, which will be
used more in coming patches. (The net/core/scm.c code is left as-is here
to assist with -stable backports for the compat path.)

Cc: stable@vger.kernel.org
Fixes: 48a87cc26c13 ("net: netprio: fd passed in SCM_RIGHTS datagram not set correctly")
Fixes: d84295067fc7 ("net: net_cls: fd passed in SCM_RIGHTS datagram not set correctly")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/net/sock.h |  4 ++++
 net/compat.c       |  1 +
 net/core/sock.c    | 21 +++++++++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index c53cc42b5ab9..2be67f1ee8b1 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -890,6 +890,8 @@ static inline int sk_memalloc_socks(void)
 {
 	return static_branch_unlikely(&memalloc_socks_key);
 }
+
+void __receive_sock(struct file *file);
 #else
 
 static inline int sk_memalloc_socks(void)
@@ -897,6 +899,8 @@ static inline int sk_memalloc_socks(void)
 	return 0;
 }
 
+static inline void __receive_sock(struct file *file)
+{ }
 #endif
 
 static inline gfp_t sk_gfp_mask(const struct sock *sk, gfp_t gfp_mask)
diff --git a/net/compat.c b/net/compat.c
index 5e3041a2c37d..2937b816107d 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -309,6 +309,7 @@ void scm_detach_fds_compat(struct msghdr *kmsg, struct scm_cookie *scm)
 			break;
 		}
 		/* Bump the usage count and install the file. */
+		__receive_sock(fp[i]);
 		fd_install(new_fd, get_file(fp[i]));
 	}
 
diff --git a/net/core/sock.c b/net/core/sock.c
index 6c4acf1f0220..bde394979041 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2840,6 +2840,27 @@ int sock_no_mmap(struct file *file, struct socket *sock, struct vm_area_struct *
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
+		sock_update_netprioidx(&sock->sk->sk_cgrp_data);
+		sock_update_classid(&sock->sk->sk_cgrp_data);
+	}
+}
+
 ssize_t sock_no_sendpage(struct socket *sock, struct page *page, int offset, size_t size, int flags)
 {
 	ssize_t res;
-- 
2.25.1

