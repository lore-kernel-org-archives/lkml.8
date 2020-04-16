Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06794C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 20:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D98AB21744
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 20:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731014AbgDPUIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 16:08:13 -0400
Received: from smtprelay0085.hostedemail.com ([216.40.44.85]:47790 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728776AbgDPUIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 16:08:10 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id ECAD618224D93;
        Thu, 16 Apr 2020 20:08:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: alley89_6406c9b99173f
X-Filterd-Recvd-Size: 2121
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Thu, 16 Apr 2020 20:08:07 +0000 (UTC)
Message-ID: <4a40bfcf1c964bbb9b68a8b7c467a5a770907e4a.camel@perches.com>
Subject: Re: [PATCH v4] mm/ksm: Fix NULL pointer dereference when KSM zero
 page is enabled
From:   Joe Perches <joe@perches.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Xiongchun Duan <duanxiongchun@bytedance.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>
Date:   Thu, 16 Apr 2020 13:05:54 -0700
In-Reply-To: <e620f913-d0fb-7d48-b6b2-d4c6b433b563@virtuozzo.com>
References: <20200416025034.29780-1-songmuchun@bytedance.com>
         <20200415195841.da4361916f662a0136a271a5@linux-foundation.org>
         <516df5d7-b514-11dc-130e-f1a2edce0108@web.de>
         <e620f913-d0fb-7d48-b6b2-d4c6b433b563@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-04-16 at 14:20 +0300, Kirill Tkhai wrote:
> On 16.04.2020 09:14, Markus Elfring wrote:
> > …
> > > > +++ b/mm/ksm.c
> > > > @@ -2112,8 +2112,15 @@ static void cmp_and_merge_page(struct page *page, struct rmap_item *rmap_item)
> > …
> > > > +		if (vma)
> > > > +			err = try_to_merge_one_page(vma, page,
> > > > +					ZERO_PAGE(rmap_item->address));
> > > > +		else
> > > > +			/**
> > > > +			 * If the vma is out of date, we do not need to
> > > > +			 * continue.

trivia:

It's generally better to not use "/**" as that's used for kernel-doc
and this could be a single line like

+			/* If the vma is out of date, no need to continue */

> > > It's conventional to put braces around multi-line blocks such as this.

true

> > Are there different views to consider around the usage of single statements
> > together with curly brackets in if branches?

no

