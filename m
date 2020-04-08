Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94C2C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 14:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC83206F5
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 14:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HiIccaiH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgDHO0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 10:26:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49582 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726795AbgDHO0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 10:26:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586356011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jInxb6S6kno8alLpBOp6oo5DZLTgW5u7AbwcRZ4qu+U=;
        b=HiIccaiHfJFiRExGzSJ8mzj0/A+q0mb/omA6EjIxKFdx1KpeHNMv99LPGIu8lZVnedUucO
        f393+KXptk6qRKnH+ZJBW1+tSNeou1whLraN4ddtAOT8F7JhaY75JHDjlQdSEPKJfA/8PQ
        mJoSFgP3kZ9u3Wjwtn3Q1o7n22z2EFY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-49Dx_m0CMMyPtIq9K6n6ew-1; Wed, 08 Apr 2020 10:26:49 -0400
X-MC-Unique: 49Dx_m0CMMyPtIq9K6n6ew-1
Received: by mail-wr1-f70.google.com with SMTP id u16so4129060wrp.14
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 07:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jInxb6S6kno8alLpBOp6oo5DZLTgW5u7AbwcRZ4qu+U=;
        b=jzt+xVachTDh1CoLRYeEYxYE6ErKDcF+aIKrAjoRqhIvKmN3n6hcmpm3X0CUkNR51D
         JvhJsONqUO19oTb5FYVj0poco4FX3BQhIxw6ZJ74n0O4h3OC+eGPK7t5im6DbxUBqq06
         c4/qebTr+yGdkhe6rBh4apnEjpS3hIalaK+FTXcDhUqZuebk+3fLEC32YmPjtLaoRQdt
         /dZckazFkMXZPjVC3kwWn66VAu/0iU3P0WlriauieDp2QB5JzD0imNA79yohNeMYrVSC
         1GACFTbZcYIwyqzuf6mre+jr8HywBRbVuBczOrvIt6rhF6I39JwMoP8WE3Eytst84D/c
         /i/w==
X-Gm-Message-State: AGi0PubufXH0EVA2Ioc08IKrWjLCzks0vT/SBSuUQ1itqP/ZQHUwyBUH
        kJ8K3FNr36Z0oSZ9sAiJve4rYfiByx2onhJApJuaADMDcacnaemArB+dTjXbe0z5r3mN8Oi6Qxx
        SGm3KjxDWZwSrEuKN0GPKjn3h
X-Received: by 2002:a1c:c302:: with SMTP id t2mr5026690wmf.85.1586356008062;
        Wed, 08 Apr 2020 07:26:48 -0700 (PDT)
X-Google-Smtp-Source: APiQypL93j1JGbhmlzyGs7UPvOEjdq8mXYKa70sYn+9u3/NXGRFCEUVRtx7SgpDd3+CMxyGnT4hEMw==
X-Received: by 2002:a7b:c7cb:: with SMTP id z11mr4837917wmk.15.1586355643514;
        Wed, 08 Apr 2020 07:20:43 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::3])
        by smtp.gmail.com with ESMTPSA id u6sm29411783wrm.65.2020.04.08.07.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 07:20:42 -0700 (PDT)
Date:   Wed, 8 Apr 2020 10:20:39 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        syzbot+693dc11fcb53120b5559@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] mm/mempolicy: Allow lookup_node() to handle fatal
 signal
Message-ID: <20200408142039.GD66033@xz-x1>
References: <20200408014010.80428-1-peterx@redhat.com>
 <20200408014010.80428-2-peterx@redhat.com>
 <20200408102128.GX18914@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200408102128.GX18914@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 12:21:28PM +0200, Michal Hocko wrote:
> On Tue 07-04-20 21:40:09, Peter Xu wrote:
> > lookup_node() uses gup to pin the page and get node information.  It
> > checks against ret>=0 assuming the page will be filled in.  However
> > it's also possible that gup will return zero, for example, when the
> > thread is quickly killed with a fatal signal.  Teach lookup_node() to
> > gracefully return an error -EFAULT if it happens.
> > 
> > Meanwhile, initialize "page" to NULL to avoid potential risk of
> > exploiting the pointer.
> > 
> > Reported-by: syzbot+693dc11fcb53120b5559@syzkaller.appspotmail.com
> > Fixes: 4426e945df58 ("mm/gup: allow VM_FAULT_RETRY for multiple times")
> 
> I am not familiar with thic commit but shouldn't gup return ERESTARTSYS
> on a fatal signal?

Hi, Michal,

I do see quite a few usages on -ERESTARTSYS, but also some others,
majorly -EINTR, or even -EFAULT.  I think it could be a more general
question rather than a specific question to this patch only.

I saw some other discussions about this return value issue, I'll CC
you in the other thread when I raise this as a general question.

Thanks,

-- 
Peter Xu

