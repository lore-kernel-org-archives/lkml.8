Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9278C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8852B20885
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597918758;
	bh=YKOLualWO9C4qYdvL7Xb+bTQPwiEtuBFqCinjF8SZNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PkJjQJuxSjCez2YQpSSB+h7TfAzfI3Vim9Q596U8HrGNfpLtwKv4SqHNk8IBNUAhc
	 LQC3PCqWrHLrRwIou+TXdlGULWSHVvI9blljQKblEHifFytUw7hRnLCT3ZiGV9Z99d
	 6EjJCPu5SsffiLjSabmpLX8g8MWsC8Qc+CcnDfDk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgHTKTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:19:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:40230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731154AbgHTKSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:18:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B83020738;
        Thu, 20 Aug 2020 10:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918701;
        bh=YKOLualWO9C4qYdvL7Xb+bTQPwiEtuBFqCinjF8SZNY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G9NX+Q4tlYUjiMqHrOx7wD3E4roQlKmRVimUDi6Fm/SHhyHQjJurGmYCfzisHHTec
         fcBoB3+O8YW149q1AhbtzoGMqDbjB9eh5Dru1EGtW/CYNW3b4p8NTo6MCR+p0tpOPc
         djcbIcFMr3mXhwa1oBD55DrVssUf3ljCus5EUwOA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+1a54a94bd32716796edd@syzkaller.appspotmail.com,
        syzbot+9d2abfef257f3e2d4713@syzkaller.appspotmail.com,
        Hillf Danton <hdanton@sina.com>, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 034/149] ALSA: seq: oss: Serialize ioctls
Date:   Thu, 20 Aug 2020 11:21:51 +0200
Message-Id: <20200820092127.381677453@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820092125.688850368@linuxfoundation.org>
References: <20200820092125.688850368@linuxfoundation.org>
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
@@ -180,10 +180,16 @@ static long
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


