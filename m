Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45275C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 17:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 214482082E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 17:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587577197;
	bh=AGiU7qjKR7ZjubwJ6K3M5/8GasoseXdg8O+47fVqLuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1CFXt0WsyGLjjooDvNnnspocEqKuHQ287JNJlspNS70mavpVdEtBc/eWpVIAxMBS5
	 HV8lKsZUriWq2Bn4N8ub2nB51xSICZ0kWkJCj8sb5PQlot8iZSoN9di+GhP/Qo5LZW
	 WMO+GgIPgoaXqUe8PtZdO+xj12pk1EeKnZ9GznOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgDVRj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 13:39:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:47250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbgDVRjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 13:39:55 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54D942076E;
        Wed, 22 Apr 2020 17:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587577195;
        bh=AGiU7qjKR7ZjubwJ6K3M5/8GasoseXdg8O+47fVqLuw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JyusGuPT4yl7OaJxaidjSDJ0k/CikIy6bBfxMY0e+Pl8R0Jyo0kh0xtn6x5NZmkJc
         57TrOndBtCukynqsiQxqbtjZ/p4Kv1jhveVyOIXjcX+v2OQKZhsYeb5Uw/OHmxFOIs
         4BB1KgVHdsNjWZXGTusGX+5UGalpUEJglG0CFtsA=
Date:   Wed, 22 Apr 2020 18:39:47 +0100
From:   Will Deacon <will@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 01/12] add support for Clang's Shadow Call Stack (SCS)
Message-ID: <20200422173938.GA3069@willie-the-truck>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200416161245.148813-1-samitolvanen@google.com>
 <20200416161245.148813-2-samitolvanen@google.com>
 <20200420171727.GB24386@willie-the-truck>
 <20200420211830.GA5081@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420211830.GA5081@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 02:18:30PM -0700, Sami Tolvanen wrote:
> On Mon, Apr 20, 2020 at 06:17:28PM +0100, Will Deacon wrote:
> > > +	 * The shadow call stack is aligned to SCS_SIZE, and grows
> > > +	 * upwards, so we can mask out the low bits to extract the base
> > > +	 * when the task is not running.
> > > +	 */
> > > +	return (void *)((unsigned long)task_scs(tsk) & ~(SCS_SIZE - 1));
> > 
> > Could we avoid forcing this alignment it we stored the SCS pointer as a
> > (base,offset) pair instead? That might be friendlier on the allocations
> > later on.
> 
> The idea is to avoid storing the current task's shadow stack address in
> memory, which is why I would rather not store the base address either.

What I mean is that, instead of storing the current shadow stack pointer,
we instead store a base and an offset. We can still clear the base, as you
do with the pointer today, and I don't see that the offset is useful to
an attacker on its own.

But more generally, is it really worthwhile to do this clearing at all? Can
you (or Kees?) provide some justification for it, please? We don't do it
for anything else, e.g. the pointer authentication keys, so something
feels amiss here.

Thanks,

Will
