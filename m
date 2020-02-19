Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1830BC5ACC4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 22:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E434220656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 22:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgBSWpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 17:45:06 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:52265 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbgBSWpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 17:45:06 -0500
Received: by mail-pj1-f65.google.com with SMTP id ep11so1639pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 14:45:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lLbGCApp0kw/cxO3wVgRURONxiOtR+9Pq112uDjPMic=;
        b=FWHHth5cXf9YwDIY1a770hHPFHPmIGuR7k15yKwf/YNxBM3ikR1BLuh2il5meJ+NZq
         Ruzoz4Lvj0dU0aOIJhFRCd5vJ8LCUVaNG4cZgBibkIRe48bFppmTASKq5RBbJbNU8lif
         3JprgUoubXqlZLsxazvq2wUvQMbyNugGR9O58MeUaY+zWj+3Yjy33+8Lq0Ck1guRDCL4
         sCvfrWqp2Z/udJTquE4S54MydG1SEeLCX0WYYOGEOgmQfZisbNj3yk6HRYf9TUqSbMf+
         AEv0CGtSARl46lS2107oVJKG3PzKJnpxA+TwNuty83Di6JHQGZeaSTjBlsEf8dFl+whT
         b5KA==
X-Gm-Message-State: APjAAAUYB/+fwvg1laS0E/ABoIDw45i6Kl6SKtUUd5u36tgeqSJaQtMP
        qm0QeyL4k7vPmZsoVUVI1auApb14
X-Google-Smtp-Source: APXvYqzRqiVsaGXY7a6QyEtZAOH71T7kxfaQgp64P/WRyCjh5HKUpXVZchgo0NJk119epb6nRCH0FQ==
X-Received: by 2002:a17:902:123:: with SMTP id 32mr28771095plb.38.1582152305677;
        Wed, 19 Feb 2020 14:45:05 -0800 (PST)
Received: from sultan-book.localdomain ([104.200.129.62])
        by smtp.gmail.com with ESMTPSA id o9sm652686pfg.130.2020.02.19.14.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 14:45:05 -0800 (PST)
Date:   Wed, 19 Feb 2020 14:45:03 -0800
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Stop kswapd early when nothing's waiting for it to
 free pages
Message-ID: <20200219224503.GB5190@sultan-book.localdomain>
References: <20200219182522.1960-1-sultan@kerneltoast.com>
 <20200219112653.116de9db314dade1f6086696@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219112653.116de9db314dade1f6086696@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 11:26:53AM -0800, Andrew Morton wrote:
> On Wed, 19 Feb 2020 10:25:22 -0800 Sultan Alsawaf <sultan@kerneltoast.com> wrote:
> 
> > Keeping kswapd running when all the failed allocations that invoked it
> > are satisfied incurs a high overhead due to unnecessary page eviction
> > and writeback, as well as spurious VM pressure events to various
> > registered shrinkers. When kswapd doesn't need to work to make an
> > allocation succeed anymore, stop it prematurely to save resources.
> 
> Seems sensible.
> 
> Please fully describe the userspace-visible runtime effects of this
> change?
> 

FWIW, it looks like the refcount API doesn't allow refcounts to be zero, so I'd
have to update this patch to use just plain atomic_t instead. But since there
doesn't seem to be much interest in this, I'll only send an updated patch if
it's desired.

Sultan
