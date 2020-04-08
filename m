Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AA0C2D0EC
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 01:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5DAA206F7
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 01:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vgc92owQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgDHBkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 21:40:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55126 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726484AbgDHBkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 21:40:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586310019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wl5DI6kAtUJ8k2YGULEZuXgrxTBuaptiox8B/l3QktI=;
        b=Vgc92owQgkP61Su6rb7lnRwfQwRpKp6MqFRbbvBVYPAxcMq5IAoAUwj1zXvrR11URSJxYO
        lRlcTTlcB8Hr4/EVgbuc8Vyn8DEpPcXVY98/NdBYxBDkUtnu4T1DxPSSW7ppOygCV1vfaU
        Yqkdoc0iRE+2AD+WDcTXpsxNQzj9k5A=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-rtbdM2eJOfamBZauj_cL9Q-1; Tue, 07 Apr 2020 21:40:15 -0400
X-MC-Unique: rtbdM2eJOfamBZauj_cL9Q-1
Received: by mail-qv1-f70.google.com with SMTP id z14so4839448qvk.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 18:40:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wl5DI6kAtUJ8k2YGULEZuXgrxTBuaptiox8B/l3QktI=;
        b=CM4vs8PHjt+KdlNj61iLJq/KOiC8twkJ2qPetT75/Ora8ZvMp7EElC8nsyqzfeqcJz
         c2WE1xGgWaGx4DYd7cynN5QGr8cuKf5zgZxC3BWqBNF6UtnipX1/lzGSmnH3siYXcqal
         Awp2dyFLHgaPGvdKAj+FG+Vh6v5b01S6HogQz0SsvUwDfy5cR6q9PLEY26aGn4zPBcJC
         cMdfNsK2Y7ET2ThnkTWAI0OsIyG6zs15cfbBQUJqSpJoIhjm6JhTOrBYVhurAT5Gf5ry
         Esad1EU9K3xTiGWbt9VdEcqg01MgkHNUsLaHQyf+3m/Ocmz4qVWoR94VjyedBI05dafv
         Xxwg==
X-Gm-Message-State: AGi0PuZhyokT2V/V9+C2YUSSEqSV5z7hGI5vhy8RiFkQE867/NzFvX1R
        MySWIqnRrLveB1DbXqlrdS83BsR4lCKGk8tRGTj0ykuyp4tRKx+VHglEL5An9jJpdW+4gItKVU8
        KpDbju4iumxcU0VY4WC6atQGY
X-Received: by 2002:a05:620a:7eb:: with SMTP id k11mr5218335qkk.282.1586310013173;
        Tue, 07 Apr 2020 18:40:13 -0700 (PDT)
X-Google-Smtp-Source: APiQypIck+cZdT2RczXl/himnTKPJmXhgzUtYHMHz0sOupASHZtDDvsQBExfkfjpVMjfuSSjvpLSWQ==
X-Received: by 2002:a05:620a:7eb:: with SMTP id k11mr5218325qkk.282.1586310012967;
        Tue, 07 Apr 2020 18:40:12 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::3])
        by smtp.gmail.com with ESMTPSA id g10sm18665035qkb.9.2020.04.07.18.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 18:40:12 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com
Subject: [PATCH 0/2] mm: Two small fixes for recent syzbot reports
Date:   Tue,  7 Apr 2020 21:40:08 -0400
Message-Id: <20200408014010.80428-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The two patches should fix below syzbot reports:

  BUG: unable to handle kernel paging request in kernel_get_mempolicy
  https://lore.kernel.org/lkml/0000000000002b25f105a2a3434d@google.com/

  WARNING: bad unlock balance in __get_user_pages_remote
  https://lore.kernel.org/lkml/00000000000005c65d05a2b90e70@google.com/

Note that the 1st patch also applied two extra small changes comparing
to when posted on the list in that: (1) it squashed an "interupt"
spelling error that Andrew has pointed out when picked up, and (2) it
also initializes the "page" pointer to NULL.  But I'm fairly confident
it shouldn't affect the correctness of the patch.

The 2nd patch is exactly the patch posted previously.

Thanks,

Peter Xu (2):
  mm/mempolicy: Allow lookup_node() to handle fatal signal
  mm/gup: Mark lock taken only after a successful retake

 mm/gup.c       | 2 +-
 mm/mempolicy.c | 7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.24.1

