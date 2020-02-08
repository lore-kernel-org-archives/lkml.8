Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EA6C35250
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 11:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE1F217BA
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 11:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Ad/2Af+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgBHLKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 06:10:48 -0500
Received: from ozlabs.org ([203.11.71.1]:37099 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726995AbgBHLKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 06:10:48 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48F8bn0sXNz9sRK;
        Sat,  8 Feb 2020 22:10:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1581160246;
        bh=11MScsoMyeqa5c+szDIhAjVEW3lvNS5cGRZ69eB6oBg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Ad/2Af+ltMuYd+Ht6TxrJqPzjWaI+lqNnbnRNcYq0Hqk9MsN59HWTRMl/2BhwRl4k
         p5jcZhuhRSrU3rIcbcmicaQJXFHhYOhUK/+LcqQ8tvQoT2cWwHoRYutyh0SGwlOLSs
         R5vpMIgH+GcDcZppMbJTZvL5PrinxlyPgPY0nRiXDi6jWYFz56iMrxD2m05U/VfnbZ
         /g9cCXmbtXJT+er5Di3dBubDn7IzePUN0po8qVPIaWaElE5C1TryAqy9VWtiFc8ud2
         cCmGBgrZp/vyDlkh0qNTNwlkqxVkeldcJ39ZNW0S4AYU7GWt9m21sjB9KnOmCTk/at
         J9VYCWoR4140A==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] tools/bootconfig: Fix wrong __VA_ARGS__ usage
In-Reply-To: <158108370130.2758.10893830923800978011.stgit@devnote2>
References: <87o8ua1rg3.fsf@mpe.ellerman.id.au> <158108370130.2758.10893830923800978011.stgit@devnote2>
Date:   Sat, 08 Feb 2020 22:10:40 +1100
Message-ID: <87lfpd1gi7.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masami Hiramatsu <mhiramat@kernel.org> writes:
> Since printk() wrapper macro uses __VA_ARGS__ without
> "##" prefix, it causes a build error if there is no
> variable arguments (e.g. only fmt is specified.)
> To fix this error, use ##__VA_ARGS__ instead of
> __VAR_ARGS__.
>
> Fixes: 950313ebf79c ("tools: bootconfig: Add bootconfig command")
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  tools/bootconfig/include/linux/printk.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks that builds for me.

The output when adding to a fresh initrd is a bit confusing though, eg:

  $ ./bootconfig -a samples/good-simple.bconf initrd.img
  Apply samples/good-simple.bconf to initrd.img
          Number of nodes: 13
          Size: 120 bytes
          Checksum: 9036
  checksum error: 0 != 444373994
  $ echo $?
  0

ie. the checksum error.

That's because although delete_xbc() does:

	pr_output = 0;
	size = load_xbc_from_initrd(fd, &buf);

in load_xbc_from_initrd() the error message is printed with printf, not
printk, so it's not controlled by pr_output:

	printf("checksum error: %d != %d\n", csum, rcsum);

Switching that line to printk fixes it, ie. makes the checksum error go
away, but it seems a bit odd to be using printk in userspace code.

cheers
