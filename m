Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A92C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6D024676
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578996933;
	bh=UnitqGIL4BayPEuh5GU0szWLUTtZK+Bm39PXTu23tIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Oug5Kj6pWVX5JT415/0XVLG5lrjWekNWKoMqeiNFduEGXvUg4joMBPxA2NxitH5MO
	 i/wCDXV8TN5ynXgdZllsoH7aMRH/5DeMwgSnKu0FHLQwggGdm0mRdvHoO0viyZQz7i
	 z7wqcHXFi88DQvQ0dSc4OqUxsqo6i2+IYPJKqcDM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731430AbgANKLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:11:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:45526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731991AbgANKK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:10:57 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC5252467D;
        Tue, 14 Jan 2020 10:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996657;
        bh=UnitqGIL4BayPEuh5GU0szWLUTtZK+Bm39PXTu23tIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bHRljwoQ+4captzmKMaYiBwheGyhKKsFX16uwjEWgI7At7xZ5yh+tBSVt8ACTI4GF
         ZUCSHzzUhBFVMrD6WHMPqrSOF/QU3cbP69quxlLjHcCfn0MmA7WN7QxVNu7cRbi08H
         RSBYmFeAJLllJdY1Ky3CvW473qD8uyWOqQiXDmOM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@fb.com>
Subject: [PATCH 4.9 01/31] kobject: Export kobject_get_unless_zero()
Date:   Tue, 14 Jan 2020 11:01:53 +0100
Message-Id: <20200114094335.950381243@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094334.725604663@linuxfoundation.org>
References: <20200114094334.725604663@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kara <jack@suse.cz>

commit c70c176ff8c3ff0ac6ef9a831cd591ea9a66bd1a upstream.

Make the function available for outside use and fortify it against NULL
kobject.

CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jens Axboe <axboe@fb.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/kobject.h |    2 ++
 lib/kobject.c           |    5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -108,6 +108,8 @@ extern int __must_check kobject_rename(s
 extern int __must_check kobject_move(struct kobject *, struct kobject *);
 
 extern struct kobject *kobject_get(struct kobject *kobj);
+extern struct kobject * __must_check kobject_get_unless_zero(
+						struct kobject *kobj);
 extern void kobject_put(struct kobject *kobj);
 
 extern const void *kobject_namespace(struct kobject *kobj);
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -599,12 +599,15 @@ struct kobject *kobject_get(struct kobje
 }
 EXPORT_SYMBOL(kobject_get);
 
-static struct kobject * __must_check kobject_get_unless_zero(struct kobject *kobj)
+struct kobject * __must_check kobject_get_unless_zero(struct kobject *kobj)
 {
+	if (!kobj)
+		return NULL;
 	if (!kref_get_unless_zero(&kobj->kref))
 		kobj = NULL;
 	return kobj;
 }
+EXPORT_SYMBOL(kobject_get_unless_zero);
 
 /*
  * kobject_cleanup - free kobject resources.


