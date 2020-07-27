Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28651C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 20:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE73420809
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 20:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y+lqk4wl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ubrfn5F5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgG0U4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 16:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbgG0U4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 16:56:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB0DC061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 13:56:06 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595883364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vGlklfhOhKMe52+hawZnpl3d36F4/BFOW/Vk8oQE7eM=;
        b=Y+lqk4wl3HL7c+JNJAFxRC1GzsSXbJ0VMOlLjOY4Ni0TuONAOSVDBx2jAX8nnZd9BJx/LJ
        ap3ZhsmV0KycsC33/t7LDlK64uUeKZG4Sgz5Mm1qFk7nBwIKfdCcWOIGX9sifLuHxKnl9B
        Z6qaybkU6dgaYLrf7pL0v5STxN3MfKHOQdyZSyBnwlpvpUjztrkueY9B6C2kV6ICuTHRnF
        6/K9i7GCqexJK0/s9WcEY05TuXaNbevELaiy1FFvGJODfvYxojlZoJbf7mJtCx6CQKy/+0
        xRtD6tM7bcSK867HNsXVNZwEE0+15y3hmh6vZvEch3mzK6IfSOiQ5p+E53sGjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595883364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vGlklfhOhKMe52+hawZnpl3d36F4/BFOW/Vk8oQE7eM=;
        b=ubrfn5F5T2p7GfJQ/BCtS23kE9iQnqxHg/uK2gDXVj+jvcTjq8vwhFhrAQi0w2a1HvwOVE
        5VcYODlch6rUInCQ==
To:     peterz@infradead.org, Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mbenes@suse.cz
Subject: Re: [PATCH] objtool,x86: Verify poke_int3_handler() is self contained
In-Reply-To: <20200727104050.GH119549@hirez.programming.kicks-ass.net>
References: <20200727104050.GH119549@hirez.programming.kicks-ass.net>
Date:   Mon, 27 Jul 2020 22:56:03 +0200
Message-ID: <87eeowbrto.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

peterz@infradead.org writes:
> Abuse the SMAP rules to ensure poke_int3_handler() doesn't call out to
> anything.

Yuck. Isn't that what noinstr is for or am I missing something?

Thanks,

        tglx


