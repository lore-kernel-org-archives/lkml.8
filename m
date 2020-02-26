Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA5CC4BA09
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 01:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC67224650
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 01:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582679951;
	bh=m5Ec52LnUpmn0dvstISfjGZ103hI4TaopqMNXFzHMV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Hcx1xErTokl7JWU51vM5ZudEkIQGEswmGcNrpkeJ1wR5XtMEDS6AEZVgl95obGdX5
	 NTExnpYRV0crQmPT2hZH4uBtprkfnhkuG0L+fZImKPEK0HKYI1ugc7sGQnFWquCFuL
	 C2I5LerN76WTV6MhdprZO2KOK2G6znfBfO1poZBk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbgBZBTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 20:19:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:44728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729403AbgBZBTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 20:19:10 -0500
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2865420732;
        Wed, 26 Feb 2020 01:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582679949;
        bh=m5Ec52LnUpmn0dvstISfjGZ103hI4TaopqMNXFzHMV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NZPiaJ1JJ9IL4yKcE1BZa6PxohxzMmnHQFz3WCIR+8mWY1Mq1Nu9GTh0V4S6C9Jfe
         cEThpCxCEGv+ie9bZ5nSN/UVRX8pyerqfyezkZWkCGpdoyQGj5j2qJdU4LnxsNuxZk
         Eqg3ssAC2Sraj9Tg7Fx5yMzEDS+QL3GFgp2+r6o4=
Date:   Wed, 26 Feb 2020 02:19:07 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [patch 04/10] x86/traps: Remove pointless irq enable from
 do_spurious_interrupt_bug()
Message-ID: <20200226011906.GI9599@lenoir>
References: <20200225213636.689276920@linutronix.de>
 <20200225220216.518575042@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225220216.518575042@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 10:36:40PM +0100, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> That function returns immediately after conditionally reenabling interrupts which
> is more than pointless and requires the ASM code to disable interrupts again.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lore.kernel.org/r/20191023123117.871608831@linutronix.de

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
