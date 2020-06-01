Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FEFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F542206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgFAQGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 12:06:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55315 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgFAQGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 12:06:47 -0400
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1jfmxZ-0006s6-01
        for linux-kernel@vger.kernel.org; Mon, 01 Jun 2020 16:06:45 +0000
Received: by mail-wr1-f72.google.com with SMTP id t5so167836wro.20
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 09:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bpQ13/Tb/1v9ESSJdhnUaEx5I/MEIqhF5at0rFUACNM=;
        b=i7bYUu4pdZdA18BL3W0+kRh8UhQy3lFKdi0oESXHxrfYBQeEPrB1XQ7gDYpqBDWZSS
         W6EJIbu6PPs5PF44jAm/94FsMO6m2fuubvTpn1eWL9BcTWwln7Vwf4g2f4+MY7fKMutk
         2HPtEcourqj7mZuB8qttghShGDX4dF2uEm1rssyi/ONd4rqXfy/b0fatzZYIjEEAIZlq
         vGVLkK/RwqTXf4vOwszkjO9d1/c9zPgvy6wutRQw+RhvAHehM63k3bcXMPsL4nYYKPtj
         NCerwlArbpj4fCc1hDw62Q2F21swqgq2CXbKqci+/Lf0uMB1YIZwIMmsUeoBeyWgNsAn
         /gqQ==
X-Gm-Message-State: AOAM533HjziedlMoshKuMT+VrYzv1GMCuN8gR27dAXF05/0I/TQmr7ad
        ZB9ecaSr1FQZP3bJyb+S+hmUYYQXUFSyQvVQaSo1sw8xR/PyBwDrey51DtBOs5bIPnNfRkDn/Nc
        006w/RKhWWcwQ5p+WxULpfm10BYF10iEO+4U2RQCJcg==
X-Received: by 2002:adf:dc42:: with SMTP id m2mr11722690wrj.342.1591027604648;
        Mon, 01 Jun 2020 09:06:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtIARnKWstXAKhlHKQE+KOrbq5RT+XW8IL/zXgEDl3x/r+gjZRu4PbPN3pWQtFh7apH9Bo4w==
X-Received: by 2002:adf:dc42:: with SMTP id m2mr11722665wrj.342.1591027604369;
        Mon, 01 Jun 2020 09:06:44 -0700 (PDT)
Received: from xps-13.homenet.telecomitalia.it (host105-135-dynamic.43-79-r.retail.telecomitalia.it. [79.43.135.105])
        by smtp.gmail.com with ESMTPSA id k16sm19719262wrp.66.2020.06.01.09.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 09:06:43 -0700 (PDT)
From:   Andrea Righi <andrea.righi@canonical.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Len Brown <len.brown@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-pm@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] PM: hibernate: opportunistic memory reclaim
Date:   Mon,  1 Jun 2020 18:06:34 +0200
Message-Id: <20200601160636.148346-1-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the first attempt to provide an interface that allows user-space
tasks to trigger an opportunistic memory reclaim before hibernating a
system.

Reclaiming memory in advance (e.g., when the system is idle) allows to
reduce the size of the hibernation image and significantly speed up the
time to hibernate and resume.

The typical use case of this feature is to allow high-priority cloud
instances to preempt low-priority instances (e.g., "spot" instances [1])
by hibernating them.

Opportunistic memory reclaim is very effective to quickly hibernate
instances that allocate a large chunk of memory and remain mostly idle
for the majority of the time, only using a minimum working set.

This topic has been mentioned during the OSPM 2020 conference [2].

See [RFC PATCH 2/2] for details about the proposed solution.

Feedbacks are welcome.

Thanks,
-Andrea

[1] https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-spot-instances.html
[2] https://lwn.net/Articles/821158/

----------------------------------------------------------------
Andrea Righi (2):
      mm: swap: allow partial swapoff with try_to_unuse()
      PM: hibernate: introduce opportunistic memory reclaim

 Documentation/ABI/testing/sysfs-power | 38 ++++++++++++++
 include/linux/swapfile.h              |  8 +++
 kernel/power/hibernate.c              | 94 ++++++++++++++++++++++++++++++++++-
 mm/swapfile.c                         | 45 ++++++++++++++---
 4 files changed, 176 insertions(+), 9 deletions(-)

