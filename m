Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E136C35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 19:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1EA20663
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 19:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NvpFi2pN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbgA2TbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 14:31:20 -0500
Received: from merlin.infradead.org ([205.233.59.134]:52300 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgA2TbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 14:31:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mPKhSGzCXQSe05xs1pmWo6QlfzIgdBymEOx6dbVc6AY=; b=NvpFi2pNiSM8B9O2oBcNQYYoO
        ifYEMAzEST4o10GmLrqVPJu7C+7sJqDPKepPXwdv2Kkx7W7egizawuK78Kz31imUiOodzSv8IO8+n
        1DjDMJ5iUas9rmz2SjBfsM/4/ccdl+Uz+IgUKQG+WY+uF7HT92GIt1ACiKRGY9JpInpjDJf2t64Fw
        F2esNU97u3UZ1xf8JhNOulYXpbYONuhIxLBu5GFPW72L0qTtdRRfphOoWfO4s+f8is0yQGCtNCSOH
        Ul0uhQXO097XAG5UECRzjX8EHJOPdbUfOibWnf1+2bmSYl1/fcb9LQ9D6JK3mK8c8UbGOquc+G5SF
        78jHLdeGw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwt3P-0006bK-7o; Wed, 29 Jan 2020 19:31:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2EF79300606;
        Wed, 29 Jan 2020 20:29:26 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 16F582B7337B9; Wed, 29 Jan 2020 20:31:09 +0100 (CET)
Date:   Wed, 29 Jan 2020 20:31:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux/m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 0/5] Rewrite Motorola MMU page-table layout
Message-ID: <20200129193109.GS14914@hirez.programming.kicks-ass.net>
References: <20200129103941.304769381@infradead.org>
 <bbdb9596-583e-5d26-ac1c-4775440059b9@physik.fu-berlin.de>
 <20200129115412.GN14914@hirez.programming.kicks-ass.net>
 <CAOmrzkJ8dsuSnomcE7uhyY9ip6T9ADLT7LhjydvY-hizpikBiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOmrzkJ8dsuSnomcE7uhyY9ip6T9ADLT7LhjydvY-hizpikBiA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 07:52:11AM +1300, Michael Schmitz wrote:
> Peter,
> 
> On Thu, Jan 30, 2020 at 12:54 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Jan 29, 2020 at 11:49:13AM +0100, John Paul Adrian Glaubitz wrote:
> >
> > > > [1] https://wiki.debian.org/M68k/QemuSystemM68k
> >
> > Now, if only debian would actually ship that :/
> >
> > AFAICT that emulates a q800 which is another 68040 and should thus not
> > differ from ARAnyM.
> >
> > I'm fairly confident in the 040 bits, it's the 020/030 things that need
> > coverage.
> 
> I'll take a look - unless this eats up way more kernel memory for page
> tables, it should still boot on my Falcon.

It should actually be better in most cases I think, since we no longer
require all 16 pte-tables to map consecutive (virtual) memory.
