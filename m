Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3186AC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 051E820639
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="N7LAbLrR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729970AbgHOWHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbgHOVuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:50:44 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05B0C0F26F0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 11:15:00 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id u20so6116186pfn.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 11:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=BIuH6kISmbFa5kGRXf8C1zMlDZ6CK7mUtowqlOF0/dI=;
        b=N7LAbLrRiARO/ku0BNslWmbNZ5KMCXLYS4qzRJQeD3ePz5Yc0oZPSKTy+Q+tKlLaSZ
         vw4sOnwZUbHIwBkpaULk8Dqk1m0Ks89+CTMi2qyHyNAhT49JzM0/RZm4qt0hZ/wedgnT
         nca35p5YbcomCaOpAzEKL0DcuitU3yNF+7APgnu2ircedVIIIkJb3bDwhLaBmRHPIcvj
         p4Gzixsux1Po9Z+nJQoK/7ZRuqxIibSsvwuMfnEeEiYNN118g0/aECXWk0JIf8Zqmitp
         R4cMpAJMWrzNAoJt+US7GHgi+0ITpXxHm49DrtT77cwixLU8EFf1Q6pad9Pfenz+XvZ1
         sOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BIuH6kISmbFa5kGRXf8C1zMlDZ6CK7mUtowqlOF0/dI=;
        b=CiKU1aQYq2gfbrQhFBjyRXncHBRMFgunrt9vfYXIYvnQvn6egxiwPyOuYr4YIZlaWe
         VzLpXdRnmnzNTF/cgjPpq8qWwwjcjT4VKnl4flAKOq9zB6WdOf7Q6DjH1KY4TsyGJXIS
         SirD0jZLgmx0FE495ZQwmP/kLnaNuZhdj5yB95xxXSAaKXsIZsiN+KYOrNZAycTbRCWY
         6sdEJROpDqe2RfpIJfxejO1WHj1qMFlcyYWYb+qjn4ttyA3YFyLvK6h+BacMLbOicPOl
         MGzyA5NV9J5TKIZKU75sgcuzONt8whYzSixD14TvEDB7u+B+3YAazApIny1RaN6RdmMb
         REAA==
X-Gm-Message-State: AOAM5300ObMSJIpfCiv7tD1XUpk7LJsX7LEiq+gfkQMUJQ9l0JC3te9V
        E6+8yPjD7N59iH5/hawGsVS2/Q==
X-Google-Smtp-Source: ABdhPJyfy8cQiabf33POMoUVdvZFoEvwy1OBJwtbtdWdmCXbYJDDDjojpV/LcyrdhWnFkCXCxmfsvQ==
X-Received: by 2002:a63:143:: with SMTP id 64mr5167393pgb.343.1597515300385;
        Sat, 15 Aug 2020 11:15:00 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:6299:2df1:e468:6351? ([2605:e000:100e:8c61:6299:2df1:e468:6351])
        by smtp.gmail.com with ESMTPSA id j94sm11734141pje.44.2020.08.15.11.14.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Aug 2020 11:14:59 -0700 (PDT)
Subject: Re: possible deadlock in io_poll_double_wake
To:     syzbot <syzbot+0d56cfeec64f045baffc@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <000000000000923cee05acee6f61@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e3494c53-f84e-5152-42b0-f8ddd3ad4ccb@kernel.dk>
Date:   Sat, 15 Aug 2020 11:14:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <000000000000923cee05acee6f61@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz dupe general protection fault in io_poll_double_wake

-- 
Jens Axboe

