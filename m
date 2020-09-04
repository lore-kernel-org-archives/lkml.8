Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3E4C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B7F12074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YnlEN4f7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbgIDPlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgIDPlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:41:02 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595A9C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 08:41:02 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g4so7197564wrs.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2TzoBat9rSOZ6f++r+CepUVmCJOu3zYkmgghF9mksEs=;
        b=YnlEN4f7iF+L8Q2CLkv0licnnoCK1sE20W+PiA6DQxq9uzUghg6CdEFLBuBsZab07N
         kWBC+5MR8a30w/2UZmUW0CFe9NU3v5xelGM/wUSAByE7li5cGhXYGk44PpEZLPP4ghCC
         LwI2/fuDs+iBM00pNEHsfT8B87WYLBzlRSgKnef+klltPoKq7QcUE49JhbE0Kc0x6dRe
         DLfLwu9x0k8ET5+QM7n/g0XxhdpsXtt31PonhoyMWQVABgWPqfLO+sjDxNOY3WmOYvul
         kKCGsCWVfLeYgoW6s9vHiHY0YOPYFSMlskcwTd8aa7j3IgT1u4s6B60J8mu2IpvwuVgD
         5YXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2TzoBat9rSOZ6f++r+CepUVmCJOu3zYkmgghF9mksEs=;
        b=rxnW1+qNrgLir2R9YGk9BTqILLOqKLLHtBV5xenfDSzK7J3F6YUG0eKhofB9o82zvP
         BNs7FXulDpdYk5/kTz1QlLIiO3lR+cWo4c9jCNoFSLjaWEjUF642j/SPe9i1rxtjLJhd
         0RvcQcRN3YF9ioTK19pstpU1oWAlmBS4n3CV6DCSRI4RhaETpELcBY0Fjc2C8oaEfjZm
         iaVXXqZqRMZzjZIc+0Ey7UsT5TkBIdQw6+sYu5ZhAiKUCxMmdbhV8XhmU78ups2kfIuh
         eDr8bJUwVXDDIVO2r0zSKENZ+6cqKxCANIfiy0kBi323tpUhy3DtiaO6GeKJRM6o98xR
         JNpw==
X-Gm-Message-State: AOAM53102cXXf4aYoWtERis2YHVuQ2wjqmikH9uA2ybIq8Y+Kf2w4TCR
        XgKySsm5Bsuaa6DrVyXOUtF2cw==
X-Google-Smtp-Source: ABdhPJz9OexeGYtGOyyjCI7anjKl2LCCfHPKb7HFS1IgEZtNKIcVFCxXhMEfjgz2pFwwFZuU6kqojw==
X-Received: by 2002:a5d:60c6:: with SMTP id x6mr8233226wrt.26.1599234060917;
        Fri, 04 Sep 2020 08:41:00 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id y5sm2733111wrh.6.2020.09.04.08.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:41:00 -0700 (PDT)
Date:   Fri, 4 Sep 2020 16:40:58 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Will Deacon <will@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Patch Tracking <patches@linaro.org>
Subject: Re: [PATCH v2 3/3] kgdb: Add NOKPROBE labels on the trap handler
 functions
Message-ID: <20200904154058.qdrdkkctfs66ouw2@holly.lan>
References: <20200716151943.2167652-1-daniel.thompson@linaro.org>
 <20200716151943.2167652-4-daniel.thompson@linaro.org>
 <CAD=FV=UBMa4pt7Xg2sKXHdjo6tVaQWBQFtT_aoDJ+Xt1HrPD+Q@mail.gmail.com>
 <20200720081323.5f3xojhu6v23jgqi@holly.lan>
 <CAD=FV=VipxFspgHJZ0uKURyfE4e3GB-w3gyJZdRn5CF9aLT8fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=VipxFspgHJZ0uKURyfE4e3GB-w3gyJZdRn5CF9aLT8fg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 02:22:08PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Mon, Jul 20, 2020 at 1:13 AM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > On Fri, Jul 17, 2020 at 03:39:58PM -0700, Doug Anderson wrote:
> > > Hi,
> > >
> > > On Thu, Jul 16, 2020 at 8:20 AM Daniel Thompson
> > > <daniel.thompson@linaro.org> wrote:
> > > >
> > > > Currently kgdb honours the kprobe blocklist but doesn't place its own
> > > > trap handling code on the list. Add labels to discourage attempting to
> > > > use kgdb to debug itself.
> > > >
> > > > These changes do not make it impossible to provoke recursive trapping
> > > > since they do not cover all the calls that can be made on kgdb's entry
> > > > logic. However going much further whilst we are sharing the kprobe
> > > > blocklist risks reducing the capabilities of kprobe and this would be a
> > > > bad trade off (especially so given kgdb's users are currently conditioned
> > > > to avoid recursive traps).
> > > >
> > > > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> > > > ---
> > > >  kernel/debug/debug_core.c | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > >
> > > I could just be missing something, but...
> > >
> > > I understand not adding "NOKPROBE_SYMBOL" to generic kernel functions
> > > that kgdb happens to call, but I'm not quite sure I understand why all
> > > of the kdb / kgdb code itself shouldn't be in the blocklist.  I
> > > certainly don't object to the functions you added to the blocklist, I
> > > guess I'm must trying to understand why it's a bad idea to add more or
> > > how you came up with the list of functions that you did.
> >
> > Relatively early in the trap handler execution (just after we bring the
> > other CPUs to a halt) all breakpoints are replaced with the original
> > opcodes. Therefore I only marked up functions that run between the trap
> > firing and the breakpoints being removed (and also between the
> > breakpoints being reinstated and trap exit).
> 
> Ah, OK!  Could that be added to the commit message?

Will do.
 
> Also, shouldn't you mark kgdb_arch_set_breakpoint()?  What about
> dbg_activate_sw_breakpoints()?  I haven't gone and extensively
> searched, but those two jump out to me as ones that were missed.

Agree. I think I over-focusses on the entry path. I will review the
exit path more closely.

> I suppose that means that if someone tried to set a breakpoint on a
> kgdb function that wasn't one of the ones that you listed then the
> system would happily report that the breakpoint has been set (no error
> given) but that the breakpoint would just have no effect?  It wouldn't
> crash (which is good), it just wouldn't detect that the breakpoint was
> useless.

Assuming the kgdb function is used exclusively from the trap handler
then this is correct.

> However, if these were in the NOKPROBE_SYMBOL then you'd get
> a nice error message.  Is there no way we could use a linker script to
> just mark everything using a linker script or somesuch?

You'd still get odd effects with library functions that are used inside
and outside the debugger (which can be breakpointed but don't trigger
inside kgdb). Arguably the effect is clearer to users if they can see
kdb/kgdb functions behaving the same way as library functions. It's odd
but it won't promote false expectations from users.


Daniel.
