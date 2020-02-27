Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73AEC11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C98A24699
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="TVyj2rNl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbgB0Ttf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 14:49:35 -0500
Received: from mail.skyhub.de ([5.9.137.197]:56692 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727159AbgB0Ttf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 14:49:35 -0500
Received: from zn.tnic (p200300EC2F0E0F0080237097B4C234BF.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:f00:8023:7097:b4c2:34bf])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C6B661EC0A0E;
        Thu, 27 Feb 2020 20:49:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582832974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hFlsLDjrGILzRZvLWpLegtB6KF7JNimSyKmgEdxC3mU=;
        b=TVyj2rNlnvuz+5LcyrpITIwQPUe8mpZLKOidxe+rMQLquuHqpYLWmRYH3WuLF+OnBFFXnv
        PfxRw86VdeQkkp+3YVWX/hkXtp+UJQ0tRsq3km133+gGLhR8uy/8Ax5pl66+XZAMRIzcVn
        Cw/hFfeysf5vqthIc+1pDAyE9CSbh2U=
Date:   Thu, 27 Feb 2020 20:49:28 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 1/8] x86/entry/64: Trace irqflags unconditionally on when
 returing to user space
Message-ID: <20200227194928.GC18629@zn.tnic>
References: <20200225220801.571835584@linutronix.de>
 <20200225221305.295289073@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200225221305.295289073@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just formulations improvements:

> Subject: [patch 1/8] x86/entry/64: Trace irqflags unconditionally on when returing to user space

s/on //

On Tue, Feb 25, 2020 at 11:08:02PM +0100, Thomas Gleixner wrote:
> User space cannot longer disable interrupts so trace return to user space

"Userspace cannot disable interrupts any longer... "

> unconditionally as IRQS_ON.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
