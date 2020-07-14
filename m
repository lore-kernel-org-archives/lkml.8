Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE295C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAC3022B2A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594752480;
	bh=pHJxLikuzUBUsmeFUYG5PrZJTGqQpdsm39r3eU+a4b4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a4QyxQBo94ThZvckNaq0md/17i3P1IRTUpkiv609SuLMA8PP7KLAAJHm1RHzKFlXJ
	 6MH3vQb9tLfA1vFx+sV/XaOnBv50uguCX4tgdTpCYCEoLkpTc5uClxWWbIPWapXNvs
	 gifZM6xXR1QThNNt70626jOtzKv5m66RZLOgz9QE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbgGNSr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:47:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:43204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729854AbgGNSr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:47:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFE8322AB0;
        Tue, 14 Jul 2020 18:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752476;
        bh=pHJxLikuzUBUsmeFUYG5PrZJTGqQpdsm39r3eU+a4b4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g+hQ1UswJksIMLwVFYwpnAgRmCObEVew9U1t60i/dkLImMvQhoWIbIgiz7ex51kPR
         xkzgp9YMTeFauDptbGYcjRRCihzsTpATX9UkL6bzxbCvnLbfdirEOMSe6Sm+woZABB
         hqow2XqPPMBfGs+kAQSqqpCEs0Qr7NVFCH0EHWj8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Khazhismel Kumykov <khazhy@google.com>,
        Tahsin Erdogan <tahsin@google.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.19 55/58] dm: use noio when sending kobject event
Date:   Tue, 14 Jul 2020 20:44:28 +0200
Message-Id: <20200714184058.910142747@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184056.149119318@linuxfoundation.org>
References: <20200714184056.149119318@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>

commit 6958c1c640af8c3f40fa8a2eee3b5b905d95b677 upstream.

kobject_uevent may allocate memory and it may be called while there are dm
devices suspended. The allocation may recurse into a suspended device,
causing a deadlock. We must set the noio flag when sending a uevent.

The observed deadlock was reported here:
https://www.redhat.com/archives/dm-devel/2020-March/msg00025.html

Reported-by: Khazhismel Kumykov <khazhy@google.com>
Reported-by: Tahsin Erdogan <tahsin@google.com>
Reported-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/sched/mm.h>
 #include <linux/sched/signal.h>
 #include <linux/blkpg.h>
 #include <linux/bio.h>
@@ -2853,17 +2854,25 @@ EXPORT_SYMBOL_GPL(dm_internal_resume_fas
 int dm_kobject_uevent(struct mapped_device *md, enum kobject_action action,
 		       unsigned cookie)
 {
+	int r;
+	unsigned noio_flag;
 	char udev_cookie[DM_COOKIE_LENGTH];
 	char *envp[] = { udev_cookie, NULL };
 
+	noio_flag = memalloc_noio_save();
+
 	if (!cookie)
-		return kobject_uevent(&disk_to_dev(md->disk)->kobj, action);
+		r = kobject_uevent(&disk_to_dev(md->disk)->kobj, action);
 	else {
 		snprintf(udev_cookie, DM_COOKIE_LENGTH, "%s=%u",
 			 DM_COOKIE_ENV_VAR_NAME, cookie);
-		return kobject_uevent_env(&disk_to_dev(md->disk)->kobj,
-					  action, envp);
+		r = kobject_uevent_env(&disk_to_dev(md->disk)->kobj,
+				       action, envp);
 	}
+
+	memalloc_noio_restore(noio_flag);
+
+	return r;
 }
 
 uint32_t dm_next_uevent_seq(struct mapped_device *md)


