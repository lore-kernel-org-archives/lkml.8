Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B1CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 848042078B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D8qbh/xQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbgHTLyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:54:09 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41354 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729897AbgHTLta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 07:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597924166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9saac307wOKfkkuwU6eXgFAqSu4oqXrr/wJpcDGuHPE=;
        b=D8qbh/xQPRhff33jRFuZI6J6lTCaIy7mmv24+cOB/+f1tTv661pXOzDKn0IIhk31GUgPd1
        ua10o/SzF5w9ianCBShQS6DRvlBq6iEuY2pGoKKeFPhV9eA3GHWAD9o/51Seh2T+H/FHZC
        8nB18ToRvgwhnjkL98o0eWpCf0vpbu8=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-cZc3r9bzMjKd4T2903xkCA-1; Thu, 20 Aug 2020 07:49:25 -0400
X-MC-Unique: cZc3r9bzMjKd4T2903xkCA-1
Received: by mail-pl1-f199.google.com with SMTP id y13so1429220plr.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 04:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9saac307wOKfkkuwU6eXgFAqSu4oqXrr/wJpcDGuHPE=;
        b=ZHMNCNAP963srqs+bqW/jdML+CjeqpdGMbxx803l+ITJYg6kI+mCbuaX+5kQ2QvzpH
         UX2tYP/VECExpS6I+rGCZB6tbq2S3fugf3b7EwEljiWm8wuDBliiq49mRF0WqL3MHx1a
         1Ekz/adbMYdB0+NNLKBZREdekGimzUy43RHzktrnDdgnY0Orz+euCpnyxNI9ihNziMbq
         VXpOxV6mN3P9FxBJ63wXixIDo2VZTdgjH4WDn6IS+oiAo5ruOgHtw9oP0krRFaQf5BHX
         yt6czpUlgS5v1tNncEb0n7EVMNLfm5x5faGya6B4acExrk11hKq9IUjKqePchD0wbZtw
         MAiw==
X-Gm-Message-State: AOAM533V8G1Oio7SGRT3HgIms2tdgCY1j2UKVCXMhe6mERVHqVZ4OifE
        vHxrAY3Gurc50Usggg8d63o1Z5t1z69BTjr23pXs6RVL/ucRfONtdW5LcqOwlHE6rfJHyth8WYI
        XWlUKN3iZKf1QSOxTLK+SNGF6
X-Received: by 2002:a17:90a:fca:: with SMTP id 68mr2139379pjz.12.1597924163736;
        Thu, 20 Aug 2020 04:49:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBjLpZdhtO7F74YwmOts0pQqOWh6y/Tz0vd4MXLA4VdNuTc/QS10DWsZj7Ckm0QBRZGJGSRA==
X-Received: by 2002:a17:90a:fca:: with SMTP id 68mr2139363pjz.12.1597924163438;
        Thu, 20 Aug 2020 04:49:23 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b22sm2671768pfb.52.2020.08.20.04.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 04:49:23 -0700 (PDT)
Date:   Thu, 20 Aug 2020 19:49:11 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Carlos Maiolino <cmaiolino@redhat.com>,
        Eric Sandeen <esandeen@redhat.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Rafael Aquini <aquini@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH v2] mm, THP, swap: fix allocating cluster for swapfile by
 mistake
Message-ID: <20200820114911.GA12068@xiangao.remote.csb>
References: <20200820045323.7809-1-hsiangkao@redhat.com>
 <20200820113448.GM17456@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820113448.GM17456@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

On Thu, Aug 20, 2020 at 12:34:48PM +0100, Matthew Wilcox wrote:
> On Thu, Aug 20, 2020 at 12:53:23PM +0800, Gao Xiang wrote:
> > SWP_FS is used to make swap_{read,write}page() go through
> > the filesystem, and it's only used for swap files over
> > NFS. So, !SWP_FS means non NFS for now, it could be either
> > file backed or device backed. Something similar goes with
> > legacy SWP_FILE.
> > 
> > So in order to achieve the goal of the original patch,
> > SWP_BLKDEV should be used instead.
> 
> This is clearly confusing.  I think we need to rename SWP_FS to SWP_FS_OPS.
> 
> More generally, the swap code seems insane.  I appreciate that it's an
> inherited design from over twenty-five years ago, and nobody wants to
> touch it, but it's crazy that it cares about how the filesystem has
> mapped file blocks to disk blocks.  I understand that the filesystem
> has to know not to allocate memory in order to free memory, but this
> is already something filesystems have to understand.  It's also useful
> for filesystems to know that this is data which has no meaning after a
> power cycle (so it doesn't need to be journalled or snapshotted or ...),
> but again, that's useful functionality which we could stand to present
> to userspace anyway.
> 
> I suppose the tricky thing about it is that working on the swap code is
> not as sexy as working on a filesystem, and doing the swap code right
> is essentially writing a filesystem, so everybody who's capable already
> has something better to do.

Yeah, I agree with your point. After looking into swap code a bit
(swapfile.c and swap.c), I think such code really needs to be
cleaned up... But I'm lack of motivation about this since I couldn't
guarantee to introduce some new regression and honestly I don't care
much about this piece of code.

Maybe some new projects based on this could help clean up that
as well. :)

Anyway, we really need a quick fix to avoid such FS corruption,
which looks dangerous on the consumer side.

> 
> Anyway, Gao, please can you submit a follow-on patch to rename SWP_FS?

Ok, anyway, that is another stuff and may need some other thread.
I will seek some time to send out a patch for further discussion later.

Thanks,
Gao Xiang

> 

