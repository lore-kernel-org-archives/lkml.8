Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3656C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D7592071A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ey7HSMC6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731369AbgFOSop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 14:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729842AbgFOSop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 14:44:45 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AEEC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 11:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V4Io7ePzwvS2kGHr75GUeXtx2wRmDZTAfJ1o45dyoU0=; b=Ey7HSMC631dFQ86f6xCE8dg6B+
        CqCVa6hi5Lgh55svpKuyL5aQQquI+sZi5KvoGu1So8cOP2t3ypqRTJ9UtK1+W+0bdp2IgWAcMA2JB
        FbmmzmCaVCApZpm9wc94clWO9nd3TcJIth5QxD8JrnWXEQji2W9Z2L0EU1rQ5S1cR4yqGXVpThyUT
        I5jnCNNKBT3sUZPE1V/OqNkeEteIGdXgSqOemZOQZHHZLfrycGGMeNW4DBFXzZYz2EqnO4rqUpEbE
        cax+vi/LmDFOLGxZUjMmtjA6DSM7W4Icu1wmyVTpk0/DHGRH0slXx1UBuQBen2tuqAN8WkamzZGxC
        eeyT7Nsw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jku5d-0004Gh-0s; Mon, 15 Jun 2020 18:44:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 803E93028C8;
        Mon, 15 Jun 2020 20:44:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5A65C203B8160; Mon, 15 Jun 2020 20:44:11 +0200 (CEST)
Date:   Mon, 15 Jun 2020 20:44:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matt Helsley <mhelsley@vmware.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, dvyukov@google.com,
        elver@google.com, andreyknvl@google.com, mark.rutland@arm.com,
        rostedt@goodmis.org, jthierry@redhat.com, mbenes@suse.cz
Subject: Re: [RFC][PATCH 1/3] objtool: Clean up elf_write() condition
Message-ID: <20200615184411.GH2531@hirez.programming.kicks-ass.net>
References: <20200612143034.933422660@infradead.org>
 <20200612143553.953897818@infradead.org>
 <20200615183448.GD25598@rlwimi.vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615183448.GD25598@rlwimi.vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 11:34:48AM -0700, Matt Helsley wrote:
> On Fri, Jun 12, 2020 at 04:30:35PM +0200, Peter Zijlstra wrote:
> > With there being multiple ways to change the ELF data, let's more
> > concisely track modification.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Would it make sense to set the relocation section's "changed" flag in
> addition to the elf struct's changed flag in elf_rebuild_reloc_section()?
> 
> Right now I think the code is  assuming that it's a newly created section
> but it would be more defensive to set it during a rebuild too I think.

Indeed, currently the code assumes (and this is so) elf_rebuild_rela_sections()
is only called on an elf_create_reloc_section() result and thus setting
->changed is superfluous.

But sure, I can certainly set them there too.
