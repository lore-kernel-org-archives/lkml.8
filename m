Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033B2C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF734208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585056336;
	bh=JSFuvJQzJ7z7qEnJYSNpQwGk9hUieakJek03WvMDRPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oTc7/DHgtclEvUXi/QZEaCqrAf4fX0XrONo2URFtGL2QoOAdxsWUN3MViaJ2r/079
	 rc5XG7bQI3vzbSgU9OT1UMkb9c4vyJgkYm1L1Q6qGPSO5adk2j7/oyzpSWTK4lA2fg
	 suVBGcewn0g+qFJU6bPo+/7KLJMVXHbFg1HknkZY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbgCXNZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:25:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:49856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgCXNZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:25:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D30AE208FE;
        Tue, 24 Mar 2020 13:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585056333;
        bh=JSFuvJQzJ7z7qEnJYSNpQwGk9hUieakJek03WvMDRPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zwztQlbBaaM4heHB6SciBlnRK9eHbtWR4vDbQM0RqnBY76lMN/jZ4qGzCHXn9/ANr
         xNMng5gh9y7e6L4w3A55Y9M8DlROu68vQmisChubHL2ueA5zKC+SQLvIxNKwcI/u0E
         w4g0LiPzTLFp8V0Yl+ByTGOb1Sn2OU4xjQCogWiQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.5 093/119] mm, memcg: fix corruption on 64-bit divisor in memory.high throttling
Date:   Tue, 24 Mar 2020 14:11:18 +0100
Message-Id: <20200324130817.468739261@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324130808.041360967@linuxfoundation.org>
References: <20200324130808.041360967@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Down <chris@chrisdown.name>

commit d397a45fc741c80c32a14e2de008441e9976f50c upstream.

Commit 0e4b01df8659 had a bunch of fixups to use the right division
method.  However, it seems that after all that it still wasn't right --
div_u64 takes a 32-bit divisor.

The headroom is still large (2^32 pages), so on mundane systems you
won't hit this, but this should definitely be fixed.

Fixes: 0e4b01df8659 ("mm, memcg: throttle allocators when failing reclaim over memory.high")
Reported-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Chris Down <chris@chrisdown.name>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Roman Gushchin <guro@fb.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Cc: <stable@vger.kernel.org>	[5.4.x+]
Link: http://lkml.kernel.org/r/80780887060514967d414b3cd91f9a316a16ab98.1584036142.git.chris@chrisdown.name
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/memcontrol.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2339,7 +2339,7 @@ void mem_cgroup_handle_over_high(void)
 	 */
 	clamped_high = max(high, 1UL);
 
-	overage = div_u64((u64)(usage - high) << MEMCG_DELAY_PRECISION_SHIFT,
+	overage = div64_u64((u64)(usage - high) << MEMCG_DELAY_PRECISION_SHIFT,
 			  clamped_high);
 
 	penalty_jiffies = ((u64)overage * overage * HZ)


