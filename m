Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039E5C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4750206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597920768;
	bh=XCOsw6EYaCe/VuNEJW7IXNxuEoH4nyKL4wkuResnRA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gT8lrAbjFX9c4iFsr+TMUI7AfKWa4nKDZg+TIDd9iqoAoKU/HXFJJ0EInRCrc6azQ
	 nCe95daNoDTKwVs+PzJknP1vYU3cSCZ0rcxyreBhaeKqn63P5H1/mjEUxtylNAGgp3
	 tBRIDl0nUKwLS13fHj3jcRiza65hEkK+OLagWoUw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731565AbgHTKwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:52:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:32830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731168AbgHTKOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:14:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D14F32067C;
        Thu, 20 Aug 2020 10:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918464;
        bh=XCOsw6EYaCe/VuNEJW7IXNxuEoH4nyKL4wkuResnRA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QzqNJjyHmcm4YmCIlGnIjYT49VOXt2Zao3mzEcHhSATtLASuUG4yKrPqUCp343VW/
         nluFlcsfyl46e2oxeqJTwBkyHucLSf6Ec3A29T5UIObSZo6t7Ei1YTI2ZuzmMxJJlo
         Uu5X5nO3RMGlBS6KeIYN9YcBpKp+yUX86ZTPrdKs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Wu <alexwu@synology.com>,
        BingJing Chang <bingjingc@synology.com>,
        Danny Shih <dannyshih@synology.com>,
        ChangSyun Peng <allenpeng@synology.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 4.14 179/228] md/raid5: Fix Force reconstruct-write io stuck in degraded raid5
Date:   Thu, 20 Aug 2020 11:22:34 +0200
Message-Id: <20200820091616.523407496@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091607.532711107@linuxfoundation.org>
References: <20200820091607.532711107@linuxfoundation.org>
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
@@ -3593,6 +3593,7 @@ static int need_this_block(struct stripe
 	 * is missing/faulty, then we need to read everything we can.
 	 */
 	if (sh->raid_conf->level != 6 &&
+	    sh->raid_conf->rmw_level != PARITY_DISABLE_RMW &&
 	    sh->sector < sh->raid_conf->mddev->recovery_cp)
 		/* reconstruct-write isn't being forced */
 		return 0;
@@ -4829,7 +4830,7 @@ static void handle_stripe(struct stripe_
 	 * or to load a block that is being partially written.
 	 */
 	if (s.to_read || s.non_overwrite
-	    || (conf->level == 6 && s.to_write && s.failed)
+	    || (s.to_write && s.failed)
 	    || (s.syncing && (s.uptodate + s.compute < disks))
 	    || s.replacing
 	    || s.expanding)


