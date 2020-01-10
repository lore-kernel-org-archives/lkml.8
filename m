Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44B2C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 23:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 868C72077C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 23:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="ZJEDO0YS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbgAJX4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 18:56:39 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42293 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbgAJX4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 18:56:39 -0500
Received: by mail-lj1-f195.google.com with SMTP id y4so3856261ljj.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 15:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IAXX3JDfW91L1oFBIls8QdCooR7SfK5C1si/SVwg03w=;
        b=ZJEDO0YSgA77ITGYIDctyb0EOae3X0E9DZsrCSD/137Q3wBqPH6xelTolj5I+N71/m
         5okd9DsJlWyaN1rsC3T919/aHllzar6Pnp4CeoJCFftfC/HxvuIYfoOCgqcRVjx+4g1/
         bQuCMoS5FuERQc0oHq+lqFBEPrMGhXsiZEb9NZl/XRJlIVzJKMYMZMa89dSO0w/8e5fp
         aJz4V0v9uMWruuU74+yNtL2YiDQ9r72yMWVR/x42Fu1X1yKuo+6ChgY0YVt9IdI8Qx72
         rnZjO15pE/BaQphl6RgkxTalDUEhDYoyEKHlIOBfN4f2NlhTBpYsPzwBWvRguNWa8/ZP
         SLEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IAXX3JDfW91L1oFBIls8QdCooR7SfK5C1si/SVwg03w=;
        b=mP+vTwIa0tjHjGIdERctetO3fPKKmDa+Q93P99nnPKfELuCB2LRJ8JhDfRGgVKDlyS
         b5sasf470HCgKfEBCkkBGzGLC4AJ+iCn6uHY8oR76801vsEhOPtM1IvnajlciEzn8MYT
         P/t3KX1oQhxql2InIyDEltdbLviQkFYJrikaxY/7QP9pE1DYVtrssr/tLUydlTZwqMVZ
         fbtQC/hRmGt/LuLEjMtyGipmdP4biBpjv1zeFVKtKQPm264lwsCSljXK+azwKCFR8vjZ
         qvqqjprFtSx2fdIRtG/8QKpiTBwF0j6ygpGAeSuCGZ1cpzopike4H9q91V/C6cfbE0Hc
         /h3Q==
X-Gm-Message-State: APjAAAXg6ly3TOarHO7cY2Wnno3KEohiljOwvW3rSnZnjg9A/nxb1MB9
        j0FUFOAyRYrtsOf56aFiH+hLB+MchrM=
X-Google-Smtp-Source: APXvYqyYnIVVGBQ0KU6ZYtLcMk4lwa3fxOsd1TpsJHLhRA96yRkEYjF9cTgjcd/1b4ELB7gGiTiejw==
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr4142551ljj.97.1578700597199;
        Fri, 10 Jan 2020 15:56:37 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id z5sm1673807lji.40.2020.01.10.15.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 15:56:36 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 74CCF10144E; Sat, 11 Jan 2020 02:56:37 +0300 (+03)
Date:   Sat, 11 Jan 2020 02:56:37 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com
Subject: Re: [PATCH 2/2] mm/huge_memory.c: use head to emphasize the purpose
 of page
Message-ID: <20200110235637.ppkb6iecd4ayiqr5@box>
References: <20200110032610.26499-1-richardw.yang@linux.intel.com>
 <20200110032610.26499-2-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110032610.26499-2-richardw.yang@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 11:26:10AM +0800, Wei Yang wrote:
> During split huge page, it checks the property of the page. Currently we
> do the check on page and head without emphasizing the check is on the
> compound page. In case the page passed to split_huge_page_to_list is a
> tail page, audience would take some time to think about whether the
> check is on compound page or tail page itself.
> 
> To make it explicit, use head instead of page for those checks. After
> this, audience would be more clear about the checks are on compound page
> and the page is used to do the split and dump error message if failed.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
