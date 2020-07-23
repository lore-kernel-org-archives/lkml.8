Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B7FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 14:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91CB020768
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 14:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ug2TEUNq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aX7htOkj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgGWOqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 10:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgGWOqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 10:46:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE19C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 07:46:06 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595515564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yGvcyUU8IIK/MQJUoGdWT+9Rmu88PZaZBBf5NFsBArs=;
        b=ug2TEUNqIyDZnJ4+S8ihC9um70TC2nXQEW9+UEVy4nMkodbPtQxPqJqW22ktsmOsoO0CsD
        d0pbEzDxvTpJC9Ph+zwBLe/FZvunbdZFRSttYS8AcnDrxAWP+clYfmoXTIdFuN/G2Yc30q
        vJDdUk7eK2JakPNen5cNwsKd31QBEoDWlY2fFluFRU0GII/NiYCLTNGK0AFAv6WnKYyRD5
        NJ84srLC0hxvvJ2I2hm7XyCZ8Fw1hSEbNuYo+2bRIVDd3Q8/OEK+ZFIhAiTFkPVZIGVr8k
        xzlUAoEbbEapnOZ8Lxlz7h/AX3jVRkD1bqp1afcwqcOz74fl/L4ojK9IOz9M7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595515564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yGvcyUU8IIK/MQJUoGdWT+9Rmu88PZaZBBf5NFsBArs=;
        b=aX7htOkjDbnrg2SZGus2XLjG06kfuiwxdqCnEqSQ97ZbL2fOOrCjK6g4ncU3a9zYjPK2Up
        +GD3xT+X2FuiwTBw==
To:     Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Regression on todays tip/master (commit 16f70beccf43)
In-Reply-To: <20200723133743.GA30716@8bytes.org>
References: <20200723133743.GA30716@8bytes.org>
Date:   Thu, 23 Jul 2020 16:46:04 +0200
Message-ID: <871rl2xpar.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Roedel <joro@8bytes.org> writes:
> while testing the SEV-ES patches on todays tip/master I triggered the BUG
> below:
>
> [  137.629660] ------------[ cut here ]------------
> [  137.630769] kernel BUG at kernel/signal.c:1917!
> [  137.631796] invalid opcode: 0000 [#1] SMP NOPTI
> [  137.632822] CPU: 3 PID: 28596 Comm: test_syscall_vd Not tainted 5.8.0-rc6-tip+ #3
> [  137.634495] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
> [  137.636236] RIP: 0010:do_notify_parent+0x25c/0x290
> The guest had 4 VCPUs and ran 4 instances of the in-kernel x86-selftests
> in a loop, together with 'perf top -e cycles:k'. As you can see in the
> time-stamps, the issue triggered pretty quickly.
>
> Please let me know if you need more information or testing from my side.

Any chance to bisect this?

Thanks,

        tglx
