Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34409C2BB55
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 22:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03AEA2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 22:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uW6JEUpT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgDJWwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 18:52:33 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:42323 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgDJWwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 18:52:33 -0400
Received: by mail-pf1-f201.google.com with SMTP id q11so3024933pfq.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 15:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=QnD7jf6NnpFfWYgdUU7JMnulWidV5JBOmVwlz8r8qHQ=;
        b=uW6JEUpTkFJrIz4a/B7t0DrKvY78+2gD6Qkm/ZrG7eZ1wnmYTNorgXKeWxCxmP89/N
         14ab2dqaU0bXB5HmErhSnORXACIPJ4MoENRaui52jzNHfJyGUjEucuVxmFDxl9QvIGUu
         K0otgS/ZW1vHkc08q15eGSp5+L03DRZwKsn9CoaV7P9EFLyu1IrPriyJvwfrTrjeMG0R
         NWIETnbwGxu1DeAToCE9yOkwubR04rgdfyd43hM9Q6AbqJWNf53Umm0GKVLV9Rk/khbN
         CevpEApfoOyFNEBzT/3ljlVTzRiIszf9p4P6jKvFqbblbpVd3gaOO30QnjHun+TiudTt
         p/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=QnD7jf6NnpFfWYgdUU7JMnulWidV5JBOmVwlz8r8qHQ=;
        b=aac5pubXYOhoVMQvWl6RVGeNODIGGtXXTkadvB9bHRrpwq+n7rTha1lheDs8LSTHXz
         7nwufrotSjXTamji/zOsnZiynGQCKoHnc6DNuNdXhE3BnZCCG4T3PJTEVXGZuxk0zZBB
         FEmM+tNzHi/5JIRt8ycb1n9bv0Tb/dt6MqX7pD3CX/JzelXwzkEMVhsFRvuJogbOh4gZ
         TqwIVPGgnxf1hTO1atSbFptQnlLK4v9SupmAWyXpb7EEtxcAuk9G7GZGLwbm7JAU9hPU
         MoLYlYpZbbFIluOrLu/uQbIrSFnQGrQncdpjnVLGa+7ep5ONwy87mBDWlduEzE03mbQT
         cJXw==
X-Gm-Message-State: AGi0PuaX5Im7LpMZLkFl7uAKoAOaNti2Z0VMyhsgI9me3E09d6x9uQMr
        YuPGiXNMP8p6ZT8Pyiky73RFI35/4bPU
X-Google-Smtp-Source: APiQypIF48wIyoWABG5tdcA6Jz16Oc92ssFuXtk+9oHDa5yZM/d6oqtE/W7+b6Ug0LHsJ/v7WMLL3oyVdwqt
X-Received: by 2002:a17:90a:276a:: with SMTP id o97mr8003192pje.194.1586559150739;
 Fri, 10 Apr 2020 15:52:30 -0700 (PDT)
Date:   Fri, 10 Apr 2020 15:52:06 -0700
Message-Id: <20200410225208.109717-1-joshdon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH 0/2] Fix race in CFS bandwidth
From:   Josh Don <joshdon@google.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Paul Turner <pjt@google.com>,
        Huaixin Chang <changhuaixin@linux.alibaba.com>,
        Phil Auld <pauld@redhead.com>, linux-kernel@vger.kernel.org,
        Josh Don <joshdon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains a fix for CFS bandwidth and a related cleanup
patch.

Josh Don (2):
  sched: eliminate bandwidth race between throttling and distribution
  sched: remove distribute_running from CFS bandwidth

 kernel/sched/fair.c  | 91 +++++++++++++++++++++++---------------------
 kernel/sched/sched.h |  1 -
 2 files changed, 47 insertions(+), 45 deletions(-)

-- 
2.26.0.110.g2183baf09c-goog

