Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497E6C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 17:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DD5C20792
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 17:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="0zguSQRp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730895AbgGURmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 13:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730868AbgGURmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 13:42:24 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E43C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 10:42:24 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id d27so16797909qtg.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 10:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iXpIXavlE/ZwGIdQyg7+BwcjDDLZaRfVGWyFGkObed4=;
        b=0zguSQRpifWOIMc3Wxbvdk6Bwwn9eip+C034+tkTuBiaMTd1zFjdRoq+3omx245Aa4
         DZQGmwSGRpqWcyMnsjpDTupp7W5/t7+i65WcuXWio/xYmvM2eFB5Gs0/xWXYIa0nNvnp
         Z+kFKIXI/Twm0g0qpTVJcdRYzmdtv4LO+2463GownoC4rx5Wz05xJ0t5s0YL9Ibdqury
         jIAzJ0f7OdzeN7hMBcGhP25hDNUuULtxA07UfeyertHuveci290NT2L0Falns7sr1XN0
         82pwykAKX3K75CZfB+/1uJ4E2Cf3ywWAfZNDPzzqoKiTM6V4aHDgbcyTwASq7WP5g/cV
         1P4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iXpIXavlE/ZwGIdQyg7+BwcjDDLZaRfVGWyFGkObed4=;
        b=arYn5pT9SIW+d+jWmp6n1VyN0tkxxHymlHSHy5MzAClQOu7JgI+m3UcOeQ9a+V8Acj
         kylTxyndMzqycY5TZ7c189DU1Z6Y6pNibKU7ei1CP2ih0hU+dDGkwXyc/j9CVZ+Zu5KY
         QCX09vBtBpO6LfIqv5jedWh9oOc9EM4437VJNM7B+hZAnB+HG2FOekQNaD43IIN/iJIP
         GK9v7K7fe+nFuIUH9JcWYA9fdidxzxI+cs7Q25EY6LSfVBPDP+RA3BHvcjpim7KQAj5B
         cRz64xtzp/nlLj1JgJE4/w+UxtZ6u4fYDIvQHC7KiDaaZKTLyWhlU2Gf2exqTp+v1Ou4
         07Nw==
X-Gm-Message-State: AOAM533dYfKb4iVN3jDmwWv8YvAwpkYY64F8yWGjyA4zMxrvpEwkMhMw
        uHpph/Br7PG40y5g6czjkAD8qw==
X-Google-Smtp-Source: ABdhPJyoj9zwU/wa5AiYfBYxHfCaabKUXrxqETrJfjZQJpm9id3e3cDafQAZKwFg0G5lJSi4FiBY6Q==
X-Received: by 2002:ac8:4f13:: with SMTP id b19mr30642157qte.146.1595353343267;
        Tue, 21 Jul 2020 10:42:23 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4399])
        by smtp.gmail.com with ESMTPSA id r35sm22987577qtb.11.2020.07.21.10.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 10:42:22 -0700 (PDT)
Date:   Tue, 21 Jul 2020 13:41:26 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     jingrui <jingrui@huawei.com>
Cc:     "tj@kernel.org" <tj@kernel.org>, Lizefan <lizefan@huawei.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        caihaomin <caihaomin@huawei.com>,
        "Weiwei (N)" <wick.wei@huawei.com>, guro@cmpxchg.org
Subject: Re: PROBLEM: cgroup cost too much memory when transfer small files
 to tmpfs
Message-ID: <20200721174126.GA271870@cmpxchg.org>
References: <2E04DD7753BE0E4ABABF0B664610AD6F2620CAF7@dggeml528-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2E04DD7753BE0E4ABABF0B664610AD6F2620CAF7@dggeml528-mbx.china.huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 11:19:52AM +0000, jingrui wrote:
> Cc: Johannes Weiner <hannes@cmpxchg.org> ; Michal Hocko <mhocko@kernel.org>; Vladimir Davydov <vdavydov.dev@gmail.com>
> 
> Thanks.
> 
> ---
> PROBLEM: cgroup cost too much memory when transfer small files to tmpfs.
> 
> keywords: cgroup PERCPU/memory cost too much.
> 
> description:
> 
> We send small files from node-A to node-B tmpfs /tmp directory using sftp. On
> node-B the systemd configured with pam on like below.
> 
> cat /etc/pam.d/password-auth | grep systemd
> -session     optional      pam_systemd.so
> 
> So when transfer a file, a systemd session is created, that means a cgroup is
> created, then file saved at /tmp will associated with a cgroup object. After
> file transferred, session and cgroup-dir will be removed, but the file in /tmp
> still associated with the cgroup object. The PERCPU memory in cgroup/css object
> cost a lot(about 0.5MB/per-cgroup-object) on 200/cpus machine.

CC Roman who had a patch series to free all this extended (percpu)
memory upon cgroup deletion:

https://lore.kernel.org/patchwork/cover/1050508/

It looks like it never got merged for some reason.
