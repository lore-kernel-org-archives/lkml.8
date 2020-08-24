Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC721C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC4EC22CF6
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598258330;
	bh=z9X8XAf5pNu5xFYsewaUK9xluow/ICaWKL8M9zLZUyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FsmP2wToCEG3s0MFgavd8JVpZbRkCNVpPD7AaFknzEz1GVkiHv5ZXbZk1fbRFzFH5
	 9ozK3oL8yUsfXNid1k8zAsD96U/ParB3gsfeb4geSaQz3sk0+n6X1TZD0RcufQufMt
	 jY1yDjKukbKT/atY6yO2dcmfngWqHNCJuvNZVhMA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgHXIis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:38:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:53498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728006AbgHXIil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:38:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BF3A20FC3;
        Mon, 24 Aug 2020 08:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258321;
        bh=z9X8XAf5pNu5xFYsewaUK9xluow/ICaWKL8M9zLZUyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Se2ZnQanC6n0qXQVjDAG7hhvFBneca7hSwM04pvkh5Bz6snz7hWz+rDgzpaUmP1CK
         yFd87uwN46i5MPRctrAYX/ByVlaueA+I7VrtQ8Bi1j/ug9zU/WHbroJu5t86W9iFeE
         10v3erO5tQHwEpdFUShZ/7hDKB0bMMBZyIMMPGvM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 5.8 148/148] do_epoll_ctl(): clean the failure exits up a bit
Date:   Mon, 24 Aug 2020 10:30:46 +0200
Message-Id: <20200824082421.115891566@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082413.900489417@linuxfoundation.org>
References: <20200824082413.900489417@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

commit 52c479697c9b73f628140dcdfcd39ea302d05482 upstream.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/eventpoll.c |   19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2203,29 +2203,22 @@ int do_epoll_ctl(int epfd, int op, int f
 			full_check = 1;
 			if (is_file_epoll(tf.file)) {
 				error = -ELOOP;
-				if (ep_loop_check(ep, tf.file) != 0) {
-					clear_tfile_check_list();
+				if (ep_loop_check(ep, tf.file) != 0)
 					goto error_tgt_fput;
-				}
 			} else {
 				get_file(tf.file);
 				list_add(&tf.file->f_tfile_llink,
 							&tfile_check_list);
 			}
 			error = epoll_mutex_lock(&ep->mtx, 0, nonblock);
-			if (error) {
-out_del:
-				list_del(&tf.file->f_tfile_llink);
-				if (!is_file_epoll(tf.file))
-					fput(tf.file);
+			if (error)
 				goto error_tgt_fput;
-			}
 			if (is_file_epoll(tf.file)) {
 				tep = tf.file->private_data;
 				error = epoll_mutex_lock(&tep->mtx, 1, nonblock);
 				if (error) {
 					mutex_unlock(&ep->mtx);
-					goto out_del;
+					goto error_tgt_fput;
 				}
 			}
 		}
@@ -2246,8 +2239,6 @@ out_del:
 			error = ep_insert(ep, epds, tf.file, fd, full_check);
 		} else
 			error = -EEXIST;
-		if (full_check)
-			clear_tfile_check_list();
 		break;
 	case EPOLL_CTL_DEL:
 		if (epi)
@@ -2270,8 +2261,10 @@ out_del:
 	mutex_unlock(&ep->mtx);
 
 error_tgt_fput:
-	if (full_check)
+	if (full_check) {
+		clear_tfile_check_list();
 		mutex_unlock(&epmutex);
+	}
 
 	fdput(tf);
 error_fput:


