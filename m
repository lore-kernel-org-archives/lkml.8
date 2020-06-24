Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBD6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 18:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD69320823
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 18:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TK3CFbKk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406019AbgFXSsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 14:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405581AbgFXSsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 14:48:07 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EF1C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 11:48:07 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 145so331233qke.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 11:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eETegcECrqvywpE3KsL+8WK3hMwkFIOHNGmh0aWGRFA=;
        b=TK3CFbKkxiJln4JU3katp8P1wCphmM8l24Pu1y7cIzE7uqmb01MGeURvRdKy75rFUq
         PKojLEKtdIPvfWqaGlgUR1ZXP5NeTA26kTDgafmMoBNa8R3UoHWyIIlrUJvwmhvuTRE8
         wLTSkPsFDQt5TD6zsiTgmRPBuIZbVZKyheVW48Bfqb/4qPi6U271rlHt+Kap8WhSYOaG
         gwIqbMm7+jrtyFheUdJuP/0bIQDCTC1e8auU1g2KXVoEB6L7Ty/1mg+E0mmfYrY1VugH
         8i/FD9MJFVLBnUSbSe6jsl+QhevOv0D9zbbnoUqw3H5nSLKfybbs+dlsgvEMSEV8l+j3
         qICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eETegcECrqvywpE3KsL+8WK3hMwkFIOHNGmh0aWGRFA=;
        b=S+Ogk/S0LOelbYZcIsTHhnJD09vxhQCJC/RYQUIZwMJJresG78SyMdGM/sTXdpYD5N
         hXVimOyoSb/C7giLI5XKZQuns8YP0oqJ1xdUdripoCXYPkByWV9IJCT3xf6DVFC8Xpj1
         pJzczJmQ79D2BWF9c6LH4s+d3xkZg//GFLGUY0laQjXxZnEcM0zEVhOYhMesj5LAEujG
         5hdeVLF0JnSrIbq5NoOCwGD8fdjMUbRc1kpl4siDNFJfEVrts1cW4Ji60tBI0NVbLUOr
         zRYAJqehVT9XOlBSHqMlpBMFPluYczMzWQ55KDfJ8HCbPmAQqVB/N1fpLdXDFissRM7/
         JxxQ==
X-Gm-Message-State: AOAM5313nOgCNLq3Kkfjb3rDQM6BESBEJ+RpAUGymyvNg1YHmUl7WbkG
        a2FPyglY/UbD44rqM0CVwhGUJESz5NhBWg==
X-Google-Smtp-Source: ABdhPJwCclSbXjfp78+cyBid7KTxKfsoe/k5D1XwYtNFhk9DIfiHIytxbU3UfA1zOl//O+JimPup0w==
X-Received: by 2002:a37:9a01:: with SMTP id c1mr4508370qke.111.1593024486213;
        Wed, 24 Jun 2020 11:48:06 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id j7sm2913342qtd.53.2020.06.24.11.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 11:48:05 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1joARI-00DgLI-MZ; Wed, 24 Jun 2020 15:48:04 -0300
Date:   Wed, 24 Jun 2020 15:48:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] mm/mmu_notifier: Mark up direct reclaim paths with
 MAYFAIL
Message-ID: <20200624184804.GL6578@ziepe.ca>
References: <20200624121053.GD6578@ziepe.ca>
 <159300126338.4527.3968787379471939056@build.alporthouse.com>
 <20200624123910.GA3178169@ziepe.ca>
 <159300796224.4527.2014771396582759689@build.alporthouse.com>
 <20200624141604.GH6578@ziepe.ca>
 <159300850942.4527.8335506003268197914@build.alporthouse.com>
 <20200624142544.GI6578@ziepe.ca>
 <159300945202.4527.4366416413140642633@build.alporthouse.com>
 <20200624165057.GJ6578@ziepe.ca>
 <159302152915.4527.9099070806700792078@build.alporthouse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159302152915.4527.9099070806700792078@build.alporthouse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 06:58:49PM +0100, Chris Wilson wrote:
> > I'm still a little unclear on what you are trying to fix - pinned
> > pages are definitely not freed, do you have some case where pages
> > which are pinned are being cleaned out from the MM despite being
> > pinned? Sounds a bit strange, maybe that is worth adressing directly?
> 
> It suffices to say that pin_user_pages does not prevent try_to_unmap_one
> from trying to revoke the page.

This doesn't sound right.. Maybe there are some odd ball cases, but in
common things like page out we absolutely cannot page out or discard
pages under DMA. This would be a significant bug.

What is the actual problem here?

Jason
