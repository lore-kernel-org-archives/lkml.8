Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562DDC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E3DE2076A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgGQJGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 05:06:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:59048 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbgGQJGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 05:06:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D5983B132;
        Fri, 17 Jul 2020 09:06:35 +0000 (UTC)
Date:   Fri, 17 Jul 2020 11:06:31 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Mark Brown <broonie@kernel.org>
cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: stacktrace: Convert to ARCH_STACKWALK
In-Reply-To: <20200716162022.GD5105@sirena.org.uk>
Message-ID: <alpine.LSU.2.21.2007171105250.21694@pobox.suse.cz>
References: <20200715202821.12220-1-broonie@kernel.org> <20200715202821.12220-4-broonie@kernel.org> <alpine.LSU.2.21.2007161342290.3958@pobox.suse.cz> <20200716162022.GD5105@sirena.org.uk>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jul 2020, Mark Brown wrote:

> On Thu, Jul 16, 2020 at 01:56:13PM +0200, Miroslav Benes wrote:
> > On Wed, 15 Jul 2020, Mark Brown wrote:
> 
> > > -void save_stack_trace(struct stack_trace *trace)
> > > -{
> > > -	__save_stack_trace(current, trace, 0);
> > > +	walk_stackframe(task, &frame, consume_entry, cookie);
> > >  }
> 
> > just an idea for further improvement (and it might be a matter of taste). 
> 
> Yeah, there's some more stuff that can be done - the reason I'm looking
> at this code is to do reliable stack trace which is going to require at
> least some changes to the actual unwinder, this just seemed like a
> useful block moving things forwards in itself and I particularly wanted
> feedback on patch 1.

Understood. Reliable stack traces would be an important step for live 
patching on arm64, so I am looking forward to seeing that.

Thanks
Miroslav
