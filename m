Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA8CC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 00:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E960A20810
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 00:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbgE3Awp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 20:52:45 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:35537 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728297AbgE3Awp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 20:52:45 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Fri, 29 May 2020 17:52:40 -0700
Received: from localhost (unknown [10.200.192.41])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id EF45440996;
        Fri, 29 May 2020 17:52:44 -0700 (PDT)
Date:   Fri, 29 May 2020 17:52:44 -0700
From:   Matt Helsley <mhelsley@vmware.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>
Subject: Re: [PATCH 1/2] objtool: Rename rela to reloc
Message-ID: <20200530005244.GZ9040@rlwimi.vmware.com>
Mail-Followup-To: Matt Helsley <mhelsley@vmware.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>
References: <cover.1590785960.git.mhelsley@vmware.com>
 <39f183f3acec8a758939dcbede7908a7455be8b8.1590785960.git.mhelsley@vmware.com>
 <20200529232200.xhjaemclbg2uqrih@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200529232200.xhjaemclbg2uqrih@treble>
Received-SPF: None (EX13-EDG-OU-001.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 06:22:00PM -0500, Josh Poimboeuf wrote:
> On Fri, May 29, 2020 at 02:01:13PM -0700, Matt Helsley wrote:
> > Before supporting additional relocation types rename the relevant
> > types and functions from "rela" to "reloc". This work be done with
> > the following regex:
> > 
> > 	sed -i -e 's/struct rela/struct reloc/g' \
> > 		-e 's/\([_\*]\)rela\(s\{0,1\}\)/\1reloc\2/g' \
> > 		-e 's/tmprela\(s\{0,1\}\)/tmpreloc\1/g' \
> > 		-e 's/relasec/relocsec/g' \
> > 		-e 's/rela_list/reloc_list/g' \
> > 		-e 's/rela_hash/reloc_hash/g' \
> > 		-e 's/add_rela/add_reloc/g' \
> > 		-e 's/rela->/reloc->/g' \
> > 		-e '/rela[,\.]/{ s/\([^\.>]\)rela\([\.,]\)/\1reloc\2/g ; }' \
> > 		-e 's/rela =/reloc =/g' \
> > 		-e 's/relas =/relocs =/g' \
> > 		-e 's/relas\[/relocs[/g' \
> > 		-e 's/relaname =/relocname =/g' \
> > 		-e 's/= rela\;/= reloc\;/g' \
> > 		-e 's/= relas\;/= relocs\;/g' \
> > 		-e 's/= relaname\;/= relocname\;/g' \
> > 		-e 's/, rela)/, reloc)/g' \
> > 		-e 's/, relaname/, relocname/g' \
> > 		-e 's/sec->rela/sec->reloc/g' \
> > 		-e 's/(\(!\{0,1\}\)rela/(\1reloc/g' \
> > 		arch.h \
> > 		arch/x86/decode.c  \
> > 		check.c \
> > 		check.h \
> > 		elf.c \
> > 		elf.h \
> > 		orc_gen.c \
> > 		special.c \
> 
> Holy regex!  Thanks for doing that :-)

So I was rebasing my future patches and I found a few spots where
objtool warning strings and code comments weren't fixed-up to
consistent. Here's the new, complete regex -- it includes the original
changes and the missed bits (e.g. note the new substitution for @rela
comments):

sed -i -e 's/struct rela/struct reloc/g' \
        -e 's/\([_\*]\)rela\(s\{0,1\}\)/\1reloc\2/g' \
        -e 's/tmprela\(s\{0,1\}\)/tmpreloc\1/g' \
        -e 's/relasec/relocsec/g' \
        -e 's/rela_list/reloc_list/g' \
        -e 's/rela_hash/reloc_hash/g' \
        -e 's/add_rela/add_reloc/g' \
        -e 's/rela->/reloc->/g' \
        -e '/rela[,\.]/{ s/\([^\.>]\)rela\([\.,]\)/\1reloc\2/g ; }' \
        -e 's/rela =/reloc =/g' \
        -e 's/relas =/relocs =/g' \
        -e 's/relas\[/relocs[/g' \
        -e 's/relaname =/relocname =/g' \
        -e 's/= rela\;/= reloc\;/g' \
        -e 's/= relas\;/= relocs\;/g' \
        -e 's/= relaname\;/= relocname\;/g' \
        -e 's/, rela)/, reloc)/g' \
        -e 's/\([ @]\)rela\([ "]\)/\1reloc\2/g' \
        -e 's/ rela$/ reloc/g' \
        -e 's/, relaname/, relocname/g' \
        -e 's/sec->rela/sec->reloc/g' \
        -e 's/(\(!\{0,1\}\)rela/(\1reloc/g' \
        arch.h \
        arch/x86/decode.c  \
        check.c \
        check.h \
        elf.c \
        elf.h \
        orc_gen.c \
        special.c

If you want to fixup this commit you could just re-run the regex after
applying it but before applying the next commit.

Cheers,
	-Matt Helsley

