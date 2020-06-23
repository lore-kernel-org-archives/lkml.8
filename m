Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F43C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D47ED21D79
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592945052;
	bh=Ue0UmwVWigaMg1k0SBFBFVuMmyzebbHag0LR1QUwES8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LKE4sWfUmnVgrbI/9wImCO6rGAKBSeOn6J9y3FnOfbJJZfiipHQ7bniMbCNvkOkJN
	 ibE3c/o/kasnd27jmCbMaxsQkXCR3Q3wQ/y7kvSRlH1T4kYel2H6oDAHHnWnj10K9j
	 dWhn1aS3B1xL25ozC8CgmMDXcACIuHMGBZNP4GGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403974AbgFWUoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:44:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:41166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403965AbgFWUoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:44:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4A002070E;
        Tue, 23 Jun 2020 20:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592945047;
        bh=Ue0UmwVWigaMg1k0SBFBFVuMmyzebbHag0LR1QUwES8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OzTq1cJ5edBoCgcPX1dILDazTEfiIyBbeCzBuDUVyJcLpgSgQAz1Z32IQkg3QR7uK
         fX3sZFEABEbobWpDFT+57zCcHcuKI4EpSCYJTJISp+r6kOvmYAHrmm9lgYp3Gfw8wR
         7bA94joBpywwV7cTt3Ew+xBKkl2CzFkBK/IC2JMo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Wilck <mwilck@suse.com>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 019/136] dm mpath: switch paths in dm_blk_ioctl() code path
Date:   Tue, 23 Jun 2020 21:57:55 +0200
Message-Id: <20200623195304.580822821@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195303.601828702@linuxfoundation.org>
References: <20200623195303.601828702@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Wilck <mwilck@suse.com>

[ Upstream commit 2361ae595352dec015d14292f1b539242d8446d6 ]

SCSI LUN passthrough code such as qemu's "scsi-block" device model
pass every IO to the host via SG_IO ioctls. Currently, dm-multipath
calls choose_pgpath() only in the block IO code path, not in the ioctl
code path (unless current_pgpath is NULL). This has the effect that no
path switching and thus no load balancing is done for SCSI-passthrough
IO, unless the active path fails.

Fix this by using the same logic in multipath_prepare_ioctl() as in
multipath_clone_and_map().

Note: The allegedly best path selection algorithm, service-time,
still wouldn't work perfectly, because the io size of the current
request is always set to 0. Changing that for the IO passthrough
case would require the ioctl cmd and arg to be passed to dm's
prepare_ioctl() method.

Signed-off-by: Martin Wilck <mwilck@suse.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-mpath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-mpath.c b/drivers/md/dm-mpath.c
index 8b7328666eaaf..7c60aace8d25d 100644
--- a/drivers/md/dm-mpath.c
+++ b/drivers/md/dm-mpath.c
@@ -1815,7 +1815,7 @@ static int multipath_prepare_ioctl(struct dm_target *ti,
 	int r;
 
 	current_pgpath = READ_ONCE(m->current_pgpath);
-	if (!current_pgpath)
+	if (!current_pgpath || !test_bit(MPATHF_QUEUE_IO, &m->flags))
 		current_pgpath = choose_pgpath(m, 0);
 
 	if (current_pgpath) {
-- 
2.25.1



