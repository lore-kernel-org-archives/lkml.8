Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2319DC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5D8D218AC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iRRCcEPO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgDTIGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgDTIGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 04:06:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC619C061A0C;
        Mon, 20 Apr 2020 01:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Vf8hYM2eZOPkLhH5fgdfAeqmsd0pBAaJVj9Hv3nUGRY=; b=iRRCcEPOCB+OYDKNIbSiFvluqm
        h280tgLpDVrw8XD1rLIJp0cdL5BOGOrGdJBkxGvdtyIo7hjcucNZDcVRd1LMvwTj/jf3IEDEI4Rzv
        3O/uzz68cL7AYiJ1EBTDuSowTwPyc5ZyT8hhVjFvcErdxmQ9Ww0KOL21lZ5serLSbkV8mNNmDn6S/
        SwEmM8PyUhXeAvr/Qm9Sm0oC6oN1kxe5Z5OEHFQhX3R45rWDZplYsN3aOkPwxx7u2ZvuHILb6tm/T
        F0JNRCrTLmstdhhe/piFnOOczqg4FlkK2fh05wasPF8/U6u2DdEtR1rm5FHPR3M1ViNQGCFnpRdwl
        4CH2a+vg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQRRw-0004Gg-FZ; Mon, 20 Apr 2020 08:06:40 +0000
Date:   Mon, 20 Apr 2020 01:06:40 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>
Subject: Re: [tip: ras/core] x86/mce: Add a struct mce.kflags field
Message-ID: <20200420080640.GB32592@infradead.org>
References: <20200214222720.13168-4-tony.luck@intel.com>
 <158694418849.28353.16699731019695420884.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158694418849.28353.16699731019695420884.tip-bot2@tip-bot2>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 09:49:48AM -0000, tip-bot2 for Tony Luck wrote:
> The following commit has been merged into the ras/core branch of tip:
> 
> Commit-ID:     1de08dccd383482a3e88845d3554094d338f5ff9
> Gitweb:        https://git.kernel.org/tip/1de08dccd383482a3e88845d3554094d338f5ff9
> Author:        Tony Luck <tony.luck@intel.com>
> AuthorDate:    Fri, 14 Feb 2020 14:27:16 -08:00
> Committer:     Borislav Petkov <bp@suse.de>
> CommitterDate: Tue, 14 Apr 2020 15:58:43 +02:00
> 
> x86/mce: Add a struct mce.kflags field
> 
> There can be many different subsystems register on the mce handler
> chain. Add a new bitmask field and define values so that handlers can
> indicate whether they took any action to log or otherwise handle an
> error.
> 
> The default handler at the end of the chain can use this information to
> decide whether to print to the console log.
> 
> Boris suggested a generic name and leaving plenty of spare bits for
> possible future use.
> 
>  [ bp: Move flag bits to the internal mce.h header and use BIT_ULL(). ]

Err, how can you add a new field to an uapi structure and not break
things?
