Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D8BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 636A7204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405197AbgFSQqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405063AbgFSQqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:46:10 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A718C0613EE;
        Fri, 19 Jun 2020 09:46:10 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jmK9U-00044z-FZ; Fri, 19 Jun 2020 18:46:04 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0ECDF1C06DA;
        Fri, 19 Jun 2020 18:46:01 +0200 (CEST)
Date:   Fri, 19 Jun 2020 16:46:00 -0000
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efivarfs: Update inode modification time for
 successful writes
Cc:     Lennart Poettering <mzxreary@0pointer.de>,
        Tony Luck <tony.luck@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200528194905.690-2-tony.luck@intel.com>
References: <20200528194905.690-2-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <159258516080.16989.10213715663213506670.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     2096721f1577b51b574fa06a7d91823dffe7267a
Gitweb:        https://git.kernel.org/tip/2096721f1577b51b574fa06a7d91823dffe7267a
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Thu, 28 May 2020 12:49:04 -07:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Mon, 15 Jun 2020 14:38:56 +02:00

efivarfs: Update inode modification time for successful writes

Some applications want to be able to see when EFI variables
have been updated.

Update the modification time for successful writes.

Reported-by: Lennart Poettering <mzxreary@0pointer.de>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/r/20200528194905.690-2-tony.luck@intel.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 fs/efivarfs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/efivarfs/file.c b/fs/efivarfs/file.c
index e9e27a2..4b8bc45 100644
--- a/fs/efivarfs/file.c
+++ b/fs/efivarfs/file.c
@@ -51,6 +51,7 @@ static ssize_t efivarfs_file_write(struct file *file,
 	} else {
 		inode_lock(inode);
 		i_size_write(inode, datasize + sizeof(attributes));
+		inode->i_mtime = current_time(inode);
 		inode_unlock(inode);
 	}
 
