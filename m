Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494F0C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E089205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ia1N6OmI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgCQOIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:08:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46328 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgCQOIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 10:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RIkqeCGkzTQAKwqtRyvdstXXI+gDsJqkU9w2ugRYyXY=; b=Ia1N6OmI6/cmy3MLUChU86ZOCf
        nfT8xtI+cBykSKQmnH75LpqW7zMmEYkd7xGEKGq+EclUdicyNR1RldCPVw7qWT/GD5HyL4ckoSm1/
        5fDYYMP08g1EdocrXOQdbm3CuRmPtrydYz/6xWPtysE6ISzGzPsYWV5L5moSduAlusjlp1K+yTdOy
        2TVWka9HcU6cRbY+eGint+w4MuIHj8j+Se4n2nl8kSi7BvCdMyBRf3G+jK/43UIMa4bpHd0KCpI9W
        UNEMOTODT54GAKRjzFD7aTBHpxJvhQBGzbV3rAFoNEsnzDjc+A0ll0d8ZJU3QKy69EKJK9jeMRSJ2
        58yJtqzg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jECtU-00081V-BG; Tue, 17 Mar 2020 14:08:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 50DE2300606;
        Tue, 17 Mar 2020 15:08:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1C51D20B14B19; Tue, 17 Mar 2020 15:08:29 +0100 (CET)
Date:   Tue, 17 Mar 2020 15:08:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     tglx@linutronix.de, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC][PATCH 05/16] objtool: Optimize find_symbol_by_index()
Message-ID: <20200317140829.GA20730@hirez.programming.kicks-ass.net>
References: <20200312134107.700205216@infradead.org>
 <20200312135041.699859794@infradead.org>
 <alpine.LSU.2.21.2003171253180.2339@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2003171253180.2339@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 12:55:01PM +0100, Miroslav Benes wrote:
> > --- a/tools/objtool/elf.h
> > +++ b/tools/objtool/elf.h
> > @@ -27,7 +27,6 @@ struct section {
> >  	struct list_head list;
> >  	GElf_Shdr sh;
> >  	struct list_head symbol_list;
> > -	DECLARE_HASHTABLE(symbol_hash, 8);
> >  	struct list_head rela_list;
> >  	DECLARE_HASHTABLE(rela_hash, 16);
> >  	struct section *base, *rela;
> > @@ -71,7 +70,7 @@ struct elf {
> >  	int fd;
> >  	char *name;
> >  	struct list_head sections;
> > -	DECLARE_HASHTABLE(rela_hash, 16);
> > +	DECLARE_HASHTABLE(symbol_hash, 20);
> >  };
> 
> Not that it really matters, but what was rela_hash in struct elf for 
> before this?

Unused afaict.
