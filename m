Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC30C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DE86206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b+L75C/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730930AbgF2TOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:14:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51586 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731819AbgF2TOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:14:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593458074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uaWG/Hwtc/IuZbOB2qwDYiIrGK8VtDdNu+bH/o2E7C4=;
        b=b+L75C/29nuPnY7P7vp/5K56gpxYUxfEN2LmOxKSBtEOuNgEMLivk6ByH5mFPrwYyNDxR3
        NMID2N3Uvn/mpzlvc9y65GCIjI8JAcUXXl4sWls5AD785df12+oqamND3tSY/Tcvq4qtEY
        RGChheQHJVzCDsN3PmvjYVt3PHomg1A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-4UE05tubOXSAa1_zfb3LrQ-1; Mon, 29 Jun 2020 11:13:46 -0400
X-MC-Unique: 4UE05tubOXSAa1_zfb3LrQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22F07107ACCA;
        Mon, 29 Jun 2020 15:13:45 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.58])
        by smtp.corp.redhat.com (Postfix) with SMTP id BFEE2101E5A2;
        Mon, 29 Jun 2020 15:13:42 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 29 Jun 2020 17:13:44 +0200 (CEST)
Date:   Mon, 29 Jun 2020 17:13:41 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Nick Piggin <npiggin@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jan Kara <jack@suse.cz>, Davidlohr Bueso <dave@stgolabs.net>,
        Andi Kleen <ak@linux.intel.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: wait_on_page_bit_common(TASK_KILLABLE, EXCLUSIVE) can miss
 wakeup?
Message-ID: <20200629151340.GC20323@redhat.com>
References: <20200624161142.GA12184@redhat.com>
 <20200624162042.GA12238@redhat.com>
 <CAHk-=wjJA2Z3kUFb-5s=6+n0qbTs8ELqKFt9B3pH85a8fGD73w@mail.gmail.com>
 <20200626154313.GI4817@hirez.programming.kicks-ass.net>
 <CAHk-=whvVWNXPJq1k566zn4SfXAifXtiA7T+7JFweR3rQ0nc9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whvVWNXPJq1k566zn4SfXAifXtiA7T+7JFweR3rQ0nc9A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/27, Linus Torvalds wrote:
>
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1150,6 +1150,12 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
>  			io_schedule();
>  
>  		if (behavior == EXCLUSIVE) {
> +			/*
> +			 * Make sure we don't get any exclusive wakeups
> +			 * after this point!
> +			 */
> +			__set_current_state(TASK_RUNNING);
> +			smp_mb__before_atomic();
>  			if (!test_and_set_bit_lock(bit_nr, &page->flags))
>  				break;
>  		} else if (behavior == SHARED) {

FWIW,

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

