Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2323FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EADED20658
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597919250;
	bh=mtp6d66p2I3R3obgM+Jhh+mnbb27xVJ81nUwr8awmjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KIYNaa5AQHzc44v33bjLY42bOP5Yc4tDQSCfOB6iqz3dc4v4kJy6wtAUszjVWtSzM
	 6++xNi0ISFbxS3pImaJ6I30XZu/ZfDmQqkzTj5g/339AEygObN6ixTz72rYTvxx/zB
	 YuFE0IHfliZ6RklhyC0r89ra4X3t2wziK6w0WJPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731219AbgHTK13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:27:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731629AbgHTKWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:22:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75D582072D;
        Thu, 20 Aug 2020 10:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918950;
        bh=mtp6d66p2I3R3obgM+Jhh+mnbb27xVJ81nUwr8awmjE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kZ3nLOWPZIO95xweml+E8E+Yl0/zu49M0Z/0utONxWXbTbDajlHzRq+46cknNFgkN
         iG7GTDPFk6wYNMwa3tX7GUEuyIMEtZeUPVKNdDHT2vPWue8PVXSSmFhXIQYFWMJXBJ
         cwX2hqFdHbR+sperXdp1pkqLdcldLi4gYjgkdX5I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Wu <alexwu@synology.com>,
        BingJing Chang <bingjingc@synology.com>,
        Danny Shih <dannyshih@synology.com>,
        ChangSyun Peng <allenpeng@synology.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 4.4 126/149] md/raid5: Fix Force reconstruct-write io stuck in degraded raid5
Date:   Thu, 20 Aug 2020 11:23:23 +0200
Message-Id: <20200820092131.806741655@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820092125.688850368@linuxfoundation.org>
References: <20200820092125.688850368@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChangSyun Peng <allenpeng@synology.com>

commit a1c6ae3d9f3dd6aa5981a332a6f700cf1c25edef upstream.

In degraded raid5, we need to read parity to do reconstruct-write when
data disks fail. However, we can not read parity from
handle_stripe_dirtying() in force reconstruct-write mode.

Reproducible Steps:

1. Create degraded raid5
mdadm -C /dev/md2 --assume-clean -l5 -n3 /dev/sda2 /dev/sdb2 missing
2. Set rmw_level to 0
echo 0 > /sys/block/md2/md/rmw_level
3. IO to raid5

Now some io may be stuck in raid5. We can use handle_stripe_fill() to read
the parity in this situation.

Cc: <stable@vger.kernel.org> # v4.4+
Reviewed-by: Alex Wu <alexwu@synology.com>
Reviewed-by: BingJing Chang <bingjingc@synology.com>
Reviewed-by: Danny Shih <dannyshih@synology.com>
Signed-off-by: ChangSyun Peng <allenpeng@synology.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/raid5.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -3345,6 +3345,7 @@ static int need_this_block(struct stripe
 	 * is missing/faulty, then we need to read everything we can.
 	 */
 	if (sh->raid_conf->level != 6 &&
+	    sh->raid_conf->rmw_level != PARITY_DISABLE_RMW &&
 	    sh->sector < sh->raid_conf->mddev->recovery_cp)
 		/* reconstruct-write isn't being forced */
 		return 0;
@@ -4479,7 +4480,7 @@ static void handle_stripe(struct stripe_
 	 * or to load a block that is being partially written.
 	 */
 	if (s.to_read || s.non_overwrite
-	    || (conf->level == 6 && s.to_write && s.failed)
+	    || (s.to_write && s.failed)
 	    || (s.syncing && (s.uptodate + s.compute < disks))
 	    || s.replacing
 	    || s.expanding)


