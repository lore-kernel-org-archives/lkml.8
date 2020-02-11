Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87BEC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B387820873
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="HqWJVT2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgBKNBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:01:19 -0500
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:49582 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727041AbgBKNBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:01:18 -0500
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id B6C512E1590;
        Tue, 11 Feb 2020 16:01:15 +0300 (MSK)
Received: from vla1-5a8b76e65344.qloud-c.yandex.net (vla1-5a8b76e65344.qloud-c.yandex.net [2a02:6b8:c0d:3183:0:640:5a8b:76e6])
        by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id tTygow4JdF-1FSSM519;
        Tue, 11 Feb 2020 16:01:15 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1581426075; bh=D5lgADcjNeDpoHpl282aAWYt8Pd5KWAKw6hPxPX/Y+I=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=HqWJVT2+irkHY0JL0f2iDa/cx4+tLoX0FoWwtUjywSGdBD0BuLCYHlfS+v/c+ZIuG
         nPjjJNpkqXeudejJ9O7I6lUsQYvm8eV6u2Poy16EFm38C44wMwRgadKWNnydH/FQwP
         pcUYuhWf5EJrJw0m5tWiT+rE5M6dxcsuSL19J0Po=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:8448:fbcc:1dac:c863])
        by vla1-5a8b76e65344.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 3IWGqE8uP2-1EXqpkZf;
        Tue, 11 Feb 2020 16:01:14 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH] lib/test_lockup: test module to generate lockups
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
References: <158132859146.2797.525923171323227836.stgit@buzz>
 <20200210144101.e144335455399d6d84d92370@linux-foundation.org>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <c7e9d2ac-0f6d-31ed-ec00-cc315b1e34f8@yandex-team.ru>
Date:   Tue, 11 Feb 2020 16:01:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200210144101.e144335455399d6d84d92370@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/2020 01.41, Andrew Morton wrote:
> On Mon, 10 Feb 2020 12:56:31 +0300 Konstantin Khlebnikov <khlebnikov@yandex-team.ru> wrote:
> 
>> CONFIG_TEST_LOCKUP=m adds module "test_lockup" that helps to make sure
>> that watchdogs and lockup detectors are working properly.
> 
> Now we'll get test robot reports "hey this makes my kernel lock up" ;)

Without module parameters it is completely save and does nothing.

> 
> Is there any way in which we can close the loop here?  Add a
> tools/testing/selftests script which loads the module, attempts to
> trigger a lockup and then checks whether it happened as expected?
> Sounds tricky.
> 

Yes, I'll try to script this.
