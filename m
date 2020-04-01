Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705F8C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 17:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 379972071A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 17:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b/fKiL+5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732769AbgDARh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 13:37:27 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32985 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726901AbgDARh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 13:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585762645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bN9sAxxrxI0QKUe5EmcfAyEAD1O55pPC904an2QRe7s=;
        b=b/fKiL+5HJaCivkLTAvMjRfEEqi1w643XkH66KOf6RF2imLUmOkPt/cfCWfpgKyCjTiA5B
        j61klu7et+RwxIJScW2T9034mrYpFIDqhDOA4EwriuNuqmxS1yAKslrBC9uCwVVZ4g6VBW
        XhB/u3KHULhjh5ViPLMxFDzP3Bf3wl8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-5qC2-SH4MpmplGeB9sW4Bw-1; Wed, 01 Apr 2020 13:37:13 -0400
X-MC-Unique: 5qC2-SH4MpmplGeB9sW4Bw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 541381005055;
        Wed,  1 Apr 2020 17:37:12 +0000 (UTC)
Received: from treble (ovpn-118-135.phx2.redhat.com [10.3.118.135])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8627C391;
        Wed,  1 Apr 2020 17:37:11 +0000 (UTC)
Date:   Wed, 1 Apr 2020 12:37:09 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Julien Thierry <jthierry@redhat.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        mbenes@suse.cz, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] objtool,ftrace: Implement UNWIND_HINT_RET_OFFSET
Message-ID: <20200401173709.xzfuwmbz4b6lvsfy@treble>
References: <20200330190205.k5ssixd5hpshpjjq@treble>
 <20200330200254.GV20713@hirez.programming.kicks-ass.net>
 <20200331111652.GH20760@hirez.programming.kicks-ass.net>
 <20200331202315.zialorhlxmml6ec7@treble>
 <20200331204047.GF2452@worktop.programming.kicks-ass.net>
 <20200331211755.pb7f3wa6oxzjnswc@treble>
 <20200331212040.7lrzmj7tbbx2jgrj@treble>
 <20200331222703.GH2452@worktop.programming.kicks-ass.net>
 <d2cad75e-1708-f0bf-7f88-194bcb29e61d@redhat.com>
 <20200401170910.GX20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200401170910.GX20730@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 07:09:10PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 01, 2020 at 04:43:35PM +0100, Julien Thierry wrote:
> 
> > > +static bool has_modified_stack_frame(struct instruction *insn, struct insn_state *state)
> > >   {
> > > +	u8 ret_offset = insn->ret_offset;
> > >   	int i;
> > > 
> > > -	if (state->cfa.base != initial_func_cfi.cfa.base ||
> > > -	    state->cfa.offset != initial_func_cfi.cfa.offset ||
> > > -	    state->stack_size != initial_func_cfi.cfa.offset ||
> > > -	    state->drap)
> > > +	if (state->cfa.base != initial_func_cfi.cfa.base || state->drap)
> > > +		return true;
> > > +
> > > +	if (state->cfa.offset != initial_func_cfi.cfa.offset &&
> > > +	    !(ret_offset && state->cfa.offset == initial_func_cfi.cfa.offset + ret_offset))
> > 
> > Isn't that the same thing as "state->cfa.offset !=
> > initial_func_cfi.cfa.offset + ret_offset" ?
> 
> I'm confused on what cfa.offset is, sometimes it increase with
> stack_size, sometimes it doesn't.
>
> ISTR that for the ftrace case it was indeed cfa.offset + 8, but for the
> IRET case below (where it is now not used anymore) it was cfa.offset
> (not cfa.offset + 40, which I was expecting).

It depends on the value of cfa.base.  If cfa.base is CFI_SP, then
cfa.offset changes with stack_size.  If cfa.base is CFI_BP (i.e. if the
function uses a frame pointer), then cfa.offset is constant (the
distance between RBP on the stack and the previous frame).

-- 
Josh

