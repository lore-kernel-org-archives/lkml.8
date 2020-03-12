Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65316C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 19:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B0DF206EB
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 19:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eGBSWPjS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgCLT5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 15:57:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44064 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726822AbgCLT5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 15:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584043042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/qb4wFG53QR3ePPXzBjbOc/jfWAkGnV+htN3KtJo1bw=;
        b=eGBSWPjS0a6Xba6dPLwEYa0SXbCOOxvmBS7FYe9vxpLvpj/JwJ34P6GqR1PDSXl5FhuvwP
        SrRi/gfhSE5ggkb1xsPTPztuXrFZ4IrrjK0oYPLuV94yH5XTZMfIgQN1qoznQKlVV1yidK
        Leoq4XR2z0sWbtoNsaFwm6SujqMzros=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-Kh9XhrrzOdGT5JkywWoHag-1; Thu, 12 Mar 2020 15:57:20 -0400
X-MC-Unique: Kh9XhrrzOdGT5JkywWoHag-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6F47107ACC9;
        Thu, 12 Mar 2020 19:57:18 +0000 (UTC)
Received: from treble (ovpn-122-137.rdu2.redhat.com [10.10.122.137])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C5C6B5C1B5;
        Thu, 12 Mar 2020 19:57:16 +0000 (UTC)
Date:   Thu, 12 Mar 2020 14:57:14 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Dave Jones <dsj@fb.com>, Jann Horn <jannh@google.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 03/14] x86/entry/64: Fix unwind hints in register
 clearing code
Message-ID: <20200312195714.gc5jalix2dp57dyb@treble>
References: <cb9b03b2a391b064573c152696d99017f76e8603.1584033751.git.jpoimboe@redhat.com>
 <DECA668C-B7EA-4663-8ABB-5B9E0495F498@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DECA668C-B7EA-4663-8ABB-5B9E0495F498@amacapital.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 12:29:29PM -0700, Andy Lutomirski wrote:
> > On Mar 12, 2020, at 10:31 AM, Josh Poimboeuf <jpoimboe@redhat.com> wr=
ote:
> >=20
> > =EF=BB=BFThe PUSH_AND_CLEAR_REGS macro zeroes each register immediate=
ly after
> > pushing it.  If an NMI or exception hits after a register is cleared,
> > but before the UNWIND_HINT_REGS annotation, the ORC unwinder will
> > wrongly think the previous value of the register was zero.  This can
> > confuse the unwinding process and cause it to exit early.
> >=20
> > Because ORC is simpler than DWARF, there are a limited number of unwi=
nd
> > annotation states, so it's not possible to add an individual unwind h=
int
> > after each push/clear combination.  Instead, the register clearing
> > instructions need to be consolidated and moved to after the
> > UNWIND_HINT_REGS annotation.
>=20
> I don=E2=80=99t suppose you know how bad t he performance hit is on a n=
on-PTI machine?

Hm, what does it have to do with PTI?  Should I run a syscall
microbenchmark?

--=20
Josh

