Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B51C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 703EE20767
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598978503;
	bh=Dpj3KMcxE1VLvM7pvNMakfITVTdblxRjjMAZljRkcDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LbVPC79/mRjo15MIJPhnVdlUqN55r3Pf5ZI1GU1H3q4TBYh0KUOBvjmh+k3TBt4gz
	 fBEGnXle60+iXwBeUfdD2yNgAMHaO4q0X0o12MxqDUpMf16Xd5Blof5oE3azTfC2Tu
	 bZhZChcayrnkMCvfnEEyhheHahT6I7ucvHpet1QY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732108AbgIAQll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:41:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:36984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730413AbgIAQle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 12:41:34 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0E5C20767;
        Tue,  1 Sep 2020 16:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598978493;
        bh=Dpj3KMcxE1VLvM7pvNMakfITVTdblxRjjMAZljRkcDU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WvjCz2qBgk+FjDtaXrxOLkuzmSpoC4TPO6NJF7n+CDvIMNWJQWf99TvOqppqIMqw8
         6AhmQ6HzzYRQSIMUnBHMLF7hekb3DnxI1zqCnflew4pbnq/sR2xUas2XQNIH19JdHZ
         F9Syn/FXhE0QGH+nz2WFVMtNgTW0oGlziYXvCKB0=
Date:   Tue, 1 Sep 2020 09:41:32 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     willy@infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/7] mm: Make more use of readahead_control
Message-ID: <20200901164132.GD669796@gmail.com>
References: <159897769535.405783.17587409235571100774.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159897769535.405783.17587409235571100774.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 05:28:15PM +0100, David Howells wrote:
> 
> Hi Willy,
> 
> Here's a set of patches to expand the use of the readahead_control struct,
> essentially from do_sync_mmap_readahead() down.  Note that I've been
> passing the number of pages to read in rac->_nr_pages, and then saving it
> and changing it certain points, e.g. page_cache_readahead_unbounded().
> 
> Also pass file_ra_state into force_page_cache_readahead().
> 
> Also there's an apparent minor bug in khugepaged.c that I've included a
> patch for: page_cache_sync_readahead() looks to be given the wrong size in
> collapse_file().
> 

What branch does this apply to?

- Eric
