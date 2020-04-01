Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853C3C2D0F3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 18:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B1882082F
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 18:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585764388;
	bh=wGJfsStv/o8iBthUPnKYXV5sqz3tNFOfYyySNd33CNM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=EbNTGrP1HHCXDOEFhPIc2dvZwm+5B3TRWVZtCnUmHjAxtL2RnuIWNdwEycWj142o7
	 cakf6VAF/kPEX31XOwjfTAoFjc32vLORmaPuQWo/E9qphzt2X37L0pxMmHnSJYrfAA
	 uGuo1fZWT4BrmEP2eg4/CceEBWu2wjOocK7a21AY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732582AbgDASG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 14:06:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732316AbgDASG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 14:06:26 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08B1C2071A;
        Wed,  1 Apr 2020 18:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585764385;
        bh=wGJfsStv/o8iBthUPnKYXV5sqz3tNFOfYyySNd33CNM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i+cOOUiGgpBf5MwOavDQT/S4h1rU9K3h2C6yvBXiKEMnJ/+RuoSfv0JMJjLPFk99M
         6dmg8frVngWLpQCurTw8LF49EqpA+y30cx7Kbh4y2oEgMXGac+QviplThwcHvIABr8
         qHOF+tNyTNAqnswPulNeLjHQDp1GydPzgw1c8svU=
Date:   Wed, 1 Apr 2020 11:06:24 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Baoquan He <bhe@redhat.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Yiqian Wei <yiwei@redhat.com>
Subject: Re: [PATCH v1 0/2] mm/page_alloc: fix stalls/soft lockups with huge
 VMs
Message-Id: <20200401110624.e5caf6632215004a18a3757b@linux-foundation.org>
In-Reply-To: <20200401144529.7zkqq4rfdnitg32h@ca-dmjordan1.us.oracle.com>
References: <20200401104156.11564-1-david@redhat.com>
        <596d593e-7f36-0e24-6c67-311bd6971e89@redhat.com>
        <CAM9Jb+hYPUZXVLr2T8x6Njcscw_+W0e2SCmr_B1fLZuOwgLZuw@mail.gmail.com>
        <20200401144529.7zkqq4rfdnitg32h@ca-dmjordan1.us.oracle.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Apr 2020 10:45:29 -0400 Daniel Jordan <daniel.m.jordan@oracle.com> wrote:

> On Wed, Apr 01, 2020 at 04:31:51PM +0200, Pankaj Gupta wrote:
> > > On 01.04.20 12:41, David Hildenbrand wrote:
> > > > Two fixes for misleading stall messages / soft lockups with huge nodes /
> > > > zones during boot without CONFIG_PREEMPT.
> > > >
> > > > David Hildenbrand (2):
> > > >   mm/page_alloc: fix RCU stalls during deferred page initialization
> > > >   mm/page_alloc: fix watchdog soft lockups during set_zone_contiguous()
> > > >
> > > >  mm/page_alloc.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > >
> > > Patch #1 requires "[PATCH v3] mm: fix tick timer stall during deferred
> > > page init"
> > >
> > > https://lkml.kernel.org/r/20200311123848.118638-1-shile.zhang@linux.alibaba.com
> > 
> > Thanks! Took me some time to figure it out.
> 
> FYI, I'm planning to post an alternate version of that fix, hopefully today if
> all goes well with my testing.

I assume you'll redo this two-patch series to apply on top of this
forthcoming patch?

