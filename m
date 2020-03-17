Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0F4C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 00:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3B6206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 00:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733168AbgCQAp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 20:45:28 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53812 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733005AbgCQAp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 20:45:27 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 403CF283BEE
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jdike@addtoit.com
Cc:     richard@nod.at, anton.ivanov@cambridgegreys.com,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Martyn Welch <martyn.welch@collabora.com>
Subject: [PATCH 2/2] um: ubd: Retry buffer read on any kind of error
Date:   Mon, 16 Mar 2020 20:45:07 -0400
Message-Id: <20200317004507.1513370-3-krisman@collabora.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200317004507.1513370-1-krisman@collabora.com>
References: <20200317004507.1513370-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Should bulk_req_safe_read return an error, we want to retry the read,
otherwise, even though no IO will be done, os_write_file might still end
up writing garbage to the pipe.

Cc: Martyn Welch <martyn.welch@collabora.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 arch/um/drivers/ubd_kern.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 0f5d0a699a49..d259f0728003 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1591,11 +1591,11 @@ int io_thread(void *arg)
 			&io_remainder_size,
 			UBD_REQ_BUFFER_SIZE
 		);
-		if (n < 0) {
-			if (n == -EAGAIN) {
+		if (n <= 0) {
+			if (n == -EAGAIN)
 				ubd_read_poll(-1);
-				continue;
-			}
+
+			continue;
 		}
 
 		for (count = 0; count < n/sizeof(struct io_thread_req *); count++) {
-- 
2.25.0

