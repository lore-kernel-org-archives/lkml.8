Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0482C76581
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9441524688
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582813717;
	bh=NjFPG8xSrKgimw87UF2CW1b5ud1z43xOcu4dU/Mnkqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zh+IQ67mmr56wYDRhljhVrO+rtTA4Y2IDfZ1s0tmzuseqKNythnk3VIGeXuz3QtFp
	 YzJ+zt4xomoO69BvgMn4/fWDCd62/59WnFs3RN1Q7rPt7EOIRtJ2zR5DR3dCuriRPL
	 mbrY+n4iwkDBEF7MyNq8ODjFSNpPArnDgO2xmJ2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388420AbgB0O2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:28:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:44762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388073AbgB0OHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:07:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E452521D7E;
        Thu, 27 Feb 2020 14:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812438;
        bh=NjFPG8xSrKgimw87UF2CW1b5ud1z43xOcu4dU/Mnkqc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ydF+M/dOA10Ppxp5xgb2VlP3a/024ypJA89FT5INSdfkDOABaYb6eNNh7qdenpf7h
         T8XqYtFYEZJ4cni3+AfLBxYxXMNU6QX/hz4NxjiYt+P2z9JSQoIz+6wWSrRRkqRLfa
         Nuqoec+EyhUqmyP8sMbLR+OkH7cNsL7JvC/9VubA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 5.4 018/135] vt: selection, handle pending signals in paste_selection
Date:   Thu, 27 Feb 2020 14:35:58 +0100
Message-Id: <20200227132232.006860598@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132228.710492098@linuxfoundation.org>
References: <20200227132228.710492098@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Slaby <jslaby@suse.cz>

commit 687bff0cd08f790d540cfb7b2349f0d876cdddec upstream.

When pasting a selection to a vt, the task is set as INTERRUPTIBLE while
waiting for a tty to unthrottle. But signals are not handled at all.
Normally, this is not a problem as tty_ldisc_receive_buf receives all
the goods and a user has no reason to interrupt the task.

There are two scenarios where this matters:
1) when the tty is throttled and a signal is sent to the process, it
   spins on a CPU until the tty is unthrottled. schedule() does not
   really echedule, but returns immediately, of course.
2) when the sel_buffer becomes invalid, KASAN prevents any reads from it
   and the loop simply does not proceed and spins forever (causing the
   tty to throttle, but the code never sleeps, the same as above). This
   sometimes happens as there is a race in the sel_buffer handling code.

So add signal handling to this ioctl (TIOCL_PASTESEL) and return -EINTR
in case a signal is pending.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200210081131.23572-1-jslaby@suse.cz
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/vt/selection.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -29,6 +29,8 @@
 #include <linux/console.h>
 #include <linux/tty_flip.h>
 
+#include <linux/sched/signal.h>
+
 /* Don't take this from <ctype.h>: 011-015 on the screen aren't spaces */
 #define isspace(c)	((c) == ' ')
 
@@ -350,6 +352,7 @@ int paste_selection(struct tty_struct *t
 	unsigned int count;
 	struct  tty_ldisc *ld;
 	DECLARE_WAITQUEUE(wait, current);
+	int ret = 0;
 
 	console_lock();
 	poke_blanked_console();
@@ -363,6 +366,10 @@ int paste_selection(struct tty_struct *t
 	add_wait_queue(&vc->paste_wait, &wait);
 	while (sel_buffer && sel_buffer_lth > pasted) {
 		set_current_state(TASK_INTERRUPTIBLE);
+		if (signal_pending(current)) {
+			ret = -EINTR;
+			break;
+		}
 		if (tty_throttled(tty)) {
 			schedule();
 			continue;
@@ -378,6 +385,6 @@ int paste_selection(struct tty_struct *t
 
 	tty_buffer_unlock_exclusive(&vc->port);
 	tty_ldisc_deref(ld);
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(paste_selection);


