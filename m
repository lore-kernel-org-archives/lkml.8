Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC7CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 04:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD10220756
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 04:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qYs1kqOy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgHKE47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 00:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgHKE46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 00:56:58 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CCAC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 21:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=ZjofLFFhvWgNTqXw/7Hk7zgdK7p+AaFWRQrmkPAcBe0=; b=qYs1kqOyq/LEl5UvPBwkSMa73O
        XtPnIntrS77KJR+X/f7+AMIqjtYab4UMn5yPU0AAeOQYEvqEuFVyE5CLb9+PYJF7uuXTKEMN9ecB0
        AUBYV5OZsWrT6AsMkfo6x3h2HClQDgnVGYETb89Ll+Jxdjl2hiPxN/6xsYoQjYQsP7TZiOZuU/J9q
        Ms/kAir65VwVEkfT/cW4U0Vuw54jafoUeen0hDxHjxsfOYKgHkaqRauCOPOgLiJFR0PvzeXB03F/6
        WilcHGTfFh0s0e9vxC16DzQc//iLknbic5P/cr0GVXOnbwRKg18gEvuKunvaPGjILgyiDtlITZROv
        L8LVRARw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5ML9-0005r5-CX; Tue, 11 Aug 2020 04:56:47 +0000
Subject: Re: [RFC PATCH] printk: Change timestamp to triplet as mono, boot and
 real
To:     Orson Zhai <orsonzhai@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        zhang.lyra@gmail.com, ruifeng.zhang1@unisoc.com,
        cixi.geng1@unisoc.com, Orson Zhai <orson.zhai@unisoc.com>
References: <1597120822-11999-1-git-send-email-orsonzhai@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4bbc99b0-3d20-eb22-1996-52474b463fe7@infradead.org>
Date:   Mon, 10 Aug 2020 21:56:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1597120822-11999-1-git-send-email-orsonzhai@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/20 9:40 PM, Orson Zhai wrote:
> +/*
> + * struct timestanps - Simultaneous mono/boot/real timestamps

typo:        timestamps

> + * @mono:	Monotonic timestamp
> + * @boot:	Boottime timestamp
> + * @real:	Realtime timestamp
> + */
> +struct timestamps {
> +	u64		mono;
> +	u64		boot;
> +	u64		real;
> +};


-- 
~Randy

