Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD414C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9988722208
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MElu6c9A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgGNLRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 07:17:22 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34594 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727119AbgGNLPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594725352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wo3b72+f5d0wE/+LGqBGg/pHVyxAvNtZLrUUPiNVkWE=;
        b=MElu6c9AjpadHMhKjIf1xATnqMITgHfBaoZFUjBXCy3q56RzNLCiP1IentsOOytk/FFLZS
        MR/7KTnj+qUwED+OZGmnaTx9eMWWMTV+Tbpub2MI5XwdwkJO+HuJYEZppIcJgbttroYGMt
        5T8BhF19OIBeZREZeu9pIa5JUT2el8c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-JAf95g9fOGa8PNJBi69ewg-1; Tue, 14 Jul 2020 07:15:50 -0400
X-MC-Unique: JAf95g9fOGa8PNJBi69ewg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E931100A61D;
        Tue, 14 Jul 2020 11:15:49 +0000 (UTC)
Received: from krava (unknown [10.40.193.14])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3ADFA1CA;
        Tue, 14 Jul 2020 11:15:46 +0000 (UTC)
Date:   Tue, 14 Jul 2020 13:15:45 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: linux-next: build warning after merge of the bpf-next tree
Message-ID: <20200714111545.GI183694@krava>
References: <20200714121608.58962d66@canb.auug.org.au>
 <20200714090048.GG183694@krava>
 <20200714203341.4664dda3@canb.auug.org.au>
 <20200714104702.GH183694@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714104702.GH183694@krava>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 12:47:02PM +0200, Jiri Olsa wrote:
> On Tue, Jul 14, 2020 at 08:33:41PM +1000, Stephen Rothwell wrote:
> 
> SNIP
> 
> > > diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
> > > index 948378ca73d4..a88cd4426398 100644
> > > --- a/tools/bpf/resolve_btfids/Makefile
> > > +++ b/tools/bpf/resolve_btfids/Makefile
> > > @@ -16,6 +16,20 @@ else
> > >    MAKEFLAGS=--no-print-directory
> > >  endif
> > >  
> > > +# always use the host compiler
> > > +ifneq ($(LLVM),)
> > > +HOSTAR  ?= llvm-ar
> > > +HOSTCC  ?= clang
> > > +HOSTLD  ?= ld.lld
> > > +else
> > > +HOSTAR  ?= ar
> > > +HOSTCC  ?= gcc
> > > +HOSTLD  ?= ld
> > > +endif
> > > +AR       = $(HOSTAR)
> > > +CC       = $(HOSTCC)
> > > +LD       = $(HOSTLD)
> > > +
> > >  OUTPUT ?= $(srctree)/tools/bpf/resolve_btfids/
> > >  
> > >  LIBBPF_SRC := $(srctree)/tools/lib/bpf/
> > > 
> > 
> > Thanks for the quick response.  However, in the mean time the bpf-next
> > tree has been merged into the net-next tree, so these fixes will be
> > needed there ASAP.
> 
> I just posted it

ugh, you said net-next..

David, do you need me to repost with net-next tag?
  https://lore.kernel.org/bpf/20200714102534.299280-1-jolsa@kernel.org/T/

jirka

