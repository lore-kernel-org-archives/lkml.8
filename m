Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88902C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E37C2468D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221603;
	bh=R+t2XQlS/Rxez7cQeaAhdFbKV41lZ7VbFW+NLwDR7FI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=haOoE/HF4Ng9LfJ3zrpo0lyO36hPr9M3c4ChXB2V6fcPne/oTsDlDvUF/K1kb4qqh
	 NuB8DmUHICcYLNzx5vvHRlApPpHKKadO77QxfsEDGlycac/j0vpu+JFzZh/eLiT3ag
	 fNZL8SGLu80dX7A68szPStaPpdnXbYJFPlN/arFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733215AbgA1O0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:26:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:54182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733200AbgA1O0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:26:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D491E2468F;
        Tue, 28 Jan 2020 14:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221600;
        bh=R+t2XQlS/Rxez7cQeaAhdFbKV41lZ7VbFW+NLwDR7FI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vD/KQvtkONCMY2G9HZbPO6g2R89hkYRqYtmzGD3sptaty5b8l4xly1COMfRO5qMYR
         /5U9jXeoEccdtEgkd/mDGy8aAbzTwUD1aNg5+BBaf9OVL50ngaVUuH/2739lkCltqp
         OPLJgbLoezigkZWYqecbmDbmR+ofk3S5hAoM8ggA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot <syzbot+30209ea299c09d8785c9@syzkaller.appspotmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        David Miller <davem@davemloft.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jouni Hogander <jouni.hogander@unikie.com>
Subject: [PATCH 4.19 15/92] net-sysfs: Call dev_hold always in rx_queue_add_kobject
Date:   Tue, 28 Jan 2020 15:07:43 +0100
Message-Id: <20200128135811.135105869@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135809.344954797@linuxfoundation.org>
References: <20200128135809.344954797@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jouni Hogander <jouni.hogander@unikie.com>

commit ddd9b5e3e765d8ed5a35786a6cb00111713fe161 upstream.

Dev_hold has to be called always in rx_queue_add_kobject.
Otherwise usage count drops below 0 in case of failure in
kobject_init_and_add.

Fixes: b8eb718348b8 ("net-sysfs: Fix reference count leak in rx|netdev_queue_add_kobject")
Reported-by: syzbot <syzbot+30209ea299c09d8785c9@syzkaller.appspotmail.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: David Miller <davem@davemloft.net>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Jouni Hogander <jouni.hogander@unikie.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/core/net-sysfs.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -928,14 +928,17 @@ static int rx_queue_add_kobject(struct n
 	struct kobject *kobj = &queue->kobj;
 	int error = 0;
 
+	/* Kobject_put later will trigger rx_queue_release call which
+	 * decreases dev refcount: Take that reference here
+	 */
+	dev_hold(queue->dev);
+
 	kobj->kset = dev->queues_kset;
 	error = kobject_init_and_add(kobj, &rx_queue_ktype, NULL,
 				     "rx-%u", index);
 	if (error)
 		goto err;
 
-	dev_hold(queue->dev);
-
 	if (dev->sysfs_rx_queue_group) {
 		error = sysfs_create_group(kobj, dev->sysfs_rx_queue_group);
 		if (error)


