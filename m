Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C01C34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 21:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8498424656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 21:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="KHQvflBu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgBSVdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 16:33:39 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:39871 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbgBSVdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 16:33:38 -0500
Received: by mail-qv1-f65.google.com with SMTP id y8so912127qvk.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 13:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JVkD5nxiTD0qf2+tDsHsfNYWqcQb37JvAO77tIsuHko=;
        b=KHQvflBumvT9ocn+DUGF92g5qIEYXn4RpN+sBAiiGI7qDTLMDNvmMXdzmPx07tdVC5
         Z0jvJ9KvD3Oz7dzhrCjSoFhzzkkoRZ5cfSGee6fXlC4SGMn+qcgJb69EApxW+QV0Ithg
         yFxee/9aU7GZEi96Gqkjtz9aGbnDEFfrQR2RtxW3VYOlLw45JSNOGyp0Qo2KHPO4KTEF
         fO+TS/HO2EgULbw5hfQWr8Ui6ZzSceXUwwZI2AQcNjv8OJCCdE9TwIsToHxrKor4ndV+
         a4UIjjq/mOCYYiNdlRbZawGhrrSJpjoQsKrEzSmsPSJkWMOrGT7A5yXMxtog1VXEBgr6
         GCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JVkD5nxiTD0qf2+tDsHsfNYWqcQb37JvAO77tIsuHko=;
        b=GaqoR9xmnohbOD99HPaAJRPIHFK3nfVCwCQnZaHBidRStPTJ+/UnRIRoaXJdhJfR7V
         SUHZ60EKFDkOHeAEcdl9eRzkbrMUdQNSMAnn4fwCNFTSDbZkR8nh3jSoFOIA1R4Eaq+T
         Hppu9j9GlfPhGbIppLFwcXuPUjgWPXmJihbFZIswk3IqRCHNmDVKYNOJbnlQVlDR6+PR
         QWafH6BtCJ9PvvE84nQbxWPhRL3kA1yYnfOwxWWCpge+tsNJz1lAfsx2uw/OsX80dmcR
         YSYzpOyhwaG+vAnwmQT3WCnKwah/7K67yYUOBME6AnXW7X1SpzwwjlT053tM3KRHCVqE
         xO9A==
X-Gm-Message-State: APjAAAWAPipuMhyVc99780Oi2mtz2uaGe67DPd8qg3a9NQajOVD9Bu4i
        N5I743Nf/z/SuWXMM5rhbkT6Kw==
X-Google-Smtp-Source: APXvYqzEXXsR5u3FJN/PyxBmZtf/Z8ndTXA0RM2zBRR4GY9UMh7JsgHW89x2UTENdKZ+5MLtTmbR5A==
X-Received: by 2002:a0c:e2d1:: with SMTP id t17mr23178016qvl.25.1582148017323;
        Wed, 19 Feb 2020 13:33:37 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:3bde])
        by smtp.gmail.com with ESMTPSA id g62sm512111qkd.25.2020.02.19.13.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 13:33:36 -0800 (PST)
Date:   Wed, 19 Feb 2020 16:33:35 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: asynchronous reclaim for memory.high
Message-ID: <20200219213335.GE54486@cmpxchg.org>
References: <20200219181219.54356-1-hannes@cmpxchg.org>
 <20200219183731.GC11847@dhcp22.suse.cz>
 <20200219113139.ee60838bc7eb35747eb330fa@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219113139.ee60838bc7eb35747eb330fa@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 11:31:39AM -0800, Andrew Morton wrote:
> But what was the nature of these stalls?  If they were "stuck in D
> state waiting for something" then that's throttling.  If they were
> "unexpected bursts of in-kernel CPU activity" then I see a better case.

It was both.

However, the workload was able to perform with no direct reclaim
activity and no stalls, while memory.high semantics were never
violated. This means that allocation rate was not outstripping reclaim
rate, just that both of these things happened in bursts and sputters.

If the workload isn't exceeding the memory.high grace buffer, it seems
unnecessary to make it wait behind a reclaim invocation that gets
delayed on IO but will succeed before the workload comes back for the
next allocation. We can just let it get on with its thing, actually
work with the memory it just obtained, while background reclaim will
free pages as they become reclaimable. This is a win-win situation.
