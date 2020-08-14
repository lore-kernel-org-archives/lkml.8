Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1EEC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 03:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81B3A20716
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 03:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgHNDEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 23:04:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:40076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbgHNDEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 23:04:08 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BE6B20716;
        Fri, 14 Aug 2020 03:04:08 +0000 (UTC)
Date:   Thu, 13 Aug 2020 23:04:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] bootconfig: Fix off-by-one in
 xbc_node_compose_key_after()
Message-ID: <20200813230406.2e3b9246@oasis.local.home>
In-Reply-To: <20200813193818.a44ea9afc447f57d470b2def@linux-foundation.org>
References: <20200813183050.029a6003@oasis.local.home>
        <20200813193818.a44ea9afc447f57d470b2def@linux-foundation.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Aug 2020 19:38:18 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Thu, 13 Aug 2020 18:30:50 -0400 Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > 
> > While reviewing some patches for bootconfig, I noticed the following
> > code in xbc_node_compose_key_after():
> > 
> > 	ret = snprintf(buf, size, "%s%s", xbc_node_get_data(node),
> > 		       depth ? "." : "");
> > 	if (ret < 0)
> > 		return ret;
> > 	if (ret > size) {
> > 		size = 0;
> > 	} else {
> > 		size -= ret;
> > 		buf += ret;
> > 	}
> > 
> > But snprintf() returns the number of bytes that would be written, not
> > the number of bytes that are written (ignoring the nul terminator).
> > This means that if the number of non null bytes written were to equal
> > size, then the nul byte, which snprintf() always adds, will overwrite
> > that last byte.
> > 
> > 	ret = snprintf(buf, 5, "hello");
> > 	printf("buf = '%s'\n", buf);
> > 	printf("ret = %d\n", ret);
> > 
> > produces:
> > 
> > 	buf = 'hell'
> > 	ret = 5
> > 
> > The string was truncated without ret being greater than 5.
> > Test (ret >= size) for overwrite.  
> 
> What are the end-user visible effects of the bug?  IOW, why cc:stable?
> 

Hmm, looking at it at a wider view, it may not be an issue. The tools
code calls this code, and I looked to see if it was possible to corrupt
the buffer by an incorrect size. But now that I'm looking at the else
part of the section, it may not be a problem as it may act the same.

That is, ret == size will make size = 0 with the size -= ret, and we
get the same result.

OK, you can drop the patch. Thanks for the review!

Although, there's no error message if the buffer is not big enough to
hold the fields.

Masami?

-- Steve
