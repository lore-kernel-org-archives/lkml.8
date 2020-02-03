Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818B3C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 584082166E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="M+dBjUlD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgBCSAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 13:00:31 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35130 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728097AbgBCSAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 13:00:31 -0500
Received: by mail-qt1-f196.google.com with SMTP id n17so10998075qtv.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 10:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wdj5tmwIO7fxCz8UnDnfa7K1klbEEPxhOInltF7ScW4=;
        b=M+dBjUlDoBYWgPsybUxws18GQBpTHTdNOra53zF3nDvUJEJ5HUbulam9LVJHgVbq5J
         SOfL6WOuY6N8nSuehf2NrL0HVUTlSNFwYGhVZBj6Fq6oueEXrGjBPVfgxNzP5FLpjLEM
         f6fzKkkEUa8iQYaXAlgB38/l8rbaMCOLHJywbHx9XfmFpb/reI1xas3ENvRpcBFkBjnt
         Tg/hlY1lYllF+rsc1W/WX/PPizv/Gypq9aiWpu3F9swdovbsqYkyl14eoSFft2H9KOoB
         XJUoyh0lbbDSgrsWbpeJmWexEAVs5Kga5y/0pEM3yHwV1giVFM2LG3eKxwY40JOX9R4b
         fUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wdj5tmwIO7fxCz8UnDnfa7K1klbEEPxhOInltF7ScW4=;
        b=aYPUBhFus36qwwJc6axs8LyaqTPBuwu9/LEGBy+8La7GO/fciW0LMSA439N6TDrrNi
         T7nWaGFyml6I12gx7o6yOqeIFeEslFwb/toaw/RvftvUo1zzsvcJuCOesrVbjRDPpew9
         Cxh4cw1id3PX/lnO5C7RfKb9ywFg3XSjTNPjtM3mqbTEQMUpr+3XiAmIiDXLgI0IaG2t
         e08CYq+uAendus89mpo+PBtY8eL329OhXXznAzkmHYUhVDSsK5A4r+pEDZrEoQM+oOEt
         vtCJCxZasjfsjRFoB1cWEJ2FaOCHeQ/iJy84pLlS8WgJJWAw6iATPRgFDKsxExRv5T3k
         rn1A==
X-Gm-Message-State: APjAAAXV1z0eQ00Fim9etgv5zMjCIxlqCzEdtjksIGkjWtYdnkdO3/YO
        elDroLbHKcAvMaz4Mh7ciI5LQw==
X-Google-Smtp-Source: APXvYqxc29YPvC+A7tQjkB+2R3KeT8ErIusoa6YKscpcxv4onRrfRMdtkYsTy9diLVt9VQBHhytyow==
X-Received: by 2002:ac8:607:: with SMTP id d7mr24565557qth.271.1580752829730;
        Mon, 03 Feb 2020 10:00:29 -0800 (PST)
Received: from localhost ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id k4sm9665676qki.35.2020.02.03.10.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 10:00:28 -0800 (PST)
Date:   Mon, 3 Feb 2020 12:58:18 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Bharata B Rao <bharata@linux.ibm.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v2 12/28] mm: vmstat: use s32 for vm_node_stat_diff in
 struct per_cpu_nodestat
Message-ID: <20200203175818.GF1697@cmpxchg.org>
References: <20200127173453.2089565-1-guro@fb.com>
 <20200127173453.2089565-13-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127173453.2089565-13-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 09:34:37AM -0800, Roman Gushchin wrote:
> Currently s8 type is used for per-cpu caching of per-node statistics.
> It works fine because the overfill threshold can't exceed 125.
> 
> But if some counters are in bytes (and the next commit in the series
> will convert slab counters to bytes), it's not gonna work:
> value in bytes can easily exceed s8 without exceeding the threshold
> converted to bytes. So to avoid overfilling per-cpu caches and breaking
> vmstats correctness, let's use s32 instead.
> 
> This doesn't affect per-zone statistics. There are no plans to use
> zone-level byte-sized counters, so no reasons to change anything.

Wait, is this still necessary? AFAIU, the node counters will account
full slab pages, including free space, and only the memcg counters
that track actual objects will be in bytes.

Can you please elaborate?
