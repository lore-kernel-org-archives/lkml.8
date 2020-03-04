Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0420CC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 21:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F6420866
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 21:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="otYQd4Bg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388230AbgCDVHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 16:07:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40886 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbgCDVHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 16:07:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=vEBQ9Oh5DEsZStk/47umQFJ1w5UJ/wMmh0eDlyTD1YI=; b=otYQd4BgDFNgb6t3Jl0d+9/2OS
        EnBbuAI69FvAsUY1jaqowJjwO1/ZeP3uYSXnV7sj5e5vhKtlRphfSd9eDhFcbnkbgGu8z52SMW87H
        JElVFROP6zTjfouT2MQQlCZJ0CFrZ4gTAfF69R9Cx3a/Dh9URkbpg4myzsb7nAg6JBWIppZpO6fHm
        Y9ixU92i2paS0QTGd1O0P3UYDcFj3mpZDk4gF94RdaJQqTObxHDad8p2X3RmKZ3lwT7QSf26g0/gR
        A3iMKNbTWQZWPBd8jjZbtzzfhEOtF8fpIAI9q6NOGNmwsLcdYo84B/8Xl58gXKTnjll7g20mKuBeD
        rnUm+Kcw==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9bEz-0003Ey-G6; Wed, 04 Mar 2020 21:07:41 +0000
Subject: Re: [v4] Documentation: bootconfig: Update boot configuration
 documentation
To:     Markus Elfring <Markus.Elfring@web.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-doc@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
References: <158322634266.31847.8245359938993378502.stgit@devnote2>
 <158322635301.31847.15011454479023637649.stgit@devnote2>
 <ad1e9855-4c64-53bd-7da5-f7cdafe78571@infradead.org>
 <20200304203722.8e8699c2a3e0a979aae091b1@kernel.org>
 <3a3a5f1a-3654-d96d-3b4a-dd649a366c65@web.de>
 <531371ef-354a-b0fa-f69f-c8cf9ecc9919@infradead.org>
 <a9f8980e-4325-52c1-d217-d2fca1add37d@web.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3118d72b-a33c-e6d7-36a1-204d39d2bdbb@infradead.org>
Date:   Wed, 4 Mar 2020 13:07:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <a9f8980e-4325-52c1-d217-d2fca1add37d@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/20 10:09 AM, Markus Elfring wrote:
>>>> What about the following?
>>>>
>>>> User can group identical parent keys together and use braces to list child keys
>>
>>    The user
> …
>>>> under them.
>>>
>>> Another wording alternative:
>>>
>>> The user can group settings together. Curly brackets enclose a configuration then
>>> according to a parent context.
>>
>> I slightly prefer Masami's text.
> 
> Would you like to improve the distinction for grouping the involved items?

I'm hoping to be done with the current changes. :)

-- 
~Randy

