Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11516C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 13:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D931F207BB
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 13:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589722280;
	bh=j3mxr5IVPgfcoNTOXWaaIHv8SoKr2pxZMz433HXVkVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=u/1Di0WbTo5+XFwCIE7JFd2wYHV5QewZORBXi1YPHxzMjiN8tOraKdaC7U+I8nTdb
	 aqOCYLzdUoqkznsFkVjUIGLhNbKzMTgjRdtUS12FigGnOASJs3xkw+qvB7ieV7Z1Fn
	 0OpTYMurD0ySYm3XOFj3hgXIEWNZAPeZgUrgOQpw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgEQNbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 09:31:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:57800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727893AbgEQNbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 09:31:19 -0400
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DA2A206F4;
        Sun, 17 May 2020 13:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589722279;
        bh=j3mxr5IVPgfcoNTOXWaaIHv8SoKr2pxZMz433HXVkVs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NCZKzl/ZNFZ1Zz/FDlUtkYSgTpyCkmQVB1RMQDCm5DzlzGYbzVHd7xbcEkyl46BkA
         CT2ZeJAT7B5p24Vtat9IVos6UIMRjKPtAXDDiIY6J75vedSFZJ0tJ0o0oirbtmj992
         Z+XbA4laSiRpqqwxG4mX1vhkhRt2icDx29Xv4rt0=
Date:   Sun, 17 May 2020 15:31:16 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Matt Fleming <matt@codeblueprint.co.uk>, stable@kernel.org
Subject: Re: [PATCH] tick/nohz: Narrow down noise while setting current
 task's tick dependency
Message-ID: <20200517133115.GA28573@lenoir>
References: <20200515003429.4317-1-frederic@kernel.org>
 <20200516030718.GL2869@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200516030718.GL2869@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 08:07:18PM -0700, Paul E. McKenney wrote:
> On Fri, May 15, 2020 at 02:34:29AM +0200, Frederic Weisbecker wrote:
> > So far setting a tick dependency on any task, including current, used to
> > trigger an IPI to all CPUs. That's of course suboptimal but it wasn't
> > an issue as long as it was only used by posix-cpu-timers on nohz_full,
> > a combo that nobody seemed to use in real life.
> > 
> > But RCU started to use task tick dependency on current task to fix
> > stall issues on callbacks processing. These trigger regular and
> > undesired system wide IPIs on nohz_full.
> > 
> > The fix is very easy while setting a tick dependency on the current
> > task, only its CPU needs an IPI.
> 
> This passes moderate rcutorture testing.  If you want me to take it, please
> let me know, and otherwise:
> 
> Tested-by: Paul E. McKenney <paulmck@kernel.org>

If you already have a pending urgent queue, I'd love you to take it.
If not I can take it.

Thanks.
