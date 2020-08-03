Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E3FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24ABC207FC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fd80tP7v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbgHCVfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 17:35:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43727 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726130AbgHCVfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 17:35:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596490539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h9SfcHvrVL171F/TlYWZMH1j+qEEwI65V+nQH+ZI8OI=;
        b=fd80tP7v3GkjZcCFPypC3GF9cb0hcUpx/k0L4MBEYhx6AW9yCR1HLYo7URaMvJndXXmFLt
        FST9f/duYdzv0VqYq/40eaZb5IFhIU1kMJSS6q/pZHTl7ziKe4Wbv70MvQw2NI3cMhjuUY
        jyT+7ZrhK0mFBI+5LeuKT6/ANWt3oDg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-oS980i_sNsq8l8S3ZEG_Zw-1; Mon, 03 Aug 2020 17:35:38 -0400
X-MC-Unique: oS980i_sNsq8l8S3ZEG_Zw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95425102C7ED;
        Mon,  3 Aug 2020 21:35:36 +0000 (UTC)
Received: from treble (ovpn-113-147.rdu2.redhat.com [10.10.113.147])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BE6AB5C6D9;
        Mon,  3 Aug 2020 21:35:32 +0000 (UTC)
Date:   Mon, 3 Aug 2020 16:35:29 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org
Subject: Re: [PATCH v2 9/9] objtool: Abstract unwind hint reading
Message-ID: <20200803213506.hlbpdlitom7sjtqo@treble>
References: <20200730094652.28297-1-jthierry@redhat.com>
 <20200730094652.28297-10-jthierry@redhat.com>
 <20200730150341.udqnykbw7yfsjvin@treble>
 <1a078563-001d-c666-d2f5-9291f0efd35a@redhat.com>
 <20200731140441.cpzr4lrlkcrmoz2c@treble>
 <6a314dba-4086-717b-d226-6c292240a3e9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6a314dba-4086-717b-d226-6c292240a3e9@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 01:13:14PM +0100, Julien Thierry wrote:
> 
> 
> On 7/31/20 3:04 PM, Josh Poimboeuf wrote:
> > On Fri, Jul 31, 2020 at 08:00:58AM +0100, Julien Thierry wrote:
> > > > > +	cfa->offset = hint->sp_offset;
> > > > > +	insn->cfi.hint_type = hint->type;
> > > > > +	insn->cfi.end = hint->end;
> > > > > +
> > > > > +	insn->cfi.sp_only = hint->type == ORC_TYPE_REGS || hint->type == ORC_TYPE_REGS_IRET;
> > > > 
> > > > What does "sp" mean here in sp_only?
> > > > 
> > > 
> > > Stack pointer, like in CFI_SP. When objtool encounters one of these hints,
> > > it starts to only track the stack frame with the stack pointer (no BP, no
> > > drap register, no move to temporary registers). Just trying to make some
> > > sense of this corner case.
> > 
> > I think that's not quite right, because ORC_TYPE_CALL could also be
> > "sp_only" in some cases, by that definition.
> > 
> 
> But in that case the code will still track when/if the CFI becomes pointed
> to by BP.
> 
> > The call to update_cfi_state_regs() is really regs-specific, not
> > sp-specific.
> > 
> 
> I must admit I don't really understand what "regs" is and why exactly such
> an exception in stack state tracking is made where only operations to SP are
> taken into account.

"regs" is a special type of stack frame, usually for asm entry code,
where the frame is actually an instance of 'struct pt_regs'.  So if
there's a variable associated it with it, maybe it should have "regs" in
the name.

Though I think non-x86 arches will also have regs frames, so would it
make sense to just make the unwind hint types a global multiarch thing?
They could be renamed to UNWIND_HINT_TYPE_REGS{_PARTIAL}.  Then there
wouldn't really be a need for the "sp_only" thing.

-- 
Josh

