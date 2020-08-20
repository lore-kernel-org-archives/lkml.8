Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7F0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FF87207DA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597928935;
	bh=fYjUzlgWLrjLPQZGD7uGMfTq09k9G2bdCDizIxzhr2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aQepYGWlI48xuXvvqL7XHEU/3bufzMRdSzx28P3Or19RnnPShNgApQj0oMD39LN4x
	 6xgr/pmOQKStshxPj8oJeysxURv2cV+f3OQcG/2Vg5F/X4hMSzcXSkL4lL8/rcLPv7
	 WDGjWiuojmVVpMjbW94b3m/NdSPeKrQMQKpm+SEU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgHTJhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:37:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:53168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728695AbgHTJhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:37:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36E3C2075E;
        Thu, 20 Aug 2020 09:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916231;
        bh=fYjUzlgWLrjLPQZGD7uGMfTq09k9G2bdCDizIxzhr2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LByY+ros8UBPcwsCg04o+KHUvcSMFX9blXnpzwuJ4BrccOIih5JKOl6VYjGdEirqQ
         EhB6xioa56DjRDHuekM1JDBgks8K+qCtgAVI+ImnrX8aBIs93ZE9F1CLkg+k2J7cFj
         zFH4CGiuq4IyJw5tZ6d/hMzRMLJrM199Drbcqouw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>,
        Sargun Dhillon <sargun@sargun.me>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 5.7 055/204] pidfd: Add missing sock updates for pidfd_getfd()
Date:   Thu, 20 Aug 2020 11:19:12 +0200
Message-Id: <20200820091609.017231573@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091606.194320503@linuxfoundation.org>
References: <20200820091606.194320503@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

commit 4969f8a073977123504609d7310b42a588297aa4 upstream.

The sock counting (sock_update_netprioidx() and sock_update_classid())
was missing from pidfd's implementation of received fd installation. Add
a call to the new __receive_sock() helper.

Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sargun Dhillon <sargun@sargun.me>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Fixes: 8649c322f75c ("pid: Implement pidfd_getfd syscall")
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/pid.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -42,6 +42,7 @@
 #include <linux/sched/signal.h>
 #include <linux/sched/task.h>
 #include <linux/idr.h>
+#include <net/sock.h>
 
 struct pid init_struct_pid = {
 	.count		= REFCOUNT_INIT(1),
@@ -624,10 +625,12 @@ static int pidfd_getfd(struct pid *pid,
 	}
 
 	ret = get_unused_fd_flags(O_CLOEXEC);
-	if (ret < 0)
+	if (ret < 0) {
 		fput(file);
-	else
+	} else {
+		__receive_sock(file);
 		fd_install(ret, file);
+	}
 
 	return ret;
 }


