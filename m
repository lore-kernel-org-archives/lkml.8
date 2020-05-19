Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBA6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 06:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D1E02075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 06:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=unikie-com.20150623.gappssmtp.com header.i=@unikie-com.20150623.gappssmtp.com header.b="gg2IMSyU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgESGAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 02:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgESGAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 02:00:44 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62056C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 23:00:42 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id c21so10141682lfb.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 23:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unikie-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6KzCFnBysx4f+SYXFrhJOfuSGyFAARDihLujrLqLhHI=;
        b=gg2IMSyUwj+ggi0vwse5+yIqvCKIt5mNtYP74zuvPh+TMb+1c3FQPwG1HRN2fkoHRA
         OmELKqyTaPghxxwwe5VHtsR26GGKMgBvalifw1O+GSSNkvw+a8dFVqZFbboS9tG+Gqau
         HvSCuyr0NszUhJGcZTTchqiWrpEU/bau4zKxl5SOYuNgiMbEKtb0IxifXWkycvIeqzL8
         UebwQR8f3C+TCvh3rtQKD5+VZVLinVWOef95AZ3b6ANNbkuDTKN8WOyWJk949ftNms2K
         uZRdj0zwUtOx2Bva0jvbK8mnEpUSh+oyX2UQo7je6BmAJSRsawolCdOl7cteqy0aIFQL
         kRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6KzCFnBysx4f+SYXFrhJOfuSGyFAARDihLujrLqLhHI=;
        b=tUhcSbeOzkPn3XfvPPOwBtAAvhMiidrizoE1DGF7X4W7lA65XjPjHYH9Z+e1MLFm4R
         ix6Ap/vVWDtleiPkxpExwIwnhZsiDihGD7eE+SwPXsoN6UpjoGetIX+FaaJW5MYDdP3F
         YRkdUb4haQslSvKirLNDSSMyErSZ4iILgPioUMEV/IUg6PSkolOqAk1e37Y6wGv1TWz9
         je0VG3dq6gNeyMvYOdv7+yFVCmO0PZN93E93nkkt8YDrQCau5jyXwlbeGH48BUlKcEto
         WOuhhg8Pi5gaYpVpsYVsExOB1sHQIyxj9O47tI3SIheLwK5Z9tirTN2s4FayaacUewD0
         gDkQ==
X-Gm-Message-State: AOAM530cYXr3AbqNf1ZMSKLcjJdnCjlXTyhl/veH3DvExfCGV3CMkrFj
        RgSnh6l1s72oo3sx/Dci4gu11w==
X-Google-Smtp-Source: ABdhPJyyLpBOcLYYQNPI6jD+RvQfGKDpqKyzETt2AanQcX4wtGv5uyEi6P6SkWtOAuQ/aqziNW4A8w==
X-Received: by 2002:a19:4b12:: with SMTP id y18mr13978660lfa.169.1589868040431;
        Mon, 18 May 2020 23:00:40 -0700 (PDT)
Received: from buimax ([109.204.208.150])
        by smtp.gmail.com with ESMTPSA id m13sm8329898lfk.12.2020.05.18.23.00.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 May 2020 23:00:40 -0700 (PDT)
Date:   Tue, 19 May 2020 09:00:38 +0300
From:   Henri Rosten <henri.rosten@unikie.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Giuliano Procida <gprocida@google.com>, lukas.bulwahn@gmail.com
Subject: Re: [PATCH 4.4 63/86] block: defer timeouts to a workqueue
Message-ID: <20200519060036.GA28441@buimax>
References: <20200518173450.254571947@linuxfoundation.org>
 <20200518173503.131794977@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518173503.131794977@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 07:36:34PM +0200, Greg Kroah-Hartman wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> commit 287922eb0b186e2a5bf54fdd04b734c25c90035c upstream.

I notice 287922eb0b18 has been referenced in Fixes-tag in mainline 
commit 5480e299b5ae ("scsi: iscsi: Fix a potential deadlock in the 
timeout handler"). Consider if backporting 5480e299b5ae together with 
this 4.4 version of 287922eb0b18 is also relevant.

Thanks,
-- Henri


> 
> Timer context is not very useful for drivers to perform any meaningful abort
> action from.  So instead of calling the driver from this useless context
> defer it to a workqueue as soon as possible.
> 
> Note that while a delayed_work item would seem the right thing here I didn't
> dare to use it due to the magic in blk_add_timer that pokes deep into timer
> internals.  But maybe this encourages Tejun to add a sensible API for that to
> the workqueue API and we'll all be fine in the end :)
> 
> Contains a major update from Keith Bush:
> 
> "This patch removes synchronizing the timeout work so that the timer can
>  start a freeze on its own queue. The timer enters the queue, so timer
>  context can only start a freeze, but not wait for frozen."
> 
> -------------
> NOTE: Back-ported to 4.4.y.
> 
> The only parts of the upstream commit that have been kept are various
> locking changes, none of which were mentioned in the original commit
> message which therefore describes this change not at all.
> 
> Timeout callbacks continue to be run via a timer. Both blk_mq_rq_timer
> and blk_rq_timed_out_timer will return without without doing any work
> if they cannot acquire the queue (without waiting).
> -------------
> 
 
