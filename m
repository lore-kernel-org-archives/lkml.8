Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253ABC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECF02214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="fv22xKHy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgD1S0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728791AbgD1S0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:26:40 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0A8C03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 11:26:40 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u16so3977509wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 11:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=UefID2OlDLM7XATtSz3mUqUNERRjSOJzh4SyUlDrdHk=;
        b=fv22xKHyOHTuLkg2qiGirsFBU8GgmId83+5knRJI3ydB77UUfZnOQLl2IPJwBd8Cn0
         XAFIqD+eY3wN8GeHQaKHks5K+pqC/P5KTWCZ8yKyOkcZ0KE8nLyWPaTNSXSx/A5phVBN
         4nvE4lcoWNruCSqXzVJoTXE3Sb9SMDUe6yi7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=UefID2OlDLM7XATtSz3mUqUNERRjSOJzh4SyUlDrdHk=;
        b=Pq1M2HOCUMpCV4GFTClhsj3oYpMUzpEeVtSavaWq/vX7OldqTIiVfjXcA9EVNCPf9c
         foXrM0h5sAXpFmbh69bmPD/vZQy77ZJCY6z5QmMBtrAJzrTfjvA+ug6W8U7/ZaldIUqe
         GssyCJKzELTknFFVU+DCsNTuyuSrvTiKzM5wUEMQB1fRZvODMTQH2+WvQp4Pj32QIzyC
         AYI0rkVled6SjF0pdMErz2MWP/dYZoqTIWxpjLV0o6EmmvToIsisqnP+cDGGSUv78bp/
         LgIPtOHgnKDECFTaY+85GPPD/ofpEXP5OuuUAqg2oHndb0TY2xo/Q7+FBLI4X+dxoF2q
         savw==
X-Gm-Message-State: AGi0PuYyywvYZnV35xWtjzJUld0qFWYpE7NSesBD3thKlFNy7vPbxisa
        zIq7gEW3kNgFOJQrFTqyOHUGZQ==
X-Google-Smtp-Source: APiQypLHoWk0qTwfpysUzM0q8vA2b+q+WLZCal3lFGsR0gVIyDEiREhK+8Cbm3Rdke/9HeCCnL2MFw==
X-Received: by 2002:a1c:7415:: with SMTP id p21mr5807501wmc.93.1588098398739;
        Tue, 28 Apr 2020 11:26:38 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:56e1:adff:fe3f:49ed])
        by smtp.gmail.com with ESMTPSA id q187sm4316031wma.41.2020.04.28.11.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 11:26:37 -0700 (PDT)
Date:   Tue, 28 Apr 2020 19:26:37 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] mm: memcontrol: memory.{low,min} reclaim fix & cleanup
Message-ID: <cover.1588092152.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains a fix for a edge case in my earlier protection
calculation patches, and a patch to make the area overall a little more
robust to hopefully help avoid this in future.

Chris Down (1):
  mm, memcg: Decouple e{low,min} state mutations from protection checks

Yafang Shao (1):
  mm: memcontrol: memory.low reclaim fix & cleanup

 include/linux/memcontrol.h | 48 +++++++++++++++++++++++++++++---------
 mm/memcontrol.c            | 43 ++++++++++++++++------------------
 mm/vmscan.c                | 17 ++++----------
 3 files changed, 61 insertions(+), 47 deletions(-)

--
2.26.2

