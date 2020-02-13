Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B481CC3B18C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C80C2073C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aW4NpPK/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbgBMP5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:57:34 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44365 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbgBMP5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:57:21 -0500
Received: by mail-ot1-f65.google.com with SMTP id h9so6000459otj.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 07:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iHd9eEOMss4ignfVOBjMhQvhmaQpxOZedD/hOOnSljE=;
        b=aW4NpPK/CUlNtpEKVSyOptCzOOAEb2UBHdaa2/6OuNkGeDyA/3Ju9hy4bWbsVCTZG2
         HcS2gB+D/ewN3JPKxLD9z/UO/hKQLyHqtZSVOrVNmQFS7sd31qPbQHktwPrdzlHoBTaQ
         ZFHGf/SCImB3lwFh0KIdsJ8b3l2+vU9TRI/9wlxTO9+8s+tdN+BH6p8vuyXjNeSwA7w0
         f1BIjIQA9oUVq2/se0P5dfZmzcBbxr+v1zB7PxiKJAEw1l57/9npFLS22goXHfHH3l2j
         w+WBxEKnHNvvco1oGaxKSTDThGtAQkulVUfNkOtkAgDMGUOeYGWyxz6XOfe5u0o2+AyY
         o4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=iHd9eEOMss4ignfVOBjMhQvhmaQpxOZedD/hOOnSljE=;
        b=fdnAFJeYmt6HJyA4sdVDE2+YQWxV47FB60NE4xwGoirCw7hFwC6JQnxO9RH3ai2cZn
         CjD/orOzPLBadaDAJFgt5rA4lrtOoZwtPxb06Uy1KaORk1y2VKjiqk+AyKoN+a1P7DaU
         +M3s9Lusd8cSXH0prTwvEtxbG2c39DcufmaMTHlMQC608bPymx2aQGj5EHjW1ZnnXfUn
         ujCPMgwteqziM0oM0wc0anTF06vv4KebP6bGJ4w9ZxvvB9cjjHkUEItja2hnjyWk50px
         zL3Kny+5L+Xk6t3oPMzWA9oER9I5wSQKvEZ/vpMnoE7ONkp10ToaJpCHEQupClPgOvi2
         kp1w==
X-Gm-Message-State: APjAAAWALjrumX6dAWPknydVSIjstZbE4OkJQf7TuhdmYM85S7pWekKL
        IEj/Ud0KrIiYtpmk21k4tw==
X-Google-Smtp-Source: APXvYqwW5dr9VVGCv7dnexVl4FihX0lzD1j3rmacCX9mxpMnvRdb7Q/x+CX/eDQeZcBknsVcjEBzxQ==
X-Received: by 2002:a9d:7e99:: with SMTP id m25mr13475107otp.212.1581609439644;
        Thu, 13 Feb 2020 07:57:19 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id m15sm914229otl.20.2020.02.13.07.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 07:57:19 -0800 (PST)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:d0c7:64ad:d8cf:b1d2])
        by serve.minyard.net (Postfix) with ESMTPSA id 97B2A180053;
        Thu, 13 Feb 2020 15:57:18 +0000 (UTC)
Date:   Thu, 13 Feb 2020 09:57:17 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] arm64 kgdb fixes for single stepping
Message-ID: <20200213155717.GR7842@minyard.net>
Reply-To: minyard@acm.org
References: <20200213031131.13255-1-minyard@acm.org>
 <20200213101057.GB1405@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213101057.GB1405@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 10:10:58AM +0000, Will Deacon wrote:
> On Wed, Feb 12, 2020 at 09:11:29PM -0600, minyard@acm.org wrote:
> > I got a bug report about using kgdb on arm64, and it turns out it was
> > fairly broken.  Patch 2 has a description of what was going on.  I am
> > using a Marvell 8100 board.
> > 
> > The following patches fix the problem, but probably not in the
> > best way.  They are what I hacked out to show the problems.
> > 
> > I am not quite sure how this will interact with kprobes and hardware
> > breakpoints which use the same code, but they would have been broken,
> > too, so this is not making them any worse.
> 
> This should all be handled by kgdb itself, not by changing the low-level
> debug exception handling. For example, the '&kgdb_step_hook' can take
> care of re-arming the step state machine and kgdb can also simply disable
> interrupts during the step if it doesn't want to step into the handler.

How can kgdb disable the SS bit in MDSRC, or re-enable it on the right
CPU, without doing this in the exception handling?

I'm actually thinking that this may be a hardware bug.  Looking at the
ARMv8 manual, it looks like PSTATE.SS should be set to 0 if the
processor takes an exception.  That's definitely not happening; if I do
an instruction step from, say, sys_sync(), it gets the single-step trap
on the instruction after the PSTATE.D bit is disabled in el1_irq.

Even so, I think the migration issue is still a problem.  If you do an
eret set up for single-step, and interrupts are on, and you get a timer
interrupt, it could migrate the task to a different CPU if
PREEMPT_ENABLE is set, right?  If so, the MDSRC.SS bit will be set on
the wrong CPU and the single step trap won't happen.  That will break
kprobes, too.

You mention turning off interrupts in kgdb when single-stepping, which
you could do and it would solve this problem.  But it wouldn't solve the
problem of taking a paging exception, which you want to take in this
case.  And you could still migrate on a paging exception.  So I don't
think disabling interrupts is a good solution.

I don't see a solution besides clearing MDSCR.SS on an el1 exception
entry and conditionally setting it on an el1 exception return.  It might
be better to have a thread flag to do this instead of depending on the
setting of that bit; I'm not sure how expensive accessing the MDSRC
register is.

Setting SPSR.SS on subsequent single steps is definitely an issue, but I
can split that out into a separate patch.

-corey

> 
> Will
