Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05D9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFF6F20721
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="AZvUVlJq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbgEZQCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 12:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727862AbgEZQCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 12:02:05 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C895C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 09:02:05 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id x13so9668226qvr.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 09:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RsZ3nQfGjW40v4ckRRp9241TQQ4YCE7GdfX8IPCvDyE=;
        b=AZvUVlJqEqbAPtDWEcV8xLSKNrSwwqm27o4j1nKpKyNIvP//3xF9TBUmSqeioWu+ox
         GgUtzLzzkJzvIbm87q0XvHko4QXlFaYxgKgfCZ53z4iBOhQnGqODmLbw626evo9klZtu
         c7PoTVabRQKKhf5nWGB1E7GcRx+eMZZcPz81NaE8FAVR20U3lqHBNcCpwjcPFS5ErJ+8
         6XZEtI7fjLtnGewlpV2uHO14tWYN0wa4KnFXX+ibs43sGR8LaHz0R1Bm+9wCm93w5gpq
         u4epjiy5ZZpl+TZKm6frdFVstFQ04kgG6wE7yggabAskwiesK6ye0FxlnjiklEHIwV5l
         thfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RsZ3nQfGjW40v4ckRRp9241TQQ4YCE7GdfX8IPCvDyE=;
        b=gXpwbrVPNr4jirEpv3g0nO+gVXWQUErh2r/p6eoUUE5soNrVtEEHcDMYfe9z45REo2
         guNN9tbNzw5I6T+ieBlYdTnVWT4ogFMMghdYoWwkkaSrUUQ9JQfyjUG35fddSFWF/oFK
         NupIo8L/DIf9MPWQncgjDA2EomNJ0gh18FA9o3i/tQgZI4UBWb+mBjvRRicBu+hnmoP3
         5ZPUnQgiNHGS+LnpERV1+T/qumupYnborcBTerbP4aT9b7BiqAoXVBm+g37uW6+bMwEv
         ceAmTi7Fwtes0Q0hmkH0Nv1J3mP23DajANOppXu3NAE2n3p/M7lT5mTTMBHp5GwwswMk
         xYVA==
X-Gm-Message-State: AOAM531Pk5ZLZ6utjzWK0CbEqcRb+z21FYR9hHxfrSuv2B+84OAz+adA
        cDWF0fTB1aBWW3YUE+k8JWxyoA==
X-Google-Smtp-Source: ABdhPJzhXcKDUYQ8+zI3NmJftxHzdTRDdvli5ewQjK6oPrSCn55dFt7LvsFzmcLbWioE/ZJdmqLuIA==
X-Received: by 2002:a0c:b354:: with SMTP id a20mr20923201qvf.205.1590508924821;
        Tue, 26 May 2020 09:02:04 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:8152])
        by smtp.gmail.com with ESMTPSA id q34sm58103qtd.89.2020.05.26.09.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 09:02:04 -0700 (PDT)
Date:   Tue, 26 May 2020 12:01:40 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm,thp: stop leaking unreleased file pages
Message-ID: <20200526160140.GC850116@cmpxchg.org>
References: <alpine.LSU.2.11.2005231837500.1766@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2005231837500.1766@eggly.anvils>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 23, 2020 at 06:50:15PM -0700, Hugh Dickins wrote:
> When collapse_file() calls try_to_release_page(), it has already
> isolated the page: so if releasing buffers happens to fail (as it
> sometimes does), remember to putback_lru_page(): otherwise that page is
> left unreclaimable and unfreeable, and the file extent uncollapsible.

Oof, I could imagine that was painful to debug (unless you already
suspected file THP due to a targeted test or similar). Kudos.

> Signed-off-by: Hugh Dickins <hughd@google.com>
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> Cc: stable@vger.kernel.org # v5.4+

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
