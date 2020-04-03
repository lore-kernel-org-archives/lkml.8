Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0009AC2BA16
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C831E20721
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="UnCvRIn9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390950AbgDCOJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 10:09:56 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38918 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbgDCOJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 10:09:56 -0400
Received: by mail-qk1-f195.google.com with SMTP id b62so8042647qkf.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 07:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id;
        bh=SQFQSzXMplKQfDnkVvKdkAy3GUv+MO9Dq03vdb78I0Y=;
        b=UnCvRIn9WAjq3I3yJcm3WWQme/hytmQnl/QcC66UpIgGZyWToaEBW1bbeAfUUOHwb2
         VC+EOHEH7ox0ZRC7lFtm6usCpOqUpEhjU/r/zy7lt6khuFIj26Kf13t/iDrU1t8G46qy
         iJjLR7uWOPeREgFOcch4GAw7xGCega8ce9lIOhYiCfVHIr32VE9MGwye5Jdk6bd9St4t
         7mzdp/Z57Phoa0sCPbVXFKBDH4zzEBfY5/QN4WAF5FgM+U49jCyIoT3qOoPSAgMoDYY+
         j5XJGh4lSXa0nvw1UupK5xmWGbCJ1F/3dtDeuceOhgUiyY2kwqCzABUO8Sh4QIDc/QTM
         RRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=SQFQSzXMplKQfDnkVvKdkAy3GUv+MO9Dq03vdb78I0Y=;
        b=MWHHKNX3wUIFSTCHQHMaJ7DF88gKif5BrNp9v3jse56b96QpPETxkFZYNuRRes6WVl
         MDFrez6GjMi16FcHthsPIRqNbSSpl3MqFTYhhhUvTZwZ4IzmYJrLGjmfck3qkKAdUyn8
         Mgbi37J2RbmSvnVwtU8MVnqqZu8nEHBbJKOZLs9dd+65PTjeYm8y4AbBhPVFPKt0jGbX
         FfUoVboy5gWNHMqWBXFUR/2goWvhO3c5U/C1bkRB/3uQ9nYzvnlW8jzZX9H1aTbBCFe2
         /jfA8iWHLBRU4TH93QX8T+qBhW9B5H27LOLdk97hmCeYpw+fsltTQyOidOzx8snYZx7e
         DjvA==
X-Gm-Message-State: AGi0PuYwGySm2M39tqJGQace0+eM99JEgKns6ZEkNebPf+BCpdFiQNrX
        HF9L1DWwsNlbQz8Ivm03+VLFc7CtlKw=
X-Google-Smtp-Source: APiQypKE+DZFl4g/RDVQzGIVeyQeA2sSL7w3cmpG0YRvOARpOy+W/uFLuY1LWh5Wl4Lt6Sn69OkazA==
X-Received: by 2002:a37:9bc6:: with SMTP id d189mr8984248qke.174.1585922994755;
        Fri, 03 Apr 2020 07:09:54 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id s56sm6917392qtk.9.2020.04.03.07.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 07:09:54 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mhocko@suse.com, linux-mm@kvack.org, dan.j.williams@intel.com,
        shile.zhang@linux.alibaba.com, daniel.m.jordan@oracle.com,
        pasha.tatashin@soleen.com, ktkhai@virtuozzo.com, david@redhat.com,
        jmorris@namei.org, sashal@kernel.org, vbabka@suse.cz
Subject: [PATCH v4 0/3] initialize deferred pages with interrupts enabled
Date:   Fri,  3 Apr 2020 10:09:49 -0400
Message-Id: <20200403140952.17177-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep interrupts enabled during deferred page initialization in order to
make code more modular and allow jiffies to update.

Original approach, and discussion can be found here:
https://lore.kernel.org/linux-mm/20200311123848.118638-1-shile.zhang@linux.alibaba.com

Changelog
v4:
- Added reviewed-by Daniel Joardan, and also fixed a stupid mistake: sched_clock()
instead of cond_resched().

v3:
- Splitted cond_resched() change into a separate patch as suggested by
  David Hildenbrand

v2:
- Addressed comments Daniel Jordan. Replaced touch_nmi_watchdog() to cond_resched().
  Added reviewed-by's and acked-by's.

v1:
https://lore.kernel.org/linux-mm/20200401193238.22544-1-pasha.tatashin@soleen.com

Daniel Jordan (1):
  mm: call touch_nmi_watchdog() on max order boundaries in deferred init

Pavel Tatashin (2):
  mm: initialize deferred pages with interrupts enabled
  mm: call cond_resched() from deferred_init_memmap()

 include/linux/mmzone.h |  2 ++
 mm/page_alloc.c        | 27 +++++++++++----------------
 2 files changed, 13 insertions(+), 16 deletions(-)

-- 
2.17.1

