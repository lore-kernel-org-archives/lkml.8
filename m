Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234CCC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 18:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F105920737
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 18:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZxhTJILp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbgGWSBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 14:01:14 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52340 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726666AbgGWSBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 14:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595527272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b93yeIvddw4DaH1gMOexxEvLdonaecE9blDE2Si2APo=;
        b=ZxhTJILp/WCwSUscGpKP3xRl9k6wwF733zdNBco/hodU61WECP0BS0INp/xuJCl0FBNjUs
        8yz4aQ+QncDPrdJ996ykgpKsG22F1CgBlS7IlfPHgr+yUC2TdU3UqgANCLKyVFXdSW3Yzk
        Qkyu7+F85VtGVXgfJqeYFXdnmXsBVR0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-c0wkkV3jNXy9AdnDpa0p8w-1; Thu, 23 Jul 2020 14:01:05 -0400
X-MC-Unique: c0wkkV3jNXy9AdnDpa0p8w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2497480046B;
        Thu, 23 Jul 2020 18:01:04 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.194.249])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1693919D7E;
        Thu, 23 Jul 2020 18:01:01 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 23 Jul 2020 20:01:03 +0200 (CEST)
Date:   Thu, 23 Jul 2020 20:01:00 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
Message-ID: <20200723180100.GA21755@redhat.com>
References: <20200721063258.17140-1-mhocko@kernel.org>
 <CAHk-=whewL14RgwLZTXcNAnrDPt0H+sRJS6iDq0oGb6zwaBMxg@mail.gmail.com>
 <CAHk-=whb0=rjc1WR+F_r_syw5Ld4=ebuNJmmpaPEzfjZRD5Y-w@mail.gmail.com>
 <alpine.LSU.2.11.2007221359450.1017@eggly.anvils>
 <CAHk-=wi=vuc6sdu0m9nYd3gb8x5Xgnc6=TH=DTOy7qU96rZ9nw@mail.gmail.com>
 <CAHk-=whEjnsANEhTA3aqpNLZ3vv7huP7QAmcAEd-GUxm2YMo-Q@mail.gmail.com>
 <20200723124749.GA7428@redhat.com>
 <CAHk-=wgyc7en4=HddEYiz_RKJXfqe1JYv3BzHc=+_wYq9ti+LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgyc7en4=HddEYiz_RKJXfqe1JYv3BzHc=+_wYq9ti+LQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/23, Linus Torvalds wrote:
>
> So here's a v2, now as a "real" commit with a commit message and everything.

I am already sleeping, will read it tomorrow, but at first glance...

> @@ -1013,18 +1014,40 @@ static int wake_page_function(wait_queue_entry_t *wait, unsigned mode, int sync,
>  	if (wait_page->bit_nr != key->bit_nr)
>  		return 0;
>  
> +	/* Stop walking if it's locked */
> +	if (wait->flags & WQ_FLAG_EXCLUSIVE) {
> +		if (test_and_set_bit(key->bit_nr, &key->page->flags))
> +			return -1;
> +	} else {
> +		if (test_bit(key->bit_nr, &key->page->flags))
> +			return -1;
> +	}
> +
>  	/*
> -	 * Stop walking if it's locked.
> -	 * Is this safe if put_and_wait_on_page_locked() is in use?
> -	 * Yes: the waker must hold a reference to this page, and if PG_locked
> -	 * has now already been set by another task, that task must also hold
> -	 * a reference to the *same usage* of this page; so there is no need
> -	 * to walk on to wake even the put_and_wait_on_page_locked() callers.
> +	 * Let the waiter know we have done the page flag
> +	 * handling for it (and the return value lets the
> +	 * wakeup logic count exclusive wakeup events).
>  	 */
> -	if (test_bit(key->bit_nr, &key->page->flags))
> -		return -1;
> +	ret = (wait->flags & WQ_FLAG_EXCLUSIVE) != 0;
> +	wait->flags |= WQ_FLAG_WOKEN;
> +	wake_up_state(wait->private, mode);
>  
> -	return autoremove_wake_function(wait, mode, sync, key);
> +	/*
> +	 * Ok, we have successfully done what we're waiting for,
> +	 * and we can unconditionally remove the wait entry.
> +	 *
> +	 * Note that this has to be the absolute last thing we do,
> +	 * since after list_del_init(&wait->entry) the wait entry
> +	 * might be de-allocated and the process might even have
> +	 * exited.
> +	 *
> +	 * We _really_ should have a "list_del_init_careful()" to
> +	 * properly pair with the unlocked "list_empty_careful()"
> +	 * in finish_wait().
> +	 */
> +	smp_mb();
> +	list_del_init(&wait->entry);

I think smp_wmb() would be enough, but this is minor.

We need a barrier between "wait->flags |= WQ_FLAG_WOKEN" and list_del_init(),

But afaics we need another barrier, rmb(), in wait_on_page_bit_common() for
the case when wait->private was not blocked; we need to ensure that if
finish_wait() sees list_empty_careful() == T then we can't miss WQ_FLAG_WOKEN.

Oleg.

