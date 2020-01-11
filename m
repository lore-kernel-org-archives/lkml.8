Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170CCC33CA3
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 09:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70682077C
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 09:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578736254;
	bh=sgPoZuyrC/wmdnNYYIwRy3WGKs/xJNs/D6IS6/65TD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eHWsKiaXDG3QcMWCjIunI45G3PRYUHYRBMS2zRZCpEw1m2n7BV9Y6XeYwcL/mu9mX
	 dZEFbhDhuYfbCtaGPwRrL532MOlbzug58zKxTGmNPcQ3PItj4Q792KNY3iJfhc3cdT
	 XRnLuoCjNeI4Oh+KTc7B/hPTkosZc4Fr/ncvmK6w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbgAKJux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 04:50:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:32964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728789AbgAKJuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 04:50:51 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CF0A2082E;
        Sat, 11 Jan 2020 09:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578736251;
        bh=sgPoZuyrC/wmdnNYYIwRy3WGKs/xJNs/D6IS6/65TD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=edULj/COvbgb5Tn892k/ZA6QqZZ+VgY18N9A1k3MWm0aVdYBy6+6Cta/xWdlDB+41
         +lIySgc3+buy7O3vNOk+NdWt0IfAHuzDRE/uKU+e8d/4jDAgSeofp/Dutyof0kDsMH
         G8gbAZDdNqY5xch2wYTkvYAOpk/bJt7ynpUdp3Sk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicholas Tsirakis <niko.tsirakis@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 11/59] xen/balloon: fix ballooned page accounting without hotplug enabled
Date:   Sat, 11 Jan 2020 10:49:20 +0100
Message-Id: <20200111094839.923105101@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094835.417654274@linuxfoundation.org>
References: <20200111094835.417654274@linuxfoundation.org>
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
index cfab1d24e4bc..1c789056e7e8 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -392,7 +392,8 @@ static struct notifier_block xen_memory_nb = {
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



