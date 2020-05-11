Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438C0C54E8E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 00:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F16D2184D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 00:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589158654;
	bh=LpZzJNZGmsoRYfY3qNWlHhWaDTqLtBQwXcNrDeXRhAI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ts4sGzB8O0chYH0WQ3ssegnwS8cXGPdrGkGdRswkU+SwNkhvQqwbhbxC63VJhKwt0
	 HMEwEgHPpBfRGdErr9CZoiYSQ/O5nTXDo7j7KApRPpPlSjPBnKGI0+op98qjH2sFNF
	 8eXsMHqQdwheQ2UnfVci6pZOE9/YImfLPy9rB41U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbgEKA5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 20:57:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729095AbgEKA5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 20:57:33 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1D03207FF;
        Mon, 11 May 2020 00:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589158652;
        bh=LpZzJNZGmsoRYfY3qNWlHhWaDTqLtBQwXcNrDeXRhAI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BLCEQUijg1l/kP1iVWLZtToWBUN0TbgETDk4LIeWK9lrnhjjuP/YwKpwlB7pfpiIH
         ul1imYYFV8YR5MxBGyyqLGMALNw4aMjkqC8N0g7iArzZl/Uv4OHi7Y38XS0tUsImo4
         FuQhcgFErvObEM3EAs70l9VIvt7JeTu4c9uFy2ao=
Date:   Mon, 11 May 2020 09:57:28 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Borislav Petkov <bp@alien8.de>, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Regression with *bootconfig: Fix to remove bootconfig data from
 initrd while boot*
Message-Id: <20200511095728.8490ad9e3d5a25e7400a4910@kernel.org>
In-Reply-To: <9b1ba335-071d-c983-89a4-2677b522dcc8@molgen.mpg.de>
References: <9b1ba335-071d-c983-89a4-2677b522dcc8@molgen.mpg.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 May 2020 19:16:47 +0200
Paul Menzel <pmenzel@molgen.mpg.de> wrote:

> Dear Masami,
> 
> 
> Commit de462e5f10 (bootconfig: Fix to remove bootconfig data from initrd 
> while boot) causes a cosmetic regression on my x86 system with Debian 
> Sid/unstable.
> 
> Despite having no `bootconfig` parameter on the Linux CLI, the warning 
> below is shown.
> 
>      'bootconfig' found on command line, but no bootconfig found
> 
> Reverting the commit fixes it.

Oops, sorry about that.
I'll fix it soon.

Thanks!

-- 
Masami Hiramatsu <mhiramat@kernel.org>
