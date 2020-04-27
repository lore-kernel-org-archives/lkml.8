Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD3AC54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 15:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79583206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 15:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588002855;
	bh=GzHcKeJNUKqZMJXI9hV1XJzO/w60O4aCtaOhcc1X/gM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BiLXqMMbtZqoRh66ZA/JlVNzFC5w+xHNLg/q17AQ5/OqjK3jVBlb9mIQZNORzwdcz
	 sIxXJ9rFwA01JGZrRozU6PJ+C3zzbpP0hLmRDb87lpusg5IDWQLKUSSmsqIbiYFiao
	 KD3Rh9xCfSRrPkUYEpdAlhx7mZF2RGe3tsj7C9Fs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgD0PyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 11:54:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:32992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728119AbgD0PyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 11:54:14 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CE59206D4;
        Mon, 27 Apr 2020 15:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588002853;
        bh=GzHcKeJNUKqZMJXI9hV1XJzO/w60O4aCtaOhcc1X/gM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sc7760sgl9cV7RR6+Ul5gW9Hjs90ASi5+HcKQLCuM/ZlC2UwaeQPAdnBHYvpSUc54
         +Ey6GhAXdE4o1N/IcCH544yKfvEMPlXM7iWlqt5Q/rQQWjeHR5jDwnADMgMiXWqBrZ
         ZqaEJJQ6WdcCMuq5Hz4GK+j8+KWcTiGv4bHlEmNw=
Date:   Mon, 27 Apr 2020 18:54:10 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86 <x86@kernel.org>,
        Suresh Siddha <suresh.b.siddha@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/apic: Fix circular locking dependency between
 console and hrtimer locks
Message-ID: <20200427155410.GG134660@unreal>
References: <20200407170925.1775019-1-leon@kernel.org>
 <20200414054836.GA956407@unreal>
 <20200414062454.GA84326@gmail.com>
 <87tv15qj5u.fsf@nanos.tec.linutronix.de>
 <20200427113218.GB134660@unreal>
 <87h7x5qe3v.fsf@nanos.tec.linutronix.de>
 <20200427134130.GE134660@unreal>
 <87y2qhoshi.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2qhoshi.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 05:31:21PM +0200, Thomas Gleixner wrote:
> Leon Romanovsky <leon@kernel.org> writes:
> > OK, I consulted with verification people and back then the trigger was:
> > Reproduce when run "echo 1 > /sys/kernel/debug/clear_warn_once" after
> > reboot
>
> That explains it.
>
> > [    0.937310] Freeing SMP alternatives memory: 32K
> > [    0.940471] TSC deadline timer enabled
>
> So here is the first one which sets 'once'. Of course if you clear 'once'
> afterwards then this triggers because the context is completely
> different.
>
> So the right thing to do is to move this out of __setup_APIC_LVTT() and
> be done with it.

Thanks a lot.
