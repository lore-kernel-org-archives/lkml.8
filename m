Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5722FC33C9E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 01:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E3C24679
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 01:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579051173;
	bh=ktOauvrUOBF6V2YXVtNEGXvaG7vGM34H3Rv5P2vEd6M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=0srPssbUI9ZknruTfJAnaTGwRan8O4Bq+N0CPSjSnGVfcH1UZZZRYizbvYWH8E7gu
	 IZM/8DX0VegH85qaiydA8UgB2YdsI7PlHd4Qa2LXcCro1Y/cTpuo7BOvgR9e6rCQNC
	 suvEuhdK0ubgyyzGEe0v68Gh12YiXCWLoaUtxm64=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgAOBTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 20:19:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:44264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728824AbgAOBTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 20:19:31 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E390E214AF;
        Wed, 15 Jan 2020 01:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579051171;
        bh=ktOauvrUOBF6V2YXVtNEGXvaG7vGM34H3Rv5P2vEd6M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=btxWWaF3YEeRL18RbRYNFF3qURcbo/cUEjyh5J+ixuPzVEe4INLT5zWFeyvXRRfcL
         6QVD4L4w6FSWOk2QicOq7omFqD1ATKLsfDx4fi48df27aT4DHmZNr2n5odfUcKO70l
         SNMvRBYsbqo75lEcZ57g5Y4g/Ery3mRTvDkWrv64=
Date:   Tue, 14 Jan 2020 17:19:30 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        pmladek@suse.com, rostedt@goodmis.org, peterz@infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm/hotplug: silence a lockdep splat with printk()
Message-Id: <20200114171930.9a0dbd9ae82174abf19b3df5@linux-foundation.org>
In-Reply-To: <DEF43337-68A2-4FDF-9B8C-795E017831DE@lca.pw>
References: <20200114210215.GQ19428@dhcp22.suse.cz>
        <D5CC7C52-1F08-401E-BDCA-DF617909BB9D@lca.pw>
        <20200114155339.ad5eee63b9ff38b617ee6168@linux-foundation.org>
        <DEF43337-68A2-4FDF-9B8C-795E017831DE@lca.pw>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2020 20:02:31 -0500 Qian Cai <cai@lca.pw> wrote:

> 
> 
> >> @@ -8290,8 +8290,10 @@ bool has_unmovable_pages(struct zone *zo
> >> 	return false;
> >> unmovable:
> >> 	WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE);
> >> -	if (flags & REPORT_FAILURE)
> >> -		dump_page(pfn_to_page(pfn + iter), reason);
> >> +	if (flags & REPORT_FAILURE) {
> >> +		page = pfn_to_page(pfn + iter);
> > 
> > This statement appears to be unnecessary.
> 
> dump_page() in set_migratetype_isolate() needs that “page”.

local var `page' is never used after this statement.


