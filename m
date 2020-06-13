Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FADC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 22:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99EC520789
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 22:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p2eUytlx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgFMWRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 18:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgFMWRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 18:17:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F25C03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 15:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i5R8hGtupULp/LcVllMJa3o6cOtVEr3gO4/vRAJX748=; b=p2eUytlxPR3iPhCZ0KngWubLeM
        zm42uSEM457KwFdzZwuav82XyMjwbtox4oV2A4A7HWqClcOWGfRVHS8sws0VVU4wIwBUMiX3SchMa
        uFsVAnalBx9WEVFAzcZXqpv9WFHV8b+hgtAOboKUtPFEXg4eG9TUMX49nAhU//h8ikPV8zNFiG0RK
        1HrfnY9Rs2dfhZxFE1dxgnu9LHNrRD2fjo1qVZMlVFRfKn7GYIdvLS5+MJevtTuAeMYUZa1jkPciM
        S9djRDiMdXSS+XfnqqG0iJcgzjHUchMmDWrv//HthfDc+4SyFQHln1Z268xc+L1VCvcM432Vnl2YU
        /WANM4aQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkESM-000668-Rm; Sat, 13 Jun 2020 22:16:54 +0000
Date:   Sat, 13 Jun 2020 15:16:54 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [RFC 1/3] lib: copy_{from,to}_user using gup & kmap_atomic()
Message-ID: <20200613221654.GO8681@bombadil.infradead.org>
References: <cover.1591885760.git.afzal.mohd.ma@gmail.com>
 <9e1de19f35e2d5e1d115c9ec3b7c3284b4a4e077.1591885760.git.afzal.mohd.ma@gmail.com>
 <CAK8P3a1XUJHC0kG_Qwh4D4AoxTgCL5ggHd=45yNSmzaYWLUWXw@mail.gmail.com>
 <20200612135538.GA13399@afzalpc>
 <CAK8P3a25ffh_2Y1xKDbkL2xU9nLpGbEq7j6xHdODEwUtavgdwA@mail.gmail.com>
 <20200613120432.GA5319@afzalpc>
 <CAK8P3a2g6a=V4BmPAOM0vNYUfJqm_aZziQhCxfF8MT_fbHMMLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2g6a=V4BmPAOM0vNYUfJqm_aZziQhCxfF8MT_fbHMMLg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 13, 2020 at 10:45:33PM +0200, Arnd Bergmann wrote:
> On Sat, Jun 13, 2020 at 2:04 PM afzal mohammed <afzal.mohd.ma@gmail.com> wrote:
> > Observation is that max. pages reaching copy_{from,to}_user() is 2,
> > observed maximum of n (number of bytes) being 1 page size. i think C
> > library cuts any size read, write to page size (if it exceeds) &
> > invokes the system call. Max. pages reaching 2, happens when 'n'
> > crosses page boundary, this has been observed w/ small size request
> > as well w/ ones of exact page size (but not page aligned).
> 
> Right, this is apparently because tmpfs uses shmem_file_read_iter() to
> copy the file pages one at a time. generic_file_buffered_read() seems
> similar, to copying between an aligned kernel page and address in
> user space that is not page aligned would be an important case to
> optimize for.

This is kind of the nature of the page cache.  The kernel doesn't
necessarily have contiguous memory in the page cache, so it's going to
be split on page boundaries.  This is going to change with my THP series
(I haven't actually changed generic_file_buffered_read(), but it'll
come later).

> > Quickly comparing boot-time on Beagle Bone White, boot time increases
> > by only 4%, perhaps this worry is irrelevant, but just thought will
> > put it across.
> 
> 4% boot time increase sounds like a lot, especially if that is only for
> copy_from_user/copy_to_user. In the end it really depends on how well
> get_user()/put_user() and small copies can be optimized in the end.

The write path should also be paid attention to.  Look at
generic_perform_write() which first calls iov_iter_fault_in_readable()
(for the entire length of the write) and then actually does the copy
later with iov_iter_copy_from_user_atomic().  So you're going to want
to optimise the case where you access the same pages multiple times.

