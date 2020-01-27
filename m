Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840D5C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 16:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C51A214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 16:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XeJhgG7f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgA0Q4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 11:56:48 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25296 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725845AbgA0Q4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 11:56:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580144206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4HSLSFcK67NxSxIqNgVdsWkaP8xObe9Q1wx/FTvVGVE=;
        b=XeJhgG7fe0Hmu/ZdvR/EPuQx1SkMfqt8SOBK0rFNB8KwZ51jwlH9NuJblGZeVO6SVKeNAf
        HzDB6nJQPNnwDh/UktethDPOFMYzdFqiaw3GD/RwCHUaJodgCMV0dQzSL8Ypm2jEhJ8FyD
        4+uksyheJ1O6jCMKIS8y7woi8LLY62w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-AKeFL_hLPUyCRJsomxPg0w-1; Mon, 27 Jan 2020 11:56:42 -0500
X-MC-Unique: AKeFL_hLPUyCRJsomxPg0w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBAF2800D41;
        Mon, 27 Jan 2020 16:56:40 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B1A05D9CA;
        Mon, 27 Jan 2020 16:56:40 +0000 (UTC)
Date:   Mon, 27 Jan 2020 11:56:38 -0500
From:   Phil Auld <pauld@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Juri Lelli <juri.lelli@gmail.com>, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3]sched/rt: Stop for_each_process_thread() iterations in
 tg_has_rt_tasks()
Message-ID: <20200127165638.GC1295@pauld.bos.csb>
References: <152415882713.2054.8734093066910722403.stgit@localhost.localdomain>
 <20180420092540.GG24599@localhost.localdomain>
 <0d7fbdab-b972-7f86-4090-b49f9315c868@virtuozzo.com>
 <854a5fb1-a9c1-023f-55ec-17fa14ad07d5@virtuozzo.com>
 <20180425194915.GH4064@hirez.programming.kicks-ass.net>
 <9f76872b-85e6-63bd-e503-fcaec69e28e3@virtuozzo.com>
 <20200123215616.GA14789@pauld.bos.csb>
 <20200127164315.GJ14879@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127164315.GJ14879@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 05:43:15PM +0100 Peter Zijlstra wrote:
> On Thu, Jan 23, 2020 at 04:56:19PM -0500, Phil Auld wrote:
> > Peter, is there any chance of taking something like this?
> 
> Whoopsy, looks like this fell on the floor. Can do I suppose.
> 
> Thanks!
> 

Thanks. Probably make sense at this point to use Konstantin's new version?
But they both do the trick.


Cheers,
Phil

-- 

