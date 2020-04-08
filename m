Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476FAC2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EACB2082F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586362848;
	bh=FvEMB9hEQ08qb6F1rpCNlzPRwlyB2qFUs3E/QV2Pm6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OgKYYMvgQcBw0G3cAO+FYYYeCIXiOjZ4zIq2oo4cMlniRy7knE0LamfFLPTYXQlFs
	 pIOtXTq7vEZqL9LqLt1gwKnt/IaEaPuw7JqG5Tm8EkNbKj0CWXzvRY5gZAfwbIaY7k
	 v89Pg5dWXiUc5Fb0523VxZB4A4THx2FPXMBfcTgE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730175AbgDHQUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 12:20:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:38610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729860AbgDHQUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 12:20:46 -0400
Received: from linux-8ccs.fritz.box (p3EE2C7AC.dip0.t-ipconnect.de [62.226.199.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C1CE20784;
        Wed,  8 Apr 2020 16:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586362846;
        bh=FvEMB9hEQ08qb6F1rpCNlzPRwlyB2qFUs3E/QV2Pm6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LsSBeAnKb8zrghoxl6Ny9D8ifQxNl8stUXIqv+/mZQUUN/FhrgYgBXUke4zhScEzw
         R8i75p1iC+HFGPf+zGSYsk4JQbNPqWe/dCgEzyOmUHc2/eVpMn9kkUbjOkY74RrsUb
         fbt/9Y+suV4HMaVamZIb/zb/ZxvZC/pqwCgCtY54=
Date:   Wed, 8 Apr 2020 18:20:42 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        keescook@chromium.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v2] module: Harden STRICT_MODULE_RWX
Message-ID: <20200408162041.GA18334@linux-8ccs.fritz.box>
References: <20200403171303.GK20760@hirez.programming.kicks-ass.net>
 <20200408153249.GA26619@linux-8ccs>
 <20200408155719.GQ20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200408155719.GQ20730@hirez.programming.kicks-ass.net>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Peter Zijlstra [08/04/20 17:57 +0200]:
[..snip..]
>> Just to clarify, did we want to enforce this only when
>> CONFIG_STRICT_MODULE_RWX=y?  Because here it's still in the
>> CONFIG_ARCH_HAS_STRICT_MODULE_RWX block.
>>
>> Unfortunately, when we add module_enforce_rwx_sections() in the
>> CONFIG_STRICT_MODULE_RWX block, we'll need two empty stubs, one for
>> !CONFIG_ARCH_HAS_STRICT_MODULE_RWX and one for !CONFIG_STRICT_MODULE_RWX.
>>
>> This is because the CONFIG_STRICT_MODULE_RWX block is currently nested
>> within ARCH_HAS_STRICT_MODULE_RWX :/
>
>Yeah, so the primary reason it's under that ARCH_HAS thing is indeed the
>mess and the extra stub required (I'm a lazy sod at times).

Heh :-)

>I then rationalized this decision to myself that having it under
>ARCH_HAS give a more consistent module loading behaviour.
>
>But I really don't care too much, my most my .config's have
>CONFIG_MODULE=n, and the ones that do not very much have the STRICT_RWX
>set.
>
>Put it where you think it's best.

I don't really mind either way, but my gut tells me I should just move
that hunk under STRICT_MODULE_RWX just to be consistent with STRICT
vs. non STRICT semantics. No need to respin, I'll rebase after I queue
the other patch.

Thanks!

Jessica

