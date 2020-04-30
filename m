Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6219CC47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 19:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34E5820656
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 19:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="b4OU7wwb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgD3T3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 15:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgD3T3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 15:29:19 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F8AC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 12:29:19 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id b1so6088088qtt.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 12:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/eq6aHDyq4eplML2a4cRLGlwq126IAji+Fvgv3MjJ3w=;
        b=b4OU7wwbA3wxPurcG9pIX2GntI2Xn9noV/RldtqK/ry2Aih34RZFyG37mvEUhqPgUJ
         FZuolZ4rblAdaMTfLS/iPurKZ2F/6LgIKXT/SPaEjMRd+QYwp0iY0BM+tlLBA7fvDX0b
         PoKDmL7E0sHYEdt3HL88joyXkVl1giGBlW/wGc0A4Z+11ui4tXTZR9v+/zrk6N9GA6vQ
         haEP1z4FLxKtLHf0Jh1JXqAuHFmIlunGDsdbG4opwBuPEkRLvy8YZ6HWRP9GmVpISVqB
         FH581z7KqQk9BGUSOLm3k9zUxr+9oN1hYP+uY2Iia++2Azdeu1TiYpS2K1o6nZxcsaMj
         dT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/eq6aHDyq4eplML2a4cRLGlwq126IAji+Fvgv3MjJ3w=;
        b=B0+9ypvBAXJXAlq0FMLy5gsbskxn1+/BBgQvT/dOb1aI2jDrqln27Yc4rTccCEE6z5
         jr14O9rRnuVjJFiZy9NmhVqdAcaGYvZwt/DekCQVLKFqD0N57udHhmr3HSw+sF0Jq4n6
         1edwuy8dXl7l12adWqRb+UNc3ZSlWXEjhU9AuE1lqOLWB66g7fUvJ9xKDGT7DWvYqwkM
         1h5c+NNdkh86XS6RHuHXHNDEe865a1IMT4LenBZ9sxgy/hIkOlmsD0bjlCQy+Ywg+jDD
         s8X7rEmCsQS/8YW/YmdwfYtl4i5XVo6HTR9mY/jyRVOFthdiPR9sPojQ2mTaOdvZpeT9
         aRfQ==
X-Gm-Message-State: AGi0PuZZCeN4NV1b1pQM2mBBKsfiUsRf6/EeXoNd+spBCzK/eyq2HcHi
        vQh8UYmKtQx99fnYdM+eUHKfQQ==
X-Google-Smtp-Source: APiQypJkMljmJVrYuqw1/FA/joYSeHchiIXs0+3QO3JPks1R2xxvo8ZkpSGPuQBznRyTzHv3YCWvFw==
X-Received: by 2002:ac8:1885:: with SMTP id s5mr2430qtj.253.1588274958913;
        Thu, 30 Apr 2020 12:29:18 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:63a7])
        by smtp.gmail.com with ESMTPSA id u27sm543996qtc.73.2020.04.30.12.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 12:29:18 -0700 (PDT)
Date:   Thu, 30 Apr 2020 15:29:07 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: oom: ignore oom warnings from memory.max
Message-ID: <20200430192907.GA2436@cmpxchg.org>
References: <20200430182712.237526-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430182712.237526-1-shakeelb@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 11:27:12AM -0700, Shakeel Butt wrote:
> Lowering memory.max can trigger an oom-kill if the reclaim does not
> succeed. However if oom-killer does not find a process for killing, it
> dumps a lot of warnings.
> 
> Deleting a memcg does not reclaim memory from it and the memory can
> linger till there is a memory pressure. One normal way to proactively
> reclaim such memory is to set memory.max to 0 just before deleting the
> memcg. However if some of the memcg's memory is pinned by others, this
> operation can trigger an oom-kill without any process and thus can log a
> lot un-needed warnings. So, ignore all such warnings from memory.max.

Can't you set memory.high=0 instead? It does the reclaim portion of
memory.max, without the actual OOM killing that causes you problems.
