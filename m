Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EEAC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 10:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DD8D206C1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 10:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595673536;
	bh=ugfaCdOmsh+SINTvVJocI7HdQFsBVqnfcacYCEu4+UQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wWQxtLshofvPtK18geBpg7I6njb0wQKVYuU+fzu8beH4u0jiocw3SAz7PIw1wWOVO
	 1PnNjtUdb4E9CRFkNzydRLPkmX5xl52iG9+sLqrXhqOx0Lz5nvzGZXSRrV8nypASIL
	 XZLcQ+w/JkTajY17ZNeFotkp2jP6/+KzFi3eyIDA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgGYKiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 06:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbgGYKiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 06:38:54 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54487C0619D3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 03:38:54 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id a8so8733941edy.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 03:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Abyy2Er/XsCBrdFLrMSrl7iTqnBYYPdm4277heekMEY=;
        b=EF7EvHSzrz8fBp+uinEBiF5rMEKU+b/MqvCBYhOvAzK9laJbUZ4Qo5BwKXbrWjHP4f
         miaAF7u1TvS5MDKzlEf9iRr4RkDEB5PpNCO4xrMmJ19Z9P4QIZ52DHh+O5O2/TqtENnA
         e0J77O5ZezxnvGPacwQHlqOB2Vo9hLTGpk6SSVZ1WO7O3qgHQ5AfIqa/LUKQWmEWz8V6
         9CFiKJVf6AnGZcMhHipH3izJlfiBFTTbCo8LgXx49a4l41WgpoANGnsGjn91euAx5Cdd
         V90L8DOVJs6q0woZr+HpwB5ybnObW24shG/xQEcx6Zwgi+lBnLdG0499Nv8bjWNNnvlc
         Zqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Abyy2Er/XsCBrdFLrMSrl7iTqnBYYPdm4277heekMEY=;
        b=C6wOQ66PfcKKPKKtpCpwFYhRNCpSBL15HhHWr0ZM1qi4qY0E2YelqitURS1kzmlJP9
         UEqVsWkVi6eX3x8hWtNAWzQphN9lyCvGDKLfHBYttszaCqD1btv4fakM9f+9i6qzaXck
         eme2nGj1CMsLPdEZNUWEGcyR9YK3rz5KmXLJlKdfPyduttxDCFRXAnAOkr6MZU8qojJT
         YIP6doQmBGv9NocsI9DLfwn0CJOPKs+n8NHZ9kwXybeBJCJk0fe89VVIDuIFsMTpaGIn
         dE7zLcK2dffIfS876DMckS/OtZT2noT2K8q9om8SUVHFdMC8gnrTh+3yj/7MIb1Q5Znk
         ujOQ==
X-Gm-Message-State: AOAM532SlYPpK/mqkmGil2FJqC2YwhKD9JmcKDZ8X4Qwbs2trQ/ZJeK5
        cYm3eJTWEYjQO+3IRcbKBJQ=
X-Google-Smtp-Source: ABdhPJz5Y0QHB+pK2pUF/HVuG2dJPXyVFpIL6Z2EnqoCsfk00LhMv+FxGuBeVbytWZx8S4mBMsf/QA==
X-Received: by 2002:a05:6402:1841:: with SMTP id v1mr12914069edy.198.1595673533056;
        Sat, 25 Jul 2020 03:38:53 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id mj22sm2599772ejb.118.2020.07.25.03.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 03:38:52 -0700 (PDT)
Date:   Sat, 25 Jul 2020 12:38:50 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Regression on todays tip/master (commit 16f70beccf43)
Message-ID: <20200725103850.GA823877@gmail.com>
References: <20200723133743.GA30716@8bytes.org>
 <871rl2xpar.fsf@nanos.tec.linutronix.de>
 <20200723145219.GP27672@8bytes.org>
 <20200724132802.GA640628@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724132802.GA640628@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Joerg Roedel <joro@8bytes.org> wrote:
> 
> > On Thu, Jul 23, 2020 at 04:46:04PM +0200, Thomas Gleixner wrote:
> > > Joerg Roedel <joro@8bytes.org> writes:
> > > > while testing the SEV-ES patches on todays tip/master I triggered the BUG
> > > > below:
> > > >
> > > > [  137.629660] ------------[ cut here ]------------
> > > > [  137.630769] kernel BUG at kernel/signal.c:1917!
> > > > [  137.631796] invalid opcode: 0000 [#1] SMP NOPTI
> > > > [  137.632822] CPU: 3 PID: 28596 Comm: test_syscall_vd Not tainted 5.8.0-rc6-tip+ #3
> > > > [  137.634495] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
> > > > [  137.636236] RIP: 0010:do_notify_parent+0x25c/0x290
> > > > The guest had 4 VCPUs and ran 4 instances of the in-kernel x86-selftests
> > > > in a loop, together with 'perf top -e cycles:k'. As you can see in the
> > > > time-stamps, the issue triggered pretty quickly.
> > > >
> > > > Please let me know if you need more information or testing from my side.
> > > 
> > > Any chance to bisect this?
> > 
> > Yes, will try. I am currently testing plain -rc6, it seems to be fine.
> > Bisecting is next.
> 
> Given that you are perf stress-testing the box, some recent perf 
> commit would be the primary suspect - before doing a full bisect you 
> might want to try current perf/core (2ac5413e5edc) and its upstream 
> base: v5.8-rc3, to narrow it down.
> 
> But in principle any other commit could be the cause as well, the 
> assert suggests memory corruption - I don't think we changed anything 
> in the signal code.

On a second thought, I think this recent bug might have been the 
culprit:

  d136122f5845: ("sched: Fix race against ptrace_freeze_trace()")

Fixed in tip:sched/urgent - this is why it went away in your testing 
perhaps?

I'm sending this fix to Linus today.

Thanks,

	Ingo
