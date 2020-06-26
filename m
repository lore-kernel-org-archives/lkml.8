Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BC8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 19:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43F5920707
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 19:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZrEhMFIQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbgFZTmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 15:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgFZTmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 15:42:20 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D076BC03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 12:42:20 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u5so5058585pfn.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 12:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=sjZkk2ohguzX2taCj5iKPqcZeXksHN3X9kXAkAwuPs8=;
        b=ZrEhMFIQQ04PvWXlRlUmhNWePiKl2rLmLxp/ffKGPcdncklUGyAnrXT9yEYTj5nyma
         japQJ4dYbwRzpQOEaEqE26M2RNDrqROpFpMU9ZsHyrgFs7leaVqTzIQKWtgf2BG4a7IL
         7HQ085zrbJ6QABjGoLm5/wdKF8D8F9j8hKpfdE5iflRA9zCeA8mgky1GkwyeQYFiYW8h
         nXlIMYoHK0/swhF4J6cp/QHKi/3rcTsObBAZDihY+YTyXObjOcbcLIzUgGC8J5jaM0XK
         4gRI8tNDTjQvEeMZopqGjVpK7Fi0ZVaHB07Q1K0wbrIdridZMe5GHspMUqSpFW5NDz5G
         IO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=sjZkk2ohguzX2taCj5iKPqcZeXksHN3X9kXAkAwuPs8=;
        b=Vn0bqaigPaY5ZuSmCDPZKC//QQi9YysdJRmQYJxi5cjl3hhhjdQO2IUCqi4e7r5o88
         2mg7bnZ1JdXEh1LbZz//xFVz83hs8Pt+RMF004ADrR9zMoX0w+Mt4RZo5/SPYN9dJyn3
         5JJozYynA5g0MyQCWiF9UPU3g9zwTWFtN6nKrOyID8D8iSFIpKD2H2KCO1vlOJ8/ZFPF
         PKaGsbwto6gW7NooZHQGMUIomdwBYJAZ5SHFuQBDmwaWNkgu3GuxLofPhVnjL9xY2JRt
         jrlsUbhm9HXP5uWmDwUlv4iGe2bQ17T0LpHDqzAxjP+QEbusASaQGy04+vGp5IFmypMN
         eH2Q==
X-Gm-Message-State: AOAM530Pvljfq4M4rNtAKusMf1mafzCagluiru0cIg513+TWrE/cwvns
        DaKcGRLBoDmHATIDnMHdgZ1UsPmCKETzLw==
X-Google-Smtp-Source: ABdhPJzPZ9cGfujtMwVKZFWK97745rdmhxZ/GVYvUXDmfr1vEqjC7NQ9CNMTYPnBY0aZ7R8+deV72g==
X-Received: by 2002:a63:a843:: with SMTP id i3mr302296pgp.190.1593200540047;
        Fri, 26 Jun 2020 12:42:20 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h8sm22938348pgm.16.2020.06.26.12.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2020 12:42:19 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] io_uring fixes for 5.8-rc3
Message-ID: <cbae6931-9653-d051-fab5-08537e1dd1bc@kernel.dk>
Date:   Fri, 26 Jun 2020 13:42:18 -0600
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

Three small fixes for 5.8-rc3:

- Close a corner case for polled IO resubmission (Pavel)
- Toss commands when exiting (Pavel)
- Fix SQPOLL conditional reschedule on perpetually busy submit (Xuan)

Please pull!

The following changes since commit 48778464bb7d346b47157d21ffde2af6b2d39110:

  Linux 5.8-rc2 (2020-06-21 15:45:29 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/io_uring-5.8-2020-06-26

for you to fetch changes up to d60b5fbc1ce8210759b568da49d149b868e7c6d3:

  io_uring: fix current->mm NULL dereference on exit (2020-06-25 07:20:43 -0600)

----------------------------------------------------------------
io_uring-5.8-2020-06-26

----------------------------------------------------------------
Pavel Begunkov (2):
      io_uring: fix hanging iopoll in case of -EAGAIN
      io_uring: fix current->mm NULL dereference on exit

Xuan Zhuo (1):
      io_uring: fix io_sq_thread no schedule when busy

 fs/io_uring.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

-- 
Jens Axboe

