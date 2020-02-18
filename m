Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B385C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D6C24125
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582056350;
	bh=ZNoFQhqDJF5StAaTMZ9SrcEr4X4SKy8i2lcFlXd0zBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z/vAHvO611U8uvubjOmJmEy7qiTxqf36m4WDeXxkeiYIzO50E7pTUbLFI/BbKpRXO
	 jFAODaAX0UqkQ7BE7CRqijxp3LoFW+KQZzPn38InLx1k24IpYUbtCayNNL1w33sIZd
	 aeJYCsuL0WNkMF3rbKTi6uLeL6twNpjD/5aDBD/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbgBRUBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:01:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:40694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727656AbgBRUBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 15:01:11 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D445F24676;
        Tue, 18 Feb 2020 20:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582056071;
        bh=ZNoFQhqDJF5StAaTMZ9SrcEr4X4SKy8i2lcFlXd0zBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c0WgyTH8AuMdnBWHVwG9ClB771v0ZY2NuwenjHtW/J/0IErrSYgRLtsaidLWID/JI
         1pn0lF4JFU/elFpbCT4PJfaTzMk18Re4+MzxogCYrbOY6J3PdBCMbrvRqEBdDeFV2j
         YdgnL86AKG4FubWRekgzonT3QZag2c129qBEPt6c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Murphy <lists@colorremedies.com>,
        Anand Jain <anand.jain@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.5 23/80] btrfs: print message when tree-log replay starts
Date:   Tue, 18 Feb 2020 20:54:44 +0100
Message-Id: <20200218190434.586993436@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200218190432.043414522@linuxfoundation.org>
References: <20200218190432.043414522@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Sterba <dsterba@suse.com>

commit e8294f2f6aa6208ed0923aa6d70cea3be178309a upstream.

There's no logged information about tree-log replay although this is
something that points to previous unclean unmount. Other filesystems
report that as well.

Suggested-by: Chris Murphy <lists@colorremedies.com>
CC: stable@vger.kernel.org # 4.4+
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/disk-io.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3164,6 +3164,7 @@ int __cold open_ctree(struct super_block
 	/* do not make disk changes in broken FS or nologreplay is given */
 	if (btrfs_super_log_root(disk_super) != 0 &&
 	    !btrfs_test_opt(fs_info, NOLOGREPLAY)) {
+		btrfs_info(fs_info, "start tree-log replay");
 		ret = btrfs_replay_log(fs_info, fs_devices);
 		if (ret) {
 			err = ret;


