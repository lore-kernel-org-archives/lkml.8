Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042C5C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D29D021741
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="OF5msf8x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgHZO22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgHZO2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:28:19 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772EEC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 07:28:19 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b14so2016727qkn.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 07:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xk5PuaZ3h09SHfotxUuVEcyrelgIx31zSBn5gXVN9IM=;
        b=OF5msf8xUCmN3Dyr5IsRi7XjXqiObhM2vxPE0Wx6z73yQzocQZyXZsVr5xG0GxVewc
         8mLHzkVTThC3XbmKu2Oa0VF7cELOHQSCp/cqw+5vpnsG3VZHJvXAr+JOvrRE6R63MecR
         5eKN8lU7SEwLqjplk8sot+PoejbjUxEv8shqxLgH73nW3b2ndtpOW1dPSVhhoQHC5XxK
         PdD3gTbsv7nty7LeKQllTit9Ov259nDQt7vZU9yH1d6KPkehzqy90/rxUJUFDOLY8VkC
         R2+yVQgS7FhIexvx3CAo8IWgUcOwpwxqj9aIgTPNL0TCgX8H7T0yWCtFyDa7/BtXGVhx
         sMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xk5PuaZ3h09SHfotxUuVEcyrelgIx31zSBn5gXVN9IM=;
        b=QAQwWAa7w29BeGRxdaxz2gKVZ2MiBWwDpiqWRboGuTwnTBBNLCobS1g/Wr6zl55xUv
         9oBziyo4QnbW7X9eZmnFM9DD2C8X43QGw5LRCJsxrTcJJmguczsnKuk1r+o914TE6Rbi
         27sndW5z6ICRc534nOLBVZZrQ8IhyeRFMpQEScuLq7jQDJKTQYycSUNt6dqYEZpIPELc
         otdkrTGWpYxPhw2caAXIPdSpYisyzhCoCX3BeFjJuz9KlsZSIN6bMUrEGttNtjmQa+25
         vCuPjvnZwwOtAB1IsRq+0ewuZg5nXyY2us2iQVDYyt7vI+ql1cOAZLS+IsiAAG22MRMm
         8E2g==
X-Gm-Message-State: AOAM532O/7fWDM0n/bCzeU7ZmiIsOjHqT5RiKYipSNHTiIwFpeWkoRKn
        FMzhvhdf/IOPiJrTJwkGLQLKcA==
X-Google-Smtp-Source: ABdhPJwTpEodJr7XmJ6vcGG/Qy1YoTKLrAkKtGQKZLh7Xqi5GwYySJHucKowPQ2UWvg/JqRFErD0OQ==
X-Received: by 2002:a05:620a:1257:: with SMTP id a23mr13959682qkl.207.1598452098795;
        Wed, 26 Aug 2020 07:28:18 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:1f2b])
        by smtp.gmail.com with ESMTPSA id v136sm1814940qkb.31.2020.08.26.07.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 07:28:18 -0700 (PDT)
Date:   Wed, 26 Aug 2020 10:27:03 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        intel-gfx@lists.freedesktop.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] i915: Use find_lock_page instead of find_lock_entry
Message-ID: <20200826142703.GD988805@cmpxchg.org>
References: <20200819184850.24779-1-willy@infradead.org>
 <20200819184850.24779-6-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819184850.24779-6-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 07:48:47PM +0100, Matthew Wilcox (Oracle) wrote:
> i915 does not want to see value entries.  Switch it to use
> find_lock_page() instead, and remove the export of find_lock_entry().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
