Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E72C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 11:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE87D20737
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 11:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586951880;
	bh=lzAr4ppCgdjZHX3lpnDUbHFj+hcvIzVExwUEm8K4/hI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2a+IfpEYLOLEJ7Hz9DKx99HpkJVwHFV+jkHMvn7imGHu9+mN7pEOUQ6xeKkjB+ot0
	 ibvXW9LHoTHvCKlZz6E6T7kJfzJe+kpgl+/5RGgfjSTUmdWRTF0ChxgnVadBweInp4
	 3jNLA6LP3tMpHvugiosxkUDE0gAdPvzA6pY21+Zs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897983AbgDOL55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 07:57:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409312AbgDOLql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:46:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 171FF21655;
        Wed, 15 Apr 2020 11:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586951200;
        bh=lzAr4ppCgdjZHX3lpnDUbHFj+hcvIzVExwUEm8K4/hI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zcC296suW7zJDNEHdPAsUUqUQYPJXGwj1Eu4zFrNgeq3LK+S1RO+6splXAYfJk69+
         4cpbwaR9VbO58CpRJu59DrDFobe7mvcTAG27Lf5pnwreIta5NDrXf82OaM4/JBkZcH
         dHne8I3pIh0FSouTfgpDKLHR94F0WNWeM2BiQ8SI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Martyn Welch <martyn.welch@collabora.com>,
        Richard Weinberger <richard@nod.at>,
        Sasha Levin <sashal@kernel.org>, linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 15/40] um: ubd: Prevent buffer overrun on command completion
Date:   Wed, 15 Apr 2020 07:45:58 -0400
Message-Id: <20200415114623.14972-15-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415114623.14972-1-sashal@kernel.org>
References: <20200415114623.14972-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 83c470364dfb3..748bd0921dfff 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1574,7 +1574,9 @@ int io_thread(void *arg)
 		written = 0;
 
 		do {
-			res = os_write_file(kernel_fd, ((char *) io_req_buffer) + written, n);
+			res = os_write_file(kernel_fd,
+					    ((char *) io_req_buffer) + written,
+					    n - written);
 			if (res >= 0) {
 				written += res;
 			} else {
-- 
2.20.1

