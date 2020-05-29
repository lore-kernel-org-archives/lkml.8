Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D15BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 23:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B379207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 23:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NGaxJQxI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbgE2XWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 19:22:10 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39126 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726898AbgE2XWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 19:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590794528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8A5G+qFYuCrXOOgykP56EexnSdFAp2t0M/7TVEW0xww=;
        b=NGaxJQxIO8WrVYGWpb6tNzNEpZYlIw3L9+bGYwKJc49nh7mPCK3uBLctW3SaoC9KefFKyo
        VA5fcDlrwU0FBRof9ch9OJJWl65kNSRZe5eZbCr/rWJPexLnohSCPI67yTyoJniSjLL4zI
        8+oocQG+5WKw1e6kdhsHaxAZjbhwlUc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-h2o-eJEbNOG9FbvpR5OAdA-1; Fri, 29 May 2020 19:22:04 -0400
X-MC-Unique: h2o-eJEbNOG9FbvpR5OAdA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 791561800D42;
        Fri, 29 May 2020 23:22:03 +0000 (UTC)
Received: from treble (ovpn-116-170.rdu2.redhat.com [10.10.116.170])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A916760BE2;
        Fri, 29 May 2020 23:22:02 +0000 (UTC)
Date:   Fri, 29 May 2020 18:22:00 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Matt Helsley <mhelsley@vmware.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>
Subject: Re: [PATCH 1/2] objtool: Rename rela to reloc
Message-ID: <20200529232200.xhjaemclbg2uqrih@treble>
References: <cover.1590785960.git.mhelsley@vmware.com>
 <39f183f3acec8a758939dcbede7908a7455be8b8.1590785960.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <39f183f3acec8a758939dcbede7908a7455be8b8.1590785960.git.mhelsley@vmware.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 02:01:13PM -0700, Matt Helsley wrote:
> Before supporting additional relocation types rename the relevant
> types and functions from "rela" to "reloc". This work be done with
> the following regex:
> 
> 	sed -i -e 's/struct rela/struct reloc/g' \
> 		-e 's/\([_\*]\)rela\(s\{0,1\}\)/\1reloc\2/g' \
> 		-e 's/tmprela\(s\{0,1\}\)/tmpreloc\1/g' \
> 		-e 's/relasec/relocsec/g' \
> 		-e 's/rela_list/reloc_list/g' \
> 		-e 's/rela_hash/reloc_hash/g' \
> 		-e 's/add_rela/add_reloc/g' \
> 		-e 's/rela->/reloc->/g' \
> 		-e '/rela[,\.]/{ s/\([^\.>]\)rela\([\.,]\)/\1reloc\2/g ; }' \
> 		-e 's/rela =/reloc =/g' \
> 		-e 's/relas =/relocs =/g' \
> 		-e 's/relas\[/relocs[/g' \
> 		-e 's/relaname =/relocname =/g' \
> 		-e 's/= rela\;/= reloc\;/g' \
> 		-e 's/= relas\;/= relocs\;/g' \
> 		-e 's/= relaname\;/= relocname\;/g' \
> 		-e 's/, rela)/, reloc)/g' \
> 		-e 's/, relaname/, relocname/g' \
> 		-e 's/sec->rela/sec->reloc/g' \
> 		-e 's/(\(!\{0,1\}\)rela/(\1reloc/g' \
> 		arch.h \
> 		arch/x86/decode.c  \
> 		check.c \
> 		check.h \
> 		elf.c \
> 		elf.h \
> 		orc_gen.c \
> 		special.c \

Holy regex!  Thanks for doing that :-)

I'll run these through testing and merge.

-- 
Josh

