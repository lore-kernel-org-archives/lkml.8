Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60BFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C81720758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597686904;
	bh=5GDMueqNpv673QiI73sCw3/yXTsCns+lReg0nfYIfr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QczCKM25UMM38XswAlwn6ns3ionyrPRhgRxUNgpfWcIuA7tBh7aScSjpvZewXiiIy
	 hqM2+q2VgHxV0ka+gFZfcwEfXZ6VYNCt1/6r6xw3nKXDKGCMzBBZHmbWvr/4o+ebI3
	 ERsS5vvpuzsxQ7FDWIDziD7KxNcEqm+YPcTdIStw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388608AbgHQRy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:54:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388589AbgHQQLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:11:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B34BC22BF5;
        Mon, 17 Aug 2020 16:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680664;
        bh=5GDMueqNpv673QiI73sCw3/yXTsCns+lReg0nfYIfr0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oeZ2CbUYN5twaDEgZ3s6JL4LHk7Tsi4Q2C+UV8TyQq46lQGYE9C9mj6KQSklW9Jch
         4ydtEpukOW7US+ytcFWO5tHVQ8BQmm0aQHSZBYIdeGDXiHvdWVQ7ZvuwYrwGp0+T//
         dZ+Lp9oREmGyHwy1SUqWNY/ppx+zbFa7CvvAJSOY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH 5.4 266/270] xen/balloon: make the balloon wait interruptible
Date:   Mon, 17 Aug 2020 17:17:47 +0200
Message-Id: <20200817143809.060064975@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143755.807583758@linuxfoundation.org>
References: <20200817143755.807583758@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roger Pau Monne <roger.pau@citrix.com>

commit 88a479ff6ef8af7f07e11593d58befc644244ff7 upstream.

So it can be killed, or else processes can get hung indefinitely
waiting for balloon pages.

Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20200727091342.52325-3-roger.pau@citrix.com
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/xen/balloon.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -570,11 +570,13 @@ static int add_ballooned_pages(int nr_pa
 	if (xen_hotplug_unpopulated) {
 		st = reserve_additional_memory();
 		if (st != BP_ECANCELED) {
+			int rc;
+
 			mutex_unlock(&balloon_mutex);
-			wait_event(balloon_wq,
+			rc = wait_event_interruptible(balloon_wq,
 				   !list_empty(&ballooned_pages));
 			mutex_lock(&balloon_mutex);
-			return 0;
+			return rc ? -ENOMEM : 0;
 		}
 	}
 


