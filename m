Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419D0C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 14:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1602A2166E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 14:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hvfrPeq4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgCYOmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 10:42:23 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:48123 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727123AbgCYOmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 10:42:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585147341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f0QoE/qndgvHkzTsiprhqXEFUL5AmxJl7pgoSBh+XjM=;
        b=hvfrPeq4KmAm+Cs+gb+IfgeE/LP1KsgV18F4eXD7KaMzpn34cNds/eiasiSFJMO6CrItQe
        p1Ys5PISfcM2A+Y6iWE7LPloHhlFJv5c6GAbgl/mjgGfp/bc8jSrkdnu6t4ZKCk6ju24Px
        rwV1Ky9WSYumZ8oiPkdVxXiKGUNi0j0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-3heDe8q8OI-tXT8rSVc0iQ-1; Wed, 25 Mar 2020 10:42:16 -0400
X-MC-Unique: 3heDe8q8OI-tXT8rSVc0iQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD080800D54;
        Wed, 25 Mar 2020 14:42:14 +0000 (UTC)
Received: from treble (unknown [10.10.119.253])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BBCEA10002A5;
        Wed, 25 Mar 2020 14:42:13 +0000 (UTC)
Date:   Wed, 25 Mar 2020 09:42:11 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: Re: [PATCH v3 26/26] objtool: Add STT_NOTYPE noinstr validation
Message-ID: <20200325144211.irnwnly37fyhapvx@treble>
References: <20200324153113.098167666@infradead.org>
 <20200324160925.470421121@infradead.org>
 <20200324221616.2tdljgyay37aiw2t@treble>
 <20200324223455.GV2452@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200324223455.GV2452@worktop.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 11:34:55PM +0100, Peter Zijlstra wrote:
> On Tue, Mar 24, 2020 at 05:16:16PM -0500, Josh Poimboeuf wrote:
> > On Tue, Mar 24, 2020 at 04:31:39PM +0100, Peter Zijlstra wrote:
> 
> > > +	if (state.noinstr) {
> > > +		/*
> > > +		 * In vmlinux mode we will not run validate_unwind_hints() by
> > > +		 * default which means we'll not otherwise visit STT_NOTYPE
> > > +		 * symbols.
> > > +		 *
> > > +		 * In case of --duplicate mode, insn->visited will avoid actual
> > > +		 * duplicate work being done.
> > > +		 */
> > > +		list_for_each_entry(func, &sec->symbol_list, list) {
> > > +			if (func->type != STT_NOTYPE)
> > > +				continue;
> > > +
> > > +			warnings += validate_symbol(file, sec, func, &state);
> > > +		}
> > > +	}
> > > +
> > 
> > I guess this is ok, but is there a valid reason why we don't just call
> > validate_unwind_hints()?
> > 
> > It's also slightly concerning that validate_reachable_instructions()
> > isn't called, I'm not 100% convinced all the code will get checked.
> 
> This will only end up running on .noinstr.text, while
> validate_unwind_hints() will run on *everything*. That is, we're
> purposely not checking everything.
> 
> It very much relies on the !vmlinux mode to do the unreachable things.

Sure, but couldn't validate_unwind_hints() and
validate_reachable_instructions() be changed to *only* run on
.noinstr.text, for the vmlinux case?  That might help converge the
vmlinux and !vmlinux paths.

-- 
Josh

