Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DDFC433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B2762064B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NDuePlci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgGXOpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 10:45:36 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33222 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726170AbgGXOpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 10:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595601934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bG1yDLGWaSETMRzgJW6YtgsTeF47PRE999wzG6k/f94=;
        b=NDuePlcin5he6w9SHzhaA+q9+VPnapy1+uQH4ZZbgC7vOLANauJOHGLYEzgymgdFkNr+Oz
        89ngWXdhR3b5ofnOBoASKLeN0V1mlqdIq28qr3QmmsJhBeSqmQOLjMM8dcrOO5T/hV8IgQ
        rY3xPLXskYm+3RJ26aIhN2OF3oACkt4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-wyDAzewePwaS7ZvCwK9RoQ-1; Fri, 24 Jul 2020 10:45:30 -0400
X-MC-Unique: wyDAzewePwaS7ZvCwK9RoQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE98080183C;
        Fri, 24 Jul 2020 14:45:28 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.121])
        by smtp.corp.redhat.com (Postfix) with SMTP id E524370C5F;
        Fri, 24 Jul 2020 14:45:26 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 24 Jul 2020 16:45:28 +0200 (CEST)
Date:   Fri, 24 Jul 2020 16:45:25 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
Message-ID: <20200724144525.GB17209@redhat.com>
References: <CAHk-=whewL14RgwLZTXcNAnrDPt0H+sRJS6iDq0oGb6zwaBMxg@mail.gmail.com>
 <CAHk-=whb0=rjc1WR+F_r_syw5Ld4=ebuNJmmpaPEzfjZRD5Y-w@mail.gmail.com>
 <alpine.LSU.2.11.2007221359450.1017@eggly.anvils>
 <CAHk-=wi=vuc6sdu0m9nYd3gb8x5Xgnc6=TH=DTOy7qU96rZ9nw@mail.gmail.com>
 <CAHk-=whEjnsANEhTA3aqpNLZ3vv7huP7QAmcAEd-GUxm2YMo-Q@mail.gmail.com>
 <20200723124749.GA7428@redhat.com>
 <CAHk-=wgyc7en4=HddEYiz_RKJXfqe1JYv3BzHc=+_wYq9ti+LQ@mail.gmail.com>
 <20200723180100.GA21755@redhat.com>
 <CAHk-=wj9KWfs799xU5eW0J_hkee52C5kvFFmBV-A+vN7qNWnjA@mail.gmail.com>
 <CAHk-=wg=zqJ69JH3S9Ux0XKwZzjKqBP+ruLrmjW6NbNrpMuBNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg=zqJ69JH3S9Ux0XKwZzjKqBP+ruLrmjW6NbNrpMuBNw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/23, Linus Torvalds wrote:
>
> IOW, I think we should do something like this (this is on top of my
> patch, since it has that wake_page_function() change in it, but notice
> how we have the exact same issue in our traditional
> autoremove_wake_function() usage).

...

> +static inline void list_del_init_careful(struct list_head *entry)
> +{
> +	__list_del_entry(entry);
> +	entry->prev = entry;
> +	smp_store_release(&entry->next, entry);
> +}
> +
...
>  static inline int list_empty_careful(const struct list_head *head)
>  {
> -	struct list_head *next = head->next;
> +	struct list_head *next = smp_load_acquire(&head->next);
>  	return (next == head) && (next == head->prev);
>  }

This (and your previous email) answers my concerns about memory barriers.

IIUC, finish_wait() could even use this version of list_empty_careful(),

	struct list_head *next = smp_load_acquire(&head->next);
	return (next == head) && !WARN_ON(next != head->prev);

iow, it doesn't really need to check next == head->prev as long as only
list_del_init_careful() can remove it from list.

Thanks!

Oleg.

