Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73782C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FD962065F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595597289;
	bh=wB4i1IOp1KJRc+qQznpYzpLNqlIbg9c9myZm/j2Jc1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CFmUJuWjsZWbFFViaRXcFmlCyH6e3zax7ynzjT+gJvVoIxwrwIWzdylQCDt34MwnI
	 G499JNCHZkdTu7t1AD8gLHR14Zmtf8bsgAGVlNeBg1xN39dA18YvtYHI7Zm76mPbCD
	 6sj7180c8mELGyWPqeGSPJqTp1esVsCRwBqG2OMM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgGXN2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbgGXN2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:28:06 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615DCC0619E4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 06:28:06 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id g7so1709013ejw.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 06:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OJFe4XlgDaUT1BN7JDWdIBCtuqkoezpQiMpyQlUPivw=;
        b=JlUWCrf2CQySq4nPLDpOuHiYDLaB1teJzoZobzCJo0zPBvTuqqauXTPBf/TE/66b0C
         smsYJAk60fUKqKHoDwQpwT5PVLWEmHnWmEIkrnBbvAN+dtkunIAT5Zv2h8wddOLfpZwf
         E/8IysQenGjDice7jtz4tuDPw+mHWnjqyobHBjJ1Adyk1zZ7XlWC3tqJyDxBOXsghc8v
         m6Jm8eEBFhsebg5H/FFBSj/LtOVDQBomSdrMNrasboyovD5XXjMESgibGtQX+qUsVJvq
         I6LPa+b8jAnOzZ1cETRDBKL+h91q7EbLblkxYEwgmdiyV8u2BTr1Wt8KZ5hzvcPSs2jX
         NWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=OJFe4XlgDaUT1BN7JDWdIBCtuqkoezpQiMpyQlUPivw=;
        b=icaQhXWu7TO9Atby6U+N0GNUrbk71zF6tURsanZ73kmGoPqWyMEutwn/vq9j1NhOSo
         JhBP3ImJ5S7V6H3nFOMjArCzFanLtY6oU05SWVK4H0feRdCrqIDt06PSxRvWdTiZ1yYw
         JbVzhkzdggFGpKb3S61z1IgUN9aQ5HfuoXK/WP4lL6vG4Ss5d1e/dreocPfsdYMrgrYl
         eHoa/O4h99MjmcY8ZFogZIWh2kvcPgOgtCZxVJ6BqpQi1xEzPV4iub7jVcf7OJpi7vGa
         UNcGmTrrahzawmPGBa7FgVvMTmFDhvdl7Mh159I68Dyt/2ThyFT6yH5fjuf9AwoF4CvJ
         KJ0g==
X-Gm-Message-State: AOAM5331uUx4uMOq285TVNOLJTt7neMOhTj4mbtA4ksT+XfDthSz2Pcz
        7fJgrzfugGlb/XIht9dUGz0=
X-Google-Smtp-Source: ABdhPJyQUHxEbR3FDjOM4nETLdD5DuI8fWTzi9csdh5fuQaAYhk+3YtgaIeR4DWWrOpa0gFpJBThXA==
X-Received: by 2002:a17:906:2f17:: with SMTP id v23mr8899876eji.343.1595597285096;
        Fri, 24 Jul 2020 06:28:05 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id bz14sm665571ejc.88.2020.07.24.06.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 06:28:04 -0700 (PDT)
Date:   Fri, 24 Jul 2020 15:28:02 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Regression on todays tip/master (commit 16f70beccf43)
Message-ID: <20200724132802.GA640628@gmail.com>
References: <20200723133743.GA30716@8bytes.org>
 <871rl2xpar.fsf@nanos.tec.linutronix.de>
 <20200723145219.GP27672@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723145219.GP27672@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Joerg Roedel <joro@8bytes.org> wrote:

> On Thu, Jul 23, 2020 at 04:46:04PM +0200, Thomas Gleixner wrote:
> > Joerg Roedel <joro@8bytes.org> writes:
> > > while testing the SEV-ES patches on todays tip/master I triggered the BUG
> > > below:
> > >
> > > [  137.629660] ------------[ cut here ]------------
> > > [  137.630769] kernel BUG at kernel/signal.c:1917!
> > > [  137.631796] invalid opcode: 0000 [#1] SMP NOPTI
> > > [  137.632822] CPU: 3 PID: 28596 Comm: test_syscall_vd Not tainted 5.8.0-rc6-tip+ #3
> > > [  137.634495] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
> > > [  137.636236] RIP: 0010:do_notify_parent+0x25c/0x290
> > > The guest had 4 VCPUs and ran 4 instances of the in-kernel x86-selftests
> > > in a loop, together with 'perf top -e cycles:k'. As you can see in the
> > > time-stamps, the issue triggered pretty quickly.
> > >
> > > Please let me know if you need more information or testing from my side.
> > 
> > Any chance to bisect this?
> 
> Yes, will try. I am currently testing plain -rc6, it seems to be fine.
> Bisecting is next.

Given that you are perf stress-testing the box, some recent perf 
commit would be the primary suspect - before doing a full bisect you 
might want to try current perf/core (2ac5413e5edc) and its upstream 
base: v5.8-rc3, to narrow it down.

But in principle any other commit could be the cause as well, the 
assert suggests memory corruption - I don't think we changed anything 
in the signal code.

Thanks,

	Ingo
