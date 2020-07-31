Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58C8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 07:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8E1F207F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 07:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731739AbgGaH4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 03:56:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:43628 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731684AbgGaH4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 03:56:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 88BCFACDF;
        Fri, 31 Jul 2020 07:56:55 +0000 (UTC)
Date:   Fri, 31 Jul 2020 09:56:42 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Julien Thierry <jthierry@redhat.com>
cc:     Josh Poimboeuf <jpoimboe@redhat.com>, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] objtool: Move orc outside of check
In-Reply-To: <7f7a7196-8b28-cd55-0685-799766bb6d4c@redhat.com>
Message-ID: <alpine.LSU.2.21.2007310949020.19678@pobox.suse.cz>
References: <20200730094143.27494-1-jthierry@redhat.com> <20200730094143.27494-3-jthierry@redhat.com> <20200730095759.GH2655@hirez.programming.kicks-ass.net> <dfe69c8f-db70-8366-5601-2592409ce7a0@redhat.com> <20200730132237.GM2655@hirez.programming.kicks-ass.net>
 <3af41a3b-a4b9-8120-3ac0-c9ce13770628@redhat.com> <20200730141526.lr33zv4ffa3rdygp@treble> <7f7a7196-8b28-cd55-0685-799766bb6d4c@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jul 2020, Julien Thierry wrote:

> 
> 
> On 7/30/20 3:15 PM, Josh Poimboeuf wrote:
> > On Thu, Jul 30, 2020 at 02:29:20PM +0100, Julien Thierry wrote:
> >>
> >>
> >> On 7/30/20 2:22 PM, peterz@infradead.org wrote:
> >>> On Thu, Jul 30, 2020 at 01:40:42PM +0100, Julien Thierry wrote:
> >>>>
> >>>>
> >>>> On 7/30/20 10:57 AM, peterz@infradead.org wrote:
> >>>>> On Thu, Jul 30, 2020 at 10:41:41AM +0100, Julien Thierry wrote:
> >>>>>> +		if (file->elf->changed)
> >>>>>> +			return elf_write(file->elf);
> >>>>>> +		else
> >>>>>> +			return 0;
> >>>>>>      }
> >>>>>
> >>>>> I think we can do without that else :-)
> >>>>>
> >>>>
> >>>> I did wonder and was not 100% confident about it, but the orc gen will
> >>>> always change the file, correct?
> >>>
> >>> Not if it already has orc, iirc.
> >>>
> >>> But what I was trying to say is that:
> >>>
> >>>  if (file->elf->changed)
> >>>   return elf_write(file->elf)
> >>>
> >>>  return 0;
> >>>
> >>> is identical code and, IMO, easier to read.
> >>>
> >>
> >> Much easier yes, I'll change it.
> > 
> > But I think file->elf->changed can be assumed at this point anyway, so
> > it could just be an unconditional
> > 
> >  return elf_write(file->elf);
> > 
> 
> I'll triple check whether that's the case and remove the if if possible.

I think it is the case. And even if not, it would only cause a pointless 
call to elf_update() in the end and that should not do any harm anyway if 
I am not mistaken.

However, I think there is a problem with the rebase on top of the current 
code. The patch moves elf_write() call to orc_gen.c which was ok before 
Peterz introduced elf_write_insn() et al. We need to keep elf_write() in 
check.c for this case too.

Miroslav
