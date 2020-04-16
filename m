Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAFDC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF686214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587052544;
	bh=26hgxjMd+f9rckP63OnUNWM2GnK+GowOVTaS4I0FbMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yhrKA3EMOd9sPJB6oAj2pJC0iBY02u8fpRpH/yHyfHW+WDfVBdi7Y1kczi+lFMLfU
	 Kat/IMj5dlw5sz8L3g8ggawybzv0sb+MuLeCsK8HiuYKj2xi01dJV5ZRAFy04RZFNr
	 ERkH0cxhNrlgFw2vEeU/91w/SYDnxBrFsHPYncj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442693AbgDPPzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:55:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:39362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896012AbgDPN33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:29:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 549C920767;
        Thu, 16 Apr 2020 13:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587043768;
        bh=26hgxjMd+f9rckP63OnUNWM2GnK+GowOVTaS4I0FbMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H2mkGU2jN+FhuFW7FuRHCORjrdVqcTkMswiv67NtMbAQHmXc7UPrF6NVKL+zzMeWt
         BxnsthUTTWtnP+COZ2Kfv2T5okMVoalzVaT0YbVppWbNNEUTTAHuRrSol0rU1UNwoc
         AZ/iPgAPvG3/jbjvaYMDFMi/2B8dB8zV1VJz35OU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robbie Ko <robbieko@synology.com>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 093/146] btrfs: fix missing semaphore unlock in btrfs_sync_file
Date:   Thu, 16 Apr 2020 15:23:54 +0200
Message-Id: <20200416131255.505565278@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131242.353444678@linuxfoundation.org>
References: <20200416131242.353444678@linuxfoundation.org>
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
@@ -2137,6 +2137,7 @@ int btrfs_sync_file(struct file *file, l
 	 */
 	ret = start_ordered_ops(inode, start, end);
 	if (ret) {
+		up_write(&BTRFS_I(inode)->dio_sem);
 		inode_unlock(inode);
 		goto out;
 	}


