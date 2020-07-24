Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95032C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 11:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A6C12074B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 11:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgGXLBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 07:01:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:45476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgGXLBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 07:01:36 -0400
Received: from gaia (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0C2D2074A;
        Fri, 24 Jul 2020 11:01:34 +0000 (UTC)
Date:   Fri, 24 Jul 2020 12:01:32 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrei Vagin <avagin@gmail.com>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Safonov <dima@arista.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v5 0/6] arm64: add the time namespace support
Message-ID: <20200724110131.GC23388@gaia>
References: <20200624083321.144975-1-avagin@gmail.com>
 <20200705064055.GA28894@gmail.com>
 <20200714015743.GA843937@gmail.com>
 <20200722181506.GA4517@gaia>
 <20200723174140.GA3991167@gmail.com>
 <87d04mvv0g.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d04mvv0g.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 10:25:35PM +0200, Thomas Gleixner wrote:
> Andrei Vagin <avagin@gmail.com> writes:
> > On Wed, Jul 22, 2020 at 07:15:06PM +0100, Catalin Marinas wrote:
> >
> > I don't think that we need to handle this case in the kernel. Users
> > must understand what they are doing and have to write code so that avoid
> > these sort of situations. In general, I would say that in most cases it
> > is a bad idea to call setns from a signal handler.
> 
> This should not be supported in the first place and just let the
> offender die right there.

It would have been nice if we caught the offender easily but since
signal handling doesn't have to be paired with sigreturn(), the kernel
can't tell whether setns() is called in the wrong context. I guess we
just have to live with this (maybe document the restriction in
time_namespaces(7) or setns(2)).

-- 
Catalin
