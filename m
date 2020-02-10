Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B80AC352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 09:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C272080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 09:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="W7idsM5Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbgBJJvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 04:51:05 -0500
Received: from ozlabs.org ([203.11.71.1]:54747 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726950AbgBJJvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 04:51:05 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48GLks6yxcz9sRN;
        Mon, 10 Feb 2020 20:51:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1581328262;
        bh=YTydLZoYszBuzjKhfW/aeI/bxK6LWTe+ijjjadvaURg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=W7idsM5ZHpcvN1LBIkeLhB++cqQ4o6v4y54v/PeaFOWviWNysrowAhfu/S80+r6IJ
         30FYuvGqdCAHh9kh8Jm+rdR4pQpbQs3P4Sl/4sute2mXt0jOPLAXsdnJ6BJ1thi3gX
         S9DzDqGSJ7Gp1Us975u/LjW9EWFVSmiwDqkn3lkpFMkWdOagV8ZfFTfVkv0m/ylpFG
         DoBOViIU3Wb/S2RyNZe73OyFyQ/04mpE12Q473ccoR3dFxR51RH3bpPhDMjO3iXimZ
         Lxl9ZnCIinpNE258Aqx+GGwITyNkee+UUio+88+7LYuy/IHucuLe0s48sfHirHAsU6
         2FYHx0GIL0oQQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] tools/bootconfig: Suppress non-error messages
In-Reply-To: <20200210161818.fbef4c21a99c8001a6d97ea8@kernel.org>
References: <87lfpd1gi7.fsf@mpe.ellerman.id.au> <158125351377.16911.13283712972275131160.stgit@devnote2> <87d0an19ih.fsf@mpe.ellerman.id.au> <20200210161818.fbef4c21a99c8001a6d97ea8@kernel.org>
Date:   Mon, 10 Feb 2020 20:50:59 +1100
Message-ID: <87v9oezs70.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masami Hiramatsu <mhiramat@kernel.org> writes:
> Hi Michael,
>
> On Mon, 10 Feb 2020 13:06:14 +1100
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>
>> Masami Hiramatsu <mhiramat@kernel.org> writes:
>> > Suppress non-error messages when applying new bootconfig
>> > to initrd image. To enable it, replace printf for error
>> > message with pr_err() macro.
>> > This also adds a testcase for this fix.
>> >
>> > Reported-by: Michael Ellerman <mpe@ellerman.id.au>
>> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
>> > ---
>> >  tools/bootconfig/main.c             |   28 ++++++++++++++--------------
>> >  tools/bootconfig/test-bootconfig.sh |    9 +++++++++
>> >  2 files changed, 23 insertions(+), 14 deletions(-)
>> 
>> Thanks, that works for me.
>> 
>> Tested-by: Michael Ellerman <mpe@ellerman.id.au>
>
> Could you give me your tested-by to the previous patch too?

Sure, just sent.

cheers
