Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0AEC11D24
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 23:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A7A20801
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 23:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582241707;
	bh=+vxZumNs1ah+G+/HYQ/utLfPw5v1Cw4mV4Ea+m4M9gg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=yGvFfPgpFLlPof+eluDYuuFpd0R+DcBlvuveWs6c64K/Ev8dSfIWRSekut1R8xj41
	 vd8KgtKBajFg0ND0aGzllNU07OITEXRW70xdhBIR55Fqhyb3M1x+dPqzzLbFsGdQqZ
	 GIZ2IX+j78jc8psIIBEV8fUXhtBGneJf9rfItx+s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbgBTXfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 18:35:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:57544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729382AbgBTXfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 18:35:04 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D5A4208CD;
        Thu, 20 Feb 2020 23:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582241704;
        bh=+vxZumNs1ah+G+/HYQ/utLfPw5v1Cw4mV4Ea+m4M9gg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gs1lr4IENJuU8QEKWW+cxv9RVYuHxiiyrkN0+7PjLhZyyT9BpT+14/NN0KSYh/c+g
         Vpe7B3DycW7UevacPa0zpmffKRo+VU07e+UVjSYCCe++VP+QnIOiV6qvzvrSQUXWpi
         9Ao/OpVfYlC7PuAEbXx54syVA9N6ZKek4hJKJgpw=
Date:   Fri, 21 Feb 2020 08:34:59 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 4/8] bootconfig: Remove unneeded checksum
Message-Id: <20200221083459.5469ae4bbb26b57f2063ec99@kernel.org>
In-Reply-To: <20200220121431.0de871fe@gandalf.local.home>
References: <158220110257.26565.4812934676257459744.stgit@devnote2>
        <158220114239.26565.3917262826354805559.stgit@devnote2>
        <20200220121431.0de871fe@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2020 12:14:31 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 20 Feb 2020 21:19:02 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Remove checksum of bootconfig because we already use a magic
> > word to identify bootconfig. This checksum was used for
> > checking whether there is a bootconfig at the end of initrd
> > or not. Since we have a bootconfig magic word to identify
> > the bootconfig data, we do not this checksum anymore.
> > 
> > Thus the block image of the initrd file with bootconfig is
> > as follows.
> > 
> > [initrd][bootconfig][size(u32)][#BOOTCONFIG\n]
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >
> 
> Hmm, I think the checksum is still good to have, in case of a corrupted
> file. Does it hurt to keep it?

No problem. We can drop this patch.
I thought this check was a bit redundant since (originally) this was
introduced to identify the bootconfig.

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
