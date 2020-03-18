Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A343C5ACD9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D251320724
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jvwZwXXB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgCRMPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 08:15:06 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38099 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbgCRMPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 08:15:06 -0400
Received: by mail-qk1-f193.google.com with SMTP id h14so38225564qke.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 05:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JtFXIfIE3pIhsgNz5a2Tc68ESm0JIZ+L7JiGzETmzNE=;
        b=jvwZwXXB/uqCF8yPkz7NyKvPz4BuL1Iz9UcqkYw93vszZJnrvUaCGtoSlvnfEOOdPH
         XiQFYIOhsU8s+SjXT3HwWRpTtWkfSPAEHs3ObZkPlxCL7KN49qEovMOd5ZG7eGQMTx6U
         cMKXqkD3IcjO57ExTFkXbIiJRLSTFNnXkbmmJHVXM104i1SIrsWZQeMlWhNQIaOF67Dz
         QMF9gcnU0EwtBv3b5VvPJHAT4xzwCaV7404g6EtmsawjPtkJrmu1Me2L6vH7ahxK5+Gc
         MDhAPYcAWWCjgSYhIF4yynBwAv7U0OcGqbR7y2i0w5g6W3leSv9I4/Wj7ub2DiMAqd3B
         1+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JtFXIfIE3pIhsgNz5a2Tc68ESm0JIZ+L7JiGzETmzNE=;
        b=W5ke+wTkegEzDZS7VqyOzl3uaJ/UjI/muz8T9N7Ay/OND+5BBIWZIY9aBCxvPDqZyz
         xnv3caKbjZi1XN+H4MKNfq5puIrH+njAqFmK1Bxl1hv2OJCDGs9tXqtki5z7fu5L7zb8
         uyhDj8fOlJFj+x+pJgLcmhHw2I8zGUQuRaGPefFUwTjfwm5wgdco9ySMeGzGxyE7u/gE
         oBulmrJRWOtlX5TJK6e2Caoa66M/946dm+ushJ/w7CU1nd7ruDWLPLpmFHG274pAeM2T
         xKXukZQZcd+HQ1VSFgRZWyPK/iLpxWaQWeV0UsBDnufXTVM/rWPzhZLhtoBgWysjzlIo
         m7ww==
X-Gm-Message-State: ANhLgQ2/W+3vUW8OXnFf7p+wtesCzqMYD3289nfA7Vy/1P6HclZTMd0+
        rqSmqG6sx9zsVIMxOm83KPlWTg==
X-Google-Smtp-Source: ADFU+vtjjsOeFEoMC78iy2foUC8bNyQw3C4AqPG0xwLV9UcU+lPoMnjaKFzJDACesBiP1bV6BQMRQg==
X-Received: by 2002:a05:620a:84d:: with SMTP id u13mr3705543qku.94.1584533705141;
        Wed, 18 Mar 2020 05:15:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id s49sm4525733qtc.29.2020.03.18.05.15.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Mar 2020 05:15:04 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jEXbC-0003dR-W7; Wed, 18 Mar 2020 09:15:03 -0300
Date:   Wed, 18 Mar 2020 09:15:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7 2/3] mm/gup: fix omission of check on FOLL_LONGTERM in
 gup fast path
Message-ID: <20200318121502.GA13926@ziepe.ca>
References: <1584333244-10480-3-git-send-email-kernelfans@gmail.com>
 <1584445652-30064-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584445652-30064-1-git-send-email-kernelfans@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 07:47:32PM +0800, Pingfan Liu wrote:
> FOLL_LONGTERM is a special case of FOLL_PIN. It suggests a pin which is
> going to be given to hardware and can't move. It would truncate CMA
> permanently and should be excluded.
> 
> In gup slow path, slow path, where
> __gup_longterm_locked->check_and_migrate_cma_pages() handles FOLL_LONGTERM,
> but in fast path, there lacks such a check, which means a possible leak of
> CMA page to longterm pinned.
> 
> Place a check in try_grab_compound_head() in the fast path to fix the leak,
> and if FOLL_LONGTERM happens on CMA, it will fall back to slow path to
> migrate the page.
> 
> Some note about the check:
> Huge page's subpages have the same migrate type due to either
> allocation from a free_list[] or alloc_contig_range() with param
> MIGRATE_MOVABLE. So it is enough to check on a single subpage
> by is_migrate_cma_page(subpage)
> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> To: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
> v6 -> v7: fix coding style issue
>  mm/gup.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Much clearer, thank you

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
