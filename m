Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5FDC35E1D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75AA020801
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582812205;
	bh=WfR1glQBxu8YOajsf+RKgWMV+PrcXt72mpGHCBNKBu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OUj1MHEC15171KlOHuzqk5vU6bTHsj2OrYjx1QTKUD+2jt185UvdiPMVDbK8jcNuk
	 eFNf9s9aOTsc8W71qsKkV6sdKJPgeG9hB0P9mQaiF6+wLQuheL78KvHn/jMG4g6LeU
	 UqGfbcEUzO3u0qRFuVxr4XKo/a0qxMktMi2OiwCM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387420AbgB0ODY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:03:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:38552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387408AbgB0ODV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:03:21 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C89A421556;
        Thu, 27 Feb 2020 14:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812201;
        bh=WfR1glQBxu8YOajsf+RKgWMV+PrcXt72mpGHCBNKBu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U26e6XvbRrvsgikOIaf/YGvPRiX8vtolKMkGff1dbq4vc4M0z2jBCN0M5zuL7554O
         7Db1t0as13HqhAYpRFcscyQX4JEQgrn2aDVuCnF+UhKUwQsgEY1a6g7ww6agzF6BhF
         iXgmLBvKtXKCMrV/VPF0A7+IqFOEZd8lqjagSwfo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wenwen@cs.uga.edu>,
        Tyler Hicks <tyhicks@canonical.com>
Subject: [PATCH 4.19 07/97] ecryptfs: fix a memory leak bug in ecryptfs_init_messaging()
Date:   Thu, 27 Feb 2020 14:36:15 +0100
Message-Id: <20200227132215.770740002@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132214.553656188@linuxfoundation.org>
References: <20200227132214.553656188@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wenwen@cs.uga.edu>

commit b4a81b87a4cfe2bb26a4a943b748d96a43ef20e8 upstream.

In ecryptfs_init_messaging(), if the allocation for 'ecryptfs_msg_ctx_arr'
fails, the previously allocated 'ecryptfs_daemon_hash' is not deallocated,
leading to a memory leak bug. To fix this issue, free
'ecryptfs_daemon_hash' before returning the error.

Cc: stable@vger.kernel.org
Fixes: 88b4a07e6610 ("[PATCH] eCryptfs: Public key transport mechanism")
Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ecryptfs/messaging.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/ecryptfs/messaging.c
+++ b/fs/ecryptfs/messaging.c
@@ -392,6 +392,7 @@ int __init ecryptfs_init_messaging(void)
 					* ecryptfs_message_buf_len),
 				       GFP_KERNEL);
 	if (!ecryptfs_msg_ctx_arr) {
+		kfree(ecryptfs_daemon_hash);
 		rc = -ENOMEM;
 		goto out;
 	}


