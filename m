Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F871C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 13:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E196120829
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 13:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NT0JKZu1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbgG3NWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 09:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgG3NWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 09:22:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D37C061794
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 06:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wcPyE4+cPQF2p348dprC1q/nCXnWrHlXNo+LiKFxU9c=; b=NT0JKZu1sNprgCq89FvOkPnuOA
        O7GShg8Baj2xualxn0r//kz6dxm8pUnpLMkS1+MfO7wv8THh15aLntzgTGP81xuHkPCFLq2iUC9jZ
        B1u354qTKAb8QPHhwEa5WANwSb76+MCBAGWmyIlRwhJszxFSQtMCddHwEnLUthMqmSMbU/fxQU6vO
        iti/wW7L0zJEkWI9BrbeILJDX6vcCrvQ1XOgq/qUeHop6F098yfV7uIIzxdITYKmS6UYNElIKfka4
        W3n8mcrmn+hRtb7e3EcUgoTVw5qekWXUnbnzYVRN42F2u+LvD3eyLSoiMOQ6xweEAKenOQ9t8rHrr
        AvH+omKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k18W8-0007Rg-Bq; Thu, 30 Jul 2020 13:22:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0F73C30411F;
        Thu, 30 Jul 2020 15:22:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D8F3B203DB3CD; Thu, 30 Jul 2020 15:22:37 +0200 (CEST)
Date:   Thu, 30 Jul 2020 15:22:37 +0200
From:   peterz@infradead.org
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        mhelsley@vmware.com, mbenes@suse.cz
Subject: Re: [PATCH v3 2/4] objtool: Move orc outside of check
Message-ID: <20200730132237.GM2655@hirez.programming.kicks-ass.net>
References: <20200730094143.27494-1-jthierry@redhat.com>
 <20200730094143.27494-3-jthierry@redhat.com>
 <20200730095759.GH2655@hirez.programming.kicks-ass.net>
 <dfe69c8f-db70-8366-5601-2592409ce7a0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfe69c8f-db70-8366-5601-2592409ce7a0@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 01:40:42PM +0100, Julien Thierry wrote:
> 
> 
> On 7/30/20 10:57 AM, peterz@infradead.org wrote:
> > On Thu, Jul 30, 2020 at 10:41:41AM +0100, Julien Thierry wrote:
> > > +		if (file->elf->changed)
> > > +			return elf_write(file->elf);
> > > +		else
> > > +			return 0;
> > >   	}
> > 
> > I think we can do without that else :-)
> > 
> 
> I did wonder and was not 100% confident about it, but the orc gen will
> always change the file, correct?

Not if it already has orc, iirc.

But what I was trying to say is that:

	if (file->elf->changed)
		return elf_write(file->elf)

	return 0;

is identical code and, IMO, easier to read.
