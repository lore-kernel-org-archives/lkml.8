Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16178C2BA83
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 02:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBCC62082E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 02:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="MKKuI7KG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgBJCGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 21:06:18 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:50083 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbgBJCGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 21:06:18 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48G8Qb0Jmwz9sRQ;
        Mon, 10 Feb 2020 13:06:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1581300376;
        bh=Cxk4Np+RK0F4YGKGtiJkVhKEmVGeGevu59EYXpX4lFc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=MKKuI7KGonu40Gk6WTnDEDeMOtT/EUr1ntnl93vwqJuIx36OihdqJgQYjHrDZwqAC
         5ChrMK/4QZ3tv1xcluuhNYBPz+1sUsX0DAb4aBOSUHUqf9cL/9x/7HKH26TzYukYAS
         agYlI9O0uC+ThQu/LQB8+cCy9pLZKQ7cqeBi0r/M9Nux+tLFUb83RRMrXmqka9kpVp
         recSP3LMnYVhhSS6wyxE7qKQFQpadZ5zxew0E19i23VssMy2wi29WAZj6J+Fkaq0TI
         El08adQ/AaXN5xc04JM+Ewr9BR9hpx+GZ0BA+rgCxtwntiO3D7SGntpW9wb0Q4tsOL
         5L27heLNGluQw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] tools/bootconfig: Suppress non-error messages
In-Reply-To: <158125351377.16911.13283712972275131160.stgit@devnote2>
References: <87lfpd1gi7.fsf@mpe.ellerman.id.au> <158125351377.16911.13283712972275131160.stgit@devnote2>
Date:   Mon, 10 Feb 2020 13:06:14 +1100
Message-ID: <87d0an19ih.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masami Hiramatsu <mhiramat@kernel.org> writes:
> Suppress non-error messages when applying new bootconfig
> to initrd image. To enable it, replace printf for error
> message with pr_err() macro.
> This also adds a testcase for this fix.
>
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  tools/bootconfig/main.c             |   28 ++++++++++++++--------------
>  tools/bootconfig/test-bootconfig.sh |    9 +++++++++
>  2 files changed, 23 insertions(+), 14 deletions(-)

Thanks, that works for me.

Tested-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
