Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44CDC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 19:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B37720674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 19:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="msdHOOSt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732419AbgCPTNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 15:13:44 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:43559 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732366AbgCPTNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 15:13:43 -0400
Received: by mail-qv1-f67.google.com with SMTP id c28so9484962qvb.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 12:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hQ6KfYR9gsZkcfMfYyRVmhCMb80+DstZqdWe5a9vHYQ=;
        b=msdHOOStVPMDS4Mqi0Uw5qYY3xmOx/awlB/N7lszPYI/CkuBwbE2ctj8Cktbsgy/M/
         YhyH+WEXvueDCguQlgjMpZTsrtXUqpZzT4q9I74W0tplZSCZpgZDs5KsIkXdKGwjmhJ3
         WBjoWnH+yLuK/luBrjtZbREo1xGzazEEcK0iuQDrplBar6wkYUFAG5Ry1haIEijIC8G8
         uQGuyulp7IRd8+TMJuwRTO1exTFxEKvHkEyMq5aUs7EPp7zLQo47w7g9vtfod0B5YRBR
         X7M1JBEWs1VgBIR7abel2WyB1OUeuApmBML954516LCrA2QGW1K0r67VmqHE6dz4uglp
         lOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hQ6KfYR9gsZkcfMfYyRVmhCMb80+DstZqdWe5a9vHYQ=;
        b=iJ0WCwiFItlU+CCkkXieuPzVvb9lXuLx90QK4qWnDtKauupD9/UYKYZ6uVJWBD3MLa
         OJchlfI0FKBPGMO24CbmIJU8UEZaMUlHP3OsTELFRq1dcLLlpgq94N1YLn3XzneMstat
         PZvuvLQMeQLDizSUvxB/0gerWVHWJh9cM2yfnvEFH4BCQok0Jyh1qYOM6hrvrXb4JxCp
         7JXfbuuvEAz76e1LRP3crONu5p5VY9ibKmCDQoOYJ5zrxPnK5ULCM6tBtiiHVfwDsH9c
         Fvx8IXePfWG98of1fW/AyUWN/hU1F90iIER3h0jjYDoUENy4NUdjwz9gcoAlCXKftfwy
         1u8Q==
X-Gm-Message-State: ANhLgQ11De0/acmlNBnZhHt7IP4Fg7BxWARqWYeM4eFvJ8KGPB5NSlrP
        kjGkObc10b3joxA9B78ZNoWGmQ==
X-Google-Smtp-Source: ADFU+vsu45fsRLuBxs5DFRHzUrtDy2+HKc9VZM37d00UZjgBQcoCmiVnyeQgskRuo+XwcMhK0wwgbg==
X-Received: by 2002:a0c:edc5:: with SMTP id i5mr1350832qvr.16.1584386022960;
        Mon, 16 Mar 2020 12:13:42 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:f40d])
        by smtp.gmail.com with ESMTPSA id v187sm43025qkc.29.2020.03.16.12.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 12:13:42 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 0/3] psi: cpu.pressure cgroup fix & MAINTAINERS update
Date:   Mon, 16 Mar 2020 15:13:30 -0400
Message-Id: <20200316191333.115523-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Peter,

Patch 1 implements the cpu.pressure fix for cgroups we were looking at
recently, 2 is the cgroup hierarchy walk optimization you proposed.

Patch 3 adds a MAINTAINER entry for psi, as at least one person tried
looking for it and couldn't find it.

If they look alright to you, it'd be great to get them into 5.7.

Based on 5.6-rc6.

Thanks

 MAINTAINERS               |  6 +++
 include/linux/psi.h       |  2 +
 include/linux/psi_types.h | 10 ++++-
 kernel/sched/core.c       |  2 +
 kernel/sched/psi.c        | 99 +++++++++++++++++++++++++++++++++------------
 kernel/sched/stats.h      | 21 ++++++++++
 6 files changed, 114 insertions(+), 26 deletions(-)


