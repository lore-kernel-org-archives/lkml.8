Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25855C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 19:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5C002078D
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 19:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ECRfbia0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IhE4sV9h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbgHPTig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 15:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbgHPTig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 15:38:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BFBC061786
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 12:38:35 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597606707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zj2bPBJN64iZzxDKZPd2o/t71Sq/zP3xAM9fWh7m0IA=;
        b=ECRfbia0QszbU4Eu+FWfl8oM1VR7WW1yqyiWbyxRzp2s1sNKxwP7pHe/jm52d4eUq1x6Yd
        oEie43eoJM3tRxxGJBp1zCYssVgmp7VaJDOovmzQQCTEysx+zVF9RZFPSv5FaG97VOyZKz
        ENHeg4yy2j3XxR8BnO2dMJYF4lVXEha4BAs0NJja3ucuqRDNCVB7RupidT1JLAckgQNq25
        O0X4B9CF/2PpedWi105kkIjLNL0eBGPSwClH7ZJ1pbTCZuJ7NCwMoXTo+pvtj0DmXrPsLa
        cUa+2M5CKoXLh/h28todS9Z2fW6LD1nDAqC7Jy05uAQZF4wNdUszkNdbYowclg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597606707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zj2bPBJN64iZzxDKZPd2o/t71Sq/zP3xAM9fWh7m0IA=;
        b=IhE4sV9h6YThjyQ/cd5rnZ4JZ4CUBv+sd3x0CKRKtEZJQX/KiPU2yeDSIXeMwL7l+UABzb
        xH8hPbRTzkgM5UCg==
To:     Stephen Boyd <sboyd@kernel.org>, Felix.Kuehling@amd.com,
        Qianli Zhao <zhaoqianligood@gmail.com>,
        akpm@linux-foundation.org, axboe@kernel.dk
Cc:     john.stultz@linaro.org, ben.dooks@codethink.co.uk,
        bfields@redhat.com, cl@rock-chips.com,
        linux-kernel@vger.kernel.org, zhaoqianli@xiaomi.com
Subject: Re: [RFC V2] kthread: add object debug support
In-Reply-To: <159748064613.2270147.9288160745183605164@swboyd.mtv.corp.google.com>
References: <311159bc826dcca2848344fc277c0069cff0a164.1597207603.git.zhaoqianli@xiaomi.com> <159722125596.33733.17725649536425524344@swboyd.mtv.corp.google.com> <87pn7w5fd4.fsf@nanos.tec.linutronix.de> <159748064613.2270147.9288160745183605164@swboyd.mtv.corp.google.com>
Date:   Sun, 16 Aug 2020 21:38:26 +0200
Message-ID: <87d03qjs99.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 15 2020 at 01:37, Stephen Boyd wrote:
> Quoting Thomas Gleixner (2020-08-12 03:27:03)
>> or any other variant of insanity which makes the check claim that this
>> is statically initialized then you rightfully can keep the pieces :)
>
> Makes sense. Maybe this "technique" should be documented in
> Documentation/core-api/debug-objects.rst? I can cook up a patch to add
> is_static_object() to the Fixup functions section.

Sure. Better documentation is always a good thing.

Thanks,

        tglx
