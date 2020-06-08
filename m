Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E2CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 11:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6C8B2072F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 11:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VDKUeP5n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbgFHLvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 07:51:33 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57561 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729568AbgFHLvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 07:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591617089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fnLQOqCm9fYymeAqY+q40GtLrdA7AapZIlufFwxKbYQ=;
        b=VDKUeP5nqNIsA+/hE+IKj27HN0yLPsTVyh8a1wyp2ctZ0Lqx+nKYXu+qprhtEppVpL9+H6
        emefCeUbWDGdJltYy9q6thIaSBnvDIenXVB6gO3gEgqg9LNgMcBNYATkdKW6mbKWHbcso0
        sW3TyawGtrI8MXtuE3B+ocRau5E4+po=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-rEMiqG34PUu2h8InmVOLCQ-1; Mon, 08 Jun 2020 07:51:26 -0400
X-MC-Unique: rEMiqG34PUu2h8InmVOLCQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93900107ACCD;
        Mon,  8 Jun 2020 11:51:24 +0000 (UTC)
Received: from elisabeth (unknown [10.36.110.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D3E6B5C1C5;
        Mon,  8 Jun 2020 11:51:21 +0000 (UTC)
Date:   Mon, 8 Jun 2020 13:51:14 +0200
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] lib: Add test for bitmap_cut()
Message-ID: <20200608135114.44ae7962@elisabeth>
In-Reply-To: <CAHp75Vfvx6wKJUKfgDjyEcPthT9BicoZqfZmaS8eKMFwgvVphg@mail.gmail.com>
References: <cover.1591606281.git.sbrivio@redhat.com>
        <3e3ab7a4756df2ecf8fb012f16c375d4cd714552.1591606281.git.sbrivio@redhat.com>
        <20200608101214.GE2428291@smile.fi.intel.com>
        <20200608122702.034c8c80@redhat.com>
        <CAHp75Vfvx6wKJUKfgDjyEcPthT9BicoZqfZmaS8eKMFwgvVphg@mail.gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jun 2020 14:31:02 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Jun 8, 2020 at 1:29 PM Stefano Brivio <sbrivio@redhat.com> wrote:
> > On Mon, 8 Jun 2020 13:12:14 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:  
> > > On Mon, Jun 08, 2020 at 11:13:29AM +0200, Stefano Brivio wrote:  
> > > > Based on an original patch by Yury Norov: introduce a test for
> > > > bitmap_cut() that also makes sure functionality is as described for
> > > > partially overlapping src and dst.  
> > >  
> > > > Co-authored-by: Yury Norov <yury.norov@gmail.com>  
> > >
> > > Co-developed-by (and it requires Yury's SoB as well).  
> >
> > Oops, sorry, I didn't remember this part from submitting-patches.rst
> > correctly. Thanks for pointing this out.
> >
> > Yury, let me know if I should re-post with both Co-authored-by: and  
> 
> Co-developed-by: :-)

Grrr. That! :)

> > Signed-off-by: you -- otherwise I'll repost without both.  
> 
> ...
> 
> > > > +           if (!bitmap_equal(out, t->expected, t->nbits)) {
> > > > +                   pr_err("bitmap_cut failed: expected %*pb, got %*pb\n",
> > > > +                          t->nbits, t->expected, t->nbits, out);
> > > > +           }  
> > >
> > > Perhaps
> > >
> > >       if (bitmap_equal(...))
> > >               continue;
> > >
> > >       ...
> > >
> > > ?  
> >
> > That's five lines instead of four (I can't get pr_err() on one line
> > anyway) and it looks less straightforward: "if it doesn't match we have
> > an error" vs. "if it matches go to next case. We have an error". Any
> > specific reason I'm missing?  
> 
> Actually, please use one of suitable expect_eq_*() macro or add your
> own. Because above has an inconsistent format with the rest.

Whoops, I see now. Yes, expect_eq_bitmap() will do, I'll change this in
v2.

-- 
Stefano

