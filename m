Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E225CC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF17D2076C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587473578;
	bh=Fn7rbRiapP/SaYGJR8P7RLqze6s1UTZ2512WBb64z7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gG2ee5PLyCP3/EXDb362zzpbPvhwUNXlocEuTI6zcMZmK7a2x9eIsuvnVdTkKJw00
	 dGxfNNKspRINj4eWlZ6NomayBhs9UdiLzNF+O2fy+zDasxsQW6p8oUCWLQ99G32+wH
	 35Mxvo7NdfDFgt1LQXgCjIqg0Iztbeb8QO5RQ5es=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbgDUMw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 08:52:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46009 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbgDUMwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 08:52:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id t14so16289110wrw.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 05:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wH+l3kjkV4M80pSfaf6tFiuhqXzQ05Et/uLXKnbO3F0=;
        b=bSkBphiiCZWHgpMJPiMcs4fOqvxiFFTnk482WAaeE+Kt+ZRb8UKhGkpZUXYmzTu3nv
         M4jrjCvLLAGysDOROm7pgmdL5aC9ivFb5IvRk6L6UmBvs7rFevdn18+iwcJ81vlDaJvL
         WSyUbU/SUdHUD9Ad0BqTUoOTUUkpHUzFQD1knjZXFJPnj/EredQrEWlCT538hC5clFoU
         /pKfrEyVR86dO5ZFLe2iXoFy0r6u56TEU7EkYuyNsfeEF0a5q9ZwrZKuCKiNawrmo8Qw
         dKO5jAinBFr/BvIrXezAElisr9qHxwSj7PuESk7vZv5KJZWP4vWdWy1rFn5bU0ScG4hL
         RHew==
X-Gm-Message-State: AGi0PuYJ8qM+Es96WIiJOVxrwXHUlm3upbnblqWJburo/iYZHrxI8TAi
        bllFVgKnWG13cn4ZOZ2WTGY=
X-Google-Smtp-Source: APiQypJK2DJznM4LBkwNiRARpy4QXbLWtusdChfPktwY+Si3C/BZwRW5C4+XrfnGFfZdOyFoMUQ86A==
X-Received: by 2002:a5d:670c:: with SMTP id o12mr10344273wru.286.1587473572262;
        Tue, 21 Apr 2020 05:52:52 -0700 (PDT)
Received: from localhost (ip-37-188-130-62.eurotel.cz. [37.188.130.62])
        by smtp.gmail.com with ESMTPSA id u17sm4375673wra.63.2020.04.21.05.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 05:52:51 -0700 (PDT)
Date:   Tue, 21 Apr 2020 14:52:50 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: Re: [PATCH RFC 1/2] mm/memory_hotplug: no need to init new pgdat
 with node_start_pfn
Message-ID: <20200421125250.GG27314@dhcp22.suse.cz>
References: <20200416104707.20219-1-david@redhat.com>
 <20200416104707.20219-2-david@redhat.com>
 <20200421123011.GE27314@dhcp22.suse.cz>
 <ac246ba8-9a61-0e0b-3aff-caf78743e81f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac246ba8-9a61-0e0b-3aff-caf78743e81f@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21-04-20 14:35:12, David Hildenbrand wrote:
> On 21.04.20 14:30, Michal Hocko wrote:
> > Sorry for the late reply
> > 
> > On Thu 16-04-20 12:47:06, David Hildenbrand wrote:
> >> A hotadded node/pgdat will span no pages at all, until memory is moved to
> >> the zone/node via move_pfn_range_to_zone() -> resize_pgdat_range - e.g.,
> >> when onlining memory blocks. We don't have to initialize the
> >> node_start_pfn to the memory we are adding.
> > 
> > You are right that the node is empty at this phase but that is already
> > reflected by zero present pages (hmm, I do not see spanned pages to be
> > set 0 though). What I am missing here is why this is an improvement. The
> > new node is already visible here and I do not see why we hide the
> > information we already know.
> 
> "information we already know" - no, not before we online the memory.

Is this really the case? All add_memory_resource users operate on a
physical memory range.

> Before onlining, it's just setting node_start_pfn to *some value* to be
> overwritten in move_pfn_range_to_zone()->resize_pgdat_range().

Yes the value is overwritten but I am not sure this is actually correct
thing to do. I cannot remember why I've chosen to do that. It doesn't
really seem unlikely to online node in a higher physical address.

Btw. one thing that I have in my notes, I was never able to actually
test the no numa node case. Because I have always been testing with node
being allocated during the boot. Do you have any way to trigger this
path?
-- 
Michal Hocko
SUSE Labs
