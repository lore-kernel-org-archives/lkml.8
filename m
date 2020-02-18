Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DED4C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6687B22B48
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="FyTZYuiD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgBRUJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:09:03 -0500
Received: from mail.skyhub.de ([5.9.137.197]:56696 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbgBRUJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 15:09:01 -0500
Received: from zn.tnic (p200300EC2F0C1F00DCB96C3517B36067.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:1f00:dcb9:6c35:17b3:6067])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B54D41EC0C1A;
        Tue, 18 Feb 2020 21:08:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582056539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jmx0+z5jUn1UpZBqLi7uGXjByEV5/Ttc9P/ABLwrAZM=;
        b=FyTZYuiDS+cpITcqPx08jBvNoaFPPFytcGfkneBv1JenackcGRNG4pz9x0VbXJc0lsPVU2
        zRZzcgf9XMiZ2F8jtGhV8XwpWUhCBWAl/a5XF5JgG1T96yEZKVR6ELdlwHW12A3VF+wTNc
        iCKVlddjRiyTnZkxeqZd3x/46DXUJqQ=
Date:   Tue, 18 Feb 2020 21:09:00 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] #MC mess
Message-ID: <20200218200900.GS14449@zn.tnic>
References: <20200218173150.GK14449@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7F57B937@ORSMSX115.amr.corp.intel.com>
 <20200218200200.GE11457@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200218200200.GE11457@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 09:02:00PM +0100, Peter Zijlstra wrote:
> Then please rewrite the #MC entry code to deal with nested exceptions
> unmasking the MCE, very similr to NMI.
> 
> The moment you allow tracing, jump_labels or anything else you can
> expect #PF, #BP and probably #DB while inside #MC, those will then IRET
> and re-enable the #MC.

Yeah, I'd like to keep it simple and reenable all the crap we disabled
only on exit from the handler.

Dunno if we care about losing tracing samples when an MCE happened...

> The current situation is completely and utterly buggered.

Lovely. ;-(

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
