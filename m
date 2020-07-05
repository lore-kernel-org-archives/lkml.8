Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36495C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 13:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D45FD20739
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 13:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mN+s6EMe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgGENFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 09:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgGENFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 09:05:52 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D3AC061794
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 06:05:52 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id j19so10301546pgm.11
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 06:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=hUG7wwDDkhtMducaWVZ0O0Oom1LcQiUMTGXQXJrxsz4=;
        b=mN+s6EMeW/Us0EwzKFvefY+QMVbP3m5P9hkpsM6Uj5kjai7ofDa/SuVK3T64HWpFYC
         /eF/N+M8vybQ7Tuiasu4dHF/MtgfPoXEqE4hAu1rEI0MpGlzO6hSQd85LOdR650SoQxn
         CoVdZwxse3ed3FiA/pNDMvo0G0CVCXFRP52j3h0ge3rbI6Kg+nqLuzxicaLf/XAAxkdM
         hm7n8GSrHD0vPG7Uz8LIVVZnqB7Qj1BLqNMSLlJRxzrSviMvnLL2AY8ATheVpJDtlhvD
         7b1CvzRfsKzv18RmFBRrY865Kk3DLnasJ8V/oJ1/6ogPiK3AnVbRmftPuRLcbxawUKRe
         Ggig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=hUG7wwDDkhtMducaWVZ0O0Oom1LcQiUMTGXQXJrxsz4=;
        b=gmTM42Ii3HH1086VEoj67/55jjDJ+Hx0wClyRGX7mRkpXUIUBK549PdeFUkPG1StGF
         S0niYLNhLYRl6qJ98mPgqCK+fLQlBGZ3ymhkvyvUiJJTf1tOLhlR1kp/yqmC3CDRbPZA
         PVwKzT4ahWLd3la9PuWtGjIG3wS7rp10MbAq7haLIL1tdtqVtdDjsjAXK7WgeHmyT6UE
         gXnhypC932rzMKPt7NtSh3KW6yyriqiFD4I1/CcUsNBJTtBH0cP8scLEUkNJJSbvkEFs
         JLk7S+0Qbu+oAuTZpOqoUJAPOThyDKde1IKaesxrYOWGDrIIE6pFT/Dj/evXKMOUaFt4
         ERaA==
X-Gm-Message-State: AOAM533fTDAHcKjivk7oZA7nlFdHZ+hAIlnMI644On64Ig+Tm+JQxHHo
        gyEdZIyjIrJYm7ZqTgUDTzmKGgAGlGz21g==
X-Google-Smtp-Source: ABdhPJy3PO49E0KDQtPtq5ASvGq8Y4zwJ94qgE77HcE0epmBG2nam8BwHd2KKLxXQEQZokSLRtDm7A==
X-Received: by 2002:a63:441c:: with SMTP id r28mr34871342pga.372.1593954351017;
        Sun, 05 Jul 2020 06:05:51 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id g8sm16342989pgr.70.2020.07.05.06.05.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2020 06:05:50 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] io_uring fix for 5.8-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <39012c6d-b53c-703f-218d-9d8fddd9871f@kernel.dk>
Date:   Sun, 5 Jul 2020 07:05:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Andres reported a regression with the fix that was merged earlier this
week, where his setup of using signals to interrupt io_uring CQ waits no
longer worked correctly. Fix this, and also limit our use of TWA_SIGNAL
to the case where we need it, and continue using TWA_RESUME for
task_work as before.

Since the original is marked for 5.7 stable, let's flush this one out
before -rc4 is tagged.

Please pull!


The following changes since commit ce593a6c480a22acba08795be313c0c6d49dd35d:

  io_uring: use signal based task_work running (2020-06-30 12:39:05 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/io_uring-5.8-2020-07-05

for you to fetch changes up to b7db41c9e03b5189bc94993bd50e4506ac9e34c1:

  io_uring: fix regression with always ignoring signals in io_cqring_wait() (2020-07-04 13:44:45 -0600)

----------------------------------------------------------------
io_uring-5.8-2020-07-05

----------------------------------------------------------------
Jens Axboe (1):
      io_uring: fix regression with always ignoring signals in io_cqring_wait()

 fs/io_uring.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

-- 
Jens Axboe

