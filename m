Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82B3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFBCB221FD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592444516;
	bh=UGhfDyzH5DKoRcZ9PfBcUbV7VLVNuUQ36yNDMsI1WJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XWQTAPK2Ga2LdeRPeGIzwFe7zu6Anb/XfHWRYpRpdGCAm9oRIr1EnGPnTsEgD6Qwf
	 TMj1VfpSE0Paof5/wGoRTpw0rx56MwTrRRGvtqVCmIu2ILg3j2/0Cojx462LiNz9MQ
	 DpuY6S7koaW5zy3Ll/Y5UCfmY7j3sIRzrYyVkDa0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732316AbgFRB3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:29:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:33876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731014AbgFRB0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:26:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B183D20B1F;
        Thu, 18 Jun 2020 01:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443584;
        bh=UGhfDyzH5DKoRcZ9PfBcUbV7VLVNuUQ36yNDMsI1WJA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JSIp9F9yX/43dwq5ycPHSiONKYpHN2LzEU+k5Du3/AuRytDHCZL+DJ45jKk9uJpUs
         rqBE/2VtxXZqHBK831c+n77cgEi39RvvCIm0gNGs4G4Jq6+ABXkSE6wN1SGGeEcmoX
         Y3uZZ1lvYcVX7tj1uNKOsuKO4Z0pJO8agLZbd/Hk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin Wilck <mwilck@suse.com>, Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <sashal@kernel.org>, dm-devel@redhat.com
Subject: [PATCH AUTOSEL 4.14 019/108] dm mpath: switch paths in dm_blk_ioctl() code path
Date:   Wed, 17 Jun 2020 21:24:31 -0400
Message-Id: <20200618012600.608744-19-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012600.608744-1-sashal@kernel.org>
References: <20200618012600.608744-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 8b7328666eaa..7c60aace8d25 100644
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

