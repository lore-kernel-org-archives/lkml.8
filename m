Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB17C10F26
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE2522064A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585812855;
	bh=kg+mYWRJcXUsin3JbbqPUkk4x02wuKXJQUva8u5M7J4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Zf5+7AI9TYQQ/BEnf46ASzz7o4sWAoAVvte2umQNWxSvDFR6fK1nGsDoiPpSq6FfV
	 JqAoYxqggqf/Ep0OgxjlZoVDVkj5EnzlFDg1FtDGVjqBDkxqGi165jy4E2jWLel5H/
	 v4T2e0xa5ff8Tq3dhMrHcvNlKNWYG26V8Sgh59B0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732537AbgDBHeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 03:34:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45643 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbgDBHeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 03:34:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id t7so2871814wrw.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 00:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=epdqCPxnoC+zcq08DlC7aOQBj0oB2B3DQy9u2NkQk+U=;
        b=eArYa0gl7risEI2DirdQt61jA1s36Honozddp2ffGYmk7fiR55AhJG9759IKPYHNXt
         SrgmHuClNkoyVinlD8tTpHgV+cs0Ya1rAjeCk4YD/ht46yreRQmrb2JBpd7U8hy0s0pf
         b1ruVArChJmsqoIXdtsnvTclGWRlgWFTC8ooH79g0GS2r03Qt0C9TX6YnZ1xhTfI/nTi
         5NwyTjhafv59NM7hvcdlHtqqmnMJWi371FbPfzo1V6gWWIDwvErEFT3zk8ftymy9rblI
         f5ej0qNtOPwBaGU1DgClsmZ+c2H9xPeBwpkcgcFe67iMd3mdTlLVGY2ygiD49LEf6iSD
         Qj7Q==
X-Gm-Message-State: AGi0Pub080LdebWexy2Rkg1xLxGlV7/c4PgS9AI8lG5CCP4e7B1NJ2tj
        82TwjZGyh0Q2/iHppyEBIoE=
X-Google-Smtp-Source: APiQypK3ZFbdRdx2Cy++KiBT48fpK60xOXPMXBHmur7Ae9nQHnt4p5Qkh5mD5rZLlsdtoU+53/ipNQ==
X-Received: by 2002:adf:8164:: with SMTP id 91mr2001835wrm.422.1585812852386;
        Thu, 02 Apr 2020 00:34:12 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id 9sm5760238wmm.6.2020.04.02.00.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 00:34:11 -0700 (PDT)
Date:   Thu, 2 Apr 2020 09:34:10 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        David Hildenbrand <david@redhat.com>,
        James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] mm: initialize deferred pages with interrupts enabled
Message-ID: <20200402073410.GF22681@dhcp22.suse.cz>
References: <20200401193238.22544-1-pasha.tatashin@soleen.com>
 <20200401195721.GZ22681@dhcp22.suse.cz>
 <CA+CK2bBC-KBRuCBjJminVp+NmYSK3mhRZgmTmcBY5C5a-xVoMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bBC-KBRuCBjJminVp+NmYSK3mhRZgmTmcBY5C5a-xVoMw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 01-04-20 16:27:33, Pavel Tatashin wrote:
> On Wed, Apr 1, 2020 at 3:57 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Wed 01-04-20 15:32:38, Pavel Tatashin wrote:
> > > Initializing struct pages is a long task and keeping interrupts disabled
> > > for the duration of this operation introduces a number of problems.
> > >
> > > 1. jiffies are not updated for long period of time, and thus incorrect time
> > >    is reported. See proposed solution and discussion here:
> > >    lkml/20200311123848.118638-1-shile.zhang@linux.alibaba.com
> >
> > http://lkml.kernel.org/r/20200311123848.118638-1-shile.zhang@linux.alibaba.com
> >
> > > 2. It prevents farther improving deferred page initialization by allowing
> > >    inter-node multi-threading.
> > >
> > > We are keeping interrupts disabled to solve a rather theoretical problem
> > > that was never observed in real world (See 3a2d7fa8a3d5).
> > >
> > > Lets keep interrupts enabled. In case we ever encounter a scenario where
> > > an interrupt thread wants to allocate large amount of memory this early in
> > > boot we can deal with that by growing zone (see deferred_grow_zone()) by
> > > the needed amount before starting deferred_init_memmap() threads.
> > >
> > > Before:
> > > [    1.232459] node 0 initialised, 12058412 pages in 1ms
> > >
> > > After:
> > > [    1.632580] node 0 initialised, 12051227 pages in 436ms
> > >
> >
> > Fixes: 3a2d7fa8a3d5 ("mm: disable interrupts while initializing deferred pages")
> > > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> >
> > I would much rather see pgdat_resize_lock completely out of both the
> > allocator and deferred init path altogether but this can be done in a
> > separate patch. This one looks slightly safer for stable backports.
> 
> This is what I wanted to do, but after studying deferred_grow_zone(),
> I do not see a simple way to solve this. It is one thing to fail an
> allocation, and it is another thing to have a corruption because of
> race.

Let's discuss deferred_grow_zone after this all settles down. I still
have to study it because I wasn't aware that this is actually a page
allocator path relying on the resize lock. My recollection was that the
resize lock is only about memory hotplug. Your patches flew by and I
didn't have time to review them back then. So I have to admit I have
seen the resize lock too simple.
-- 
Michal Hocko
SUSE Labs
