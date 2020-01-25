Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD153C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 20:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9160120716
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 20:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="bMl/02vp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgAYUTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 15:19:11 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37680 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbgAYUTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 15:19:11 -0500
Received: from zn.tnic (p200300EC2F1CE900698071F6EB5AEF0D.dip0.t-ipconnect.de [IPv6:2003:ec:2f1c:e900:6980:71f6:eb5a:ef0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BEFC91EC0AA0;
        Sat, 25 Jan 2020 21:19:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579983549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=GWPlkscBO5mlHw1+EDfCxlwtI5gheQRnpKKvPRbkm3o=;
        b=bMl/02vpaWe3auQVAi7TYHf+H47CENvzT6PRhVayXhI4THOoROdaKBOXsOP3YTOXNZc0+U
        Lpsphk4RWdBuLwrg+G4YjUex4/7xogRaXML4EkclGjOReRLWELixYsA0R2znOjfLWrfdL7
        T4m0ZBme5GoxPH6FSrLBCilSTTzjo8s=
Date:   Sat, 25 Jan 2020 21:19:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        x86 <x86@kernel.org>
Subject: Re: [tip: core/rcu] rcu: Enable tick for nohz_full CPUs slow to
 provide expedited QS
Message-ID: <20200125201904.GB4369@zn.tnic>
References: <157994897654.396.5667707782512768142.tip-bot2@tip-bot2>
 <20200125131425.GB16136@zn.tnic>
 <20200125161050.GE2935@paulmck-ThinkPad-P72>
 <20200125175442.GA4369@zn.tnic>
 <20200125194846.GF2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200125194846.GF2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2020 at 11:48:46AM -0800, Paul E. McKenney wrote:
> My guess is "no" because the real-time application would not yet be
> running during boot.  On the other hand, if this issue is due not so much
> to boot, but to (say) expensive filesystem operations on large systems,
> that might be a different story.

Possible - that warn happened around a btrfs init-something.

> Except that I would have hard questions to ask of someone doing expensive
> filesystem operations while their deep-sub-millisecond real-time
> application was running.  So even then, I doubt that they would care.
> 
> Again, if I am wrong about this, this would be an excellent time for
> them to let me know.

I can see the hint there. :-)

> In the meantime, one question...  Are you testing for realtime suitability
> on your big box?  If so, to what extent?

Nah, just boot-testing tip/master before the merge window opens. Got a
couple of boxes on which I throw tip/master on from time to time and see
what breaks. I have caught a number of issues in past years, so it is a
useful exercise.

> Aside from habitually failing to trim emails, which of these was I
> violating?  ;-)

That's my mail signature. In the hope that people see that doc and stop
doing the same annoying things on LKML, it gets pasted in every mail of
mine. I didn't mean you or your mail.

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
