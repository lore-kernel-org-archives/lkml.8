Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAD0C761A1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 22:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D97207FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 22:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgBSWmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 17:42:35 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43799 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbgBSWme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 17:42:34 -0500
Received: by mail-pf1-f193.google.com with SMTP id s1so812407pfh.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 14:42:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OIoZhKbx27/FCo9yilFuIVLxJ+Eh0wcGMXuT/euPHOc=;
        b=EWU2wJgaKEjGy5Br1fZNKC7fVlcD7SGWAIGBIrng/Kd1WAT6vBn2YgQMqreHbBUYyJ
         8RRr53TBaKiAR8Qh2CGV0INnXnaXYPmcZl0l2XB7CyrNaEA7gndXi6bTZtLKC1sZH/1/
         ukIve+D7gNwGEihaelSfMOx4qvVHTwg531i3rC1qukaJuktRlEPC1GtcCWHGqa/taBbZ
         123GTwO7QsngtTkf26WjdUFev4ni92i9lUuc2H0gJbppi/WNGe4eaGFVLS4y9a7Bief1
         Gf4kJ4Wcr1njSWA7nI8SLXWQD1Ocgtb3v0OkB1SiQLIkgDIEweOF/AC8K2SAbp2K312t
         vqPw==
X-Gm-Message-State: APjAAAUruwKv7AoOk0lsgmCJL/C2JwIcMqRsodvtjseSgTInlYAx3EjO
        WiTcyeKpFTNSX8BhEcfeC5g=
X-Google-Smtp-Source: APXvYqzFd+7FAez8BO6WoN8/0I+p7oskMsNBKXcYctB7DEouDjN17mDU3zO6Ke3OQtZ/LDuGM9pMgQ==
X-Received: by 2002:a65:468d:: with SMTP id h13mr3403908pgr.359.1582152154012;
        Wed, 19 Feb 2020 14:42:34 -0800 (PST)
Received: from sultan-book.localdomain ([104.200.129.62])
        by smtp.gmail.com with ESMTPSA id d2sm794824pjv.18.2020.02.19.14.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 14:42:33 -0800 (PST)
Date:   Wed, 19 Feb 2020 14:42:31 -0800
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm: Stop kswapd early when nothing's waiting for it to
 free pages
Message-ID: <20200219224231.GA5190@sultan-book.localdomain>
References: <20200219182522.1960-1-sultan@kerneltoast.com>
 <dcd1cb4c-89dc-856b-ea1b-8d4930fec3eb@intel.com>
 <20200219194006.GA3075@sultan-book.localdomain>
 <20200219200527.GF11847@dhcp22.suse.cz>
 <20200219204220.GA3488@sultan-book.localdomain>
 <20200219214513.GL3420@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219214513.GL3420@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 09:45:13PM +0000, Mel Gorman wrote:
> This could be watermark boosting run wild again. Can you test with
> sysctl vm.watermark_boost_factor=0 or the following patch? (preferably
> both to compare and contrast).

I can test that, but something to note is that I've been doing equal testing
with this on 4.4, which exhibits the same behavior, and that kernel doesn't have
watermark boosting in it, as far as I can tell.

I don't think what we're addressing here is a "bug", but rather something
fundamental about how we've been thinking about kswapd lifetime. The argument
here is that it's not coherent to be letting kswapd run as it does, and instead
gating it on outstanding allocation requests provides much more reasonable
behavior, given real workloads and use patterns.

Does that make sense and seem reasonable?

Sultan
