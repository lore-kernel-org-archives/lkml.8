Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB966C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A2EE2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="hV9+5puq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgE0TpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 15:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgE0TpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 15:45:22 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFADC05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 12:45:22 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id x29so7065871qtv.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 12:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D80XpsA6hJ4kY4NNH02ZCQ+SxpQnIHKs3bcOMnCiqaA=;
        b=hV9+5puqc8TazkxTs6psTgANjLuorgwlMEXYnsnhCo+mw9taU1spQGto8UthSQ0LTF
         w8l/d+vh+tJ1UDVAWTP7pHdmCvXxbCfbVswIiQ9FaSUTGahXM/Emag2teZrIKyJZxBIm
         blhjYl35v+2kYyF8Kx4bm0JVyTMQ8qO1o2HcJqthotpb7fz5qYTHu1ms8PT60qteiOHW
         lBP12r117ByfuDvTHsRzh4Bui41TdIbWV4zSQ7f5iTWv9sbuob+9dFK8jqGnbx/0bh0a
         Uw0ra6vaDjyO85emAlyD0v7cFz/NXx+4oHJpUYHInlCVQ0ZS2wv5cEGGrOQ9hmSo5LEb
         X2zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D80XpsA6hJ4kY4NNH02ZCQ+SxpQnIHKs3bcOMnCiqaA=;
        b=EMkZA7KFxZ3UOQIydnX3v55J1D/F8wWGKI4mroo4r5rD44qgCX8orxhyg/0d21IHlY
         eOGTdtAJ8ZCnduQG8h3bLcQbAlp/EtzwN8nnXxYFPGb/6HikgxhDpEO4z8E08m1t+PU/
         DlIy8AIwh6J7lzOmlEhExaiCwu44sdBvXM/Bv542g2ywUxmkmOjYlwL6hp1tDRDnoTWf
         4EQaVT+1HkcJ6EhaKdbshqdUVIK21IukpBZhHoJrT91m+91Vy3Og/A0d/b0jpRkZRKn/
         5zBecDRbX+u2rNKHDfKxasPuw5Oj9MQoZTuo6ekJnax09lt3itF6hABk0Fr/KLMIUS9X
         dBzw==
X-Gm-Message-State: AOAM533pi1AQim53uLUJ9s0Ow/ZKTusRNunIEXzr1EE0Y8ClqbdnSikJ
        1XjNgySMkXILJprIpfjhdBp4LQ==
X-Google-Smtp-Source: ABdhPJydAAdrWEqBz4+lafNXlZ92z44aShoyQMaDpyiLn4rtZVfccZmqkLHnU+QgCDyMuEQjPPnV5A==
X-Received: by 2002:ac8:339c:: with SMTP id c28mr6210643qtb.9.1590608721295;
        Wed, 27 May 2020 12:45:21 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2535])
        by smtp.gmail.com with ESMTPSA id l22sm2850802qki.45.2020.05.27.12.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 12:45:20 -0700 (PDT)
Date:   Wed, 27 May 2020 15:44:55 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 04/19] mm: slub: implement SLUB version of
 obj_to_index()
Message-ID: <20200527194455.GB47905@cmpxchg.org>
References: <20200526214227.989341-1-guro@fb.com>
 <20200526214227.989341-5-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526214227.989341-5-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 02:42:12PM -0700, Roman Gushchin wrote:
> This commit implements SLUB version of the obj_to_index() function,
> which will be required to calculate the offset of obj_cgroup in the
> obj_cgroups vector to store/obtain the objcg ownership data.
> 
> To make it faster, let's repeat the SLAB's trick introduced by
> commit 6a2d7a955d8d ("[PATCH] SLAB: use a multiply instead of a
> divide in obj_to_index()") and avoid an expensive division.
> 
> Vlastimil Babka noticed, that SLUB does have already a similar
> function called slab_index(), which is defined only if SLUB_DEBUG
> is enabled. The function does a similar math, but with a division,
> and it also takes a page address instead of a page pointer.
> 
> Let's remove slab_index() and replace it with the new helper
> __obj_to_index(), which takes a page address. obj_to_index()
> will be a simple wrapper taking a page pointer and passing
> page_address(page) into __obj_to_index().
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
