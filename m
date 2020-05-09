Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545B3C38A2A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 00:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2561A24953
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 00:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588983073;
	bh=OCJ83ytuwXv45OnOiAlJSMIZEo8q5Uw1eby5O6JdPes=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=o4zHJitlsjydZeE9kXCdGG/qxTWrt60QPDOOXdL3x18Bw2DoCjNEexMheerUgAPYo
	 uHF5NeQFWZdGXUkZspWd3MkYnpEGEDeQnqZSX/oCxSfMvSvXVPeqIGuTocTIKEIu8R
	 fNZF7qoAUK77uFiLEOGW88kQ/SRVQTX6OzkpjzaQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgEIALM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 20:11:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:58486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727890AbgEIALM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 20:11:12 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81BED2184D;
        Sat,  9 May 2020 00:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588983071;
        bh=OCJ83ytuwXv45OnOiAlJSMIZEo8q5Uw1eby5O6JdPes=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=axpwNfALf/EVsvKzEzzMW+KXTEoKQb358I0WBAbtpPFljrL8kJsrLQBDjZkf7sAII
         zdJF+t2MNaadDgYNIXdOFG92HZQYNM18X+ektT/WCk89veErSelzWZvuAEU8GKOlXE
         jGxzxUIauVOImL7vDDi2/VMD2swE9u5OIgzlYUDI=
Date:   Sat, 9 May 2020 09:11:07 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
Subject: Re: [PATCH] tools/bootconfig: Fix apply_xbc() to return zero on
 success
Message-Id: <20200509091107.eb4f517a93ff2e0ae5e64b93@kernel.org>
In-Reply-To: <20200509081424.7d0d21270f1725b5cf9a8535@kernel.org>
References: <20200508111349.3b599bde@gandalf.local.home>
        <20200509081424.7d0d21270f1725b5cf9a8535@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 May 2020 08:14:24 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Fri, 8 May 2020 11:13:49 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > 
> > The return of apply_xbc() returns the result of the last write() call, which
> > is not what is expected. It should only return zero on success.
> > 
> > Link: https://lore.kernel.org/r/20200508093059.GF9365@kadam
> > 
> 
> Thanks for fixing!
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 

Oh, and tested too.

---
...
test case 40 (samples/good-tree.bconf)... 
Apply samples/good-tree.bconf to ./initrd-tNhd
	Number of nodes: 16
	Size: 136 bytes
	Checksum: 9171
		[OK]

All tests passed
---

Tested-by: Masami Hiramatsu <mhiramat@kernel.org>

BTW, I might better add a test summary to the test script (and move it
into kselftest?)

Thank you,

> 
> > Fixes: 8842604446d1 ("tools/bootconfig: Fix resource leak in apply_xbc()")
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---
> >  tools/bootconfig/main.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
> > index 001076c51712..0efaf45f7367 100644
> > --- a/tools/bootconfig/main.c
> > +++ b/tools/bootconfig/main.c
> > @@ -337,6 +337,7 @@ int apply_xbc(const char *path, const char *xbc_path)
> >  		pr_err("Failed to apply a boot config magic: %d\n", ret);
> >  		goto out;
> >  	}
> > +	ret = 0;
> >  out:
> >  	close(fd);
> >  	free(data);
> > -- 
> > 2.20.1
> > 
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
