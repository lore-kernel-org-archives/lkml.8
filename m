Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F84C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B2D4207DE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599581882;
	bh=vJitGi6HoHhou8yOBfLEmrf3ya1C/eGIv+uiqN/Adck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v0F/+UkuL9NxDfG++tBbbQFbFFHsxifOrm6ERgzr+Ghfuv5x4Jj4O91PV2SuMQDuu
	 0S+nhpC7CQvTJyujsWNLQN87rw9pvugH65z2eOOGX9axVTxAqUVIPJy+UaQnVhqSCv
	 CY9ry5/DNN2bLhgisyDOYvRpTFyw7LcFzb9C/OBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731544AbgIHQRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:17:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:53448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731038AbgIHQH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:07:27 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECF3B23E55;
        Tue,  8 Sep 2020 15:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599580038;
        bh=vJitGi6HoHhou8yOBfLEmrf3ya1C/eGIv+uiqN/Adck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UqtBepm4uVAPnooM0cQD2W8m67+gj4+1Vg2zsl4g+D/NZvrgJxVaflCsiBz4sCrWl
         GmXT5GL5nkm8vufq9uOUGj7e+UoUrZyND2PBstzTSfnMdgaOUyD0QyL4wEl4XZj7+x
         iUCrN3YG24MAvesmbX9YbHzoM/GwQLlQRRvJl8ZY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Marzinski <bmarzins@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 5.4 114/129] dm mpath: fix racey management of PG initialization
Date:   Tue,  8 Sep 2020 17:25:55 +0200
Message-Id: <20200908152235.549282325@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152229.689878733@linuxfoundation.org>
References: <20200908152229.689878733@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Snitzer <snitzer@redhat.com>

commit c322ee9320eaa4013ca3620b1130992916b19b31 upstream.

Commit 935fcc56abc3 ("dm mpath: only flush workqueue when needed")
changed flush_multipath_work() to avoid needless workqueue
flushing (of a multipath global workqueue). But that change didn't
realize the surrounding flush_multipath_work() code should also only
run if 'pg_init_in_progress' is set.

Fix this by only doing all of flush_multipath_work()'s PG init related
work if 'pg_init_in_progress' is set.

Otherwise multipath_wait_for_pg_init_completion() will run
unconditionally but the preceeding flush_workqueue(kmpath_handlerd)
may not. This could lead to deadlock (though only if kmpath_handlerd
never runs a corresponding work to decrement 'pg_init_in_progress').

It could also be, though highly unlikely, that the kmpath_handlerd
work that does PG init completes before 'pg_init_in_progress' is set,
and then an intervening DM table reload's multipath_postsuspend()
triggers flush_multipath_work().

Fixes: 935fcc56abc3 ("dm mpath: only flush workqueue when needed")
Cc: stable@vger.kernel.org
Reported-by: Ben Marzinski <bmarzins@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-mpath.c |   22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

--- a/drivers/md/dm-mpath.c
+++ b/drivers/md/dm-mpath.c
@@ -1190,17 +1190,25 @@ static void multipath_wait_for_pg_init_c
 static void flush_multipath_work(struct multipath *m)
 {
 	if (m->hw_handler_name) {
-		set_bit(MPATHF_PG_INIT_DISABLED, &m->flags);
-		smp_mb__after_atomic();
+		unsigned long flags;
+
+		if (!atomic_read(&m->pg_init_in_progress))
+			goto skip;
+
+		spin_lock_irqsave(&m->lock, flags);
+		if (atomic_read(&m->pg_init_in_progress) &&
+		    !test_and_set_bit(MPATHF_PG_INIT_DISABLED, &m->flags)) {
+			spin_unlock_irqrestore(&m->lock, flags);
 
-		if (atomic_read(&m->pg_init_in_progress))
 			flush_workqueue(kmpath_handlerd);
-		multipath_wait_for_pg_init_completion(m);
+			multipath_wait_for_pg_init_completion(m);
 
-		clear_bit(MPATHF_PG_INIT_DISABLED, &m->flags);
-		smp_mb__after_atomic();
+			spin_lock_irqsave(&m->lock, flags);
+			clear_bit(MPATHF_PG_INIT_DISABLED, &m->flags);
+		}
+		spin_unlock_irqrestore(&m->lock, flags);
 	}
-
+skip:
 	if (m->queue_mode == DM_TYPE_BIO_BASED)
 		flush_work(&m->process_queued_bios);
 	flush_work(&m->trigger_event);


