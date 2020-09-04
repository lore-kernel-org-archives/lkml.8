Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DB5C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 07:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCF3320748
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 07:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbgIDHya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 03:54:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:50036 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgIDHya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 03:54:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 59D86AD03;
        Fri,  4 Sep 2020 07:54:30 +0000 (UTC)
Date:   Fri, 4 Sep 2020 09:54:29 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: support symtab_shndx during dump
In-Reply-To: <20200903153545.zy24o7pqfohgoxge@treble>
Message-ID: <alpine.LSU.2.21.2009040921470.22451@pobox.suse.cz>
References: <20200812175712.9462-1-kristen@linux.intel.com> <20200903153545.zy24o7pqfohgoxge@treble>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Sep 2020, Josh Poimboeuf wrote:

> On Wed, Aug 12, 2020 at 10:57:11AM -0700, Kristen Carlson Accardi wrote:
> 
> >  			if (GELF_ST_TYPE(sym.st_info) == STT_SECTION) {
> > -				scn = elf_getscn(elf, sym.st_shndx);
> > +				if ((sym.st_shndx > SHN_UNDEF &&
> > +				     sym.st_shndx < SHN_LORESERVE) ||
> > +				    (xsymtab && sym.st_shndx == SHN_XINDEX)) {
> > +					if (sym.st_shndx != SHN_XINDEX)
> > +						shndx = sym.st_shndx;
> 
> The sym.st_shndx checks are redundant, if 'sym.st_shndx == SHN_XINDEX'
> then 'sym.st_shndx != SHN_XINDEX' can't be true.

It is probably a copy-paste from read_symbols() in elf.c, where the logic 
is different.

> Actually I think this can be even further simplified to something like
> 
> 				if (!shndx)
> 					shndx = sym.st_shndx;

This relies on the fact that gelf_getsymshndx() always initializes shndx, 
no? I think it would be better to initialize it in orc_dump() too. Safer 
and easier to read. It applies to Kristen's patch as well. I missed that.

Miroslav
