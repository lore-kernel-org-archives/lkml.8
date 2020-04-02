Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614CEC2BA12
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 313EE2072E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="FmCRcwxM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389122AbgDBPOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:14:02 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41525 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388853AbgDBPOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 11:14:01 -0400
Received: by mail-ed1-f68.google.com with SMTP id v1so4602174edq.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 08:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WKhRMc892s5J3SEByy2exIsvz2J4zE9FBkgS5UdcNJE=;
        b=FmCRcwxMwa6FxspThwYLZYojVuq5qJR6W9C29g9WnofOMQHwJUxssNKKX53oEmHAaV
         7OdwB8vfafKvgUMFFCuShhRA7PHZFZVBKAYEMP8+f13HxsSbUVAAEXhY2tiYh67PDbOZ
         5LuKTHcoeahEgyFFv1+nFiDhKkxf5BVEfEKCEW7tyiBDATHP/s3gYbeXNvVgYlG/rb8A
         jHsfItuTM7S0iliNjYMtOBc3SHBy4JldksWzN9flP/cTqeHtwy5ip/DG/dWHdSaR60do
         wssrEQLGjrD9H6YBsVHYT5xHBwwN+pt0xtTXgzjhtbM2ERu1zv406ii7/CGZstczEPGB
         6pYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WKhRMc892s5J3SEByy2exIsvz2J4zE9FBkgS5UdcNJE=;
        b=FgyQ0vdQKaOyGm21OlHyxMTa2ZjCqP+598aZAMNvw9qaR8TH4fcenHUhEb6snInNgD
         LPVNBoLarRNjKGv6I3qh+SmYTJgZ4v/WC+pwDyEgSKwvukFcvSZ9BM3U91kojEmJiH+V
         kX5xRvBjqvajGJN56IoJ0UI9lmzMhsxdAgoUfHEqxSRYnMVy5NEBMP3/ynf6sYzKyfKS
         wjAU0UrQPpsf6qY/oIbd5fdor2ytE9M+eWnOnx/hfcewshy35xn4EIJDjXyfdoy/PdoQ
         MuzWVRVKuOkAlLhHucips91DdFXkEwVC5Ks02wLIB6qyFsq9H5J5hV0xbDSCk/N4+k2C
         lXCA==
X-Gm-Message-State: AGi0PuZuwAUnApobjHS3a0tEyvj6F/TQuF6fVJtqWStkyP5njBF/H7wU
        ex6YLeteTFJvXpEkFtpHqnYwYUkyMV+yHvibVGcTqg==
X-Google-Smtp-Source: APiQypIrP4nwSL50Fx9MmDml9Al1/4dW/gWr+/pgpcAvkiRW8A4rj1dc8hvwXkVGJsIDrKHc39PIXcfdYR+KEBS60g4=
X-Received: by 2002:a50:d0c3:: with SMTP id g3mr2968963edf.85.1585840440103;
 Thu, 02 Apr 2020 08:14:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200401225723.14164-1-pasha.tatashin@soleen.com>
 <20200401225723.14164-3-pasha.tatashin@soleen.com> <bd3db378-f5d5-0058-0a42-4ed6033439a8@redhat.com>
 <20200402074732.GJ22681@dhcp22.suse.cz>
In-Reply-To: <20200402074732.GJ22681@dhcp22.suse.cz>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 2 Apr 2020 11:13:49 -0400
Message-ID: <CA+CK2bAFsTJT2zU=+OyHj_-=zTKbw6mLHzrc2VEoGjPQpfhppQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: initialize deferred pages with interrupts enabled
To:     Michal Hocko <mhocko@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > I do wonder if this change is strictly required in this patch (IOW, if
> > we could keep calling touch_nmi_watchdog() also without holding a spinlock)
>
> Exactly. I would go with your patch on top.
>
> > Anyhow, it's the right thing to do.

Michal,

The reason I changed it here is because in the original patch that
this patch fixes we changed cond_sched() to touch_nmi_watchdog():
$ git show 3a2d7fa8a3d5 | grep -E '(nmi|sched)'
- cond_resched();
+ touch_nmi_watchdog();
- cond_resched();
+ touch_nmi_watchdog();

So, should I move it to a separate patch or is it OK to keep it here?

Thank you,
Pasha
