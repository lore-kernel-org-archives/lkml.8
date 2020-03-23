Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA938C54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 992782076A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="I8nEQQSW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbgCWQvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:51:14 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46010 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbgCWQvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 12:51:14 -0400
Received: by mail-qt1-f196.google.com with SMTP id t17so2119853qtn.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 09:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LWBMOpdQ6RM6tzOn/8vWjeIgj8g8a5I1STuJsGCjRo8=;
        b=I8nEQQSWkjtHSqP1oR4eghgEG3cRUnPlE+gN/nLMpRir0NoJuL2+OW3Ih9ju54o1mp
         AHaALAKLIoIOXw3pyp+wb+fJADkm3tYqh79N43FfTLB1ikS2bppY8ZfEK12nDPlFafTR
         afvhXue9Jb+JdKlFwqQUl7+WlJ4l6hBwCpYmW2Y9CVnf27BQDsCNeFCqRTsDzKw+Um4T
         Kow9JvP65D9EhMJ0W7QNwbOxXYn/7byquVJrjEazzOPYurkG1c7A0JhF+VGWJzaw64hJ
         Okj2CwJ0nbbDIQ4KtMeCRus9UkOVuaENlWnzezFt2qWFp1nNrsSfj+rMW0+cHuC5+4qQ
         dDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LWBMOpdQ6RM6tzOn/8vWjeIgj8g8a5I1STuJsGCjRo8=;
        b=ioyvttyH1/mbUh4Xp/WW84mQYGQrgVbUZJI76NdaV+9EC9D7zL9rqmvYwsHYcL1qk3
         bMwK7AFQ3mlhT+ffiWM43CyA/NqAwrRgGukR3TcIs23XxSA+T5ES2qL0x9YV4hQNQIEO
         cbknzvX20ucN3H9D2oMBQ0mHF9DIQTZLvvp7piAIT3KfkKoRpPAAMT/EUASTpYRF86F8
         uragmhc9OXYfh8ihB9oVi5BE65dJzC826jnNaFaBkwTgglcGquKo+InXELAbEIt+BfhQ
         YVExMfIGrQEo2xaKD4oFBAayK39tsE5ia4oBueCNqKnC5JA4bX8bx5Ksu9mvCcRfFP7e
         qDcA==
X-Gm-Message-State: ANhLgQ1lEHdySY5JNesmnK7cuWy/Oj0adztecsj6NgK17QUAjC7b93DF
        uz6/FnkFFZeLIILZQ8RJFgdcU3T+xOo=
X-Google-Smtp-Source: ADFU+vsVno42d9S3diBfWFL38XIfIgaPdPcxiMkRilrh1GpMhoHWHq7xqGvY4ajHi7WGL965oPHLWA==
X-Received: by 2002:ac8:6043:: with SMTP id k3mr22532957qtm.336.1584982273059;
        Mon, 23 Mar 2020 09:51:13 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a9a9])
        by smtp.gmail.com with ESMTPSA id l45sm12547211qtb.8.2020.03.23.09.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 09:51:12 -0700 (PDT)
Date:   Mon, 23 Mar 2020 12:51:11 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     js1304@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v4 5/8] mm/workingset: handle the page without memcg
Message-ID: <20200323165111.GC204561@cmpxchg.org>
References: <1584942732-2184-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1584942732-2184-6-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584942732-2184-6-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 02:52:09PM +0900, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> When implementing workingset detection for anonymous page, I found
> some swapcache pages with NULL memcg. They are brought in by swap
> readahead and nobody has touched it.
> 
> The idea behind the workingset code is to tell on page fault time
> whether pages have been previously used or not. Since this page
> hasn't been used, don't store a shadow entry for it; when it later
> faults back in, we treat it as the new page that it is.
> 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
