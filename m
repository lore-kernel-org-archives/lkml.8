Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D59C54E8E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 01:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8C242192A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 01:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FSvdiai/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbgEKBVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 21:21:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43379 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728381AbgEKBVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 21:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589160077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XpPUF4Lpte5er2Ch71QCy11te1/+/YJzd/wxHcmocTg=;
        b=FSvdiai/YNVNH4VUslYfV99JYZSQEYTJMNIRNq3vVTyYWOje81uB0lssKTos+KU2x1Uojc
        HyPBjzjZrU1tqWH4UhVw46g/QvbBtKYls8y14zoMqHxHkW5HOl/Ft2HA9SdeXnADVsAuQ1
        oBJi7i9ln8r0aUn3zcDVzHcutu8ZTRk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-aRhFNX5KNKObKy9zYJ2tGw-1; Sun, 10 May 2020 21:21:14 -0400
X-MC-Unique: aRhFNX5KNKObKy9zYJ2tGw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4591A80058A;
        Mon, 11 May 2020 01:21:12 +0000 (UTC)
Received: from localhost (ovpn-12-129.pek2.redhat.com [10.72.12.129])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 930026062D;
        Mon, 11 May 2020 01:21:07 +0000 (UTC)
Date:   Mon, 11 May 2020 09:21:00 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: compaction: VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn))
Message-ID: <20200511012100.GI5029@MiWiFi-R3L-srv>
References: <8C537EB7-85EE-4DCF-943E-3CC0ED0DF56D@lca.pw>
 <20200424034353.GD4247@MiWiFi-R3L-srv>
 <A49F2991-4319-4207-9B6E-CC8563102C27@lca.pw>
 <20200505124314.GA5029@MiWiFi-R3L-srv>
 <46D27820-4B67-45F0-898C-B0547D654626@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <46D27820-4B67-45F0-898C-B0547D654626@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/20 at 09:20am, Qian Cai wrote:
> 
> 
> > On May 5, 2020, at 8:43 AM, Baoquan He <bhe@redhat.com> wrote:
> > 
> > Hi,
> > 
> > On 04/24/20 at 09:45am, Qian Cai wrote:
> >> 
> >> 
> >>> On Apr 23, 2020, at 11:43 PM, Baoquan He <bhe@redhat.com> wrote:
> >>> 
> >>> On 04/23/20 at 05:25pm, Qian Cai wrote:
> >>>> Compaction starts to crash below on linux-next today. The faulty page belongs to Node 0 DMA32 zone.
> >>>> I’ll continue to narrow it down, but just want to give a headup in case someone could beat me to it.
> >>>> 
> >>>> Debug output from free_area_init_core()
> >>>> [    0.000000] KK start page = ffffea0000000040, end page = ffffea0000040000, nid = 0 DMA
> >>>> [    0.000000] KK start page = ffffea0000040000, end page = ffffea0004000000, nid = 0 DMA32
> >>>> [    0.000000] KK start page = ffffea0004000000, end page = ffffea0012000000, nid = 0 NORMAL
> >>>> [    0.000000] KK start page = ffffea0012000000, end page = ffffea0021fc0000, nid = 4 NORMAL
> >>> 
> >>> Where are these printed? They are the direct mapping address of page?
> >> 
> >> From this debug patch. Yes, direct mapping.
> > 
> > Can you try below patch? I may get why this is caused, not sure if the
> > place is right. 
> > 
> > diff --git a/mm/compaction.c b/mm/compaction.c
> > index 177c11a8f3b9..e26972f26414 100644
> > --- a/mm/compaction.c
> > +++ b/mm/compaction.c
> > @@ -1409,7 +1409,9 @@ fast_isolate_freepages(struct compact_control *cc)
> > 				cc->free_pfn = highest;
> > 			} else {
> > 				if (cc->direct_compaction && pfn_valid(min_pfn)) {
> > -					page = pfn_to_page(min_pfn);
> > +					page = pageblock_pfn_to_page(min_pfn,
> > +						pageblock_end_pfn(min_pfn),
> > +						cc->zone);
> > 					cc->free_pfn = min_pfn;
> > 				}
> > 			}
> 
> I have not had luck to reproduce this again yet, but feel free to move forward with the patch anyway if you are comfortable to do so, so at least people could review it properly.

OK, I will make a patch with details in log and post. Thanks.

