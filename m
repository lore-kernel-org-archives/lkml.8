Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943D0C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6707624953
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588341143;
	bh=IN3dBcosvKC2QUoeyRI6B2svCXNsLO997YBPPyyQJAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wZGc1TfYLaJEuTMTyeZr42SnHp5dAPgFbe3oEoEyJlWjTTc7MlMnXiWrBVSStn8dd
	 2jDFRLQa4eYk6K8W9KN+qB3OwOw1p/gik7n5RjG0fD7ryddk3zZqcq6oleXfuqlyUX
	 nWqqmUI0LJPrxBkaYAom8jOAkKSDVulHWNA0a/q4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbgEANwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:52:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730979AbgEANhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:37:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7720B24957;
        Fri,  1 May 2020 13:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340264;
        bh=IN3dBcosvKC2QUoeyRI6B2svCXNsLO997YBPPyyQJAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v090XWm5ipUm0ypRTmUjmDqQJfypChijEz1gZuOZggCRi7Xy18Mka4b8uKWrLRNWY
         4bmCFwXz3GV+QzyKCtYird8I9jsJiQzYxgF1gjPc/FXfjTCcuL/YC4RyKIskf/m6lc
         07E5lJDnygT5CNuA0xfJhBDaf+IzFJAwjfPSR3Vo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Wei Liu <wl@xen.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 37/46] xen/xenbus: ensure xenbus_map_ring_valloc() returns proper grant status
Date:   Fri,  1 May 2020 15:23:02 +0200
Message-Id: <20200501131511.871004246@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131457.023036302@linuxfoundation.org>
References: <20200501131457.023036302@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juergen Gross <jgross@suse.com>

[ Upstream commit 6b51fd3f65a22e3d1471b18a1d56247e246edd46 ]

xenbus_map_ring_valloc() maps a ring page and returns the status of the
used grant (0 meaning success).

There are Xen hypervisors which might return the value 1 for the status
of a failed grant mapping due to a bug. Some callers of
xenbus_map_ring_valloc() test for errors by testing the returned status
to be less than zero, resulting in no error detected and crashing later
due to a not available ring page.

Set the return value of xenbus_map_ring_valloc() to GNTST_general_error
in case the grant status reported by Xen is greater than zero.

This is part of XSA-316.

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Wei Liu <wl@xen.org>
Link: https://lore.kernel.org/r/20200326080358.1018-1-jgross@suse.com
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/xenbus/xenbus_client.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/xenbus/xenbus_client.c b/drivers/xen/xenbus/xenbus_client.c
index a1c17000129ba..e94a61eaeceb0 100644
--- a/drivers/xen/xenbus/xenbus_client.c
+++ b/drivers/xen/xenbus/xenbus_client.c
@@ -450,7 +450,14 @@ EXPORT_SYMBOL_GPL(xenbus_free_evtchn);
 int xenbus_map_ring_valloc(struct xenbus_device *dev, grant_ref_t *gnt_refs,
 			   unsigned int nr_grefs, void **vaddr)
 {
-	return ring_ops->map(dev, gnt_refs, nr_grefs, vaddr);
+	int err;
+
+	err = ring_ops->map(dev, gnt_refs, nr_grefs, vaddr);
+	/* Some hypervisors are buggy and can return 1. */
+	if (err > 0)
+		err = GNTST_general_error;
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(xenbus_map_ring_valloc);
 
-- 
2.20.1



