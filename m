Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A082C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 14:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3BBD206F6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 14:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="Atl/wt6R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgCZOKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 10:10:50 -0400
Received: from one.firstfloor.org ([193.170.194.197]:35836 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgCZOKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 10:10:50 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
        id F138E8733C; Thu, 26 Mar 2020 15:10:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1585231847;
        bh=gtlaDC8+1MnEKKvFmSZFeaFwgBKvGDYgeKA6K1fcej4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Atl/wt6RZcvoL6jy6Yt0O/5l4UWsejLFnQptGxZ8OnNjWuwJTtUBBJAn9kuDC+KIf
         SbqlXG+wt08q3iQJ5PjbEVXUBbO3Qg0ro2D0Gs2kr1mjrRJvrggCFDFgcP87nzfl0J
         brucGMzVB1TAm+GSsqPIjXfEgqD+DS3uvXV+lmf4=
Date:   Thu, 26 Mar 2020 07:10:47 -0700
From:   Andi Kleen <andi@firstfloor.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <andi@firstfloor.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH] x86/speculation: Allow overriding seccomp speculation
 disable
Message-ID: <20200326141046.giyacwh46bfcbvjy@two.firstfloor.org>
References: <20200312231222.81861-1-andi@firstfloor.org>
 <87sgi1rcje.fsf@nanos.tec.linutronix.de>
 <202003211916.8078081E0@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202003211916.8078081E0@keescook>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The point of the defaults was to grandfather older seccomp users into
> speculation mitigations. Newly built seccomp users can choose to disable
> this with SECCOMP_FILTER_FLAG_SPEC_ALLOW when applying seccomp filters.
> The rationale was that once a process knows how to manage its exposure,
> it can choose to leave off the automatic enabling. I don't see any
> mention of that method in the commit log, so if there is some reason
> it's not workable, that would need to be discussed first.

SECCOMP_FILTER_FLAG_SPEC_ALLOW doesn't completely solve the problem because
it enables everything, including cross process defenses, like Spectre.

The motivation of my patch was to only allow to disable SSBD, which
is only relevant for in process attacks, which are completely
mitigated by process isolation, which is now widely deployed.

Completely mitigating Spectre (which could be cross process) is harder,
and it doesn't have have as bad a performance impact as SSBD.

> 
> And the force disable matches the design goals of seccomp: no applied
> restrictions can be later relaxed for a process. I'm more in favor of

It seems to me this design goal is not useful for 
speculation defenses. If an attacker can call prctl they don't
need speculation attacks anymore, they can just read the memory
directly.

> changing the behavior of SPEC_STORE_BYPASS_CMD_AUTO, but probably not for
> another 3 years at least. (To get us to at least 5 years since Meltdown,
> which is relatively close to various longer LTS cycles.)

The seccomp defenses are mainly for web browsers, whose life cycles have
nothing to do with LTS cycles. Web browsers are updated much faster
because of their bazillion other security holes. If someone doesn't
update their web browser they are completely open to other attacks anyways.
So we can assume they do, and the browsers usually enforce it in 
some way.

I'm not aware of anything else that is not a browser that would rely on the
seccomp heuristic. Are you?

Anyways back to the opt-in:

Anyways one way to keep your design goals would be to split the SECCOMP
flags into flags for SSBD and SPECTRE. Then at least the web browser
could reenable it

-Andi

