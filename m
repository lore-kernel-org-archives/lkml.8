Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF038C33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 15:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB81F21835
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 15:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="smcmK0GK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgAVPvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 10:51:35 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:41130 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgAVPve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 10:51:34 -0500
Received: by mail-io1-f66.google.com with SMTP id m25so7080469ioo.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 07:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=TQtYIVnmBZTGSPMBAl2QZf/eZ6kMW1F4eBDZ4mB7h6c=;
        b=smcmK0GKN1dQqQgLnBLLzgFICWzT8tPktwwZZh7+jPrIdNJqJF7j4lW7zwkNQsOuhO
         clz/t+48YeHACEJutxBF2IZaExTXRfxxWfAEmw957NVm2sIM1RX+g104hmFKEldVMKJn
         i6y05FaAl2RxRpm7nZCEFJNlGONY0/oOpqDmKogbe58MH4BovaKhNAbjzI0hU3UnKWSL
         tz1dAIc97KYbJZeD9kq9lNdqCVihEk5JZ8Fm+sdhrvRegIoYQ80uGXeEhhy1jlbtNAR4
         mwjNDBMCvsy+cby0PQzMcvqSt+f7L/gKHo9HJVm1cpm061eDKC33R6qH31xEk7/wLA+H
         3ghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=TQtYIVnmBZTGSPMBAl2QZf/eZ6kMW1F4eBDZ4mB7h6c=;
        b=CXScGclwtrEoEv4TEBcGcNKjHFXzZg3F4/fYF4PwyRas/WfNXS4oY2FT84OphrV2h4
         VI5UAXmxSt2PJJTgoVqf3DneUgL30Po3ltiWKHE14oumE2C62x0ZnZ7plPFdkATzTvW5
         Ia9PMR8CO67cRBuhQe5dM0j2FFX5u/GIex0Ik8Kx8QMIJx5ZWVdC2PcZL+tjcrCDE03G
         j1VzWG34JXnWF6d88gGW/+3XDXqIAU6+A/s64YOVsuCHB07O9K1+lIdAWfP+715EwoWl
         PrLH+bYUASKARkPCm5xQ6T3iJu+sy7Hevj208CLv5coSqqipxgx4nfiaaHcKDf/vbFdC
         qhYA==
X-Gm-Message-State: APjAAAX+W4pU3FTEwZbgahXVpGqx51X5QSe6ZmC51DQsNB4nzVzL/MW1
        +z3SPo54EkgDQmGIhSvogcXo6xQs2IY=
X-Google-Smtp-Source: APXvYqxQaa00nlD2XddYDdcwY5NC5M4NAEwZjrt0P4xYff3bTELwrx4bQfpIpvbO/lqR4KvFLRrJ3Q==
X-Received: by 2002:a6b:e30e:: with SMTP id u14mr7581903ioc.242.1579708293721;
        Wed, 22 Jan 2020 07:51:33 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id y26sm812138iob.88.2020.01.22.07.51.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 07:51:33 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] io_uring fix for 5.5-final
Message-ID: <98957d45-ad2a-9505-9771-63828538f3bf@kernel.dk>
Date:   Wed, 22 Jan 2020 08:51:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This was supposed to have gone in last week, but due to a brain fart on
my part, I forgot that we made this struct addition in the 5.5 cycle. So
here it is for 5.5, to prevent having a 32 vs 64-bit compatability issue
with the files_update command. Please pull!


  git://git.kernel.dk/linux-block.git tags/io_uring-5.5-2020-01-22


----------------------------------------------------------------
Eugene Syromiatnikov (1):
      io_uring: fix compat for IORING_REGISTER_FILES_UPDATE

 fs/io_uring.c                 | 4 +++-
 include/uapi/linux/io_uring.h | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

-- 
Jens Axboe

