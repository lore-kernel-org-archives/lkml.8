Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F231C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 20:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC52020708
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 20:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="VaTwfVt3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbgAYUX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 15:23:28 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38236 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgAYUX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 15:23:27 -0500
Received: from zn.tnic (p200300EC2F1CE900698071F6EB5AEF0D.dip0.t-ipconnect.de [IPv6:2003:ec:2f1c:e900:6980:71f6:eb5a:ef0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 52D191EC0AA0;
        Sat, 25 Jan 2020 21:23:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579983806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1I/IKIKqRGKC6McgkqmcX5DcurVKpTj7So8s7IRW72I=;
        b=VaTwfVt3V0rDQ+urOJKHiIxf5Hen0DuxJ+YbZRV/eQns4evTiqegzczy74+POqUOryrun6
        T0zuwNRZYBGbYEgmdcm2KG8xxwVtan7fGKUGq8B9EClZ9u1rtbGZptbnFAf6Se3ox5wRE0
        WfAOuvQFQAqWbtwNk9THb/hQ/rZ+1Vg=
Date:   Sat, 25 Jan 2020 21:23:25 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        x86 <x86@kernel.org>
Subject: Re: [tip: core/rcu] rcu: Enable tick for nohz_full CPUs slow to
 provide expedited QS
Message-ID: <20200125202325.GC4369@zn.tnic>
References: <157994897654.396.5667707782512768142.tip-bot2@tip-bot2>
 <20200125131425.GB16136@zn.tnic>
 <20200125161050.GE2935@paulmck-ThinkPad-P72>
 <20200125175442.GA4369@zn.tnic>
 <20200125194846.GF2935@paulmck-ThinkPad-P72>
 <20200125200854.GA8673@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200125200854.GA8673@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2020 at 12:08:54PM -0800, Paul E. McKenney wrote:
> And I do have an alleged fix on branch dev of the -rcu tree:
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> 
> I am just now starting testing, so the probability of failure is
> decidedly non-zero.  ;-)

Lemme run it here too.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
