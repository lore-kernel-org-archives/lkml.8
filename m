Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB59C4BA06
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 08:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8EAB2467B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 08:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mtQ+Hiq+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbgB0ImT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 03:42:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46694 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728539AbgB0ImT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 03:42:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NchcK2F8lTU+wLCCB53RMFq8FiC3rzaeN3BsRLSDq10=; b=mtQ+Hiq+AjYfDtqxea6fYM7MjP
        kQhalP4tsN4PpuxR/h6RsiXOtMDQiTJZ+ee/SCSNNRj/8b6TETlYpB7vuxnzOAvI5Q54CgV571mC0
        Zu8Z+fKALdkt89d3xvq9lkFubNz/0fMI5s8Eb9enZCFZjXPvKtAIX5KBV2lYlahXjZUuXqV2H+40i
        JQll+dNODUHr//z30Zhq0EjX3ngGXhovvvXqX7xBZxBWRRjkX7OBgkFymjL6tzz1RDillFJqaOh9Y
        TVHAf1yZZN5WMwyi1S0poSDXHEcvdS5E6MW22u6oBrtrgxR3Uc14JlWJ9LcoY09mFxKkN+IspUIlm
        94j3k31Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j7Ek5-0001Td-L6; Thu, 27 Feb 2020 08:42:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 90B8530018B;
        Thu, 27 Feb 2020 09:40:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 37DBC2B9AF8C6; Thu, 27 Feb 2020 09:41:59 +0100 (CET)
Date:   Thu, 27 Feb 2020 09:41:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 16/16] x86/entry: Disable interrupts in IDTENTRY
Message-ID: <20200227084159.GF18400@hirez.programming.kicks-ass.net>
References: <20200225223321.231477305@linutronix.de>
 <20200225224145.764810350@linutronix.de>
 <20200226092335.GS18400@hirez.programming.kicks-ass.net>
 <87eeuhp0aw.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eeuhp0aw.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 09:21:11PM +0100, Thomas Gleixner wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
> 
> > On Tue, Feb 25, 2020 at 11:33:37PM +0100, Thomas Gleixner wrote:
> >> Not all exceptions guarantee to return with interrupts disabled. Disable
> >> them in idtentry_exit() which is invoked on all regular (non IST) exception
> >> entry points. Preparatory patch for further consolidation of the return
> >> code.
> >
> > ISTR a patch that undoes cond_local_irq_enable() in the various trap
> > handlers. Did that get lost or is that still on the TODO list
> > somewhere?
> 
> Hmm. I ditched it after we decided that fixing the #PF cases is ugly as
> hell. Lemme find that stuff again.

Hmm, vague memories. Anyway, we can leave that for later, but maybe put
in a comment so we don't forget.
