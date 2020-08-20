Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76DEC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BEA72078D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597922725;
	bh=JviOPlayrNp5TUqYGsqdv/rzayIkoShqBQoDfszUVDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g9I2i8b6O3MhqNYKP8QdEO1IWphZJozEc+sV+VlDJ4Yua2BS3u8j8tRc5EGy3bLaQ
	 D7XiWnWVSt7IChkGBNhni1uuLs8gUu64HwxrtZDVOj+q47cvLi2kj7pXuWIxXmAsbx
	 cb//idV7V73Ju4DTCSmHfEocuH/tQ24zLo8dyemk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbgHTLZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:25:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730501AbgHTKGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:06:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6AC12067C;
        Thu, 20 Aug 2020 10:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918013;
        bh=JviOPlayrNp5TUqYGsqdv/rzayIkoShqBQoDfszUVDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z1LicdltTKjVqr4e7/5fQ9jo2/G7+hqn2J+6NPKciG3hqCoTfAHC02MpnA+QN8sss
         YKLPiCVc95tnmUrcxnYP5PKUXQppk7+acpxCCxSc38ny5qLNxBvm83Gy0fbVzYpdG3
         GIsxyMDCuPHtK9dZHymo0AMkbZZHvuULeL4yDY5s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+1a54a94bd32716796edd@syzkaller.appspotmail.com,
        syzbot+9d2abfef257f3e2d4713@syzkaller.appspotmail.com,
        Hillf Danton <hdanton@sina.com>, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 006/228] ALSA: seq: oss: Serialize ioctls
Date:   Thu, 20 Aug 2020 11:19:41 +0200
Message-Id: <20200820091607.848935183@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091607.532711107@linuxfoundation.org>
References: <20200820091607.532711107@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 80982c7e834e5d4e325b6ce33757012ecafdf0bb upstream.

Some ioctls via OSS sequencer API may race and lead to UAF when the
port create and delete are performed concurrently, as spotted by a
couple of syzkaller cases.  This patch is an attempt to address it by
serializing the ioctls with the existing register_mutex.

Basically OSS sequencer API is an obsoleted interface and was designed
without much consideration of the concurrency.  There are very few
applications with it, and the concurrent performance isn't asked,
hence this "big hammer" approach should be good enough.

Reported-by: syzbot+1a54a94bd32716796edd@syzkaller.appspotmail.com
Reported-by: syzbot+9d2abfef257f3e2d4713@syzkaller.appspotmail.com
Suggested-by: Hillf Danton <hdanton@sina.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200804185815.2453-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/seq/oss/seq_oss.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/sound/core/seq/oss/seq_oss.c
+++ b/sound/core/seq/oss/seq_oss.c
@@ -181,10 +181,16 @@ static long
 odev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct seq_oss_devinfo *dp;
+	long rc;
+
 	dp = file->private_data;
 	if (snd_BUG_ON(!dp))
 		return -ENXIO;
-	return snd_seq_oss_ioctl(dp, cmd, arg);
+
+	mutex_lock(&register_mutex);
+	rc = snd_seq_oss_ioctl(dp, cmd, arg);
+	mutex_unlock(&register_mutex);
+	return rc;
 }
 
 #ifdef CONFIG_COMPAT


