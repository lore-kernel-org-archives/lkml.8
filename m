Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA28AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEA7720792
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgGUJJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 05:09:05 -0400
Received: from 8bytes.org ([81.169.241.247]:58282 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgGUJJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 05:09:05 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 1B17B2C8; Tue, 21 Jul 2020 11:09:03 +0200 (CEST)
Date:   Tue, 21 Jul 2020 11:09:01 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, hpa@zytor.com,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/idt: Make sure idt_table takes a whole page
Message-ID: <20200721090901.GC620@8bytes.org>
References: <0CEC6A66-FD50-4B6B-9521-A40E5B9DA10F@zytor.com>
 <7FB389D0-77D4-482E-8A21-8662DDB00268@amacapital.net>
 <0B7CF270-EC04-4907-821A-A01F24BEF156@zytor.com>
 <20200719023405.GA564835@rani.riverdale.lan>
 <87pn8rokjz.fsf@nanos.tec.linutronix.de>
 <20200720161112.GB620@8bytes.org>
 <87sgdmm8u4.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sgdmm8u4.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 06:48:03PM +0200, Thomas Gleixner wrote:
> But with explicit sections which store only page aligned objects there
> is an implicit guarantee that the object is alone in the page in which
> it is placed. That works for all objects except the last one. That's
> inconsistent.
> 
> By enforcing page sized objects for this section you might also wreckage
> memory sanitizers, because your object is artificially larger than it
> should be and out of bound access becomes legit.

Okay, valid points about the consistency and the memory sanitizers. I'll
submit a patch for the linker scripts soon.

Regards,

	Joerg
