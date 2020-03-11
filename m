Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7211AC18E5A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277A020650
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="sNkNrzhd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbgCKO4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 10:56:08 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45812 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729521AbgCKO4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 10:56:07 -0400
Received: from zn.tnic (p200300EC2F12AA00E5C435974B72A9DE.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:aa00:e5c4:3597:4b72:a9de])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 834C71EC0BF2;
        Wed, 11 Mar 2020 15:56:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1583938566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=92qwRm+YOA18EqQyRIQCHO5hSt3TQ0QTKu3/BKRY/WM=;
        b=sNkNrzhdtUbjn39ZqLFHkdiOJgk6qMzncEQPLfKgcqq409n7qijV04mih0quVL9x2/qM80
        FPRKcfwatCBps4LdMQmgDZiRyrs71keb8txORKXgewxntIX4D8Mj2YlGos5Xjyst94YFqa
        Dw7/Px4d6L8QTTv+JyzP6cRcSG9a3SQ=
Date:   Wed, 11 Mar 2020 15:56:11 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Bruce Rogers <brogers@suse.com>
Subject: Re: [PATCH] x86/ioremap: Map EFI runtime services data as encrypted
 for SEV
Message-ID: <20200311145610.GC3470@zn.tnic>
References: <2d9e16eb5b53dc82665c95c6764b7407719df7a0.1582645327.git.thomas.lendacky@amd.com>
 <20200310124003.GE29372@zn.tnic>
 <20200310130321.GH7028@suse.de>
 <20200310163738.GF29372@zn.tnic>
 <20200310174712.GG29372@zn.tnic>
 <20200311090447.GI7028@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200311090447.GI7028@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 10:04:47AM +0100, Joerg Roedel wrote:
> Hi,
> 
> On Tue, Mar 10, 2020 at 06:47:31PM +0100, Borislav Petkov wrote:
> > Ok, here's what I have. @joro, I know it is trivially different from the
> > version you tested but I'd appreciate it if you ran it again, just to be
> > sure.
> 
> Looks good and ested it, works fine.
> 
> Reviewed-by: Joerg Roedel <jroedel@suse.de>
> Tested-by: Joerg Roedel <jroedel@suse.de>

Thanks man!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
