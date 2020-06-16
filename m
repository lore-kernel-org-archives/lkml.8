Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D5FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 20:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28A4B2078D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 20:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="flPVcLwI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731782AbgFPU3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 16:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgFPU3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 16:29:19 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63343C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 13:29:18 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id e8so4359571ooi.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 13:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=jyPggzZv8VCGivaCuAFS5PLAgo7RpCZi3OBdD1gwUbA=;
        b=flPVcLwI8gnvMfXVRNbVEJqUavqPue+QjklHJXPQpLlK6k++mnVa0GZXHcJIq57gH9
         8Jv1exnXrPkmHXNDO8qh1vVMUE0YiW8VNsJMR4y+c0tKlj0FzjLpr960BL0hn/hTMQSb
         xd00yXAVeExAPGODLd+qBa4yw02HiZII8b/fsGpFOv1EC5BmGJOXsT6DtNAbDy0oF2oR
         jo2Lj9EU8g0S7OpQ9acAdhyUFkdWYP51XrrEhD1mWCvy/YQUfGEYbhhtwopo8kSIEMuW
         5k16rMe3e7/bIwzLG6IHtfFO6WpvVQWZlXK+9TatXRDDd+SmPNyIFgWD/CoGTBzwidgf
         h82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=jyPggzZv8VCGivaCuAFS5PLAgo7RpCZi3OBdD1gwUbA=;
        b=VVmyDs1fKCbBev+A/mM2tO55xExvarZO6ap7VfjCY0QrEUbxZ0bGobPhba/3aa3Obr
         4vL3uZTQvsaT3/ku0cxy5/k2vd19BNtiUxXRAJT89btakxZiB4Us1iXcOX6zcw9e8GoT
         plCH7k80ASOPnSBMW443HeILjImNnCciSD8D6DMXsmEsxWjS+yZ8LOaOXCLinUs+uhpU
         nyk5v5oG5g5z8cche/jCFClVOvZgbCjoFLHbLxpiTWFnDwFwclv9kqKrqyp4BwW/fBoY
         +1Xh7djqHkdyz60Se/gDy9Dem8RXIQyl4+/FbgLkGcB69Evn901nGn28v+z4nUTob1w9
         rj2w==
X-Gm-Message-State: AOAM532PAncuhnFHSVMM4Up8/Q1ItkMbZY00FlWxg3JQbU64JmqGqNL5
        SeQYxX9e5X48swNwAWYzHaEc3GbDhe8=
X-Google-Smtp-Source: ABdhPJzMYPbcuFOwOPomE3YNa4+25hJDx36Tn/T4Kmez4WBptaadokkxnblUUtOAc4F982FOWYusYg==
X-Received: by 2002:a4a:d1ca:: with SMTP id a10mr3925663oos.31.1592339357430;
        Tue, 16 Jun 2020 13:29:17 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id k8sm2642811oik.31.2020.06.16.13.29.15
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 16 Jun 2020 13:29:16 -0700 (PDT)
Date:   Tue, 16 Jun 2020 13:29:14 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     akpm@linux-foundation.org, alex.shi@linux.alibaba.com,
        hughd@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        liwang@redhat.com, mgorman@techsingularity.net
Subject: Re: [PATCH 2/2] mm, page_alloc: use unlikely() in task_capc()
In-Reply-To: <20200616082649.27173-2-vbabka@suse.cz>
Message-ID: <alpine.LSU.2.11.2006161319030.1119@eggly.anvils>
References: <b17acf5b-5e8a-3edf-5a64-603bf6177312@suse.cz> <20200616082649.27173-1-vbabka@suse.cz> <20200616082649.27173-2-vbabka@suse.cz>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jun 2020, Vlastimil Babka wrote:

> Hugh noted that task_capc() could use unlikely(), as most of the time there is
> no capture in progress and we are in page freeing hot path. Indeed adding
> unlikely() redirects produces assembly that better matches the assumption and
> moves all the tests away from the hot path.
> 
> I have also noticed that we don't need to test for cc->direct_compaction as the
> only place we set current->task_capture is compact_zone_order() which also
> always sets cc->direct_compaction true.
> 
> Suggested-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Hugh Dickins <hughd@googlecom>

Thanks for pursuing these, Vlastimil: I'm glad you were able
to remove a test and branch instead of adding one as I had.

One little thing, you've probably gone into this yourself and know
what you've written here is optimal: but I'd rather imagined it with
"unlikely(capc) && ..." instead of "unlikely(capc && ...)" - no need
to respond, please just give it a moment's consideration, Acked anyway.

> ---
>  mm/page_alloc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 48eb0f1410d4..8a4e342d7e8f 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -813,11 +813,10 @@ static inline struct capture_control *task_capc(struct zone *zone)
>  {
>  	struct capture_control *capc = current->capture_control;
>  
> -	return capc &&
> +	return unlikely(capc &&
>  		!(current->flags & PF_KTHREAD) &&
>  		!capc->page &&
> -		capc->cc->zone == zone &&
> -		capc->cc->direct_compaction ? capc : NULL;
> +		capc->cc->zone == zone) ? capc : NULL;
>  }
>  
>  static inline bool
> -- 
> 2.27.0
> 
> 
