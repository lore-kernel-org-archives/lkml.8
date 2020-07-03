Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAACC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 22:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 276E22192A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 22:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UxWfa4HS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bvB//3vc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgGCWbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 18:31:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35838 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgGCWbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 18:31:03 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593815461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e6HM5KalB3cdRfA4Hps7INNFh9eeE6yz+RhORK/ferw=;
        b=UxWfa4HS6S7NQAyS/jMl4fjxbcCv1prvRSCKbsDllp1+dzc5z4T7inYWBkJ3FhkaGfHaTZ
        vAGLgP5gEjwFC1sgShElbTjfY3RehAdz/I6E1I+msYo1HdhV615kK2pihe8pCXeOFCgX9E
        WONDkzZJl/h8MJnEGa00LKFRZ09tDewa4sRXfvLgaYEAaDe0ATeTslGCTtHWH9CNJoVLkl
        62KdtDowVoLPx/rBXkQleegbyC+nJxPWzpcyu6WdZgfHKU6pXPFzpUBtldeZBQuvTSrj0p
        EV6miUZEF3v9PMDvUvKVJnZHJUh9rLNxNz7hdtwPUXED6ouA+tE72u89gRISxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593815461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e6HM5KalB3cdRfA4Hps7INNFh9eeE6yz+RhORK/ferw=;
        b=bvB//3vcFyKBqGU4jVbTlAhUCfJaMSN/jkN+tpi1wI9XzIYrvfyn0Bmgf8ATogOTaNPtl2
        DSyT7KFiHbveqTBg==
To:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Jan Beulich <jbeulich@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     X86 ML <x86@kernel.org>
Subject: Re: FSGSBASE seems to be busted on Xen PV
In-Reply-To: <e78d2ee5-66cf-2ed8-c04f-71dd92efdfe1@citrix.com>
References: <CALCETrVfi1Rnt5nnrHNivdxE7MqRPiLXvon4-engqo=LCKiojA@mail.gmail.com> <e78d2ee5-66cf-2ed8-c04f-71dd92efdfe1@citrix.com>
Date:   Sat, 04 Jul 2020 00:31:00 +0200
Message-ID: <87eepss02j.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Cooper <andrew.cooper3@citrix.com> writes:
> On 03/07/2020 18:10, Andy Lutomirski wrote:
>> If you can't get this fixed in upstream Xen reasonably quickly, we may
>> need to disable FSGSBASE in a Xen PV guest in Linux.
>
> This has come up several times before, but if its actually breaking
> userspace then Xen needs to change.
>
> I'll see about making something which is rather more robust.

You mean disabling XEN PV completely? That would be indeed very robust
and allows us to get rid of lots of obscure code. Feel free to add my
Acked-by :)

Thanks,

        tglx
