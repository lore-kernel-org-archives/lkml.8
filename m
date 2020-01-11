Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E92C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 184662082E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578736820;
	bh=dtthTRTJ8vL/CqL+TZPiYkrcd1PDDV0Edhuth7WZ8C0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2CFS+MPvdK19+ZbrmV5XOtrXPxFEIJWuJZuiSGEu5o5DDAazlWo9dNRqjv4fbPbm1
	 cYC3eRszS0peOiQIEFgPIel68JSQto7+CBC6PwIkW6cGgIcgWn5NSfXw2HLYpFR8qc
	 kAHX4iiOLGpONP3OxbJ6DTA5ZkSweRFe/Kgxx9k0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbgAKKAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:00:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:56054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729412AbgAKKAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:00:13 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54B3A2082E;
        Sat, 11 Jan 2020 10:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578736812;
        bh=dtthTRTJ8vL/CqL+TZPiYkrcd1PDDV0Edhuth7WZ8C0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UhzsAKQPWEPUWrcvSSp2xI8xaWF6rp373acvlDY2jxhRibYtXvhLvKpc/s/e9nHAW
         eNDHxqscwULQ+tpiarINoKL61cda10OYabD6s0aCAy37k2Z5TzH9kIBGvjqrFsuJjE
         w1zUqROb2mGHo6b5BSOYeXTMnQltWkjh4q2iIGUY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicholas Tsirakis <niko.tsirakis@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 13/91] xen/balloon: fix ballooned page accounting without hotplug enabled
Date:   Sat, 11 Jan 2020 10:49:06 +0100
Message-Id: <20200111094847.889748009@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094844.748507863@linuxfoundation.org>
References: <20200111094844.748507863@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juergen Gross <jgross@suse.com>

[ Upstream commit c673ec61ade89bf2f417960f986bc25671762efb ]

When CONFIG_XEN_BALLOON_MEMORY_HOTPLUG is not defined
reserve_additional_memory() will set balloon_stats.target_pages to a
wrong value in case there are still some ballooned pages allocated via
alloc_xenballooned_pages().

This will result in balloon_process() no longer be triggered when
ballooned pages are freed in batches.

Reported-by: Nicholas Tsirakis <niko.tsirakis@gmail.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/balloon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index 731cf54f75c6..05f9f5983ee1 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -403,7 +403,8 @@ static struct notifier_block xen_memory_nb = {
 #else
 static enum bp_state reserve_additional_memory(void)
 {
-	balloon_stats.target_pages = balloon_stats.current_pages;
+	balloon_stats.target_pages = balloon_stats.current_pages +
+				     balloon_stats.target_unpopulated;
 	return BP_ECANCELED;
 }
 #endif /* CONFIG_XEN_BALLOON_MEMORY_HOTPLUG */
-- 
2.20.1



