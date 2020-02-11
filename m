Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F909C35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 03:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB1CA206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 03:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581393015;
	bh=KlTBGHzBwEEpW5M1NxWMEwp4ci+LaUkSpctlqT3gaoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=U1Y+LsHAoEXXeICN9lESI48CtQkQgTXFyIMkDYyRRwaCwI/MaaVr6Lh/tbF8vYcyb
	 MTW2jyTKwSaTMrvf19dAWvmhuPoT3EAOpIwdtFAzssJAtCOb9AbMTHbgRhaF0Ucc/o
	 L2G1v9RJNcpbwUgwyCVg2pq4kTBD5SmewupSmOnU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgBKDuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 22:50:14 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:34931 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbgBKDuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 22:50:14 -0500
Received: by mail-pj1-f68.google.com with SMTP id q39so650297pjc.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 19:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3nqU/O+TdSRMSc5Iylpi8VTithOiRFDrm96y3sARYI8=;
        b=UTmr/EQuGdLNwCEGo3xt2whj2Yp4ofvsR+3DHJ7aVQ8p/ULL5OMNfxyp5IEnQIho2u
         LO+fd3c6YenOeygz1cI14DtDIG+zN7p9dGXhVoOEziuLFScOIE68s+BGISEdEOV0YUvS
         cLbJhnG1ZkEsf41lZZbvwUZenwkvDv6Fy+pxK+v8X91/2BR/8EHyKoRpRkQM1KmAMxzA
         z9Zgo8K+2c+1QzdiiMSh/OCq1h3UljUfsBL+TcIbfSfTtfygy1XL/ckU195GDeOd9n8C
         nDwnLaRgcAQji405YM4nPYkGlpZsg3iIAGZS9X19QjdWDtuO7iCY5UrIlt2uYOG+hRwN
         XUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3nqU/O+TdSRMSc5Iylpi8VTithOiRFDrm96y3sARYI8=;
        b=SDIIyE3VyjCk3jxABFOK258EEebe4Bkw7Km1/+HfBrWb7cJUDeRi4CWIEgszUgVw2X
         tHs2tyIpYaOUKqUpESgxCepBHoltBgXSJPVItSrojurDocfpWATi8cSBENlCykcCOJ8V
         zcdUFGtntzEWBj0NHmNMFwyjfB3fZLsuji7kwhShVNo4uHMZSLgcu4Yojp+T7YDK478e
         pRzgjSn+sCGfZLesQ+INKxVW+mMMgSzzZMP+/Ir7ZyLmCtaiFvAeA45jty6/5NdIVpUh
         Hdb374Tzm9yzU/f610oqwcyGLh4XizaLZ2mjfy23vOuUMMh38lB0UfhyLRuPw2Oxmsjs
         VMnw==
X-Gm-Message-State: APjAAAUo8L6tkQZwPJ5q5KpnIfuhISAkQC9wJ6ptNPTkJppL/2LRycud
        X3g+yUwJtNR3ODsvgM+SlQPA00aJ
X-Google-Smtp-Source: APXvYqzyPQ4s8RFroOe8AaydMzrU2A1MfwzgXDPCfacBXUeMfGbzaCVJHpi/MDUaQjcrGclvQkMvXA==
X-Received: by 2002:a17:90a:e291:: with SMTP id d17mr1375367pjz.116.1581393006817;
        Mon, 10 Feb 2020 19:50:06 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id e38sm1520811pgm.82.2020.02.10.19.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 19:50:05 -0800 (PST)
Date:   Mon, 10 Feb 2020 19:50:04 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix long time stall from mm_populate
Message-ID: <20200211035004.GA242563@google.com>
References: <20200211001958.170261-1-minchan@kernel.org>
 <20200211011021.GP8731@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211011021.GP8731@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 05:10:21PM -0800, Matthew Wilcox wrote:
> On Mon, Feb 10, 2020 at 04:19:58PM -0800, Minchan Kim wrote:
> >       filemap_fault
> >         find a page form page(PG_uptodate|PG_readahead|PG_writeback)
> 
> Uh ... That shouldn't be possible.

Please see shrink_page_list. Vmscan uses PG_reclaim to accelerate
page reclaim when the writeback is done so the page will have both
flags at the same time and the PG reclaim could be regarded as
PG_readahead in fault conext.

> 
>         /*
>          * Same bit is used for PG_readahead and PG_reclaim.
>          */
>         if (PageWriteback(page))
>                 return;
> 
>         ClearPageReadahead(page);
> 


