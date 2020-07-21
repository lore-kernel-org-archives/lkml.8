Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C8FC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 18:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DCFF206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 18:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="12HYBkZ/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e61+OZve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbgGUSaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 14:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgGUSaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 14:30:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30C5C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 11:30:04 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595356203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ttSe9w6Mw1Qj5PQY7Ph3g7FUnHNh76V9UJxXkZFD+/s=;
        b=12HYBkZ/oOhFY1ip1KDtlpVrb+U/LJEIlIwHN3BY3vjoCgvRD9QxJa3zFLCxcM9hstFhxV
        17veq01BqP87/XaojXaoAjZUfFCu6pvX2/+qd9g3Bt2uY+tjllupwnpEP3SaE+sn5Alyqv
        2SKzPAA7/eRhH+yi3k3QS06uVpRBdsLxKaWW602QygYpHjAIXL/rrQeWypUpwhdNbcfgIQ
        Xxn28hQYMf2wsCRi79lWnJXnpqxHIf8w0mSWIpfVD54A+aH/H6exy4yecH6gMZB3sRAbes
        6up3R1v7Eo8EeGJFNYMfk4a/yNVW9dCxzRN56hkgslQ/Y5XecXZp5ukEOb3tfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595356203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ttSe9w6Mw1Qj5PQY7Ph3g7FUnHNh76V9UJxXkZFD+/s=;
        b=e61+OZveY17BhZHVJQ36vNiT7buatGCsnNxSfFP0Cyf8CH43caW7JUOigVtyS7T4XNufrn
        GoFhoEmtv8Uv7ABA==
To:     David Laight <David.Laight@ACULAB.COM>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "x86\@kernel.org" <x86@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        John Stultz <john.stultz@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: RE: [patch V2 2/5] posix-cpu-timers: Convert the flags to a bitmap
In-Reply-To: <d9bb2c5f6df1471f8863f84e710e50a4@AcuMS.aculab.com>
References: <20200716201923.228696399@linutronix.de> <20200716202044.625081169@linutronix.de> <20200721123452.GA9290@lenoir> <874kq04zn3.fsf@nanos.tec.linutronix.de> <d9bb2c5f6df1471f8863f84e710e50a4@AcuMS.aculab.com>
Date:   Tue, 21 Jul 2020 20:30:02 +0200
Message-ID: <871rl44t79.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Laight <David.Laight@ACULAB.COM> writes:
> From: Thomas Gleixner
>> Sent: 21 July 2020 17:11
>> 
>> Frederic Weisbecker <frederic@kernel.org> writes:
>> > On Thu, Jul 16, 2020 at 10:19:25PM +0200, Thomas Gleixner wrote:
>> >> --- a/kernel/time/posix-cpu-timers.c
>> >> +++ b/kernel/time/posix-cpu-timers.c
>> >> @@ -25,7 +25,7 @@ void posix_cputimers_group_init(struct p
>> >>  	posix_cputimers_init(pct);
>> >>  	if (cpu_limit != RLIM_INFINITY) {
>> >>  		pct->bases[CPUCLOCK_PROF].nextevt = cpu_limit * NSEC_PER_SEC;
>> >> -		pct->timers_active = true;
>> >> +		set_bit(CPUTIMERS_ACTIVE, &pct->flags);
>> >
>> > I guess this one could be __set_bit().
>> 
>> True :)
>
> Hmmm... does this code need the bit operations to be atmomic?
> If not then an bitmap is completely the wrong thing to be using.

Some of it does, otherwise the booleans would have stayed, but I'm
reworking parts of it so this might change.

Thanks,

        tglx
