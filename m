Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A25C2BAEE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F68E2074C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l8Y5WO63"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbgCKRhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:37:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41165 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729852AbgCKRhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:37:45 -0400
Received: by mail-pg1-f194.google.com with SMTP id b1so1574401pgm.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 10:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=apEu9N/pFu25fe7Vqmx6y36i/WaTLbYKboYSmzmWmdI=;
        b=l8Y5WO63bmnms6wYDERKf+nPQ07ujfaSMsBS/MjhTJdIyr52i3qKwMRtlG+68DyuQb
         1eZctlrhU8ij5/BvkiFwIjETBRx3uUkdVn1hu1MimLHfwA3PhYNRv9GsL6jl7o9Rqbb2
         3f6hCbES4VNJC5sJbOEz7Vq3m/NZtxYj7wQrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=apEu9N/pFu25fe7Vqmx6y36i/WaTLbYKboYSmzmWmdI=;
        b=hTQfoaoT+admGX08EHSmGmv01uUzqhF4xbZYuRgv2ibxARWj3qUTELpCXEWsQOApjl
         3QN/I3nTSG9P/ciiise1CYor8qbQvvXd0eT7ldRKGrSB3miwdq34lvE4ihwLWGdUomI9
         OOkvrJqupLQQUrIScOLYUh7qA/FtqfwRqhMo9hY2Tu1l2E7luqaeWfEI8l7IOTN04GyT
         juFlBjRvvU+mI65C11K7FP/LdMzKahT8j7hBjk8XVcbjOr7EI2YvRw3TGNR/ntx1wh51
         Gs96sY0n+fz6T+IlvJa2exeWZCv0guw7HxD1pmfeOaqtVxYgN5qxFzZy7GRd9Iof0OyZ
         Av/w==
X-Gm-Message-State: ANhLgQ2Mqd6RkgTM+WJ0EOhLBI9al+bsqbhlsOTAlS5Vfw1cby0rwIsx
        L8G8kkKfIoJobyxgVdf7EoWTMXqgPrw=
X-Google-Smtp-Source: ADFU+vswXXoOnWhIYDbnMCIFSjDRcmVBiJ4nhzgaFobMHV0hGKkrUvnoqselwWa48XEKR6xl0ZCVFw==
X-Received: by 2002:a62:f24d:: with SMTP id y13mr4093191pfl.27.1583948263031;
        Wed, 11 Mar 2020 10:37:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i187sm11966774pfg.33.2020.03.11.10.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 10:37:41 -0700 (PDT)
Date:   Wed, 11 Mar 2020 10:37:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Christopher Lameter' <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Daniel Micay <danielmicay@gmail.com>,
        Vitaly Nikolenko <vnik@duasynt.com>,
        Silvio Cesare <silvio.cesare@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] slub: Relocate freelist pointer to middle of object
Message-ID: <202003111036.80DEE85@keescook>
References: <202003051624.AAAC9AECC@keescook>
 <alpine.DEB.2.21.2003081919290.14266@www.lameter.com>
 <6fbf67b5936a44feaf9ad5b58d39082b@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fbf67b5936a44feaf9ad5b58d39082b@AcuMS.aculab.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 02:48:05PM +0000, David Laight wrote:
> From: Christopher Lameter
> > Sent: 08 March 2020 19:21
> 
> > 
> > On Thu, 5 Mar 2020, Kees Cook wrote:
> > 
> > > Instead of having the freelist pointer at the very beginning of an
> > > allocation (offset 0) or at the very end of an allocation (effectively
> > > offset -sizeof(void *) from the next allocation), move it away from
> > > the edges of the allocation and into the middle. This provides some
> > > protection against small-sized neighboring overflows (or underflows),
> > > for which the freelist pointer is commonly the target. (Large or well
> > > controlled overwrites are much more likely to attack live object contents,
> > > instead of attempting freelist corruption.)
> > 
> > Sounds good. You could even randomize the position to avoid attacks on via
> > the freelist pointer.
> 
> Random overwrites could be detected (fairly cheaply) by putting two
> copies of the pointer into the same cacheline in the buffer.
> Or better make the second one 'pointer xor constant'.

My sense is that this starts to stray closer to "too much overhead" vs
the mitigation benefit against known heap metadata attacks. I'm open to
seeing patches, of course, though! :)

-- 
Kees Cook
