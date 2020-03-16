Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CF4C2BB1D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 16:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE4AF2071C
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 16:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="SHgvwS9Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732099AbgCPQTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 12:19:10 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34903 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732021AbgCPQTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 12:19:10 -0400
Received: by mail-qt1-f194.google.com with SMTP id v15so14702843qto.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 09:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FGmHo0X0ug88xLxL5VEMvKfeQgO1Bzc/6oEObLpalt0=;
        b=SHgvwS9ZQXVqWJj5Zg/whvmP0uVvCvk7nB+wXhoy06AICUCarPw4d95BS7CJvG67UU
         NX8wP9DEQJ0mgCrwGOWKtNK59MMqvFI00+RHuh0T+yO1RTHxBEtxCbEK2FT8r+V2tB9h
         Mk1bzFa1SvwjUcS6Q7GSk61qqUhraymSLxN7La1EGmsw+Qxumbbns6Wb1kYMHPlLtkxe
         9JEk6yL6bHZszcytqNRZZSfQAp498YTvNeyQjFBVRM6Ckt1osk3zGZvEMoaGp9qkKZvP
         0ILeErzkPHYfFxCPj9zcFZL6pVv34cuxBMBtFOMl/RegHfvHd5bpoXm8eLeqMpNhP21R
         C0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FGmHo0X0ug88xLxL5VEMvKfeQgO1Bzc/6oEObLpalt0=;
        b=RA/7Z7Eth5PRw+RAUcMUoEbb1C/ZEMoo5PGpVHSvxMZjameb0sYTytzRHI+iwzooLw
         XYwzzKBCkU9yR1YPbgYf0Muye8toR8vH88XcubIZViNINp+xQ/aSvcJayar7nv4WCAq9
         +64KNaIke5Z68L0k45BH9Y+Y5T49K18VvKqlua2fYVihkizOjFABDNMg3yezCXCj/122
         9k7rbnttfxtW2PgE13LRGt/YeQxw1OEcPhJVLUPDBbYlyBkYunTBz2ErUBmrQdAAzJAl
         m5Ol5DySATDUgPBQwHf4G2Fb1AL1x4GzwAonoJ5lZGfKawz7nwc1zNd+7HIbdkKs5KNA
         HAxg==
X-Gm-Message-State: ANhLgQ2kFQPDXVIi6aEoZ7k7eBYef+nYsPJXIM325Mp24AO1QCtFLIIQ
        TW1XwLMhYLba3su+eDRUwmRPYg==
X-Google-Smtp-Source: ADFU+vtx+zMj7eTBogu7AvmwKKGLCsGJnyGIB45kgyVWQ3gEMMOGIIAyfVwsIK6AVGNouJNqa0oo9g==
X-Received: by 2002:ac8:18f3:: with SMTP id o48mr897399qtk.368.1584375549434;
        Mon, 16 Mar 2020 09:19:09 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id y17sm108505qth.59.2020.03.16.09.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 09:19:08 -0700 (PDT)
Date:   Mon, 16 Mar 2020 12:19:07 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 1/2] mm, memcg: Fix corruption on 64-bit divisor in
 memory.high throttling
Message-ID: <20200316161907.GE67986@cmpxchg.org>
References: <80780887060514967d414b3cd91f9a316a16ab98.1584036142.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80780887060514967d414b3cd91f9a316a16ab98.1584036142.git.chris@chrisdown.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 06:02:54PM +0000, Chris Down wrote:
> 0e4b01df8659 had a bunch of fixups to use the right division method.
> However, it seems that after all that it still wasn't right -- div_u64
> takes a 32-bit divisor.
> 
> The headroom is still large (2^32 pages), so on mundane systems you
> won't hit this, but this should definitely be fixed.
> 
> Fixes: 0e4b01df8659 ("mm, memcg: throttle allocators when failing reclaim over memory.high")
> Reported-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-mm@kvack.org
> Cc: cgroups@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: kernel-team@fb.com
> Cc: stable@vger.kernel.org # 5.4.x

div_u64 versus div64_u64 is really a handgrenade. We just fixed a
bunch of those in psi as well.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
