Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8779EC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 655FA206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598979249;
	bh=CvSkdwDg6PRknrGxMyqrHFPTdy7TeeZG/HZYNd6mZRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OBbEo1vMt6fuRl2RZQQparNXT2QovsOIFYoa6y5RbIp3L4eiHkVeR8ghhEk/AMO7X
	 syoYsi9xB6bmbmoQjlNN/Ux1RUDKplyTjb55RVCLL5CPLTeGE6blGYokjJ3OeBKg8E
	 1fiwXSHhfZ1gAHOjJqyUamzA6amZsb8CJh95M4bc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732495AbgIAQyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:54:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:48872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729070AbgIAPYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:24:51 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C35C920FC3;
        Tue,  1 Sep 2020 15:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973889;
        bh=CvSkdwDg6PRknrGxMyqrHFPTdy7TeeZG/HZYNd6mZRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tKoukL++EDMwYQ1LDNIZX8HfKH3hrY9qTu4nRpIcTb9SD53rG5ZTfLLlBPDvm55m/
         1Y/EMFpzlMfnAgbEnFf/vbQUAO83YWyp8/BV4bLOyMq2R/VRtzH+UfOXasEpvFbRs/
         Ia+/8nJF+eGnizRbZCPXrRV6Oc6Twd8vCzV9B8Zg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot <syzbot+9116ecc1978ca3a12f43@syzkaller.appspotmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH 4.19 087/125] vt: defer kfree() of vc_screenbuf in vc_do_resize()
Date:   Tue,  1 Sep 2020 17:10:42 +0200
Message-Id: <20200901150938.837990318@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150934.576210879@linuxfoundation.org>
References: <20200901150934.576210879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

commit f8d1653daec02315e06d30246cff4af72e76e54e upstream.

syzbot is reporting UAF bug in set_origin() from vc_do_resize() [1], for
vc_do_resize() calls kfree(vc->vc_screenbuf) before calling set_origin().

Unfortunately, in set_origin(), vc->vc_sw->con_set_origin() might access
vc->vc_pos when scroll is involved in order to manipulate cursor, but
vc->vc_pos refers already released vc->vc_screenbuf until vc->vc_pos gets
updated based on the result of vc->vc_sw->con_set_origin().

Preserving old buffer and tolerating outdated vc members until set_origin()
completes would be easier than preventing vc->vc_sw->con_set_origin() from
accessing outdated vc members.

[1] https://syzkaller.appspot.com/bug?id=6649da2081e2ebdc65c0642c214b27fe91099db3

Reported-by: syzbot <syzbot+9116ecc1978ca3a12f43@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/1596034621-4714-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/vt/vt.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1199,7 +1199,7 @@ static int vc_do_resize(struct tty_struc
 	unsigned int old_rows, old_row_size, first_copied_row;
 	unsigned int new_cols, new_rows, new_row_size, new_screen_size;
 	unsigned int user;
-	unsigned short *newscreen;
+	unsigned short *oldscreen, *newscreen;
 	struct uni_screen *new_uniscr = NULL;
 
 	WARN_CONSOLE_UNLOCKED();
@@ -1297,10 +1297,11 @@ static int vc_do_resize(struct tty_struc
 	if (new_scr_end > new_origin)
 		scr_memsetw((void *)new_origin, vc->vc_video_erase_char,
 			    new_scr_end - new_origin);
-	kfree(vc->vc_screenbuf);
+	oldscreen = vc->vc_screenbuf;
 	vc->vc_screenbuf = newscreen;
 	vc->vc_screenbuf_size = new_screen_size;
 	set_origin(vc);
+	kfree(oldscreen);
 
 	/* do part of a reset_terminal() */
 	vc->vc_top = 0;


