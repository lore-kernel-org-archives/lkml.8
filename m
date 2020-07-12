Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD92C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 16:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 933EB2063A
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 16:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="uF/QHLQp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgGLQao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 12:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728854AbgGLQan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 12:30:43 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3593DC061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 09:30:43 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id f2so4416942plr.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 09:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=fduEEX0FvmLvbjM6DjKUizgxNHtjjRTc20Yn5n2GOU4=;
        b=uF/QHLQpIEkXpsDzG6f4pmhhE6qd8Z/6Z1lxRzQNgJES9td/xuPCsUWjaFhAlRoGqv
         Kr10QnkY9xqNmEu++t1ZGnBUXDpGTw0i8nQrxwLGrm8IT/wcJXGtx3cDvFfLirVv/RRt
         /xGMIujy+bPfN2tgXps+2+sid/uBaRwmZ49ZerJSk6VNeuftQP/y/6qPQqgcz/4V4YYL
         WlwE/eiSuGFKqg6c3aEMg7l9p9Ti9D9MBTFSmuT6xlqiECAkCYWDomuUVEyPh+CSy4Jh
         VkQ44y3grWAO7hLcaMg+fxkvEO5W/aq8zyoSQIltKTNC9yCKoOGN9+t4v5dn1r/60xDl
         JTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=fduEEX0FvmLvbjM6DjKUizgxNHtjjRTc20Yn5n2GOU4=;
        b=JG6GTh4cHshkev4BiNtpVxngyFKKRC0z8zGPurG5IcI7sAgXH74BFTOBEhXzbaBTXM
         7u9eIk3pkDJq+t4iIVH/4Uf88MUlj6QDKQexGdLoSM3UYNkP9PYSuPMnWcfnmD3kqSjS
         Hq1dWcrQz4fMy2bpmR3bA6whrdsRX6MJQyZQewAXjXT9PDyN280f/eBUwodhOrrwP5mt
         C1HO913OGWymUEdR3ip0RNsOpAo2MeQXofhFpd/TtrzHtPiRb3OpGI8/cNHjzqkV726J
         z7E1c1BRxQCeToiB7F/DTb5u+pzq3HWK62iORWcLaAejgT0laRaW742BPCdD8g4dlhIf
         RloQ==
X-Gm-Message-State: AOAM5334cBh5AM9LsdpgTtqICOwV5lO7muq8qGCG/aGyDr26NkLmAB5E
        JVkjVN1Acgixj7MtaX1JyOyn56T8k2RxGA==
X-Google-Smtp-Source: ABdhPJwdHApLEQXID+EPdWAxQbWH/w7vmc3jSPVQLWW6Te77B3fnsXw+3basNFqIrvxZNLWQ0CJAMQ==
X-Received: by 2002:a17:90a:30c2:: with SMTP id h60mr15281620pjb.23.1594571442362;
        Sun, 12 Jul 2020 09:30:42 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id n2sm11176025pgv.37.2020.07.12.09.30.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2020 09:30:41 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] io_uring fixes for 5.8-rc5
Message-ID: <4583056e-bec6-f26a-5194-1add6f2b619f@kernel.dk>
Date:   Sun, 12 Jul 2020 10:30:40 -0600
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

Two late fixes again, but they should make -rc5.

- Fix missing msg_name assignment in certain cases (Pavel)

- Correct a previous fix for full coverage (Pavel)

Please pull!


The following changes since commit 309fc03a3284af62eb6082fb60327045a1dabf57:

  io_uring: account user memory freed when exit has been queued (2020-07-10 09:18:35 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/io_uring-5.8-2020-07-12

for you to fetch changes up to 16d598030a37853a7a6b4384cad19c9c0af2f021:

  io_uring: fix not initialised work->flags (2020-07-12 09:40:50 -0600)

----------------------------------------------------------------
io_uring-5.8-2020-07-12

----------------------------------------------------------------
Pavel Begunkov (2):
      io_uring: fix missing msg_name assignment
      io_uring: fix not initialised work->flags

 fs/io_uring.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
Jens Axboe

