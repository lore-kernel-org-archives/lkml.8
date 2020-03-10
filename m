Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2297C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C86E2208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583845436;
	bh=WT1CUfg1qElEb8x9nr6gHgJArDA6hGpqVjQJywTOviU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UphQRZCauhyNZ7YUMonUUUZVEEsbtiTi3dFdXeU+jNBcPEh21E/YPK7Uq6MNmwRi2
	 V+OjLnporp6kagULbgeTgWZfAzr8b+B5eY0YhJ3cBuLOFoZbOS0SoDH3eBYKhOsfIf
	 aU5ouUza3Wlpw5KMvA5jC9/cz5/mtbOjhqNHNoGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730671AbgCJNDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:03:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:48746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730659AbgCJNDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:03:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BACB1208E4;
        Tue, 10 Mar 2020 13:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845432;
        bh=WT1CUfg1qElEb8x9nr6gHgJArDA6hGpqVjQJywTOviU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fyIjbkCbJPKqszskHSr+20Kk6GHs1ciAtVl+J/nKjMYiIQg1zq1TNTU1hbWTb7uJS
         CaKzOAVR/E0aYAREwYzn4+S/cK0xDWQWkAFwDBzlgg8Pk83noE3oF2slaDn1lLSyQC
         l5QDtvamXHQJ3uYOFJQykjvBPZhU7EojzOI6Y/Ww=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 5.5 180/189] sched/fair: Fix statistics for find_idlest_group()
Date:   Tue, 10 Mar 2020 13:40:17 +0100
Message-Id: <20200310123657.801985824@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123639.608886314@linuxfoundation.org>
References: <20200310123639.608886314@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Guittot <vincent.guittot@linaro.org>

commit 289de35984815576793f579ec27248609e75976e upstream.

sgs->group_weight is not set while gathering statistics in
update_sg_wakeup_stats(). This means that a group can be classified as
fully busy with 0 running tasks if utilization is high enough.

This path is mainly used for fork and exec.

Fixes: 57abff067a08 ("sched/fair: Rework find_idlest_group()")
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Link: https://lore.kernel.org/r/20200218144534.4564-1-vincent.guittot@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/sched/fair.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8315,6 +8315,8 @@ static inline void update_sg_wakeup_stat
 
 	sgs->group_capacity = group->sgc->capacity;
 
+	sgs->group_weight = group->group_weight;
+
 	sgs->group_type = group_classify(sd->imbalance_pct, group, sgs);
 
 	/*


