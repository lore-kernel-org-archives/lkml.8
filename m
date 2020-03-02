Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3260C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA382146E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZqoGx7Mn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbgCBPwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 10:52:49 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40911 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727000AbgCBPwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 10:52:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583164368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rc7S3GfEURPABvAMtPoo3IHj2IzyHVgUsHYiM/6+E1M=;
        b=ZqoGx7Mnwyv1xuye10sCZmzvP561NT0GSQERIVhLKvqpIc/L9G2B4sTI/d/6z/N4WdyM7a
        X0OiC++acdusO0VEpwUhkzyMYg5Qr3OA4/GbA6BtDnpt25d39VdPG8Op3TcKcS+V/X28j1
        3WggVa1ErET5gTUKDS9ie0HfSeHVPzw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-48mENsD5NPCdcw6bZPT7Mg-1; Mon, 02 Mar 2020 10:52:44 -0500
X-MC-Unique: 48mENsD5NPCdcw6bZPT7Mg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D67D0801A01;
        Mon,  2 Mar 2020 15:52:42 +0000 (UTC)
Received: from treble (ovpn-123-162.rdu2.redhat.com [10.10.123.162])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C88FA73884;
        Mon,  2 Mar 2020 15:52:41 +0000 (UTC)
Date:   Mon, 2 Mar 2020 09:52:40 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Jann Horn <jannh@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: x86 entry perf unwinding failure (missing IRET_REGS annotation
 on stack switch?)
Message-ID: <20200302155239.7ww7jfeu4yeevpkb@treble>
References: <CAG48ez1rkN0YU-ieBaUZDKFYG5XFnd7dhDjSDdRmVfWyQzsA5g@mail.gmail.com>
 <20200302151829.brlkedossh7qs47s@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200302151829.brlkedossh7qs47s@treble>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 09:18:29AM -0600, Josh Poimboeuf wrote:
> > So I think on machines without X86_FEATURE_SMAP, trying to unwind from
> > the two NOPs at f41 and f42 will cause the unwinder to report an
> > error? Looking at unwind_next_frame(), "sp:(und)" without the "end:1"
> > marker seems to be reserved for errors.

I think we can blame this one on Peter ;-)

  764eef4b109a ("objtool: Rewrite alt->skip_orig")

With X86_FEATURE_SMAP, alt->skip_orig gets set, which tells objtool to
skip validation of the NOPs.  That has the side effect of not
propagating the ORC state to the NOPs as well.

-- 
Josh

