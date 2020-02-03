Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C5EC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92EE2080D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="mFABLiRZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbgBCQNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:13:43 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45757 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgBCQNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:13:42 -0500
Received: by mail-qt1-f195.google.com with SMTP id d9so11803684qte.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 08:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5ZPjQ9pyWegFq7ptB0Of0FuoHr1kyVa2z4FlXuSnJwU=;
        b=mFABLiRZqHMCt0JZs8/Rt/DmWcHMcqdBw8N/uq0D0YvB/GxaEgpyrz5As2bHwWTXcg
         HoUT2W956XCzqcOsNRC9CYjBV9AQ4jpXQw9DHxWeH393UFWJwPFPc2urzoyv/1v1IgN0
         kRxR7qcK4KfpcTsQl6F4J95BKmAmSS4PEZpFtjD0fTirNC6zVPnwoCTFgBSbPPmd8FPh
         YU0jY5dQMjjVxRilvrXBNTPCTcS+8OKNw7peUyihgtkj1Ucg9WOQZWPgt1iMe7bJVFh7
         C9nfuPz4Z73Z44YqJJizsoRkdx2juj5yx+z5mjUu8yrviZcBM8U4SLLW1g0IevhHjWZs
         fe6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5ZPjQ9pyWegFq7ptB0Of0FuoHr1kyVa2z4FlXuSnJwU=;
        b=KjQajH+qYeEM5X2VzdCjeL90g7NPTnTMA3LPB9MpGal9nXq6m8CdmwJhaDYorOVF1s
         Zj/JXYqjPG+hldj0hYZxCFEqsF1RuVUUGC+e0owcjRO5X1CqdEZVfFaC5hPCbVdYGuZa
         Kd5Hro5oZM/XzqmDUHPlcTP1SFanM2zT/HgEbQXxZ8AB92yq4f2HrjLc7KEoD0OXVfxa
         Yr/mkDXeI0YLzUFigWGGU0kM7r5lib4o/fm8kkk0ch0SffkAtG7aqxKLIaZDge2MxXv8
         uMVO8fGcpBZeb9Wir1Hgp0q6u/8roRGLMea9Z2BqsqU16vqlLfhy18CSY37TVIMdf0WG
         LLqg==
X-Gm-Message-State: APjAAAUfvs3LdTbzLUjifgy3TKjfcd/gkrn1CprHAwy7doFqGYvAxKuh
        7azt+UvDOIA/AE51t6zu4iag+Q==
X-Google-Smtp-Source: APXvYqwjdR9TVx4GU6B5klThIt/F+G0GrsNyifcGvXkPp7QKBRII6lMLqucHhw8EzGWEJEXGddLyLg==
X-Received: by 2002:ac8:7952:: with SMTP id r18mr24493028qtt.251.1580746421743;
        Mon, 03 Feb 2020 08:13:41 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::3:c810])
        by smtp.gmail.com with ESMTPSA id d25sm9333054qka.39.2020.02.03.08.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 08:13:41 -0800 (PST)
Date:   Mon, 3 Feb 2020 11:13:40 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Bharata B Rao <bharata@linux.ibm.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v2 09/28] mm: memcg/slab: rename
 __mod_lruvec_slab_state() into __mod_lruvec_obj_state()
Message-ID: <20200203161340.GC1697@cmpxchg.org>
References: <20200127173453.2089565-1-guro@fb.com>
 <20200127173453.2089565-10-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127173453.2089565-10-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 09:34:34AM -0800, Roman Gushchin wrote:
> Rename __mod_lruvec_slab_state() into __mod_lruvec_obj_state()
> to unify it with mod_memcg_obj_state(). It better reflects the fact
> that the passed object isn't necessary slab-backed.

Makes sense to me.

> @@ -1116,7 +1116,7 @@ static inline void mod_lruvec_page_state(struct page *page,
>  	mod_node_page_state(page_pgdat(page), idx, val);
>  }
>  
> -static inline void __mod_lruvec_slab_state(void *p, enum node_stat_item idx,
> +static inline void __mod_lruvec_obj_state(void *p, enum node_stat_item idx,
>  					   int val)
>  {
>  	struct page *page = virt_to_head_page(p);
> @@ -1217,12 +1217,12 @@ static inline void __dec_lruvec_page_state(struct page *page,
>  
>  static inline void __inc_lruvec_slab_state(void *p, enum node_stat_item idx)
>  {
> -	__mod_lruvec_slab_state(p, idx, 1);
> +	__mod_lruvec_obj_state(p, idx, 1);
>  }
>  
>  static inline void __dec_lruvec_slab_state(void *p, enum node_stat_item idx)
>  {
> -	__mod_lruvec_slab_state(p, idx, -1);
> +	__mod_lruvec_obj_state(p, idx, -1);
>  }

These should be renamed as well, no?
