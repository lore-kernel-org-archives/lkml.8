Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1827C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 21:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF6FB2076D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 21:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371382AbgDOVLk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 17:11:40 -0400
Received: from ms.lwn.net ([45.79.88.28]:52784 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S371372AbgDOVLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 17:11:34 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1B799739;
        Wed, 15 Apr 2020 21:11:34 +0000 (UTC)
Date:   Wed, 15 Apr 2020 15:11:32 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Peter Maydell <peter.maydell@linaro.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] scripts/kernel-doc: Add missing close-paren in
 c:function directives
Message-ID: <20200415151132.03cad507@lwn.net>
In-Reply-To: <20200414143743.32677-1-peter.maydell@linaro.org>
References: <20200414143743.32677-1-peter.maydell@linaro.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Apr 2020 15:37:43 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> When kernel-doc generates a 'c:function' directive for a function
> one of whose arguments is a function pointer, it fails to print
> the close-paren after the argument list of the function pointer
> argument. For instance:
> 
>  long work_on_cpu(int cpu, long (*fn) (void *, void * arg)
> 
> in driver-api/basics.html is missing a ')' separating the
> "void *" of the 'fn' arguments from the ", void * arg" which
> is an argument to work_on_cpu().
> 
> Add the missing close-paren, so that we render the prototype
> correctly:
> 
>  long work_on_cpu(int cpu, long (*fn)(void *), void * arg)
> 
> (Note that Sphinx stops rendering a space between the '(fn*)' and the
> '(void *)' once it gets something that's syntactically valid.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Interesting.  This appears to have affected well over 100 function
definitions in the docs, and nobody ever noticed.  Good to know we're all
reading it closely :)

Applied, thanks.

> I noticed this first in the copy of kernel-doc that QEMU is using for
> its Sphinx documentation.  Older versions of Sphinx don't try to
> parse the argument to c:function, so the only effect is incorrect
> output, but Sphinx 3.0 does do this and will complain:
>   Invalid C declaration: Expecting "," or ")" in parameters, got "EOF".
> 
> It looks like the kernel docs currently won't build at all
> with Sphinx 3.0; https://github.com/sphinx-doc/sphinx/issues/7421
> so I don't have an example of the error for the kernel docs.
> 
> QEMU is currently carrying another patch to our kernel-doc:
>  https://patchew.org/QEMU/20200411182934.28678-1-peter.maydell@linaro.org/20200411182934.28678-4-peter.maydell@linaro.org/
> which makes it use the new-in-3.0 "c:struct::" directive now
> that "c:type::" no longer accepts "struct foo". Does anybody
> have a plan for how the kernel kernel-doc is going to deal with
> that non-back-compatible Sphinx change?

Thinking about 3.0 is on my list, but I've not gotten there yet.  I really
wish they wouldn't break things like that...

Thanks,

jon
