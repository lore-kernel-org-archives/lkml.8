Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B596EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 842752065F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cs33rQ2N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wdUDbYM9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgGXNWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgGXNWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:22:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E354BC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 06:22:36 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595596955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8gts4+rhoCcJmIbspKqY0dRXPYjhj0KR9ID/ZNHGSTY=;
        b=cs33rQ2NIph3IdIHiubXINFkgQEgCuMUMNUwZB5JhRE9WHGCgr5vbG7cTfnoTXOAmznq8e
        Tjw3rKYTn2fHAzbDZ+THN5wWU5w0GI3zmJgw5dmPucL+6Ns2MDhugZqEy5HbmtsCtz3Rls
        x+GiwpenaOHw+QBEqML3RIA7ikoyv0KsgV7BuMUw6I2111kK8XsWjtbh8UjecGuDugaXrY
        mfCjvNSCKDMKiKsLb/+QxjaUYHk+hgB0ddzwPnPS5I8aBfpOECwn/Kzp944oIxFVIgFkbF
        oMKykPXTrTjU2gKBqXzVQM15aItTnzQV7nnpEyJD4rXKtUfkpdFSCp8d1pF0Lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595596955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8gts4+rhoCcJmIbspKqY0dRXPYjhj0KR9ID/ZNHGSTY=;
        b=wdUDbYM98kOo9cWK8AKk8HLRWvE314quZ4hQSY20WWYkfc7cPLvHRt0qLRnLrfSFombc0h
        o9nrg8DG3u4UcgAA==
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrei Vagin <avagin@gmail.com>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Safonov <dima@arista.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v5 0/6] arm64: add the time namespace support
In-Reply-To: <20200724110131.GC23388@gaia>
References: <20200624083321.144975-1-avagin@gmail.com> <20200705064055.GA28894@gmail.com> <20200714015743.GA843937@gmail.com> <20200722181506.GA4517@gaia> <20200723174140.GA3991167@gmail.com> <87d04mvv0g.fsf@nanos.tec.linutronix.de> <20200724110131.GC23388@gaia>
Date:   Fri, 24 Jul 2020 15:22:34 +0200
Message-ID: <874kpxujxh.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Catalin Marinas <catalin.marinas@arm.com> writes:
> On Thu, Jul 23, 2020 at 10:25:35PM +0200, Thomas Gleixner wrote:
>> Andrei Vagin <avagin@gmail.com> writes:
>> > On Wed, Jul 22, 2020 at 07:15:06PM +0100, Catalin Marinas wrote:
>> >
>> > I don't think that we need to handle this case in the kernel. Users
>> > must understand what they are doing and have to write code so that avoid
>> > these sort of situations. In general, I would say that in most cases it
>> > is a bad idea to call setns from a signal handler.
>> 
>> This should not be supported in the first place and just let the
>> offender die right there.
>
> It would have been nice if we caught the offender easily but since
> signal handling doesn't have to be paired with sigreturn(), the kernel
> can't tell whether setns() is called in the wrong context. I guess we
> just have to live with this (maybe document the restriction in
> time_namespaces(7) or setns(2)).

Yes, I know that it's more or less impossible. The 'should' was just
wishful thinking :)

But yes, proper documentation is required.

Thanks,

        tglx
