Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CDCC55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 18:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04E7A20704
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 18:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="MUKlal7f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbgDXSDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 14:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728300AbgDXSDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 14:03:31 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07CEC09B049
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 11:03:30 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id o127so11331407iof.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 11:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=l9DZkzCjHWvWpAFUFEboMfl5JVZotMAsYoNk7iZWJS0=;
        b=MUKlal7f0QTMDIbBD8mwNCPDsD4bz887lRmnK33mEet2P64rMi8Vdt/2i9wnUocIyI
         XuuV8O8JLZM4TxpdTeaM6BzaVw2V3bIbeNprvtXp0QsdlQe9z+PyTQbZ6394kJ2tlf0r
         wMNlD88pAn1GCrzaHbDY9MiyovI+WDXb70koPCM/7N3yIwXC24BfdxKgcj5gNZaRE4xD
         9mDNc8xTTvOj7wQ27RdvrSPMxgT+dlxPvVhIJ6oB/EAp8mIBn/y1V4k5sHBFBj4taT21
         jlirb9cG3XjaNWCBY6u/xNiEvOAPibinQFajatGA4cpvFm/xQlRMmuuSF6p81PgiiAzB
         vIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=l9DZkzCjHWvWpAFUFEboMfl5JVZotMAsYoNk7iZWJS0=;
        b=VohpdsUBBQLEri0b6k/FNBUtcYu4dKl82V3+gjNKQvyZZXL4teI1l4A1y8hiOkjjnD
         K7ts1wHVi4l40vUbZI5ElPirjyIQe4GvTvPo+PHQt/7bDjCYNDRyYlNZbMNHknqSTnn2
         GedSqAoQVTTiVs3NA1McOJZot85JFSlGmnROE4s32LOls2rlTaYOVZb09nuYUZ0MFxxJ
         x3pKI2rLGTxBt861HF37e7VUydcH65sqFOxHLialyAuTzH0AiqUmySv60OBlCHWed3N2
         4w8ra78cOjUkjsQLLvdV5g+sD7MgQsPgVOw2RNerYlET0lYoQkE2BZQIUfDQr2aPqMFw
         epRQ==
X-Gm-Message-State: AGi0PuZ9Kl1qkNicZ2s7lXS/E/NxUffVDIY0LWSOAe+Ewd7lCgqwabMx
        PtYxN8CmZXjMJsF0j3TDx1CaDK/FUrDYRA==
X-Google-Smtp-Source: APiQypLiBb6pQAayp6kyLN7BnySABnVTZSw+CHHuZ4vQXAsd/3B4Bc5CFHJtmvahPb0r6NhZxQdEiQ==
X-Received: by 2002:a02:a90e:: with SMTP id n14mr9230294jam.97.1587751409829;
        Fri, 24 Apr 2020 11:03:29 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id g90sm2329941ila.19.2020.04.24.11.03.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 11:03:29 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] io_uring fix for 5.7-rc3
Message-ID: <156f8353-5841-39ad-3bc2-af9cadac3c71@kernel.dk>
Date:   Fri, 24 Apr 2020 12:03:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Single fixup for a change that went into -rc2, please pull.


  git://git.kernel.dk/linux-block.git tags/io_uring-5.7-2020-04-24


----------------------------------------------------------------
Xiaoguang Wang (1):
      io_uring: only restore req->work for req that needs do completion

 fs/io_uring.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
Jens Axboe

