Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A473C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06D292467B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686595;
	bh=RR+nFKij4VabaC5YVhm66/fxmKNHMt8p/paFyJe6+2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QIyGpq0wylMoZd6MEhLYIWBJs4omB/Ax38D0KrDJgJ6ThdHZsiFDeM6Yy7s9wLIPK
	 NNBEoVGdvRjxHSQwDqh4CXWYuiZQ8fTOgEoX328ZLJzlbN6lpop5h1QEgpCq0GNrT6
	 TnfvMkjIkF0uEYdEGeOAACGULv+TKQs30xoExQsc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733161AbgAVJjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:39:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:56532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733145AbgAVJjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:39:09 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29E0724680;
        Wed, 22 Jan 2020 09:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685948;
        bh=RR+nFKij4VabaC5YVhm66/fxmKNHMt8p/paFyJe6+2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ti3lBZLPCkDKl5aEP71xO2sVzgBAxiWv+RuaKwWx2iWGueMWUQQGBf+8Po0i8eUK2
         3WJQU2YYptPVxu617A8LGUMI97wAUqAEiH0+8AETAy6etOnUl1z5D341b1QQb2gpJ6
         j0QKr+nVnB0NwprlSPsjDibB7SCBI+5qBcocmU2w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Antti Laakso <antti.laakso@intel.com>,
        Vladis Dronov <vdronov@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 47/65] ptp: free ptp device pin descriptors properly
Date:   Wed, 22 Jan 2020 10:29:32 +0100
Message-Id: <20200122092757.884265813@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092750.976732974@linuxfoundation.org>
References: <20200122092750.976732974@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladis Dronov <vdronov@redhat.com>

[ Upstream commit 75718584cb3c64e6269109d4d54f888ac5a5fd15 ]

There is a bug in ptp_clock_unregister(), where ptp_cleanup_pin_groups()
first frees ptp->pin_{,dev_}attr, but then posix_clock_unregister() needs
them to destroy a related sysfs device.

These functions can not be just swapped, as posix_clock_unregister() frees
ptp which is needed in the ptp_cleanup_pin_groups(). Fix this by calling
ptp_cleanup_pin_groups() in ptp_clock_release(), right before ptp is freed.

This makes this patch fix an UAF bug in a patch which fixes an UAF bug.

Reported-by: Antti Laakso <antti.laakso@intel.com>
Fixes: a33121e5487b ("ptp: fix the race between the release of ptp_clock and cdev")
Link: https://lore.kernel.org/netdev/3d2bd09735dbdaf003585ca376b7c1e5b69a19bd.camel@intel.com/
Signed-off-by: Vladis Dronov <vdronov@redhat.com>
Acked-by: Richard Cochran <richardcochran@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ptp/ptp_clock.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -179,6 +179,7 @@ static void ptp_clock_release(struct dev
 {
 	struct ptp_clock *ptp = container_of(dev, struct ptp_clock, dev);
 
+	ptp_cleanup_pin_groups(ptp);
 	mutex_destroy(&ptp->tsevq_mux);
 	mutex_destroy(&ptp->pincfg_mux);
 	ida_simple_remove(&ptp_clocks_map, ptp->index);
@@ -315,9 +316,8 @@ int ptp_clock_unregister(struct ptp_cloc
 	if (ptp->pps_source)
 		pps_unregister_source(ptp->pps_source);
 
-	ptp_cleanup_pin_groups(ptp);
-
 	posix_clock_unregister(&ptp->clock);
+
 	return 0;
 }
 EXPORT_SYMBOL(ptp_clock_unregister);


