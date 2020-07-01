Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65528C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 22:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D0AD20853
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 22:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GIwxPYMx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgGAWO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 18:14:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54122 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726960AbgGAWOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 18:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593641692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=glPotn+K1T613CjdKByq3iS5Ne25OlUyrCXDnz2IEJI=;
        b=GIwxPYMxTKcoydC9vFpVsjxxv0acSNTJSi55AWiU+JwiCfEvWkpHfS86QIkLPkl4OJ9+H0
        3lkeF4f4dlIG/lqA8GK6Lz/z7P5Gw9kOeBngP7IkqYkzrNJD/3m8xJcUd8tZ73v/gG24uK
        LNI+/OUZLlmCMZlxNBVwbnwpqSSTHwY=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-uMcLmj7VOYGCQtSY3FOmKQ-1; Wed, 01 Jul 2020 18:14:43 -0400
X-MC-Unique: uMcLmj7VOYGCQtSY3FOmKQ-1
Received: by mail-pl1-f200.google.com with SMTP id y9so5167088plr.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 15:14:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=glPotn+K1T613CjdKByq3iS5Ne25OlUyrCXDnz2IEJI=;
        b=hZbfbPOgfhROjXdv8T4wMhSeGbIMRPCBL5KM9Q4M+W0ihqXXExwPphIyeg7S6EbzSb
         hb8c4oyWtli17OVocQRBEtLgqKgRVP6/CWlcw8qxplqNEg94QQBE2mbBoGIPoumvTJkJ
         ajVrXZphtNjZPrYYxY+WhTRA3BXSDcptVByzAA9JoEmigOBRoMVt4i4Z52KG02qJp4Cs
         EQWAF60dE89WQTH+muiZX5d3XsOnbfdTRtC1wCydvq1XLsi/zSQuY2lVdFg0MBJDu/Ws
         onXdS7+wBY1G72K32UwkkA57bOT+eZgUZJeIHSYoddoJp+A930P+T/34EJQ/1EdxCaFm
         ECpA==
X-Gm-Message-State: AOAM5300GzaJouzyplqq4PTFb6xFEjopfVR7o4tsPtJLH2uiYMXaHC9F
        yvxtUu0l7I4lVkTkrVN5jRfn8a4A06CMJ3SrtAgaMTGCB/rdVRx93qcOOieeNEOQTwiANqn6JsG
        CiPxhpoTfvqWSaxOrfi4S4w3d
X-Received: by 2002:a17:90a:c295:: with SMTP id f21mr17700625pjt.208.1593641681957;
        Wed, 01 Jul 2020 15:14:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPvPqACXXwd/bD0e/FXP/qE7VfvMYJ9AYKG238E3SOIkFKDcqV3tvp0NbqgZNbAots/y7ygA==
X-Received: by 2002:a17:90a:c295:: with SMTP id f21mr17700609pjt.208.1593641681705;
        Wed, 01 Jul 2020 15:14:41 -0700 (PDT)
Received: from localhost ([110.227.183.4])
        by smtp.gmail.com with ESMTPSA id i196sm6902130pgc.55.2020.07.01.15.14.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2020 15:14:41 -0700 (PDT)
From:   Bhupesh Sharma <bhsharma@redhat.com>
To:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org
Cc:     bhsharma@redhat.com, bhupesh.linux@gmail.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: [PATCH 0/2] arm64/kdump: Fix OOPS and OOM issues in kdump kernel
Date:   Thu,  2 Jul 2020 03:44:18 +0530
Message-Id: <1593641660-13254-1-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prabhakar recently reported a kdump kernel boot failure on ThunderX2
arm64 plaforms (which I was able to reproduce on ampere arm64 machines
as well), (see [1]), which is seen when a corner case is hit on some
arm64 boards when kdump kernel runs with "cgroup_disable=memory" passed
to the kdump kernel (via bootargs) and the crashkernel was originally
allocated from either a ZONE_DMA32 memory or mixture of memory chunks
belonging to both ZONE_DMA and ZONE_DMA32 regions.

While [PATCH 1/2] fixes the OOPS inside mem_cgroup_get_nr_swap_pages()
function, [PATCH 2/2] fixes the OOM seen inside the kdump kernel by
allocating the crashkernel inside ZONE_DMA region only.

[1]. https://marc.info/?l=kexec&m=158954035710703&w=4

Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org
Reported-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>

Bhupesh Sharma (2):
  mm/memcontrol: Fix OOPS inside mem_cgroup_get_nr_swap_pages()
  arm64: Allocate crashkernel always in ZONE_DMA

 arch/arm64/mm/init.c | 16 ++++++++++++++--
 mm/memcontrol.c      |  9 ++++++++-
 2 files changed, 22 insertions(+), 3 deletions(-)

-- 
2.7.4

