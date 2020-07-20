Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1E4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 303EE20684
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261575;
	bh=Mdl/K+7xLaxusjBhgs4IxBfsL816xmLFcY8NBTjFunY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q1L+fDPmY7epfF8Z7V7rdfRU+/0V4OIWJeZGaM5eC7FbtserCUaXgRD4/h2yXyY9p
	 jjx3d/aFLGaLTGAWyTFBM3EmIox6i9A0SxkAeNIFjN0PNrrNnCGjQh7aipDHV0dYuc
	 Lc3Vn/kH1YfOE+PsAq6KieYxjaqIOvp1Weg/Mbmk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388038AbgGTQMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:12:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:52534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387683AbgGTQMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:12:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CC8920684;
        Mon, 20 Jul 2020 16:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261569;
        bh=Mdl/K+7xLaxusjBhgs4IxBfsL816xmLFcY8NBTjFunY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RrLrqsuPCPSuzaPUYquwZdkiusLHWILTfkPTLw03Z1Zx7dKVOX/c7kFSpAv+8ZqVJ
         VDJp3YZ2ZRFvdVqVlJA4ms0MU9xiJ220pSQ7UeaHe1HLzjJXQyZlg3GhF26l31EqDJ
         2K2LaMqaSelc3O8I69O+Tg7G5E0kcrHGAS75NgCw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhang Qiang <qiang.zhang@windriver.com>,
        Felipe Balbi <balbi@kernel.org>
Subject: [PATCH 5.7 163/244] usb: gadget: function: fix missing spinlock in f_uac1_legacy
Date:   Mon, 20 Jul 2020 17:37:14 +0200
Message-Id: <20200720152833.594701777@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
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


