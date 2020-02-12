Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AF1C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 17:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6742073C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 17:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581529413;
	bh=1iZBCXVW3eFVYidbhlV8fBSc5TDSRJULgaw4u07us4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZPkT6e62bjqn/waRYLXN3V6t4hie+grD+qTFzPlryn7fIjXRUUx2PBWMRMdEWHE31
	 B88dmUGpAqwT4gyRekDiylze0xZ7rAGOunTFUC1gqmze8OlJj+779HUbvca6yvHPj6
	 SWGNKvOcickcrhyd8aTILaIM0ed429Zp81jTrwTU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgBLRnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 12:43:32 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:56014 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727372AbgBLRnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 12:43:32 -0500
Received: by mail-pj1-f68.google.com with SMTP id d5so1172066pjz.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 09:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rNICHkLbJTVgEdPQbhs6w63GjR1LcJl8un8NvPek2fI=;
        b=OVshkgAzjxdXM1zg6t1n401th/FuOWTu2lrRPuKw7zBNq000hv/19b+VfT4Ijn60l8
         x0BmHMooDj9t44s0XHjLm+lLLkME57AsQZd2Iv2XLekvOwivDnToEZ240V45ZBcaM6cw
         VVdfiy7EhgUQdisQ5dVIaac+GvpEHaelLz7YbCNlA6z7En89ZN0NYH5TkDngk3CTtRln
         nt7ak0675ltINM0z5A61TSI/GsDpKvu9xCwepvQMW1WUWXXHsNaljgJYvllmXDnfHaGK
         k07oNGnNfP6XVI/LcJ/H3Va9Qde+YsWoyiAC4xxDsVuDDxPfA/wEcxblpNFJ2ff0CYTG
         59QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rNICHkLbJTVgEdPQbhs6w63GjR1LcJl8un8NvPek2fI=;
        b=cVekmEC0kyg4ZGUSjvZkWa0XfuWHHzxSpiFMU8FTDqHmkpkq5WUaAVTXb5u29yDXBO
         YnOWR6KoP9VbaOpMoDtb4m4NPUQOABywqDrww/qt7327tZcjeCSZZTOXUgVoeR8xrE6j
         McPJZWEKsxMDCb0MM4fecGcLtFUXuhBx6oXa3x6Pq6GwioTsiEZLAlvi3ezMcRi/zfW7
         t3NNDa5vf7XL5reZmq6LQ27EA+rQg5gHpzFANPcBkocW20oCtbAt4iwvZ9ahF430VPhU
         JZU2KesRZXhcwOEqAkSu0UNSUyAedq8bk0ujm+H+88xRaxCO+2IAJ8mwiudtHoVuF2CZ
         xDrA==
X-Gm-Message-State: APjAAAUWn19fIZWqzvGFHSCPLmkckVMhyUOBYGGR0qY3aUuXfTj6M9nJ
        58kn93HtRBjBDUfUdiSVhrc=
X-Google-Smtp-Source: APXvYqw55+IBnNdt1HhMxFj8Fw4EwFQH1L36LfiCFQ8NJGFpvntKixLHCo6b2U1/LOX7dlqTTn7MUg==
X-Received: by 2002:a17:902:7484:: with SMTP id h4mr9112516pll.206.1581529410937;
        Wed, 12 Feb 2020 09:43:30 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id l18sm1594393pfe.96.2020.02.12.09.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 09:43:29 -0800 (PST)
Date:   Wed, 12 Feb 2020 09:43:28 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix long time stall from mm_populate
Message-ID: <20200212174328.GC93795@google.com>
References: <20200211001958.170261-1-minchan@kernel.org>
 <20200212102206.GE25573@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212102206.GE25573@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 11:22:06AM +0100, Jan Kara wrote:
> On Mon 10-02-20 16:19:58, Minchan Kim wrote:
> > Basically, fault handler releases mmap_sem before requesting readahead
> > and then it is supposed to retry lookup the page from page cache with
> > FAULT_FLAG_TRIED so that it avoids the live lock of infinite retry.
> > 
> > However, what happens if the fault handler find a page from page
> > cache and the page has readahead marker but are waiting under
> > writeback? Plus one more condition, it happens under mm_populate
> > which repeats faulting unless it encounters error. So let's assemble
> > conditions below.
> > 
> > __mm_populate
> > for (...)
> >   get_user_pages(faluty_address)
> >     handle_mm_fault
> >       filemap_fault
> >         find a page form page(PG_uptodate|PG_readahead|PG_writeback)
> > 	it will return VM_FAULT_RETRY
> >   continue with faulty_address
> > 
> > IOW, it will repeat fault retry logic until the page will be written
> > back in the long run. It makes big spike latency of several seconds.
> > 
> > This patch solves the issue by turning off fault retry logic in second
> > trial.
> > 
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> > It was orignated from code review once I have seen several user reports
> > but didn't confirm yet it's the root cause.
> 
> Yes, I think the immediate problem is actually elsewhere but I agree that
> __mm_populate() should follow the general protocol of retrying only once
> so your change should make it more robust. The patch looks good to me, you
> can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks for the review!
