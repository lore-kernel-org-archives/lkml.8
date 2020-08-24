Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF74C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA8062074D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598260935;
	bh=Nv2JwtW1MlhabNmeQfyVOlTAp/34zvL3bmAUIbA/WH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=01rMzBEeoaovdo3gbEFshhAMuHHVXxsasbYzPoZLuvVo4vbA+rB03gpPJ5iUXFSq0
	 4ym8yQI4Xex+u0jJ9q/FUBPnTAZ/1mtQVpYc5N+UtFLVVtKFC/c5zKSZQ3nF9rKrCv
	 N0mTrBuCjqJiCEmKDvLtxiTNIoepKeEN/kasyCso=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730392AbgHXIzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:55:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730113AbgHXIyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:54:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB1702072D;
        Mon, 24 Aug 2020 08:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598259294;
        bh=Nv2JwtW1MlhabNmeQfyVOlTAp/34zvL3bmAUIbA/WH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CEd13UVhCMH2jrIlN0cmARGib4U4aCwivnziZK41qyk93gxasl3HafFv80bQV/ntK
         ynzLAdcfi4ntABSMso6o9ikfDDuTJYDCPFTZ+n0NgGVrGUBtzJNK50LyjARxQVdHUQ
         Wr1L69PhO7Blw4Brxe7i+kUWaB8y9bReHBpBKzFQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.14 46/50] epoll: Keep a reference on files added to the check list
Date:   Mon, 24 Aug 2020 10:31:47 +0200
Message-Id: <20200824082354.374727642@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082351.823243923@linuxfoundation.org>
References: <20200824082351.823243923@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Zyngier <maz@kernel.org>

commit a9ed4a6560b8562b7e2e2bed9527e88001f7b682 upstream.

When adding a new fd to an epoll, and that this new fd is an
epoll fd itself, we recursively scan the fds attached to it
to detect cycles, and add non-epool files to a "check list"
that gets subsequently parsed.

However, this check list isn't completely safe when deletions
can happen concurrently. To sidestep the issue, make sure that
a struct file placed on the check list sees its f_count increased,
ensuring that a concurrent deletion won't result in the file
disapearing from under our feet.

Cc: stable@vger.kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/eventpoll.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1900,9 +1900,11 @@ static int ep_loop_check_proc(void *priv
 			 * not already there, and calling reverse_path_check()
 			 * during ep_insert().
 			 */
-			if (list_empty(&epi->ffd.file->f_tfile_llink))
+			if (list_empty(&epi->ffd.file->f_tfile_llink)) {
+				get_file(epi->ffd.file);
 				list_add(&epi->ffd.file->f_tfile_llink,
 					 &tfile_check_list);
+			}
 		}
 	}
 	mutex_unlock(&ep->mtx);
@@ -1946,6 +1948,7 @@ static void clear_tfile_check_list(void)
 		file = list_first_entry(&tfile_check_list, struct file,
 					f_tfile_llink);
 		list_del_init(&file->f_tfile_llink);
+		fput(file);
 	}
 	INIT_LIST_HEAD(&tfile_check_list);
 }
@@ -2100,9 +2103,11 @@ SYSCALL_DEFINE4(epoll_ctl, int, epfd, in
 					clear_tfile_check_list();
 					goto error_tgt_fput;
 				}
-			} else
+			} else {
+				get_file(tf.file);
 				list_add(&tf.file->f_tfile_llink,
 							&tfile_check_list);
+			}
 			mutex_lock_nested(&ep->mtx, 0);
 			if (is_file_epoll(tf.file)) {
 				tep = tf.file->private_data;


