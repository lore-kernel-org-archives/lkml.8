Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1F6C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5942A2074A
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bhw+6TPC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbgIDOSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 10:18:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39537 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730664AbgIDOR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 10:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599229046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NhbmgM9CAg/pgwM5tMOYVETsgotjMfnAS44cxXVk1W4=;
        b=bhw+6TPC1uY4OmC+//S+lTqzfhlVuU3hVGHYT9Jqywij+EkETnyLBhRIvh/1JM+Te/yY4t
        mB0475osk6kTaqhUstlAImBLcprvGIZ41WFpBS1EwDX8eGjC8qSTagcQOOtFvjJ+ReYiT6
        qFdg/Yk1YK5I/4O48rGiepWqBojRdBU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-xcDdSwKEPsO7Fw6FvzN5vQ-1; Fri, 04 Sep 2020 10:17:25 -0400
X-MC-Unique: xcDdSwKEPsO7Fw6FvzN5vQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6EB618BA285;
        Fri,  4 Sep 2020 14:17:23 +0000 (UTC)
Received: from treble (ovpn-117-138.rdu2.redhat.com [10.10.117.138])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E0B460C0F;
        Fri,  4 Sep 2020 14:17:22 +0000 (UTC)
Date:   Fri, 4 Sep 2020 09:17:20 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: support symtab_shndx during dump
Message-ID: <20200904141720.qdnesfk3dxl3rlpz@treble>
References: <20200812175712.9462-1-kristen@linux.intel.com>
 <20200903153545.zy24o7pqfohgoxge@treble>
 <alpine.LSU.2.21.2009040921470.22451@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2009040921470.22451@pobox.suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 09:54:29AM +0200, Miroslav Benes wrote:
> On Thu, 3 Sep 2020, Josh Poimboeuf wrote:
> 
> > On Wed, Aug 12, 2020 at 10:57:11AM -0700, Kristen Carlson Accardi wrote:
> > 
> > >  			if (GELF_ST_TYPE(sym.st_info) == STT_SECTION) {
> > > -				scn = elf_getscn(elf, sym.st_shndx);
> > > +				if ((sym.st_shndx > SHN_UNDEF &&
> > > +				     sym.st_shndx < SHN_LORESERVE) ||
> > > +				    (xsymtab && sym.st_shndx == SHN_XINDEX)) {
> > > +					if (sym.st_shndx != SHN_XINDEX)
> > > +						shndx = sym.st_shndx;
> > 
> > The sym.st_shndx checks are redundant, if 'sym.st_shndx == SHN_XINDEX'
> > then 'sym.st_shndx != SHN_XINDEX' can't be true.
> 
> It is probably a copy-paste from read_symbols() in elf.c, where the logic 
> is different.

Yeah.

> > Actually I think this can be even further simplified to something like
> > 
> > 				if (!shndx)
> > 					shndx = sym.st_shndx;
> 
> This relies on the fact that gelf_getsymshndx() always initializes shndx, 
> no? I think it would be better to initialize it in orc_dump() too. Safer 
> and easier to read. It applies to Kristen's patch as well. I missed that.

Agreed.

-- 
Josh

