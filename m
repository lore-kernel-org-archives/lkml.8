Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128FCC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E45F420724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592947285;
	bh=/2CYLF6f8t7m6yhxykhDd6BFoqe6kUko8+ah4vtC1uk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k1CKlcYRxm93MWT/wGfiO11D8FfMxT92fsAHP1msz/GoGkjvMDlY9VKS+KBmwYyfU
	 xahtZv2Jj1HTBkcB6E2vTA+QmMmUyG7d2nRPV5qO8B/oclctqYtsc/tWm5QX/OAxTX
	 HptqmDQ1or2N2f6jl5foolYAKuLmlN4z2FTdZemQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393485AbgFWVVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:21:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:41040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390233AbgFWUW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:22:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E90092064B;
        Tue, 23 Jun 2020 20:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943779;
        bh=/2CYLF6f8t7m6yhxykhDd6BFoqe6kUko8+ah4vtC1uk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R1uKH1m66DCNE2+fOMZjsYlE2o7LbTk3+tPNoorfjFJtaw/Tw0guvta1fuzNnwdm8
         +fvFDG/dBikTG1eKHhheydXANAAJszJ4Ecu7oqDsSXWuZT+HxgBN6IA4zSpxOGh2bn
         KYPJSaCJJMSXurFJ8fAoqGtAs8VaMRtFN6Tt7szU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        syzbot+be5b5f86a162a6c281e6@syzkaller.appspotmail.com,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 030/314] usblp: poison URBs upon disconnect
Date:   Tue, 23 Jun 2020 21:53:45 +0200
Message-Id: <20200623195340.245958345@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Neukum <oneukum@suse.com>

[ Upstream commit 296a193b06120aa6ae7cf5c0d7b5e5b55968026e ]

syzkaller reported an URB that should have been killed to be active.
We do not understand it, but this should fix the issue if it is real.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Reported-by: syzbot+be5b5f86a162a6c281e6@syzkaller.appspotmail.com
Link: https://lore.kernel.org/r/20200507085806.5793-1-oneukum@suse.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/class/usblp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/class/usblp.c b/drivers/usb/class/usblp.c
index 0d8e3f3804a3f..084c48c5848fc 100644
--- a/drivers/usb/class/usblp.c
+++ b/drivers/usb/class/usblp.c
@@ -468,7 +468,8 @@ static int usblp_release(struct inode *inode, struct file *file)
 	usb_autopm_put_interface(usblp->intf);
 
 	if (!usblp->present)		/* finish cleanup from disconnect */
-		usblp_cleanup(usblp);
+		usblp_cleanup(usblp);	/* any URBs must be dead */
+
 	mutex_unlock(&usblp_mutex);
 	return 0;
 }
@@ -1375,9 +1376,11 @@ static void usblp_disconnect(struct usb_interface *intf)
 
 	usblp_unlink_urbs(usblp);
 	mutex_unlock(&usblp->mut);
+	usb_poison_anchored_urbs(&usblp->urbs);
 
 	if (!usblp->used)
 		usblp_cleanup(usblp);
+
 	mutex_unlock(&usblp_mutex);
 }
 
-- 
2.25.1



