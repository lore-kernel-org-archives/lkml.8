Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1F8C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FDF620752
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="m4IwnX1r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgCRRpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:45:44 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33033 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgCRRpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:45:43 -0400
Received: by mail-qt1-f194.google.com with SMTP id d22so21510518qtn.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 10:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rl1b6YsGtBJ3kOtNa0WFcM2DTHbfoy2KmOV32IqCN6M=;
        b=m4IwnX1r7ptkHEQp8cCRIvLRK4qk3fGLYPnHlbCgubUCeCJX02T5YBzaFCQ+dKgRDv
         3IbSIdwhuzgBII/5GDiJqKNBs/4PHxH0vhLn/ZrmBmZSRQSDPe35udC4jvstH2ONraC5
         SApIJsEotVmsVQ219uqJRpUfi8e3BjCKd7GY+xWcw5vnv3FmuzJ4GXnEvuwF/IwaaYOD
         AcfwyyjwWyS1y5fSE4aWBMl6jAOgFMfB3VncDtQWEL+jsk1fdqANIIIJOgj9SPpRlxYf
         /bbExpzoJxulmE9xqrl303wkC8zXKywiMzWr6Zd2OA3F3KI4SFcS0rK5pwtlF+x5uY4p
         1c3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rl1b6YsGtBJ3kOtNa0WFcM2DTHbfoy2KmOV32IqCN6M=;
        b=WHjACgRX9BdAF3esdKqnn5k67WzEjL4p1L0S6p2lr6bCmT8rARdeAXmvN8VKp3ZiEA
         VAif/HrmHBpVfi18Fe6KRR8cM5lP/SuWDm7YJq+oYa4O90v7PR95hltSyND4dXQ9G+hy
         m7SjliklHq6w+rQKET7iomsiZ3BUBuUw5laiAOEswzvsPXtdlBeaJX7pFgnddXhrYo6J
         YWmShLpixDOZTwpydcDljUmPEHDMUwPvlwXUWnELh3Mq/UPmtqw25yL7Y7MMLoNjxOYp
         khpCFU5J9qR+h83AKuws8TTEpUjiue0Cpti2eJQpqEWGbmkZj2QawxQUy3a+asy50Avr
         Xzyg==
X-Gm-Message-State: ANhLgQ3djxWkPy9i+PBAAZusyk9ggvA039LuSla8BjrXXD2OWIBw07VH
        3mlauu9BhhK8geUXG1R9WfQ9XQ==
X-Google-Smtp-Source: ADFU+vsfKn0pQfH0EAmid/5E8Mr64khvU8AUJGk6+wGnA2d81z/i63l57gULHPDlQdBxUYt+INIO+Q==
X-Received: by 2002:ac8:3488:: with SMTP id w8mr5648485qtb.187.1584553542277;
        Wed, 18 Mar 2020 10:45:42 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a9a9])
        by smtp.gmail.com with ESMTPSA id t71sm4678137qke.55.2020.03.18.10.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 10:45:41 -0700 (PDT)
Date:   Wed, 18 Mar 2020 13:45:39 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     js1304@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v3 1/9] mm/vmscan: make active/inactive ratio as 1:1 for
 anon lru
Message-ID: <20200318174539.GA154135@cmpxchg.org>
References: <1584423717-3440-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1584423717-3440-2-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584423717-3440-2-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 02:41:49PM +0900, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> Current implementation of LRU management for anonymous page has some
> problems. Most important one is that it doesn't protect the workingset,
> that is, pages on the active LRU list. Although, this problem will be
> fixed in the following patchset, the preparation is required and
> this patch does it.
> 
> What following patchset does is to restore workingset protection. In this
> case, newly created or swap-in pages are started their lifetime on the
> inactive list. If inactive list is too small, there is not enough chance
> to be referenced and the page cannot become the workingset.
> 
> In order to provide enough chance to the newly anonymous pages, this patch
> makes active/inactive LRU ratio as 1:1.
> 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
