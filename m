Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431ACC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 11:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12D8520773
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 11:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="RqGITRMK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbgGMLFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 07:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729303AbgGMLE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 07:04:59 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF76C061794
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 04:04:58 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id g20so13154215edm.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 04:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=nN3m2m7pEWJxxgE22EVhuHKcD4TrCFPuvsPIp3KGX9k=;
        b=RqGITRMKNmMiYRdu6+vlFczkTYWFJp1c6+1yOC3ohAOzxc8vpAusqQEaQ0E2axiD3D
         QON4GHysm7Te5zUXV4Lz0GiISjc4xgU5T3b391ZpRcwJGbZ1amHXgAgqFQDjhLNJfgyG
         eX0sdzLY1TPzVvZ6Y5DHPyyoWITelQBhUSBaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=nN3m2m7pEWJxxgE22EVhuHKcD4TrCFPuvsPIp3KGX9k=;
        b=ElJHNfDOokTv3+di8wba5xkBAoYohChuZ38OiaAR0dlaA+lQmNIQcM0vEzKoEYdSwm
         vEYVJZXhponDyYttaMkbNn5IZaO7R84ePSDoRPfR5QF+NkTVZ0a6AmZFA9kt2oEw+pQ3
         6/fDlkjnOcu70940mQvzMgRpo3XPnxiX8a6KJ8nabqQfdfT7iVR7oYcEEtIG7/y9tw4+
         VTBfL5znDWVuoTAK/P6VBh5/jx/8FTRDH5CZ1F76pDamcqPBpQndNlILVxswazvZM/1l
         zZdox4+Nj07AZgrfbQYOpox64ks9svM9KbfU5csGgnn00ffzxvjyQugRZBmEuGYqJoTb
         ZLFw==
X-Gm-Message-State: AOAM532PUZN1RkHvu6muTybrWp8I1hQISQ1gVrKJmb1zMcsSEr5QiM7g
        5IpCpOayfNsIF2obm54+FV23aw==
X-Google-Smtp-Source: ABdhPJxJ/mazTAbJfCnV5ZLs6gKzw7Mb01cM+wDRYPldnGl3iBlU+mkR/ggy29bNiaIxfIFLSI4DFw==
X-Received: by 2002:a50:b5e3:: with SMTP id a90mr50641671ede.381.1594638297371;
        Mon, 13 Jul 2020 04:04:57 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:ef88])
        by smtp.gmail.com with ESMTPSA id j21sm11395375edq.20.2020.07.13.04.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 04:04:56 -0700 (PDT)
Date:   Mon, 13 Jul 2020 12:04:56 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] mm, memcg: memory.{low,min} reclaim fix & cleanup
Message-ID: <cover.1594638158.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.14.5 (2020-06-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains a fix for a edge case in my earlier protection
calculation patches, and a patch to make the area overall a little more
robust to hopefully help avoid this in future.

Changes in v4:

- Fix premature OOM when checking protection on root memcg. Thanks
  Naresh and Michal for helping debug.

Chris Down (1):
  mm, memcg: Decouple e{low,min} state mutations from protection checks

Yafang Shao (1):
  mm, memcg: Avoid stale protection values when cgroup is above
    protection

 include/linux/memcontrol.h | 95 ++++++++++++++++++++++++++++++++------
 mm/memcontrol.c            | 36 ++++++---------
 mm/vmscan.c                | 20 +++-----
 3 files changed, 103 insertions(+), 48 deletions(-)

-- 
2.27.0

