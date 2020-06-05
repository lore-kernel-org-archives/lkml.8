Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCCFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BC2F20663
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591367010;
	bh=aDgcUaJq4bg5nRl9WjF9YUlhj1m0hnmtac2sqOvW77o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z8WaoewdhdYBOjkVRnNXB4RSITWwCnwcGQfNt4GEbPa1ovPkW+9ikZeDDPeKJqL41
	 gaobNvFEea0c3Tx/aYBOCfQVffu455W4h98A/PQHP1GEqmTQrsDlvuCv71ki7OdHgq
	 lB9CThmuYwKBI5D8kN1j5Y13h+gsUvAUaK/Ysg3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbgFEOSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:18:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:48340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728568AbgFEOR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 10:17:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C90FB208A7;
        Fri,  5 Jun 2020 14:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591366678;
        bh=aDgcUaJq4bg5nRl9WjF9YUlhj1m0hnmtac2sqOvW77o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=imTdv7XVCxolYttRJzJtcEIsONKuk3o+Q8tOGbdtO9di90gLpBdGs817EHNzlU4OL
         swSCOUwrH9/y0wF5HaXbLb+QOWmKzZVFbiKjoPJZjHjyWOAfExlw0QtxQoyzX2Rm7t
         hS8Cx5SiJeZ6Tnu705ZH3sBvAala1VsQ+l786qb8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 01/38] Revert "cgroup: Add memory barriers to plug cgroup_rstat_updated() race window"
Date:   Fri,  5 Jun 2020 16:14:44 +0200
Message-Id: <20200605140252.623231453@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200605140252.542768750@linuxfoundation.org>
References: <20200605140252.542768750@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tejun Heo <tj@kernel.org>

[ Upstream commit d8ef4b38cb69d907f9b0e889c44d05fc0f890977 ]

This reverts commit 9a9e97b2f1f2 ("cgroup: Add memory barriers to plug
cgroup_rstat_updated() race window").

The commit was added in anticipation of memcg rstat conversion which needed
synchronous accounting for the event counters (e.g. oom kill count). However,
the conversion didn't get merged due to percpu memory overhead concern which
couldn't be addressed at the time.

Unfortunately, the patch's addition of smp_mb() to cgroup_rstat_updated()
meant that every scheduling event now had to go through an additional full
barrier and Mel Gorman noticed it as 1% regression in netperf UDP_STREAM test.

There's no need to have this barrier in tree now and even if we need
synchronous accounting in the future, the right thing to do is separating that
out to a separate function so that hot paths which don't care about
synchronous behavior don't have to pay the overhead of the full barrier. Let's
revert.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Mel Gorman <mgorman@techsingularity.net>
Link: http://lkml.kernel.org/r/20200409154413.GK3818@techsingularity.net
Cc: v4.18+
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/cgroup/rstat.c |   16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -33,12 +33,9 @@ void cgroup_rstat_updated(struct cgroup
 		return;
 
 	/*
-	 * Paired with the one in cgroup_rstat_cpu_pop_upated().  Either we
-	 * see NULL updated_next or they see our updated stat.
-	 */
-	smp_mb();
-
-	/*
+	 * Speculative already-on-list test. This may race leading to
+	 * temporary inaccuracies, which is fine.
+	 *
 	 * Because @parent's updated_children is terminated with @parent
 	 * instead of NULL, we can tell whether @cgrp is on the list by
 	 * testing the next pointer for NULL.
@@ -134,13 +131,6 @@ static struct cgroup *cgroup_rstat_cpu_p
 		*nextp = rstatc->updated_next;
 		rstatc->updated_next = NULL;
 
-		/*
-		 * Paired with the one in cgroup_rstat_cpu_updated().
-		 * Either they see NULL updated_next or we see their
-		 * updated stat.
-		 */
-		smp_mb();
-
 		return pos;
 	}
 


