Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D327C2BA15
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF3020721
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585929309;
	bh=oVWrsYkWGxWbx8MnpkDESimiY8pPeZZPuXc2RWEmaxE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=aJ/33mYKahfzWn/QFT0kXjtQ1ZqTmicb+Pj0Lk8PP0BKNVWvnQWM4sHzodayHfPcc
	 /L+mPLbpUh8HcefvO5YcSy837TDxWLw87uh6DfyL65LBFa35To8fh9yJWHY0fgBI0G
	 zgiWQ3+RChu2tpMcxGz8nEVt5zcSDFccB8130A/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391025AbgDCPzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 11:55:08 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:36858 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbgDCPzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 11:55:07 -0400
Received: by mail-qv1-f66.google.com with SMTP id z13so3824435qvw.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 08:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=E78AxwdqXV10kfdNdTIIpmWpEn07ja6yRLEmZEWYatc=;
        b=gjFamP/ljB4OFshWeWOiACpJmAk1OnADrIrn7FQ+qZQVld3SlUmSqMM9pDJApWJwoD
         d+17HTzT7SZhpGeUthukqy1VGXx3y5wJgJwWBGdwUfpRiM9RiqmZhpzK98HmXniTY2ac
         HxOLO28kY1vykZgY3WyvGIhWLm9AYVXdFNWoYz+FrX85/drxuD8/Wj1fYomtP7wYnQ66
         34SY7ucjAdit9y90VKoyMFkaHg6kYD7YZWluijhPchUZHSy1Z6wGlcrIGEbYCWnhHx2L
         QBT4dBWbL4n+3lbjf5uPFlK2MnJSVZ855BmUbJmhsGMC+l0IvH/W2Va7iGMK5Ia/Re/N
         ZLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=E78AxwdqXV10kfdNdTIIpmWpEn07ja6yRLEmZEWYatc=;
        b=UsM40qMggInG3Sa6VuejrqYfIXOfdDzQ1NT2yflhlKVt1qq+rWZ6acWLugpQA7EhdE
         kl4nQqXCOXHg7khor23PWs/+Mo60KC+CyfZQ4m6wuL90hmsTMzo6GG0mYaKfOZiWirRL
         eDsFxUCtWKArcpBR1TIkSycVR6CWbcav9rqYGmUaOSZ7ZsXf3bcTOCmO/wnN/hzOd1S0
         YhBxVL2AytdvEkNrdk9d7aA6+hNMf98HQ9nQhRYSZA+sang+PAcx63np0NYzeucXZSUQ
         1ZpNsIXT/FVYpkYyRI7s584+402pJW9drEg9qVgACHaakD6NZHvEHcf9ao+FdohUzrDm
         /uag==
X-Gm-Message-State: AGi0PuZE3LyEoJYFb6TAOfd30t6ynoFVBhJUkTNw9y3TnBSWuMfgkheA
        VC6GdyUw3QNKGY3kLUnkbDE=
X-Google-Smtp-Source: APiQypIYib23ILBkfS1aQ/+O6eH8cZyVDfc1FjSHb+9aetZwB14PH0s0boPUk+CF3x4R1qPuyt46Jg==
X-Received: by 2002:a0c:9ae6:: with SMTP id k38mr9118859qvf.17.1585929305694;
        Fri, 03 Apr 2020 08:55:05 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::842b])
        by smtp.gmail.com with ESMTPSA id y13sm6755364qtk.6.2020.04.03.08.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 08:55:05 -0700 (PDT)
Date:   Fri, 3 Apr 2020 11:55:04 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [GIT PULL] workqueue changes for v5.7-rc1
Message-ID: <20200403155504.GG162390@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus.

Nothing too interesting. Just two trivial patches.

Thanks.

The following changes since commit 8b614cb8f1dcac8ca77cf4dd85f46ef3055f8238:

  Merge tag '5.6-rc4-smb3-fixes' of git://git.samba.org/sfrench/cifs-2.6 (2020-03-03 17:31:19 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.7

for you to fetch changes up to 00d5d15b0641f4ae463253eba06c836d56c2ce42:

  workqueue: Mark up unlocked access to wq->first_flusher (2020-03-12 14:26:50 -0400)

----------------------------------------------------------------
Chris Wilson (1):
      workqueue: Mark up unlocked access to wq->first_flusher

Yu Chen (1):
      workqueue: Make workqueue_init*() return void

 include/linux/workqueue.h |  4 ++--
 kernel/workqueue.c        | 12 ++++--------
 2 files changed, 6 insertions(+), 10 deletions(-)

-- 
tejun
