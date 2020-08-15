Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633B7C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CB4920639
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597529483;
	bh=KfGt975NPBEP9wsbMKWVgCVnQOPVZ544VGJDmCxaib4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=dURXVwGUjYOQb+1DbHhaDyNc3Zyyt8LHjfyQXcPfzYwKwrQDlBTQ4HAwYmXyBybzi
	 38Px0YUOewbGid1yLGVTzUXq0c8JPDqrKyXmbOPtg1/8RFU+LvNy8Lznz4hDTvzdMr
	 KjuRLwgNvcy+vrZVLzZcHyDQjT00WoAxZlNCa+wk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbgHOWLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:11:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729348AbgHOWKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 18:10:30 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A37A623119;
        Sat, 15 Aug 2020 11:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597490898;
        bh=KfGt975NPBEP9wsbMKWVgCVnQOPVZ544VGJDmCxaib4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N01FrX8JngsFPU42Abd/sTqdyZS1vJooKBnO6OS702Vcy2BhzsScOlw2LGBOpxcsK
         r0ofxwr3qY2HR2PXlHyxoBEIm7y7t3fLl5+EGO2g3pbT8kyR4slibjMT1nMT1svCqo
         MsYCDE03sR7lCMjeSIKKPuueBKk5zrfBMtEeLO6M=
Date:   Sat, 15 Aug 2020 20:28:15 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] bootconfig: Fix off-by-one in
 xbc_node_compose_key_after()
Message-Id: <20200815202815.27cd58b6491028e4a3f3f540@kernel.org>
In-Reply-To: <20200813230406.2e3b9246@oasis.local.home>
References: <20200813183050.029a6003@oasis.local.home>
        <20200813193818.a44ea9afc447f57d470b2def@linux-foundation.org>
        <20200813230406.2e3b9246@oasis.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Aug 2020 23:04:06 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 13 Aug 2020 19:38:18 -0700
> Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > On Thu, 13 Aug 2020 18:30:50 -0400 Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > > 
> > > While reviewing some patches for bootconfig, I noticed the following
> > > code in xbc_node_compose_key_after():
> > > 
> > > 	ret = snprintf(buf, size, "%s%s", xbc_node_get_data(node),
> > > 		       depth ? "." : "");
> > > 	if (ret < 0)
> > > 		return ret;
> > > 	if (ret > size) {
> > > 		size = 0;
> > > 	} else {
> > > 		size -= ret;
> > > 		buf += ret;
> > > 	}
> > > 
> > > But snprintf() returns the number of bytes that would be written, not
> > > the number of bytes that are written (ignoring the nul terminator).
> > > This means that if the number of non null bytes written were to equal
> > > size, then the nul byte, which snprintf() always adds, will overwrite
> > > that last byte.
> > > 
> > > 	ret = snprintf(buf, 5, "hello");
> > > 	printf("buf = '%s'\n", buf);
> > > 	printf("ret = %d\n", ret);
> > > 
> > > produces:
> > > 
> > > 	buf = 'hell'
> > > 	ret = 5
> > > 
> > > The string was truncated without ret being greater than 5.
> > > Test (ret >= size) for overwrite.  
> > 
> > What are the end-user visible effects of the bug?  IOW, why cc:stable?
> > 
> 
> Hmm, looking at it at a wider view, it may not be an issue. The tools
> code calls this code, and I looked to see if it was possible to corrupt
> the buffer by an incorrect size. But now that I'm looking at the else
> part of the section, it may not be a problem as it may act the same.
> 
> That is, ret == size will make size = 0 with the size -= ret, and we
> get the same result.
> 
> OK, you can drop the patch. Thanks for the review!

Thanks Andrew, you're right. If size == ret, then size -= ret makes
 size = 0 and after that, the loop doesn't change the size. 

> 
> Although, there's no error message if the buffer is not big enough to
> hold the fields.
> 
> Masami?

Ah, I think we need a patch to fix a comment of the function. It says

 * Returns the total length of the key stored in @buf.

But this must be

  * Returns the total bytes of the key which would be written.

As similar to the snprintf(), so that the user can compare the result
with the given buffer size.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
