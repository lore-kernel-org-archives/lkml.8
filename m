Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A57C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 14:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 237AF2083B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 14:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gpRmaGsK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732387AbgGaOEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 10:04:51 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55866 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730170AbgGaOEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 10:04:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596204291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VyIseixnXp1s5WTThyAPC9T3W3AG9+lCb/FRjaq4Th4=;
        b=gpRmaGsKoY97rPYK0Z7uhmHRmWaZVaiD/k+su+C/grb85PoTxhLmynHPJHia0plqGEJei3
        yALxor/QDgUpuofR4xwfmuGYoqcxVgQJa0tO9A1NZVD2dT+R7TTgi3Zb6DeWBdqGncSaA4
        s2x2y517pSTDVYSs5cH8MXNz4t9mPUM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-cCDTueIOP7SOBg3xRLHFxQ-1; Fri, 31 Jul 2020 10:04:47 -0400
X-MC-Unique: cCDTueIOP7SOBg3xRLHFxQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87493800465;
        Fri, 31 Jul 2020 14:04:45 +0000 (UTC)
Received: from treble (ovpn-119-23.rdu2.redhat.com [10.10.119.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C14E75C5B7;
        Fri, 31 Jul 2020 14:04:43 +0000 (UTC)
Date:   Fri, 31 Jul 2020 09:04:41 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org
Subject: Re: [PATCH v2 9/9] objtool: Abstract unwind hint reading
Message-ID: <20200731140441.cpzr4lrlkcrmoz2c@treble>
References: <20200730094652.28297-1-jthierry@redhat.com>
 <20200730094652.28297-10-jthierry@redhat.com>
 <20200730150341.udqnykbw7yfsjvin@treble>
 <1a078563-001d-c666-d2f5-9291f0efd35a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1a078563-001d-c666-d2f5-9291f0efd35a@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 08:00:58AM +0100, Julien Thierry wrote:
> > > +	cfa->offset = hint->sp_offset;
> > > +	insn->cfi.hint_type = hint->type;
> > > +	insn->cfi.end = hint->end;
> > > +
> > > +	insn->cfi.sp_only = hint->type == ORC_TYPE_REGS || hint->type == ORC_TYPE_REGS_IRET;
> > 
> > What does "sp" mean here in sp_only?
> > 
> 
> Stack pointer, like in CFI_SP. When objtool encounters one of these hints,
> it starts to only track the stack frame with the stack pointer (no BP, no
> drap register, no move to temporary registers). Just trying to make some
> sense of this corner case.

I think that's not quite right, because ORC_TYPE_CALL could also be
"sp_only" in some cases, by that definition.

The call to update_cfi_state_regs() is really regs-specific, not
sp-specific.

-- 
Josh

