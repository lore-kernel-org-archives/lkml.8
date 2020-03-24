Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219B9C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 21:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA3E42078A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 21:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585084097;
	bh=Ts2q4lc5rS0zE3p9NKfuZ3OCIDyXTdzeBDRNZoAYpTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MTSUoOl+zgxN4C3DKSwDug2boaM+saEKvfLetdIyd/fq60sOuxJDX72PhVVmMR8CB
	 XKrMeg0Tn8pyVVZmAziOztOOTAtDZMQ10WlvVB+ReGzTRCILRs0NeFYLlHsNqekFdc
	 +DT6yeak7Yf9Rct3+4Rvv84XwdnXCrPPoeS8G9Fk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgCXVIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 17:08:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:51672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbgCXVIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 17:08:16 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD1E22074D;
        Tue, 24 Mar 2020 21:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585084095;
        bh=Ts2q4lc5rS0zE3p9NKfuZ3OCIDyXTdzeBDRNZoAYpTg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dcbn27CTP2jdEE8Ft12vQNu+KMxtzPKAyV+xeoInVKlIwjJB9hsf+U831sbsfiY9s
         79yCeVkuICil1S4IFAkNrKNbTMyHP2iMAWtYIjJJIG5KnsML5NtKNjADY/lmxvnjTc
         vpdD56t4J55t5JoPQSl+f0JSXuFSCmOpP/2m/gK8=
Date:   Tue, 24 Mar 2020 21:08:09 +0000
From:   Will Deacon <will@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Maddie Stone <maddiestone@google.com>,
        Marco Elver <elver@google.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        kernel-hardening@lists.openwall.com
Subject: Re: [RFC PATCH 17/21] linux/bit_spinlock.h: Include linux/processor.h
Message-ID: <20200324210808.GA19527@willie-the-truck>
References: <20200324153643.15527-1-will@kernel.org>
 <20200324153643.15527-18-will@kernel.org>
 <20200324162820.GD2518046@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324162820.GD2518046@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 05:28:20PM +0100, Greg KH wrote:
> On Tue, Mar 24, 2020 at 03:36:39PM +0000, Will Deacon wrote:
> > Needed for cpu_relax().
> 
> Is this needed now, or for the next patch?  And if for next patch, why
> not just add it then?

If the next patch correctly included linux/list_bl.h like it was supposed
to, then yes, it's needed there. I'll sort that out and fold this in for
v2.

Cheers,

Will
