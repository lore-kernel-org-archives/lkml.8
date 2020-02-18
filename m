Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722A3C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F2152465A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582055892;
	bh=AsSMnKeMTMcD4kGjUjNdXw9PMfFQvVmGxmsD9F5aTk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ODcJyRXt7MivR57HO98Zvz7FzFHcVdx9OswT9KYVfdbE8SCz0qnEEWO7M49YI/2qu
	 qiqAOjLHCz2iToDZq1odRROhjdiDRnwDfbTQVCQjYwRXiPRPo5NSYOWKxQQHUAMU16
	 uROT/9DE2r6a6OJlWGSmxrEw4idwpHhWpNGKr0es=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgBRT6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:58:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:35626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728116AbgBRT6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:58:07 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 985F324125;
        Tue, 18 Feb 2020 19:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582055887;
        bh=AsSMnKeMTMcD4kGjUjNdXw9PMfFQvVmGxmsD9F5aTk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oI9Th2bUdZ96qGdky642Qm+cSaHFfuNG3abHsWVXvT+Um727/fh6S4yvKpA/zQ0Qt
         9n1ZWECUmkn9mJNjBdnfvhtgWBtwGpYIcabd2LVW5tSHEoBvRFjl6Vp4wbr0rVp990
         qzRlnpUWtmYnUqdXomHPG8c9B2gR15w/siTtwzjs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Murphy <lists@colorremedies.com>,
        Anand Jain <anand.jain@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.4 21/66] btrfs: print message when tree-log replay starts
Date:   Tue, 18 Feb 2020 20:54:48 +0100
Message-Id: <20200218190430.048003245@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200218190428.035153861@linuxfoundation.org>
References: <20200218190428.035153861@linuxfoundation.org>
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
@@ -3167,6 +3167,7 @@ retry_root_backup:
 	/* do not make disk changes in broken FS or nologreplay is given */
 	if (btrfs_super_log_root(disk_super) != 0 &&
 	    !btrfs_test_opt(fs_info, NOLOGREPLAY)) {
+		btrfs_info(fs_info, "start tree-log replay");
 		ret = btrfs_replay_log(fs_info, fs_devices);
 		if (ret) {
 			err = ret;


