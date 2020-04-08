Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDFAC2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 17:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6633020768
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 17:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586365999;
	bh=FoiImDp2DYzSC0NZaFstUAHqxjS8zXEz3ZgOUzfsYbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uQ861+nPykLQ477qs3wIsnLdxL6dBsvI8KFsD9bijS8VB/H9Fe2UbgkqSEji9J6Kw
	 MrIJ0UH5yIzkq0lB+HEv8SwoA7MP93KlQlVmPgp0YT+19H7aWjLWK+zRFUPnq4PXii
	 mEHytebMSwV+Kh0pZ7+EKzHnWxnlyM9vt+lkLj/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730529AbgDHRNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 13:13:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45180 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbgDHRNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 13:13:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id v5so8716225wrp.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 10:13:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PGK0QQ5iawAohJgI19o0w6WPitsBtyuTREYifWy6rnk=;
        b=kQK/Bwh+0qpFdFQ0xwcXj+MQ9krQFurOVk6V8npqO6OMwf88522BYVQa6n3kjAssX9
         7lZH9FoKoTlpxkj9HsGpPNOyjogu8tYleo296fY8qNX6DsdNR0rmeCo2RmrM5evTagbQ
         vU/upI69IeISwwC/qSMgdtMvPAeOXSnnQpq1/JyMF0fKKOywfwypr6HztoEli3GA7STf
         Zzgbs2Hv1H9RD/UvjVNnTv8kzulbZ0Li8Kv+snbi+NrorhSKW/Rsr6V9VRbANDNbRPx/
         Q2In+l0JcFe4Nji15KGGFApEo7oA3bW22gjYI+BAjiEynqkaLsT81rPMkMeau8+bqvuu
         jlwQ==
X-Gm-Message-State: AGi0PuZ44sfkOVruPruughRkwOzY3wMLQdwXWWbp22MTnF5AWDxKoMlW
        UFgLjlFvjoPZWHvA5q7htek=
X-Google-Smtp-Source: APiQypL2wNAUOEz6xsdGeVvjZ+Xc8BldJu40k9eRSyNvN9GmPki/87HGbWbDXEz9aBz9+p77dv/koA==
X-Received: by 2002:a5d:688f:: with SMTP id h15mr985530wru.352.1586365994354;
        Wed, 08 Apr 2020 10:13:14 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id q8sm250026wmg.22.2020.04.08.10.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 10:13:13 -0700 (PDT)
Date:   Wed, 8 Apr 2020 19:13:10 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot+3be1a33f04dc782e9fd5@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/gup: Let __get_user_pages_locked() return -EINTR for
 fatal signal
Message-ID: <20200408171023.GC18914@dhcp22.suse.cz>
References: <20200408155924.107722-1-peterx@redhat.com>
 <CAHk-=wjR=rtvm21=yP_1tqscXpOSEVpZaJ+oBAD8qU9ZKeZEWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjR=rtvm21=yP_1tqscXpOSEVpZaJ+oBAD8qU9ZKeZEWQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 08-04-20 09:20:00, Linus Torvalds wrote:
> On Wed, Apr 8, 2020 at 8:59 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > __get_user_pages_locked() will return 0 instead of -EINTR after commit
> > 4426e945df588 which added extra code to allow gup detect fatal signal
> > faster.  Restore that behavior.
> 
> I've applied this, but it's worth noting that
> __get_user_pages_locked() can still return 0 in other situations.
> 
> I realize that "I got zero pages" is a valid return value, but I do
> wonder if we should make the rule be that a zero return value isn't
> possible (return -EAGAIN or whatever if you doin't have the
> EFAULT/EINTR conditions).
> 
> So that you'd always get either an error, or a successful number of pages.
> 
> The only case where __get_user_pages_locked() might return zero is if
> you pass in a zero 'nr_pages', although I suspect even for that case
> returning -EINVAL might be a better option.

Yeah, that makes sense to me. And get_user_pages_locked documentation
would benefit from an actual documentation as well. What we have right
now is more suited to the lower level (__get_user_pages_locked) and have
a high level user oriented documentation.
-- 
Michal Hocko
SUSE Labs
