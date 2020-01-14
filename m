Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7583C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 23:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C7ED24671
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 23:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579046022;
	bh=ZIPS+SRI/IdrMxuWTsYUabzFN7x54xJzdCh1LjONnHk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=cLBvf+o60qqnxwdB0Uru3Gc/cTweWoCQ8OIaVIiqDuo/EiZJB38XzCJLYiSgaCThO
	 /G/EbVbZwga0XE9Z0YqtwR2xsKIXMaj5mhyLMGcc9mvG6i1eyAgO3hwdf7P3fMrCED
	 3k084sfSrdME+edZio4cXXRjDXcrikTm193WwuHI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgANXxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 18:53:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:49756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728759AbgANXxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 18:53:41 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 169F020728;
        Tue, 14 Jan 2020 23:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579046020;
        bh=ZIPS+SRI/IdrMxuWTsYUabzFN7x54xJzdCh1LjONnHk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Nm3+H5BGEVQMF0KQuYKNJ0cziNV5P8VRPZrAfFU8Fa49BrU8Aj+sv8kaa0Qmx3Xml
         10ipA/NjVqhdM2xglllAKIotl/NBNQN67z0n9WxLuotJceLbwrTUHbOu5QWQZrcEZb
         jSzPkPbn9Z9B0XiQM2rQijKyrWDJGPq3MU/KzTfg=
Date:   Tue, 14 Jan 2020 15:53:39 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        sergey.senozhatsky.work@gmail.com, pmladek@suse.com,
        rostedt@goodmis.org, peterz@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm/hotplug: silence a lockdep splat with printk()
Message-Id: <20200114155339.ad5eee63b9ff38b617ee6168@linux-foundation.org>
In-Reply-To: <D5CC7C52-1F08-401E-BDCA-DF617909BB9D@lca.pw>
References: <20200114210215.GQ19428@dhcp22.suse.cz>
        <D5CC7C52-1F08-401E-BDCA-DF617909BB9D@lca.pw>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jan 14, 2020, at 4:02 PM, Michal Hocko <mhocko@kernel.org> wrote:
>> 
>> Yeah, that was a long discussion with a lot of lockdep false positives.
>> I believe I have made it clear that the console code shouldn't depend on
>> memory allocation because that is just too fragile. If that is not
>> possible for some reason then it has to be mentioned in the changelog.
>> I really do not want us to add kludges to the MM code just because of
>> printk deficiencies unless that is absolutely inevitable.
>
> I don't know how to convince you, but both random number generator and
> printk() maintainers agreed to get ride of printk() with zone->lock
> held as you can see in the approved commit mentioned in this patch
> description because it is a whac-a-mole to fix other places.  In other
> word, the patch alone fixes quite a few false positives and potential
> real deadlocks.  Maybe Andrew please has a look at this directly?
>

Well, a few things.

The changelog is quite poor.  It doesn't describe the problem (console
drivers allocating memory) not does it describe the solution
(deferring the dump_page() until after release of zone->lock).

So I changed it to this:

: Some console drivers can perform memory allocation at inappropriate times,
: which can result in lockdep warnings (and presumably deadlocks) if printk
: is called with zone->lock held.
: 
: By far the best fix is to reeducate those console drivers to not perform
: these allocations, but this is proving difficult.
: 
: Another but poorer approach is to call printk_deferred() when holding
: zone->lock, but memory offline will call dump_page() which needs to defer
: after the lock.
: 
: So change has_unmovable_pages() so that it no longer calls dump_page()
: itself - instead it passes the page's descripton (as a string) back to the
: caller so that in the case of a has_unmovable_pages() failure, the caller
: can call dump_page() after releasing zone->lock.
: 
: While at it, remove a similar but unnecessary debug printk() as well.

But I see a couple of other issues.

> @@ -8290,8 +8290,10 @@ bool has_unmovable_pages(struct zone *zo
>  	return false;
>  unmovable:
>  	WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE);
> -	if (flags & REPORT_FAILURE)
> -		dump_page(pfn_to_page(pfn + iter), reason);
> +	if (flags & REPORT_FAILURE) {
> +		page = pfn_to_page(pfn + iter);

This statement appears to be unnecessary.

> +		strscpy(dump, reason, 64);
> +	}


Also, that whole `reason' thing in has_unmovable_pages() is just there
to tell us whether it was an "unmovable page" or a "CMA page".  This
doesn't seem terribly useful to me.  Also, I expect that the
dump_page() output will permit the user to determine that it was a CMA
page anyway.  If not, we can change dump_page() to add that info.

So how about we remove that whole `reason' thing and possibly enhance
dump_page()?  The patch then becomes much simpler.

