Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D27C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 17:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B258F20B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 17:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597858860;
	bh=e4VWfb9ywUeb7sqzFNdc4jPCrcgVnIKkbzQRdNhonQU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=OBvgaWFjWv8hbIgBd51w6LC7iv1EhUwcNXuzbTBNcVrqjb3LFJLh+IxEBi3rDXDeS
	 ZKQtJYg5vOHRmHXSylGpMfrclsvsFs9TLllNaQfECWjoJV8pdNmVUyYa7i52YOEBFo
	 poidqL4rQBYKLAU59YqIpW7DnMO9JTDs2ilnrs9I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgHSRk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 13:40:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgHSRk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 13:40:58 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBD23207DE;
        Wed, 19 Aug 2020 17:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597858858;
        bh=e4VWfb9ywUeb7sqzFNdc4jPCrcgVnIKkbzQRdNhonQU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d3HSDCtKR+S7WQPy1e2acz7Bymkz77u9pDlh8CsUzJg2IYm6/TvQQfxElJ74t8ZQl
         g3cRk9mplTMHgbKs44YC1q38ZkdjMTrbb+Y/P5sa9T3bqRC0cFd97QBadBf8u+whj6
         5kpjSSmDlvCxRxhuJ3xoc35PS+uk/7Rosy7yxMz4=
Date:   Wed, 19 Aug 2020 10:40:57 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Doug Berger <opendmb@gmail.com>, Jason Baron <jbaron@akamai.com>,
        David Rientjes <rientjes@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: include CMA pages in lowmem_reserve at boot
Message-Id: <20200819104057.4b91898b76302b7b1c3e8e56@linux-foundation.org>
In-Reply-To: <50ad53dc-faf2-3014-bac3-be370b972f59@gmail.com>
References: <1597423766-27849-1-git-send-email-opendmb@gmail.com>
        <20200818201817.351499e75cba2a84e8bf33e6@linux-foundation.org>
        <e22cbcdc-e9ce-50b7-aa88-6a3579ffd509@gmail.com>
        <20200819102214.32238093b116ab6f1c5c7b73@linux-foundation.org>
        <50ad53dc-faf2-3014-bac3-be370b972f59@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Aug 2020 10:30:25 -0700 Florian Fainelli <f.fainelli@gmail.com> wrote:

> On 8/19/20 10:22 AM, Andrew Morton wrote:
> > On Wed, 19 Aug 2020 10:15:53 -0700 Florian Fainelli <f.fainelli@gmail.com> wrote:
> > 
> >>>> In many cases the difference is not significant, but for example
> >>>> an ARM platform with 1GB of memory and the following memory layout
> >>>> [    0.000000] cma: Reserved 256 MiB at 0x0000000030000000
> >>>> [    0.000000] Zone ranges:
> >>>> [    0.000000]   DMA      [mem 0x0000000000000000-0x000000002fffffff]
> >>>> [    0.000000]   Normal   empty
> >>>> [    0.000000]   HighMem  [mem 0x0000000030000000-0x000000003fffffff]
> >>>>
> >>>> would result in 0 lowmem_reserve for the DMA zone. This would allow
> >>>> userspace to deplete the DMA zone easily.
> >>>
> >>> Sounds fairly serious for thos machines.  Was a cc:stable considered?
> >>
> >> Since there is a Fixes: tag, it may have been assumed that the patch
> >> would be picked up and as soon as it reaches Linus' tree it would be
> >> picked up by the stable selection.
> > 
> > It doesn't work that way - sometimes a fix isn't considered important
> > enough to backport.  It could just fix a typo in a comment!
> 
> Then can this be applied ASAP and back ported?

Sure.
