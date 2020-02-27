Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB50C3F35E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB8FA2084E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811611;
	bh=+wZu/w2pg+fy8WGtwN3eCFrO6E82uY8hmEVZgEpUAfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I7PFe+YAZSbEAYFopm5Zt8kK+CJiG1OuPxuGYSQZfeIrpnH8/1vzZnvoxjtL3MTvs
	 Jiku3pFTfaTMsaFuiavYqJNGSQwBJX1Zmg8UXDr+gEPOwfgd8utnvokuUMkr9/NQeZ
	 WWCD9gNRpRgxa4bx/KOiZVIDhb0eF+wPI6/8WrO0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731402AbgB0Nxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:53:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:53308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731710AbgB0Nx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:53:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0421E24656;
        Thu, 27 Feb 2020 13:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811608;
        bh=+wZu/w2pg+fy8WGtwN3eCFrO6E82uY8hmEVZgEpUAfA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eC85DkOca/AYR0ySzz1TNiYRtgTqf7mOZ8euKLWYg8BmEa9/JeaZXkdXqb0SOwxxJ
         sjHSe1Ug08KzkqpWtlKUiGpPJ0bnTyxcrTDfPtuwWyw+k2uM5eFRR859AzUg1cEOUv
         Srt2KlNlY6913C7U1v6nB3h4bXlzA+twi1gnIKW4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wenwen@cs.uga.edu>,
        Tyler Hicks <tyhicks@canonical.com>
Subject: [PATCH 4.14 006/237] ecryptfs: fix a memory leak bug in ecryptfs_init_messaging()
Date:   Thu, 27 Feb 2020 14:33:40 +0100
Message-Id: <20200227132256.167218809@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132255.285644406@linuxfoundation.org>
References: <20200227132255.285644406@linuxfoundation.org>
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
@@ -397,6 +397,7 @@ int __init ecryptfs_init_messaging(void)
 					* ecryptfs_message_buf_len),
 				       GFP_KERNEL);
 	if (!ecryptfs_msg_ctx_arr) {
+		kfree(ecryptfs_daemon_hash);
 		rc = -ENOMEM;
 		printk(KERN_ERR "%s: Failed to allocate memory\n", __func__);
 		goto out;


