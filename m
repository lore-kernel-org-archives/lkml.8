Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA4EC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ED432072D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388596AbgF3OOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 10:14:39 -0400
Received: from smtprelay0085.hostedemail.com ([216.40.44.85]:48984 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727773AbgF3OOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 10:14:39 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 2E210181D3028;
        Tue, 30 Jun 2020 14:14:38 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: crown41_290f39a26e78
X-Filterd-Recvd-Size: 3023
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Tue, 30 Jun 2020 14:14:36 +0000 (UTC)
Message-ID: <b370f8bfbf2bfc958b15ce6f6d138bec64972183.camel@perches.com>
Subject: Re: [PATCH] mm: util: update the kerneldoc for kstrdup_const()
From:   Joe Perches <joe@perches.com>
To:     David Hildenbrand <david@redhat.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 30 Jun 2020 07:14:35 -0700
In-Reply-To: <98163576-c98e-77f7-17a7-efd04dc2e86f@redhat.com>
References: <20200628152500.17916-1-brgl@bgdev.pl>
         <693db5a878ac09994e2a27c64cb14c0e552f3f50.camel@perches.com>
         <7f1439be-75c4-3a07-ab7b-f4505bf30c48@redhat.com>
         <644c67ae316bde28669f660aa5aade274d19a2d0.camel@perches.com>
         <98163576-c98e-77f7-17a7-efd04dc2e86f@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-06-30 at 10:57 +0200, David Hildenbrand wrote:
> On 29.06.20 21:21, Joe Perches wrote:
> > On Mon, 2020-06-29 at 12:54 +0200, David Hildenbrand wrote:
> > > On 28.06.20 19:37, Joe Perches wrote:
> > > > On Sun, 2020-06-28 at 17:25 +0200, Bartosz Golaszewski wrote:
> > > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > > > 
> > > > > Memory allocated with kstrdup_const() must not be passed to regular
> > > > > krealloc() as it is not aware of the possibility of the chunk residing
> > > > > in .rodata. Since there are no potential users of krealloc_const()
> > > > > at the moment, let's just update the doc to make it explicit.
> > > > 
> > > > Another option would be to return NULL if it's
> > > > used from krealloc with a pointer into rodata
> > []
> > > > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > []
> > > > @@ -1683,6 +1683,9 @@ static __always_inline void *__do_krealloc(const void *p, size_t new_size,
> > > >   * @new_size: how many bytes of memory are required.
> > > >   * @flags: the type of memory to allocate.
> > > >   *
> > > > + * If the object pointed to is in rodata (likely from kstrdup_const)
> > > > + * %NULL is returned.
> > > > + *
> > []
> > > Won't we have similar issues if somebody would do a kfree() instead of a
> > > kfree_const()? So I think the original patch makes sense.
> > 
> > Which is why I also suggested making kfree work for
> > more types of memory freeing earlier this month.
> > 
> > https://lore.kernel.org/lkml/573b3fbd5927c643920e1364230c296b23e7584d.camel@perches.com/
[]
> what's the real benefit that is worth spending extra runtime cycles?

I very much doubt there is an actual instance
where the runtime cycles matter.  Where could
there be a fast-path instance of free?

ANd kvfree consolidation and coding simplicity
make it somewhat useful.


