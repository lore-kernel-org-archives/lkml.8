Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A435BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 19:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A01D20823
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 19:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OJncFXFd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406179AbgFXTVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 15:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404794AbgFXTVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 15:21:19 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7059CC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 12:21:19 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id dm12so1592756qvb.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 12:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lbKCmmztI3GgkMC9SQmlMbuo/bkXgsTXp+Ju628Hzro=;
        b=OJncFXFdbc+4VNNWbBXY/ONS10iTtFLqYn5Nej/BXiYIlE7wXPRGFVSu8ZW607rFKr
         YknLuolvGMfXTw1BdQHDCnuJQI8IZ6e1ci5+5PMyFELyMNYv+yReSBqpSfGs10N4398w
         6/M5HZ7dqwB1N6G71BIQ0sTf1V8F056Nsfj7I8ub3w36xCjEXwOz6x5x3TWV7KfmsSk3
         vDTPMwCKXuQIt+B3olNNZtkZ5sWsE3yQQQpgCMuoryEKw4DkykTYk4c218295wog872Y
         0VtDMaiEWJMNPTdQk9qgfZB4FowV506Ijg9f+kTS/YvAvzmq4EuQzUl/AY2TSgsnnw5T
         QgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lbKCmmztI3GgkMC9SQmlMbuo/bkXgsTXp+Ju628Hzro=;
        b=Y1XDPqAmvaJ/8mSLfluz/gmU3z2i/LGwPjxdjp6xc66bmRZ7jfFtza8H7gE71m7jA+
         cyYrZSj6Fvm/k88DWi5l3mVf7YtffCrNSKh6ZnYjAdO9ffcNuSNOlmFFo33vo7HL3M87
         JEwWiTkkKmmsyPUUDFFYKZ9FKufUPSWgGrar+dlbV8LIY3BLHg/yPojuJQbUgEakniln
         K0BcV+M2bsK+s/hreqX4aEgzE7z6pqrs1jtHspeA4eQrCGZMCtepg7HRIPkUpdHOXtSF
         r49IoJUdx6Vn13BepqBul7WOGbMAtKH/fqxe6oj8lnokmvH8kNeogOQkc41aGAGePQhY
         QQxw==
X-Gm-Message-State: AOAM531rx6RALDEoVgCO5pFFpK9+cfI5vSbbiLLy4H8/Jyu0J8mIcq1G
        Y66qWJDOKNnC+Enz+5oeNDnYWw==
X-Google-Smtp-Source: ABdhPJyho45QObrN+BKeqm/MpnwnYYjrO/2aj2hyfcW5lNxqkyNoe1fDIsNNoLHTtmdM5ssJGxFWzQ==
X-Received: by 2002:a05:6214:1190:: with SMTP id t16mr33464697qvv.219.1593026477776;
        Wed, 24 Jun 2020 12:21:17 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id k26sm3854365qki.98.2020.06.24.12.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 12:21:17 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1joAxQ-00DixB-Bk; Wed, 24 Jun 2020 16:21:16 -0300
Date:   Wed, 24 Jun 2020 16:21:16 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] mm: Skip opportunistic reclaim for dma pinned pages
Message-ID: <20200624192116.GO6578@ziepe.ca>
References: <20200624191417.16735-1-chris@chris-wilson.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624191417.16735-1-chris@chris-wilson.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 08:14:17PM +0100, Chris Wilson wrote:
> A general rule of thumb is that shrinkers should be fast and effective.
> They are called from direct reclaim at the most incovenient of times when
> the caller is waiting for a page. If we attempt to reclaim a page being
> pinned for active dma [pin_user_pages()], we will incur far greater
> latency than a normal anonymous page mapped multiple times. Worse the
> page may be in use indefinitely by the HW and unable to be reclaimed
> in a timely manner.

A pinned page can't be migrated, discarded or swapped by definition -
it would cause data corruption.

So, how do things even get here and/or work today at all? I think the
explanation is missing something important.

Jason
