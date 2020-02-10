Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C636C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 07:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE8B21739
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 07:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581319104;
	bh=B3hiZAKFzznLCGF/Ovt7+28OG4VrDhztO8IljR4LwLo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Demusud0VNQbSoiZlMrsk8RtBaqUodB8/DDvoedSRrrigMqRbYuoPyMLfGF0zaEXz
	 kYOzQRiXV8Ua6aOGOetMdlX34JozqeVZxKbPXVzD+huZzK4Jgz/VIjLpng++9f9bdc
	 96nl05UBUQkqM1QaAab5pEl+jNHGb4GklkypkqaQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgBJHSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 02:18:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:45462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgBJHSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 02:18:23 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C952E20838;
        Mon, 10 Feb 2020 07:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581319102;
        bh=B3hiZAKFzznLCGF/Ovt7+28OG4VrDhztO8IljR4LwLo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iKJSIpRZcvvmnHYrwWYnKJU3xWzMbsTPM6vPvWVEE52ggtTXVlmORDbchv6aU94n+
         qKaYgioIagUy8V2Q3VH1v62Q1KvPcZ0sEcGoLnAPZqih7wpgfT/3QQBtTRodSaMRlZ
         3vYwGTpSl9uvu1yHVWLrllVVFINwocSV+kW4yRxQ=
Date:   Mon, 10 Feb 2020 16:18:18 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] tools/bootconfig: Suppress non-error messages
Message-Id: <20200210161818.fbef4c21a99c8001a6d97ea8@kernel.org>
In-Reply-To: <87d0an19ih.fsf@mpe.ellerman.id.au>
References: <87lfpd1gi7.fsf@mpe.ellerman.id.au>
        <158125351377.16911.13283712972275131160.stgit@devnote2>
        <87d0an19ih.fsf@mpe.ellerman.id.au>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Mon, 10 Feb 2020 13:06:14 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Masami Hiramatsu <mhiramat@kernel.org> writes:
> > Suppress non-error messages when applying new bootconfig
> > to initrd image. To enable it, replace printf for error
> > message with pr_err() macro.
> > This also adds a testcase for this fix.
> >
> > Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  tools/bootconfig/main.c             |   28 ++++++++++++++--------------
> >  tools/bootconfig/test-bootconfig.sh |    9 +++++++++
> >  2 files changed, 23 insertions(+), 14 deletions(-)
> 
> Thanks, that works for me.
> 
> Tested-by: Michael Ellerman <mpe@ellerman.id.au>

Could you give me your tested-by to the previous patch too?

Thank you!

> 
> cheers


-- 
Masami Hiramatsu <mhiramat@kernel.org>
