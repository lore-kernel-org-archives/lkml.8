Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1E2C43461
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 15:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D56220714
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 15:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="MNPhg1hC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbgIFPSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 11:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728807AbgIFPSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 11:18:07 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE21BC061573
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 08:18:01 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k13so1361079plk.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 08:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=hDobB/Q998Cw1MxuhqmCwFkS+hu5pJEO8IyhAgTvAlI=;
        b=MNPhg1hCRwPztEXPVJ32uYRRGztBrrTCDbATaRVhxydtdwqZy4uzaDTE38UHruh0dG
         qyLyBtj/9Na4S7cEgXOD3bRsRp/6EBuKxCbnnkAguA+aFhmLH4v7beKgReHfaPdG6ov2
         WZJ5+pyeqoN8jyNIqdQlBQJ8HYDfez71tL7G7V77JbV/eY0AxNTq5TINDbe8lDZmeq9g
         lGEhT9hugBLkqtnmqC6daUpQJx4VFWl0kHGj6G4cppfiRAoMp6Ss/RAe93+mcIGSivgP
         jK3spPraZ5GGWCHRQNmb4nGU+Ih8HNpnCOJMlYJ46L1pR7GEuB5tpNjmsNkrDhLhmSa2
         RpIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=hDobB/Q998Cw1MxuhqmCwFkS+hu5pJEO8IyhAgTvAlI=;
        b=WSyPrMfoo2xggtQb3Bi6CJ6n3ErmsMZAfxt/9dyVD9OG2ygP9Iuyxal7eeDpB4qhYn
         s0uKvRiShJqzraN2ST/nZveMBVwWYYSTpoV5Kd2jMeJrY2XTMIYdmEckIPUYX195lcV+
         o6JPtZWw1ujoA7ercp3d3EwAWyfBXpGpovdNc4NjGEIexon9FM4hk4Lc93iuIX0qRdVE
         EMQlbfry9uKBorpT21391TENN16L2atKJ+x59WW9t880Um3mO9EZtHMMQtJjxmKcFUmo
         GcsBAPmZpZ74d0FMbOdD5Gw8v2xglVqVT6Cndbdcpnew61zeHVqW3hTYITB0ygYtOx04
         1deQ==
X-Gm-Message-State: AOAM5332s1WAr8N5Eoeh2HKR3JJdhOQbIe3NZZsGEYVAMa665uX/ZrnR
        2SuOCEJEOas51pObeDAyIZ2KIUEtN068sbsN
X-Google-Smtp-Source: ABdhPJyQWPg6MrNBPk6LMvvoHz42slrbr34uOXga7IRxI8pKij7PWHF71JjVDX3WZYeOs58bJ7JBRA==
X-Received: by 2002:a17:902:a5c3:: with SMTP id t3mr14183466plq.134.1599405480543;
        Sun, 06 Sep 2020 08:18:00 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id d77sm12408690pfd.121.2020.09.06.08.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2020 08:17:59 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Followup io_uring fixes for 5.9-rc4
Message-ID: <7b093a7c-4230-c7b7-8f39-15bb4f18d5a7@kernel.dk>
Date:   Sun, 6 Sep 2020 09:17:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Two followup fixes from the pull request on Friday that were done and
tested since. I deliberated on just waiting with these until the pull
request next week, but I think we should just get them in now. One is
fixing a regression from this merge window, the other are a followup
cancelation fix. Both have gone through full testing, and both spawned a
few new regression test additions to liburing.

- Don't play games with const, properly store the output iovec and
  assign it as needed.

- Deferred request cancelation fix (Pavel)

Please pull!


The following changes since commit 355afaeb578abac907217c256a844cfafb0337b2:

  io_uring: no read/write-retry on -EAGAIN error and O_NONBLOCK marked file (2020-09-02 10:20:41 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/io_uring-5.9-2020-09-06

for you to fetch changes up to c127a2a1b7baa5eb40a7e2de4b7f0c51ccbbb2ef:

  io_uring: fix linked deferred ->files cancellation (2020-09-05 16:02:42 -0600)

----------------------------------------------------------------
io_uring-5.9-2020-09-06

----------------------------------------------------------------
Jens Axboe (1):
      io_uring: fix explicit async read/write mapping for large segments

Pavel Begunkov (2):
      io_uring: fix cancel of deferred reqs with ->files
      io_uring: fix linked deferred ->files cancellation

 fs/io_uring.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 52 insertions(+), 3 deletions(-)

-- 
Jens Axboe

