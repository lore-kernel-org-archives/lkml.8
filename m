Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEED4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 06:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4FA820825
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 06:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595485852;
	bh=2TnEdOfsykAkYYerZFFR6l65rbC6c64eg7TSB+TwCZs=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=pzsIkC+CKbZTbEb9u0iDgdwaUjUMZ60nXvkNIJyzujf2yLPTBLp9TmMxDErLqAHQ1
	 qi6wY0byBpVIAalZpAgxTt3Ii0YJ7lNrc2wEQDnhhxi+FXz+1G/YU+EOxJf5Lx9vL/
	 0QSYR9X+oJE4xKBwAwcMiAI8PzzmfjY20rysLNvY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgGWGav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 02:30:51 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:35629 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgGWGav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 02:30:51 -0400
Received: by mail-ej1-f68.google.com with SMTP id rk21so5158755ejb.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 23:30:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eDgm/ih2DQ4QIrGZyxDtxU/oByDdRbhwgqp17CXgW48=;
        b=rqfZJ3cvBw5oeuLMqYjfh+IfvZ0kcfMy7VREXhSOEC8XsdrPR3/ISI7AJswhdlQla8
         cBDEhEbOmHLaLfG4SOXT7p5/ml1KsMtKHdYqX6UZPWeGNzJM+Qyk3pH7lOw27XwmBJ1b
         xd1EqrjuYmvRJfuEDdva3qpmD7rnjMiQhnX91vj7tdaXEZUSCcYya4S/FSUFTJdzVbKz
         5x08mWsLUHHXE+h/2mqD017byCRVY1kVRRz4/jl6nnjnc30huwZHBXWp5tYpAt7mWm4A
         nRPV64cuXS/30Hjf49TNO1aa3ozrlw3KhI0LFHQxdaNOmzR9pJk/pLjqeXqHw4pwKTKu
         +dyg==
X-Gm-Message-State: AOAM5306/YGweC4b1P3QY2xC3sZIQAvLcoz616iJ/rPZDGs+/aakbbTY
        Fb5tuZfYDjx7UeIxRbwDcCKvsJd2
X-Google-Smtp-Source: ABdhPJwdrpukpMP/ymEOKGYOygiIPw5HGaz5VqJFwVEbIDDTFngxJiHlYVBUQMhm9NE4aGxavbHA0Q==
X-Received: by 2002:a17:906:743:: with SMTP id z3mr2988409ejb.216.1595485849007;
        Wed, 22 Jul 2020 23:30:49 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id ay27sm1375262edb.81.2020.07.22.23.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 23:30:48 -0700 (PDT)
Subject: Re: [PATCH][next] tty: Avoid the use of one-element arrays
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20200716180858.GA30115@embeddedor>
 <f8aa0762-4af2-54a2-c9e8-8023a4b7aed5@kernel.org>
 <8dd6e3ae-7ab3-d829-0231-e436de3ad6a8@embeddedor.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <6228681b-f601-597a-64c2-87cd048d2599@kernel.org>
Date:   Thu, 23 Jul 2020 08:30:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8dd6e3ae-7ab3-d829-0231-e436de3ad6a8@embeddedor.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 07. 20, 20:24, Gustavo A. R. Silva wrote:
> 
> 
> On 7/17/20 01:10, Jiri Slaby wrote:
>> On 16. 07. 20, 20:08, Gustavo A. R. Silva wrote:
>>> One-element arrays are being deprecated[1]. Replace the one-element arrays
>>> with simple value types 'char reserved_char' and 'compat_int_t reserved'[2],
>>> once it seems these are just placeholders for alignment.
>>>
>>> Also, while there, use the preferred form for passing a size of a struct.
>>> The alternative form where struct name is spelled out hurts readability
>>> and introduces an opportunity for a bug when the variable type is changed
>>> but the corresponding sizeof that is passed as argument is not.
>>>
>>> Lastly, fix the checkpatch.pl warnings below:
>>>
>>> ERROR: code indent should use tabs where possible
>>> +        char    reserved_char;$
>>>
>>> WARNING: please, no spaces at the start of a line
>>> +        char    reserved_char;$
>>>
>>> ERROR: code indent should use tabs where possible
>>> +        compat_int_t    reserved;$
>>>
>>> WARNING: please, no spaces at the start of a line
>>> +        compat_int_t    reserved;$
>>
>> May I ask you to send a follow-up patch to fix the whole structure's
>> indentation?
>>
> 
> Hi Jiri,
> 
> Sure thing. I'll fix that up and send v2, shortly.

Hi,

by a follow-up patch I meant a separate patch. Looking at it once again,
I would do 3 patches:
1) remove [1] arrays
2) change sizeofs
3) fix white space

thanks,
-- 
js
suse labs
