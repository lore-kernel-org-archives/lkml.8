Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0F2C3F2C6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 23:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1825246A6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 23:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582845322;
	bh=ZZ5ist0tBjfrX9Xv4tYDsQIOtspXflZDuau5xoTTgXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VEQNDFr5MpBN3c/q4OibCv+y+XFeo0RxFHliE3MD6OAAaoWX1C0+Zx0dMohFCHSJ6
	 JNgmFGwf9OOphJu/T9cMpfIxoxupFqWc/kTOgZHngupkwcjW95AOVfRqI/R9z8/CWo
	 zErQuRdEJYYVuBqZsXqNv2UEVX+3OwSSmE+cprwA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbgB0XPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 18:15:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:36340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729656AbgB0XPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 18:15:21 -0500
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E8B9246A4;
        Thu, 27 Feb 2020 23:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582845320;
        bh=ZZ5ist0tBjfrX9Xv4tYDsQIOtspXflZDuau5xoTTgXc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hjlzrtd/bzj6DMSZQi6G0DCajzUEX98JtRfa2LpiLhjYvayOpU7GahSfxoXVkrtv3
         TrVJHsz1aw3CwU6eWaaIqZL2gNYHMZ0vrf8hQ8NYxnywi2tCv79wn/14/T3rYUbDbR
         8o/TCg8oWLjBuq3uN8eGnq5Pe5YtYqe5sJZJSRMo=
Date:   Fri, 28 Feb 2020 00:15:18 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 3/8] x86/entry/common: Mark syscall entry points
 notrace/nokprobe
Message-ID: <20200227231517.GF21795@lenoir>
References: <20200225220801.571835584@linutronix.de>
 <20200225221305.496864179@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225221305.496864179@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 11:08:04PM +0100, Thomas Gleixner wrote:
> Anything before enter_from_user_mode() is not safe to be traced or probed.

Perhaps the changelog should clarify as to why exactly it isn't
safe to trace before enter_from_user_mode(). There have been
so many patches on that lately that I'm not clear on that either.

Thanks.
