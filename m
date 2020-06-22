Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C9BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C02720767
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="jQHFPHh/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbgFVTAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 15:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730519AbgFVTAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 15:00:03 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D29C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 12:00:03 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0a2500329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:2500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B1D881EC0315;
        Mon, 22 Jun 2020 21:00:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592852401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=yNIrWdyXw+nImLtUPVb2517x4L9Mdf4hV8BjzW0wDRg=;
        b=jQHFPHh/8kfJScpzFcdlgsneQyncWjSisgmsrS4P6F/mYQt52xMHavRdRAXdRqm090WY9R
        z8bkXux2eUqnXkTV3UK1+4YHw6td/XJoNqhuDIZIrPkNC0JCD8l5f6sgtsMY0gzNyeTbw0
        9jk/ZFB81Q4BPye0ZHnyag0R53EBRUA=
Date:   Mon, 22 Jun 2020 20:59:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        jpa@kernelbug.mail.kapsi.fi, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/fpu: Reset MXCSR to default in kernel_fpu_begin()
Message-ID: <20200622185954.GK32200@zn.tnic>
References: <20200619174127.22304-1-bp@alien8.de>
 <20200619174127.22304-2-bp@alien8.de>
 <CALCETrXZhFJGJA2h4zP743KYTtni-rQSUME8mtSYUdk1-ZTauQ@mail.gmail.com>
 <20200622170908.GH32200@zn.tnic>
 <CALCETrU0C5yVwfAOj+v1RqNBZY+phXrdvCBZMKdOXOExBgMbVg@mail.gmail.com>
 <ef327682-7e9f-5652-1664-3e201ac38f60@intel.com>
 <CALCETrUT1_WVjMbPZhUcX9sjFvLBZKCc2fxeJJsD940k1Ajyrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrUT1_WVjMbPZhUcX9sjFvLBZKCc2fxeJJsD940k1Ajyrw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 11:40:38AM -0700, Andy Lutomirski wrote:
> On Mon, Jun 22, 2020 at 11:38 AM Dave Hansen <dave.hansen@intel.com> wrote:
> >
> > On 6/22/20 11:33 AM, Andy Lutomirski wrote:
> > > Suppose you do:
> > >
> > > double x = 1.0;
> > >
> > > kernel_fpu_begin();
> > >
> > > x += 2.0;
> > >
> > > We want to make sure that GCC puts things in the right order.  I
> > > suppose that even a memory clobber is insufficient here, though.
> >
> > Even with CONFIG_PREEMPT disabled, we still have:
> >
> >         #define preempt_disable()                       barrier()
> >
> > I don't see us supporting preemptible kernel_fpu regions any time soon,
> > so shouldn't this be sufficient now and for a long time?
> 
> That's on the wrong end of the function.  It'sL
> 
> preempt_disable();
> LDMXCSR;
> <-- some kind of barrier here might be nice

For what? LDMXCSR loads the MXCSR *hardware* register with a u32 from
memory.

In any case, I'm still unconvinced we should preemptively fix issues
that might potentially happen when someone uses FPU in the kernel. And
even if, this doesn't belong in this patch but in a separate one with a
commit message explaining what is being fixed.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
