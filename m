Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3689C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2F582071B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="k+rsyxml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgCLRcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:32:48 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:39285 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCLRcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 13:32:48 -0400
Received: by mail-wr1-f43.google.com with SMTP id r15so8571894wrx.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 10:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=EMQBFUEliM01ip8eYZWL54ZvB7/WFqSxm3Itb84CtRE=;
        b=k+rsyxmleUdEKNf2d3kL7o7aiIxuTWtLn6o1bdXxge9PXpxV5wPfTKxhslPzkpG0Ar
         G5gSlzvijsb4gXxQfcmGRT1CfQ9MAD/nDqTxMBpLtubU80R8hfLmLGOjuZEo1pkWHAVw
         etC0c1ppz8Vikx3F9E4p63Pul+eZweVNu48ZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=EMQBFUEliM01ip8eYZWL54ZvB7/WFqSxm3Itb84CtRE=;
        b=t/NnwVCMCCHUuoKvV+xMl0BNMXj7ZK0gJUdWr9tnRgqWRV/iNSSnzniy2FZk60iN/T
         LdhGfYM/r+5OBNkGBTvHweGoigxaFXa0ak4TibiO2gla0K8WUknfYSUxCImgQvRNMucj
         4+iGb2b5I/ycKwYF2K0NNt7k4MzDb7evzeP4HeuuIm9QbgIPzibXOzkDqfMdJnVA/yOn
         JOdv8TgjKiz0ymVd541iohHHfk4mx707sY8KZ+UFw4tlZSlryEeRgR7OGVrT3UKS4jQO
         VItgLnwzZZNMKQGkMrlxPex/MtklKrpj8AZ1H2M+qVVeDPbvkB7uWOhwUMWFWusz8OyY
         iy4Q==
X-Gm-Message-State: ANhLgQ3h6TodWZrFzKw6sX85At8bIdT3jTSdb0eiMzyH8eD1/vQAWWsk
        UT4I79seqpnOO/dubwtv8bWVng==
X-Google-Smtp-Source: ADFU+vt8M+ruZvYsAkNQLctYbvXMo4M+2Rv3wILfwgIvL/SQim+R4gGlI7lWWyLUelfDqApMTDzS9w==
X-Received: by 2002:adf:bb81:: with SMTP id q1mr11942344wrg.110.1584034366244;
        Thu, 12 Mar 2020 10:32:46 -0700 (PDT)
Received: from localhost ([89.32.122.5])
        by smtp.gmail.com with ESMTPSA id o9sm78936300wrw.20.2020.03.12.10.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 10:32:45 -0700 (PDT)
Date:   Thu, 12 Mar 2020 17:32:45 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 0/6] mm, memcg: cgroup v2 tunable load/store tearing fixes
Message-ID: <cover.1584034301.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Down (6):
  mm, memcg: Prevent memory.high load/store tearing
  mm, memcg: Prevent memory.max load tearing
  mm, memcg: Prevent memory.low load/store tearing
  mm, memcg: Prevent memory.min load/store tearing
  mm, memcg: Prevent memory.swap.max load tearing
  mm, memcg: Prevent mem_cgroup_protected store tearing

 mm/memcontrol.c   | 42 ++++++++++++++++++++++--------------------
 mm/page_counter.c | 17 +++++++++++------
 2 files changed, 33 insertions(+), 26 deletions(-)

-- 
2.25.1

