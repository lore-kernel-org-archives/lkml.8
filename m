Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6C9C2D0F6
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 16:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CD9F206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 16:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="DhAhB8v+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgELQ2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 12:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgELQ2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 12:28:52 -0400
X-Greylist: delayed 4402 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 May 2020 09:28:52 PDT
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D0DC061A0C;
        Tue, 12 May 2020 09:28:52 -0700 (PDT)
Received: from zn.tnic (p200300EC2F0A9D0059BB7FCAE11E2EA0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:9d00:59bb:7fca:e11e:2ea0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 935741EC0299;
        Tue, 12 May 2020 18:28:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1589300930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jfdRhXHPFSXx8Q5aS323J6F+OYj8FS8BGUJyQM6iM68=;
        b=DhAhB8v+Voi3PoHmOwXGeE9dEEdWM7Lppt80ZWH3Ep59LXOlnXJB9f63UvLzLtZLrO5lCd
        EnTSzz72STpeA4rwayxZeH8F23977zQW0UELu1jtXrdF1PBWsR/jXJhSOXVx0RWcZDNOIM
        pxsMg496T/+kff6wgORL9Wu4foBdJ7M=
Date:   Tue, 12 May 2020 18:28:45 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org,
        "H. Peter Anvin (Intel)" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>
Subject: Re: [tip: x86/cpu] x86/cpu: Use INVPCID mnemonic in invpcid.h
Message-ID: <20200512162845.GC6859@zn.tnic>
References: <20200508092247.132147-1-ubizjak@gmail.com>
 <158929264101.390.18239205970315804831.tip-bot2@tip-bot2>
 <CAFULd4bZLkME4kn9bmbOBMtd+ZpNnsH-w8a6tPdtmpV57WSHtw@mail.gmail.com>
 <20200512151522.GB6859@zn.tnic>
 <CAFULd4bP4SPZDafsp-sqH2GP1mWxfBiBRA9wp8UrmkPZnfManQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFULd4bP4SPZDafsp-sqH2GP1mWxfBiBRA9wp8UrmkPZnfManQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 05:54:49PM +0200, Uros Bizjak wrote:
> Symbolic operands are agnostic to the position in the asm clause, so
> it really doesn't matter much. It just doesn't feel right, when other
> cases follow different order.
> 
> > $ diff -suprN /tmp/before /tmp/after
> > Files /tmp/before and /tmp/after are identical
> 
> Sure, otherwise assembler would complain.
> 
> > Makes sense?
> 
> Well, I don't want to bikeshed around this anymore, so any way is good.

Look at it this way: the symbolic operand names feature has made inline
assembly *orders* of magnitude more readable than what it was before.
Kernel folks, including myself, have stumbled upon the question which
operand is which, on a regular basis and having the operand names there
makes reading the inline asm almost trivial.

So while we should not convert wholesale, I think we should aim to
gradually convert those other cases to the a-lot-more readable variant
with symbolic operand names.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
