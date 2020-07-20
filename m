Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B62C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EE962065E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260420;
	bh=Mdl/K+7xLaxusjBhgs4IxBfsL816xmLFcY8NBTjFunY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bZk+HHDCnCpaIWt1YuR7EPu7u/PyxFDcPa6ZBxrHFek1THeKe8Zm7M2zQjSoLwHkj
	 4Pq5Nm8L3UYx3GjfBjBCKX58P6+AtuPNlfMryCjg8rgYwC5TUobI86HiHKexhOZkGs
	 7xVF81ngzC5o0vFsVkGdq2TgxbjT9xu5FS8DyvfI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731486AbgGTPxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:53:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730314AbgGTPxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:53:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C81BF2064B;
        Mon, 20 Jul 2020 15:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260416;
        bh=Mdl/K+7xLaxusjBhgs4IxBfsL816xmLFcY8NBTjFunY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dgwhw/EArEmYy/gs20JZUkQTqr9QNUjJQKwmugQqMJuI8YwFtB6DyfhLotMigs6pQ
         uLw7vzTziliDf351auHNJ3tWwy64TbE/0hacy2iSp40B7wklmNJyJufS5uEQRNHyNn
         IC1cUlBJY5+R+sqjRxXGoy5t1rSjOMoOsYbdKdlc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhang Qiang <qiang.zhang@windriver.com>,
        Felipe Balbi <balbi@kernel.org>
Subject: [PATCH 4.19 093/133] usb: gadget: function: fix missing spinlock in f_uac1_legacy
Date:   Mon, 20 Jul 2020 17:37:20 +0200
Message-Id: <20200720152808.216140250@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152803.732195882@linuxfoundation.org>
References: <20200720152803.732195882@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Qiang <qiang.zhang@windriver.com>

commit 8778eb0927ddcd3f431805c37b78fa56481aeed9 upstream.

Add a missing spinlock protection for play_queue, because
the play_queue may be destroyed when the "playback_work"
work func and "f_audio_out_ep_complete" callback func
operate this paly_queue at the same time.

Fixes: c6994e6f067cf ("USB: gadget: add USB Audio Gadget driver")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Zhang Qiang <qiang.zhang@windriver.com>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/function/f_uac1_legacy.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/gadget/function/f_uac1_legacy.c
+++ b/drivers/usb/gadget/function/f_uac1_legacy.c
@@ -336,7 +336,9 @@ static int f_audio_out_ep_complete(struc
 
 	/* Copy buffer is full, add it to the play_queue */
 	if (audio_buf_size - copy_buf->actual < req->actual) {
+		spin_lock_irq(&audio->lock);
 		list_add_tail(&copy_buf->list, &audio->play_queue);
+		spin_unlock_irq(&audio->lock);
 		schedule_work(&audio->playback_work);
 		copy_buf = f_audio_buffer_alloc(audio_buf_size);
 		if (IS_ERR(copy_buf))


