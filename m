Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3852EC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06CAA21927
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587045590;
	bh=mXmldqJE/IfGSyxwgX4d/vi1/B5euc2LVrh7OmYTZyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TYdPiEtHAA6Euzl++StMVmMAQAAnbEUER0I+CuDKLcMDXa9lB9hx/Oay9ZHNbCE3E
	 CUpqH3ZZt1QR29dliH/VxqFJCxXswfvSdu95hMpFs1y6KHeQI2fzBHVS9UDiIBPelX
	 eIjXjPy9w98F/ROtSM/TWeoFMYyQp9ZIsV9ioM2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898878AbgDPN7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 09:59:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896335AbgDPNkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:40:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2932920732;
        Thu, 16 Apr 2020 13:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044409;
        bh=mXmldqJE/IfGSyxwgX4d/vi1/B5euc2LVrh7OmYTZyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nPB7KtPz6ycoj3IBf82Fi1Wtqxol1kECbx8nfViwnaoDQbRDoxxpuPRHE5jWgUZND
         qWPXlMB0DvSW2+CyOdNLJBOLwwFar7TETDOmudMopMUXY2IL2wmDTtRv8L41R6AT5a
         i+JVUuZ71Pk36Fmi/515xiW6MK28VYErPztcTemo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robbie Ko <robbieko@synology.com>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.5 165/257] btrfs: fix missing semaphore unlock in btrfs_sync_file
Date:   Thu, 16 Apr 2020 15:23:36 +0200
Message-Id: <20200416131347.137167039@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.891903893@linuxfoundation.org>
References: <20200416131325.891903893@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robbie Ko <robbieko@synology.com>

commit 6ff06729c22ec0b7498d900d79cc88cfb8aceaeb upstream.

Ordered ops are started twice in sync file, once outside of inode mutex
and once inside, taking the dio semaphore. There was one error path
missing the semaphore unlock.

Fixes: aab15e8ec2576 ("Btrfs: fix rare chances for data loss when doing a fast fsync")
CC: stable@vger.kernel.org # 4.19+
Signed-off-by: Robbie Ko <robbieko@synology.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
[ add changelog ]
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/file.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2135,6 +2135,7 @@ int btrfs_sync_file(struct file *file, l
 	 */
 	ret = start_ordered_ops(inode, start, end);
 	if (ret) {
+		up_write(&BTRFS_I(inode)->dio_sem);
 		inode_unlock(inode);
 		goto out;
 	}


