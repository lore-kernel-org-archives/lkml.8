Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90DDC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 19:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0CED2083E
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 19:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WVXMJRV/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgHaTzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 15:55:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49504 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728344AbgHaTzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 15:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598903753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pg1EKJ08eC4msPPg4w9Q4tqRrD2nD69pzCZKjpi0eZg=;
        b=WVXMJRV/DxCsvgUte9kAtQbc2iT4gYG3HOYBgBPgPv3Sg/c1Xq6GP4XOBtMQ7P6e6AfFkr
        yi+MDtPvjd23+uO5K6YgyloQDVGzST3+/encwXFFiLPyVc9IOgmcGYv2Wxac5hMsp1H1lU
        n/FrDd9Vh31XgwZPlCKciMS1lAhbEoM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-mFuRQQa6OYWh8gPYCP7Hqw-1; Mon, 31 Aug 2020 15:55:50 -0400
X-MC-Unique: mFuRQQa6OYWh8gPYCP7Hqw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4DCF802B60;
        Mon, 31 Aug 2020 19:55:49 +0000 (UTC)
Received: from treble (ovpn-114-37.rdu2.redhat.com [10.10.114.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AA7FC5C1BB;
        Mon, 31 Aug 2020 19:55:48 +0000 (UTC)
Date:   Mon, 31 Aug 2020 14:55:46 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org
Subject: Re: [PATCH v2 9/9] objtool: Abstract unwind hint reading
Message-ID: <20200831195546.gt72y5tplwuftqv7@treble>
References: <20200730094652.28297-1-jthierry@redhat.com>
 <20200730094652.28297-10-jthierry@redhat.com>
 <20200730150341.udqnykbw7yfsjvin@treble>
 <1a078563-001d-c666-d2f5-9291f0efd35a@redhat.com>
 <20200731140441.cpzr4lrlkcrmoz2c@treble>
 <6a314dba-4086-717b-d226-6c292240a3e9@redhat.com>
 <20200803213506.hlbpdlitom7sjtqo@treble>
 <8fe8199e-a2f3-513f-6cdf-c61d7936dede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8fe8199e-a2f3-513f-6cdf-c61d7936dede@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 01:31:46PM +0100, Julien Thierry wrote:
> > > > The call to update_cfi_state_regs() is really regs-specific, not
> > > > sp-specific.
> > > > 
> > > 
> > > I must admit I don't really understand what "regs" is and why exactly such
> > > an exception in stack state tracking is made where only operations to SP are
> > > taken into account.
> > 
> > "regs" is a special type of stack frame, usually for asm entry code,
> > where the frame is actually an instance of 'struct pt_regs'.  So if
> > there's a variable associated it with it, maybe it should have "regs" in
> > the name.
> > 
> > Though I think non-x86 arches will also have regs frames, so would it
> > make sense to just make the unwind hint types a global multiarch thing?
> > They could be renamed to UNWIND_HINT_TYPE_REGS{_PARTIAL}.  Then there
> > wouldn't really be a need for the "sp_only" thing.
> > 
> 
> If having regs frame means having a pt_regs on the stack when procedure
> calls/return, then yes this will probably be the case on most archs (it is
> for arm64 at least.

The regs frames aren't for function/procedure calls, but rather
exceptions/interrupts.

> However in that case, arm64 still builds a stack frame and sets the frame
> pointer, so only handling SP operations doesn't make much sense for arm64.

If for example arm64 were to switch to ORC, it could have regs-only
frames in entry code just like x86.

> Also, things like ORC_TYPE_REGS_IRET don't have a use for arm64 (but maybe
> for other non-x86 arches it does?)

If we called it TYPE_REGS_PARTIAL, at least the name would be generic
enough, even if it's not used by all arches.

> In the end that's why I left the unwind hint types as arch defined. It seems
> like every arch will have their specific semantics they might want to let
> objtool know about.

Ok, I guess I'd need to look at the code to have an opinion.  If there
turn out to be commonalities between the different arch unwind hints
then we could always unify them later.

-- 
Josh

