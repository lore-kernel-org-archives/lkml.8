Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E733BCA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 16:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFC2020752
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 16:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589299873;
	bh=B/QyDqBFh4UG8qEGIGYgPAZDeR/CDDdUH5vW17rFKwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SHOgJhPJm2J4YeapkGMAhnxlYy6h3WFU6gWkSJdyODqBgWx1YCfGQIjZn2PHkEt+V
	 ZJbIwoAjxoYbxUgetmSfu4oEeYT+1pUSorc5zrPmN93Iej61Lf790Pd4MAvB+4D+RW
	 RDHktx03qqtx3dpe/n8Y2tZvwO1tqSa1ldxHinFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgELQLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 12:11:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:49324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbgELQLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 12:11:12 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D86D20736;
        Tue, 12 May 2020 16:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589299872;
        bh=B/QyDqBFh4UG8qEGIGYgPAZDeR/CDDdUH5vW17rFKwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WRrmWf9clym3H/36B2kwMWll9n9DO3kvqC4cg+TmcoehPDQ4ywaSlneJniNSrR3PJ
         OkYmg7mokvmm9DlB+LDSjPawIIP/9cTKByX45R7qAmrZxqybHRrtR3fo+Gj1XYg4Eg
         qZcCYgj0LNrQvMXluXummnWZdG7kYNR6IcQ6gCug=
Date:   Tue, 12 May 2020 19:11:07 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <adech.fo@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Ingo Molnar <mingo@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Michal Marek <mmarek@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH rdma-next 0/2] Fix kasan compilation warnings
Message-ID: <20200512161107.GL4814@unreal>
References: <20200512063728.17785-1-leon@kernel.org>
 <CAAeHK+zFDoykmS3KD88hD3S8R09n064c7n1gLDurMr0KOhte5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+zFDoykmS3KD88hD3S8R09n064c7n1gLDurMr0KOhte5A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 05:34:10PM +0200, Andrey Konovalov wrote:
> On Tue, May 12, 2020 at 8:37 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > Hi,
> >
> > The following two fixes are adding missing function prototypes
> > declarations to internal kasan header in order to eliminate compilation
> > warnings.
> >
> > Thanks
> >
> > Leon Romanovsky (2):
> >   kasan: fix compilation warnings due to missing function prototypes
> >   kasan: add missing prototypes to fix compilation warnings
>
> Hi Leon,
>
> I've mailed a series with slightly different/fuller fixes for these issues.
>
> Thanks for the report!

No problem, thanks for taking care.
