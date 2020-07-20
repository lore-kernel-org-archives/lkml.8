Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15F5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D28821775
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="JYUDdhKT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgGTIna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgGTIn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 04:43:28 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEBFC0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 01:43:27 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id f5so19312978ljj.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 01:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2//ZirLZY8WUjufK4xWqlnUTAHx3aYPuLBIOLa7IvsM=;
        b=JYUDdhKTdn0PXDzqfyY8YfJq/9wrEPXYDXNQ2OX7FljO4qpB54LSndW8nr+4SmlARw
         Yrl4dxRuSDxwdROtDrErQYiHhp19afoSagdTmg9S9EB01SYQx4fTLdf1dCYISs6g9ABP
         G1iJjIeT6Jq5AC4VOx419ci7L8AbFkd9QApQXTxRpe6tT9pbYO4MrHLHQEDX0Z6JhIeo
         DVkQLUlsneyc4mXfuoSRjd/TH/DTejiSpwhW/jGTG3WbxPvsQhEZKvtTtFjlMmqDpvia
         eWYVCqFdw3wUSa/KPPh7OuIUyGB+vE3j0THkliuI4PrH/Vu88/QD5Nr+/jHDg+1sCtQJ
         Irsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2//ZirLZY8WUjufK4xWqlnUTAHx3aYPuLBIOLa7IvsM=;
        b=nG3dacrocdSvjH94PxN/9Rro/ZCT0SXCHpBfL53FdPiH8gcfe3esj4TopT0Zq8p1KI
         /nv7+w9Jive75Rr2QHVNbLfgVveuaHENqyEy+mj4pcfTpFvTn194oincTlOCZvASn65Q
         EugRknhHW7Q6rpx8LNeEbkEIcE8oVg9gzeEysQ1M8gn6nC44UsD04d4LI+qaSpu84+yW
         UD2kFYQIT8a36Yc2FU0hJNmnzYbaROaR8KcgATRqMqI0GI2Mmu8UrvNMLgPiKcscmXuL
         oCG8E2RRVcZ2rfPwF05EPkvcFmJfti2471gZpliYDnv3ys7AHPCEghpWn7XFG9i2Ykyq
         XSsw==
X-Gm-Message-State: AOAM533aPtM+Zc6EK5N24GrjSVKZ2QvKBTOiwL3ME/Ec+B688SQRPAK9
        FBGIZxXVDvLx2FLbAenriYbpag==
X-Google-Smtp-Source: ABdhPJxEltVRnm2F4nZSPvwufUlESbLuDbL1bMVF4USlraQQiH6d0uMEGZs7qrpgEvzcTqOi05ItIQ==
X-Received: by 2002:a2e:b88e:: with SMTP id r14mr9467437ljp.197.1595234606306;
        Mon, 20 Jul 2020 01:43:26 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id m14sm4291096lfp.18.2020.07.20.01.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 01:43:25 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id E0B4E102393; Mon, 20 Jul 2020 11:43:25 +0300 (+03)
Date:   Mon, 20 Jul 2020 11:43:25 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
Subject: Re: [PATCH v16 07/22] mm/thp: remove code path which never got into
Message-ID: <20200720084325.fb6apppq5kvnw5eo@box>
References: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com>
 <1594429136-20002-8-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594429136-20002-8-git-send-email-alex.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 11, 2020 at 08:58:41AM +0800, Alex Shi wrote:
> split_huge_page() will never call on a page which isn't on lru list, so
> this code never got a chance to run, and should not be run, to add tail
> pages on a lru list which head page isn't there.
> 
> Although the bug was never triggered, it'better be removed for code
> correctness.
> 
> BTW, it looks better to have BUG() or soem warning set in the wrong

s/soem/some/

> path, but the path will be changed in incomming new page isolation
> func. So just save it here.

Yeah, WARN() would be great. Otherwise I'm okay with the patch

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
