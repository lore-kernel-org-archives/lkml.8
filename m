Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20C9C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9458F205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbgEMVeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 17:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728711AbgEMVeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 17:34:17 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3D3C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 14:34:17 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jYz12-0004hG-39; Wed, 13 May 2020 23:34:12 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 2837B100605; Wed, 13 May 2020 23:34:11 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     psodagud@codeaurora.org
Cc:     john.stultz@linaro.org, sboyd@kernel.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, saravanak@google.com,
        pkondeti@codeaurora.org, Joonwoo Park <joonwoop@codeaurora.org>
Subject: Re: [PATCH v3 1/2] timer: make deferrable cpu unbound timers really not bound to a cpu
In-Reply-To: <ba1e3e84f0a77d550898222e94844ca7@codeaurora.org>
References: <1588444137-18651-1-git-send-email-psodagud@codeaurora.org> <1588444137-18651-2-git-send-email-psodagud@codeaurora.org> <87a72lkx9t.fsf@nanos.tec.linutronix.de> <dbc01cd27346bb465744b93ece2b6362@codeaurora.org> <87d0771swr.fsf@nanos.tec.linutronix.de> <ba1e3e84f0a77d550898222e94844ca7@codeaurora.org>
Date:   Wed, 13 May 2020 23:34:11 +0200
Message-ID: <8736831pv0.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prasad,

psodagud@codeaurora.org writes:
> On 2020-05-13 13:28, Thomas Gleixner wrote:
>> psodagud@codeaurora.org writes:
>>> It is not clear to me how to avoid #ifdef's in this case. Could you
>>> please share an example here?
>> 
>> The answer is further down already:
>
> I think, you are referring stub functions. Yes. I can reduce some of the 
> #ifdefs with stub functions as you mentioned and not all the cases 
> right?
> I have introduced two variables timer_base_deferrable and 
> deferrable_pending and I can put stub function where ever is possible. 
> But it may not be appropriate to have stub function for all the 
> references of these variables right? Correct me if my understanding is 
> wrong.

Is this a quiz or are you expecting me to make your homework?

Thanks,

        Thomas
