Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA63C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B0582073A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587551839;
	bh=TXZIIcAEiQ/wpsaKSiN6BSXBSoCued4W7EnX5YJPXsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lze5R4VUl3A54OcGBoJYM9a+iKTwmlVPx3w8cKEGf03G3yfZqGwYVgn9cNk9ud/DB
	 /KBsboUCNE+Z+RN/ypdGsKV8Qr5p/1eWXLPqSPg7/l3JMrsuEqCg9GK7KUZtJlN9TK
	 chyHRdvwMAtCUzMpwu7f3qLDRcBS9IQ6ZVJotQ+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgDVKWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:22:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:55338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730017AbgDVKSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:18:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CEEA2070B;
        Wed, 22 Apr 2020 10:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550726;
        bh=TXZIIcAEiQ/wpsaKSiN6BSXBSoCued4W7EnX5YJPXsc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cv+hHK0b9tNqT+aPXD3gB7uZt7FWSvKoZF7HzU1dztjes60nsrCPYnB5bsJ/EiqV0
         eEKGQejC/CNRg7DEOQT+6oKMGUHlWF34IjRE5AdIglnKujxKN69aqHqWgclJz0rT6l
         OSAfwW4OdrBEHd7iGS+3kjU4seXGZSGgQDCyG6Vs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martyn Welch <martyn.welch@collabora.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Richard Weinberger <richard@nod.at>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 067/118] um: ubd: Prevent buffer overrun on command completion
Date:   Wed, 22 Apr 2020 11:57:08 +0200
Message-Id: <20200422095042.899761587@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095031.522502705@linuxfoundation.org>
References: <20200422095031.522502705@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Krisman Bertazi <krisman@collabora.com>

[ Upstream commit 6e682d53fc1ef73a169e2a5300326cb23abb32ee ]

On the hypervisor side, when completing commands and the pipe is full,
we retry writing only the entries that failed, by offsetting
io_req_buffer, but we don't reduce the number of bytes written, which
can cause a buffer overrun of io_req_buffer, and write garbage to the
pipe.

Cc: Martyn Welch <martyn.welch@collabora.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/drivers/ubd_kern.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 6627d7c30f370..0f5d0a699a49b 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1606,7 +1606,9 @@ int io_thread(void *arg)
 		written = 0;
 
 		do {
-			res = os_write_file(kernel_fd, ((char *) io_req_buffer) + written, n);
+			res = os_write_file(kernel_fd,
+					    ((char *) io_req_buffer) + written,
+					    n - written);
 			if (res >= 0) {
 				written += res;
 			}
-- 
2.20.1



