Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269D6C33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 07:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F21712087E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 07:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579506148;
	bh=3YQVEHCog7/EoCM8/BbQmTRXqcOmvSAy5U6IN5NqEfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=km8z4Qr8328QyEzXSkUNYViUZToMJIg5Hmg9ZL9AZ/1wz0vIjDBdvbU1VIaHQ+QmU
	 c7PoyzSmQDlYxoFZ4XOIEVHhFW1hu9XcDGf6xf7pZkRNnPc7Das6vZ8lsjszEHrfOc
	 MazS7Y7gkZKsJzqZrTz7XHD1DqgiBSHa58tkQcEo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgATHm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 02:42:27 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39374 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgATHm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 02:42:26 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so28360617wrt.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 23:42:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oYPv014C6O3vR5nrvfR9UKHGQnNqmP0rTFCUylko2hY=;
        b=uOZrgz+1R36EjANfruyLGRVWC4QPuwjqV7yfMdS/ANWL3IlBkoaarpNV3D9nd4ohhL
         GPcgVOyvO1Im2K/eG9MAQ8EvBEg4+Aa3U1b5NxopcYOcHb52sj/El4j5TdPJVRGBIhwi
         dd59jsvOmFdE+O6JOgxiUCLryY0clZCmj9aieHGuK5gRX64mNl5KKE5evSATXtKvTIrS
         8sYWH2iLrHrUrviFqfSzeN9vClG5eygfrmfhq+8hWpulcGolmXwI/BWQ3nbD0T2zRBlL
         5I3Dyfh7/uRF21t+xMxG7wd1TrqjrysBIf7PNQC5ht1J7Su/wYhpqEZy8gpcJF6AlCWq
         Hb6A==
X-Gm-Message-State: APjAAAXwaYsg/hf6cwrREmZRNjXEAfhomLJeTlQBm1y3tW1YQVRJzJ3/
        wWYCoNTQg+Ldu3p9ZxnrmZc=
X-Google-Smtp-Source: APXvYqyxHbwCf1rEwyiPliE2VJRRsUpskKzOCC9hpd3QOUPFNfJx3XHUPNjrUjzx9oPxyxEzRGSxTg==
X-Received: by 2002:adf:f847:: with SMTP id d7mr16568464wrq.35.1579506145143;
        Sun, 19 Jan 2020 23:42:25 -0800 (PST)
Received: from localhost (ip-37-188-138-155.eurotel.cz. [37.188.138.155])
        by smtp.gmail.com with ESMTPSA id d14sm49499767wru.9.2020.01.19.23.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2020 23:42:24 -0800 (PST)
Date:   Mon, 20 Jan 2020 08:42:22 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org, david@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] mm/page_isolation: fix potential warning from user
Message-ID: <20200120074222.GF18451@dhcp22.suse.cz>
References: <20200120034252.1558-1-cai@lca.pw>
 <91ba5997-b227-7ae2-8459-310e18b9bb87@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91ba5997-b227-7ae2-8459-310e18b9bb87@arm.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20-01-20 09:50:33, Anshuman Khandual wrote:
> Hello Qian,
> 
> On 01/20/2020 09:12 AM, Qian Cai wrote:
> > It makes sense to call the WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE)
> > from the offlining path, but should avoid triggering it from userspace,
> > i.e, from is_mem_section_removable().
> 
> Could you elaborate why it makes sense not to warn about an unmovable
> ZONE_MOVABLE page when an user tries to query about a memory block
> device's movability through sysfs ?

Because somebody might have panic_on_warn and then this is unlikely (but
not impossible) way to put the system down by arbitrary user. Besides
that it is stupid to warn when we convey the information to the
userspace anyway.
 
[...]
> > +	} else {
> > +		if (isol_flags & MEMORY_OFFLINE)
> > +			WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE);> +
> > +		if ((isol_flags & REPORT_FAILURE) && !IS_ERR(unmovable))
> > +			/*
> > +			 * printk() with zone->lock held will likely trigger a
> > +			 * lockdep splat, so defer it here.
> > +			 */
> > +			dump_page(unmovable, "unmovable page");
> > +	}
> > +
> > +	return !!unmovable;
> >  }
> >  
> >  static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
> 
> set_migratetype_isolate() gets called from CMA as well as HugeTLB
> allocation paths, so its not only during offline. Hence the commit
> message should be changed to reflect this.

We should just report for all those cases I believe.
-- 
Michal Hocko
SUSE Labs
