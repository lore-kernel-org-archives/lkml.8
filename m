Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E42C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8F572084D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587731420;
	bh=IUCErDYU5+chUFB9+LblbUcLmt79a5CAIndVF79zzyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J6UYdaWRPmtD69wbf9QFGWjoTjUQ9NjifmdzUNlGimoMKvnHsIu0I062RbiB15hMa
	 I0LqrOSCxuFO+v8A2JUsf8o5B77qN4qtcpHSncHULAkpWnInZxg+pQZItTDVTb9AIW
	 1byhjIJ64105ZSpBCwFDfGHfZf8s6C9fpRta8THk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgDXMaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 08:30:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:53758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728098AbgDXMXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 08:23:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D339020776;
        Fri, 24 Apr 2020 12:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587731022;
        bh=IUCErDYU5+chUFB9+LblbUcLmt79a5CAIndVF79zzyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zwo1FmAO7tVEIUmg3qmd96ARoD0Msmy6lRm4rM9OPb7JgAk0z3M4rdOXADz1TbzIa
         6GB5or2oSMJ7csl1mVMPd+4Hnav27fAEJZy2m0rE7RxKzeB7jSlJi9Gu2msVv2nqZo
         s2dDg6egHqfPY0y8HwWKqExekawle2RDvnUEI8Ss=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>, Wei Liu <wl@xen.org>,
        Sasha Levin <sashal@kernel.org>, xen-devel@lists.xenproject.org
Subject: [PATCH AUTOSEL 5.4 16/26] xen/xenbus: ensure xenbus_map_ring_valloc() returns proper grant status
Date:   Fri, 24 Apr 2020 08:23:13 -0400
Message-Id: <20200424122323.10194-16-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424122323.10194-1-sashal@kernel.org>
References: <20200424122323.10194-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index e17ca81561713..a38292ef79f6d 100644
--- a/drivers/xen/xenbus/xenbus_client.c
+++ b/drivers/xen/xenbus/xenbus_client.c
@@ -448,7 +448,14 @@ EXPORT_SYMBOL_GPL(xenbus_free_evtchn);
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

