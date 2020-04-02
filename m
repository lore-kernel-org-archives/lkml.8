Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC4BC2D0F3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 950592078C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="L/SnQjBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389049AbgDBPSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:18:55 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:46042 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388234AbgDBPSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 11:18:55 -0400
Received: by mail-qv1-f66.google.com with SMTP id g4so1803854qvo.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 08:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X4md8GfFb/AZLlmWivRcEwSCP4uBimc7oKbXY4Cuzbs=;
        b=L/SnQjBfnp5fEn4nBLMR6OIrZCUsqaFG32VM3D8P0P8Lj/uoYnjkRyEnuYvXsJsAKt
         c4igzrWSnvwBSj3E7mr0QbuhFJhboCmmv66EkfRKM8dykWur9UCs7QjwYmhFzRp4O+A4
         SnrLBfG8ir/Oio7mvh4OgFCEi2cahY9VIyMpFSkHRdm41lB0/v0GSq1mKWVd2TiCyBlN
         hI6cIgvd6bBViEDgjTfBgb3PQnim/I28LCR10Uk8FN4kj7u9VdBwqKzsszZNJndU/ap/
         B/jD43fEcMR1E7yUPLdB4B9rCGNhvxza6rn5dvPkZt/C61cv9D6z0rzi3GwPV+Lp5T9D
         VM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X4md8GfFb/AZLlmWivRcEwSCP4uBimc7oKbXY4Cuzbs=;
        b=aQvs/YWdpojqaN/2HmDaTUBUN1zIfocdGbamqWGV9rxsTKU6zWgjDj9Xew86EJRjVg
         GZjvXUACIEUmetTCVuBDfii01aGJZAjDM40c2LVlvJK2dtyN0s3bY5nwSbmbitOSZ48g
         KjbyhGRMt+8ITeRXZFFKGDeSPsTb3aS4VdB6p3qr08AD2uZFREYx2CZurNqrbQvf8ywf
         h5fFwzwirsgr36GR1jYCgTx1X4zyFQoYQ4uACGk5unLwwGSR5YcYceaPFur8SFOqiAoa
         XbZK7UorAgONNjQ1gLdHHbCN5oZBbZLlF0o1m55Ce5GrgX5eMdmVJ7pCqp4qcDjFgU+p
         yoAQ==
X-Gm-Message-State: AGi0PuaDgA2wlB9+FSewYTq2oqDPYsIJBk/u/J9RHrGH/AyiAGdbR1gN
        z1IEwF3znNT0WhiYXnrfqEcKXL4jrF0=
X-Google-Smtp-Source: APiQypL5Dn4DcQmenazeGPmJARieWyi3C0ntxFpd4l0Ao5mKkYmQaN0AZVEOfdy/PupIGM0JUmOwRg==
X-Received: by 2002:ad4:55cd:: with SMTP id bt13mr3597389qvb.111.1585840733984;
        Thu, 02 Apr 2020 08:18:53 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::11c9])
        by smtp.gmail.com with ESMTPSA id z66sm3721863qkb.94.2020.04.02.08.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 08:18:53 -0700 (PDT)
Date:   Thu, 2 Apr 2020 11:18:52 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm, memcg: Bypass high reclaim iteration for cgroup
 hierarchy root
Message-ID: <20200402151852.GD2089@cmpxchg.org>
References: <20200312164137.GA1753625@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312164137.GA1753625@chrisdown.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 04:41:37PM +0000, Chris Down wrote:
> The root of the hierarchy cannot have high set, so we will never reclaim
> based on it. This makes that clearer and avoids another entry.
> 
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-mm@kvack.org
> Cc: cgroups@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: kernel-team@fb.com

This makes sense, memory.high doesn't exist on the root.

And the mem_cgroup_is_root() check, a simple pointer comparison, is
cheaper than reading the page_counter atomic and memcg->high (which we
already know to be PAGE_COUNTER_MAX).

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
