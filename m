Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7247AC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B9CD246A1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="FHy404mC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404882AbgAPRek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:34:40 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43212 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392947AbgAPRaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:30:05 -0500
Received: by mail-qt1-f193.google.com with SMTP id d18so19489624qtj.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 09:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nXB1QQ2IuOraqyyfUU+xQ4aQQGOF9c/16KgO75ZTWiU=;
        b=FHy404mC4DAy7avamv6rP/tsX7uXrpLtoSjPwiMjoZ0SqcGxITSnPNJZVBXFcW/T81
         uouPRPMh0bW+Ls5KLmYmvhW3LD+wuD0GUeJkGYdhuUWqETB8A+IcdMx0euMvDy3eOrGC
         Q9bmG6NpVDsBPG5GuzJewaoG8pHLTriec/oHOSKxP49MnAf4o6tycXpj0zOocC35I3lE
         vo6ZZ/lU+AUJ5Z5ZcIIpDHVzS1qrb+pyJE5Ymrr4libH2/npms2xZiCp5JfKd6fWsvuW
         wPU5z6ht6cLg6Rldc4fnq+WLuYaN5tP/nI0fxujCyhsFWLp+Ywn+/pudirlk/JIf7RTz
         5dIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nXB1QQ2IuOraqyyfUU+xQ4aQQGOF9c/16KgO75ZTWiU=;
        b=awQn2LcyvzCZouNCN8kaUj3KjDOnl78gz6in9+C9feXO1DqPJXv/RRbloGX/+mvqTu
         pYoisAKVNGHEvr0+8vRx8+QQ5CvNr2ElcY6K/WXFOVGEtn9MBU3E9QJZajhYl2kHzFhL
         YdfB+iuI3GRrOPvCkal3MQblCLs1fqjAVlUGGBVciyzN+z9FyOALgX+9gozhBTNMNs+x
         VcujJE/8dA2A3mXDFtA/QYX86yBWbqYAFuqF6A8GIKtUjlNzGn0z+A9fs+mNsRvH3ujn
         XHKrUx/UCZO19xs9APd/fK+I6yRfG90kixhFKhtiLcm9+xGQVhEdiBQ2aMlNBH/Q7MOY
         iN/w==
X-Gm-Message-State: APjAAAVYC//4aJJ8wa/TyI0s3a4I1lIMni7cS8osFZpkcwgGVsV5q5Ae
        vMlFGn1uBtsIEDWC4VqQTBa/QA==
X-Google-Smtp-Source: APXvYqzJz9SHhVW/QFhyuUBUHinkJx7R7n44cFOVCqZgDzLe2eqyGEJJj5CjHH9aHKqLRdmShIbdgQ==
X-Received: by 2002:ac8:2f03:: with SMTP id j3mr3537882qta.180.1579195804411;
        Thu, 16 Jan 2020 09:30:04 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::ae73])
        by smtp.gmail.com with ESMTPSA id k4sm10398554qki.35.2020.01.16.09.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 09:30:03 -0800 (PST)
Date:   Thu, 16 Jan 2020 12:30:02 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 6/6] mm: kmem: rename
 (__)memcg_kmem_(un)charge_memcg() to __memcg_kmem_(un)charge()
Message-ID: <20200116173002.GF57074@cmpxchg.org>
References: <20200109202659.752357-1-guro@fb.com>
 <20200109202659.752357-7-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109202659.752357-7-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 12:26:59PM -0800, Roman Gushchin wrote:
> Drop the _memcg suffix from (__)memcg_kmem_(un)charge functions.
> It's shorter and more obvious.
> 
> These are the most basic functions which are just (un)charging the
> given cgroup with the given amount of pages.
> 
> Also fix up the corresponding comments.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

This looks good to me. I also appreciate the grouping of the functions
by layer (first charge/uncharge, then charge_page/uncharge_page).

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
