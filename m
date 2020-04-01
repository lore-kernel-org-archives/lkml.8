Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E602CC2D0F3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 20:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB57B20737
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 20:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="IGkoDtyi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732758AbgDAUbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 16:31:42 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43162 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732337AbgDAUbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 16:31:42 -0400
Received: by mail-ed1-f68.google.com with SMTP id bd14so1459868edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 13:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DBjdSPXE/6dhZ17WWAfxRA8tbpzcbJh3eAJ5O42gqfY=;
        b=IGkoDtyiaTzsf7pLuMQaRFwOG+a1DG9slQei/GLTqufGtEScaDuD2aB1yN+jU6u+25
         ZXNmMKn2i4MP1Ph6a8oOW5esuVF/HoFHCUICHiRC0mp8tgHDOlDXRX+ruVZ4uYEqtfWN
         NPDuwuU0ILplPzPl4UJIln7jg8+W1jxVwiw9Ww3H9vm5WWInr7rb6o0uKdXqeK5kzfhA
         0oWSZ26/mK1r/CE4ffghM4xEpcursiDq3KY8dEtjrGExtUR8vHoUVWuJtU5z1mKwkZLd
         obKs5zldxxwkQHkRNbcDuYRegWotG89fydZQdqO9PD+iPrYOKCKIPVFnOdiLonbZCSTN
         nQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DBjdSPXE/6dhZ17WWAfxRA8tbpzcbJh3eAJ5O42gqfY=;
        b=abFFz4fFxIoBmGAVyvliOCSSpkYUHH/6wor1WoLHTrt+Qt3Wep6bMGhb8LAmtuRrOC
         PJX3jBgWB68tpkKZn6/Yn3mEqihZIR9GACasAHb7KJ4wAr+cGtDg1IIUxDSohdokaHSD
         VwDJlP9Es9UZJJIKUg+PpX/h8eyq7xtypmuBkr6phVBjON7O1BhGa7lbvXtgjfY9A0Zd
         tHTiyReHSDuKtjxv/5HGv91L9wh9w2PZf8PNT9izKrGt5QoROsBySrOi2z2sRNfWNJiJ
         DToOIOYBuJbm4hURPqpPHOhPVnWqflx5FbCBReIzsTzxr1V7uHUaqshPE+U1UvL/gtxr
         h18Q==
X-Gm-Message-State: ANhLgQ3XdPDK0UhpdikXwsbeX9psbEQW2jfvV48XydX3i+zJ5SW3sjD5
        ernRVPlpF6AlcP385Zh+qOMoIuTA6OcWdPl+YnB1vA==
X-Google-Smtp-Source: ADFU+vswBjP4j1n+6ACzm+zV8axSXvSjQK2m5q3sTL1QuKcC7l/nLC1liTOl4YgcGuVPOSE92R8QvVrYyliozn9Ixjo=
X-Received: by 2002:a17:907:414d:: with SMTP id od21mr22683254ejb.178.1585773100664;
 Wed, 01 Apr 2020 13:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200401193238.22544-1-pasha.tatashin@soleen.com>
 <20200401200027.vsm5roobllewniea@ca-dmjordan1.us.oracle.com> <20200401200855.d23xcwznr5cm67p2@ca-dmjordan1.us.oracle.com>
In-Reply-To: <20200401200855.d23xcwznr5cm67p2@ca-dmjordan1.us.oracle.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 1 Apr 2020 16:31:29 -0400
Message-ID: <CA+CK2bBe9VNujo9ZNOeViJ+GQpfOHN8Yt9Xqjebu61Z2YtF3Ng@mail.gmail.com>
Subject: Re: [PATCH] mm: initialize deferred pages with interrupts enabled
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm <linux-mm@kvack.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        David Hildenbrand <david@redhat.com>,
        James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 1, 2020 at 4:10 PM Daniel Jordan <daniel.m.jordan@oracle.com> wrote:
>
> On Wed, Apr 01, 2020 at 04:00:27PM -0400, Daniel Jordan wrote:
> > On Wed, Apr 01, 2020 at 03:32:38PM -0400, Pavel Tatashin wrote:
> > > Initializing struct pages is a long task and keeping interrupts disabled
> > > for the duration of this operation introduces a number of problems.
> > >
> > > 1. jiffies are not updated for long period of time, and thus incorrect time
> > >    is reported. See proposed solution and discussion here:
> > >    lkml/20200311123848.118638-1-shile.zhang@linux.alibaba.com
> > > 2. It prevents farther improving deferred page initialization by allowing
> >
> >                                                                    not allowing
> > >    inter-node multi-threading.
> >
> >      intra-node
> >
> > ...
> > > After:
> > > [    1.632580] node 0 initialised, 12051227 pages in 436ms
> >
> > Fixes: 3a2d7fa8a3d5 ("mm: disable interrupts while initializing deferred pages")
> > Reported-by: Shile Zhang <shile.zhang@linux.alibaba.com>
> >
> > > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> >
> > Freezing jiffies for a while during boot sounds like stable to me, so
> >
> > Cc: <stable@vger.kernel.org>    [4.17.x+]
> >
> >
> > Can you please add a comment to mmzone.h above node_size_lock, something like
> >
> >          * Must be held any time you expect node_start_pfn,
> >          * node_present_pages, node_spanned_pages or nr_zones to stay constant.
> > +        * Also synchronizes pgdat->first_deferred_pfn during deferred page
> > +        * init.
> >          ...
> >         spinlock_t node_size_lock;
> >
> > > @@ -1854,18 +1859,6 @@ deferred_grow_zone(struct zone *zone, unsigned int order)
> > >             return false;
> > >
> > >     pgdat_resize_lock(pgdat, &flags);
> > > -
> > > -   /*
> > > -    * If deferred pages have been initialized while we were waiting for
> > > -    * the lock, return true, as the zone was grown.  The caller will retry
> > > -    * this zone.  We won't return to this function since the caller also
> > > -    * has this static branch.
> > > -    */
> > > -   if (!static_branch_unlikely(&deferred_pages)) {
> > > -           pgdat_resize_unlock(pgdat, &flags);
> > > -           return true;
> > > -   }
> > > -
> >
> > Huh, looks like this wasn't needed even before this change.
> >
> >
> > The rest looks fine.
> >
> > Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
>
> ...except for I forgot about the touch_nmi_watchdog() calls.  I think you'd
> need something kind of like this before your patch.

Thank you for review. You are right, I will add your patch, and modify
my to change touch_nmi_watchdog() to cond_resched().

Pasha
