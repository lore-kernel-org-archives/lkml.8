Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B967CC2BA83
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 04:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8289420838
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 04:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581221373;
	bh=Sr2ZhEDZB2/bXu2Sp7IgPjpFEipqZzwPeSej1aJpqo0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=RiGVdrsRCvjTVPZCo6wOLuOg9DV6VOPiMiJ5HxpeSCYwLLiubHE5NLZV3WMxPcCu7
	 TRvfbsyktTwe874ATYG30AX/pBpvLlXIjCCGTpges71JgE9HybtwT17EXFGHhUZa6r
	 SGs2qHsTxWR5sqoAAPgnTRX08KZN/UbjDJLkh10Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbgBIEJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 23:09:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:58788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727550AbgBIEJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 23:09:32 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 142272080D;
        Sun,  9 Feb 2020 04:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581221371;
        bh=Sr2ZhEDZB2/bXu2Sp7IgPjpFEipqZzwPeSej1aJpqo0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iICAJs2IWDCCU4DZdQYDo303aSqGZ64tNTsCrNzUEL1PEwit9EFOsj5Ydi7YH62gX
         Bnp1Rx43Ok5xSo63sDxBWzAbDTfvz8FkCsbmEn2TiMiwI3qpe3NkXf671GcivHDZDy
         UXHjqzyK8+z38ldaQrnP3uFTNZgq/4Ov4suoIeQ8=
Date:   Sun, 9 Feb 2020 13:09:27 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] tools/bootconfig: Fix wrong __VA_ARGS__ usage
Message-Id: <20200209130927.19b43a5a4da8b93e60f88a64@kernel.org>
In-Reply-To: <87lfpd1gi7.fsf@mpe.ellerman.id.au>
References: <87o8ua1rg3.fsf@mpe.ellerman.id.au>
        <158108370130.2758.10893830923800978011.stgit@devnote2>
        <87lfpd1gi7.fsf@mpe.ellerman.id.au>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 08 Feb 2020 22:10:40 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Masami Hiramatsu <mhiramat@kernel.org> writes:
> > Since printk() wrapper macro uses __VA_ARGS__ without
> > "##" prefix, it causes a build error if there is no
> > variable arguments (e.g. only fmt is specified.)
> > To fix this error, use ##__VA_ARGS__ instead of
> > __VAR_ARGS__.
> >
> > Fixes: 950313ebf79c ("tools: bootconfig: Add bootconfig command")
> > Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  tools/bootconfig/include/linux/printk.h |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Thanks that builds for me.
> 
> The output when adding to a fresh initrd is a bit confusing though, eg:
> 
>   $ ./bootconfig -a samples/good-simple.bconf initrd.img
>   Apply samples/good-simple.bconf to initrd.img
>           Number of nodes: 13
>           Size: 120 bytes
>           Checksum: 9036
>   checksum error: 0 != 444373994
>   $ echo $?
>   0
> 
> ie. the checksum error.

Hmm...

> 
> That's because although delete_xbc() does:
> 
> 	pr_output = 0;
> 	size = load_xbc_from_initrd(fd, &buf);
> 
> in load_xbc_from_initrd() the error message is printed with printf, not
> printk, so it's not controlled by pr_output:
> 
> 	printf("checksum error: %d != %d\n", csum, rcsum);

Oh, I got it. If there is no bootconfig in initrd, it warns but
that is expected result. 

> 
> Switching that line to printk fixes it, ie. makes the checksum error go
> away, but it seems a bit odd to be using printk in userspace code.

What about pr_err() as perf does? :)
OK, I'll fix the error messages.

Thank you,


> 
> cheers


-- 
Masami Hiramatsu <mhiramat@kernel.org>
